return {
	Play1108409001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 1108409001
		arg_1_1.duration_ = 5.83

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play1108409002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.A00 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "A00")
				var_4_0.name = "A00"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.A00 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.A00

				arg_1_1.bgs_.A00.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "A00" then
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

			if 1 < arg_1_1.time_ and arg_1_1.time_ <= 1 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_story_office_new", "bgm_story_office_new", "bgm_story_office_new.awb")

				local var_4_11 = manager.audio:GetAudioName("bgm_story_office_new", "bgm_story_office_new")

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

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "ui_battle", "ui_battle_stopbgm", "")
			end

			if 0.2 < arg_1_1.time_ and arg_1_1.time_ <= 0.2 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_142", "se_story_142_amb_commandroom", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_14 = 2
			local var_4_15 = 0.3

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_14 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_16 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_16:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_17 = arg_1_1:GetWordFromCfg(1108409001)
				local var_4_18 = arg_1_1:FormatText(var_4_17.content)

				arg_1_1.text_.text = var_4_18

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_20 = 12 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_18) / 12)

				if (12 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_18) / 12)) > 0 and var_4_15 < var_4_20 then
					arg_1_1.talkMaxDuration = var_4_20
					var_4_14 = var_4_14 + 0.3

					if var_4_20 + var_4_14 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_20 + var_4_14
					end
				end

				arg_1_1.text_.text = var_4_18
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409001", "story_v_side_new_1108409.awb") ~= 0 then
					local var_4_21 = manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409001", "story_v_side_new_1108409.awb") / 1000

					if var_4_21 + var_4_14 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_21 + var_4_14
					end

					if var_4_17.prefab_name ~= "" and arg_1_1.actors_[var_4_17.prefab_name] ~= nil then
						local var_4_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_17.prefab_name].transform, "story_v_side_new_1108409", "1108409001", "story_v_side_new_1108409.awb")

						arg_1_1:RecordAudio("1108409001", var_4_22)
						arg_1_1:RecordAudio("1108409001", var_4_22)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_side_new_1108409", "1108409001", "story_v_side_new_1108409.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_side_new_1108409", "1108409001", "story_v_side_new_1108409.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_23 = var_4_14 + 0.3
			local var_4_24 = math.max(var_4_15, arg_1_1.talkMaxDuration)

			if var_4_14 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_23 + var_4_24 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_23) / var_4_24

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_23 + var_4_24 and arg_1_1.time_ < var_4_23 + var_4_24 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play1108409002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 1108409002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play1108409003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0.875

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, false)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_1 = arg_8_1:FormatText(arg_8_1:GetWordFromCfg(1108409002).content)

				arg_8_1.text_.text = var_11_1

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_3 = 35 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_1) / 35)

				if (35 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_1) / 35)) > 0 and var_11_0 < var_11_3 then
					arg_8_1.talkMaxDuration = var_11_3

					if var_11_3 + 0 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_3 + 0
					end
				end

				arg_8_1.text_.text = var_11_1
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)
				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_4 = math.max(var_11_0, arg_8_1.talkMaxDuration)

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_4 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - 0) / var_11_4

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= 0 + var_11_4 and arg_8_1.time_ < 0 + var_11_4 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play1108409003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 1108409003
		arg_12_1.duration_ = 1.7

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play1108409004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			if arg_12_1.actors_["1047ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1047ui_story"))) then
				local var_15_0 = Object.Instantiate(Asset.Load("Char/" .. "1047ui_story"), arg_12_1.stage_.transform)

				var_15_0.name = "1047ui_story"
				var_15_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_12_1.actors_["1047ui_story"] = var_15_0

				local var_15_1 = var_15_0:GetComponentInChildren(typeof(CharacterEffect))

				var_15_1.enabled = true

				local var_15_2 = GameObjectTools.GetOrAddComponent(var_15_0, typeof(DynamicBoneHelper))

				if var_15_2 then
					var_15_2:EnableDynamicBone(false)
				end

				arg_12_1:ShowWeapon(var_15_1.transform, false)

				arg_12_1.var_["1047ui_story" .. "Animator"] = var_15_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_12_1.var_["1047ui_story" .. "Animator"].applyRootMotion = true
				arg_12_1.var_["1047ui_story" .. "LipSync"] = var_15_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_15_3 = arg_12_1.actors_["1047ui_story"].transform

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1.var_.moveOldPos1047ui_story = var_15_3.localPosition
			end

			local var_15_4 = 0.001

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_4 then
				var_15_3.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_12_1.time_ - 0) / var_15_4)
				var_15_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_15_3.position).x, (manager.ui.mainCamera.transform.position - var_15_3.position).y, (manager.ui.mainCamera.transform.position - var_15_3.position).z)
				var_15_3.localEulerAngles.z = 0
				var_15_3.localEulerAngles.x = 0
				var_15_3.localEulerAngles = var_15_3.localEulerAngles
			end

			if arg_12_1.time_ >= 0 + var_15_4 and arg_12_1.time_ < 0 + var_15_4 + arg_15_0 then
				var_15_3.localPosition = Vector3.New(0, -1.13, -6.2)
				var_15_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_15_3.position).x, (manager.ui.mainCamera.transform.position - var_15_3.position).y, (manager.ui.mainCamera.transform.position - var_15_3.position).z)
				var_15_3.localEulerAngles.z = 0
				var_15_3.localEulerAngles.x = 0
				var_15_3.localEulerAngles = var_15_3.localEulerAngles
			end

			local var_15_5 = arg_12_1.actors_["1047ui_story"]

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 and not isNil(var_15_5) and arg_12_1.var_.characterEffect1047ui_story == nil then
				arg_12_1.var_.characterEffect1047ui_story = var_15_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_6 = 0.200000002980232

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_6 and not isNil(var_15_5) then
				if arg_12_1.var_.characterEffect1047ui_story and not isNil(var_15_5) then
					arg_12_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_12_1.time_ >= 0 + var_15_6 and arg_12_1.time_ < 0 + var_15_6 + arg_15_0 and not isNil(var_15_5) and arg_12_1.var_.characterEffect1047ui_story then
				arg_12_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_15_8 = 0
			local var_15_9 = 0.175

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_8 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				arg_12_1.leftNameTxt_.text = arg_12_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_10 = arg_12_1:GetWordFromCfg(1108409003)
				local var_15_11 = arg_12_1:FormatText(var_15_10.content)

				arg_12_1.text_.text = var_15_11

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_13 = 7 <= 0 and var_15_9 or var_15_9 * (utf8.len(var_15_11) / 7)

				if (7 <= 0 and var_15_9 or var_15_9 * (utf8.len(var_15_11) / 7)) > 0 and var_15_9 < var_15_13 then
					arg_12_1.talkMaxDuration = var_15_13

					if var_15_13 + var_15_8 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_13 + var_15_8
					end
				end

				arg_12_1.text_.text = var_15_11
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409003", "story_v_side_new_1108409.awb") ~= 0 then
					local var_15_14 = manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409003", "story_v_side_new_1108409.awb") / 1000

					if var_15_14 + var_15_8 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_14 + var_15_8
					end

					if var_15_10.prefab_name ~= "" and arg_12_1.actors_[var_15_10.prefab_name] ~= nil then
						local var_15_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_10.prefab_name].transform, "story_v_side_new_1108409", "1108409003", "story_v_side_new_1108409.awb")

						arg_12_1:RecordAudio("1108409003", var_15_15)
						arg_12_1:RecordAudio("1108409003", var_15_15)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_side_new_1108409", "1108409003", "story_v_side_new_1108409.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_side_new_1108409", "1108409003", "story_v_side_new_1108409.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_16 = math.max(var_15_9, arg_12_1.talkMaxDuration)

			if var_15_8 <= arg_12_1.time_ and arg_12_1.time_ < var_15_8 + var_15_16 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_8) / var_15_16

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_8 + var_15_16 and arg_12_1.time_ < var_15_8 + var_15_16 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_12_1:InitPlayNodeList()
	end,
	Play1108409004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 1108409004
		arg_16_1.duration_ = 5

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play1108409005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 and not isNil(arg_16_1.actors_["1047ui_story"]) and arg_16_1.var_.characterEffect1047ui_story == nil then
				arg_16_1.var_.characterEffect1047ui_story = arg_16_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_0 = 0.200000002980232

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_0 and not isNil(arg_16_1.actors_["1047ui_story"]) then
				if arg_16_1.var_.characterEffect1047ui_story and not isNil(arg_16_1.actors_["1047ui_story"]) then
					arg_16_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_16_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_16_1.time_ - 0) / var_19_0)
				end
			end

			if arg_16_1.time_ >= 0 + var_19_0 and arg_16_1.time_ < 0 + var_19_0 + arg_19_0 and not isNil(arg_16_1.actors_["1047ui_story"]) and arg_16_1.var_.characterEffect1047ui_story then
				arg_16_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_16_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_19_1 = 0
			local var_19_2 = 0.525

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_1 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				arg_16_1.leftNameTxt_.text = arg_16_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, true)
				arg_16_1.iconController_:SetSelectedState("hero")

				arg_16_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_16_1.callingController_:SetSelectedState("normal")

				arg_16_1.keyicon_.color = Color.New(1, 1, 1)
				arg_16_1.icon_.color = Color.New(1, 1, 1)

				local var_19_3 = arg_16_1:FormatText(arg_16_1:GetWordFromCfg(1108409004).content)

				arg_16_1.text_.text = var_19_3

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_5 = 21 <= 0 and var_19_2 or var_19_2 * (utf8.len(var_19_3) / 21)

				if (21 <= 0 and var_19_2 or var_19_2 * (utf8.len(var_19_3) / 21)) > 0 and var_19_2 < var_19_5 then
					arg_16_1.talkMaxDuration = var_19_5

					if var_19_5 + var_19_1 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_5 + var_19_1
					end
				end

				arg_16_1.text_.text = var_19_3
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)
				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_6 = math.max(var_19_2, arg_16_1.talkMaxDuration)

			if var_19_1 <= arg_16_1.time_ and arg_16_1.time_ < var_19_1 + var_19_6 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_1) / var_19_6

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_1 + var_19_6 and arg_16_1.time_ < var_19_1 + var_19_6 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play1108409005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 1108409005
		arg_20_1.duration_ = 3.67

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play1108409006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			if arg_20_1.actors_["1084ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1084ui_story"))) then
				local var_23_0 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_20_1.stage_.transform)

				var_23_0.name = "1084ui_story"
				var_23_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_20_1.actors_["1084ui_story"] = var_23_0

				local var_23_1 = var_23_0:GetComponentInChildren(typeof(CharacterEffect))

				var_23_1.enabled = true

				local var_23_2 = GameObjectTools.GetOrAddComponent(var_23_0, typeof(DynamicBoneHelper))

				if var_23_2 then
					var_23_2:EnableDynamicBone(false)
				end

				arg_20_1:ShowWeapon(var_23_1.transform, false)

				arg_20_1.var_["1084ui_story" .. "Animator"] = var_23_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_20_1.var_["1084ui_story" .. "Animator"].applyRootMotion = true
				arg_20_1.var_["1084ui_story" .. "LipSync"] = var_23_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_23_3 = arg_20_1.actors_["1084ui_story"].transform

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1.var_.moveOldPos1084ui_story = var_23_3.localPosition
			end

			local var_23_4 = 0.001

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_4 then
				var_23_3.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos1084ui_story, Vector3.New(0.7, -0.97, -6), (arg_20_1.time_ - 0) / var_23_4)
				var_23_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_23_3.position).x, (manager.ui.mainCamera.transform.position - var_23_3.position).y, (manager.ui.mainCamera.transform.position - var_23_3.position).z)
				var_23_3.localEulerAngles.z = 0
				var_23_3.localEulerAngles.x = 0
				var_23_3.localEulerAngles = var_23_3.localEulerAngles
			end

			if arg_20_1.time_ >= 0 + var_23_4 and arg_20_1.time_ < 0 + var_23_4 + arg_23_0 then
				var_23_3.localPosition = Vector3.New(0.7, -0.97, -6)
				var_23_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_23_3.position).x, (manager.ui.mainCamera.transform.position - var_23_3.position).y, (manager.ui.mainCamera.transform.position - var_23_3.position).z)
				var_23_3.localEulerAngles.z = 0
				var_23_3.localEulerAngles.x = 0
				var_23_3.localEulerAngles = var_23_3.localEulerAngles
			end

			local var_23_5 = arg_20_1.actors_["1047ui_story"].transform

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1.var_.moveOldPos1047ui_story = var_23_5.localPosition
			end

			local var_23_6 = 0.001

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_6 then
				var_23_5.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos1047ui_story, Vector3.New(-0.6, -1.13, -6.2), (arg_20_1.time_ - 0) / var_23_6)
				var_23_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_23_5.position).x, (manager.ui.mainCamera.transform.position - var_23_5.position).y, (manager.ui.mainCamera.transform.position - var_23_5.position).z)
				var_23_5.localEulerAngles.z = 0
				var_23_5.localEulerAngles.x = 0
				var_23_5.localEulerAngles = var_23_5.localEulerAngles
			end

			if arg_20_1.time_ >= 0 + var_23_6 and arg_20_1.time_ < 0 + var_23_6 + arg_23_0 then
				var_23_5.localPosition = Vector3.New(-0.6, -1.13, -6.2)
				var_23_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_23_5.position).x, (manager.ui.mainCamera.transform.position - var_23_5.position).y, (manager.ui.mainCamera.transform.position - var_23_5.position).z)
				var_23_5.localEulerAngles.z = 0
				var_23_5.localEulerAngles.x = 0
				var_23_5.localEulerAngles = var_23_5.localEulerAngles
			end

			local var_23_7 = arg_20_1.actors_["1084ui_story"]

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 and not isNil(var_23_7) and arg_20_1.var_.characterEffect1084ui_story == nil then
				arg_20_1.var_.characterEffect1084ui_story = var_23_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_8 = 0.200000002980232

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_8 and not isNil(var_23_7) then
				if arg_20_1.var_.characterEffect1084ui_story and not isNil(var_23_7) then
					arg_20_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_20_1.time_ >= 0 + var_23_8 and arg_20_1.time_ < 0 + var_23_8 + arg_23_0 and not isNil(var_23_7) and arg_20_1.var_.characterEffect1084ui_story then
				arg_20_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action4_1")
			end

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_23_10 = 0
			local var_23_11 = 0.4

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_10 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				arg_20_1.leftNameTxt_.text = arg_20_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_12 = arg_20_1:GetWordFromCfg(1108409005)
				local var_23_13 = arg_20_1:FormatText(var_23_12.content)

				arg_20_1.text_.text = var_23_13

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_15 = 16 <= 0 and var_23_11 or var_23_11 * (utf8.len(var_23_13) / 16)

				if (16 <= 0 and var_23_11 or var_23_11 * (utf8.len(var_23_13) / 16)) > 0 and var_23_11 < var_23_15 then
					arg_20_1.talkMaxDuration = var_23_15

					if var_23_15 + var_23_10 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_15 + var_23_10
					end
				end

				arg_20_1.text_.text = var_23_13
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409005", "story_v_side_new_1108409.awb") ~= 0 then
					local var_23_16 = manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409005", "story_v_side_new_1108409.awb") / 1000

					if var_23_16 + var_23_10 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_16 + var_23_10
					end

					if var_23_12.prefab_name ~= "" and arg_20_1.actors_[var_23_12.prefab_name] ~= nil then
						local var_23_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_12.prefab_name].transform, "story_v_side_new_1108409", "1108409005", "story_v_side_new_1108409.awb")

						arg_20_1:RecordAudio("1108409005", var_23_17)
						arg_20_1:RecordAudio("1108409005", var_23_17)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_side_new_1108409", "1108409005", "story_v_side_new_1108409.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_side_new_1108409", "1108409005", "story_v_side_new_1108409.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_18 = math.max(var_23_11, arg_20_1.talkMaxDuration)

			if var_23_10 <= arg_20_1.time_ and arg_20_1.time_ < var_23_10 + var_23_18 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_10) / var_23_18

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_10 + var_23_18 and arg_20_1.time_ < var_23_10 + var_23_18 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1047ui_story",
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
	Play1108409006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 1108409006
		arg_24_1.duration_ = 7.6

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play1108409007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 and not isNil(arg_24_1.actors_["1047ui_story"]) and arg_24_1.var_.characterEffect1047ui_story == nil then
				arg_24_1.var_.characterEffect1047ui_story = arg_24_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_0 = 0.200000002980232

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_0 and not isNil(arg_24_1.actors_["1047ui_story"]) then
				if arg_24_1.var_.characterEffect1047ui_story and not isNil(arg_24_1.actors_["1047ui_story"]) then
					arg_24_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_24_1.time_ >= 0 + var_27_0 and arg_24_1.time_ < 0 + var_27_0 + arg_27_0 and not isNil(arg_24_1.actors_["1047ui_story"]) and arg_24_1.var_.characterEffect1047ui_story then
				arg_24_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_27_2 = arg_24_1.actors_["1084ui_story"]

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 and not isNil(var_27_2) and arg_24_1.var_.characterEffect1084ui_story == nil then
				arg_24_1.var_.characterEffect1084ui_story = var_27_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_3 = 0.200000002980232

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_3 and not isNil(var_27_2) then
				if arg_24_1.var_.characterEffect1084ui_story and not isNil(var_27_2) then
					arg_24_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_24_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_24_1.time_ - 0) / var_27_3)
				end
			end

			if arg_24_1.time_ >= 0 + var_27_3 and arg_24_1.time_ < 0 + var_27_3 + arg_27_0 and not isNil(var_27_2) and arg_24_1.var_.characterEffect1084ui_story then
				arg_24_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_24_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action4_1")
			end

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_27_4 = 0
			local var_27_5 = 0.825

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_4 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				arg_24_1.leftNameTxt_.text = arg_24_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_6 = arg_24_1:GetWordFromCfg(1108409006)
				local var_27_7 = arg_24_1:FormatText(var_27_6.content)

				arg_24_1.text_.text = var_27_7

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_9 = 33 <= 0 and var_27_5 or var_27_5 * (utf8.len(var_27_7) / 33)

				if (33 <= 0 and var_27_5 or var_27_5 * (utf8.len(var_27_7) / 33)) > 0 and var_27_5 < var_27_9 then
					arg_24_1.talkMaxDuration = var_27_9

					if var_27_9 + var_27_4 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_9 + var_27_4
					end
				end

				arg_24_1.text_.text = var_27_7
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409006", "story_v_side_new_1108409.awb") ~= 0 then
					local var_27_10 = manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409006", "story_v_side_new_1108409.awb") / 1000

					if var_27_10 + var_27_4 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_10 + var_27_4
					end

					if var_27_6.prefab_name ~= "" and arg_24_1.actors_[var_27_6.prefab_name] ~= nil then
						local var_27_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_6.prefab_name].transform, "story_v_side_new_1108409", "1108409006", "story_v_side_new_1108409.awb")

						arg_24_1:RecordAudio("1108409006", var_27_11)
						arg_24_1:RecordAudio("1108409006", var_27_11)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_side_new_1108409", "1108409006", "story_v_side_new_1108409.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_side_new_1108409", "1108409006", "story_v_side_new_1108409.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_12 = math.max(var_27_5, arg_24_1.talkMaxDuration)

			if var_27_4 <= arg_24_1.time_ and arg_24_1.time_ < var_27_4 + var_27_12 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_4) / var_27_12

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_4 + var_27_12 and arg_24_1.time_ < var_27_4 + var_27_12 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play1108409007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 1108409007
		arg_28_1.duration_ = 5

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play1108409008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 and not isNil(arg_28_1.actors_["1047ui_story"]) and arg_28_1.var_.characterEffect1047ui_story == nil then
				arg_28_1.var_.characterEffect1047ui_story = arg_28_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_0 = 0.200000002980232

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_0 and not isNil(arg_28_1.actors_["1047ui_story"]) then
				if arg_28_1.var_.characterEffect1047ui_story and not isNil(arg_28_1.actors_["1047ui_story"]) then
					arg_28_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_28_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_28_1.time_ - 0) / var_31_0)
				end
			end

			if arg_28_1.time_ >= 0 + var_31_0 and arg_28_1.time_ < 0 + var_31_0 + arg_31_0 and not isNil(arg_28_1.actors_["1047ui_story"]) and arg_28_1.var_.characterEffect1047ui_story then
				arg_28_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_28_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_31_1 = 0
			local var_31_2 = 0.2

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_1 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				arg_28_1.leftNameTxt_.text = arg_28_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, true)
				arg_28_1.iconController_:SetSelectedState("hero")

				arg_28_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_28_1.callingController_:SetSelectedState("normal")

				arg_28_1.keyicon_.color = Color.New(1, 1, 1)
				arg_28_1.icon_.color = Color.New(1, 1, 1)

				local var_31_3 = arg_28_1:FormatText(arg_28_1:GetWordFromCfg(1108409007).content)

				arg_28_1.text_.text = var_31_3

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_5 = 8 <= 0 and var_31_2 or var_31_2 * (utf8.len(var_31_3) / 8)

				if (8 <= 0 and var_31_2 or var_31_2 * (utf8.len(var_31_3) / 8)) > 0 and var_31_2 < var_31_5 then
					arg_28_1.talkMaxDuration = var_31_5

					if var_31_5 + var_31_1 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_5 + var_31_1
					end
				end

				arg_28_1.text_.text = var_31_3
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)
				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_6 = math.max(var_31_2, arg_28_1.talkMaxDuration)

			if var_31_1 <= arg_28_1.time_ and arg_28_1.time_ < var_31_1 + var_31_6 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_1) / var_31_6

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_1 + var_31_6 and arg_28_1.time_ < var_31_1 + var_31_6 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play1108409008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 1108409008
		arg_32_1.duration_ = 5.83

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play1108409009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 and not isNil(arg_32_1.actors_["1084ui_story"]) and arg_32_1.var_.characterEffect1084ui_story == nil then
				arg_32_1.var_.characterEffect1084ui_story = arg_32_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_0 = 0.200000002980232

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_0 and not isNil(arg_32_1.actors_["1084ui_story"]) then
				if arg_32_1.var_.characterEffect1084ui_story and not isNil(arg_32_1.actors_["1084ui_story"]) then
					arg_32_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_32_1.time_ >= 0 + var_35_0 and arg_32_1.time_ < 0 + var_35_0 + arg_35_0 and not isNil(arg_32_1.actors_["1084ui_story"]) and arg_32_1.var_.characterEffect1084ui_story then
				arg_32_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action4_2")
			end

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_35_2 = 0
			local var_35_3 = 0.775

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_2 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				arg_32_1.leftNameTxt_.text = arg_32_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_4 = arg_32_1:GetWordFromCfg(1108409008)
				local var_35_5 = arg_32_1:FormatText(var_35_4.content)

				arg_32_1.text_.text = var_35_5

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_7 = 31 <= 0 and var_35_3 or var_35_3 * (utf8.len(var_35_5) / 31)

				if (31 <= 0 and var_35_3 or var_35_3 * (utf8.len(var_35_5) / 31)) > 0 and var_35_3 < var_35_7 then
					arg_32_1.talkMaxDuration = var_35_7

					if var_35_7 + var_35_2 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_7 + var_35_2
					end
				end

				arg_32_1.text_.text = var_35_5
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409008", "story_v_side_new_1108409.awb") ~= 0 then
					local var_35_8 = manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409008", "story_v_side_new_1108409.awb") / 1000

					if var_35_8 + var_35_2 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_8 + var_35_2
					end

					if var_35_4.prefab_name ~= "" and arg_32_1.actors_[var_35_4.prefab_name] ~= nil then
						local var_35_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_4.prefab_name].transform, "story_v_side_new_1108409", "1108409008", "story_v_side_new_1108409.awb")

						arg_32_1:RecordAudio("1108409008", var_35_9)
						arg_32_1:RecordAudio("1108409008", var_35_9)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_side_new_1108409", "1108409008", "story_v_side_new_1108409.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_side_new_1108409", "1108409008", "story_v_side_new_1108409.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_10 = math.max(var_35_3, arg_32_1.talkMaxDuration)

			if var_35_2 <= arg_32_1.time_ and arg_32_1.time_ < var_35_2 + var_35_10 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_2) / var_35_10

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_2 + var_35_10 and arg_32_1.time_ < var_35_2 + var_35_10 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play1108409009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 1108409009
		arg_36_1.duration_ = 6.87

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play1108409010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 and not isNil(arg_36_1.actors_["1047ui_story"]) and arg_36_1.var_.characterEffect1047ui_story == nil then
				arg_36_1.var_.characterEffect1047ui_story = arg_36_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_0 = 0.200000002980232

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_0 and not isNil(arg_36_1.actors_["1047ui_story"]) then
				if arg_36_1.var_.characterEffect1047ui_story and not isNil(arg_36_1.actors_["1047ui_story"]) then
					arg_36_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_36_1.time_ >= 0 + var_39_0 and arg_36_1.time_ < 0 + var_39_0 + arg_39_0 and not isNil(arg_36_1.actors_["1047ui_story"]) and arg_36_1.var_.characterEffect1047ui_story then
				arg_36_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_39_2 = arg_36_1.actors_["1084ui_story"]

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 and not isNil(var_39_2) and arg_36_1.var_.characterEffect1084ui_story == nil then
				arg_36_1.var_.characterEffect1084ui_story = var_39_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_3 = 0.200000002980232

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_3 and not isNil(var_39_2) then
				if arg_36_1.var_.characterEffect1084ui_story and not isNil(var_39_2) then
					arg_36_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_36_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_36_1.time_ - 0) / var_39_3)
				end
			end

			if arg_36_1.time_ >= 0 + var_39_3 and arg_36_1.time_ < 0 + var_39_3 + arg_39_0 and not isNil(var_39_2) and arg_36_1.var_.characterEffect1084ui_story then
				arg_36_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_36_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047actionlink/1047action443")
			end

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_39_4 = 0
			local var_39_5 = 0.775

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_4 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				arg_36_1.leftNameTxt_.text = arg_36_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_6 = arg_36_1:GetWordFromCfg(1108409009)
				local var_39_7 = arg_36_1:FormatText(var_39_6.content)

				arg_36_1.text_.text = var_39_7

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_9 = 31 <= 0 and var_39_5 or var_39_5 * (utf8.len(var_39_7) / 31)

				if (31 <= 0 and var_39_5 or var_39_5 * (utf8.len(var_39_7) / 31)) > 0 and var_39_5 < var_39_9 then
					arg_36_1.talkMaxDuration = var_39_9

					if var_39_9 + var_39_4 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_9 + var_39_4
					end
				end

				arg_36_1.text_.text = var_39_7
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409009", "story_v_side_new_1108409.awb") ~= 0 then
					local var_39_10 = manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409009", "story_v_side_new_1108409.awb") / 1000

					if var_39_10 + var_39_4 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_10 + var_39_4
					end

					if var_39_6.prefab_name ~= "" and arg_36_1.actors_[var_39_6.prefab_name] ~= nil then
						local var_39_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_6.prefab_name].transform, "story_v_side_new_1108409", "1108409009", "story_v_side_new_1108409.awb")

						arg_36_1:RecordAudio("1108409009", var_39_11)
						arg_36_1:RecordAudio("1108409009", var_39_11)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_side_new_1108409", "1108409009", "story_v_side_new_1108409.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_side_new_1108409", "1108409009", "story_v_side_new_1108409.awb")
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
	Play1108409010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 1108409010
		arg_40_1.duration_ = 5

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play1108409011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 and not isNil(arg_40_1.actors_["1047ui_story"]) and arg_40_1.var_.characterEffect1047ui_story == nil then
				arg_40_1.var_.characterEffect1047ui_story = arg_40_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_0 = 0.200000002980232

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_0 and not isNil(arg_40_1.actors_["1047ui_story"]) then
				if arg_40_1.var_.characterEffect1047ui_story and not isNil(arg_40_1.actors_["1047ui_story"]) then
					arg_40_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_40_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_40_1.time_ - 0) / var_43_0)
				end
			end

			if arg_40_1.time_ >= 0 + var_43_0 and arg_40_1.time_ < 0 + var_43_0 + arg_43_0 and not isNil(arg_40_1.actors_["1047ui_story"]) and arg_40_1.var_.characterEffect1047ui_story then
				arg_40_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_40_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_43_1 = 0
			local var_43_2 = 1.075

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_1 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				arg_40_1.leftNameTxt_.text = arg_40_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, true)
				arg_40_1.iconController_:SetSelectedState("hero")

				arg_40_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_40_1.callingController_:SetSelectedState("normal")

				arg_40_1.keyicon_.color = Color.New(1, 1, 1)
				arg_40_1.icon_.color = Color.New(1, 1, 1)

				local var_43_3 = arg_40_1:FormatText(arg_40_1:GetWordFromCfg(1108409010).content)

				arg_40_1.text_.text = var_43_3

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_5 = 43 <= 0 and var_43_2 or var_43_2 * (utf8.len(var_43_3) / 43)

				if (43 <= 0 and var_43_2 or var_43_2 * (utf8.len(var_43_3) / 43)) > 0 and var_43_2 < var_43_5 then
					arg_40_1.talkMaxDuration = var_43_5

					if var_43_5 + var_43_1 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_5 + var_43_1
					end
				end

				arg_40_1.text_.text = var_43_3
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)
				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_6 = math.max(var_43_2, arg_40_1.talkMaxDuration)

			if var_43_1 <= arg_40_1.time_ and arg_40_1.time_ < var_43_1 + var_43_6 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_1) / var_43_6

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_1 + var_43_6 and arg_40_1.time_ < var_43_1 + var_43_6 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play1108409011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 1108409011
		arg_44_1.duration_ = 6.43

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play1108409012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 and not isNil(arg_44_1.actors_["1047ui_story"]) and arg_44_1.var_.characterEffect1047ui_story == nil then
				arg_44_1.var_.characterEffect1047ui_story = arg_44_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_0 = 0.200000002980232

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_0 and not isNil(arg_44_1.actors_["1047ui_story"]) then
				if arg_44_1.var_.characterEffect1047ui_story and not isNil(arg_44_1.actors_["1047ui_story"]) then
					arg_44_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_44_1.time_ >= 0 + var_47_0 and arg_44_1.time_ < 0 + var_47_0 + arg_47_0 and not isNil(arg_44_1.actors_["1047ui_story"]) and arg_44_1.var_.characterEffect1047ui_story then
				arg_44_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action3_2")
			end

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_47_2 = 0
			local var_47_3 = 0.85

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_2 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				arg_44_1.leftNameTxt_.text = arg_44_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_4 = arg_44_1:GetWordFromCfg(1108409011)
				local var_47_5 = arg_44_1:FormatText(var_47_4.content)

				arg_44_1.text_.text = var_47_5

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_7 = 34 <= 0 and var_47_3 or var_47_3 * (utf8.len(var_47_5) / 34)

				if (34 <= 0 and var_47_3 or var_47_3 * (utf8.len(var_47_5) / 34)) > 0 and var_47_3 < var_47_7 then
					arg_44_1.talkMaxDuration = var_47_7

					if var_47_7 + var_47_2 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_7 + var_47_2
					end
				end

				arg_44_1.text_.text = var_47_5
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409011", "story_v_side_new_1108409.awb") ~= 0 then
					local var_47_8 = manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409011", "story_v_side_new_1108409.awb") / 1000

					if var_47_8 + var_47_2 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_8 + var_47_2
					end

					if var_47_4.prefab_name ~= "" and arg_44_1.actors_[var_47_4.prefab_name] ~= nil then
						local var_47_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_4.prefab_name].transform, "story_v_side_new_1108409", "1108409011", "story_v_side_new_1108409.awb")

						arg_44_1:RecordAudio("1108409011", var_47_9)
						arg_44_1:RecordAudio("1108409011", var_47_9)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_side_new_1108409", "1108409011", "story_v_side_new_1108409.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_side_new_1108409", "1108409011", "story_v_side_new_1108409.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_10 = math.max(var_47_3, arg_44_1.talkMaxDuration)

			if var_47_2 <= arg_44_1.time_ and arg_44_1.time_ < var_47_2 + var_47_10 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_2) / var_47_10

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_2 + var_47_10 and arg_44_1.time_ < var_47_2 + var_47_10 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play1108409012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 1108409012
		arg_48_1.duration_ = 10.83

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play1108409013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_51_0 = 0
			local var_51_1 = 1.175

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_0 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				arg_48_1.leftNameTxt_.text = arg_48_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_2 = arg_48_1:GetWordFromCfg(1108409012)
				local var_51_3 = arg_48_1:FormatText(var_51_2.content)

				arg_48_1.text_.text = var_51_3

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_5 = 47 <= 0 and var_51_1 or var_51_1 * (utf8.len(var_51_3) / 47)

				if (47 <= 0 and var_51_1 or var_51_1 * (utf8.len(var_51_3) / 47)) > 0 and var_51_1 < var_51_5 then
					arg_48_1.talkMaxDuration = var_51_5

					if var_51_5 + var_51_0 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_5 + var_51_0
					end
				end

				arg_48_1.text_.text = var_51_3
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409012", "story_v_side_new_1108409.awb") ~= 0 then
					local var_51_6 = manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409012", "story_v_side_new_1108409.awb") / 1000

					if var_51_6 + var_51_0 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_6 + var_51_0
					end

					if var_51_2.prefab_name ~= "" and arg_48_1.actors_[var_51_2.prefab_name] ~= nil then
						local var_51_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_2.prefab_name].transform, "story_v_side_new_1108409", "1108409012", "story_v_side_new_1108409.awb")

						arg_48_1:RecordAudio("1108409012", var_51_7)
						arg_48_1:RecordAudio("1108409012", var_51_7)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_side_new_1108409", "1108409012", "story_v_side_new_1108409.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_side_new_1108409", "1108409012", "story_v_side_new_1108409.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_8 = math.max(var_51_1, arg_48_1.talkMaxDuration)

			if var_51_0 <= arg_48_1.time_ and arg_48_1.time_ < var_51_0 + var_51_8 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_0) / var_51_8

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_0 + var_51_8 and arg_48_1.time_ < var_51_0 + var_51_8 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play1108409013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 1108409013
		arg_52_1.duration_ = 5

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play1108409014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 and not isNil(arg_52_1.actors_["1047ui_story"]) and arg_52_1.var_.characterEffect1047ui_story == nil then
				arg_52_1.var_.characterEffect1047ui_story = arg_52_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_0 = 0.200000002980232

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_0 and not isNil(arg_52_1.actors_["1047ui_story"]) then
				if arg_52_1.var_.characterEffect1047ui_story and not isNil(arg_52_1.actors_["1047ui_story"]) then
					arg_52_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_52_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_52_1.time_ - 0) / var_55_0)
				end
			end

			if arg_52_1.time_ >= 0 + var_55_0 and arg_52_1.time_ < 0 + var_55_0 + arg_55_0 and not isNil(arg_52_1.actors_["1047ui_story"]) and arg_52_1.var_.characterEffect1047ui_story then
				arg_52_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_52_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_55_1 = 0
			local var_55_2 = 0.5

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_1 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				arg_52_1.leftNameTxt_.text = arg_52_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, true)
				arg_52_1.iconController_:SetSelectedState("hero")

				arg_52_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_52_1.callingController_:SetSelectedState("normal")

				arg_52_1.keyicon_.color = Color.New(1, 1, 1)
				arg_52_1.icon_.color = Color.New(1, 1, 1)

				local var_55_3 = arg_52_1:FormatText(arg_52_1:GetWordFromCfg(1108409013).content)

				arg_52_1.text_.text = var_55_3

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_5 = 20 <= 0 and var_55_2 or var_55_2 * (utf8.len(var_55_3) / 20)

				if (20 <= 0 and var_55_2 or var_55_2 * (utf8.len(var_55_3) / 20)) > 0 and var_55_2 < var_55_5 then
					arg_52_1.talkMaxDuration = var_55_5

					if var_55_5 + var_55_1 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_5 + var_55_1
					end
				end

				arg_52_1.text_.text = var_55_3
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)
				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_6 = math.max(var_55_2, arg_52_1.talkMaxDuration)

			if var_55_1 <= arg_52_1.time_ and arg_52_1.time_ < var_55_1 + var_55_6 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_1) / var_55_6

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_1 + var_55_6 and arg_52_1.time_ < var_55_1 + var_55_6 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play1108409014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 1108409014
		arg_56_1.duration_ = 2.67

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play1108409015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 and not isNil(arg_56_1.actors_["1047ui_story"]) and arg_56_1.var_.characterEffect1047ui_story == nil then
				arg_56_1.var_.characterEffect1047ui_story = arg_56_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_0 = 0.200000002980232

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_0 and not isNil(arg_56_1.actors_["1047ui_story"]) then
				if arg_56_1.var_.characterEffect1047ui_story and not isNil(arg_56_1.actors_["1047ui_story"]) then
					arg_56_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_56_1.time_ >= 0 + var_59_0 and arg_56_1.time_ < 0 + var_59_0 + arg_59_0 and not isNil(arg_56_1.actors_["1047ui_story"]) and arg_56_1.var_.characterEffect1047ui_story then
				arg_56_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action6_1")
			end

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_59_2 = 0
			local var_59_3 = 0.5

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_2 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				arg_56_1.leftNameTxt_.text = arg_56_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_4 = arg_56_1:GetWordFromCfg(1108409014)
				local var_59_5 = arg_56_1:FormatText(var_59_4.content)

				arg_56_1.text_.text = var_59_5

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_7 = 20 <= 0 and var_59_3 or var_59_3 * (utf8.len(var_59_5) / 20)

				if (20 <= 0 and var_59_3 or var_59_3 * (utf8.len(var_59_5) / 20)) > 0 and var_59_3 < var_59_7 then
					arg_56_1.talkMaxDuration = var_59_7

					if var_59_7 + var_59_2 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_7 + var_59_2
					end
				end

				arg_56_1.text_.text = var_59_5
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409014", "story_v_side_new_1108409.awb") ~= 0 then
					local var_59_8 = manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409014", "story_v_side_new_1108409.awb") / 1000

					if var_59_8 + var_59_2 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_8 + var_59_2
					end

					if var_59_4.prefab_name ~= "" and arg_56_1.actors_[var_59_4.prefab_name] ~= nil then
						local var_59_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_4.prefab_name].transform, "story_v_side_new_1108409", "1108409014", "story_v_side_new_1108409.awb")

						arg_56_1:RecordAudio("1108409014", var_59_9)
						arg_56_1:RecordAudio("1108409014", var_59_9)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_side_new_1108409", "1108409014", "story_v_side_new_1108409.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_side_new_1108409", "1108409014", "story_v_side_new_1108409.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_10 = math.max(var_59_3, arg_56_1.talkMaxDuration)

			if var_59_2 <= arg_56_1.time_ and arg_56_1.time_ < var_59_2 + var_59_10 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_2) / var_59_10

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_2 + var_59_10 and arg_56_1.time_ < var_59_2 + var_59_10 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play1108409015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 1108409015
		arg_60_1.duration_ = 6.93

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play1108409016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 and not isNil(arg_60_1.actors_["1084ui_story"]) and arg_60_1.var_.characterEffect1084ui_story == nil then
				arg_60_1.var_.characterEffect1084ui_story = arg_60_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_0 = 0.200000002980232

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_0 and not isNil(arg_60_1.actors_["1084ui_story"]) then
				if arg_60_1.var_.characterEffect1084ui_story and not isNil(arg_60_1.actors_["1084ui_story"]) then
					arg_60_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_60_1.time_ >= 0 + var_63_0 and arg_60_1.time_ < 0 + var_63_0 + arg_63_0 and not isNil(arg_60_1.actors_["1084ui_story"]) and arg_60_1.var_.characterEffect1084ui_story then
				arg_60_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_63_2 = arg_60_1.actors_["1047ui_story"]

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 and not isNil(var_63_2) and arg_60_1.var_.characterEffect1047ui_story == nil then
				arg_60_1.var_.characterEffect1047ui_story = var_63_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_3 = 0.200000002980232

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_3 and not isNil(var_63_2) then
				if arg_60_1.var_.characterEffect1047ui_story and not isNil(var_63_2) then
					arg_60_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_60_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_60_1.time_ - 0) / var_63_3)
				end
			end

			if arg_60_1.time_ >= 0 + var_63_3 and arg_60_1.time_ < 0 + var_63_3 + arg_63_0 and not isNil(var_63_2) and arg_60_1.var_.characterEffect1047ui_story then
				arg_60_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_60_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_1")
			end

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_63_4 = 0
			local var_63_5 = 0.95

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_4 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				arg_60_1.leftNameTxt_.text = arg_60_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_6 = arg_60_1:GetWordFromCfg(1108409015)
				local var_63_7 = arg_60_1:FormatText(var_63_6.content)

				arg_60_1.text_.text = var_63_7

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_9 = 38 <= 0 and var_63_5 or var_63_5 * (utf8.len(var_63_7) / 38)

				if (38 <= 0 and var_63_5 or var_63_5 * (utf8.len(var_63_7) / 38)) > 0 and var_63_5 < var_63_9 then
					arg_60_1.talkMaxDuration = var_63_9

					if var_63_9 + var_63_4 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_9 + var_63_4
					end
				end

				arg_60_1.text_.text = var_63_7
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409015", "story_v_side_new_1108409.awb") ~= 0 then
					local var_63_10 = manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409015", "story_v_side_new_1108409.awb") / 1000

					if var_63_10 + var_63_4 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_10 + var_63_4
					end

					if var_63_6.prefab_name ~= "" and arg_60_1.actors_[var_63_6.prefab_name] ~= nil then
						local var_63_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_6.prefab_name].transform, "story_v_side_new_1108409", "1108409015", "story_v_side_new_1108409.awb")

						arg_60_1:RecordAudio("1108409015", var_63_11)
						arg_60_1:RecordAudio("1108409015", var_63_11)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_side_new_1108409", "1108409015", "story_v_side_new_1108409.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_side_new_1108409", "1108409015", "story_v_side_new_1108409.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_12 = math.max(var_63_5, arg_60_1.talkMaxDuration)

			if var_63_4 <= arg_60_1.time_ and arg_60_1.time_ < var_63_4 + var_63_12 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_4) / var_63_12

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_4 + var_63_12 and arg_60_1.time_ < var_63_4 + var_63_12 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play1108409016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 1108409016
		arg_64_1.duration_ = 8.3

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play1108409017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 and not isNil(arg_64_1.actors_["1047ui_story"]) and arg_64_1.var_.characterEffect1047ui_story == nil then
				arg_64_1.var_.characterEffect1047ui_story = arg_64_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_0 = 0.200000002980232

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_0 and not isNil(arg_64_1.actors_["1047ui_story"]) then
				if arg_64_1.var_.characterEffect1047ui_story and not isNil(arg_64_1.actors_["1047ui_story"]) then
					arg_64_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_64_1.time_ >= 0 + var_67_0 and arg_64_1.time_ < 0 + var_67_0 + arg_67_0 and not isNil(arg_64_1.actors_["1047ui_story"]) and arg_64_1.var_.characterEffect1047ui_story then
				arg_64_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_67_2 = arg_64_1.actors_["1084ui_story"]

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 and not isNil(var_67_2) and arg_64_1.var_.characterEffect1084ui_story == nil then
				arg_64_1.var_.characterEffect1084ui_story = var_67_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_3 = 0.200000002980232

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_3 and not isNil(var_67_2) then
				if arg_64_1.var_.characterEffect1084ui_story and not isNil(var_67_2) then
					arg_64_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_64_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_64_1.time_ - 0) / var_67_3)
				end
			end

			if arg_64_1.time_ >= 0 + var_67_3 and arg_64_1.time_ < 0 + var_67_3 + arg_67_0 and not isNil(var_67_2) and arg_64_1.var_.characterEffect1084ui_story then
				arg_64_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_64_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action6_2")
			end

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_67_4 = 0
			local var_67_5 = 0.825

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= var_67_4 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				arg_64_1.leftNameTxt_.text = arg_64_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_6 = arg_64_1:GetWordFromCfg(1108409016)
				local var_67_7 = arg_64_1:FormatText(var_67_6.content)

				arg_64_1.text_.text = var_67_7

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_9 = 33 <= 0 and var_67_5 or var_67_5 * (utf8.len(var_67_7) / 33)

				if (33 <= 0 and var_67_5 or var_67_5 * (utf8.len(var_67_7) / 33)) > 0 and var_67_5 < var_67_9 then
					arg_64_1.talkMaxDuration = var_67_9

					if var_67_9 + var_67_4 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_9 + var_67_4
					end
				end

				arg_64_1.text_.text = var_67_7
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409016", "story_v_side_new_1108409.awb") ~= 0 then
					local var_67_10 = manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409016", "story_v_side_new_1108409.awb") / 1000

					if var_67_10 + var_67_4 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_10 + var_67_4
					end

					if var_67_6.prefab_name ~= "" and arg_64_1.actors_[var_67_6.prefab_name] ~= nil then
						local var_67_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_6.prefab_name].transform, "story_v_side_new_1108409", "1108409016", "story_v_side_new_1108409.awb")

						arg_64_1:RecordAudio("1108409016", var_67_11)
						arg_64_1:RecordAudio("1108409016", var_67_11)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_side_new_1108409", "1108409016", "story_v_side_new_1108409.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_side_new_1108409", "1108409016", "story_v_side_new_1108409.awb")
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
	Play1108409017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 1108409017
		arg_68_1.duration_ = 7.1

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play1108409018(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 and not isNil(arg_68_1.actors_["1084ui_story"]) and arg_68_1.var_.characterEffect1084ui_story == nil then
				arg_68_1.var_.characterEffect1084ui_story = arg_68_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_0 = 0.200000002980232

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_0 and not isNil(arg_68_1.actors_["1084ui_story"]) then
				if arg_68_1.var_.characterEffect1084ui_story and not isNil(arg_68_1.actors_["1084ui_story"]) then
					arg_68_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_68_1.time_ >= 0 + var_71_0 and arg_68_1.time_ < 0 + var_71_0 + arg_71_0 and not isNil(arg_68_1.actors_["1084ui_story"]) and arg_68_1.var_.characterEffect1084ui_story then
				arg_68_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_71_2 = arg_68_1.actors_["1047ui_story"]

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 and not isNil(var_71_2) and arg_68_1.var_.characterEffect1047ui_story == nil then
				arg_68_1.var_.characterEffect1047ui_story = var_71_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_3 = 0.200000002980232

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_3 and not isNil(var_71_2) then
				if arg_68_1.var_.characterEffect1047ui_story and not isNil(var_71_2) then
					arg_68_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_68_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_68_1.time_ - 0) / var_71_3)
				end
			end

			if arg_68_1.time_ >= 0 + var_71_3 and arg_68_1.time_ < 0 + var_71_3 + arg_71_0 and not isNil(var_71_2) and arg_68_1.var_.characterEffect1047ui_story then
				arg_68_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_68_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action473")
			end

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_71_4 = 0
			local var_71_5 = 0.7

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= var_71_4 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				arg_68_1.leftNameTxt_.text = arg_68_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_6 = arg_68_1:GetWordFromCfg(1108409017)
				local var_71_7 = arg_68_1:FormatText(var_71_6.content)

				arg_68_1.text_.text = var_71_7

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_9 = 28 <= 0 and var_71_5 or var_71_5 * (utf8.len(var_71_7) / 28)

				if (28 <= 0 and var_71_5 or var_71_5 * (utf8.len(var_71_7) / 28)) > 0 and var_71_5 < var_71_9 then
					arg_68_1.talkMaxDuration = var_71_9

					if var_71_9 + var_71_4 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_9 + var_71_4
					end
				end

				arg_68_1.text_.text = var_71_7
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409017", "story_v_side_new_1108409.awb") ~= 0 then
					local var_71_10 = manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409017", "story_v_side_new_1108409.awb") / 1000

					if var_71_10 + var_71_4 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_10 + var_71_4
					end

					if var_71_6.prefab_name ~= "" and arg_68_1.actors_[var_71_6.prefab_name] ~= nil then
						local var_71_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_6.prefab_name].transform, "story_v_side_new_1108409", "1108409017", "story_v_side_new_1108409.awb")

						arg_68_1:RecordAudio("1108409017", var_71_11)
						arg_68_1:RecordAudio("1108409017", var_71_11)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_side_new_1108409", "1108409017", "story_v_side_new_1108409.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_side_new_1108409", "1108409017", "story_v_side_new_1108409.awb")
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
	Play1108409018 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 1108409018
		arg_72_1.duration_ = 1.5

		SetActive(arg_72_1.tipsGo_, true)

		arg_72_1.tipsText_.text = StoryTipsCfg[108401].name

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"

			SetActive(arg_72_1.choicesGo_, true)

			for iter_73_0, iter_73_1 in ipairs(arg_72_1.choices_) do
				SetActive(iter_73_1.go, iter_73_0 <= 2)
			end

			arg_72_1.choices_[1].txt.text = arg_72_1:FormatText(StoryChoiceCfg[1694].name)
			arg_72_1.choices_[2].txt.text = arg_72_1:FormatText(StoryChoiceCfg[1695].name)
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play1108409019(arg_72_1)
			end

			if arg_74_0 == 2 then
				PlayerAction.UseStoryTrigger(1084014, 210840109, 1108409018, 2)
				arg_72_0:Play1108409019(arg_72_1)
			end

			arg_72_1:RecordChoiceLog(1108409018, 1694, 1695)
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 and not isNil(arg_72_1.actors_["1084ui_story"]) and arg_72_1.var_.characterEffect1084ui_story == nil then
				arg_72_1.var_.characterEffect1084ui_story = arg_72_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_0 = 0.200000002980232

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_0 and not isNil(arg_72_1.actors_["1084ui_story"]) then
				if arg_72_1.var_.characterEffect1084ui_story and not isNil(arg_72_1.actors_["1084ui_story"]) then
					arg_72_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_72_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_72_1.time_ - 0) / var_75_0)
				end
			end

			if arg_72_1.time_ >= 0 + var_75_0 and arg_72_1.time_ < 0 + var_75_0 + arg_75_0 and not isNil(arg_72_1.actors_["1084ui_story"]) and arg_72_1.var_.characterEffect1084ui_story then
				arg_72_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_72_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_75_1 = 0

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= var_75_1 + arg_75_0 then
				arg_72_1.allBtn_.enabled = false
			end

			if arg_72_1.time_ >= var_75_1 + 0.633333333333333 and arg_72_1.time_ < var_75_1 + 0.633333333333333 + arg_75_0 then
				arg_72_1.allBtn_.enabled = true
			end
		end

		arg_72_1.nodeConfigList_ = {}

		arg_72_1:InitPlayNodeList()
	end,
	Play1108409019 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 1108409019
		arg_76_1.duration_ = 3.6

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play1108409020(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 and not isNil(arg_76_1.actors_["1084ui_story"]) and arg_76_1.var_.characterEffect1084ui_story == nil then
				arg_76_1.var_.characterEffect1084ui_story = arg_76_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_0 = 0.200000002980232

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_0 and not isNil(arg_76_1.actors_["1084ui_story"]) then
				if arg_76_1.var_.characterEffect1084ui_story and not isNil(arg_76_1.actors_["1084ui_story"]) then
					arg_76_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_76_1.time_ >= 0 + var_79_0 and arg_76_1.time_ < 0 + var_79_0 + arg_79_0 and not isNil(arg_76_1.actors_["1084ui_story"]) and arg_76_1.var_.characterEffect1084ui_story then
				arg_76_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_79_2 = "1084ui_story"

			if arg_76_1.actors_["1084ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1084ui_story"))) then
				local var_79_3 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_76_1.stage_.transform)

				var_79_3.name = var_79_2
				var_79_3.transform.localPosition = Vector3.New(0, 100, 0)
				arg_76_1.actors_[var_79_2] = var_79_3

				local var_79_4 = var_79_3:GetComponentInChildren(typeof(CharacterEffect))

				var_79_4.enabled = true

				local var_79_5 = GameObjectTools.GetOrAddComponent(var_79_3, typeof(DynamicBoneHelper))

				if var_79_5 then
					var_79_5:EnableDynamicBone(false)
				end

				arg_76_1:ShowWeapon(var_79_4.transform, false)

				arg_76_1.var_[var_79_2 .. "Animator"] = var_79_4.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_76_1.var_[var_79_2 .. "Animator"].applyRootMotion = true
				arg_76_1.var_[var_79_2 .. "LipSync"] = var_79_4.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_2")
			end

			local var_79_6 = "1084ui_story"

			if arg_76_1.actors_["1084ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1084ui_story"))) then
				local var_79_7 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_76_1.stage_.transform)

				var_79_7.name = var_79_6
				var_79_7.transform.localPosition = Vector3.New(0, 100, 0)
				arg_76_1.actors_[var_79_6] = var_79_7

				local var_79_8 = var_79_7:GetComponentInChildren(typeof(CharacterEffect))

				var_79_8.enabled = true

				local var_79_9 = GameObjectTools.GetOrAddComponent(var_79_7, typeof(DynamicBoneHelper))

				if var_79_9 then
					var_79_9:EnableDynamicBone(false)
				end

				arg_76_1:ShowWeapon(var_79_8.transform, false)

				arg_76_1.var_[var_79_6 .. "Animator"] = var_79_8.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_76_1.var_[var_79_6 .. "Animator"].applyRootMotion = true
				arg_76_1.var_[var_79_6 .. "LipSync"] = var_79_8.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_79_10 = 0
			local var_79_11 = 0.6

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= var_79_10 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				arg_76_1.leftNameTxt_.text = arg_76_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_12 = arg_76_1:GetWordFromCfg(1108409019)
				local var_79_13 = arg_76_1:FormatText(var_79_12.content)

				arg_76_1.text_.text = var_79_13

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_15 = 24 <= 0 and var_79_11 or var_79_11 * (utf8.len(var_79_13) / 24)

				if (24 <= 0 and var_79_11 or var_79_11 * (utf8.len(var_79_13) / 24)) > 0 and var_79_11 < var_79_15 then
					arg_76_1.talkMaxDuration = var_79_15

					if var_79_15 + var_79_10 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_15 + var_79_10
					end
				end

				arg_76_1.text_.text = var_79_13
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409019", "story_v_side_new_1108409.awb") ~= 0 then
					local var_79_16 = manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409019", "story_v_side_new_1108409.awb") / 1000

					if var_79_16 + var_79_10 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_16 + var_79_10
					end

					if var_79_12.prefab_name ~= "" and arg_76_1.actors_[var_79_12.prefab_name] ~= nil then
						local var_79_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_12.prefab_name].transform, "story_v_side_new_1108409", "1108409019", "story_v_side_new_1108409.awb")

						arg_76_1:RecordAudio("1108409019", var_79_17)
						arg_76_1:RecordAudio("1108409019", var_79_17)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_side_new_1108409", "1108409019", "story_v_side_new_1108409.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_side_new_1108409", "1108409019", "story_v_side_new_1108409.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_18 = math.max(var_79_11, arg_76_1.talkMaxDuration)

			if var_79_10 <= arg_76_1.time_ and arg_76_1.time_ < var_79_10 + var_79_18 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_10) / var_79_18

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_10 + var_79_18 and arg_76_1.time_ < var_79_10 + var_79_18 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {}

		arg_76_1:InitPlayNodeList()
	end,
	Play1108409020 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 1108409020
		arg_80_1.duration_ = 5

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play1108409021(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 and not isNil(arg_80_1.actors_["1084ui_story"]) and arg_80_1.var_.characterEffect1084ui_story == nil then
				arg_80_1.var_.characterEffect1084ui_story = arg_80_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_0 = 0.200000002980232

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_0 and not isNil(arg_80_1.actors_["1084ui_story"]) then
				if arg_80_1.var_.characterEffect1084ui_story and not isNil(arg_80_1.actors_["1084ui_story"]) then
					arg_80_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_80_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_80_1.time_ - 0) / var_83_0)
				end
			end

			if arg_80_1.time_ >= 0 + var_83_0 and arg_80_1.time_ < 0 + var_83_0 + arg_83_0 and not isNil(arg_80_1.actors_["1084ui_story"]) and arg_80_1.var_.characterEffect1084ui_story then
				arg_80_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_80_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_83_1 = 0
			local var_83_2 = 0.65

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_1 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				arg_80_1.leftNameTxt_.text = arg_80_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, true)
				arg_80_1.iconController_:SetSelectedState("hero")

				arg_80_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_80_1.callingController_:SetSelectedState("normal")

				arg_80_1.keyicon_.color = Color.New(1, 1, 1)
				arg_80_1.icon_.color = Color.New(1, 1, 1)

				local var_83_3 = arg_80_1:FormatText(arg_80_1:GetWordFromCfg(1108409020).content)

				arg_80_1.text_.text = var_83_3

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_5 = 26 <= 0 and var_83_2 or var_83_2 * (utf8.len(var_83_3) / 26)

				if (26 <= 0 and var_83_2 or var_83_2 * (utf8.len(var_83_3) / 26)) > 0 and var_83_2 < var_83_5 then
					arg_80_1.talkMaxDuration = var_83_5

					if var_83_5 + var_83_1 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_5 + var_83_1
					end
				end

				arg_80_1.text_.text = var_83_3
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)
				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_6 = math.max(var_83_2, arg_80_1.talkMaxDuration)

			if var_83_1 <= arg_80_1.time_ and arg_80_1.time_ < var_83_1 + var_83_6 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_1) / var_83_6

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_1 + var_83_6 and arg_80_1.time_ < var_83_1 + var_83_6 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {}

		arg_80_1:InitPlayNodeList()
	end,
	Play1108409021 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 1108409021
		arg_84_1.duration_ = 5

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play1108409022(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = 1.95

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				arg_84_1.leftNameTxt_.text = arg_84_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, true)
				arg_84_1.iconController_:SetSelectedState("hero")

				arg_84_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_84_1.callingController_:SetSelectedState("normal")

				arg_84_1.keyicon_.color = Color.New(1, 1, 1)
				arg_84_1.icon_.color = Color.New(1, 1, 1)

				local var_87_1 = arg_84_1:FormatText(arg_84_1:GetWordFromCfg(1108409021).content)

				arg_84_1.text_.text = var_87_1

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_3 = 78 <= 0 and var_87_0 or var_87_0 * (utf8.len(var_87_1) / 78)

				if (78 <= 0 and var_87_0 or var_87_0 * (utf8.len(var_87_1) / 78)) > 0 and var_87_0 < var_87_3 then
					arg_84_1.talkMaxDuration = var_87_3

					if var_87_3 + 0 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_3 + 0
					end
				end

				arg_84_1.text_.text = var_87_1
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)
				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_4 = math.max(var_87_0, arg_84_1.talkMaxDuration)

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_4 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - 0) / var_87_4

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= 0 + var_87_4 and arg_84_1.time_ < 0 + var_87_4 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {}

		arg_84_1:InitPlayNodeList()
	end,
	Play1108409022 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 1108409022
		arg_88_1.duration_ = 8.27

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play1108409023(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 and not isNil(arg_88_1.actors_["1084ui_story"]) and arg_88_1.var_.characterEffect1084ui_story == nil then
				arg_88_1.var_.characterEffect1084ui_story = arg_88_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_0 = 0.200000002980232

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_0 and not isNil(arg_88_1.actors_["1084ui_story"]) then
				if arg_88_1.var_.characterEffect1084ui_story and not isNil(arg_88_1.actors_["1084ui_story"]) then
					arg_88_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_88_1.time_ >= 0 + var_91_0 and arg_88_1.time_ < 0 + var_91_0 + arg_91_0 and not isNil(arg_88_1.actors_["1084ui_story"]) and arg_88_1.var_.characterEffect1084ui_story then
				arg_88_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_1")
			end

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_91_2 = 0
			local var_91_3 = 0.7

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= var_91_2 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				arg_88_1.leftNameTxt_.text = arg_88_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_4 = arg_88_1:GetWordFromCfg(1108409022)
				local var_91_5 = arg_88_1:FormatText(var_91_4.content)

				arg_88_1.text_.text = var_91_5

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_7 = 28 <= 0 and var_91_3 or var_91_3 * (utf8.len(var_91_5) / 28)

				if (28 <= 0 and var_91_3 or var_91_3 * (utf8.len(var_91_5) / 28)) > 0 and var_91_3 < var_91_7 then
					arg_88_1.talkMaxDuration = var_91_7

					if var_91_7 + var_91_2 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_7 + var_91_2
					end
				end

				arg_88_1.text_.text = var_91_5
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409022", "story_v_side_new_1108409.awb") ~= 0 then
					local var_91_8 = manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409022", "story_v_side_new_1108409.awb") / 1000

					if var_91_8 + var_91_2 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_8 + var_91_2
					end

					if var_91_4.prefab_name ~= "" and arg_88_1.actors_[var_91_4.prefab_name] ~= nil then
						local var_91_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_4.prefab_name].transform, "story_v_side_new_1108409", "1108409022", "story_v_side_new_1108409.awb")

						arg_88_1:RecordAudio("1108409022", var_91_9)
						arg_88_1:RecordAudio("1108409022", var_91_9)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_side_new_1108409", "1108409022", "story_v_side_new_1108409.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_side_new_1108409", "1108409022", "story_v_side_new_1108409.awb")
				end

				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_10 = math.max(var_91_3, arg_88_1.talkMaxDuration)

			if var_91_2 <= arg_88_1.time_ and arg_88_1.time_ < var_91_2 + var_91_10 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_2) / var_91_10

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_2 + var_91_10 and arg_88_1.time_ < var_91_2 + var_91_10 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {}

		arg_88_1:InitPlayNodeList()
	end,
	Play1108409023 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 1108409023
		arg_92_1.duration_ = 2.83

		SetActive(arg_92_1.tipsGo_, false)

		function arg_92_1.onSingleLineFinish_()
			arg_92_1.onSingleLineUpdate_ = nil
			arg_92_1.onSingleLineFinish_ = nil
			arg_92_1.state_ = "waiting"
		end

		function arg_92_1.playNext_(arg_94_0)
			if arg_94_0 == 1 then
				arg_92_0:Play1108409024(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 and not isNil(arg_92_1.actors_["1047ui_story"]) and arg_92_1.var_.characterEffect1047ui_story == nil then
				arg_92_1.var_.characterEffect1047ui_story = arg_92_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_0 = 0.200000002980232

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_0 and not isNil(arg_92_1.actors_["1047ui_story"]) then
				if arg_92_1.var_.characterEffect1047ui_story and not isNil(arg_92_1.actors_["1047ui_story"]) then
					arg_92_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_92_1.time_ >= 0 + var_95_0 and arg_92_1.time_ < 0 + var_95_0 + arg_95_0 and not isNil(arg_92_1.actors_["1047ui_story"]) and arg_92_1.var_.characterEffect1047ui_story then
				arg_92_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_95_2 = arg_92_1.actors_["1084ui_story"]

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 and not isNil(var_95_2) and arg_92_1.var_.characterEffect1084ui_story == nil then
				arg_92_1.var_.characterEffect1084ui_story = var_95_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_3 = 0.200000002980232

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_3 and not isNil(var_95_2) then
				if arg_92_1.var_.characterEffect1084ui_story and not isNil(var_95_2) then
					arg_92_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_92_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_92_1.time_ - 0) / var_95_3)
				end
			end

			if arg_92_1.time_ >= 0 + var_95_3 and arg_92_1.time_ < 0 + var_95_3 + arg_95_0 and not isNil(var_95_2) and arg_92_1.var_.characterEffect1084ui_story then
				arg_92_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_92_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_95_4 = 0
			local var_95_5 = 0.3

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= var_95_4 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				arg_92_1.leftNameTxt_.text = arg_92_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_6 = arg_92_1:GetWordFromCfg(1108409023)
				local var_95_7 = arg_92_1:FormatText(var_95_6.content)

				arg_92_1.text_.text = var_95_7

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_9 = 12 <= 0 and var_95_5 or var_95_5 * (utf8.len(var_95_7) / 12)

				if (12 <= 0 and var_95_5 or var_95_5 * (utf8.len(var_95_7) / 12)) > 0 and var_95_5 < var_95_9 then
					arg_92_1.talkMaxDuration = var_95_9

					if var_95_9 + var_95_4 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_9 + var_95_4
					end
				end

				arg_92_1.text_.text = var_95_7
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409023", "story_v_side_new_1108409.awb") ~= 0 then
					local var_95_10 = manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409023", "story_v_side_new_1108409.awb") / 1000

					if var_95_10 + var_95_4 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_10 + var_95_4
					end

					if var_95_6.prefab_name ~= "" and arg_92_1.actors_[var_95_6.prefab_name] ~= nil then
						local var_95_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_6.prefab_name].transform, "story_v_side_new_1108409", "1108409023", "story_v_side_new_1108409.awb")

						arg_92_1:RecordAudio("1108409023", var_95_11)
						arg_92_1:RecordAudio("1108409023", var_95_11)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_side_new_1108409", "1108409023", "story_v_side_new_1108409.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_side_new_1108409", "1108409023", "story_v_side_new_1108409.awb")
				end

				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_12 = math.max(var_95_5, arg_92_1.talkMaxDuration)

			if var_95_4 <= arg_92_1.time_ and arg_92_1.time_ < var_95_4 + var_95_12 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_4) / var_95_12

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_4 + var_95_12 and arg_92_1.time_ < var_95_4 + var_95_12 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {}

		arg_92_1:InitPlayNodeList()
	end,
	Play1108409024 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 1108409024
		arg_96_1.duration_ = 6.4

		SetActive(arg_96_1.tipsGo_, false)

		function arg_96_1.onSingleLineFinish_()
			arg_96_1.onSingleLineUpdate_ = nil
			arg_96_1.onSingleLineFinish_ = nil
			arg_96_1.state_ = "waiting"
		end

		function arg_96_1.playNext_(arg_98_0)
			if arg_98_0 == 1 then
				arg_96_0:Play1108409025(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 and not isNil(arg_96_1.actors_["1084ui_story"]) and arg_96_1.var_.characterEffect1084ui_story == nil then
				arg_96_1.var_.characterEffect1084ui_story = arg_96_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_0 = 0.200000002980232

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_0 and not isNil(arg_96_1.actors_["1084ui_story"]) then
				if arg_96_1.var_.characterEffect1084ui_story and not isNil(arg_96_1.actors_["1084ui_story"]) then
					arg_96_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_96_1.time_ >= 0 + var_99_0 and arg_96_1.time_ < 0 + var_99_0 + arg_99_0 and not isNil(arg_96_1.actors_["1084ui_story"]) and arg_96_1.var_.characterEffect1084ui_story then
				arg_96_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_99_2 = arg_96_1.actors_["1047ui_story"]

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 and not isNil(var_99_2) and arg_96_1.var_.characterEffect1047ui_story == nil then
				arg_96_1.var_.characterEffect1047ui_story = var_99_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_3 = 0.200000002980232

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_3 and not isNil(var_99_2) then
				if arg_96_1.var_.characterEffect1047ui_story and not isNil(var_99_2) then
					arg_96_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_96_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_96_1.time_ - 0) / var_99_3)
				end
			end

			if arg_96_1.time_ >= 0 + var_99_3 and arg_96_1.time_ < 0 + var_99_3 + arg_99_0 and not isNil(var_99_2) and arg_96_1.var_.characterEffect1047ui_story then
				arg_96_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_96_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_2")
			end

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_99_4 = 0
			local var_99_5 = 0.475

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= var_99_4 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				arg_96_1.leftNameTxt_.text = arg_96_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_6 = arg_96_1:GetWordFromCfg(1108409024)
				local var_99_7 = arg_96_1:FormatText(var_99_6.content)

				arg_96_1.text_.text = var_99_7

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_9 = 19 <= 0 and var_99_5 or var_99_5 * (utf8.len(var_99_7) / 19)

				if (19 <= 0 and var_99_5 or var_99_5 * (utf8.len(var_99_7) / 19)) > 0 and var_99_5 < var_99_9 then
					arg_96_1.talkMaxDuration = var_99_9

					if var_99_9 + var_99_4 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_9 + var_99_4
					end
				end

				arg_96_1.text_.text = var_99_7
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409024", "story_v_side_new_1108409.awb") ~= 0 then
					local var_99_10 = manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409024", "story_v_side_new_1108409.awb") / 1000

					if var_99_10 + var_99_4 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_10 + var_99_4
					end

					if var_99_6.prefab_name ~= "" and arg_96_1.actors_[var_99_6.prefab_name] ~= nil then
						local var_99_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_6.prefab_name].transform, "story_v_side_new_1108409", "1108409024", "story_v_side_new_1108409.awb")

						arg_96_1:RecordAudio("1108409024", var_99_11)
						arg_96_1:RecordAudio("1108409024", var_99_11)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_side_new_1108409", "1108409024", "story_v_side_new_1108409.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_side_new_1108409", "1108409024", "story_v_side_new_1108409.awb")
				end

				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_12 = math.max(var_99_5, arg_96_1.talkMaxDuration)

			if var_99_4 <= arg_96_1.time_ and arg_96_1.time_ < var_99_4 + var_99_12 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_4) / var_99_12

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_4 + var_99_12 and arg_96_1.time_ < var_99_4 + var_99_12 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {}

		arg_96_1:InitPlayNodeList()
	end,
	Play1108409025 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 1108409025
		arg_100_1.duration_ = 5

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play1108409026(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 and not isNil(arg_100_1.actors_["1084ui_story"]) and arg_100_1.var_.characterEffect1084ui_story == nil then
				arg_100_1.var_.characterEffect1084ui_story = arg_100_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_103_0 = 0.200000002980232

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_0 and not isNil(arg_100_1.actors_["1084ui_story"]) then
				if arg_100_1.var_.characterEffect1084ui_story and not isNil(arg_100_1.actors_["1084ui_story"]) then
					arg_100_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_100_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_100_1.time_ - 0) / var_103_0)
				end
			end

			if arg_100_1.time_ >= 0 + var_103_0 and arg_100_1.time_ < 0 + var_103_0 + arg_103_0 and not isNil(arg_100_1.actors_["1084ui_story"]) and arg_100_1.var_.characterEffect1084ui_story then
				arg_100_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_100_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_103_1 = 0
			local var_103_2 = 0.35

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= var_103_1 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				arg_100_1.leftNameTxt_.text = arg_100_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, true)
				arg_100_1.iconController_:SetSelectedState("hero")

				arg_100_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_100_1.callingController_:SetSelectedState("normal")

				arg_100_1.keyicon_.color = Color.New(1, 1, 1)
				arg_100_1.icon_.color = Color.New(1, 1, 1)

				local var_103_3 = arg_100_1:FormatText(arg_100_1:GetWordFromCfg(1108409025).content)

				arg_100_1.text_.text = var_103_3

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_5 = 14 <= 0 and var_103_2 or var_103_2 * (utf8.len(var_103_3) / 14)

				if (14 <= 0 and var_103_2 or var_103_2 * (utf8.len(var_103_3) / 14)) > 0 and var_103_2 < var_103_5 then
					arg_100_1.talkMaxDuration = var_103_5

					if var_103_5 + var_103_1 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_5 + var_103_1
					end
				end

				arg_100_1.text_.text = var_103_3
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)
				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_6 = math.max(var_103_2, arg_100_1.talkMaxDuration)

			if var_103_1 <= arg_100_1.time_ and arg_100_1.time_ < var_103_1 + var_103_6 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_1) / var_103_6

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_1 + var_103_6 and arg_100_1.time_ < var_103_1 + var_103_6 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {}

		arg_100_1:InitPlayNodeList()
	end,
	Play1108409026 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 1108409026
		arg_104_1.duration_ = 4.4

		SetActive(arg_104_1.tipsGo_, false)

		function arg_104_1.onSingleLineFinish_()
			arg_104_1.onSingleLineUpdate_ = nil
			arg_104_1.onSingleLineFinish_ = nil
			arg_104_1.state_ = "waiting"
		end

		function arg_104_1.playNext_(arg_106_0)
			if arg_106_0 == 1 then
				arg_104_0:Play1108409027(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 and not isNil(arg_104_1.actors_["1047ui_story"]) and arg_104_1.var_.characterEffect1047ui_story == nil then
				arg_104_1.var_.characterEffect1047ui_story = arg_104_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_107_0 = 0.200000002980232

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_0 and not isNil(arg_104_1.actors_["1047ui_story"]) then
				if arg_104_1.var_.characterEffect1047ui_story and not isNil(arg_104_1.actors_["1047ui_story"]) then
					arg_104_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_104_1.time_ >= 0 + var_107_0 and arg_104_1.time_ < 0 + var_107_0 + arg_107_0 and not isNil(arg_104_1.actors_["1047ui_story"]) and arg_104_1.var_.characterEffect1047ui_story then
				arg_104_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action4_1")
			end

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_107_2 = 0
			local var_107_3 = 0.5

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= var_107_2 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				arg_104_1.leftNameTxt_.text = arg_104_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_4 = arg_104_1:GetWordFromCfg(1108409026)
				local var_107_5 = arg_104_1:FormatText(var_107_4.content)

				arg_104_1.text_.text = var_107_5

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_7 = 20 <= 0 and var_107_3 or var_107_3 * (utf8.len(var_107_5) / 20)

				if (20 <= 0 and var_107_3 or var_107_3 * (utf8.len(var_107_5) / 20)) > 0 and var_107_3 < var_107_7 then
					arg_104_1.talkMaxDuration = var_107_7

					if var_107_7 + var_107_2 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_7 + var_107_2
					end
				end

				arg_104_1.text_.text = var_107_5
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409026", "story_v_side_new_1108409.awb") ~= 0 then
					local var_107_8 = manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409026", "story_v_side_new_1108409.awb") / 1000

					if var_107_8 + var_107_2 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_8 + var_107_2
					end

					if var_107_4.prefab_name ~= "" and arg_104_1.actors_[var_107_4.prefab_name] ~= nil then
						local var_107_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_4.prefab_name].transform, "story_v_side_new_1108409", "1108409026", "story_v_side_new_1108409.awb")

						arg_104_1:RecordAudio("1108409026", var_107_9)
						arg_104_1:RecordAudio("1108409026", var_107_9)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_side_new_1108409", "1108409026", "story_v_side_new_1108409.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_side_new_1108409", "1108409026", "story_v_side_new_1108409.awb")
				end

				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_10 = math.max(var_107_3, arg_104_1.talkMaxDuration)

			if var_107_2 <= arg_104_1.time_ and arg_104_1.time_ < var_107_2 + var_107_10 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_2) / var_107_10

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_2 + var_107_10 and arg_104_1.time_ < var_107_2 + var_107_10 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {}

		arg_104_1:InitPlayNodeList()
	end,
	Play1108409027 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 1108409027
		arg_108_1.duration_ = 5

		SetActive(arg_108_1.tipsGo_, false)

		function arg_108_1.onSingleLineFinish_()
			arg_108_1.onSingleLineUpdate_ = nil
			arg_108_1.onSingleLineFinish_ = nil
			arg_108_1.state_ = "waiting"
		end

		function arg_108_1.playNext_(arg_110_0)
			if arg_110_0 == 1 then
				arg_108_0:Play1108409028(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 and not isNil(arg_108_1.actors_["1047ui_story"]) and arg_108_1.var_.characterEffect1047ui_story == nil then
				arg_108_1.var_.characterEffect1047ui_story = arg_108_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_111_0 = 0.200000002980232

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_0 and not isNil(arg_108_1.actors_["1047ui_story"]) then
				if arg_108_1.var_.characterEffect1047ui_story and not isNil(arg_108_1.actors_["1047ui_story"]) then
					arg_108_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_108_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_108_1.time_ - 0) / var_111_0)
				end
			end

			if arg_108_1.time_ >= 0 + var_111_0 and arg_108_1.time_ < 0 + var_111_0 + arg_111_0 and not isNil(arg_108_1.actors_["1047ui_story"]) and arg_108_1.var_.characterEffect1047ui_story then
				arg_108_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_108_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_111_1 = arg_108_1.actors_["1047ui_story"].transform

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 then
				arg_108_1.var_.moveOldPos1047ui_story = var_111_1.localPosition
			end

			local var_111_2 = 0.001

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_2 then
				var_111_1.localPosition = Vector3.Lerp(arg_108_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_108_1.time_ - 0) / var_111_2)
				var_111_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_111_1.position).x, (manager.ui.mainCamera.transform.position - var_111_1.position).y, (manager.ui.mainCamera.transform.position - var_111_1.position).z)
				var_111_1.localEulerAngles.z = 0
				var_111_1.localEulerAngles.x = 0
				var_111_1.localEulerAngles = var_111_1.localEulerAngles
			end

			if arg_108_1.time_ >= 0 + var_111_2 and arg_108_1.time_ < 0 + var_111_2 + arg_111_0 then
				var_111_1.localPosition = Vector3.New(0, 100, 0)
				var_111_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_111_1.position).x, (manager.ui.mainCamera.transform.position - var_111_1.position).y, (manager.ui.mainCamera.transform.position - var_111_1.position).z)
				var_111_1.localEulerAngles.z = 0
				var_111_1.localEulerAngles.x = 0
				var_111_1.localEulerAngles = var_111_1.localEulerAngles
			end

			local var_111_3 = 0
			local var_111_4 = 0.9

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= var_111_3 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, false)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_5 = arg_108_1:FormatText(arg_108_1:GetWordFromCfg(1108409027).content)

				arg_108_1.text_.text = var_111_5

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_7 = 36 <= 0 and var_111_4 or var_111_4 * (utf8.len(var_111_5) / 36)

				if (36 <= 0 and var_111_4 or var_111_4 * (utf8.len(var_111_5) / 36)) > 0 and var_111_4 < var_111_7 then
					arg_108_1.talkMaxDuration = var_111_7

					if var_111_7 + var_111_3 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_7 + var_111_3
					end
				end

				arg_108_1.text_.text = var_111_5
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)
				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_8 = math.max(var_111_4, arg_108_1.talkMaxDuration)

			if var_111_3 <= arg_108_1.time_ and arg_108_1.time_ < var_111_3 + var_111_8 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_3) / var_111_8

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_3 + var_111_8 and arg_108_1.time_ < var_111_3 + var_111_8 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_108_1:InitPlayNodeList()
	end,
	Play1108409028 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 1108409028
		arg_112_1.duration_ = 5

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play1108409029(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			local var_115_0 = 0.25

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				arg_112_1.leftNameTxt_.text = arg_112_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, true)
				arg_112_1.iconController_:SetSelectedState("hero")

				arg_112_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_112_1.callingController_:SetSelectedState("normal")

				arg_112_1.keyicon_.color = Color.New(1, 1, 1)
				arg_112_1.icon_.color = Color.New(1, 1, 1)

				local var_115_1 = arg_112_1:FormatText(arg_112_1:GetWordFromCfg(1108409028).content)

				arg_112_1.text_.text = var_115_1

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_3 = 10 <= 0 and var_115_0 or var_115_0 * (utf8.len(var_115_1) / 10)

				if (10 <= 0 and var_115_0 or var_115_0 * (utf8.len(var_115_1) / 10)) > 0 and var_115_0 < var_115_3 then
					arg_112_1.talkMaxDuration = var_115_3

					if var_115_3 + 0 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_3 + 0
					end
				end

				arg_112_1.text_.text = var_115_1
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)
				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_4 = math.max(var_115_0, arg_112_1.talkMaxDuration)

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_4 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - 0) / var_115_4

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= 0 + var_115_4 and arg_112_1.time_ < 0 + var_115_4 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {}

		arg_112_1:InitPlayNodeList()
	end,
	Play1108409029 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 1108409029
		arg_116_1.duration_ = 4.63

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play1108409030(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 and not isNil(arg_116_1.actors_["1047ui_story"]) and arg_116_1.var_.characterEffect1047ui_story == nil then
				arg_116_1.var_.characterEffect1047ui_story = arg_116_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_119_0 = 0.200000002980232

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_0 and not isNil(arg_116_1.actors_["1047ui_story"]) then
				if arg_116_1.var_.characterEffect1047ui_story and not isNil(arg_116_1.actors_["1047ui_story"]) then
					arg_116_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_116_1.time_ >= 0 + var_119_0 and arg_116_1.time_ < 0 + var_119_0 + arg_119_0 and not isNil(arg_116_1.actors_["1047ui_story"]) and arg_116_1.var_.characterEffect1047ui_story then
				arg_116_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				arg_116_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action4_2")
			end

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				arg_116_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_119_2 = arg_116_1.actors_["1047ui_story"].transform

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				arg_116_1.var_.moveOldPos1047ui_story = var_119_2.localPosition
			end

			local var_119_3 = 0.001

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_3 then
				var_119_2.localPosition = Vector3.Lerp(arg_116_1.var_.moveOldPos1047ui_story, Vector3.New(-0.6, -1.13, -6.2), (arg_116_1.time_ - 0) / var_119_3)
				var_119_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_119_2.position).x, (manager.ui.mainCamera.transform.position - var_119_2.position).y, (manager.ui.mainCamera.transform.position - var_119_2.position).z)
				var_119_2.localEulerAngles.z = 0
				var_119_2.localEulerAngles.x = 0
				var_119_2.localEulerAngles = var_119_2.localEulerAngles
			end

			if arg_116_1.time_ >= 0 + var_119_3 and arg_116_1.time_ < 0 + var_119_3 + arg_119_0 then
				var_119_2.localPosition = Vector3.New(-0.6, -1.13, -6.2)
				var_119_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_119_2.position).x, (manager.ui.mainCamera.transform.position - var_119_2.position).y, (manager.ui.mainCamera.transform.position - var_119_2.position).z)
				var_119_2.localEulerAngles.z = 0
				var_119_2.localEulerAngles.x = 0
				var_119_2.localEulerAngles = var_119_2.localEulerAngles
			end

			local var_119_4 = 0
			local var_119_5 = 0.55

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= var_119_4 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				arg_116_1.leftNameTxt_.text = arg_116_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_6 = arg_116_1:GetWordFromCfg(1108409029)
				local var_119_7 = arg_116_1:FormatText(var_119_6.content)

				arg_116_1.text_.text = var_119_7

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_9 = 22 <= 0 and var_119_5 or var_119_5 * (utf8.len(var_119_7) / 22)

				if (22 <= 0 and var_119_5 or var_119_5 * (utf8.len(var_119_7) / 22)) > 0 and var_119_5 < var_119_9 then
					arg_116_1.talkMaxDuration = var_119_9

					if var_119_9 + var_119_4 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_9 + var_119_4
					end
				end

				arg_116_1.text_.text = var_119_7
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409029", "story_v_side_new_1108409.awb") ~= 0 then
					local var_119_10 = manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409029", "story_v_side_new_1108409.awb") / 1000

					if var_119_10 + var_119_4 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_10 + var_119_4
					end

					if var_119_6.prefab_name ~= "" and arg_116_1.actors_[var_119_6.prefab_name] ~= nil then
						local var_119_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_116_1.actors_[var_119_6.prefab_name].transform, "story_v_side_new_1108409", "1108409029", "story_v_side_new_1108409.awb")

						arg_116_1:RecordAudio("1108409029", var_119_11)
						arg_116_1:RecordAudio("1108409029", var_119_11)
					else
						arg_116_1:AudioAction("play", "voice", "story_v_side_new_1108409", "1108409029", "story_v_side_new_1108409.awb")
					end

					arg_116_1:RecordHistoryTalkVoice("story_v_side_new_1108409", "1108409029", "story_v_side_new_1108409.awb")
				end

				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_12 = math.max(var_119_5, arg_116_1.talkMaxDuration)

			if var_119_4 <= arg_116_1.time_ and arg_116_1.time_ < var_119_4 + var_119_12 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_4) / var_119_12

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_4 + var_119_12 and arg_116_1.time_ < var_119_4 + var_119_12 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_116_1:InitPlayNodeList()
	end,
	Play1108409030 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 1108409030
		arg_120_1.duration_ = 14.4

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play1108409031(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			local var_123_0 = 1.625

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				arg_120_1.leftNameTxt_.text = arg_120_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_1 = arg_120_1:GetWordFromCfg(1108409030)
				local var_123_2 = arg_120_1:FormatText(var_123_1.content)

				arg_120_1.text_.text = var_123_2

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_4 = 65 <= 0 and var_123_0 or var_123_0 * (utf8.len(var_123_2) / 65)

				if (65 <= 0 and var_123_0 or var_123_0 * (utf8.len(var_123_2) / 65)) > 0 and var_123_0 < var_123_4 then
					arg_120_1.talkMaxDuration = var_123_4

					if var_123_4 + 0 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_4 + 0
					end
				end

				arg_120_1.text_.text = var_123_2
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409030", "story_v_side_new_1108409.awb") ~= 0 then
					local var_123_5 = manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409030", "story_v_side_new_1108409.awb") / 1000

					if var_123_5 + 0 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_5 + 0
					end

					if var_123_1.prefab_name ~= "" and arg_120_1.actors_[var_123_1.prefab_name] ~= nil then
						local var_123_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_120_1.actors_[var_123_1.prefab_name].transform, "story_v_side_new_1108409", "1108409030", "story_v_side_new_1108409.awb")

						arg_120_1:RecordAudio("1108409030", var_123_6)
						arg_120_1:RecordAudio("1108409030", var_123_6)
					else
						arg_120_1:AudioAction("play", "voice", "story_v_side_new_1108409", "1108409030", "story_v_side_new_1108409.awb")
					end

					arg_120_1:RecordHistoryTalkVoice("story_v_side_new_1108409", "1108409030", "story_v_side_new_1108409.awb")
				end

				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_7 = math.max(var_123_0, arg_120_1.talkMaxDuration)

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_7 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - 0) / var_123_7

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= 0 + var_123_7 and arg_120_1.time_ < 0 + var_123_7 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {}

		arg_120_1:InitPlayNodeList()
	end,
	Play1108409031 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 1108409031
		arg_124_1.duration_ = 9.83

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play1108409032(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action6_1")
			end

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_127_0 = 0
			local var_127_1 = 1.05

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= var_127_0 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				arg_124_1.leftNameTxt_.text = arg_124_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_2 = arg_124_1:GetWordFromCfg(1108409031)
				local var_127_3 = arg_124_1:FormatText(var_127_2.content)

				arg_124_1.text_.text = var_127_3

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_5 = 42 <= 0 and var_127_1 or var_127_1 * (utf8.len(var_127_3) / 42)

				if (42 <= 0 and var_127_1 or var_127_1 * (utf8.len(var_127_3) / 42)) > 0 and var_127_1 < var_127_5 then
					arg_124_1.talkMaxDuration = var_127_5

					if var_127_5 + var_127_0 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_5 + var_127_0
					end
				end

				arg_124_1.text_.text = var_127_3
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409031", "story_v_side_new_1108409.awb") ~= 0 then
					local var_127_6 = manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409031", "story_v_side_new_1108409.awb") / 1000

					if var_127_6 + var_127_0 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_6 + var_127_0
					end

					if var_127_2.prefab_name ~= "" and arg_124_1.actors_[var_127_2.prefab_name] ~= nil then
						local var_127_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_124_1.actors_[var_127_2.prefab_name].transform, "story_v_side_new_1108409", "1108409031", "story_v_side_new_1108409.awb")

						arg_124_1:RecordAudio("1108409031", var_127_7)
						arg_124_1:RecordAudio("1108409031", var_127_7)
					else
						arg_124_1:AudioAction("play", "voice", "story_v_side_new_1108409", "1108409031", "story_v_side_new_1108409.awb")
					end

					arg_124_1:RecordHistoryTalkVoice("story_v_side_new_1108409", "1108409031", "story_v_side_new_1108409.awb")
				end

				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_8 = math.max(var_127_1, arg_124_1.talkMaxDuration)

			if var_127_0 <= arg_124_1.time_ and arg_124_1.time_ < var_127_0 + var_127_8 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_0) / var_127_8

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_0 + var_127_8 and arg_124_1.time_ < var_127_0 + var_127_8 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {}

		arg_124_1:InitPlayNodeList()
	end,
	Play1108409032 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 1108409032
		arg_128_1.duration_ = 3.9

		SetActive(arg_128_1.tipsGo_, false)

		function arg_128_1.onSingleLineFinish_()
			arg_128_1.onSingleLineUpdate_ = nil
			arg_128_1.onSingleLineFinish_ = nil
			arg_128_1.state_ = "waiting"
		end

		function arg_128_1.playNext_(arg_130_0)
			if arg_130_0 == 1 then
				arg_128_0:Play1108409033(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 and not isNil(arg_128_1.actors_["1084ui_story"]) and arg_128_1.var_.characterEffect1084ui_story == nil then
				arg_128_1.var_.characterEffect1084ui_story = arg_128_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_131_0 = 0.200000002980232

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_0 and not isNil(arg_128_1.actors_["1084ui_story"]) then
				if arg_128_1.var_.characterEffect1084ui_story and not isNil(arg_128_1.actors_["1084ui_story"]) then
					arg_128_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_128_1.time_ >= 0 + var_131_0 and arg_128_1.time_ < 0 + var_131_0 + arg_131_0 and not isNil(arg_128_1.actors_["1084ui_story"]) and arg_128_1.var_.characterEffect1084ui_story then
				arg_128_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_131_2 = arg_128_1.actors_["1047ui_story"]

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 and not isNil(var_131_2) and arg_128_1.var_.characterEffect1047ui_story == nil then
				arg_128_1.var_.characterEffect1047ui_story = var_131_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_131_3 = 0.200000002980232

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_3 and not isNil(var_131_2) then
				if arg_128_1.var_.characterEffect1047ui_story and not isNil(var_131_2) then
					arg_128_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_128_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_128_1.time_ - 0) / var_131_3)
				end
			end

			if arg_128_1.time_ >= 0 + var_131_3 and arg_128_1.time_ < 0 + var_131_3 + arg_131_0 and not isNil(var_131_2) and arg_128_1.var_.characterEffect1047ui_story then
				arg_128_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_128_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				arg_128_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_1")
			end

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				arg_128_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_131_4 = 0
			local var_131_5 = 0.3

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= var_131_4 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				arg_128_1.leftNameTxt_.text = arg_128_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_6 = arg_128_1:GetWordFromCfg(1108409032)
				local var_131_7 = arg_128_1:FormatText(var_131_6.content)

				arg_128_1.text_.text = var_131_7

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_9 = 12 <= 0 and var_131_5 or var_131_5 * (utf8.len(var_131_7) / 12)

				if (12 <= 0 and var_131_5 or var_131_5 * (utf8.len(var_131_7) / 12)) > 0 and var_131_5 < var_131_9 then
					arg_128_1.talkMaxDuration = var_131_9

					if var_131_9 + var_131_4 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_9 + var_131_4
					end
				end

				arg_128_1.text_.text = var_131_7
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409032", "story_v_side_new_1108409.awb") ~= 0 then
					local var_131_10 = manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409032", "story_v_side_new_1108409.awb") / 1000

					if var_131_10 + var_131_4 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_10 + var_131_4
					end

					if var_131_6.prefab_name ~= "" and arg_128_1.actors_[var_131_6.prefab_name] ~= nil then
						local var_131_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_6.prefab_name].transform, "story_v_side_new_1108409", "1108409032", "story_v_side_new_1108409.awb")

						arg_128_1:RecordAudio("1108409032", var_131_11)
						arg_128_1:RecordAudio("1108409032", var_131_11)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_side_new_1108409", "1108409032", "story_v_side_new_1108409.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_side_new_1108409", "1108409032", "story_v_side_new_1108409.awb")
				end

				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_12 = math.max(var_131_5, arg_128_1.talkMaxDuration)

			if var_131_4 <= arg_128_1.time_ and arg_128_1.time_ < var_131_4 + var_131_12 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_4) / var_131_12

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_4 + var_131_12 and arg_128_1.time_ < var_131_4 + var_131_12 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {}

		arg_128_1:InitPlayNodeList()
	end,
	Play1108409033 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 1108409033
		arg_132_1.duration_ = 5

		SetActive(arg_132_1.tipsGo_, false)

		function arg_132_1.onSingleLineFinish_()
			arg_132_1.onSingleLineUpdate_ = nil
			arg_132_1.onSingleLineFinish_ = nil
			arg_132_1.state_ = "waiting"
		end

		function arg_132_1.playNext_(arg_134_0)
			if arg_134_0 == 1 then
				arg_132_0:Play1108409034(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 and not isNil(arg_132_1.actors_["1084ui_story"]) and arg_132_1.var_.characterEffect1084ui_story == nil then
				arg_132_1.var_.characterEffect1084ui_story = arg_132_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_135_0 = 0.200000002980232

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_0 and not isNil(arg_132_1.actors_["1084ui_story"]) then
				if arg_132_1.var_.characterEffect1084ui_story and not isNil(arg_132_1.actors_["1084ui_story"]) then
					arg_132_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_132_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_132_1.time_ - 0) / var_135_0)
				end
			end

			if arg_132_1.time_ >= 0 + var_135_0 and arg_132_1.time_ < 0 + var_135_0 + arg_135_0 and not isNil(arg_132_1.actors_["1084ui_story"]) and arg_132_1.var_.characterEffect1084ui_story then
				arg_132_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_132_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_135_1 = 0
			local var_135_2 = 0.3

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= var_135_1 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				arg_132_1.leftNameTxt_.text = arg_132_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, true)
				arg_132_1.iconController_:SetSelectedState("hero")

				arg_132_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_132_1.callingController_:SetSelectedState("normal")

				arg_132_1.keyicon_.color = Color.New(1, 1, 1)
				arg_132_1.icon_.color = Color.New(1, 1, 1)

				local var_135_3 = arg_132_1:FormatText(arg_132_1:GetWordFromCfg(1108409033).content)

				arg_132_1.text_.text = var_135_3

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_5 = 12 <= 0 and var_135_2 or var_135_2 * (utf8.len(var_135_3) / 12)

				if (12 <= 0 and var_135_2 or var_135_2 * (utf8.len(var_135_3) / 12)) > 0 and var_135_2 < var_135_5 then
					arg_132_1.talkMaxDuration = var_135_5

					if var_135_5 + var_135_1 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_5 + var_135_1
					end
				end

				arg_132_1.text_.text = var_135_3
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)
				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_6 = math.max(var_135_2, arg_132_1.talkMaxDuration)

			if var_135_1 <= arg_132_1.time_ and arg_132_1.time_ < var_135_1 + var_135_6 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_1) / var_135_6

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_1 + var_135_6 and arg_132_1.time_ < var_135_1 + var_135_6 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {}

		arg_132_1:InitPlayNodeList()
	end,
	Play1108409034 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 1108409034
		arg_136_1.duration_ = 7.03

		SetActive(arg_136_1.tipsGo_, false)

		function arg_136_1.onSingleLineFinish_()
			arg_136_1.onSingleLineUpdate_ = nil
			arg_136_1.onSingleLineFinish_ = nil
			arg_136_1.state_ = "waiting"
		end

		function arg_136_1.playNext_(arg_138_0)
			if arg_138_0 == 1 then
				arg_136_0:Play1108409035(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 and not isNil(arg_136_1.actors_["1047ui_story"]) and arg_136_1.var_.characterEffect1047ui_story == nil then
				arg_136_1.var_.characterEffect1047ui_story = arg_136_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_139_0 = 0.200000002980232

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_0 and not isNil(arg_136_1.actors_["1047ui_story"]) then
				if arg_136_1.var_.characterEffect1047ui_story and not isNil(arg_136_1.actors_["1047ui_story"]) then
					arg_136_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_136_1.time_ >= 0 + var_139_0 and arg_136_1.time_ < 0 + var_139_0 + arg_139_0 and not isNil(arg_136_1.actors_["1047ui_story"]) and arg_136_1.var_.characterEffect1047ui_story then
				arg_136_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 then
				arg_136_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action6_2")
			end

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 then
				arg_136_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_139_2 = 0
			local var_139_3 = 1.075

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= var_139_2 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				arg_136_1.leftNameTxt_.text = arg_136_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_4 = arg_136_1:GetWordFromCfg(1108409034)
				local var_139_5 = arg_136_1:FormatText(var_139_4.content)

				arg_136_1.text_.text = var_139_5

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_7 = 43 <= 0 and var_139_3 or var_139_3 * (utf8.len(var_139_5) / 43)

				if (43 <= 0 and var_139_3 or var_139_3 * (utf8.len(var_139_5) / 43)) > 0 and var_139_3 < var_139_7 then
					arg_136_1.talkMaxDuration = var_139_7

					if var_139_7 + var_139_2 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_7 + var_139_2
					end
				end

				arg_136_1.text_.text = var_139_5
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409034", "story_v_side_new_1108409.awb") ~= 0 then
					local var_139_8 = manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409034", "story_v_side_new_1108409.awb") / 1000

					if var_139_8 + var_139_2 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_8 + var_139_2
					end

					if var_139_4.prefab_name ~= "" and arg_136_1.actors_[var_139_4.prefab_name] ~= nil then
						local var_139_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_136_1.actors_[var_139_4.prefab_name].transform, "story_v_side_new_1108409", "1108409034", "story_v_side_new_1108409.awb")

						arg_136_1:RecordAudio("1108409034", var_139_9)
						arg_136_1:RecordAudio("1108409034", var_139_9)
					else
						arg_136_1:AudioAction("play", "voice", "story_v_side_new_1108409", "1108409034", "story_v_side_new_1108409.awb")
					end

					arg_136_1:RecordHistoryTalkVoice("story_v_side_new_1108409", "1108409034", "story_v_side_new_1108409.awb")
				end

				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_10 = math.max(var_139_3, arg_136_1.talkMaxDuration)

			if var_139_2 <= arg_136_1.time_ and arg_136_1.time_ < var_139_2 + var_139_10 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_2) / var_139_10

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_2 + var_139_10 and arg_136_1.time_ < var_139_2 + var_139_10 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {}

		arg_136_1:InitPlayNodeList()
	end,
	Play1108409035 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 1108409035
		arg_140_1.duration_ = 5

		SetActive(arg_140_1.tipsGo_, false)

		function arg_140_1.onSingleLineFinish_()
			arg_140_1.onSingleLineUpdate_ = nil
			arg_140_1.onSingleLineFinish_ = nil
			arg_140_1.state_ = "waiting"
		end

		function arg_140_1.playNext_(arg_142_0)
			if arg_142_0 == 1 then
				arg_140_0:Play1108409036(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 and not isNil(arg_140_1.actors_["1047ui_story"]) and arg_140_1.var_.characterEffect1047ui_story == nil then
				arg_140_1.var_.characterEffect1047ui_story = arg_140_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_143_0 = 0.200000002980232

			if 0 <= arg_140_1.time_ and arg_140_1.time_ < 0 + var_143_0 and not isNil(arg_140_1.actors_["1047ui_story"]) then
				if arg_140_1.var_.characterEffect1047ui_story and not isNil(arg_140_1.actors_["1047ui_story"]) then
					arg_140_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_140_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_140_1.time_ - 0) / var_143_0)
				end
			end

			if arg_140_1.time_ >= 0 + var_143_0 and arg_140_1.time_ < 0 + var_143_0 + arg_143_0 and not isNil(arg_140_1.actors_["1047ui_story"]) and arg_140_1.var_.characterEffect1047ui_story then
				arg_140_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_140_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_143_1 = 0
			local var_143_2 = 1.2

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= var_143_1 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				arg_140_1.leftNameTxt_.text = arg_140_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, true)
				arg_140_1.iconController_:SetSelectedState("hero")

				arg_140_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_140_1.callingController_:SetSelectedState("normal")

				arg_140_1.keyicon_.color = Color.New(1, 1, 1)
				arg_140_1.icon_.color = Color.New(1, 1, 1)

				local var_143_3 = arg_140_1:FormatText(arg_140_1:GetWordFromCfg(1108409035).content)

				arg_140_1.text_.text = var_143_3

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_5 = 48 <= 0 and var_143_2 or var_143_2 * (utf8.len(var_143_3) / 48)

				if (48 <= 0 and var_143_2 or var_143_2 * (utf8.len(var_143_3) / 48)) > 0 and var_143_2 < var_143_5 then
					arg_140_1.talkMaxDuration = var_143_5

					if var_143_5 + var_143_1 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_5 + var_143_1
					end
				end

				arg_140_1.text_.text = var_143_3
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)
				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_6 = math.max(var_143_2, arg_140_1.talkMaxDuration)

			if var_143_1 <= arg_140_1.time_ and arg_140_1.time_ < var_143_1 + var_143_6 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_1) / var_143_6

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_1 + var_143_6 and arg_140_1.time_ < var_143_1 + var_143_6 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {}

		arg_140_1:InitPlayNodeList()
	end,
	Play1108409036 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 1108409036
		arg_144_1.duration_ = 4.67

		SetActive(arg_144_1.tipsGo_, false)

		function arg_144_1.onSingleLineFinish_()
			arg_144_1.onSingleLineUpdate_ = nil
			arg_144_1.onSingleLineFinish_ = nil
			arg_144_1.state_ = "waiting"
		end

		function arg_144_1.playNext_(arg_146_0)
			if arg_146_0 == 1 then
				arg_144_0:Play1108409037(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 and not isNil(arg_144_1.actors_["1084ui_story"]) and arg_144_1.var_.characterEffect1084ui_story == nil then
				arg_144_1.var_.characterEffect1084ui_story = arg_144_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_147_0 = 0.200000002980232

			if 0 <= arg_144_1.time_ and arg_144_1.time_ < 0 + var_147_0 and not isNil(arg_144_1.actors_["1084ui_story"]) then
				if arg_144_1.var_.characterEffect1084ui_story and not isNil(arg_144_1.actors_["1084ui_story"]) then
					arg_144_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_144_1.time_ >= 0 + var_147_0 and arg_144_1.time_ < 0 + var_147_0 + arg_147_0 and not isNil(arg_144_1.actors_["1084ui_story"]) and arg_144_1.var_.characterEffect1084ui_story then
				arg_144_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 then
				arg_144_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_2")
			end

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 then
				arg_144_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_147_2 = 0
			local var_147_3 = 0.425

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= var_147_2 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				arg_144_1.leftNameTxt_.text = arg_144_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, false)
				arg_144_1.callingController_:SetSelectedState("normal")

				local var_147_4 = arg_144_1:GetWordFromCfg(1108409036)
				local var_147_5 = arg_144_1:FormatText(var_147_4.content)

				arg_144_1.text_.text = var_147_5

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_7 = 17 <= 0 and var_147_3 or var_147_3 * (utf8.len(var_147_5) / 17)

				if (17 <= 0 and var_147_3 or var_147_3 * (utf8.len(var_147_5) / 17)) > 0 and var_147_3 < var_147_7 then
					arg_144_1.talkMaxDuration = var_147_7

					if var_147_7 + var_147_2 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_7 + var_147_2
					end
				end

				arg_144_1.text_.text = var_147_5
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409036", "story_v_side_new_1108409.awb") ~= 0 then
					local var_147_8 = manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409036", "story_v_side_new_1108409.awb") / 1000

					if var_147_8 + var_147_2 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_8 + var_147_2
					end

					if var_147_4.prefab_name ~= "" and arg_144_1.actors_[var_147_4.prefab_name] ~= nil then
						local var_147_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_144_1.actors_[var_147_4.prefab_name].transform, "story_v_side_new_1108409", "1108409036", "story_v_side_new_1108409.awb")

						arg_144_1:RecordAudio("1108409036", var_147_9)
						arg_144_1:RecordAudio("1108409036", var_147_9)
					else
						arg_144_1:AudioAction("play", "voice", "story_v_side_new_1108409", "1108409036", "story_v_side_new_1108409.awb")
					end

					arg_144_1:RecordHistoryTalkVoice("story_v_side_new_1108409", "1108409036", "story_v_side_new_1108409.awb")
				end

				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_10 = math.max(var_147_3, arg_144_1.talkMaxDuration)

			if var_147_2 <= arg_144_1.time_ and arg_144_1.time_ < var_147_2 + var_147_10 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_2) / var_147_10

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_2 + var_147_10 and arg_144_1.time_ < var_147_2 + var_147_10 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {}

		arg_144_1:InitPlayNodeList()
	end,
	Play1108409037 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 1108409037
		arg_148_1.duration_ = 5

		SetActive(arg_148_1.tipsGo_, false)

		function arg_148_1.onSingleLineFinish_()
			arg_148_1.onSingleLineUpdate_ = nil
			arg_148_1.onSingleLineFinish_ = nil
			arg_148_1.state_ = "waiting"
		end

		function arg_148_1.playNext_(arg_150_0)
			if arg_150_0 == 1 then
				arg_148_0:Play1108409038(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 and not isNil(arg_148_1.actors_["1084ui_story"]) and arg_148_1.var_.characterEffect1084ui_story == nil then
				arg_148_1.var_.characterEffect1084ui_story = arg_148_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_151_0 = 0.200000002980232

			if 0 <= arg_148_1.time_ and arg_148_1.time_ < 0 + var_151_0 and not isNil(arg_148_1.actors_["1084ui_story"]) then
				if arg_148_1.var_.characterEffect1084ui_story and not isNil(arg_148_1.actors_["1084ui_story"]) then
					arg_148_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_148_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_148_1.time_ - 0) / var_151_0)
				end
			end

			if arg_148_1.time_ >= 0 + var_151_0 and arg_148_1.time_ < 0 + var_151_0 + arg_151_0 and not isNil(arg_148_1.actors_["1084ui_story"]) and arg_148_1.var_.characterEffect1084ui_story then
				arg_148_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_148_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_151_1 = 0
			local var_151_2 = 0.45

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= var_151_1 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, true)

				arg_148_1.leftNameTxt_.text = arg_148_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_148_1.leftNameTxt_.transform)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1.leftNameTxt_.text)
				SetActive(arg_148_1.iconTrs_.gameObject, true)
				arg_148_1.iconController_:SetSelectedState("hero")

				arg_148_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_148_1.callingController_:SetSelectedState("normal")

				arg_148_1.keyicon_.color = Color.New(1, 1, 1)
				arg_148_1.icon_.color = Color.New(1, 1, 1)

				local var_151_3 = arg_148_1:FormatText(arg_148_1:GetWordFromCfg(1108409037).content)

				arg_148_1.text_.text = var_151_3

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_5 = 18 <= 0 and var_151_2 or var_151_2 * (utf8.len(var_151_3) / 18)

				if (18 <= 0 and var_151_2 or var_151_2 * (utf8.len(var_151_3) / 18)) > 0 and var_151_2 < var_151_5 then
					arg_148_1.talkMaxDuration = var_151_5

					if var_151_5 + var_151_1 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_5 + var_151_1
					end
				end

				arg_148_1.text_.text = var_151_3
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)
				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_6 = math.max(var_151_2, arg_148_1.talkMaxDuration)

			if var_151_1 <= arg_148_1.time_ and arg_148_1.time_ < var_151_1 + var_151_6 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_1) / var_151_6

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_1 + var_151_6 and arg_148_1.time_ < var_151_1 + var_151_6 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {}

		arg_148_1:InitPlayNodeList()
	end,
	Play1108409038 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 1108409038
		arg_152_1.duration_ = 8.87

		SetActive(arg_152_1.tipsGo_, false)

		function arg_152_1.onSingleLineFinish_()
			arg_152_1.onSingleLineUpdate_ = nil
			arg_152_1.onSingleLineFinish_ = nil
			arg_152_1.state_ = "waiting"
		end

		function arg_152_1.playNext_(arg_154_0)
			if arg_154_0 == 1 then
				arg_152_0:Play1108409039(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 and not isNil(arg_152_1.actors_["1047ui_story"]) and arg_152_1.var_.characterEffect1047ui_story == nil then
				arg_152_1.var_.characterEffect1047ui_story = arg_152_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_155_0 = 0.200000002980232

			if 0 <= arg_152_1.time_ and arg_152_1.time_ < 0 + var_155_0 and not isNil(arg_152_1.actors_["1047ui_story"]) then
				if arg_152_1.var_.characterEffect1047ui_story and not isNil(arg_152_1.actors_["1047ui_story"]) then
					arg_152_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_152_1.time_ >= 0 + var_155_0 and arg_152_1.time_ < 0 + var_155_0 + arg_155_0 and not isNil(arg_152_1.actors_["1047ui_story"]) and arg_152_1.var_.characterEffect1047ui_story then
				arg_152_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 then
				arg_152_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action7_1")
			end

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 then
				arg_152_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_155_2 = 0
			local var_155_3 = 1

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= var_155_2 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				arg_152_1.leftNameTxt_.text = arg_152_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, false)
				arg_152_1.callingController_:SetSelectedState("normal")

				local var_155_4 = arg_152_1:GetWordFromCfg(1108409038)
				local var_155_5 = arg_152_1:FormatText(var_155_4.content)

				arg_152_1.text_.text = var_155_5

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_7 = 41 <= 0 and var_155_3 or var_155_3 * (utf8.len(var_155_5) / 41)

				if (41 <= 0 and var_155_3 or var_155_3 * (utf8.len(var_155_5) / 41)) > 0 and var_155_3 < var_155_7 then
					arg_152_1.talkMaxDuration = var_155_7

					if var_155_7 + var_155_2 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_7 + var_155_2
					end
				end

				arg_152_1.text_.text = var_155_5
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409038", "story_v_side_new_1108409.awb") ~= 0 then
					local var_155_8 = manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409038", "story_v_side_new_1108409.awb") / 1000

					if var_155_8 + var_155_2 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_8 + var_155_2
					end

					if var_155_4.prefab_name ~= "" and arg_152_1.actors_[var_155_4.prefab_name] ~= nil then
						local var_155_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_152_1.actors_[var_155_4.prefab_name].transform, "story_v_side_new_1108409", "1108409038", "story_v_side_new_1108409.awb")

						arg_152_1:RecordAudio("1108409038", var_155_9)
						arg_152_1:RecordAudio("1108409038", var_155_9)
					else
						arg_152_1:AudioAction("play", "voice", "story_v_side_new_1108409", "1108409038", "story_v_side_new_1108409.awb")
					end

					arg_152_1:RecordHistoryTalkVoice("story_v_side_new_1108409", "1108409038", "story_v_side_new_1108409.awb")
				end

				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_10 = math.max(var_155_3, arg_152_1.talkMaxDuration)

			if var_155_2 <= arg_152_1.time_ and arg_152_1.time_ < var_155_2 + var_155_10 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_2) / var_155_10

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_2 + var_155_10 and arg_152_1.time_ < var_155_2 + var_155_10 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {}

		arg_152_1:InitPlayNodeList()
	end,
	Play1108409039 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 1108409039
		arg_156_1.duration_ = 5

		SetActive(arg_156_1.tipsGo_, false)

		function arg_156_1.onSingleLineFinish_()
			arg_156_1.onSingleLineUpdate_ = nil
			arg_156_1.onSingleLineFinish_ = nil
			arg_156_1.state_ = "waiting"
		end

		function arg_156_1.playNext_(arg_158_0)
			if arg_158_0 == 1 then
				arg_156_0:Play1108409040(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 and not isNil(arg_156_1.actors_["1047ui_story"]) and arg_156_1.var_.characterEffect1047ui_story == nil then
				arg_156_1.var_.characterEffect1047ui_story = arg_156_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_159_0 = 0.200000002980232

			if 0 <= arg_156_1.time_ and arg_156_1.time_ < 0 + var_159_0 and not isNil(arg_156_1.actors_["1047ui_story"]) then
				if arg_156_1.var_.characterEffect1047ui_story and not isNil(arg_156_1.actors_["1047ui_story"]) then
					arg_156_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_156_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_156_1.time_ - 0) / var_159_0)
				end
			end

			if arg_156_1.time_ >= 0 + var_159_0 and arg_156_1.time_ < 0 + var_159_0 + arg_159_0 and not isNil(arg_156_1.actors_["1047ui_story"]) and arg_156_1.var_.characterEffect1047ui_story then
				arg_156_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_156_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_159_1 = 0
			local var_159_2 = 0.2

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= var_159_1 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, true)

				arg_156_1.leftNameTxt_.text = arg_156_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_156_1.leftNameTxt_.transform)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1.leftNameTxt_.text)
				SetActive(arg_156_1.iconTrs_.gameObject, true)
				arg_156_1.iconController_:SetSelectedState("hero")

				arg_156_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_156_1.callingController_:SetSelectedState("normal")

				arg_156_1.keyicon_.color = Color.New(1, 1, 1)
				arg_156_1.icon_.color = Color.New(1, 1, 1)

				local var_159_3 = arg_156_1:FormatText(arg_156_1:GetWordFromCfg(1108409039).content)

				arg_156_1.text_.text = var_159_3

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_5 = 8 <= 0 and var_159_2 or var_159_2 * (utf8.len(var_159_3) / 8)

				if (8 <= 0 and var_159_2 or var_159_2 * (utf8.len(var_159_3) / 8)) > 0 and var_159_2 < var_159_5 then
					arg_156_1.talkMaxDuration = var_159_5

					if var_159_5 + var_159_1 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_5 + var_159_1
					end
				end

				arg_156_1.text_.text = var_159_3
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)
				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_6 = math.max(var_159_2, arg_156_1.talkMaxDuration)

			if var_159_1 <= arg_156_1.time_ and arg_156_1.time_ < var_159_1 + var_159_6 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_1) / var_159_6

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_1 + var_159_6 and arg_156_1.time_ < var_159_1 + var_159_6 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {}

		arg_156_1:InitPlayNodeList()
	end,
	Play1108409040 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 1108409040
		arg_160_1.duration_ = 4.77

		SetActive(arg_160_1.tipsGo_, false)

		function arg_160_1.onSingleLineFinish_()
			arg_160_1.onSingleLineUpdate_ = nil
			arg_160_1.onSingleLineFinish_ = nil
			arg_160_1.state_ = "waiting"
		end

		function arg_160_1.playNext_(arg_162_0)
			if arg_162_0 == 1 then
				arg_160_0:Play1108409041(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 and not isNil(arg_160_1.actors_["1047ui_story"]) and arg_160_1.var_.characterEffect1047ui_story == nil then
				arg_160_1.var_.characterEffect1047ui_story = arg_160_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_163_0 = 0.200000002980232

			if 0 <= arg_160_1.time_ and arg_160_1.time_ < 0 + var_163_0 and not isNil(arg_160_1.actors_["1047ui_story"]) then
				if arg_160_1.var_.characterEffect1047ui_story and not isNil(arg_160_1.actors_["1047ui_story"]) then
					arg_160_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_160_1.time_ >= 0 + var_163_0 and arg_160_1.time_ < 0 + var_163_0 + arg_163_0 and not isNil(arg_160_1.actors_["1047ui_story"]) and arg_160_1.var_.characterEffect1047ui_story then
				arg_160_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 then
				arg_160_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action7_2")
			end

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 then
				arg_160_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_163_2 = 0
			local var_163_3 = 0.475

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= var_163_2 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, true)

				arg_160_1.leftNameTxt_.text = arg_160_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_160_1.leftNameTxt_.transform)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1.leftNameTxt_.text)
				SetActive(arg_160_1.iconTrs_.gameObject, false)
				arg_160_1.callingController_:SetSelectedState("normal")

				local var_163_4 = arg_160_1:GetWordFromCfg(1108409040)
				local var_163_5 = arg_160_1:FormatText(var_163_4.content)

				arg_160_1.text_.text = var_163_5

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_7 = 19 <= 0 and var_163_3 or var_163_3 * (utf8.len(var_163_5) / 19)

				if (19 <= 0 and var_163_3 or var_163_3 * (utf8.len(var_163_5) / 19)) > 0 and var_163_3 < var_163_7 then
					arg_160_1.talkMaxDuration = var_163_7

					if var_163_7 + var_163_2 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_7 + var_163_2
					end
				end

				arg_160_1.text_.text = var_163_5
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409040", "story_v_side_new_1108409.awb") ~= 0 then
					local var_163_8 = manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409040", "story_v_side_new_1108409.awb") / 1000

					if var_163_8 + var_163_2 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_8 + var_163_2
					end

					if var_163_4.prefab_name ~= "" and arg_160_1.actors_[var_163_4.prefab_name] ~= nil then
						local var_163_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_160_1.actors_[var_163_4.prefab_name].transform, "story_v_side_new_1108409", "1108409040", "story_v_side_new_1108409.awb")

						arg_160_1:RecordAudio("1108409040", var_163_9)
						arg_160_1:RecordAudio("1108409040", var_163_9)
					else
						arg_160_1:AudioAction("play", "voice", "story_v_side_new_1108409", "1108409040", "story_v_side_new_1108409.awb")
					end

					arg_160_1:RecordHistoryTalkVoice("story_v_side_new_1108409", "1108409040", "story_v_side_new_1108409.awb")
				end

				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_10 = math.max(var_163_3, arg_160_1.talkMaxDuration)

			if var_163_2 <= arg_160_1.time_ and arg_160_1.time_ < var_163_2 + var_163_10 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_2) / var_163_10

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_2 + var_163_10 and arg_160_1.time_ < var_163_2 + var_163_10 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {}

		arg_160_1:InitPlayNodeList()
	end,
	Play1108409041 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 1108409041
		arg_164_1.duration_ = 5

		SetActive(arg_164_1.tipsGo_, false)

		function arg_164_1.onSingleLineFinish_()
			arg_164_1.onSingleLineUpdate_ = nil
			arg_164_1.onSingleLineFinish_ = nil
			arg_164_1.state_ = "waiting"
		end

		function arg_164_1.playNext_(arg_166_0)
			if arg_166_0 == 1 then
				arg_164_0:Play1108409042(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 then
				arg_164_1.var_.moveOldPos1084ui_story = arg_164_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_167_0 = 0.001

			if 0 <= arg_164_1.time_ and arg_164_1.time_ < 0 + var_167_0 then
				arg_164_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_164_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_164_1.time_ - 0) / var_167_0)
				arg_164_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_164_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_164_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_164_1.actors_["1084ui_story"].transform.position).z)
				arg_164_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_164_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_164_1.actors_["1084ui_story"].transform.localEulerAngles = arg_164_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_164_1.time_ >= 0 + var_167_0 and arg_164_1.time_ < 0 + var_167_0 + arg_167_0 then
				arg_164_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_164_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_164_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_164_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_164_1.actors_["1084ui_story"].transform.position).z)
				arg_164_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_164_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_164_1.actors_["1084ui_story"].transform.localEulerAngles = arg_164_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_167_1 = arg_164_1.actors_["1047ui_story"].transform

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 then
				arg_164_1.var_.moveOldPos1047ui_story = var_167_1.localPosition
			end

			local var_167_2 = 0.001

			if 0 <= arg_164_1.time_ and arg_164_1.time_ < 0 + var_167_2 then
				var_167_1.localPosition = Vector3.Lerp(arg_164_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_164_1.time_ - 0) / var_167_2)
				var_167_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_167_1.position).x, (manager.ui.mainCamera.transform.position - var_167_1.position).y, (manager.ui.mainCamera.transform.position - var_167_1.position).z)
				var_167_1.localEulerAngles.z = 0
				var_167_1.localEulerAngles.x = 0
				var_167_1.localEulerAngles = var_167_1.localEulerAngles
			end

			if arg_164_1.time_ >= 0 + var_167_2 and arg_164_1.time_ < 0 + var_167_2 + arg_167_0 then
				var_167_1.localPosition = Vector3.New(0, 100, 0)
				var_167_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_167_1.position).x, (manager.ui.mainCamera.transform.position - var_167_1.position).y, (manager.ui.mainCamera.transform.position - var_167_1.position).z)
				var_167_1.localEulerAngles.z = 0
				var_167_1.localEulerAngles.x = 0
				var_167_1.localEulerAngles = var_167_1.localEulerAngles
			end

			local var_167_3 = arg_164_1.actors_["1047ui_story"]

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 and not isNil(var_167_3) and arg_164_1.var_.characterEffect1047ui_story == nil then
				arg_164_1.var_.characterEffect1047ui_story = var_167_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_167_4 = 0.200000002980232

			if 0 <= arg_164_1.time_ and arg_164_1.time_ < 0 + var_167_4 and not isNil(var_167_3) then
				if arg_164_1.var_.characterEffect1047ui_story and not isNil(var_167_3) then
					arg_164_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_164_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_164_1.time_ - 0) / var_167_4)
				end
			end

			if arg_164_1.time_ >= 0 + var_167_4 and arg_164_1.time_ < 0 + var_167_4 + arg_167_0 and not isNil(var_167_3) and arg_164_1.var_.characterEffect1047ui_story then
				arg_164_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_164_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_167_5 = 0
			local var_167_6 = 1.175

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= var_167_5 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0
				arg_164_1.dialogCg_.alpha = 1

				arg_164_1.dialog_:SetActive(true)
				SetActive(arg_164_1.leftNameGo_, false)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_164_1.iconTrs_.gameObject, false)
				arg_164_1.callingController_:SetSelectedState("normal")

				local var_167_7 = arg_164_1:FormatText(arg_164_1:GetWordFromCfg(1108409041).content)

				arg_164_1.text_.text = var_167_7

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_9 = 47 <= 0 and var_167_6 or var_167_6 * (utf8.len(var_167_7) / 47)

				if (47 <= 0 and var_167_6 or var_167_6 * (utf8.len(var_167_7) / 47)) > 0 and var_167_6 < var_167_9 then
					arg_164_1.talkMaxDuration = var_167_9

					if var_167_9 + var_167_5 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_9 + var_167_5
					end
				end

				arg_164_1.text_.text = var_167_7
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)
				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_10 = math.max(var_167_6, arg_164_1.talkMaxDuration)

			if var_167_5 <= arg_164_1.time_ and arg_164_1.time_ < var_167_5 + var_167_10 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - var_167_5) / var_167_10

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= var_167_5 + var_167_10 and arg_164_1.time_ < var_167_5 + var_167_10 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_164_1:InitPlayNodeList()
	end,
	Play1108409042 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 1108409042
		arg_168_1.duration_ = 9

		SetActive(arg_168_1.tipsGo_, false)

		function arg_168_1.onSingleLineFinish_()
			arg_168_1.onSingleLineUpdate_ = nil
			arg_168_1.onSingleLineFinish_ = nil
			arg_168_1.state_ = "waiting"
		end

		function arg_168_1.playNext_(arg_170_0)
			if arg_170_0 == 1 then
				arg_168_0:Play1108409043(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			if arg_168_1.bgs_.STblack == nil then
				local var_171_0 = Object.Instantiate(arg_168_1.paintGo_)

				var_171_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack")
				var_171_0.name = "STblack"
				var_171_0.transform.parent = arg_168_1.stage_.transform
				var_171_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_168_1.bgs_.STblack = var_171_0
			end

			if 2 < arg_168_1.time_ and arg_168_1.time_ <= 2 + arg_171_0 then
				local var_171_1 = arg_168_1.bgs_.STblack

				arg_168_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_171_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_171_2 = var_171_1:GetComponent("SpriteRenderer")

				if var_171_2 and var_171_2.sprite then
					local var_171_3 = 2 * (var_171_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_171_1.transform.localScale = Vector3.New(var_171_3 / var_171_2.sprite.bounds.size.y < var_171_3 * manager.ui.mainCameraCom_.aspect / var_171_2.sprite.bounds.size.x and var_171_3 * manager.ui.mainCameraCom_.aspect / var_171_2.sprite.bounds.size.x or var_171_3 / var_171_2.sprite.bounds.size.y, var_171_3 / var_171_2.sprite.bounds.size.y < var_171_3 * manager.ui.mainCameraCom_.aspect / var_171_2.sprite.bounds.size.x and var_171_3 * manager.ui.mainCameraCom_.aspect / var_171_2.sprite.bounds.size.x or var_171_3 / var_171_2.sprite.bounds.size.y, 0)
				end

				for iter_171_0, iter_171_1 in pairs(arg_168_1.bgs_) do
					if iter_171_0 ~= "STblack" then
						iter_171_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_171_4 = 4

			if 4 < arg_168_1.time_ and arg_168_1.time_ <= var_171_4 + arg_171_0 then
				arg_168_1.allBtn_.enabled = false
			end

			if arg_168_1.time_ >= var_171_4 + 0.3 and arg_168_1.time_ < var_171_4 + 0.3 + arg_171_0 then
				arg_168_1.allBtn_.enabled = true
			end

			local var_171_5 = 0

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= var_171_5 + arg_171_0 then
				arg_168_1.mask_.enabled = true
				arg_168_1.mask_.raycastTarget = true

				arg_168_1:SetGaussion(false)
			end

			local var_171_6 = 2

			if var_171_5 <= arg_168_1.time_ and arg_168_1.time_ < var_171_5 + var_171_6 then
				local var_171_7 = Color.New(0, 0, 0)

				var_171_7.a = Mathf.Lerp(0, 1, (arg_168_1.time_ - var_171_5) / var_171_6)
				arg_168_1.mask_.color = var_171_7
			end

			if arg_168_1.time_ >= var_171_5 + var_171_6 and arg_168_1.time_ < var_171_5 + var_171_6 + arg_171_0 then
				local var_171_8 = Color.New(0, 0, 0)

				var_171_8.a = 1
				arg_168_1.mask_.color = var_171_8
			end

			local var_171_9 = 2

			if 2 < arg_168_1.time_ and arg_168_1.time_ <= var_171_9 + arg_171_0 then
				arg_168_1.mask_.enabled = true
				arg_168_1.mask_.raycastTarget = true

				arg_168_1:SetGaussion(false)
			end

			local var_171_10 = 2

			if var_171_9 <= arg_168_1.time_ and arg_168_1.time_ < var_171_9 + var_171_10 then
				local var_171_11 = Color.New(0, 0, 0)

				var_171_11.a = Mathf.Lerp(1, 0, (arg_168_1.time_ - var_171_9) / var_171_10)
				arg_168_1.mask_.color = var_171_11
			end

			if arg_168_1.time_ >= var_171_9 + var_171_10 and arg_168_1.time_ < var_171_9 + var_171_10 + arg_171_0 then
				local var_171_12 = Color.New(0, 0, 0)

				arg_168_1.mask_.enabled = false
				var_171_12.a = 0
				arg_168_1.mask_.color = var_171_12
			end

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 then
				arg_168_1:AudioAction("play", "effect", "ui_battle", "ui_battle_stopbgm", "")
			end

			if arg_168_1.frameCnt_ <= 1 then
				arg_168_1.dialog_:SetActive(false)
			end

			local var_171_14 = 4
			local var_171_15 = 0.875

			if 4 < arg_168_1.time_ and arg_168_1.time_ <= var_171_14 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0

				arg_168_1.dialog_:SetActive(true)

				arg_168_1.dialogCg_.alpha = 0

				local var_171_16 = LeanTween.value(arg_168_1.dialog_, 0, 1, 0.3)

				var_171_16:setOnUpdate(LuaHelper.FloatAction(function(arg_172_0)
					arg_168_1.dialogCg_.alpha = arg_172_0
				end))
				var_171_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_168_1.dialog_)
					var_171_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_168_1.duration_ = arg_168_1.duration_ + 0.3

				SetActive(arg_168_1.leftNameGo_, false)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_168_1.iconTrs_.gameObject, false)
				arg_168_1.callingController_:SetSelectedState("normal")

				local var_171_17 = arg_168_1:FormatText(arg_168_1:GetWordFromCfg(1108409042).content)

				arg_168_1.text_.text = var_171_17

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_19 = 35 <= 0 and var_171_15 or var_171_15 * (utf8.len(var_171_17) / 35)

				if (35 <= 0 and var_171_15 or var_171_15 * (utf8.len(var_171_17) / 35)) > 0 and var_171_15 < var_171_19 then
					arg_168_1.talkMaxDuration = var_171_19
					var_171_14 = var_171_14 + 0.3

					if var_171_19 + var_171_14 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_19 + var_171_14
					end
				end

				arg_168_1.text_.text = var_171_17
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)
				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_20 = var_171_14 + 0.3
			local var_171_21 = math.max(var_171_15, arg_168_1.talkMaxDuration)

			if var_171_14 + 0.3 <= arg_168_1.time_ and arg_168_1.time_ < var_171_20 + var_171_21 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - var_171_20) / var_171_21

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= var_171_20 + var_171_21 and arg_168_1.time_ < var_171_20 + var_171_21 + arg_171_0 then
				arg_168_1.typewritter.percent = 1

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(true)
			end
		end

		arg_168_1.nodeConfigList_ = {}

		arg_168_1:InitPlayNodeList()
	end,
	Play1108409043 = function(arg_174_0, arg_174_1)
		arg_174_1.time_ = 0
		arg_174_1.frameCnt_ = 0
		arg_174_1.state_ = "playing"
		arg_174_1.curTalkId_ = 1108409043
		arg_174_1.duration_ = 7

		SetActive(arg_174_1.tipsGo_, false)

		function arg_174_1.onSingleLineFinish_()
			arg_174_1.onSingleLineUpdate_ = nil
			arg_174_1.onSingleLineFinish_ = nil
			arg_174_1.state_ = "waiting"
		end

		function arg_174_1.playNext_(arg_176_0)
			if arg_176_0 == 1 then
				arg_174_0:Play1108409044(arg_174_1)
			end
		end

		function arg_174_1.onSingleLineUpdate_(arg_177_0)
			if arg_174_1.bgs_.ST28 == nil then
				local var_177_0 = Object.Instantiate(arg_174_1.paintGo_)

				var_177_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST28")
				var_177_0.name = "ST28"
				var_177_0.transform.parent = arg_174_1.stage_.transform
				var_177_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_174_1.bgs_.ST28 = var_177_0
			end

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 then
				local var_177_1 = arg_174_1.bgs_.ST28

				arg_174_1.bgs_.ST28.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_177_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_177_2 = var_177_1:GetComponent("SpriteRenderer")

				if var_177_2 and var_177_2.sprite then
					local var_177_3 = 2 * (var_177_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_177_1.transform.localScale = Vector3.New(var_177_3 / var_177_2.sprite.bounds.size.y < var_177_3 * manager.ui.mainCameraCom_.aspect / var_177_2.sprite.bounds.size.x and var_177_3 * manager.ui.mainCameraCom_.aspect / var_177_2.sprite.bounds.size.x or var_177_3 / var_177_2.sprite.bounds.size.y, var_177_3 / var_177_2.sprite.bounds.size.y < var_177_3 * manager.ui.mainCameraCom_.aspect / var_177_2.sprite.bounds.size.x and var_177_3 * manager.ui.mainCameraCom_.aspect / var_177_2.sprite.bounds.size.x or var_177_3 / var_177_2.sprite.bounds.size.y, 0)
				end

				for iter_177_0, iter_177_1 in pairs(arg_174_1.bgs_) do
					if iter_177_0 ~= "ST28" then
						iter_177_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_177_4 = 2

			if 2 < arg_174_1.time_ and arg_174_1.time_ <= var_177_4 + arg_177_0 then
				arg_174_1.allBtn_.enabled = false
			end

			if arg_174_1.time_ >= var_177_4 + 0.3 and arg_174_1.time_ < var_177_4 + 0.3 + arg_177_0 then
				arg_174_1.allBtn_.enabled = true
			end

			local var_177_5 = 0

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= var_177_5 + arg_177_0 then
				arg_174_1.mask_.enabled = true
				arg_174_1.mask_.raycastTarget = true

				arg_174_1:SetGaussion(false)
			end

			local var_177_6 = 2

			if var_177_5 <= arg_174_1.time_ and arg_174_1.time_ < var_177_5 + var_177_6 then
				local var_177_7 = Color.New(0, 0, 0)

				var_177_7.a = Mathf.Lerp(1, 0, (arg_174_1.time_ - var_177_5) / var_177_6)
				arg_174_1.mask_.color = var_177_7
			end

			if arg_174_1.time_ >= var_177_5 + var_177_6 and arg_174_1.time_ < var_177_5 + var_177_6 + arg_177_0 then
				local var_177_8 = Color.New(0, 0, 0)

				arg_174_1.mask_.enabled = false
				var_177_8.a = 0
				arg_174_1.mask_.color = var_177_8
			end

			if 1.2 < arg_174_1.time_ and arg_174_1.time_ <= 1.2 + arg_177_0 then
				arg_174_1:AudioAction("play", "effect", "se_story_side_1095", "se_story_side_1095_amb_fountain", "")
			end

			if 0.2 < arg_174_1.time_ and arg_174_1.time_ <= 0.2 + arg_177_0 then
				arg_174_1:AudioAction("stop", "effect", "se_story_142", "se_story_142_amb_commandroom", "")
			end

			if arg_174_1.frameCnt_ <= 1 then
				arg_174_1.dialog_:SetActive(false)
			end

			local var_177_11 = 2
			local var_177_12 = 0.325

			if 2 < arg_174_1.time_ and arg_174_1.time_ <= var_177_11 + arg_177_0 then
				arg_174_1.talkMaxDuration = 0

				arg_174_1.dialog_:SetActive(true)

				arg_174_1.dialogCg_.alpha = 0

				local var_177_13 = LeanTween.value(arg_174_1.dialog_, 0, 1, 0.3)

				var_177_13:setOnUpdate(LuaHelper.FloatAction(function(arg_178_0)
					arg_174_1.dialogCg_.alpha = arg_178_0
				end))
				var_177_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_174_1.dialog_)
					var_177_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_174_1.duration_ = arg_174_1.duration_ + 0.3

				SetActive(arg_174_1.leftNameGo_, true)

				arg_174_1.leftNameTxt_.text = arg_174_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_174_1.leftNameTxt_.transform)

				arg_174_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_174_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_174_1:RecordName(arg_174_1.leftNameTxt_.text)
				SetActive(arg_174_1.iconTrs_.gameObject, true)
				arg_174_1.iconController_:SetSelectedState("hero")

				arg_174_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_174_1.callingController_:SetSelectedState("normal")

				arg_174_1.keyicon_.color = Color.New(1, 1, 1)
				arg_174_1.icon_.color = Color.New(1, 1, 1)

				local var_177_14 = arg_174_1:FormatText(arg_174_1:GetWordFromCfg(1108409043).content)

				arg_174_1.text_.text = var_177_14

				LuaForUtil.ClearLinePrefixSymbol(arg_174_1.text_)

				local var_177_16 = 13 <= 0 and var_177_12 or var_177_12 * (utf8.len(var_177_14) / 13)

				if (13 <= 0 and var_177_12 or var_177_12 * (utf8.len(var_177_14) / 13)) > 0 and var_177_12 < var_177_16 then
					arg_174_1.talkMaxDuration = var_177_16
					var_177_11 = var_177_11 + 0.3

					if var_177_16 + var_177_11 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_16 + var_177_11
					end
				end

				arg_174_1.text_.text = var_177_14
				arg_174_1.typewritter.percent = 0

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(false)
				arg_174_1:RecordContent(arg_174_1.text_.text)
			end

			local var_177_17 = var_177_11 + 0.3
			local var_177_18 = math.max(var_177_12, arg_174_1.talkMaxDuration)

			if var_177_11 + 0.3 <= arg_174_1.time_ and arg_174_1.time_ < var_177_17 + var_177_18 then
				arg_174_1.typewritter.percent = (arg_174_1.time_ - var_177_17) / var_177_18

				arg_174_1.typewritter:SetDirty()
			end

			if arg_174_1.time_ >= var_177_17 + var_177_18 and arg_174_1.time_ < var_177_17 + var_177_18 + arg_177_0 then
				arg_174_1.typewritter.percent = 1

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(true)
			end
		end

		arg_174_1.nodeConfigList_ = {}

		arg_174_1:InitPlayNodeList()
	end,
	Play1108409044 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 1108409044
		arg_180_1.duration_ = 5

		SetActive(arg_180_1.tipsGo_, false)

		function arg_180_1.onSingleLineFinish_()
			arg_180_1.onSingleLineUpdate_ = nil
			arg_180_1.onSingleLineFinish_ = nil
			arg_180_1.state_ = "waiting"
		end

		function arg_180_1.playNext_(arg_182_0)
			if arg_182_0 == 1 then
				arg_180_0:Play1108409045(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			local var_183_0 = 0.775

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0
				arg_180_1.dialogCg_.alpha = 1

				arg_180_1.dialog_:SetActive(true)
				SetActive(arg_180_1.leftNameGo_, false)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_180_1.iconTrs_.gameObject, false)
				arg_180_1.callingController_:SetSelectedState("normal")

				local var_183_1 = arg_180_1:FormatText(arg_180_1:GetWordFromCfg(1108409044).content)

				arg_180_1.text_.text = var_183_1

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_3 = 31 <= 0 and var_183_0 or var_183_0 * (utf8.len(var_183_1) / 31)

				if (31 <= 0 and var_183_0 or var_183_0 * (utf8.len(var_183_1) / 31)) > 0 and var_183_0 < var_183_3 then
					arg_180_1.talkMaxDuration = var_183_3

					if var_183_3 + 0 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_3 + 0
					end
				end

				arg_180_1.text_.text = var_183_1
				arg_180_1.typewritter.percent = 0

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(false)
				arg_180_1:RecordContent(arg_180_1.text_.text)
			end

			local var_183_4 = math.max(var_183_0, arg_180_1.talkMaxDuration)

			if 0 <= arg_180_1.time_ and arg_180_1.time_ < 0 + var_183_4 then
				arg_180_1.typewritter.percent = (arg_180_1.time_ - 0) / var_183_4

				arg_180_1.typewritter:SetDirty()
			end

			if arg_180_1.time_ >= 0 + var_183_4 and arg_180_1.time_ < 0 + var_183_4 + arg_183_0 then
				arg_180_1.typewritter.percent = 1

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(true)
			end
		end

		arg_180_1.nodeConfigList_ = {}

		arg_180_1:InitPlayNodeList()
	end,
	Play1108409045 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 1108409045
		arg_184_1.duration_ = 5

		SetActive(arg_184_1.tipsGo_, false)

		function arg_184_1.onSingleLineFinish_()
			arg_184_1.onSingleLineUpdate_ = nil
			arg_184_1.onSingleLineFinish_ = nil
			arg_184_1.state_ = "waiting"
		end

		function arg_184_1.playNext_(arg_186_0)
			if arg_186_0 == 1 then
				arg_184_0:Play1108409046(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			local var_187_0 = 1.3

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0
				arg_184_1.dialogCg_.alpha = 1

				arg_184_1.dialog_:SetActive(true)
				SetActive(arg_184_1.leftNameGo_, true)

				arg_184_1.leftNameTxt_.text = arg_184_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_184_1.leftNameTxt_.transform)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1.leftNameTxt_.text)
				SetActive(arg_184_1.iconTrs_.gameObject, true)
				arg_184_1.iconController_:SetSelectedState("hero")

				arg_184_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_184_1.callingController_:SetSelectedState("normal")

				arg_184_1.keyicon_.color = Color.New(1, 1, 1)
				arg_184_1.icon_.color = Color.New(1, 1, 1)

				local var_187_1 = arg_184_1:FormatText(arg_184_1:GetWordFromCfg(1108409045).content)

				arg_184_1.text_.text = var_187_1

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_3 = 52 <= 0 and var_187_0 or var_187_0 * (utf8.len(var_187_1) / 52)

				if (52 <= 0 and var_187_0 or var_187_0 * (utf8.len(var_187_1) / 52)) > 0 and var_187_0 < var_187_3 then
					arg_184_1.talkMaxDuration = var_187_3

					if var_187_3 + 0 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_3 + 0
					end
				end

				arg_184_1.text_.text = var_187_1
				arg_184_1.typewritter.percent = 0

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(false)
				arg_184_1:RecordContent(arg_184_1.text_.text)
			end

			local var_187_4 = math.max(var_187_0, arg_184_1.talkMaxDuration)

			if 0 <= arg_184_1.time_ and arg_184_1.time_ < 0 + var_187_4 then
				arg_184_1.typewritter.percent = (arg_184_1.time_ - 0) / var_187_4

				arg_184_1.typewritter:SetDirty()
			end

			if arg_184_1.time_ >= 0 + var_187_4 and arg_184_1.time_ < 0 + var_187_4 + arg_187_0 then
				arg_184_1.typewritter.percent = 1

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(true)
			end
		end

		arg_184_1.nodeConfigList_ = {}

		arg_184_1:InitPlayNodeList()
	end,
	Play1108409046 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 1108409046
		arg_188_1.duration_ = 5.8

		SetActive(arg_188_1.tipsGo_, false)

		function arg_188_1.onSingleLineFinish_()
			arg_188_1.onSingleLineUpdate_ = nil
			arg_188_1.onSingleLineFinish_ = nil
			arg_188_1.state_ = "waiting"
		end

		function arg_188_1.playNext_(arg_190_0)
			if arg_190_0 == 1 then
				arg_188_0:Play1108409047(arg_188_1)
			end
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			if arg_188_1.bgs_.ST04a == nil then
				local var_191_0 = Object.Instantiate(arg_188_1.paintGo_)

				var_191_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST04a")
				var_191_0.name = "ST04a"
				var_191_0.transform.parent = arg_188_1.stage_.transform
				var_191_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_188_1.bgs_.ST04a = var_191_0
			end

			if 2.00000000298023 < arg_188_1.time_ and arg_188_1.time_ <= 2.00000000298023 + arg_191_0 then
				local var_191_1 = arg_188_1.bgs_.ST04a

				arg_188_1.bgs_.ST04a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_191_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_191_2 = var_191_1:GetComponent("SpriteRenderer")

				if var_191_2 and var_191_2.sprite then
					local var_191_3 = 2 * (var_191_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_191_1.transform.localScale = Vector3.New(var_191_3 / var_191_2.sprite.bounds.size.y < var_191_3 * manager.ui.mainCameraCom_.aspect / var_191_2.sprite.bounds.size.x and var_191_3 * manager.ui.mainCameraCom_.aspect / var_191_2.sprite.bounds.size.x or var_191_3 / var_191_2.sprite.bounds.size.y, var_191_3 / var_191_2.sprite.bounds.size.y < var_191_3 * manager.ui.mainCameraCom_.aspect / var_191_2.sprite.bounds.size.x and var_191_3 * manager.ui.mainCameraCom_.aspect / var_191_2.sprite.bounds.size.x or var_191_3 / var_191_2.sprite.bounds.size.y, 0)
				end

				for iter_191_0, iter_191_1 in pairs(arg_188_1.bgs_) do
					if iter_191_0 ~= "ST04a" then
						iter_191_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_191_4 = 4.00000000298023

			if 4.00000000298023 < arg_188_1.time_ and arg_188_1.time_ <= var_191_4 + arg_191_0 then
				arg_188_1.allBtn_.enabled = false
			end

			if arg_188_1.time_ >= var_191_4 + 0.3 and arg_188_1.time_ < var_191_4 + 0.3 + arg_191_0 then
				arg_188_1.allBtn_.enabled = true
			end

			local var_191_5 = 0

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= var_191_5 + arg_191_0 then
				arg_188_1.mask_.enabled = true
				arg_188_1.mask_.raycastTarget = true

				arg_188_1:SetGaussion(false)
			end

			local var_191_6 = 2

			if var_191_5 <= arg_188_1.time_ and arg_188_1.time_ < var_191_5 + var_191_6 then
				local var_191_7 = Color.New(0, 0, 0)

				var_191_7.a = Mathf.Lerp(0, 1, (arg_188_1.time_ - var_191_5) / var_191_6)
				arg_188_1.mask_.color = var_191_7
			end

			if arg_188_1.time_ >= var_191_5 + var_191_6 and arg_188_1.time_ < var_191_5 + var_191_6 + arg_191_0 then
				local var_191_8 = Color.New(0, 0, 0)

				var_191_8.a = 1
				arg_188_1.mask_.color = var_191_8
			end

			local var_191_9 = 2

			if 2 < arg_188_1.time_ and arg_188_1.time_ <= var_191_9 + arg_191_0 then
				arg_188_1.mask_.enabled = true
				arg_188_1.mask_.raycastTarget = true

				arg_188_1:SetGaussion(false)
			end

			local var_191_10 = 2

			if var_191_9 <= arg_188_1.time_ and arg_188_1.time_ < var_191_9 + var_191_10 then
				local var_191_11 = Color.New(0, 0, 0)

				var_191_11.a = Mathf.Lerp(1, 0, (arg_188_1.time_ - var_191_9) / var_191_10)
				arg_188_1.mask_.color = var_191_11
			end

			if arg_188_1.time_ >= var_191_9 + var_191_10 and arg_188_1.time_ < var_191_9 + var_191_10 + arg_191_0 then
				local var_191_12 = Color.New(0, 0, 0)

				arg_188_1.mask_.enabled = false
				var_191_12.a = 0
				arg_188_1.mask_.color = var_191_12
			end

			local var_191_13 = arg_188_1.actors_["1084ui_story"].transform

			if 3.8 < arg_188_1.time_ and arg_188_1.time_ <= 3.8 + arg_191_0 then
				arg_188_1.var_.moveOldPos1084ui_story = var_191_13.localPosition
			end

			local var_191_14 = 0.001

			if 3.8 <= arg_188_1.time_ and arg_188_1.time_ < 3.8 + var_191_14 then
				var_191_13.localPosition = Vector3.Lerp(arg_188_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_188_1.time_ - 3.8) / var_191_14)
				var_191_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_191_13.position).x, (manager.ui.mainCamera.transform.position - var_191_13.position).y, (manager.ui.mainCamera.transform.position - var_191_13.position).z)
				var_191_13.localEulerAngles.z = 0
				var_191_13.localEulerAngles.x = 0
				var_191_13.localEulerAngles = var_191_13.localEulerAngles
			end

			if arg_188_1.time_ >= 3.8 + var_191_14 and arg_188_1.time_ < 3.8 + var_191_14 + arg_191_0 then
				var_191_13.localPosition = Vector3.New(0, -0.97, -6)
				var_191_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_191_13.position).x, (manager.ui.mainCamera.transform.position - var_191_13.position).y, (manager.ui.mainCamera.transform.position - var_191_13.position).z)
				var_191_13.localEulerAngles.z = 0
				var_191_13.localEulerAngles.x = 0
				var_191_13.localEulerAngles = var_191_13.localEulerAngles
			end

			local var_191_15 = arg_188_1.actors_["1084ui_story"]

			if 3.8 < arg_188_1.time_ and arg_188_1.time_ <= 3.8 + arg_191_0 and not isNil(var_191_15) and arg_188_1.var_.characterEffect1084ui_story == nil then
				arg_188_1.var_.characterEffect1084ui_story = var_191_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_191_16 = 0.200000002980232

			if 3.8 <= arg_188_1.time_ and arg_188_1.time_ < 3.8 + var_191_16 and not isNil(var_191_15) then
				if arg_188_1.var_.characterEffect1084ui_story and not isNil(var_191_15) then
					arg_188_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_188_1.time_ >= 3.8 + var_191_16 and arg_188_1.time_ < 3.8 + var_191_16 + arg_191_0 and not isNil(var_191_15) and arg_188_1.var_.characterEffect1084ui_story then
				arg_188_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 3.8 < arg_188_1.time_ and arg_188_1.time_ <= 3.8 + arg_191_0 then
				arg_188_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action4_1")
			end

			if 3.8 < arg_188_1.time_ and arg_188_1.time_ <= 3.8 + arg_191_0 then
				arg_188_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if 1 < arg_188_1.time_ and arg_188_1.time_ <= 1 + arg_191_0 then
				arg_188_1:AudioAction("play", "music", "bgm_side_daily01", "bgm_side_daily01", "bgm_side_daily01.awb")

				local var_191_20 = manager.audio:GetAudioName("bgm_side_daily01", "bgm_side_daily01")

				if "" ~= "" then
					if arg_188_1.bgmTxt_.text ~= var_191_20 and arg_188_1.bgmTxt_.text ~= "" then
						if arg_188_1.bgmTxt2_.text ~= "" then
							arg_188_1.bgmTxt_.text = arg_188_1.bgmTxt2_.text
						end

						arg_188_1.bgmTxt2_.text = var_191_20

						arg_188_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_188_1.bgmTxt_.text = var_191_20
						arg_188_1.bgmTxt2_.text = var_191_20
					end

					if arg_188_1.bgmTimer then
						arg_188_1.bgmTimer:Stop()

						arg_188_1.bgmTimer = nil
					end

					if arg_188_1.settingData.show_music_name == 1 then
						arg_188_1.musicController:SetSelectedState("show")
						arg_188_1.musicAnimator_:Play("open", 0, 0)

						if arg_188_1.settingData.music_time ~= 0 then
							arg_188_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_188_1.settingData.music_time), function()
								if arg_188_1 == nil or isNil(arg_188_1.bgmTxt_) then
									return
								end

								arg_188_1.musicController:SetSelectedState("hide")
								arg_188_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 1.2 < arg_188_1.time_ and arg_188_1.time_ <= 1.2 + arg_191_0 then
				arg_188_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_wind", "")
			end

			if 0.2 < arg_188_1.time_ and arg_188_1.time_ <= 0.2 + arg_191_0 then
				arg_188_1:AudioAction("stop", "effect", "se_story_side_1095", "se_story_side_1095_amb_fountain", "")
			end

			if arg_188_1.frameCnt_ <= 1 then
				arg_188_1.dialog_:SetActive(false)
			end

			local var_191_23 = 4.00000000298023
			local var_191_24 = 0.1

			if 4.00000000298023 < arg_188_1.time_ and arg_188_1.time_ <= var_191_23 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0

				arg_188_1.dialog_:SetActive(true)

				arg_188_1.dialogCg_.alpha = 0

				local var_191_25 = LeanTween.value(arg_188_1.dialog_, 0, 1, 0.3)

				var_191_25:setOnUpdate(LuaHelper.FloatAction(function(arg_193_0)
					arg_188_1.dialogCg_.alpha = arg_193_0
				end))
				var_191_25:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_188_1.dialog_)
					var_191_25:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_188_1.duration_ = arg_188_1.duration_ + 0.3

				SetActive(arg_188_1.leftNameGo_, true)

				arg_188_1.leftNameTxt_.text = arg_188_1:FormatText(StoryNameCfg[334].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_188_1.leftNameTxt_.transform)

				arg_188_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_188_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_188_1:RecordName(arg_188_1.leftNameTxt_.text)
				SetActive(arg_188_1.iconTrs_.gameObject, false)
				arg_188_1.callingController_:SetSelectedState("normal")

				local var_191_26 = arg_188_1:GetWordFromCfg(1108409046)
				local var_191_27 = arg_188_1:FormatText(var_191_26.content)

				arg_188_1.text_.text = var_191_27

				LuaForUtil.ClearLinePrefixSymbol(arg_188_1.text_)

				local var_191_29 = 4 <= 0 and var_191_24 or var_191_24 * (utf8.len(var_191_27) / 4)

				if (4 <= 0 and var_191_24 or var_191_24 * (utf8.len(var_191_27) / 4)) > 0 and var_191_24 < var_191_29 then
					arg_188_1.talkMaxDuration = var_191_29
					var_191_23 = var_191_23 + 0.3

					if var_191_29 + var_191_23 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_29 + var_191_23
					end
				end

				arg_188_1.text_.text = var_191_27
				arg_188_1.typewritter.percent = 0

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409046", "story_v_side_new_1108409.awb") ~= 0 then
					local var_191_30 = manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409046", "story_v_side_new_1108409.awb") / 1000

					if var_191_30 + var_191_23 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_30 + var_191_23
					end

					if var_191_26.prefab_name ~= "" and arg_188_1.actors_[var_191_26.prefab_name] ~= nil then
						local var_191_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_188_1.actors_[var_191_26.prefab_name].transform, "story_v_side_new_1108409", "1108409046", "story_v_side_new_1108409.awb")

						arg_188_1:RecordAudio("1108409046", var_191_31)
						arg_188_1:RecordAudio("1108409046", var_191_31)
					else
						arg_188_1:AudioAction("play", "voice", "story_v_side_new_1108409", "1108409046", "story_v_side_new_1108409.awb")
					end

					arg_188_1:RecordHistoryTalkVoice("story_v_side_new_1108409", "1108409046", "story_v_side_new_1108409.awb")
				end

				arg_188_1:RecordContent(arg_188_1.text_.text)
			end

			local var_191_32 = var_191_23 + 0.3
			local var_191_33 = math.max(var_191_24, arg_188_1.talkMaxDuration)

			if var_191_23 + 0.3 <= arg_188_1.time_ and arg_188_1.time_ < var_191_32 + var_191_33 then
				arg_188_1.typewritter.percent = (arg_188_1.time_ - var_191_32) / var_191_33

				arg_188_1.typewritter:SetDirty()
			end

			if arg_188_1.time_ >= var_191_32 + var_191_33 and arg_188_1.time_ < var_191_32 + var_191_33 + arg_191_0 then
				arg_188_1.typewritter.percent = 1

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(true)
			end
		end

		arg_188_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_188_1:InitPlayNodeList()
	end,
	Play1108409047 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 1108409047
		arg_195_1.duration_ = 2.1

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play1108409048(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action4_2")
			end

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_198_0 = 0
			local var_198_1 = 0.225

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= var_198_0 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				arg_195_1.leftNameTxt_.text = arg_195_1:FormatText(StoryNameCfg[334].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_2 = arg_195_1:GetWordFromCfg(1108409047)
				local var_198_3 = arg_195_1:FormatText(var_198_2.content)

				arg_195_1.text_.text = var_198_3

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_5 = 9 <= 0 and var_198_1 or var_198_1 * (utf8.len(var_198_3) / 9)

				if (9 <= 0 and var_198_1 or var_198_1 * (utf8.len(var_198_3) / 9)) > 0 and var_198_1 < var_198_5 then
					arg_195_1.talkMaxDuration = var_198_5

					if var_198_5 + var_198_0 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_5 + var_198_0
					end
				end

				arg_195_1.text_.text = var_198_3
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409047", "story_v_side_new_1108409.awb") ~= 0 then
					local var_198_6 = manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409047", "story_v_side_new_1108409.awb") / 1000

					if var_198_6 + var_198_0 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_6 + var_198_0
					end

					if var_198_2.prefab_name ~= "" and arg_195_1.actors_[var_198_2.prefab_name] ~= nil then
						local var_198_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_2.prefab_name].transform, "story_v_side_new_1108409", "1108409047", "story_v_side_new_1108409.awb")

						arg_195_1:RecordAudio("1108409047", var_198_7)
						arg_195_1:RecordAudio("1108409047", var_198_7)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_side_new_1108409", "1108409047", "story_v_side_new_1108409.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_side_new_1108409", "1108409047", "story_v_side_new_1108409.awb")
				end

				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_8 = math.max(var_198_1, arg_195_1.talkMaxDuration)

			if var_198_0 <= arg_195_1.time_ and arg_195_1.time_ < var_198_0 + var_198_8 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_0) / var_198_8

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_0 + var_198_8 and arg_195_1.time_ < var_198_0 + var_198_8 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {}

		arg_195_1:InitPlayNodeList()
	end,
	Play1108409048 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 1108409048
		arg_199_1.duration_ = 1

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"

			SetActive(arg_199_1.choicesGo_, true)

			for iter_200_0, iter_200_1 in ipairs(arg_199_1.choices_) do
				SetActive(iter_200_1.go, iter_200_0 <= 1)
			end

			arg_199_1.choices_[1].txt.text = arg_199_1:FormatText(StoryChoiceCfg[1696].name)
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play1108409049(arg_199_1)
			end

			arg_199_1:RecordChoiceLog(1108409048, 1696)
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 and not isNil(arg_199_1.actors_["1084ui_story"]) and arg_199_1.var_.characterEffect1084ui_story == nil then
				arg_199_1.var_.characterEffect1084ui_story = arg_199_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_202_0 = 0.200000002980232

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_0 and not isNil(arg_199_1.actors_["1084ui_story"]) then
				if arg_199_1.var_.characterEffect1084ui_story and not isNil(arg_199_1.actors_["1084ui_story"]) then
					arg_199_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_199_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_199_1.time_ - 0) / var_202_0)
				end
			end

			if arg_199_1.time_ >= 0 + var_202_0 and arg_199_1.time_ < 0 + var_202_0 + arg_202_0 and not isNil(arg_199_1.actors_["1084ui_story"]) and arg_199_1.var_.characterEffect1084ui_story then
				arg_199_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_199_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_202_1 = 0

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= var_202_1 + arg_202_0 then
				arg_199_1.allBtn_.enabled = false
			end

			if arg_199_1.time_ >= var_202_1 + 0.666666666666667 and arg_199_1.time_ < var_202_1 + 0.666666666666667 + arg_202_0 then
				arg_199_1.allBtn_.enabled = true
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	Play1108409049 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 1108409049
		arg_203_1.duration_ = 3.03

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play1108409050(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 and not isNil(arg_203_1.actors_["1084ui_story"]) and arg_203_1.var_.characterEffect1084ui_story == nil then
				arg_203_1.var_.characterEffect1084ui_story = arg_203_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_0 = 0.200000002980232

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_0 and not isNil(arg_203_1.actors_["1084ui_story"]) then
				if arg_203_1.var_.characterEffect1084ui_story and not isNil(arg_203_1.actors_["1084ui_story"]) then
					arg_203_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_203_1.time_ >= 0 + var_206_0 and arg_203_1.time_ < 0 + var_206_0 + arg_206_0 and not isNil(arg_203_1.actors_["1084ui_story"]) and arg_203_1.var_.characterEffect1084ui_story then
				arg_203_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_1")
			end

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_206_2 = 0
			local var_206_3 = 0.35

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_2 + arg_206_0 then
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

				local var_206_4 = arg_203_1:GetWordFromCfg(1108409049)
				local var_206_5 = arg_203_1:FormatText(var_206_4.content)

				arg_203_1.text_.text = var_206_5

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_7 = 14 <= 0 and var_206_3 or var_206_3 * (utf8.len(var_206_5) / 14)

				if (14 <= 0 and var_206_3 or var_206_3 * (utf8.len(var_206_5) / 14)) > 0 and var_206_3 < var_206_7 then
					arg_203_1.talkMaxDuration = var_206_7

					if var_206_7 + var_206_2 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_7 + var_206_2
					end
				end

				arg_203_1.text_.text = var_206_5
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409049", "story_v_side_new_1108409.awb") ~= 0 then
					local var_206_8 = manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409049", "story_v_side_new_1108409.awb") / 1000

					if var_206_8 + var_206_2 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_8 + var_206_2
					end

					if var_206_4.prefab_name ~= "" and arg_203_1.actors_[var_206_4.prefab_name] ~= nil then
						local var_206_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_4.prefab_name].transform, "story_v_side_new_1108409", "1108409049", "story_v_side_new_1108409.awb")

						arg_203_1:RecordAudio("1108409049", var_206_9)
						arg_203_1:RecordAudio("1108409049", var_206_9)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_side_new_1108409", "1108409049", "story_v_side_new_1108409.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_side_new_1108409", "1108409049", "story_v_side_new_1108409.awb")
				end

				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_10 = math.max(var_206_3, arg_203_1.talkMaxDuration)

			if var_206_2 <= arg_203_1.time_ and arg_203_1.time_ < var_206_2 + var_206_10 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_2) / var_206_10

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_2 + var_206_10 and arg_203_1.time_ < var_206_2 + var_206_10 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {}

		arg_203_1:InitPlayNodeList()
	end,
	Play1108409050 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 1108409050
		arg_207_1.duration_ = 2

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play1108409051(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_2")
			end

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_210_0 = 0
			local var_210_1 = 0.175

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= var_210_0 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				arg_207_1.leftNameTxt_.text = arg_207_1:FormatText(StoryNameCfg[334].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_2 = arg_207_1:GetWordFromCfg(1108409050)
				local var_210_3 = arg_207_1:FormatText(var_210_2.content)

				arg_207_1.text_.text = var_210_3

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_5 = 7 <= 0 and var_210_1 or var_210_1 * (utf8.len(var_210_3) / 7)

				if (7 <= 0 and var_210_1 or var_210_1 * (utf8.len(var_210_3) / 7)) > 0 and var_210_1 < var_210_5 then
					arg_207_1.talkMaxDuration = var_210_5

					if var_210_5 + var_210_0 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_5 + var_210_0
					end
				end

				arg_207_1.text_.text = var_210_3
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409050", "story_v_side_new_1108409.awb") ~= 0 then
					local var_210_6 = manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409050", "story_v_side_new_1108409.awb") / 1000

					if var_210_6 + var_210_0 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_6 + var_210_0
					end

					if var_210_2.prefab_name ~= "" and arg_207_1.actors_[var_210_2.prefab_name] ~= nil then
						local var_210_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_207_1.actors_[var_210_2.prefab_name].transform, "story_v_side_new_1108409", "1108409050", "story_v_side_new_1108409.awb")

						arg_207_1:RecordAudio("1108409050", var_210_7)
						arg_207_1:RecordAudio("1108409050", var_210_7)
					else
						arg_207_1:AudioAction("play", "voice", "story_v_side_new_1108409", "1108409050", "story_v_side_new_1108409.awb")
					end

					arg_207_1:RecordHistoryTalkVoice("story_v_side_new_1108409", "1108409050", "story_v_side_new_1108409.awb")
				end

				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_8 = math.max(var_210_1, arg_207_1.talkMaxDuration)

			if var_210_0 <= arg_207_1.time_ and arg_207_1.time_ < var_210_0 + var_210_8 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_0) / var_210_8

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_0 + var_210_8 and arg_207_1.time_ < var_210_0 + var_210_8 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {}

		arg_207_1:InitPlayNodeList()
	end,
	Play1108409051 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 1108409051
		arg_211_1.duration_ = 2

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play1108409052(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action12_1")
			end

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva", "EmotionTimelineAnimator")
			end

			local var_214_0 = 0
			local var_214_1 = 0.2

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= var_214_0 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, true)

				arg_211_1.leftNameTxt_.text = arg_211_1:FormatText(StoryNameCfg[334].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_2 = arg_211_1:GetWordFromCfg(1108409051)
				local var_214_3 = arg_211_1:FormatText(var_214_2.content)

				arg_211_1.text_.text = var_214_3

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_5 = 8 <= 0 and var_214_1 or var_214_1 * (utf8.len(var_214_3) / 8)

				if (8 <= 0 and var_214_1 or var_214_1 * (utf8.len(var_214_3) / 8)) > 0 and var_214_1 < var_214_5 then
					arg_211_1.talkMaxDuration = var_214_5

					if var_214_5 + var_214_0 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_5 + var_214_0
					end
				end

				arg_211_1.text_.text = var_214_3
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409051", "story_v_side_new_1108409.awb") ~= 0 then
					local var_214_6 = manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409051", "story_v_side_new_1108409.awb") / 1000

					if var_214_6 + var_214_0 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_6 + var_214_0
					end

					if var_214_2.prefab_name ~= "" and arg_211_1.actors_[var_214_2.prefab_name] ~= nil then
						local var_214_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_211_1.actors_[var_214_2.prefab_name].transform, "story_v_side_new_1108409", "1108409051", "story_v_side_new_1108409.awb")

						arg_211_1:RecordAudio("1108409051", var_214_7)
						arg_211_1:RecordAudio("1108409051", var_214_7)
					else
						arg_211_1:AudioAction("play", "voice", "story_v_side_new_1108409", "1108409051", "story_v_side_new_1108409.awb")
					end

					arg_211_1:RecordHistoryTalkVoice("story_v_side_new_1108409", "1108409051", "story_v_side_new_1108409.awb")
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
	Play1108409052 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 1108409052
		arg_215_1.duration_ = 4.23

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play1108409053(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action12_2")
			end

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_218_0 = 0
			local var_218_1 = 0.625

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= var_218_0 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				arg_215_1.leftNameTxt_.text = arg_215_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_2 = arg_215_1:GetWordFromCfg(1108409052)
				local var_218_3 = arg_215_1:FormatText(var_218_2.content)

				arg_215_1.text_.text = var_218_3

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_5 = 25 <= 0 and var_218_1 or var_218_1 * (utf8.len(var_218_3) / 25)

				if (25 <= 0 and var_218_1 or var_218_1 * (utf8.len(var_218_3) / 25)) > 0 and var_218_1 < var_218_5 then
					arg_215_1.talkMaxDuration = var_218_5

					if var_218_5 + var_218_0 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_5 + var_218_0
					end
				end

				arg_215_1.text_.text = var_218_3
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409052", "story_v_side_new_1108409.awb") ~= 0 then
					local var_218_6 = manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409052", "story_v_side_new_1108409.awb") / 1000

					if var_218_6 + var_218_0 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_6 + var_218_0
					end

					if var_218_2.prefab_name ~= "" and arg_215_1.actors_[var_218_2.prefab_name] ~= nil then
						local var_218_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_215_1.actors_[var_218_2.prefab_name].transform, "story_v_side_new_1108409", "1108409052", "story_v_side_new_1108409.awb")

						arg_215_1:RecordAudio("1108409052", var_218_7)
						arg_215_1:RecordAudio("1108409052", var_218_7)
					else
						arg_215_1:AudioAction("play", "voice", "story_v_side_new_1108409", "1108409052", "story_v_side_new_1108409.awb")
					end

					arg_215_1:RecordHistoryTalkVoice("story_v_side_new_1108409", "1108409052", "story_v_side_new_1108409.awb")
				end

				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_8 = math.max(var_218_1, arg_215_1.talkMaxDuration)

			if var_218_0 <= arg_215_1.time_ and arg_215_1.time_ < var_218_0 + var_218_8 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_0) / var_218_8

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_0 + var_218_8 and arg_215_1.time_ < var_218_0 + var_218_8 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {}

		arg_215_1:InitPlayNodeList()
	end,
	Play1108409053 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 1108409053
		arg_219_1.duration_ = 5

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play1108409054(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 and not isNil(arg_219_1.actors_["1084ui_story"]) and arg_219_1.var_.characterEffect1084ui_story == nil then
				arg_219_1.var_.characterEffect1084ui_story = arg_219_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_222_0 = 0.200000002980232

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_0 and not isNil(arg_219_1.actors_["1084ui_story"]) then
				if arg_219_1.var_.characterEffect1084ui_story and not isNil(arg_219_1.actors_["1084ui_story"]) then
					arg_219_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_219_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_219_1.time_ - 0) / var_222_0)
				end
			end

			if arg_219_1.time_ >= 0 + var_222_0 and arg_219_1.time_ < 0 + var_222_0 + arg_222_0 and not isNil(arg_219_1.actors_["1084ui_story"]) and arg_219_1.var_.characterEffect1084ui_story then
				arg_219_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_219_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_222_1 = 0
			local var_222_2 = 0.825

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_1 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				arg_219_1.leftNameTxt_.text = arg_219_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, true)
				arg_219_1.iconController_:SetSelectedState("hero")

				arg_219_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_219_1.callingController_:SetSelectedState("normal")

				arg_219_1.keyicon_.color = Color.New(1, 1, 1)
				arg_219_1.icon_.color = Color.New(1, 1, 1)

				local var_222_3 = arg_219_1:FormatText(arg_219_1:GetWordFromCfg(1108409053).content)

				arg_219_1.text_.text = var_222_3

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_5 = 33 <= 0 and var_222_2 or var_222_2 * (utf8.len(var_222_3) / 33)

				if (33 <= 0 and var_222_2 or var_222_2 * (utf8.len(var_222_3) / 33)) > 0 and var_222_2 < var_222_5 then
					arg_219_1.talkMaxDuration = var_222_5

					if var_222_5 + var_222_1 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_5 + var_222_1
					end
				end

				arg_219_1.text_.text = var_222_3
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)
				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_6 = math.max(var_222_2, arg_219_1.talkMaxDuration)

			if var_222_1 <= arg_219_1.time_ and arg_219_1.time_ < var_222_1 + var_222_6 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_1) / var_222_6

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_1 + var_222_6 and arg_219_1.time_ < var_222_1 + var_222_6 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {}

		arg_219_1:InitPlayNodeList()
	end,
	Play1108409054 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 1108409054
		arg_223_1.duration_ = 3.63

		SetActive(arg_223_1.tipsGo_, false)

		function arg_223_1.onSingleLineFinish_()
			arg_223_1.onSingleLineUpdate_ = nil
			arg_223_1.onSingleLineFinish_ = nil
			arg_223_1.state_ = "waiting"
		end

		function arg_223_1.playNext_(arg_225_0)
			if arg_225_0 == 1 then
				arg_223_0:Play1108409055(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 and not isNil(arg_223_1.actors_["1084ui_story"]) and arg_223_1.var_.characterEffect1084ui_story == nil then
				arg_223_1.var_.characterEffect1084ui_story = arg_223_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_226_0 = 0.200000002980232

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_0 and not isNil(arg_223_1.actors_["1084ui_story"]) then
				if arg_223_1.var_.characterEffect1084ui_story and not isNil(arg_223_1.actors_["1084ui_story"]) then
					arg_223_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_223_1.time_ >= 0 + var_226_0 and arg_223_1.time_ < 0 + var_226_0 + arg_226_0 and not isNil(arg_223_1.actors_["1084ui_story"]) and arg_223_1.var_.characterEffect1084ui_story then
				arg_223_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action8_1")
			end

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_226_2 = 0
			local var_226_3 = 0.4

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= var_226_2 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				arg_223_1.leftNameTxt_.text = arg_223_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_4 = arg_223_1:GetWordFromCfg(1108409054)
				local var_226_5 = arg_223_1:FormatText(var_226_4.content)

				arg_223_1.text_.text = var_226_5

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_7 = 16 <= 0 and var_226_3 or var_226_3 * (utf8.len(var_226_5) / 16)

				if (16 <= 0 and var_226_3 or var_226_3 * (utf8.len(var_226_5) / 16)) > 0 and var_226_3 < var_226_7 then
					arg_223_1.talkMaxDuration = var_226_7

					if var_226_7 + var_226_2 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_7 + var_226_2
					end
				end

				arg_223_1.text_.text = var_226_5
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409054", "story_v_side_new_1108409.awb") ~= 0 then
					local var_226_8 = manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409054", "story_v_side_new_1108409.awb") / 1000

					if var_226_8 + var_226_2 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_8 + var_226_2
					end

					if var_226_4.prefab_name ~= "" and arg_223_1.actors_[var_226_4.prefab_name] ~= nil then
						local var_226_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_223_1.actors_[var_226_4.prefab_name].transform, "story_v_side_new_1108409", "1108409054", "story_v_side_new_1108409.awb")

						arg_223_1:RecordAudio("1108409054", var_226_9)
						arg_223_1:RecordAudio("1108409054", var_226_9)
					else
						arg_223_1:AudioAction("play", "voice", "story_v_side_new_1108409", "1108409054", "story_v_side_new_1108409.awb")
					end

					arg_223_1:RecordHistoryTalkVoice("story_v_side_new_1108409", "1108409054", "story_v_side_new_1108409.awb")
				end

				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_10 = math.max(var_226_3, arg_223_1.talkMaxDuration)

			if var_226_2 <= arg_223_1.time_ and arg_223_1.time_ < var_226_2 + var_226_10 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_2) / var_226_10

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_2 + var_226_10 and arg_223_1.time_ < var_226_2 + var_226_10 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {}

		arg_223_1:InitPlayNodeList()
	end,
	Play1108409055 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 1108409055
		arg_227_1.duration_ = 5

		SetActive(arg_227_1.tipsGo_, false)

		function arg_227_1.onSingleLineFinish_()
			arg_227_1.onSingleLineUpdate_ = nil
			arg_227_1.onSingleLineFinish_ = nil
			arg_227_1.state_ = "waiting"
		end

		function arg_227_1.playNext_(arg_229_0)
			if arg_229_0 == 1 then
				arg_227_0:Play1108409056(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 and not isNil(arg_227_1.actors_["1084ui_story"]) and arg_227_1.var_.characterEffect1084ui_story == nil then
				arg_227_1.var_.characterEffect1084ui_story = arg_227_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_230_0 = 0.200000002980232

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_0 and not isNil(arg_227_1.actors_["1084ui_story"]) then
				if arg_227_1.var_.characterEffect1084ui_story and not isNil(arg_227_1.actors_["1084ui_story"]) then
					arg_227_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_227_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_227_1.time_ - 0) / var_230_0)
				end
			end

			if arg_227_1.time_ >= 0 + var_230_0 and arg_227_1.time_ < 0 + var_230_0 + arg_230_0 and not isNil(arg_227_1.actors_["1084ui_story"]) and arg_227_1.var_.characterEffect1084ui_story then
				arg_227_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_227_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_230_1 = 0
			local var_230_2 = 0.3

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= var_230_1 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				arg_227_1.leftNameTxt_.text = arg_227_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, true)
				arg_227_1.iconController_:SetSelectedState("hero")

				arg_227_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_227_1.callingController_:SetSelectedState("normal")

				arg_227_1.keyicon_.color = Color.New(1, 1, 1)
				arg_227_1.icon_.color = Color.New(1, 1, 1)

				local var_230_3 = arg_227_1:FormatText(arg_227_1:GetWordFromCfg(1108409055).content)

				arg_227_1.text_.text = var_230_3

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_5 = 12 <= 0 and var_230_2 or var_230_2 * (utf8.len(var_230_3) / 12)

				if (12 <= 0 and var_230_2 or var_230_2 * (utf8.len(var_230_3) / 12)) > 0 and var_230_2 < var_230_5 then
					arg_227_1.talkMaxDuration = var_230_5

					if var_230_5 + var_230_1 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_5 + var_230_1
					end
				end

				arg_227_1.text_.text = var_230_3
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)
				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_6 = math.max(var_230_2, arg_227_1.talkMaxDuration)

			if var_230_1 <= arg_227_1.time_ and arg_227_1.time_ < var_230_1 + var_230_6 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_1) / var_230_6

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_1 + var_230_6 and arg_227_1.time_ < var_230_1 + var_230_6 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {}

		arg_227_1:InitPlayNodeList()
	end,
	Play1108409056 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 1108409056
		arg_231_1.duration_ = 9.5

		SetActive(arg_231_1.tipsGo_, false)

		function arg_231_1.onSingleLineFinish_()
			arg_231_1.onSingleLineUpdate_ = nil
			arg_231_1.onSingleLineFinish_ = nil
			arg_231_1.state_ = "waiting"
		end

		function arg_231_1.playNext_(arg_233_0)
			if arg_233_0 == 1 then
				arg_231_0:Play1108409057(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 and not isNil(arg_231_1.actors_["1084ui_story"]) and arg_231_1.var_.characterEffect1084ui_story == nil then
				arg_231_1.var_.characterEffect1084ui_story = arg_231_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_234_0 = 0.200000002980232

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_0 and not isNil(arg_231_1.actors_["1084ui_story"]) then
				if arg_231_1.var_.characterEffect1084ui_story and not isNil(arg_231_1.actors_["1084ui_story"]) then
					arg_231_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_231_1.time_ >= 0 + var_234_0 and arg_231_1.time_ < 0 + var_234_0 + arg_234_0 and not isNil(arg_231_1.actors_["1084ui_story"]) and arg_231_1.var_.characterEffect1084ui_story then
				arg_231_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action4812")
			end

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_234_2 = 0
			local var_234_3 = 1.375

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= var_234_2 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				arg_231_1.leftNameTxt_.text = arg_231_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_4 = arg_231_1:GetWordFromCfg(1108409056)
				local var_234_5 = arg_231_1:FormatText(var_234_4.content)

				arg_231_1.text_.text = var_234_5

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_7 = 54 <= 0 and var_234_3 or var_234_3 * (utf8.len(var_234_5) / 54)

				if (54 <= 0 and var_234_3 or var_234_3 * (utf8.len(var_234_5) / 54)) > 0 and var_234_3 < var_234_7 then
					arg_231_1.talkMaxDuration = var_234_7

					if var_234_7 + var_234_2 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_7 + var_234_2
					end
				end

				arg_231_1.text_.text = var_234_5
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409056", "story_v_side_new_1108409.awb") ~= 0 then
					local var_234_8 = manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409056", "story_v_side_new_1108409.awb") / 1000

					if var_234_8 + var_234_2 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_8 + var_234_2
					end

					if var_234_4.prefab_name ~= "" and arg_231_1.actors_[var_234_4.prefab_name] ~= nil then
						local var_234_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_231_1.actors_[var_234_4.prefab_name].transform, "story_v_side_new_1108409", "1108409056", "story_v_side_new_1108409.awb")

						arg_231_1:RecordAudio("1108409056", var_234_9)
						arg_231_1:RecordAudio("1108409056", var_234_9)
					else
						arg_231_1:AudioAction("play", "voice", "story_v_side_new_1108409", "1108409056", "story_v_side_new_1108409.awb")
					end

					arg_231_1:RecordHistoryTalkVoice("story_v_side_new_1108409", "1108409056", "story_v_side_new_1108409.awb")
				end

				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_10 = math.max(var_234_3, arg_231_1.talkMaxDuration)

			if var_234_2 <= arg_231_1.time_ and arg_231_1.time_ < var_234_2 + var_234_10 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_2) / var_234_10

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_2 + var_234_10 and arg_231_1.time_ < var_234_2 + var_234_10 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {}

		arg_231_1:InitPlayNodeList()
	end,
	Play1108409057 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 1108409057
		arg_235_1.duration_ = 5

		SetActive(arg_235_1.tipsGo_, false)

		function arg_235_1.onSingleLineFinish_()
			arg_235_1.onSingleLineUpdate_ = nil
			arg_235_1.onSingleLineFinish_ = nil
			arg_235_1.state_ = "waiting"
		end

		function arg_235_1.playNext_(arg_237_0)
			if arg_237_0 == 1 then
				arg_235_0:Play1108409058(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 and not isNil(arg_235_1.actors_["1084ui_story"]) and arg_235_1.var_.characterEffect1084ui_story == nil then
				arg_235_1.var_.characterEffect1084ui_story = arg_235_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_238_0 = 0.200000002980232

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_0 and not isNil(arg_235_1.actors_["1084ui_story"]) then
				if arg_235_1.var_.characterEffect1084ui_story and not isNil(arg_235_1.actors_["1084ui_story"]) then
					arg_235_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_235_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_235_1.time_ - 0) / var_238_0)
				end
			end

			if arg_235_1.time_ >= 0 + var_238_0 and arg_235_1.time_ < 0 + var_238_0 + arg_238_0 and not isNil(arg_235_1.actors_["1084ui_story"]) and arg_235_1.var_.characterEffect1084ui_story then
				arg_235_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_235_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_238_1 = 0
			local var_238_2 = 0.875

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= var_238_1 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				arg_235_1.leftNameTxt_.text = arg_235_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, true)
				arg_235_1.iconController_:SetSelectedState("hero")

				arg_235_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_235_1.callingController_:SetSelectedState("normal")

				arg_235_1.keyicon_.color = Color.New(1, 1, 1)
				arg_235_1.icon_.color = Color.New(1, 1, 1)

				local var_238_3 = arg_235_1:FormatText(arg_235_1:GetWordFromCfg(1108409057).content)

				arg_235_1.text_.text = var_238_3

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_5 = 35 <= 0 and var_238_2 or var_238_2 * (utf8.len(var_238_3) / 35)

				if (35 <= 0 and var_238_2 or var_238_2 * (utf8.len(var_238_3) / 35)) > 0 and var_238_2 < var_238_5 then
					arg_235_1.talkMaxDuration = var_238_5

					if var_238_5 + var_238_1 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_5 + var_238_1
					end
				end

				arg_235_1.text_.text = var_238_3
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)
				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_6 = math.max(var_238_2, arg_235_1.talkMaxDuration)

			if var_238_1 <= arg_235_1.time_ and arg_235_1.time_ < var_238_1 + var_238_6 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_1) / var_238_6

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_1 + var_238_6 and arg_235_1.time_ < var_238_1 + var_238_6 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {}

		arg_235_1:InitPlayNodeList()
	end,
	Play1108409058 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 1108409058
		arg_239_1.duration_ = 2

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play1108409059(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 and not isNil(arg_239_1.actors_["1084ui_story"]) and arg_239_1.var_.characterEffect1084ui_story == nil then
				arg_239_1.var_.characterEffect1084ui_story = arg_239_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_242_0 = 0.200000002980232

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_0 and not isNil(arg_239_1.actors_["1084ui_story"]) then
				if arg_239_1.var_.characterEffect1084ui_story and not isNil(arg_239_1.actors_["1084ui_story"]) then
					arg_239_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_239_1.time_ >= 0 + var_242_0 and arg_239_1.time_ < 0 + var_242_0 + arg_242_0 and not isNil(arg_239_1.actors_["1084ui_story"]) and arg_239_1.var_.characterEffect1084ui_story then
				arg_239_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action12_2")
			end

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_242_2 = 0
			local var_242_3 = 0.225

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= var_242_2 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				arg_239_1.leftNameTxt_.text = arg_239_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_4 = arg_239_1:GetWordFromCfg(1108409058)
				local var_242_5 = arg_239_1:FormatText(var_242_4.content)

				arg_239_1.text_.text = var_242_5

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_7 = 9 <= 0 and var_242_3 or var_242_3 * (utf8.len(var_242_5) / 9)

				if (9 <= 0 and var_242_3 or var_242_3 * (utf8.len(var_242_5) / 9)) > 0 and var_242_3 < var_242_7 then
					arg_239_1.talkMaxDuration = var_242_7

					if var_242_7 + var_242_2 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_7 + var_242_2
					end
				end

				arg_239_1.text_.text = var_242_5
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409058", "story_v_side_new_1108409.awb") ~= 0 then
					local var_242_8 = manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409058", "story_v_side_new_1108409.awb") / 1000

					if var_242_8 + var_242_2 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_8 + var_242_2
					end

					if var_242_4.prefab_name ~= "" and arg_239_1.actors_[var_242_4.prefab_name] ~= nil then
						local var_242_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_239_1.actors_[var_242_4.prefab_name].transform, "story_v_side_new_1108409", "1108409058", "story_v_side_new_1108409.awb")

						arg_239_1:RecordAudio("1108409058", var_242_9)
						arg_239_1:RecordAudio("1108409058", var_242_9)
					else
						arg_239_1:AudioAction("play", "voice", "story_v_side_new_1108409", "1108409058", "story_v_side_new_1108409.awb")
					end

					arg_239_1:RecordHistoryTalkVoice("story_v_side_new_1108409", "1108409058", "story_v_side_new_1108409.awb")
				end

				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_10 = math.max(var_242_3, arg_239_1.talkMaxDuration)

			if var_242_2 <= arg_239_1.time_ and arg_239_1.time_ < var_242_2 + var_242_10 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_2) / var_242_10

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_2 + var_242_10 and arg_239_1.time_ < var_242_2 + var_242_10 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {}

		arg_239_1:InitPlayNodeList()
	end,
	Play1108409059 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 1108409059
		arg_243_1.duration_ = 5

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play1108409060(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 and not isNil(arg_243_1.actors_["1084ui_story"]) and arg_243_1.var_.characterEffect1084ui_story == nil then
				arg_243_1.var_.characterEffect1084ui_story = arg_243_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_246_0 = 0.200000002980232

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_0 and not isNil(arg_243_1.actors_["1084ui_story"]) then
				if arg_243_1.var_.characterEffect1084ui_story and not isNil(arg_243_1.actors_["1084ui_story"]) then
					arg_243_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_243_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_243_1.time_ - 0) / var_246_0)
				end
			end

			if arg_243_1.time_ >= 0 + var_246_0 and arg_243_1.time_ < 0 + var_246_0 + arg_246_0 and not isNil(arg_243_1.actors_["1084ui_story"]) and arg_243_1.var_.characterEffect1084ui_story then
				arg_243_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_243_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_246_1 = 0
			local var_246_2 = 1.125

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= var_246_1 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				arg_243_1.leftNameTxt_.text = arg_243_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, true)
				arg_243_1.iconController_:SetSelectedState("hero")

				arg_243_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_243_1.callingController_:SetSelectedState("normal")

				arg_243_1.keyicon_.color = Color.New(1, 1, 1)
				arg_243_1.icon_.color = Color.New(1, 1, 1)

				local var_246_3 = arg_243_1:FormatText(arg_243_1:GetWordFromCfg(1108409059).content)

				arg_243_1.text_.text = var_246_3

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_5 = 45 <= 0 and var_246_2 or var_246_2 * (utf8.len(var_246_3) / 45)

				if (45 <= 0 and var_246_2 or var_246_2 * (utf8.len(var_246_3) / 45)) > 0 and var_246_2 < var_246_5 then
					arg_243_1.talkMaxDuration = var_246_5

					if var_246_5 + var_246_1 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_5 + var_246_1
					end
				end

				arg_243_1.text_.text = var_246_3
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)
				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_6 = math.max(var_246_2, arg_243_1.talkMaxDuration)

			if var_246_1 <= arg_243_1.time_ and arg_243_1.time_ < var_246_1 + var_246_6 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_1) / var_246_6

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_1 + var_246_6 and arg_243_1.time_ < var_246_1 + var_246_6 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {}

		arg_243_1:InitPlayNodeList()
	end,
	Play1108409060 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 1108409060
		arg_247_1.duration_ = 2.5

		SetActive(arg_247_1.tipsGo_, false)

		function arg_247_1.onSingleLineFinish_()
			arg_247_1.onSingleLineUpdate_ = nil
			arg_247_1.onSingleLineFinish_ = nil
			arg_247_1.state_ = "waiting"
		end

		function arg_247_1.playNext_(arg_249_0)
			if arg_249_0 == 1 then
				arg_247_0:Play1108409061(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 and not isNil(arg_247_1.actors_["1084ui_story"]) and arg_247_1.var_.characterEffect1084ui_story == nil then
				arg_247_1.var_.characterEffect1084ui_story = arg_247_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_250_0 = 0.200000002980232

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_0 and not isNil(arg_247_1.actors_["1084ui_story"]) then
				if arg_247_1.var_.characterEffect1084ui_story and not isNil(arg_247_1.actors_["1084ui_story"]) then
					arg_247_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_247_1.time_ >= 0 + var_250_0 and arg_247_1.time_ < 0 + var_250_0 + arg_250_0 and not isNil(arg_247_1.actors_["1084ui_story"]) and arg_247_1.var_.characterEffect1084ui_story then
				arg_247_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 then
				arg_247_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action8_1")
			end

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 then
				arg_247_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_250_2 = 0
			local var_250_3 = 0.3

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= var_250_2 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				arg_247_1.leftNameTxt_.text = arg_247_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_4 = arg_247_1:GetWordFromCfg(1108409060)
				local var_250_5 = arg_247_1:FormatText(var_250_4.content)

				arg_247_1.text_.text = var_250_5

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_7 = 12 <= 0 and var_250_3 or var_250_3 * (utf8.len(var_250_5) / 12)

				if (12 <= 0 and var_250_3 or var_250_3 * (utf8.len(var_250_5) / 12)) > 0 and var_250_3 < var_250_7 then
					arg_247_1.talkMaxDuration = var_250_7

					if var_250_7 + var_250_2 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_7 + var_250_2
					end
				end

				arg_247_1.text_.text = var_250_5
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409060", "story_v_side_new_1108409.awb") ~= 0 then
					local var_250_8 = manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409060", "story_v_side_new_1108409.awb") / 1000

					if var_250_8 + var_250_2 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_8 + var_250_2
					end

					if var_250_4.prefab_name ~= "" and arg_247_1.actors_[var_250_4.prefab_name] ~= nil then
						local var_250_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_4.prefab_name].transform, "story_v_side_new_1108409", "1108409060", "story_v_side_new_1108409.awb")

						arg_247_1:RecordAudio("1108409060", var_250_9)
						arg_247_1:RecordAudio("1108409060", var_250_9)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_side_new_1108409", "1108409060", "story_v_side_new_1108409.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_side_new_1108409", "1108409060", "story_v_side_new_1108409.awb")
				end

				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_10 = math.max(var_250_3, arg_247_1.talkMaxDuration)

			if var_250_2 <= arg_247_1.time_ and arg_247_1.time_ < var_250_2 + var_250_10 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_2) / var_250_10

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_2 + var_250_10 and arg_247_1.time_ < var_250_2 + var_250_10 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {}

		arg_247_1:InitPlayNodeList()
	end,
	Play1108409061 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 1108409061
		arg_251_1.duration_ = 5

		SetActive(arg_251_1.tipsGo_, false)

		function arg_251_1.onSingleLineFinish_()
			arg_251_1.onSingleLineUpdate_ = nil
			arg_251_1.onSingleLineFinish_ = nil
			arg_251_1.state_ = "waiting"
		end

		function arg_251_1.playNext_(arg_253_0)
			if arg_253_0 == 1 then
				arg_251_0:Play1108409062(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 and not isNil(arg_251_1.actors_["1084ui_story"]) and arg_251_1.var_.characterEffect1084ui_story == nil then
				arg_251_1.var_.characterEffect1084ui_story = arg_251_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_254_0 = 0.200000002980232

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_0 and not isNil(arg_251_1.actors_["1084ui_story"]) then
				if arg_251_1.var_.characterEffect1084ui_story and not isNil(arg_251_1.actors_["1084ui_story"]) then
					arg_251_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_251_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_251_1.time_ - 0) / var_254_0)
				end
			end

			if arg_251_1.time_ >= 0 + var_254_0 and arg_251_1.time_ < 0 + var_254_0 + arg_254_0 and not isNil(arg_251_1.actors_["1084ui_story"]) and arg_251_1.var_.characterEffect1084ui_story then
				arg_251_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_251_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_254_1 = 0
			local var_254_2 = 0.975

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= var_254_1 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				arg_251_1.leftNameTxt_.text = arg_251_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, true)
				arg_251_1.iconController_:SetSelectedState("hero")

				arg_251_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_251_1.callingController_:SetSelectedState("normal")

				arg_251_1.keyicon_.color = Color.New(1, 1, 1)
				arg_251_1.icon_.color = Color.New(1, 1, 1)

				local var_254_3 = arg_251_1:FormatText(arg_251_1:GetWordFromCfg(1108409061).content)

				arg_251_1.text_.text = var_254_3

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_5 = 39 <= 0 and var_254_2 or var_254_2 * (utf8.len(var_254_3) / 39)

				if (39 <= 0 and var_254_2 or var_254_2 * (utf8.len(var_254_3) / 39)) > 0 and var_254_2 < var_254_5 then
					arg_251_1.talkMaxDuration = var_254_5

					if var_254_5 + var_254_1 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_5 + var_254_1
					end
				end

				arg_251_1.text_.text = var_254_3
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)
				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_6 = math.max(var_254_2, arg_251_1.talkMaxDuration)

			if var_254_1 <= arg_251_1.time_ and arg_251_1.time_ < var_254_1 + var_254_6 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_1) / var_254_6

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_1 + var_254_6 and arg_251_1.time_ < var_254_1 + var_254_6 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {}

		arg_251_1:InitPlayNodeList()
	end,
	Play1108409062 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 1108409062
		arg_255_1.duration_ = 3.8

		SetActive(arg_255_1.tipsGo_, false)

		function arg_255_1.onSingleLineFinish_()
			arg_255_1.onSingleLineUpdate_ = nil
			arg_255_1.onSingleLineFinish_ = nil
			arg_255_1.state_ = "waiting"
		end

		function arg_255_1.playNext_(arg_257_0)
			if arg_257_0 == 1 then
				arg_255_0:Play1108409063(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 and not isNil(arg_255_1.actors_["1084ui_story"]) and arg_255_1.var_.characterEffect1084ui_story == nil then
				arg_255_1.var_.characterEffect1084ui_story = arg_255_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_258_0 = 0.200000002980232

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_0 and not isNil(arg_255_1.actors_["1084ui_story"]) then
				if arg_255_1.var_.characterEffect1084ui_story and not isNil(arg_255_1.actors_["1084ui_story"]) then
					arg_255_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_255_1.time_ >= 0 + var_258_0 and arg_255_1.time_ < 0 + var_258_0 + arg_258_0 and not isNil(arg_255_1.actors_["1084ui_story"]) and arg_255_1.var_.characterEffect1084ui_story then
				arg_255_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 then
				arg_255_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action8_2")
			end

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 then
				arg_255_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_258_2 = 0
			local var_258_3 = 0.275

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= var_258_2 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, true)

				arg_255_1.leftNameTxt_.text = arg_255_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_255_1.leftNameTxt_.transform)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1.leftNameTxt_.text)
				SetActive(arg_255_1.iconTrs_.gameObject, false)
				arg_255_1.callingController_:SetSelectedState("normal")

				local var_258_4 = arg_255_1:GetWordFromCfg(1108409062)
				local var_258_5 = arg_255_1:FormatText(var_258_4.content)

				arg_255_1.text_.text = var_258_5

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_7 = 11 <= 0 and var_258_3 or var_258_3 * (utf8.len(var_258_5) / 11)

				if (11 <= 0 and var_258_3 or var_258_3 * (utf8.len(var_258_5) / 11)) > 0 and var_258_3 < var_258_7 then
					arg_255_1.talkMaxDuration = var_258_7

					if var_258_7 + var_258_2 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_7 + var_258_2
					end
				end

				arg_255_1.text_.text = var_258_5
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409062", "story_v_side_new_1108409.awb") ~= 0 then
					local var_258_8 = manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409062", "story_v_side_new_1108409.awb") / 1000

					if var_258_8 + var_258_2 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_8 + var_258_2
					end

					if var_258_4.prefab_name ~= "" and arg_255_1.actors_[var_258_4.prefab_name] ~= nil then
						local var_258_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_255_1.actors_[var_258_4.prefab_name].transform, "story_v_side_new_1108409", "1108409062", "story_v_side_new_1108409.awb")

						arg_255_1:RecordAudio("1108409062", var_258_9)
						arg_255_1:RecordAudio("1108409062", var_258_9)
					else
						arg_255_1:AudioAction("play", "voice", "story_v_side_new_1108409", "1108409062", "story_v_side_new_1108409.awb")
					end

					arg_255_1:RecordHistoryTalkVoice("story_v_side_new_1108409", "1108409062", "story_v_side_new_1108409.awb")
				end

				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_10 = math.max(var_258_3, arg_255_1.talkMaxDuration)

			if var_258_2 <= arg_255_1.time_ and arg_255_1.time_ < var_258_2 + var_258_10 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - var_258_2) / var_258_10

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= var_258_2 + var_258_10 and arg_255_1.time_ < var_258_2 + var_258_10 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {}

		arg_255_1:InitPlayNodeList()
	end,
	Play1108409063 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 1108409063
		arg_259_1.duration_ = 5

		SetActive(arg_259_1.tipsGo_, false)

		function arg_259_1.onSingleLineFinish_()
			arg_259_1.onSingleLineUpdate_ = nil
			arg_259_1.onSingleLineFinish_ = nil
			arg_259_1.state_ = "waiting"
		end

		function arg_259_1.playNext_(arg_261_0)
			if arg_261_0 == 1 then
				arg_259_0:Play1108409064(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 and not isNil(arg_259_1.actors_["1084ui_story"]) and arg_259_1.var_.characterEffect1084ui_story == nil then
				arg_259_1.var_.characterEffect1084ui_story = arg_259_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_262_0 = 0.200000002980232

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_0 and not isNil(arg_259_1.actors_["1084ui_story"]) then
				if arg_259_1.var_.characterEffect1084ui_story and not isNil(arg_259_1.actors_["1084ui_story"]) then
					arg_259_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_259_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_259_1.time_ - 0) / var_262_0)
				end
			end

			if arg_259_1.time_ >= 0 + var_262_0 and arg_259_1.time_ < 0 + var_262_0 + arg_262_0 and not isNil(arg_259_1.actors_["1084ui_story"]) and arg_259_1.var_.characterEffect1084ui_story then
				arg_259_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_259_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_262_1 = 0
			local var_262_2 = 0.125

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

				local var_262_3 = arg_259_1:FormatText(arg_259_1:GetWordFromCfg(1108409063).content)

				arg_259_1.text_.text = var_262_3

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_5 = 5 <= 0 and var_262_2 or var_262_2 * (utf8.len(var_262_3) / 5)

				if (5 <= 0 and var_262_2 or var_262_2 * (utf8.len(var_262_3) / 5)) > 0 and var_262_2 < var_262_5 then
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
	Play1108409064 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 1108409064
		arg_263_1.duration_ = 13.47

		SetActive(arg_263_1.tipsGo_, false)

		function arg_263_1.onSingleLineFinish_()
			arg_263_1.onSingleLineUpdate_ = nil
			arg_263_1.onSingleLineFinish_ = nil
			arg_263_1.state_ = "waiting"
		end

		function arg_263_1.playNext_(arg_265_0)
			if arg_265_0 == 1 then
				arg_263_0:Play1108409065(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 and not isNil(arg_263_1.actors_["1084ui_story"]) and arg_263_1.var_.characterEffect1084ui_story == nil then
				arg_263_1.var_.characterEffect1084ui_story = arg_263_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_266_0 = 0.200000002980232

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_0 and not isNil(arg_263_1.actors_["1084ui_story"]) then
				if arg_263_1.var_.characterEffect1084ui_story and not isNil(arg_263_1.actors_["1084ui_story"]) then
					arg_263_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_263_1.time_ >= 0 + var_266_0 and arg_263_1.time_ < 0 + var_266_0 + arg_266_0 and not isNil(arg_263_1.actors_["1084ui_story"]) and arg_263_1.var_.characterEffect1084ui_story then
				arg_263_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 then
				arg_263_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_1")
			end

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 then
				arg_263_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_266_2 = 0
			local var_266_3 = 1.525

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= var_266_2 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, true)

				arg_263_1.leftNameTxt_.text = arg_263_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_263_1.leftNameTxt_.transform)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1.leftNameTxt_.text)
				SetActive(arg_263_1.iconTrs_.gameObject, false)
				arg_263_1.callingController_:SetSelectedState("normal")

				local var_266_4 = arg_263_1:GetWordFromCfg(1108409064)
				local var_266_5 = arg_263_1:FormatText(var_266_4.content)

				arg_263_1.text_.text = var_266_5

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_7 = 61 <= 0 and var_266_3 or var_266_3 * (utf8.len(var_266_5) / 61)

				if (61 <= 0 and var_266_3 or var_266_3 * (utf8.len(var_266_5) / 61)) > 0 and var_266_3 < var_266_7 then
					arg_263_1.talkMaxDuration = var_266_7

					if var_266_7 + var_266_2 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_7 + var_266_2
					end
				end

				arg_263_1.text_.text = var_266_5
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409064", "story_v_side_new_1108409.awb") ~= 0 then
					local var_266_8 = manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409064", "story_v_side_new_1108409.awb") / 1000

					if var_266_8 + var_266_2 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_8 + var_266_2
					end

					if var_266_4.prefab_name ~= "" and arg_263_1.actors_[var_266_4.prefab_name] ~= nil then
						local var_266_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_263_1.actors_[var_266_4.prefab_name].transform, "story_v_side_new_1108409", "1108409064", "story_v_side_new_1108409.awb")

						arg_263_1:RecordAudio("1108409064", var_266_9)
						arg_263_1:RecordAudio("1108409064", var_266_9)
					else
						arg_263_1:AudioAction("play", "voice", "story_v_side_new_1108409", "1108409064", "story_v_side_new_1108409.awb")
					end

					arg_263_1:RecordHistoryTalkVoice("story_v_side_new_1108409", "1108409064", "story_v_side_new_1108409.awb")
				end

				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_10 = math.max(var_266_3, arg_263_1.talkMaxDuration)

			if var_266_2 <= arg_263_1.time_ and arg_263_1.time_ < var_266_2 + var_266_10 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - var_266_2) / var_266_10

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= var_266_2 + var_266_10 and arg_263_1.time_ < var_266_2 + var_266_10 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {}

		arg_263_1:InitPlayNodeList()
	end,
	Play1108409065 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 1108409065
		arg_267_1.duration_ = 5

		SetActive(arg_267_1.tipsGo_, false)

		function arg_267_1.onSingleLineFinish_()
			arg_267_1.onSingleLineUpdate_ = nil
			arg_267_1.onSingleLineFinish_ = nil
			arg_267_1.state_ = "waiting"
		end

		function arg_267_1.playNext_(arg_269_0)
			if arg_269_0 == 1 then
				arg_267_0:Play1108409066(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 and not isNil(arg_267_1.actors_["1084ui_story"]) and arg_267_1.var_.characterEffect1084ui_story == nil then
				arg_267_1.var_.characterEffect1084ui_story = arg_267_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_270_0 = 0.200000002980232

			if 0 <= arg_267_1.time_ and arg_267_1.time_ < 0 + var_270_0 and not isNil(arg_267_1.actors_["1084ui_story"]) then
				if arg_267_1.var_.characterEffect1084ui_story and not isNil(arg_267_1.actors_["1084ui_story"]) then
					arg_267_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_267_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_267_1.time_ - 0) / var_270_0)
				end
			end

			if arg_267_1.time_ >= 0 + var_270_0 and arg_267_1.time_ < 0 + var_270_0 + arg_270_0 and not isNil(arg_267_1.actors_["1084ui_story"]) and arg_267_1.var_.characterEffect1084ui_story then
				arg_267_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_267_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_270_1 = 0
			local var_270_2 = 0.55

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= var_270_1 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, false)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_267_1.iconTrs_.gameObject, false)
				arg_267_1.callingController_:SetSelectedState("normal")

				local var_270_3 = arg_267_1:FormatText(arg_267_1:GetWordFromCfg(1108409065).content)

				arg_267_1.text_.text = var_270_3

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_5 = 22 <= 0 and var_270_2 or var_270_2 * (utf8.len(var_270_3) / 22)

				if (22 <= 0 and var_270_2 or var_270_2 * (utf8.len(var_270_3) / 22)) > 0 and var_270_2 < var_270_5 then
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
	Play1108409066 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 1108409066
		arg_271_1.duration_ = 5

		SetActive(arg_271_1.tipsGo_, false)

		function arg_271_1.onSingleLineFinish_()
			arg_271_1.onSingleLineUpdate_ = nil
			arg_271_1.onSingleLineFinish_ = nil
			arg_271_1.state_ = "waiting"
		end

		function arg_271_1.playNext_(arg_273_0)
			if arg_273_0 == 1 then
				arg_271_0:Play1108409067(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			local var_274_0 = 0.25

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, true)

				arg_271_1.leftNameTxt_.text = arg_271_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_271_1.leftNameTxt_.transform)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1.leftNameTxt_.text)
				SetActive(arg_271_1.iconTrs_.gameObject, true)
				arg_271_1.iconController_:SetSelectedState("hero")

				arg_271_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_271_1.callingController_:SetSelectedState("normal")

				arg_271_1.keyicon_.color = Color.New(1, 1, 1)
				arg_271_1.icon_.color = Color.New(1, 1, 1)

				local var_274_1 = arg_271_1:FormatText(arg_271_1:GetWordFromCfg(1108409066).content)

				arg_271_1.text_.text = var_274_1

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_3 = 10 <= 0 and var_274_0 or var_274_0 * (utf8.len(var_274_1) / 10)

				if (10 <= 0 and var_274_0 or var_274_0 * (utf8.len(var_274_1) / 10)) > 0 and var_274_0 < var_274_3 then
					arg_271_1.talkMaxDuration = var_274_3

					if var_274_3 + 0 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_3 + 0
					end
				end

				arg_271_1.text_.text = var_274_1
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)
				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_4 = math.max(var_274_0, arg_271_1.talkMaxDuration)

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_4 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - 0) / var_274_4

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= 0 + var_274_4 and arg_271_1.time_ < 0 + var_274_4 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {}

		arg_271_1:InitPlayNodeList()
	end,
	Play1108409067 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 1108409067
		arg_275_1.duration_ = 2

		SetActive(arg_275_1.tipsGo_, false)

		function arg_275_1.onSingleLineFinish_()
			arg_275_1.onSingleLineUpdate_ = nil
			arg_275_1.onSingleLineFinish_ = nil
			arg_275_1.state_ = "waiting"
		end

		function arg_275_1.playNext_(arg_277_0)
			if arg_277_0 == 1 then
				arg_275_0:Play1108409068(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 and not isNil(arg_275_1.actors_["1084ui_story"]) and arg_275_1.var_.characterEffect1084ui_story == nil then
				arg_275_1.var_.characterEffect1084ui_story = arg_275_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_278_0 = 0.200000002980232

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_0 and not isNil(arg_275_1.actors_["1084ui_story"]) then
				if arg_275_1.var_.characterEffect1084ui_story and not isNil(arg_275_1.actors_["1084ui_story"]) then
					arg_275_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_275_1.time_ >= 0 + var_278_0 and arg_275_1.time_ < 0 + var_278_0 + arg_278_0 and not isNil(arg_275_1.actors_["1084ui_story"]) and arg_275_1.var_.characterEffect1084ui_story then
				arg_275_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 then
				arg_275_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_2")
			end

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 then
				arg_275_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_278_2 = 0
			local var_278_3 = 0.075

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= var_278_2 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, true)

				arg_275_1.leftNameTxt_.text = arg_275_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_275_1.leftNameTxt_.transform)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1.leftNameTxt_.text)
				SetActive(arg_275_1.iconTrs_.gameObject, false)
				arg_275_1.callingController_:SetSelectedState("normal")

				local var_278_4 = arg_275_1:GetWordFromCfg(1108409067)
				local var_278_5 = arg_275_1:FormatText(var_278_4.content)

				arg_275_1.text_.text = var_278_5

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_7 = 3 <= 0 and var_278_3 or var_278_3 * (utf8.len(var_278_5) / 3)

				if (3 <= 0 and var_278_3 or var_278_3 * (utf8.len(var_278_5) / 3)) > 0 and var_278_3 < var_278_7 then
					arg_275_1.talkMaxDuration = var_278_7

					if var_278_7 + var_278_2 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_7 + var_278_2
					end
				end

				arg_275_1.text_.text = var_278_5
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409067", "story_v_side_new_1108409.awb") ~= 0 then
					local var_278_8 = manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409067", "story_v_side_new_1108409.awb") / 1000

					if var_278_8 + var_278_2 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_8 + var_278_2
					end

					if var_278_4.prefab_name ~= "" and arg_275_1.actors_[var_278_4.prefab_name] ~= nil then
						local var_278_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_275_1.actors_[var_278_4.prefab_name].transform, "story_v_side_new_1108409", "1108409067", "story_v_side_new_1108409.awb")

						arg_275_1:RecordAudio("1108409067", var_278_9)
						arg_275_1:RecordAudio("1108409067", var_278_9)
					else
						arg_275_1:AudioAction("play", "voice", "story_v_side_new_1108409", "1108409067", "story_v_side_new_1108409.awb")
					end

					arg_275_1:RecordHistoryTalkVoice("story_v_side_new_1108409", "1108409067", "story_v_side_new_1108409.awb")
				end

				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_10 = math.max(var_278_3, arg_275_1.talkMaxDuration)

			if var_278_2 <= arg_275_1.time_ and arg_275_1.time_ < var_278_2 + var_278_10 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - var_278_2) / var_278_10

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= var_278_2 + var_278_10 and arg_275_1.time_ < var_278_2 + var_278_10 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {}

		arg_275_1:InitPlayNodeList()
	end,
	Play1108409068 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 1108409068
		arg_279_1.duration_ = 5

		SetActive(arg_279_1.tipsGo_, false)

		function arg_279_1.onSingleLineFinish_()
			arg_279_1.onSingleLineUpdate_ = nil
			arg_279_1.onSingleLineFinish_ = nil
			arg_279_1.state_ = "waiting"
		end

		function arg_279_1.playNext_(arg_281_0)
			if arg_281_0 == 1 then
				arg_279_0:Play1108409069(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 and not isNil(arg_279_1.actors_["1084ui_story"]) and arg_279_1.var_.characterEffect1084ui_story == nil then
				arg_279_1.var_.characterEffect1084ui_story = arg_279_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_282_0 = 0.200000002980232

			if 0 <= arg_279_1.time_ and arg_279_1.time_ < 0 + var_282_0 and not isNil(arg_279_1.actors_["1084ui_story"]) then
				if arg_279_1.var_.characterEffect1084ui_story and not isNil(arg_279_1.actors_["1084ui_story"]) then
					arg_279_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_279_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_279_1.time_ - 0) / var_282_0)
				end
			end

			if arg_279_1.time_ >= 0 + var_282_0 and arg_279_1.time_ < 0 + var_282_0 + arg_282_0 and not isNil(arg_279_1.actors_["1084ui_story"]) and arg_279_1.var_.characterEffect1084ui_story then
				arg_279_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_279_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_282_1 = 0
			local var_282_2 = 1.25

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= var_282_1 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, false)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_279_1.iconTrs_.gameObject, false)
				arg_279_1.callingController_:SetSelectedState("normal")

				local var_282_3 = arg_279_1:FormatText(arg_279_1:GetWordFromCfg(1108409068).content)

				arg_279_1.text_.text = var_282_3

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_5 = 50 <= 0 and var_282_2 or var_282_2 * (utf8.len(var_282_3) / 50)

				if (50 <= 0 and var_282_2 or var_282_2 * (utf8.len(var_282_3) / 50)) > 0 and var_282_2 < var_282_5 then
					arg_279_1.talkMaxDuration = var_282_5

					if var_282_5 + var_282_1 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_5 + var_282_1
					end
				end

				arg_279_1.text_.text = var_282_3
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)
				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_6 = math.max(var_282_2, arg_279_1.talkMaxDuration)

			if var_282_1 <= arg_279_1.time_ and arg_279_1.time_ < var_282_1 + var_282_6 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - var_282_1) / var_282_6

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= var_282_1 + var_282_6 and arg_279_1.time_ < var_282_1 + var_282_6 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {}

		arg_279_1:InitPlayNodeList()
	end,
	Play1108409069 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 1108409069
		arg_283_1.duration_ = 5

		SetActive(arg_283_1.tipsGo_, false)

		function arg_283_1.onSingleLineFinish_()
			arg_283_1.onSingleLineUpdate_ = nil
			arg_283_1.onSingleLineFinish_ = nil
			arg_283_1.state_ = "waiting"
		end

		function arg_283_1.playNext_(arg_285_0)
			if arg_285_0 == 1 then
				arg_283_0:Play1108409070(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			local var_286_0 = 1.175

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, true)

				arg_283_1.leftNameTxt_.text = arg_283_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_283_1.leftNameTxt_.transform)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1.leftNameTxt_.text)
				SetActive(arg_283_1.iconTrs_.gameObject, true)
				arg_283_1.iconController_:SetSelectedState("hero")

				arg_283_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_283_1.callingController_:SetSelectedState("normal")

				arg_283_1.keyicon_.color = Color.New(1, 1, 1)
				arg_283_1.icon_.color = Color.New(1, 1, 1)

				local var_286_1 = arg_283_1:FormatText(arg_283_1:GetWordFromCfg(1108409069).content)

				arg_283_1.text_.text = var_286_1

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_3 = 47 <= 0 and var_286_0 or var_286_0 * (utf8.len(var_286_1) / 47)

				if (47 <= 0 and var_286_0 or var_286_0 * (utf8.len(var_286_1) / 47)) > 0 and var_286_0 < var_286_3 then
					arg_283_1.talkMaxDuration = var_286_3

					if var_286_3 + 0 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_3 + 0
					end
				end

				arg_283_1.text_.text = var_286_1
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)
				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_4 = math.max(var_286_0, arg_283_1.talkMaxDuration)

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_4 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - 0) / var_286_4

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= 0 + var_286_4 and arg_283_1.time_ < 0 + var_286_4 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {}

		arg_283_1:InitPlayNodeList()
	end,
	Play1108409070 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 1108409070
		arg_287_1.duration_ = 7.4

		SetActive(arg_287_1.tipsGo_, false)

		function arg_287_1.onSingleLineFinish_()
			arg_287_1.onSingleLineUpdate_ = nil
			arg_287_1.onSingleLineFinish_ = nil
			arg_287_1.state_ = "waiting"
		end

		function arg_287_1.playNext_(arg_289_0)
			if arg_289_0 == 1 then
				arg_287_0:Play1108409071(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 and not isNil(arg_287_1.actors_["1084ui_story"]) and arg_287_1.var_.characterEffect1084ui_story == nil then
				arg_287_1.var_.characterEffect1084ui_story = arg_287_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_290_0 = 0.200000002980232

			if 0 <= arg_287_1.time_ and arg_287_1.time_ < 0 + var_290_0 and not isNil(arg_287_1.actors_["1084ui_story"]) then
				if arg_287_1.var_.characterEffect1084ui_story and not isNil(arg_287_1.actors_["1084ui_story"]) then
					arg_287_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_287_1.time_ >= 0 + var_290_0 and arg_287_1.time_ < 0 + var_290_0 + arg_290_0 and not isNil(arg_287_1.actors_["1084ui_story"]) and arg_287_1.var_.characterEffect1084ui_story then
				arg_287_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 then
				arg_287_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 then
				arg_287_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_290_2 = 0
			local var_290_3 = 0.675

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= var_290_2 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, true)

				arg_287_1.leftNameTxt_.text = arg_287_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_287_1.leftNameTxt_.transform)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1.leftNameTxt_.text)
				SetActive(arg_287_1.iconTrs_.gameObject, false)
				arg_287_1.callingController_:SetSelectedState("normal")

				local var_290_4 = arg_287_1:GetWordFromCfg(1108409070)
				local var_290_5 = arg_287_1:FormatText(var_290_4.content)

				arg_287_1.text_.text = var_290_5

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_7 = 27 <= 0 and var_290_3 or var_290_3 * (utf8.len(var_290_5) / 27)

				if (27 <= 0 and var_290_3 or var_290_3 * (utf8.len(var_290_5) / 27)) > 0 and var_290_3 < var_290_7 then
					arg_287_1.talkMaxDuration = var_290_7

					if var_290_7 + var_290_2 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_7 + var_290_2
					end
				end

				arg_287_1.text_.text = var_290_5
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409070", "story_v_side_new_1108409.awb") ~= 0 then
					local var_290_8 = manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409070", "story_v_side_new_1108409.awb") / 1000

					if var_290_8 + var_290_2 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_8 + var_290_2
					end

					if var_290_4.prefab_name ~= "" and arg_287_1.actors_[var_290_4.prefab_name] ~= nil then
						local var_290_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_287_1.actors_[var_290_4.prefab_name].transform, "story_v_side_new_1108409", "1108409070", "story_v_side_new_1108409.awb")

						arg_287_1:RecordAudio("1108409070", var_290_9)
						arg_287_1:RecordAudio("1108409070", var_290_9)
					else
						arg_287_1:AudioAction("play", "voice", "story_v_side_new_1108409", "1108409070", "story_v_side_new_1108409.awb")
					end

					arg_287_1:RecordHistoryTalkVoice("story_v_side_new_1108409", "1108409070", "story_v_side_new_1108409.awb")
				end

				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_10 = math.max(var_290_3, arg_287_1.talkMaxDuration)

			if var_290_2 <= arg_287_1.time_ and arg_287_1.time_ < var_290_2 + var_290_10 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - var_290_2) / var_290_10

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= var_290_2 + var_290_10 and arg_287_1.time_ < var_290_2 + var_290_10 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {}

		arg_287_1:InitPlayNodeList()
	end,
	Play1108409071 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 1108409071
		arg_291_1.duration_ = 5

		SetActive(arg_291_1.tipsGo_, false)

		function arg_291_1.onSingleLineFinish_()
			arg_291_1.onSingleLineUpdate_ = nil
			arg_291_1.onSingleLineFinish_ = nil
			arg_291_1.state_ = "waiting"
		end

		function arg_291_1.playNext_(arg_293_0)
			if arg_293_0 == 1 then
				arg_291_0:Play1108409072(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 and not isNil(arg_291_1.actors_["1084ui_story"]) and arg_291_1.var_.characterEffect1084ui_story == nil then
				arg_291_1.var_.characterEffect1084ui_story = arg_291_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_294_0 = 0.200000002980232

			if 0 <= arg_291_1.time_ and arg_291_1.time_ < 0 + var_294_0 and not isNil(arg_291_1.actors_["1084ui_story"]) then
				if arg_291_1.var_.characterEffect1084ui_story and not isNil(arg_291_1.actors_["1084ui_story"]) then
					arg_291_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_291_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_291_1.time_ - 0) / var_294_0)
				end
			end

			if arg_291_1.time_ >= 0 + var_294_0 and arg_291_1.time_ < 0 + var_294_0 + arg_294_0 and not isNil(arg_291_1.actors_["1084ui_story"]) and arg_291_1.var_.characterEffect1084ui_story then
				arg_291_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_291_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_294_1 = 0
			local var_294_2 = 0.175

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= var_294_1 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0
				arg_291_1.dialogCg_.alpha = 1

				arg_291_1.dialog_:SetActive(true)
				SetActive(arg_291_1.leftNameGo_, true)

				arg_291_1.leftNameTxt_.text = arg_291_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_291_1.leftNameTxt_.transform)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1.leftNameTxt_.text)
				SetActive(arg_291_1.iconTrs_.gameObject, true)
				arg_291_1.iconController_:SetSelectedState("hero")

				arg_291_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_291_1.callingController_:SetSelectedState("normal")

				arg_291_1.keyicon_.color = Color.New(1, 1, 1)
				arg_291_1.icon_.color = Color.New(1, 1, 1)

				local var_294_3 = arg_291_1:FormatText(arg_291_1:GetWordFromCfg(1108409071).content)

				arg_291_1.text_.text = var_294_3

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_5 = 7 <= 0 and var_294_2 or var_294_2 * (utf8.len(var_294_3) / 7)

				if (7 <= 0 and var_294_2 or var_294_2 * (utf8.len(var_294_3) / 7)) > 0 and var_294_2 < var_294_5 then
					arg_291_1.talkMaxDuration = var_294_5

					if var_294_5 + var_294_1 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_5 + var_294_1
					end
				end

				arg_291_1.text_.text = var_294_3
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)
				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_6 = math.max(var_294_2, arg_291_1.talkMaxDuration)

			if var_294_1 <= arg_291_1.time_ and arg_291_1.time_ < var_294_1 + var_294_6 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - var_294_1) / var_294_6

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= var_294_1 + var_294_6 and arg_291_1.time_ < var_294_1 + var_294_6 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {}

		arg_291_1:InitPlayNodeList()
	end,
	Play1108409072 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 1108409072
		arg_295_1.duration_ = 3.8

		SetActive(arg_295_1.tipsGo_, false)

		function arg_295_1.onSingleLineFinish_()
			arg_295_1.onSingleLineUpdate_ = nil
			arg_295_1.onSingleLineFinish_ = nil
			arg_295_1.state_ = "waiting"
		end

		function arg_295_1.playNext_(arg_297_0)
			if arg_297_0 == 1 then
				arg_295_0:Play1108409073(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 and not isNil(arg_295_1.actors_["1084ui_story"]) and arg_295_1.var_.characterEffect1084ui_story == nil then
				arg_295_1.var_.characterEffect1084ui_story = arg_295_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_298_0 = 0.200000002980232

			if 0 <= arg_295_1.time_ and arg_295_1.time_ < 0 + var_298_0 and not isNil(arg_295_1.actors_["1084ui_story"]) then
				if arg_295_1.var_.characterEffect1084ui_story and not isNil(arg_295_1.actors_["1084ui_story"]) then
					arg_295_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_295_1.time_ >= 0 + var_298_0 and arg_295_1.time_ < 0 + var_298_0 + arg_298_0 and not isNil(arg_295_1.actors_["1084ui_story"]) and arg_295_1.var_.characterEffect1084ui_story then
				arg_295_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 then
				arg_295_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action2_1")
			end

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 then
				arg_295_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva", "EmotionTimelineAnimator")
			end

			local var_298_2 = 0
			local var_298_3 = 0.35

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= var_298_2 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, true)

				arg_295_1.leftNameTxt_.text = arg_295_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_295_1.leftNameTxt_.transform)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1.leftNameTxt_.text)
				SetActive(arg_295_1.iconTrs_.gameObject, false)
				arg_295_1.callingController_:SetSelectedState("normal")

				local var_298_4 = arg_295_1:GetWordFromCfg(1108409072)
				local var_298_5 = arg_295_1:FormatText(var_298_4.content)

				arg_295_1.text_.text = var_298_5

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_7 = 14 <= 0 and var_298_3 or var_298_3 * (utf8.len(var_298_5) / 14)

				if (14 <= 0 and var_298_3 or var_298_3 * (utf8.len(var_298_5) / 14)) > 0 and var_298_3 < var_298_7 then
					arg_295_1.talkMaxDuration = var_298_7

					if var_298_7 + var_298_2 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_7 + var_298_2
					end
				end

				arg_295_1.text_.text = var_298_5
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409072", "story_v_side_new_1108409.awb") ~= 0 then
					local var_298_8 = manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409072", "story_v_side_new_1108409.awb") / 1000

					if var_298_8 + var_298_2 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_8 + var_298_2
					end

					if var_298_4.prefab_name ~= "" and arg_295_1.actors_[var_298_4.prefab_name] ~= nil then
						local var_298_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_295_1.actors_[var_298_4.prefab_name].transform, "story_v_side_new_1108409", "1108409072", "story_v_side_new_1108409.awb")

						arg_295_1:RecordAudio("1108409072", var_298_9)
						arg_295_1:RecordAudio("1108409072", var_298_9)
					else
						arg_295_1:AudioAction("play", "voice", "story_v_side_new_1108409", "1108409072", "story_v_side_new_1108409.awb")
					end

					arg_295_1:RecordHistoryTalkVoice("story_v_side_new_1108409", "1108409072", "story_v_side_new_1108409.awb")
				end

				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_10 = math.max(var_298_3, arg_295_1.talkMaxDuration)

			if var_298_2 <= arg_295_1.time_ and arg_295_1.time_ < var_298_2 + var_298_10 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - var_298_2) / var_298_10

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= var_298_2 + var_298_10 and arg_295_1.time_ < var_298_2 + var_298_10 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {}

		arg_295_1:InitPlayNodeList()
	end,
	Play1108409073 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 1108409073
		arg_299_1.duration_ = 5

		SetActive(arg_299_1.tipsGo_, false)

		function arg_299_1.onSingleLineFinish_()
			arg_299_1.onSingleLineUpdate_ = nil
			arg_299_1.onSingleLineFinish_ = nil
			arg_299_1.state_ = "waiting"
		end

		function arg_299_1.playNext_(arg_301_0)
			if arg_301_0 == 1 then
				arg_299_0:Play1108409074(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 and not isNil(arg_299_1.actors_["1084ui_story"]) and arg_299_1.var_.characterEffect1084ui_story == nil then
				arg_299_1.var_.characterEffect1084ui_story = arg_299_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_302_0 = 0.200000002980232

			if 0 <= arg_299_1.time_ and arg_299_1.time_ < 0 + var_302_0 and not isNil(arg_299_1.actors_["1084ui_story"]) then
				if arg_299_1.var_.characterEffect1084ui_story and not isNil(arg_299_1.actors_["1084ui_story"]) then
					arg_299_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_299_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_299_1.time_ - 0) / var_302_0)
				end
			end

			if arg_299_1.time_ >= 0 + var_302_0 and arg_299_1.time_ < 0 + var_302_0 + arg_302_0 and not isNil(arg_299_1.actors_["1084ui_story"]) and arg_299_1.var_.characterEffect1084ui_story then
				arg_299_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_299_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_302_1 = 0
			local var_302_2 = 0.85

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

				local var_302_3 = arg_299_1:FormatText(arg_299_1:GetWordFromCfg(1108409073).content)

				arg_299_1.text_.text = var_302_3

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_5 = 34 <= 0 and var_302_2 or var_302_2 * (utf8.len(var_302_3) / 34)

				if (34 <= 0 and var_302_2 or var_302_2 * (utf8.len(var_302_3) / 34)) > 0 and var_302_2 < var_302_5 then
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
	Play1108409074 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 1108409074
		arg_303_1.duration_ = 4.2

		SetActive(arg_303_1.tipsGo_, false)

		function arg_303_1.onSingleLineFinish_()
			arg_303_1.onSingleLineUpdate_ = nil
			arg_303_1.onSingleLineFinish_ = nil
			arg_303_1.state_ = "waiting"
		end

		function arg_303_1.playNext_(arg_305_0)
			if arg_305_0 == 1 then
				arg_303_0:Play1108409075(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 and not isNil(arg_303_1.actors_["1084ui_story"]) and arg_303_1.var_.characterEffect1084ui_story == nil then
				arg_303_1.var_.characterEffect1084ui_story = arg_303_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_306_0 = 0.200000002980232

			if 0 <= arg_303_1.time_ and arg_303_1.time_ < 0 + var_306_0 and not isNil(arg_303_1.actors_["1084ui_story"]) then
				if arg_303_1.var_.characterEffect1084ui_story and not isNil(arg_303_1.actors_["1084ui_story"]) then
					arg_303_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_303_1.time_ >= 0 + var_306_0 and arg_303_1.time_ < 0 + var_306_0 + arg_306_0 and not isNil(arg_303_1.actors_["1084ui_story"]) and arg_303_1.var_.characterEffect1084ui_story then
				arg_303_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 then
				arg_303_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action423")
			end

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 then
				arg_303_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_306_2 = 0
			local var_306_3 = 0.325

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= var_306_2 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, true)

				arg_303_1.leftNameTxt_.text = arg_303_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_303_1.leftNameTxt_.transform)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1.leftNameTxt_.text)
				SetActive(arg_303_1.iconTrs_.gameObject, false)
				arg_303_1.callingController_:SetSelectedState("normal")

				local var_306_4 = arg_303_1:GetWordFromCfg(1108409074)
				local var_306_5 = arg_303_1:FormatText(var_306_4.content)

				arg_303_1.text_.text = var_306_5

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_7 = 13 <= 0 and var_306_3 or var_306_3 * (utf8.len(var_306_5) / 13)

				if (13 <= 0 and var_306_3 or var_306_3 * (utf8.len(var_306_5) / 13)) > 0 and var_306_3 < var_306_7 then
					arg_303_1.talkMaxDuration = var_306_7

					if var_306_7 + var_306_2 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_7 + var_306_2
					end
				end

				arg_303_1.text_.text = var_306_5
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409074", "story_v_side_new_1108409.awb") ~= 0 then
					local var_306_8 = manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409074", "story_v_side_new_1108409.awb") / 1000

					if var_306_8 + var_306_2 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_8 + var_306_2
					end

					if var_306_4.prefab_name ~= "" and arg_303_1.actors_[var_306_4.prefab_name] ~= nil then
						local var_306_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_303_1.actors_[var_306_4.prefab_name].transform, "story_v_side_new_1108409", "1108409074", "story_v_side_new_1108409.awb")

						arg_303_1:RecordAudio("1108409074", var_306_9)
						arg_303_1:RecordAudio("1108409074", var_306_9)
					else
						arg_303_1:AudioAction("play", "voice", "story_v_side_new_1108409", "1108409074", "story_v_side_new_1108409.awb")
					end

					arg_303_1:RecordHistoryTalkVoice("story_v_side_new_1108409", "1108409074", "story_v_side_new_1108409.awb")
				end

				arg_303_1:RecordContent(arg_303_1.text_.text)
			end

			local var_306_10 = math.max(var_306_3, arg_303_1.talkMaxDuration)

			if var_306_2 <= arg_303_1.time_ and arg_303_1.time_ < var_306_2 + var_306_10 then
				arg_303_1.typewritter.percent = (arg_303_1.time_ - var_306_2) / var_306_10

				arg_303_1.typewritter:SetDirty()
			end

			if arg_303_1.time_ >= var_306_2 + var_306_10 and arg_303_1.time_ < var_306_2 + var_306_10 + arg_306_0 then
				arg_303_1.typewritter.percent = 1

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(true)
			end
		end

		arg_303_1.nodeConfigList_ = {}

		arg_303_1:InitPlayNodeList()
	end,
	Play1108409075 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 1108409075
		arg_307_1.duration_ = 9

		SetActive(arg_307_1.tipsGo_, false)

		function arg_307_1.onSingleLineFinish_()
			arg_307_1.onSingleLineUpdate_ = nil
			arg_307_1.onSingleLineFinish_ = nil
			arg_307_1.state_ = "waiting"
		end

		function arg_307_1.playNext_(arg_309_0)
			if arg_309_0 == 1 then
				arg_307_0:Play1108409076(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			if arg_307_1.bgs_.ST2401 == nil then
				local var_310_0 = Object.Instantiate(arg_307_1.paintGo_)

				var_310_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST2401")
				var_310_0.name = "ST2401"
				var_310_0.transform.parent = arg_307_1.stage_.transform
				var_310_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_307_1.bgs_.ST2401 = var_310_0
			end

			if 1.999999999999 < arg_307_1.time_ and arg_307_1.time_ <= 1.999999999999 + arg_310_0 then
				local var_310_1 = arg_307_1.bgs_.ST2401

				arg_307_1.bgs_.ST2401.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_310_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_310_2 = var_310_1:GetComponent("SpriteRenderer")

				if var_310_2 and var_310_2.sprite then
					local var_310_3 = 2 * (var_310_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_310_1.transform.localScale = Vector3.New(var_310_3 / var_310_2.sprite.bounds.size.y < var_310_3 * manager.ui.mainCameraCom_.aspect / var_310_2.sprite.bounds.size.x and var_310_3 * manager.ui.mainCameraCom_.aspect / var_310_2.sprite.bounds.size.x or var_310_3 / var_310_2.sprite.bounds.size.y, var_310_3 / var_310_2.sprite.bounds.size.y < var_310_3 * manager.ui.mainCameraCom_.aspect / var_310_2.sprite.bounds.size.x and var_310_3 * manager.ui.mainCameraCom_.aspect / var_310_2.sprite.bounds.size.x or var_310_3 / var_310_2.sprite.bounds.size.y, 0)
				end

				for iter_310_0, iter_310_1 in pairs(arg_307_1.bgs_) do
					if iter_310_0 ~= "ST2401" then
						iter_310_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_310_4 = 3.999999999999

			if 3.999999999999 < arg_307_1.time_ and arg_307_1.time_ <= var_310_4 + arg_310_0 then
				arg_307_1.allBtn_.enabled = false
			end

			if arg_307_1.time_ >= var_310_4 + 0.3 and arg_307_1.time_ < var_310_4 + 0.3 + arg_310_0 then
				arg_307_1.allBtn_.enabled = true
			end

			local var_310_5 = 0

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= var_310_5 + arg_310_0 then
				arg_307_1.mask_.enabled = true
				arg_307_1.mask_.raycastTarget = true

				arg_307_1:SetGaussion(false)
			end

			local var_310_6 = 2

			if var_310_5 <= arg_307_1.time_ and arg_307_1.time_ < var_310_5 + var_310_6 then
				local var_310_7 = Color.New(0, 0, 0)

				var_310_7.a = Mathf.Lerp(0, 1, (arg_307_1.time_ - var_310_5) / var_310_6)
				arg_307_1.mask_.color = var_310_7
			end

			if arg_307_1.time_ >= var_310_5 + var_310_6 and arg_307_1.time_ < var_310_5 + var_310_6 + arg_310_0 then
				local var_310_8 = Color.New(0, 0, 0)

				var_310_8.a = 1
				arg_307_1.mask_.color = var_310_8
			end

			local var_310_9 = 2

			if 2 < arg_307_1.time_ and arg_307_1.time_ <= var_310_9 + arg_310_0 then
				arg_307_1.mask_.enabled = true
				arg_307_1.mask_.raycastTarget = true

				arg_307_1:SetGaussion(false)
			end

			local var_310_10 = 2

			if var_310_9 <= arg_307_1.time_ and arg_307_1.time_ < var_310_9 + var_310_10 then
				local var_310_11 = Color.New(0, 0, 0)

				var_310_11.a = Mathf.Lerp(1, 0, (arg_307_1.time_ - var_310_9) / var_310_10)
				arg_307_1.mask_.color = var_310_11
			end

			if arg_307_1.time_ >= var_310_9 + var_310_10 and arg_307_1.time_ < var_310_9 + var_310_10 + arg_310_0 then
				local var_310_12 = Color.New(0, 0, 0)

				arg_307_1.mask_.enabled = false
				var_310_12.a = 0
				arg_307_1.mask_.color = var_310_12
			end

			local var_310_13 = arg_307_1.actors_["1084ui_story"].transform

			if 1.96599999815226 < arg_307_1.time_ and arg_307_1.time_ <= 1.96599999815226 + arg_310_0 then
				arg_307_1.var_.moveOldPos1084ui_story = var_310_13.localPosition
			end

			local var_310_14 = 0.001

			if 1.96599999815226 <= arg_307_1.time_ and arg_307_1.time_ < 1.96599999815226 + var_310_14 then
				var_310_13.localPosition = Vector3.Lerp(arg_307_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_307_1.time_ - 1.96599999815226) / var_310_14)
				var_310_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_310_13.position).x, (manager.ui.mainCamera.transform.position - var_310_13.position).y, (manager.ui.mainCamera.transform.position - var_310_13.position).z)
				var_310_13.localEulerAngles.z = 0
				var_310_13.localEulerAngles.x = 0
				var_310_13.localEulerAngles = var_310_13.localEulerAngles
			end

			if arg_307_1.time_ >= 1.96599999815226 + var_310_14 and arg_307_1.time_ < 1.96599999815226 + var_310_14 + arg_310_0 then
				var_310_13.localPosition = Vector3.New(0, 100, 0)
				var_310_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_310_13.position).x, (manager.ui.mainCamera.transform.position - var_310_13.position).y, (manager.ui.mainCamera.transform.position - var_310_13.position).z)
				var_310_13.localEulerAngles.z = 0
				var_310_13.localEulerAngles.x = 0
				var_310_13.localEulerAngles = var_310_13.localEulerAngles
			end

			local var_310_15 = arg_307_1.actors_["1084ui_story"]

			if 1.96599999815226 < arg_307_1.time_ and arg_307_1.time_ <= 1.96599999815226 + arg_310_0 and not isNil(var_310_15) and arg_307_1.var_.characterEffect1084ui_story == nil then
				arg_307_1.var_.characterEffect1084ui_story = var_310_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_310_16 = 0.034000001847744

			if 1.96599999815226 <= arg_307_1.time_ and arg_307_1.time_ < 1.96599999815226 + var_310_16 and not isNil(var_310_15) then
				if arg_307_1.var_.characterEffect1084ui_story and not isNil(var_310_15) then
					arg_307_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_307_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_307_1.time_ - 1.96599999815226) / var_310_16)
				end
			end

			if arg_307_1.time_ >= 1.96599999815226 + var_310_16 and arg_307_1.time_ < 1.96599999815226 + var_310_16 + arg_310_0 and not isNil(var_310_15) and arg_307_1.var_.characterEffect1084ui_story then
				arg_307_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_307_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 1.5 < arg_307_1.time_ and arg_307_1.time_ <= 1.5 + arg_310_0 then
				arg_307_1:AudioAction("play", "effect", "se_story_140", "se_story_140_car05", "")
			end

			if 1.2 < arg_307_1.time_ and arg_307_1.time_ <= 1.2 + arg_310_0 then
				arg_307_1:AudioAction("play", "effect", "se_story_side_1095", "se_story_side_1095_amb_car", "")
			end

			if 0.2 < arg_307_1.time_ and arg_307_1.time_ <= 0.2 + arg_310_0 then
				arg_307_1:AudioAction("stop", "effect", "se_story_1310", "se_story_1310_wind", "")
			end

			if arg_307_1.frameCnt_ <= 1 then
				arg_307_1.dialog_:SetActive(false)
			end

			local var_310_20 = 4
			local var_310_21 = 1.85

			if 4 < arg_307_1.time_ and arg_307_1.time_ <= var_310_20 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0

				arg_307_1.dialog_:SetActive(true)

				arg_307_1.dialogCg_.alpha = 0

				local var_310_22 = LeanTween.value(arg_307_1.dialog_, 0, 1, 0.3)

				var_310_22:setOnUpdate(LuaHelper.FloatAction(function(arg_311_0)
					arg_307_1.dialogCg_.alpha = arg_311_0
				end))
				var_310_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_307_1.dialog_)
					var_310_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_307_1.duration_ = arg_307_1.duration_ + 0.3

				SetActive(arg_307_1.leftNameGo_, false)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_307_1.iconTrs_.gameObject, false)
				arg_307_1.callingController_:SetSelectedState("normal")

				local var_310_23 = arg_307_1:FormatText(arg_307_1:GetWordFromCfg(1108409075).content)

				arg_307_1.text_.text = var_310_23

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_25 = 74 <= 0 and var_310_21 or var_310_21 * (utf8.len(var_310_23) / 74)

				if (74 <= 0 and var_310_21 or var_310_21 * (utf8.len(var_310_23) / 74)) > 0 and var_310_21 < var_310_25 then
					arg_307_1.talkMaxDuration = var_310_25
					var_310_20 = var_310_20 + 0.3

					if var_310_25 + var_310_20 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_25 + var_310_20
					end
				end

				arg_307_1.text_.text = var_310_23
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)
				arg_307_1:RecordContent(arg_307_1.text_.text)
			end

			local var_310_26 = var_310_20 + 0.3
			local var_310_27 = math.max(var_310_21, arg_307_1.talkMaxDuration)

			if var_310_20 + 0.3 <= arg_307_1.time_ and arg_307_1.time_ < var_310_26 + var_310_27 then
				arg_307_1.typewritter.percent = (arg_307_1.time_ - var_310_26) / var_310_27

				arg_307_1.typewritter:SetDirty()
			end

			if arg_307_1.time_ >= var_310_26 + var_310_27 and arg_307_1.time_ < var_310_26 + var_310_27 + arg_310_0 then
				arg_307_1.typewritter.percent = 1

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(true)
			end
		end

		arg_307_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_307_1:InitPlayNodeList()
	end,
	Play1108409076 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 1108409076
		arg_313_1.duration_ = 3.6

		SetActive(arg_313_1.tipsGo_, false)

		function arg_313_1.onSingleLineFinish_()
			arg_313_1.onSingleLineUpdate_ = nil
			arg_313_1.onSingleLineFinish_ = nil
			arg_313_1.state_ = "waiting"
		end

		function arg_313_1.playNext_(arg_315_0)
			if arg_315_0 == 1 then
				arg_313_0:Play1108409077(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 then
				arg_313_1.var_.moveOldPos1084ui_story = arg_313_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_316_0 = 0.001

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_0 then
				arg_313_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_313_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_313_1.time_ - 0) / var_316_0)
				arg_313_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_313_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_313_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_313_1.actors_["1084ui_story"].transform.position).z)
				arg_313_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_313_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_313_1.actors_["1084ui_story"].transform.localEulerAngles = arg_313_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_313_1.time_ >= 0 + var_316_0 and arg_313_1.time_ < 0 + var_316_0 + arg_316_0 then
				arg_313_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_313_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_313_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_313_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_313_1.actors_["1084ui_story"].transform.position).z)
				arg_313_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_313_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_313_1.actors_["1084ui_story"].transform.localEulerAngles = arg_313_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_316_1 = arg_313_1.actors_["1084ui_story"]

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 and not isNil(var_316_1) and arg_313_1.var_.characterEffect1084ui_story == nil then
				arg_313_1.var_.characterEffect1084ui_story = var_316_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_316_2 = 0.200000002980232

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_2 and not isNil(var_316_1) then
				if arg_313_1.var_.characterEffect1084ui_story and not isNil(var_316_1) then
					arg_313_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_313_1.time_ >= 0 + var_316_2 and arg_313_1.time_ < 0 + var_316_2 + arg_316_0 and not isNil(var_316_1) and arg_313_1.var_.characterEffect1084ui_story then
				arg_313_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 then
				arg_313_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 then
				arg_313_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_316_4 = 0
			local var_316_5 = 0.45

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= var_316_4 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, true)

				arg_313_1.leftNameTxt_.text = arg_313_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_313_1.leftNameTxt_.transform)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1.leftNameTxt_.text)
				SetActive(arg_313_1.iconTrs_.gameObject, false)
				arg_313_1.callingController_:SetSelectedState("normal")

				local var_316_6 = arg_313_1:GetWordFromCfg(1108409076)
				local var_316_7 = arg_313_1:FormatText(var_316_6.content)

				arg_313_1.text_.text = var_316_7

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_9 = 18 <= 0 and var_316_5 or var_316_5 * (utf8.len(var_316_7) / 18)

				if (18 <= 0 and var_316_5 or var_316_5 * (utf8.len(var_316_7) / 18)) > 0 and var_316_5 < var_316_9 then
					arg_313_1.talkMaxDuration = var_316_9

					if var_316_9 + var_316_4 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_9 + var_316_4
					end
				end

				arg_313_1.text_.text = var_316_7
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409076", "story_v_side_new_1108409.awb") ~= 0 then
					local var_316_10 = manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409076", "story_v_side_new_1108409.awb") / 1000

					if var_316_10 + var_316_4 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_10 + var_316_4
					end

					if var_316_6.prefab_name ~= "" and arg_313_1.actors_[var_316_6.prefab_name] ~= nil then
						local var_316_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_313_1.actors_[var_316_6.prefab_name].transform, "story_v_side_new_1108409", "1108409076", "story_v_side_new_1108409.awb")

						arg_313_1:RecordAudio("1108409076", var_316_11)
						arg_313_1:RecordAudio("1108409076", var_316_11)
					else
						arg_313_1:AudioAction("play", "voice", "story_v_side_new_1108409", "1108409076", "story_v_side_new_1108409.awb")
					end

					arg_313_1:RecordHistoryTalkVoice("story_v_side_new_1108409", "1108409076", "story_v_side_new_1108409.awb")
				end

				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_12 = math.max(var_316_5, arg_313_1.talkMaxDuration)

			if var_316_4 <= arg_313_1.time_ and arg_313_1.time_ < var_316_4 + var_316_12 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_4) / var_316_12

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_4 + var_316_12 and arg_313_1.time_ < var_316_4 + var_316_12 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_313_1:InitPlayNodeList()
	end,
	Play1108409077 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 1108409077
		arg_317_1.duration_ = 5

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play1108409078(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 and not isNil(arg_317_1.actors_["1084ui_story"]) and arg_317_1.var_.characterEffect1084ui_story == nil then
				arg_317_1.var_.characterEffect1084ui_story = arg_317_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_320_0 = 0.200000002980232

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_0 and not isNil(arg_317_1.actors_["1084ui_story"]) then
				if arg_317_1.var_.characterEffect1084ui_story and not isNil(arg_317_1.actors_["1084ui_story"]) then
					arg_317_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_317_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_317_1.time_ - 0) / var_320_0)
				end
			end

			if arg_317_1.time_ >= 0 + var_320_0 and arg_317_1.time_ < 0 + var_320_0 + arg_320_0 and not isNil(arg_317_1.actors_["1084ui_story"]) and arg_317_1.var_.characterEffect1084ui_story then
				arg_317_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_317_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_320_1 = 0
			local var_320_2 = 0.1

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= var_320_1 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, true)

				arg_317_1.leftNameTxt_.text = arg_317_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_317_1.leftNameTxt_.transform)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1.leftNameTxt_.text)
				SetActive(arg_317_1.iconTrs_.gameObject, true)
				arg_317_1.iconController_:SetSelectedState("hero")

				arg_317_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_317_1.callingController_:SetSelectedState("normal")

				arg_317_1.keyicon_.color = Color.New(1, 1, 1)
				arg_317_1.icon_.color = Color.New(1, 1, 1)

				local var_320_3 = arg_317_1:FormatText(arg_317_1:GetWordFromCfg(1108409077).content)

				arg_317_1.text_.text = var_320_3

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_5 = 4 <= 0 and var_320_2 or var_320_2 * (utf8.len(var_320_3) / 4)

				if (4 <= 0 and var_320_2 or var_320_2 * (utf8.len(var_320_3) / 4)) > 0 and var_320_2 < var_320_5 then
					arg_317_1.talkMaxDuration = var_320_5

					if var_320_5 + var_320_1 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_5 + var_320_1
					end
				end

				arg_317_1.text_.text = var_320_3
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)
				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_6 = math.max(var_320_2, arg_317_1.talkMaxDuration)

			if var_320_1 <= arg_317_1.time_ and arg_317_1.time_ < var_320_1 + var_320_6 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - var_320_1) / var_320_6

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= var_320_1 + var_320_6 and arg_317_1.time_ < var_320_1 + var_320_6 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {}

		arg_317_1:InitPlayNodeList()
	end,
	Play1108409078 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 1108409078
		arg_321_1.duration_ = 4.2

		SetActive(arg_321_1.tipsGo_, false)

		function arg_321_1.onSingleLineFinish_()
			arg_321_1.onSingleLineUpdate_ = nil
			arg_321_1.onSingleLineFinish_ = nil
			arg_321_1.state_ = "waiting"
		end

		function arg_321_1.playNext_(arg_323_0)
			if arg_323_0 == 1 then
				arg_321_0:Play1108409079(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 and not isNil(arg_321_1.actors_["1084ui_story"]) and arg_321_1.var_.characterEffect1084ui_story == nil then
				arg_321_1.var_.characterEffect1084ui_story = arg_321_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_324_0 = 0.200000002980232

			if 0 <= arg_321_1.time_ and arg_321_1.time_ < 0 + var_324_0 and not isNil(arg_321_1.actors_["1084ui_story"]) then
				if arg_321_1.var_.characterEffect1084ui_story and not isNil(arg_321_1.actors_["1084ui_story"]) then
					arg_321_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_321_1.time_ >= 0 + var_324_0 and arg_321_1.time_ < 0 + var_324_0 + arg_324_0 and not isNil(arg_321_1.actors_["1084ui_story"]) and arg_321_1.var_.characterEffect1084ui_story then
				arg_321_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 then
				arg_321_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action438")
			end

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 then
				arg_321_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_324_2 = 0
			local var_324_3 = 0.5

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= var_324_2 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, true)

				arg_321_1.leftNameTxt_.text = arg_321_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_321_1.leftNameTxt_.transform)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1.leftNameTxt_.text)
				SetActive(arg_321_1.iconTrs_.gameObject, false)
				arg_321_1.callingController_:SetSelectedState("normal")

				local var_324_4 = arg_321_1:GetWordFromCfg(1108409078)
				local var_324_5 = arg_321_1:FormatText(var_324_4.content)

				arg_321_1.text_.text = var_324_5

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_7 = 20 <= 0 and var_324_3 or var_324_3 * (utf8.len(var_324_5) / 20)

				if (20 <= 0 and var_324_3 or var_324_3 * (utf8.len(var_324_5) / 20)) > 0 and var_324_3 < var_324_7 then
					arg_321_1.talkMaxDuration = var_324_7

					if var_324_7 + var_324_2 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_7 + var_324_2
					end
				end

				arg_321_1.text_.text = var_324_5
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409078", "story_v_side_new_1108409.awb") ~= 0 then
					local var_324_8 = manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409078", "story_v_side_new_1108409.awb") / 1000

					if var_324_8 + var_324_2 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_8 + var_324_2
					end

					if var_324_4.prefab_name ~= "" and arg_321_1.actors_[var_324_4.prefab_name] ~= nil then
						local var_324_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_321_1.actors_[var_324_4.prefab_name].transform, "story_v_side_new_1108409", "1108409078", "story_v_side_new_1108409.awb")

						arg_321_1:RecordAudio("1108409078", var_324_9)
						arg_321_1:RecordAudio("1108409078", var_324_9)
					else
						arg_321_1:AudioAction("play", "voice", "story_v_side_new_1108409", "1108409078", "story_v_side_new_1108409.awb")
					end

					arg_321_1:RecordHistoryTalkVoice("story_v_side_new_1108409", "1108409078", "story_v_side_new_1108409.awb")
				end

				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_10 = math.max(var_324_3, arg_321_1.talkMaxDuration)

			if var_324_2 <= arg_321_1.time_ and arg_321_1.time_ < var_324_2 + var_324_10 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - var_324_2) / var_324_10

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= var_324_2 + var_324_10 and arg_321_1.time_ < var_324_2 + var_324_10 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {}

		arg_321_1:InitPlayNodeList()
	end,
	Play1108409079 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 1108409079
		arg_325_1.duration_ = 5

		SetActive(arg_325_1.tipsGo_, false)

		function arg_325_1.onSingleLineFinish_()
			arg_325_1.onSingleLineUpdate_ = nil
			arg_325_1.onSingleLineFinish_ = nil
			arg_325_1.state_ = "waiting"
		end

		function arg_325_1.playNext_(arg_327_0)
			if arg_327_0 == 1 then
				arg_325_0:Play1108409080(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 and not isNil(arg_325_1.actors_["1084ui_story"]) and arg_325_1.var_.characterEffect1084ui_story == nil then
				arg_325_1.var_.characterEffect1084ui_story = arg_325_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_328_0 = 0.200000002980232

			if 0 <= arg_325_1.time_ and arg_325_1.time_ < 0 + var_328_0 and not isNil(arg_325_1.actors_["1084ui_story"]) then
				if arg_325_1.var_.characterEffect1084ui_story and not isNil(arg_325_1.actors_["1084ui_story"]) then
					arg_325_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_325_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_325_1.time_ - 0) / var_328_0)
				end
			end

			if arg_325_1.time_ >= 0 + var_328_0 and arg_325_1.time_ < 0 + var_328_0 + arg_328_0 and not isNil(arg_325_1.actors_["1084ui_story"]) and arg_325_1.var_.characterEffect1084ui_story then
				arg_325_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_325_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_328_1 = 0
			local var_328_2 = 0.6

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= var_328_1 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, true)

				arg_325_1.leftNameTxt_.text = arg_325_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_325_1.leftNameTxt_.transform)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1.leftNameTxt_.text)
				SetActive(arg_325_1.iconTrs_.gameObject, true)
				arg_325_1.iconController_:SetSelectedState("hero")

				arg_325_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_325_1.callingController_:SetSelectedState("normal")

				arg_325_1.keyicon_.color = Color.New(1, 1, 1)
				arg_325_1.icon_.color = Color.New(1, 1, 1)

				local var_328_3 = arg_325_1:FormatText(arg_325_1:GetWordFromCfg(1108409079).content)

				arg_325_1.text_.text = var_328_3

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_5 = 24 <= 0 and var_328_2 or var_328_2 * (utf8.len(var_328_3) / 24)

				if (24 <= 0 and var_328_2 or var_328_2 * (utf8.len(var_328_3) / 24)) > 0 and var_328_2 < var_328_5 then
					arg_325_1.talkMaxDuration = var_328_5

					if var_328_5 + var_328_1 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_5 + var_328_1
					end
				end

				arg_325_1.text_.text = var_328_3
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)
				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_6 = math.max(var_328_2, arg_325_1.talkMaxDuration)

			if var_328_1 <= arg_325_1.time_ and arg_325_1.time_ < var_328_1 + var_328_6 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - var_328_1) / var_328_6

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= var_328_1 + var_328_6 and arg_325_1.time_ < var_328_1 + var_328_6 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {}

		arg_325_1:InitPlayNodeList()
	end,
	Play1108409080 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 1108409080
		arg_329_1.duration_ = 4.27

		SetActive(arg_329_1.tipsGo_, false)

		function arg_329_1.onSingleLineFinish_()
			arg_329_1.onSingleLineUpdate_ = nil
			arg_329_1.onSingleLineFinish_ = nil
			arg_329_1.state_ = "waiting"
		end

		function arg_329_1.playNext_(arg_331_0)
			if arg_331_0 == 1 then
				arg_329_0:Play1108409081(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 and not isNil(arg_329_1.actors_["1084ui_story"]) and arg_329_1.var_.characterEffect1084ui_story == nil then
				arg_329_1.var_.characterEffect1084ui_story = arg_329_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_332_0 = 0.200000002980232

			if 0 <= arg_329_1.time_ and arg_329_1.time_ < 0 + var_332_0 and not isNil(arg_329_1.actors_["1084ui_story"]) then
				if arg_329_1.var_.characterEffect1084ui_story and not isNil(arg_329_1.actors_["1084ui_story"]) then
					arg_329_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_329_1.time_ >= 0 + var_332_0 and arg_329_1.time_ < 0 + var_332_0 + arg_332_0 and not isNil(arg_329_1.actors_["1084ui_story"]) and arg_329_1.var_.characterEffect1084ui_story then
				arg_329_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 then
				arg_329_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action8_2")
			end

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 then
				arg_329_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_332_2 = 0
			local var_332_3 = 0.85

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= var_332_2 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0
				arg_329_1.dialogCg_.alpha = 1

				arg_329_1.dialog_:SetActive(true)
				SetActive(arg_329_1.leftNameGo_, true)

				arg_329_1.leftNameTxt_.text = arg_329_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_329_1.leftNameTxt_.transform)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1.leftNameTxt_.text)
				SetActive(arg_329_1.iconTrs_.gameObject, false)
				arg_329_1.callingController_:SetSelectedState("normal")

				local var_332_4 = arg_329_1:GetWordFromCfg(1108409080)
				local var_332_5 = arg_329_1:FormatText(var_332_4.content)

				arg_329_1.text_.text = var_332_5

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_7 = 34 <= 0 and var_332_3 or var_332_3 * (utf8.len(var_332_5) / 34)

				if (34 <= 0 and var_332_3 or var_332_3 * (utf8.len(var_332_5) / 34)) > 0 and var_332_3 < var_332_7 then
					arg_329_1.talkMaxDuration = var_332_7

					if var_332_7 + var_332_2 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_7 + var_332_2
					end
				end

				arg_329_1.text_.text = var_332_5
				arg_329_1.typewritter.percent = 0

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409080", "story_v_side_new_1108409.awb") ~= 0 then
					local var_332_8 = manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409080", "story_v_side_new_1108409.awb") / 1000

					if var_332_8 + var_332_2 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_8 + var_332_2
					end

					if var_332_4.prefab_name ~= "" and arg_329_1.actors_[var_332_4.prefab_name] ~= nil then
						local var_332_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_329_1.actors_[var_332_4.prefab_name].transform, "story_v_side_new_1108409", "1108409080", "story_v_side_new_1108409.awb")

						arg_329_1:RecordAudio("1108409080", var_332_9)
						arg_329_1:RecordAudio("1108409080", var_332_9)
					else
						arg_329_1:AudioAction("play", "voice", "story_v_side_new_1108409", "1108409080", "story_v_side_new_1108409.awb")
					end

					arg_329_1:RecordHistoryTalkVoice("story_v_side_new_1108409", "1108409080", "story_v_side_new_1108409.awb")
				end

				arg_329_1:RecordContent(arg_329_1.text_.text)
			end

			local var_332_10 = math.max(var_332_3, arg_329_1.talkMaxDuration)

			if var_332_2 <= arg_329_1.time_ and arg_329_1.time_ < var_332_2 + var_332_10 then
				arg_329_1.typewritter.percent = (arg_329_1.time_ - var_332_2) / var_332_10

				arg_329_1.typewritter:SetDirty()
			end

			if arg_329_1.time_ >= var_332_2 + var_332_10 and arg_329_1.time_ < var_332_2 + var_332_10 + arg_332_0 then
				arg_329_1.typewritter.percent = 1

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(true)
			end
		end

		arg_329_1.nodeConfigList_ = {}

		arg_329_1:InitPlayNodeList()
	end,
	Play1108409081 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 1108409081
		arg_333_1.duration_ = 5

		SetActive(arg_333_1.tipsGo_, false)

		function arg_333_1.onSingleLineFinish_()
			arg_333_1.onSingleLineUpdate_ = nil
			arg_333_1.onSingleLineFinish_ = nil
			arg_333_1.state_ = "waiting"
		end

		function arg_333_1.playNext_(arg_335_0)
			if arg_335_0 == 1 then
				arg_333_0:Play1108409082(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 and not isNil(arg_333_1.actors_["1084ui_story"]) and arg_333_1.var_.characterEffect1084ui_story == nil then
				arg_333_1.var_.characterEffect1084ui_story = arg_333_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_336_0 = 0.200000002980232

			if 0 <= arg_333_1.time_ and arg_333_1.time_ < 0 + var_336_0 and not isNil(arg_333_1.actors_["1084ui_story"]) then
				if arg_333_1.var_.characterEffect1084ui_story and not isNil(arg_333_1.actors_["1084ui_story"]) then
					arg_333_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_333_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_333_1.time_ - 0) / var_336_0)
				end
			end

			if arg_333_1.time_ >= 0 + var_336_0 and arg_333_1.time_ < 0 + var_336_0 + arg_336_0 and not isNil(arg_333_1.actors_["1084ui_story"]) and arg_333_1.var_.characterEffect1084ui_story then
				arg_333_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_333_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_336_1 = 0
			local var_336_2 = 0.9

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= var_336_1 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0
				arg_333_1.dialogCg_.alpha = 1

				arg_333_1.dialog_:SetActive(true)
				SetActive(arg_333_1.leftNameGo_, true)

				arg_333_1.leftNameTxt_.text = arg_333_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_333_1.leftNameTxt_.transform)

				arg_333_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_333_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_333_1:RecordName(arg_333_1.leftNameTxt_.text)
				SetActive(arg_333_1.iconTrs_.gameObject, true)
				arg_333_1.iconController_:SetSelectedState("hero")

				arg_333_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_333_1.callingController_:SetSelectedState("normal")

				arg_333_1.keyicon_.color = Color.New(1, 1, 1)
				arg_333_1.icon_.color = Color.New(1, 1, 1)

				local var_336_3 = arg_333_1:FormatText(arg_333_1:GetWordFromCfg(1108409081).content)

				arg_333_1.text_.text = var_336_3

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_5 = 36 <= 0 and var_336_2 or var_336_2 * (utf8.len(var_336_3) / 36)

				if (36 <= 0 and var_336_2 or var_336_2 * (utf8.len(var_336_3) / 36)) > 0 and var_336_2 < var_336_5 then
					arg_333_1.talkMaxDuration = var_336_5

					if var_336_5 + var_336_1 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_5 + var_336_1
					end
				end

				arg_333_1.text_.text = var_336_3
				arg_333_1.typewritter.percent = 0

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(false)
				arg_333_1:RecordContent(arg_333_1.text_.text)
			end

			local var_336_6 = math.max(var_336_2, arg_333_1.talkMaxDuration)

			if var_336_1 <= arg_333_1.time_ and arg_333_1.time_ < var_336_1 + var_336_6 then
				arg_333_1.typewritter.percent = (arg_333_1.time_ - var_336_1) / var_336_6

				arg_333_1.typewritter:SetDirty()
			end

			if arg_333_1.time_ >= var_336_1 + var_336_6 and arg_333_1.time_ < var_336_1 + var_336_6 + arg_336_0 then
				arg_333_1.typewritter.percent = 1

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(true)
			end
		end

		arg_333_1.nodeConfigList_ = {}

		arg_333_1:InitPlayNodeList()
	end,
	Play1108409082 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 1108409082
		arg_337_1.duration_ = 5

		SetActive(arg_337_1.tipsGo_, false)

		function arg_337_1.onSingleLineFinish_()
			arg_337_1.onSingleLineUpdate_ = nil
			arg_337_1.onSingleLineFinish_ = nil
			arg_337_1.state_ = "waiting"
		end

		function arg_337_1.playNext_(arg_339_0)
			if arg_339_0 == 1 then
				arg_337_0:Play1108409083(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			local var_340_0 = 1.05

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0
				arg_337_1.dialogCg_.alpha = 1

				arg_337_1.dialog_:SetActive(true)
				SetActive(arg_337_1.leftNameGo_, false)

				arg_337_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_337_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_337_1:RecordName(arg_337_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_337_1.iconTrs_.gameObject, false)
				arg_337_1.callingController_:SetSelectedState("normal")

				local var_340_1 = arg_337_1:FormatText(arg_337_1:GetWordFromCfg(1108409082).content)

				arg_337_1.text_.text = var_340_1

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_3 = 42 <= 0 and var_340_0 or var_340_0 * (utf8.len(var_340_1) / 42)

				if (42 <= 0 and var_340_0 or var_340_0 * (utf8.len(var_340_1) / 42)) > 0 and var_340_0 < var_340_3 then
					arg_337_1.talkMaxDuration = var_340_3

					if var_340_3 + 0 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_3 + 0
					end
				end

				arg_337_1.text_.text = var_340_1
				arg_337_1.typewritter.percent = 0

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(false)
				arg_337_1:RecordContent(arg_337_1.text_.text)
			end

			local var_340_4 = math.max(var_340_0, arg_337_1.talkMaxDuration)

			if 0 <= arg_337_1.time_ and arg_337_1.time_ < 0 + var_340_4 then
				arg_337_1.typewritter.percent = (arg_337_1.time_ - 0) / var_340_4

				arg_337_1.typewritter:SetDirty()
			end

			if arg_337_1.time_ >= 0 + var_340_4 and arg_337_1.time_ < 0 + var_340_4 + arg_340_0 then
				arg_337_1.typewritter.percent = 1

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(true)
			end
		end

		arg_337_1.nodeConfigList_ = {}

		arg_337_1:InitPlayNodeList()
	end,
	Play1108409083 = function(arg_341_0, arg_341_1)
		arg_341_1.time_ = 0
		arg_341_1.frameCnt_ = 0
		arg_341_1.state_ = "playing"
		arg_341_1.curTalkId_ = 1108409083
		arg_341_1.duration_ = 3.3

		SetActive(arg_341_1.tipsGo_, false)

		function arg_341_1.onSingleLineFinish_()
			arg_341_1.onSingleLineUpdate_ = nil
			arg_341_1.onSingleLineFinish_ = nil
			arg_341_1.state_ = "waiting"
		end

		function arg_341_1.playNext_(arg_343_0)
			if arg_343_0 == 1 then
				arg_341_0:Play1108409084(arg_341_1)
			end
		end

		function arg_341_1.onSingleLineUpdate_(arg_344_0)
			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 and not isNil(arg_341_1.actors_["1084ui_story"]) and arg_341_1.var_.characterEffect1084ui_story == nil then
				arg_341_1.var_.characterEffect1084ui_story = arg_341_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_344_0 = 0.200000002980232

			if 0 <= arg_341_1.time_ and arg_341_1.time_ < 0 + var_344_0 and not isNil(arg_341_1.actors_["1084ui_story"]) then
				if arg_341_1.var_.characterEffect1084ui_story and not isNil(arg_341_1.actors_["1084ui_story"]) then
					arg_341_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_341_1.time_ >= 0 + var_344_0 and arg_341_1.time_ < 0 + var_344_0 + arg_344_0 and not isNil(arg_341_1.actors_["1084ui_story"]) and arg_341_1.var_.characterEffect1084ui_story then
				arg_341_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 then
				arg_341_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action8_1")
			end

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 then
				arg_341_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_344_2 = 0
			local var_344_3 = 0.7

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= var_344_2 + arg_344_0 then
				arg_341_1.talkMaxDuration = 0
				arg_341_1.dialogCg_.alpha = 1

				arg_341_1.dialog_:SetActive(true)
				SetActive(arg_341_1.leftNameGo_, true)

				arg_341_1.leftNameTxt_.text = arg_341_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_341_1.leftNameTxt_.transform)

				arg_341_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_341_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_341_1:RecordName(arg_341_1.leftNameTxt_.text)
				SetActive(arg_341_1.iconTrs_.gameObject, false)
				arg_341_1.callingController_:SetSelectedState("normal")

				local var_344_4 = arg_341_1:GetWordFromCfg(1108409083)
				local var_344_5 = arg_341_1:FormatText(var_344_4.content)

				arg_341_1.text_.text = var_344_5

				LuaForUtil.ClearLinePrefixSymbol(arg_341_1.text_)

				local var_344_7 = 28 <= 0 and var_344_3 or var_344_3 * (utf8.len(var_344_5) / 28)

				if (28 <= 0 and var_344_3 or var_344_3 * (utf8.len(var_344_5) / 28)) > 0 and var_344_3 < var_344_7 then
					arg_341_1.talkMaxDuration = var_344_7

					if var_344_7 + var_344_2 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_7 + var_344_2
					end
				end

				arg_341_1.text_.text = var_344_5
				arg_341_1.typewritter.percent = 0

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409083", "story_v_side_new_1108409.awb") ~= 0 then
					local var_344_8 = manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409083", "story_v_side_new_1108409.awb") / 1000

					if var_344_8 + var_344_2 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_8 + var_344_2
					end

					if var_344_4.prefab_name ~= "" and arg_341_1.actors_[var_344_4.prefab_name] ~= nil then
						local var_344_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_341_1.actors_[var_344_4.prefab_name].transform, "story_v_side_new_1108409", "1108409083", "story_v_side_new_1108409.awb")

						arg_341_1:RecordAudio("1108409083", var_344_9)
						arg_341_1:RecordAudio("1108409083", var_344_9)
					else
						arg_341_1:AudioAction("play", "voice", "story_v_side_new_1108409", "1108409083", "story_v_side_new_1108409.awb")
					end

					arg_341_1:RecordHistoryTalkVoice("story_v_side_new_1108409", "1108409083", "story_v_side_new_1108409.awb")
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
	Play1108409084 = function(arg_345_0, arg_345_1)
		arg_345_1.time_ = 0
		arg_345_1.frameCnt_ = 0
		arg_345_1.state_ = "playing"
		arg_345_1.curTalkId_ = 1108409084
		arg_345_1.duration_ = 5

		SetActive(arg_345_1.tipsGo_, false)

		function arg_345_1.onSingleLineFinish_()
			arg_345_1.onSingleLineUpdate_ = nil
			arg_345_1.onSingleLineFinish_ = nil
			arg_345_1.state_ = "waiting"
		end

		function arg_345_1.playNext_(arg_347_0)
			if arg_347_0 == 1 then
				arg_345_0:Play1108409085(arg_345_1)
			end
		end

		function arg_345_1.onSingleLineUpdate_(arg_348_0)
			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 and not isNil(arg_345_1.actors_["1084ui_story"]) and arg_345_1.var_.characterEffect1084ui_story == nil then
				arg_345_1.var_.characterEffect1084ui_story = arg_345_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_348_0 = 0.200000002980232

			if 0 <= arg_345_1.time_ and arg_345_1.time_ < 0 + var_348_0 and not isNil(arg_345_1.actors_["1084ui_story"]) then
				if arg_345_1.var_.characterEffect1084ui_story and not isNil(arg_345_1.actors_["1084ui_story"]) then
					arg_345_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_345_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_345_1.time_ - 0) / var_348_0)
				end
			end

			if arg_345_1.time_ >= 0 + var_348_0 and arg_345_1.time_ < 0 + var_348_0 + arg_348_0 and not isNil(arg_345_1.actors_["1084ui_story"]) and arg_345_1.var_.characterEffect1084ui_story then
				arg_345_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_345_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_348_1 = 0
			local var_348_2 = 0.1

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= var_348_1 + arg_348_0 then
				arg_345_1.talkMaxDuration = 0
				arg_345_1.dialogCg_.alpha = 1

				arg_345_1.dialog_:SetActive(true)
				SetActive(arg_345_1.leftNameGo_, true)

				arg_345_1.leftNameTxt_.text = arg_345_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_345_1.leftNameTxt_.transform)

				arg_345_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_345_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_345_1:RecordName(arg_345_1.leftNameTxt_.text)
				SetActive(arg_345_1.iconTrs_.gameObject, true)
				arg_345_1.iconController_:SetSelectedState("hero")

				arg_345_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_345_1.callingController_:SetSelectedState("normal")

				arg_345_1.keyicon_.color = Color.New(1, 1, 1)
				arg_345_1.icon_.color = Color.New(1, 1, 1)

				local var_348_3 = arg_345_1:FormatText(arg_345_1:GetWordFromCfg(1108409084).content)

				arg_345_1.text_.text = var_348_3

				LuaForUtil.ClearLinePrefixSymbol(arg_345_1.text_)

				local var_348_5 = 4 <= 0 and var_348_2 or var_348_2 * (utf8.len(var_348_3) / 4)

				if (4 <= 0 and var_348_2 or var_348_2 * (utf8.len(var_348_3) / 4)) > 0 and var_348_2 < var_348_5 then
					arg_345_1.talkMaxDuration = var_348_5

					if var_348_5 + var_348_1 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_5 + var_348_1
					end
				end

				arg_345_1.text_.text = var_348_3
				arg_345_1.typewritter.percent = 0

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(false)
				arg_345_1:RecordContent(arg_345_1.text_.text)
			end

			local var_348_6 = math.max(var_348_2, arg_345_1.talkMaxDuration)

			if var_348_1 <= arg_345_1.time_ and arg_345_1.time_ < var_348_1 + var_348_6 then
				arg_345_1.typewritter.percent = (arg_345_1.time_ - var_348_1) / var_348_6

				arg_345_1.typewritter:SetDirty()
			end

			if arg_345_1.time_ >= var_348_1 + var_348_6 and arg_345_1.time_ < var_348_1 + var_348_6 + arg_348_0 then
				arg_345_1.typewritter.percent = 1

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(true)
			end
		end

		arg_345_1.nodeConfigList_ = {}

		arg_345_1:InitPlayNodeList()
	end,
	Play1108409085 = function(arg_349_0, arg_349_1)
		arg_349_1.time_ = 0
		arg_349_1.frameCnt_ = 0
		arg_349_1.state_ = "playing"
		arg_349_1.curTalkId_ = 1108409085
		arg_349_1.duration_ = 5

		SetActive(arg_349_1.tipsGo_, false)

		function arg_349_1.onSingleLineFinish_()
			arg_349_1.onSingleLineUpdate_ = nil
			arg_349_1.onSingleLineFinish_ = nil
			arg_349_1.state_ = "waiting"
		end

		function arg_349_1.playNext_(arg_351_0)
			if arg_351_0 == 1 then
				arg_349_0:Play1108409086(arg_349_1)
			end
		end

		function arg_349_1.onSingleLineUpdate_(arg_352_0)
			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 then
				arg_349_1.var_.moveOldPos1084ui_story = arg_349_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_352_0 = 0.001

			if 0 <= arg_349_1.time_ and arg_349_1.time_ < 0 + var_352_0 then
				arg_349_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_349_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_349_1.time_ - 0) / var_352_0)
				arg_349_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_349_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_349_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_349_1.actors_["1084ui_story"].transform.position).z)
				arg_349_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_349_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_349_1.actors_["1084ui_story"].transform.localEulerAngles = arg_349_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_349_1.time_ >= 0 + var_352_0 and arg_349_1.time_ < 0 + var_352_0 + arg_352_0 then
				arg_349_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_349_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_349_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_349_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_349_1.actors_["1084ui_story"].transform.position).z)
				arg_349_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_349_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_349_1.actors_["1084ui_story"].transform.localEulerAngles = arg_349_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_352_1 = 0
			local var_352_2 = 1.4

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= var_352_1 + arg_352_0 then
				arg_349_1.talkMaxDuration = 0
				arg_349_1.dialogCg_.alpha = 1

				arg_349_1.dialog_:SetActive(true)
				SetActive(arg_349_1.leftNameGo_, false)

				arg_349_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_349_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_349_1:RecordName(arg_349_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_349_1.iconTrs_.gameObject, false)
				arg_349_1.callingController_:SetSelectedState("normal")

				local var_352_3 = arg_349_1:FormatText(arg_349_1:GetWordFromCfg(1108409085).content)

				arg_349_1.text_.text = var_352_3

				LuaForUtil.ClearLinePrefixSymbol(arg_349_1.text_)

				local var_352_5 = 56 <= 0 and var_352_2 or var_352_2 * (utf8.len(var_352_3) / 56)

				if (56 <= 0 and var_352_2 or var_352_2 * (utf8.len(var_352_3) / 56)) > 0 and var_352_2 < var_352_5 then
					arg_349_1.talkMaxDuration = var_352_5

					if var_352_5 + var_352_1 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_5 + var_352_1
					end
				end

				arg_349_1.text_.text = var_352_3
				arg_349_1.typewritter.percent = 0

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(false)
				arg_349_1:RecordContent(arg_349_1.text_.text)
			end

			local var_352_6 = math.max(var_352_2, arg_349_1.talkMaxDuration)

			if var_352_1 <= arg_349_1.time_ and arg_349_1.time_ < var_352_1 + var_352_6 then
				arg_349_1.typewritter.percent = (arg_349_1.time_ - var_352_1) / var_352_6

				arg_349_1.typewritter:SetDirty()
			end

			if arg_349_1.time_ >= var_352_1 + var_352_6 and arg_349_1.time_ < var_352_1 + var_352_6 + arg_352_0 then
				arg_349_1.typewritter.percent = 1

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(true)
			end
		end

		arg_349_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_349_1:InitPlayNodeList()
	end,
	Play1108409086 = function(arg_353_0, arg_353_1)
		arg_353_1.time_ = 0
		arg_353_1.frameCnt_ = 0
		arg_353_1.state_ = "playing"
		arg_353_1.curTalkId_ = 1108409086
		arg_353_1.duration_ = 2

		SetActive(arg_353_1.tipsGo_, false)

		function arg_353_1.onSingleLineFinish_()
			arg_353_1.onSingleLineUpdate_ = nil
			arg_353_1.onSingleLineFinish_ = nil
			arg_353_1.state_ = "waiting"
		end

		function arg_353_1.playNext_(arg_355_0)
			if arg_355_0 == 1 then
				arg_353_0:Play1108409087(arg_353_1)
			end
		end

		function arg_353_1.onSingleLineUpdate_(arg_356_0)
			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 then
				arg_353_1.var_.moveOldPos1084ui_story = arg_353_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_356_0 = 0.001

			if 0 <= arg_353_1.time_ and arg_353_1.time_ < 0 + var_356_0 then
				arg_353_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_353_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_353_1.time_ - 0) / var_356_0)
				arg_353_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_353_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_353_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_353_1.actors_["1084ui_story"].transform.position).z)
				arg_353_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_353_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_353_1.actors_["1084ui_story"].transform.localEulerAngles = arg_353_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_353_1.time_ >= 0 + var_356_0 and arg_353_1.time_ < 0 + var_356_0 + arg_356_0 then
				arg_353_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_353_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_353_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_353_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_353_1.actors_["1084ui_story"].transform.position).z)
				arg_353_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_353_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_353_1.actors_["1084ui_story"].transform.localEulerAngles = arg_353_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_356_1 = arg_353_1.actors_["1084ui_story"]

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 and not isNil(var_356_1) and arg_353_1.var_.characterEffect1084ui_story == nil then
				arg_353_1.var_.characterEffect1084ui_story = var_356_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_356_2 = 0.200000002980232

			if 0 <= arg_353_1.time_ and arg_353_1.time_ < 0 + var_356_2 and not isNil(var_356_1) then
				if arg_353_1.var_.characterEffect1084ui_story and not isNil(var_356_1) then
					arg_353_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_353_1.time_ >= 0 + var_356_2 and arg_353_1.time_ < 0 + var_356_2 + arg_356_0 and not isNil(var_356_1) and arg_353_1.var_.characterEffect1084ui_story then
				arg_353_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 then
				arg_353_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action8_2")
			end

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 then
				arg_353_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_356_4 = 0
			local var_356_5 = 0.175

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= var_356_4 + arg_356_0 then
				arg_353_1.talkMaxDuration = 0
				arg_353_1.dialogCg_.alpha = 1

				arg_353_1.dialog_:SetActive(true)
				SetActive(arg_353_1.leftNameGo_, true)

				arg_353_1.leftNameTxt_.text = arg_353_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_353_1.leftNameTxt_.transform)

				arg_353_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_353_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_353_1:RecordName(arg_353_1.leftNameTxt_.text)
				SetActive(arg_353_1.iconTrs_.gameObject, false)
				arg_353_1.callingController_:SetSelectedState("normal")

				local var_356_6 = arg_353_1:GetWordFromCfg(1108409086)
				local var_356_7 = arg_353_1:FormatText(var_356_6.content)

				arg_353_1.text_.text = var_356_7

				LuaForUtil.ClearLinePrefixSymbol(arg_353_1.text_)

				local var_356_9 = 7 <= 0 and var_356_5 or var_356_5 * (utf8.len(var_356_7) / 7)

				if (7 <= 0 and var_356_5 or var_356_5 * (utf8.len(var_356_7) / 7)) > 0 and var_356_5 < var_356_9 then
					arg_353_1.talkMaxDuration = var_356_9

					if var_356_9 + var_356_4 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_9 + var_356_4
					end
				end

				arg_353_1.text_.text = var_356_7
				arg_353_1.typewritter.percent = 0

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409086", "story_v_side_new_1108409.awb") ~= 0 then
					local var_356_10 = manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409086", "story_v_side_new_1108409.awb") / 1000

					if var_356_10 + var_356_4 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_10 + var_356_4
					end

					if var_356_6.prefab_name ~= "" and arg_353_1.actors_[var_356_6.prefab_name] ~= nil then
						local var_356_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_353_1.actors_[var_356_6.prefab_name].transform, "story_v_side_new_1108409", "1108409086", "story_v_side_new_1108409.awb")

						arg_353_1:RecordAudio("1108409086", var_356_11)
						arg_353_1:RecordAudio("1108409086", var_356_11)
					else
						arg_353_1:AudioAction("play", "voice", "story_v_side_new_1108409", "1108409086", "story_v_side_new_1108409.awb")
					end

					arg_353_1:RecordHistoryTalkVoice("story_v_side_new_1108409", "1108409086", "story_v_side_new_1108409.awb")
				end

				arg_353_1:RecordContent(arg_353_1.text_.text)
			end

			local var_356_12 = math.max(var_356_5, arg_353_1.talkMaxDuration)

			if var_356_4 <= arg_353_1.time_ and arg_353_1.time_ < var_356_4 + var_356_12 then
				arg_353_1.typewritter.percent = (arg_353_1.time_ - var_356_4) / var_356_12

				arg_353_1.typewritter:SetDirty()
			end

			if arg_353_1.time_ >= var_356_4 + var_356_12 and arg_353_1.time_ < var_356_4 + var_356_12 + arg_356_0 then
				arg_353_1.typewritter.percent = 1

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(true)
			end
		end

		arg_353_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_353_1:InitPlayNodeList()
	end,
	Play1108409087 = function(arg_357_0, arg_357_1)
		arg_357_1.time_ = 0
		arg_357_1.frameCnt_ = 0
		arg_357_1.state_ = "playing"
		arg_357_1.curTalkId_ = 1108409087
		arg_357_1.duration_ = 5

		SetActive(arg_357_1.tipsGo_, false)

		function arg_357_1.onSingleLineFinish_()
			arg_357_1.onSingleLineUpdate_ = nil
			arg_357_1.onSingleLineFinish_ = nil
			arg_357_1.state_ = "waiting"
		end

		function arg_357_1.playNext_(arg_359_0)
			if arg_359_0 == 1 then
				arg_357_0:Play1108409088(arg_357_1)
			end
		end

		function arg_357_1.onSingleLineUpdate_(arg_360_0)
			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 and not isNil(arg_357_1.actors_["1084ui_story"]) and arg_357_1.var_.characterEffect1084ui_story == nil then
				arg_357_1.var_.characterEffect1084ui_story = arg_357_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_360_0 = 0.200000002980232

			if 0 <= arg_357_1.time_ and arg_357_1.time_ < 0 + var_360_0 and not isNil(arg_357_1.actors_["1084ui_story"]) then
				if arg_357_1.var_.characterEffect1084ui_story and not isNil(arg_357_1.actors_["1084ui_story"]) then
					arg_357_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_357_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_357_1.time_ - 0) / var_360_0)
				end
			end

			if arg_357_1.time_ >= 0 + var_360_0 and arg_357_1.time_ < 0 + var_360_0 + arg_360_0 and not isNil(arg_357_1.actors_["1084ui_story"]) and arg_357_1.var_.characterEffect1084ui_story then
				arg_357_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_357_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_360_1 = 0
			local var_360_2 = 0.125

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= var_360_1 + arg_360_0 then
				arg_357_1.talkMaxDuration = 0
				arg_357_1.dialogCg_.alpha = 1

				arg_357_1.dialog_:SetActive(true)
				SetActive(arg_357_1.leftNameGo_, true)

				arg_357_1.leftNameTxt_.text = arg_357_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_357_1.leftNameTxt_.transform)

				arg_357_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_357_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_357_1:RecordName(arg_357_1.leftNameTxt_.text)
				SetActive(arg_357_1.iconTrs_.gameObject, true)
				arg_357_1.iconController_:SetSelectedState("hero")

				arg_357_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_357_1.callingController_:SetSelectedState("normal")

				arg_357_1.keyicon_.color = Color.New(1, 1, 1)
				arg_357_1.icon_.color = Color.New(1, 1, 1)

				local var_360_3 = arg_357_1:FormatText(arg_357_1:GetWordFromCfg(1108409087).content)

				arg_357_1.text_.text = var_360_3

				LuaForUtil.ClearLinePrefixSymbol(arg_357_1.text_)

				local var_360_5 = 5 <= 0 and var_360_2 or var_360_2 * (utf8.len(var_360_3) / 5)

				if (5 <= 0 and var_360_2 or var_360_2 * (utf8.len(var_360_3) / 5)) > 0 and var_360_2 < var_360_5 then
					arg_357_1.talkMaxDuration = var_360_5

					if var_360_5 + var_360_1 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_5 + var_360_1
					end
				end

				arg_357_1.text_.text = var_360_3
				arg_357_1.typewritter.percent = 0

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(false)
				arg_357_1:RecordContent(arg_357_1.text_.text)
			end

			local var_360_6 = math.max(var_360_2, arg_357_1.talkMaxDuration)

			if var_360_1 <= arg_357_1.time_ and arg_357_1.time_ < var_360_1 + var_360_6 then
				arg_357_1.typewritter.percent = (arg_357_1.time_ - var_360_1) / var_360_6

				arg_357_1.typewritter:SetDirty()
			end

			if arg_357_1.time_ >= var_360_1 + var_360_6 and arg_357_1.time_ < var_360_1 + var_360_6 + arg_360_0 then
				arg_357_1.typewritter.percent = 1

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(true)
			end
		end

		arg_357_1.nodeConfigList_ = {}

		arg_357_1:InitPlayNodeList()
	end,
	Play1108409088 = function(arg_361_0, arg_361_1)
		arg_361_1.time_ = 0
		arg_361_1.frameCnt_ = 0
		arg_361_1.state_ = "playing"
		arg_361_1.curTalkId_ = 1108409088
		arg_361_1.duration_ = 5

		SetActive(arg_361_1.tipsGo_, false)

		function arg_361_1.onSingleLineFinish_()
			arg_361_1.onSingleLineUpdate_ = nil
			arg_361_1.onSingleLineFinish_ = nil
			arg_361_1.state_ = "waiting"
		end

		function arg_361_1.playNext_(arg_363_0)
			if arg_363_0 == 1 then
				arg_361_0:Play1108409089(arg_361_1)
			end
		end

		function arg_361_1.onSingleLineUpdate_(arg_364_0)
			if 0 < arg_361_1.time_ and arg_361_1.time_ <= 0 + arg_364_0 then
				arg_361_1.var_.moveOldPos1084ui_story = arg_361_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_364_0 = 0.001

			if 0 <= arg_361_1.time_ and arg_361_1.time_ < 0 + var_364_0 then
				arg_361_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_361_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_361_1.time_ - 0) / var_364_0)
				arg_361_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_361_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_361_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_361_1.actors_["1084ui_story"].transform.position).z)
				arg_361_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_361_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_361_1.actors_["1084ui_story"].transform.localEulerAngles = arg_361_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_361_1.time_ >= 0 + var_364_0 and arg_361_1.time_ < 0 + var_364_0 + arg_364_0 then
				arg_361_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_361_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_361_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_361_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_361_1.actors_["1084ui_story"].transform.position).z)
				arg_361_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_361_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_361_1.actors_["1084ui_story"].transform.localEulerAngles = arg_361_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_364_1 = 0
			local var_364_2 = 1.45

			if 0 < arg_361_1.time_ and arg_361_1.time_ <= var_364_1 + arg_364_0 then
				arg_361_1.talkMaxDuration = 0
				arg_361_1.dialogCg_.alpha = 1

				arg_361_1.dialog_:SetActive(true)
				SetActive(arg_361_1.leftNameGo_, false)

				arg_361_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_361_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_361_1:RecordName(arg_361_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_361_1.iconTrs_.gameObject, false)
				arg_361_1.callingController_:SetSelectedState("normal")

				local var_364_3 = arg_361_1:FormatText(arg_361_1:GetWordFromCfg(1108409088).content)

				arg_361_1.text_.text = var_364_3

				LuaForUtil.ClearLinePrefixSymbol(arg_361_1.text_)

				local var_364_5 = 58 <= 0 and var_364_2 or var_364_2 * (utf8.len(var_364_3) / 58)

				if (58 <= 0 and var_364_2 or var_364_2 * (utf8.len(var_364_3) / 58)) > 0 and var_364_2 < var_364_5 then
					arg_361_1.talkMaxDuration = var_364_5

					if var_364_5 + var_364_1 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_5 + var_364_1
					end
				end

				arg_361_1.text_.text = var_364_3
				arg_361_1.typewritter.percent = 0

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(false)
				arg_361_1:RecordContent(arg_361_1.text_.text)
			end

			local var_364_6 = math.max(var_364_2, arg_361_1.talkMaxDuration)

			if var_364_1 <= arg_361_1.time_ and arg_361_1.time_ < var_364_1 + var_364_6 then
				arg_361_1.typewritter.percent = (arg_361_1.time_ - var_364_1) / var_364_6

				arg_361_1.typewritter:SetDirty()
			end

			if arg_361_1.time_ >= var_364_1 + var_364_6 and arg_361_1.time_ < var_364_1 + var_364_6 + arg_364_0 then
				arg_361_1.typewritter.percent = 1

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(true)
			end
		end

		arg_361_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_361_1:InitPlayNodeList()
	end,
	Play1108409089 = function(arg_365_0, arg_365_1)
		arg_365_1.time_ = 0
		arg_365_1.frameCnt_ = 0
		arg_365_1.state_ = "playing"
		arg_365_1.curTalkId_ = 1108409089
		arg_365_1.duration_ = 6.53

		SetActive(arg_365_1.tipsGo_, false)

		function arg_365_1.onSingleLineFinish_()
			arg_365_1.onSingleLineUpdate_ = nil
			arg_365_1.onSingleLineFinish_ = nil
			arg_365_1.state_ = "waiting"
		end

		function arg_365_1.playNext_(arg_367_0)
			if arg_367_0 == 1 then
				arg_365_0:Play1108409090(arg_365_1)
			end
		end

		function arg_365_1.onSingleLineUpdate_(arg_368_0)
			if 0 < arg_365_1.time_ and arg_365_1.time_ <= 0 + arg_368_0 then
				arg_365_1.var_.moveOldPos1084ui_story = arg_365_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_368_0 = 0.001

			if 0 <= arg_365_1.time_ and arg_365_1.time_ < 0 + var_368_0 then
				arg_365_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_365_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_365_1.time_ - 0) / var_368_0)
				arg_365_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_365_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_365_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_365_1.actors_["1084ui_story"].transform.position).z)
				arg_365_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_365_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_365_1.actors_["1084ui_story"].transform.localEulerAngles = arg_365_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_365_1.time_ >= 0 + var_368_0 and arg_365_1.time_ < 0 + var_368_0 + arg_368_0 then
				arg_365_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_365_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_365_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_365_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_365_1.actors_["1084ui_story"].transform.position).z)
				arg_365_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_365_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_365_1.actors_["1084ui_story"].transform.localEulerAngles = arg_365_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_368_1 = arg_365_1.actors_["1084ui_story"]

			if 0 < arg_365_1.time_ and arg_365_1.time_ <= 0 + arg_368_0 and not isNil(var_368_1) and arg_365_1.var_.characterEffect1084ui_story == nil then
				arg_365_1.var_.characterEffect1084ui_story = var_368_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_368_2 = 0.200000002980232

			if 0 <= arg_365_1.time_ and arg_365_1.time_ < 0 + var_368_2 and not isNil(var_368_1) then
				if arg_365_1.var_.characterEffect1084ui_story and not isNil(var_368_1) then
					arg_365_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_365_1.time_ >= 0 + var_368_2 and arg_365_1.time_ < 0 + var_368_2 + arg_368_0 and not isNil(var_368_1) and arg_365_1.var_.characterEffect1084ui_story then
				arg_365_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_365_1.time_ and arg_365_1.time_ <= 0 + arg_368_0 then
				arg_365_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			if 0 < arg_365_1.time_ and arg_365_1.time_ <= 0 + arg_368_0 then
				arg_365_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_368_4 = 0
			local var_368_5 = 0.85

			if 0 < arg_365_1.time_ and arg_365_1.time_ <= var_368_4 + arg_368_0 then
				arg_365_1.talkMaxDuration = 0
				arg_365_1.dialogCg_.alpha = 1

				arg_365_1.dialog_:SetActive(true)
				SetActive(arg_365_1.leftNameGo_, true)

				arg_365_1.leftNameTxt_.text = arg_365_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_365_1.leftNameTxt_.transform)

				arg_365_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_365_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_365_1:RecordName(arg_365_1.leftNameTxt_.text)
				SetActive(arg_365_1.iconTrs_.gameObject, false)
				arg_365_1.callingController_:SetSelectedState("normal")

				local var_368_6 = arg_365_1:GetWordFromCfg(1108409089)
				local var_368_7 = arg_365_1:FormatText(var_368_6.content)

				arg_365_1.text_.text = var_368_7

				LuaForUtil.ClearLinePrefixSymbol(arg_365_1.text_)

				local var_368_9 = 34 <= 0 and var_368_5 or var_368_5 * (utf8.len(var_368_7) / 34)

				if (34 <= 0 and var_368_5 or var_368_5 * (utf8.len(var_368_7) / 34)) > 0 and var_368_5 < var_368_9 then
					arg_365_1.talkMaxDuration = var_368_9

					if var_368_9 + var_368_4 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_9 + var_368_4
					end
				end

				arg_365_1.text_.text = var_368_7
				arg_365_1.typewritter.percent = 0

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409089", "story_v_side_new_1108409.awb") ~= 0 then
					local var_368_10 = manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409089", "story_v_side_new_1108409.awb") / 1000

					if var_368_10 + var_368_4 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_10 + var_368_4
					end

					if var_368_6.prefab_name ~= "" and arg_365_1.actors_[var_368_6.prefab_name] ~= nil then
						local var_368_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_365_1.actors_[var_368_6.prefab_name].transform, "story_v_side_new_1108409", "1108409089", "story_v_side_new_1108409.awb")

						arg_365_1:RecordAudio("1108409089", var_368_11)
						arg_365_1:RecordAudio("1108409089", var_368_11)
					else
						arg_365_1:AudioAction("play", "voice", "story_v_side_new_1108409", "1108409089", "story_v_side_new_1108409.awb")
					end

					arg_365_1:RecordHistoryTalkVoice("story_v_side_new_1108409", "1108409089", "story_v_side_new_1108409.awb")
				end

				arg_365_1:RecordContent(arg_365_1.text_.text)
			end

			local var_368_12 = math.max(var_368_5, arg_365_1.talkMaxDuration)

			if var_368_4 <= arg_365_1.time_ and arg_365_1.time_ < var_368_4 + var_368_12 then
				arg_365_1.typewritter.percent = (arg_365_1.time_ - var_368_4) / var_368_12

				arg_365_1.typewritter:SetDirty()
			end

			if arg_365_1.time_ >= var_368_4 + var_368_12 and arg_365_1.time_ < var_368_4 + var_368_12 + arg_368_0 then
				arg_365_1.typewritter.percent = 1

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(true)
			end
		end

		arg_365_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_365_1:InitPlayNodeList()
	end,
	Play1108409090 = function(arg_369_0, arg_369_1)
		arg_369_1.time_ = 0
		arg_369_1.frameCnt_ = 0
		arg_369_1.state_ = "playing"
		arg_369_1.curTalkId_ = 1108409090
		arg_369_1.duration_ = 5

		SetActive(arg_369_1.tipsGo_, false)

		function arg_369_1.onSingleLineFinish_()
			arg_369_1.onSingleLineUpdate_ = nil
			arg_369_1.onSingleLineFinish_ = nil
			arg_369_1.state_ = "waiting"
		end

		function arg_369_1.playNext_(arg_371_0)
			if arg_371_0 == 1 then
				arg_369_0:Play1108409091(arg_369_1)
			end
		end

		function arg_369_1.onSingleLineUpdate_(arg_372_0)
			if 0 < arg_369_1.time_ and arg_369_1.time_ <= 0 + arg_372_0 and not isNil(arg_369_1.actors_["1084ui_story"]) and arg_369_1.var_.characterEffect1084ui_story == nil then
				arg_369_1.var_.characterEffect1084ui_story = arg_369_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_372_0 = 0.200000002980232

			if 0 <= arg_369_1.time_ and arg_369_1.time_ < 0 + var_372_0 and not isNil(arg_369_1.actors_["1084ui_story"]) then
				if arg_369_1.var_.characterEffect1084ui_story and not isNil(arg_369_1.actors_["1084ui_story"]) then
					arg_369_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_369_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_369_1.time_ - 0) / var_372_0)
				end
			end

			if arg_369_1.time_ >= 0 + var_372_0 and arg_369_1.time_ < 0 + var_372_0 + arg_372_0 and not isNil(arg_369_1.actors_["1084ui_story"]) and arg_369_1.var_.characterEffect1084ui_story then
				arg_369_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_369_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_372_1 = 0
			local var_372_2 = 0.5

			if 0 < arg_369_1.time_ and arg_369_1.time_ <= var_372_1 + arg_372_0 then
				arg_369_1.talkMaxDuration = 0
				arg_369_1.dialogCg_.alpha = 1

				arg_369_1.dialog_:SetActive(true)
				SetActive(arg_369_1.leftNameGo_, true)

				arg_369_1.leftNameTxt_.text = arg_369_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_369_1.leftNameTxt_.transform)

				arg_369_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_369_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_369_1:RecordName(arg_369_1.leftNameTxt_.text)
				SetActive(arg_369_1.iconTrs_.gameObject, true)
				arg_369_1.iconController_:SetSelectedState("hero")

				arg_369_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_369_1.callingController_:SetSelectedState("normal")

				arg_369_1.keyicon_.color = Color.New(1, 1, 1)
				arg_369_1.icon_.color = Color.New(1, 1, 1)

				local var_372_3 = arg_369_1:FormatText(arg_369_1:GetWordFromCfg(1108409090).content)

				arg_369_1.text_.text = var_372_3

				LuaForUtil.ClearLinePrefixSymbol(arg_369_1.text_)

				local var_372_5 = 20 <= 0 and var_372_2 or var_372_2 * (utf8.len(var_372_3) / 20)

				if (20 <= 0 and var_372_2 or var_372_2 * (utf8.len(var_372_3) / 20)) > 0 and var_372_2 < var_372_5 then
					arg_369_1.talkMaxDuration = var_372_5

					if var_372_5 + var_372_1 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_5 + var_372_1
					end
				end

				arg_369_1.text_.text = var_372_3
				arg_369_1.typewritter.percent = 0

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(false)
				arg_369_1:RecordContent(arg_369_1.text_.text)
			end

			local var_372_6 = math.max(var_372_2, arg_369_1.talkMaxDuration)

			if var_372_1 <= arg_369_1.time_ and arg_369_1.time_ < var_372_1 + var_372_6 then
				arg_369_1.typewritter.percent = (arg_369_1.time_ - var_372_1) / var_372_6

				arg_369_1.typewritter:SetDirty()
			end

			if arg_369_1.time_ >= var_372_1 + var_372_6 and arg_369_1.time_ < var_372_1 + var_372_6 + arg_372_0 then
				arg_369_1.typewritter.percent = 1

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(true)
			end
		end

		arg_369_1.nodeConfigList_ = {}

		arg_369_1:InitPlayNodeList()
	end,
	Play1108409091 = function(arg_373_0, arg_373_1)
		arg_373_1.time_ = 0
		arg_373_1.frameCnt_ = 0
		arg_373_1.state_ = "playing"
		arg_373_1.curTalkId_ = 1108409091
		arg_373_1.duration_ = 5.2

		SetActive(arg_373_1.tipsGo_, false)

		function arg_373_1.onSingleLineFinish_()
			arg_373_1.onSingleLineUpdate_ = nil
			arg_373_1.onSingleLineFinish_ = nil
			arg_373_1.state_ = "waiting"
		end

		function arg_373_1.playNext_(arg_375_0)
			if arg_375_0 == 1 then
				arg_373_0:Play1108409092(arg_373_1)
			end
		end

		function arg_373_1.onSingleLineUpdate_(arg_376_0)
			if 0 < arg_373_1.time_ and arg_373_1.time_ <= 0 + arg_376_0 and not isNil(arg_373_1.actors_["1084ui_story"]) and arg_373_1.var_.characterEffect1084ui_story == nil then
				arg_373_1.var_.characterEffect1084ui_story = arg_373_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_376_0 = 0.200000002980232

			if 0 <= arg_373_1.time_ and arg_373_1.time_ < 0 + var_376_0 and not isNil(arg_373_1.actors_["1084ui_story"]) then
				if arg_373_1.var_.characterEffect1084ui_story and not isNil(arg_373_1.actors_["1084ui_story"]) then
					arg_373_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_373_1.time_ >= 0 + var_376_0 and arg_373_1.time_ < 0 + var_376_0 + arg_376_0 and not isNil(arg_373_1.actors_["1084ui_story"]) and arg_373_1.var_.characterEffect1084ui_story then
				arg_373_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= 0 + arg_376_0 then
				arg_373_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action438")
			end

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= 0 + arg_376_0 then
				arg_373_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_376_2 = 0
			local var_376_3 = 0.7

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= var_376_2 + arg_376_0 then
				arg_373_1.talkMaxDuration = 0
				arg_373_1.dialogCg_.alpha = 1

				arg_373_1.dialog_:SetActive(true)
				SetActive(arg_373_1.leftNameGo_, true)

				arg_373_1.leftNameTxt_.text = arg_373_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_373_1.leftNameTxt_.transform)

				arg_373_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_373_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_373_1:RecordName(arg_373_1.leftNameTxt_.text)
				SetActive(arg_373_1.iconTrs_.gameObject, false)
				arg_373_1.callingController_:SetSelectedState("normal")

				local var_376_4 = arg_373_1:GetWordFromCfg(1108409091)
				local var_376_5 = arg_373_1:FormatText(var_376_4.content)

				arg_373_1.text_.text = var_376_5

				LuaForUtil.ClearLinePrefixSymbol(arg_373_1.text_)

				local var_376_7 = 28 <= 0 and var_376_3 or var_376_3 * (utf8.len(var_376_5) / 28)

				if (28 <= 0 and var_376_3 or var_376_3 * (utf8.len(var_376_5) / 28)) > 0 and var_376_3 < var_376_7 then
					arg_373_1.talkMaxDuration = var_376_7

					if var_376_7 + var_376_2 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_7 + var_376_2
					end
				end

				arg_373_1.text_.text = var_376_5
				arg_373_1.typewritter.percent = 0

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409091", "story_v_side_new_1108409.awb") ~= 0 then
					local var_376_8 = manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409091", "story_v_side_new_1108409.awb") / 1000

					if var_376_8 + var_376_2 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_8 + var_376_2
					end

					if var_376_4.prefab_name ~= "" and arg_373_1.actors_[var_376_4.prefab_name] ~= nil then
						local var_376_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_373_1.actors_[var_376_4.prefab_name].transform, "story_v_side_new_1108409", "1108409091", "story_v_side_new_1108409.awb")

						arg_373_1:RecordAudio("1108409091", var_376_9)
						arg_373_1:RecordAudio("1108409091", var_376_9)
					else
						arg_373_1:AudioAction("play", "voice", "story_v_side_new_1108409", "1108409091", "story_v_side_new_1108409.awb")
					end

					arg_373_1:RecordHistoryTalkVoice("story_v_side_new_1108409", "1108409091", "story_v_side_new_1108409.awb")
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
	Play1108409092 = function(arg_377_0, arg_377_1)
		arg_377_1.time_ = 0
		arg_377_1.frameCnt_ = 0
		arg_377_1.state_ = "playing"
		arg_377_1.curTalkId_ = 1108409092
		arg_377_1.duration_ = 5

		SetActive(arg_377_1.tipsGo_, false)

		function arg_377_1.onSingleLineFinish_()
			arg_377_1.onSingleLineUpdate_ = nil
			arg_377_1.onSingleLineFinish_ = nil
			arg_377_1.state_ = "waiting"
		end

		function arg_377_1.playNext_(arg_379_0)
			if arg_379_0 == 1 then
				arg_377_0:Play1108409093(arg_377_1)
			end
		end

		function arg_377_1.onSingleLineUpdate_(arg_380_0)
			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 and not isNil(arg_377_1.actors_["1084ui_story"]) and arg_377_1.var_.characterEffect1084ui_story == nil then
				arg_377_1.var_.characterEffect1084ui_story = arg_377_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_380_0 = 0.200000002980232

			if 0 <= arg_377_1.time_ and arg_377_1.time_ < 0 + var_380_0 and not isNil(arg_377_1.actors_["1084ui_story"]) then
				if arg_377_1.var_.characterEffect1084ui_story and not isNil(arg_377_1.actors_["1084ui_story"]) then
					arg_377_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_377_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_377_1.time_ - 0) / var_380_0)
				end
			end

			if arg_377_1.time_ >= 0 + var_380_0 and arg_377_1.time_ < 0 + var_380_0 + arg_380_0 and not isNil(arg_377_1.actors_["1084ui_story"]) and arg_377_1.var_.characterEffect1084ui_story then
				arg_377_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_377_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_380_1 = 0
			local var_380_2 = 0.625

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= var_380_1 + arg_380_0 then
				arg_377_1.talkMaxDuration = 0
				arg_377_1.dialogCg_.alpha = 1

				arg_377_1.dialog_:SetActive(true)
				SetActive(arg_377_1.leftNameGo_, true)

				arg_377_1.leftNameTxt_.text = arg_377_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_377_1.leftNameTxt_.transform)

				arg_377_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_377_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_377_1:RecordName(arg_377_1.leftNameTxt_.text)
				SetActive(arg_377_1.iconTrs_.gameObject, true)
				arg_377_1.iconController_:SetSelectedState("hero")

				arg_377_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_377_1.callingController_:SetSelectedState("normal")

				arg_377_1.keyicon_.color = Color.New(1, 1, 1)
				arg_377_1.icon_.color = Color.New(1, 1, 1)

				local var_380_3 = arg_377_1:FormatText(arg_377_1:GetWordFromCfg(1108409092).content)

				arg_377_1.text_.text = var_380_3

				LuaForUtil.ClearLinePrefixSymbol(arg_377_1.text_)

				local var_380_5 = 25 <= 0 and var_380_2 or var_380_2 * (utf8.len(var_380_3) / 25)

				if (25 <= 0 and var_380_2 or var_380_2 * (utf8.len(var_380_3) / 25)) > 0 and var_380_2 < var_380_5 then
					arg_377_1.talkMaxDuration = var_380_5

					if var_380_5 + var_380_1 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_5 + var_380_1
					end
				end

				arg_377_1.text_.text = var_380_3
				arg_377_1.typewritter.percent = 0

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(false)
				arg_377_1:RecordContent(arg_377_1.text_.text)
			end

			local var_380_6 = math.max(var_380_2, arg_377_1.talkMaxDuration)

			if var_380_1 <= arg_377_1.time_ and arg_377_1.time_ < var_380_1 + var_380_6 then
				arg_377_1.typewritter.percent = (arg_377_1.time_ - var_380_1) / var_380_6

				arg_377_1.typewritter:SetDirty()
			end

			if arg_377_1.time_ >= var_380_1 + var_380_6 and arg_377_1.time_ < var_380_1 + var_380_6 + arg_380_0 then
				arg_377_1.typewritter.percent = 1

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(true)
			end
		end

		arg_377_1.nodeConfigList_ = {}

		arg_377_1:InitPlayNodeList()
	end,
	Play1108409093 = function(arg_381_0, arg_381_1)
		arg_381_1.time_ = 0
		arg_381_1.frameCnt_ = 0
		arg_381_1.state_ = "playing"
		arg_381_1.curTalkId_ = 1108409093
		arg_381_1.duration_ = 6.9

		SetActive(arg_381_1.tipsGo_, false)

		function arg_381_1.onSingleLineFinish_()
			arg_381_1.onSingleLineUpdate_ = nil
			arg_381_1.onSingleLineFinish_ = nil
			arg_381_1.state_ = "waiting"
		end

		function arg_381_1.playNext_(arg_383_0)
			if arg_383_0 == 1 then
				arg_381_0:Play1108409094(arg_381_1)
			end
		end

		function arg_381_1.onSingleLineUpdate_(arg_384_0)
			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 and not isNil(arg_381_1.actors_["1084ui_story"]) and arg_381_1.var_.characterEffect1084ui_story == nil then
				arg_381_1.var_.characterEffect1084ui_story = arg_381_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_384_0 = 0.200000002980232

			if 0 <= arg_381_1.time_ and arg_381_1.time_ < 0 + var_384_0 and not isNil(arg_381_1.actors_["1084ui_story"]) then
				if arg_381_1.var_.characterEffect1084ui_story and not isNil(arg_381_1.actors_["1084ui_story"]) then
					arg_381_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_381_1.time_ >= 0 + var_384_0 and arg_381_1.time_ < 0 + var_384_0 + arg_384_0 and not isNil(arg_381_1.actors_["1084ui_story"]) and arg_381_1.var_.characterEffect1084ui_story then
				arg_381_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 then
				arg_381_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action8_2")
			end

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 then
				arg_381_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_384_2 = 0
			local var_384_3 = 0.85

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= var_384_2 + arg_384_0 then
				arg_381_1.talkMaxDuration = 0
				arg_381_1.dialogCg_.alpha = 1

				arg_381_1.dialog_:SetActive(true)
				SetActive(arg_381_1.leftNameGo_, true)

				arg_381_1.leftNameTxt_.text = arg_381_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_381_1.leftNameTxt_.transform)

				arg_381_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_381_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_381_1:RecordName(arg_381_1.leftNameTxt_.text)
				SetActive(arg_381_1.iconTrs_.gameObject, false)
				arg_381_1.callingController_:SetSelectedState("normal")

				local var_384_4 = arg_381_1:GetWordFromCfg(1108409093)
				local var_384_5 = arg_381_1:FormatText(var_384_4.content)

				arg_381_1.text_.text = var_384_5

				LuaForUtil.ClearLinePrefixSymbol(arg_381_1.text_)

				local var_384_7 = 34 <= 0 and var_384_3 or var_384_3 * (utf8.len(var_384_5) / 34)

				if (34 <= 0 and var_384_3 or var_384_3 * (utf8.len(var_384_5) / 34)) > 0 and var_384_3 < var_384_7 then
					arg_381_1.talkMaxDuration = var_384_7

					if var_384_7 + var_384_2 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_7 + var_384_2
					end
				end

				arg_381_1.text_.text = var_384_5
				arg_381_1.typewritter.percent = 0

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409093", "story_v_side_new_1108409.awb") ~= 0 then
					local var_384_8 = manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409093", "story_v_side_new_1108409.awb") / 1000

					if var_384_8 + var_384_2 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_8 + var_384_2
					end

					if var_384_4.prefab_name ~= "" and arg_381_1.actors_[var_384_4.prefab_name] ~= nil then
						local var_384_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_381_1.actors_[var_384_4.prefab_name].transform, "story_v_side_new_1108409", "1108409093", "story_v_side_new_1108409.awb")

						arg_381_1:RecordAudio("1108409093", var_384_9)
						arg_381_1:RecordAudio("1108409093", var_384_9)
					else
						arg_381_1:AudioAction("play", "voice", "story_v_side_new_1108409", "1108409093", "story_v_side_new_1108409.awb")
					end

					arg_381_1:RecordHistoryTalkVoice("story_v_side_new_1108409", "1108409093", "story_v_side_new_1108409.awb")
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
	Play1108409094 = function(arg_385_0, arg_385_1)
		arg_385_1.time_ = 0
		arg_385_1.frameCnt_ = 0
		arg_385_1.state_ = "playing"
		arg_385_1.curTalkId_ = 1108409094
		arg_385_1.duration_ = 5

		SetActive(arg_385_1.tipsGo_, false)

		function arg_385_1.onSingleLineFinish_()
			arg_385_1.onSingleLineUpdate_ = nil
			arg_385_1.onSingleLineFinish_ = nil
			arg_385_1.state_ = "waiting"
		end

		function arg_385_1.playNext_(arg_387_0)
			if arg_387_0 == 1 then
				arg_385_0:Play1108409095(arg_385_1)
			end
		end

		function arg_385_1.onSingleLineUpdate_(arg_388_0)
			if 0 < arg_385_1.time_ and arg_385_1.time_ <= 0 + arg_388_0 and not isNil(arg_385_1.actors_["1084ui_story"]) and arg_385_1.var_.characterEffect1084ui_story == nil then
				arg_385_1.var_.characterEffect1084ui_story = arg_385_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_388_0 = 0.200000002980232

			if 0 <= arg_385_1.time_ and arg_385_1.time_ < 0 + var_388_0 and not isNil(arg_385_1.actors_["1084ui_story"]) then
				if arg_385_1.var_.characterEffect1084ui_story and not isNil(arg_385_1.actors_["1084ui_story"]) then
					arg_385_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_385_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_385_1.time_ - 0) / var_388_0)
				end
			end

			if arg_385_1.time_ >= 0 + var_388_0 and arg_385_1.time_ < 0 + var_388_0 + arg_388_0 and not isNil(arg_385_1.actors_["1084ui_story"]) and arg_385_1.var_.characterEffect1084ui_story then
				arg_385_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_385_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_388_1 = 0
			local var_388_2 = 0.7

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= var_388_1 + arg_388_0 then
				arg_385_1.talkMaxDuration = 0
				arg_385_1.dialogCg_.alpha = 1

				arg_385_1.dialog_:SetActive(true)
				SetActive(arg_385_1.leftNameGo_, true)

				arg_385_1.leftNameTxt_.text = arg_385_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_385_1.leftNameTxt_.transform)

				arg_385_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_385_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_385_1:RecordName(arg_385_1.leftNameTxt_.text)
				SetActive(arg_385_1.iconTrs_.gameObject, true)
				arg_385_1.iconController_:SetSelectedState("hero")

				arg_385_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_385_1.callingController_:SetSelectedState("normal")

				arg_385_1.keyicon_.color = Color.New(1, 1, 1)
				arg_385_1.icon_.color = Color.New(1, 1, 1)

				local var_388_3 = arg_385_1:FormatText(arg_385_1:GetWordFromCfg(1108409094).content)

				arg_385_1.text_.text = var_388_3

				LuaForUtil.ClearLinePrefixSymbol(arg_385_1.text_)

				local var_388_5 = 28 <= 0 and var_388_2 or var_388_2 * (utf8.len(var_388_3) / 28)

				if (28 <= 0 and var_388_2 or var_388_2 * (utf8.len(var_388_3) / 28)) > 0 and var_388_2 < var_388_5 then
					arg_385_1.talkMaxDuration = var_388_5

					if var_388_5 + var_388_1 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_5 + var_388_1
					end
				end

				arg_385_1.text_.text = var_388_3
				arg_385_1.typewritter.percent = 0

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(false)
				arg_385_1:RecordContent(arg_385_1.text_.text)
			end

			local var_388_6 = math.max(var_388_2, arg_385_1.talkMaxDuration)

			if var_388_1 <= arg_385_1.time_ and arg_385_1.time_ < var_388_1 + var_388_6 then
				arg_385_1.typewritter.percent = (arg_385_1.time_ - var_388_1) / var_388_6

				arg_385_1.typewritter:SetDirty()
			end

			if arg_385_1.time_ >= var_388_1 + var_388_6 and arg_385_1.time_ < var_388_1 + var_388_6 + arg_388_0 then
				arg_385_1.typewritter.percent = 1

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(true)
			end
		end

		arg_385_1.nodeConfigList_ = {}

		arg_385_1:InitPlayNodeList()
	end,
	Play1108409095 = function(arg_389_0, arg_389_1)
		arg_389_1.time_ = 0
		arg_389_1.frameCnt_ = 0
		arg_389_1.state_ = "playing"
		arg_389_1.curTalkId_ = 1108409095
		arg_389_1.duration_ = 3.23

		SetActive(arg_389_1.tipsGo_, false)

		function arg_389_1.onSingleLineFinish_()
			arg_389_1.onSingleLineUpdate_ = nil
			arg_389_1.onSingleLineFinish_ = nil
			arg_389_1.state_ = "waiting"
		end

		function arg_389_1.playNext_(arg_391_0)
			if arg_391_0 == 1 then
				arg_389_0:Play1108409096(arg_389_1)
			end
		end

		function arg_389_1.onSingleLineUpdate_(arg_392_0)
			if 0 < arg_389_1.time_ and arg_389_1.time_ <= 0 + arg_392_0 and not isNil(arg_389_1.actors_["1084ui_story"]) and arg_389_1.var_.characterEffect1084ui_story == nil then
				arg_389_1.var_.characterEffect1084ui_story = arg_389_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_392_0 = 0.200000002980232

			if 0 <= arg_389_1.time_ and arg_389_1.time_ < 0 + var_392_0 and not isNil(arg_389_1.actors_["1084ui_story"]) then
				if arg_389_1.var_.characterEffect1084ui_story and not isNil(arg_389_1.actors_["1084ui_story"]) then
					arg_389_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_389_1.time_ >= 0 + var_392_0 and arg_389_1.time_ < 0 + var_392_0 + arg_392_0 and not isNil(arg_389_1.actors_["1084ui_story"]) and arg_389_1.var_.characterEffect1084ui_story then
				arg_389_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_389_1.time_ and arg_389_1.time_ <= 0 + arg_392_0 then
				arg_389_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			if 0 < arg_389_1.time_ and arg_389_1.time_ <= 0 + arg_392_0 then
				arg_389_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva", "EmotionTimelineAnimator")
			end

			local var_392_2 = 0
			local var_392_3 = 0.3

			if 0 < arg_389_1.time_ and arg_389_1.time_ <= var_392_2 + arg_392_0 then
				arg_389_1.talkMaxDuration = 0
				arg_389_1.dialogCg_.alpha = 1

				arg_389_1.dialog_:SetActive(true)
				SetActive(arg_389_1.leftNameGo_, true)

				arg_389_1.leftNameTxt_.text = arg_389_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_389_1.leftNameTxt_.transform)

				arg_389_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_389_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_389_1:RecordName(arg_389_1.leftNameTxt_.text)
				SetActive(arg_389_1.iconTrs_.gameObject, false)
				arg_389_1.callingController_:SetSelectedState("normal")

				local var_392_4 = arg_389_1:GetWordFromCfg(1108409095)
				local var_392_5 = arg_389_1:FormatText(var_392_4.content)

				arg_389_1.text_.text = var_392_5

				LuaForUtil.ClearLinePrefixSymbol(arg_389_1.text_)

				local var_392_7 = 12 <= 0 and var_392_3 or var_392_3 * (utf8.len(var_392_5) / 12)

				if (12 <= 0 and var_392_3 or var_392_3 * (utf8.len(var_392_5) / 12)) > 0 and var_392_3 < var_392_7 then
					arg_389_1.talkMaxDuration = var_392_7

					if var_392_7 + var_392_2 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_7 + var_392_2
					end
				end

				arg_389_1.text_.text = var_392_5
				arg_389_1.typewritter.percent = 0

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409095", "story_v_side_new_1108409.awb") ~= 0 then
					local var_392_8 = manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409095", "story_v_side_new_1108409.awb") / 1000

					if var_392_8 + var_392_2 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_8 + var_392_2
					end

					if var_392_4.prefab_name ~= "" and arg_389_1.actors_[var_392_4.prefab_name] ~= nil then
						local var_392_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_389_1.actors_[var_392_4.prefab_name].transform, "story_v_side_new_1108409", "1108409095", "story_v_side_new_1108409.awb")

						arg_389_1:RecordAudio("1108409095", var_392_9)
						arg_389_1:RecordAudio("1108409095", var_392_9)
					else
						arg_389_1:AudioAction("play", "voice", "story_v_side_new_1108409", "1108409095", "story_v_side_new_1108409.awb")
					end

					arg_389_1:RecordHistoryTalkVoice("story_v_side_new_1108409", "1108409095", "story_v_side_new_1108409.awb")
				end

				arg_389_1:RecordContent(arg_389_1.text_.text)
			end

			local var_392_10 = math.max(var_392_3, arg_389_1.talkMaxDuration)

			if var_392_2 <= arg_389_1.time_ and arg_389_1.time_ < var_392_2 + var_392_10 then
				arg_389_1.typewritter.percent = (arg_389_1.time_ - var_392_2) / var_392_10

				arg_389_1.typewritter:SetDirty()
			end

			if arg_389_1.time_ >= var_392_2 + var_392_10 and arg_389_1.time_ < var_392_2 + var_392_10 + arg_392_0 then
				arg_389_1.typewritter.percent = 1

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(true)
			end
		end

		arg_389_1.nodeConfigList_ = {}

		arg_389_1:InitPlayNodeList()
	end,
	Play1108409096 = function(arg_393_0, arg_393_1)
		arg_393_1.time_ = 0
		arg_393_1.frameCnt_ = 0
		arg_393_1.state_ = "playing"
		arg_393_1.curTalkId_ = 1108409096
		arg_393_1.duration_ = 5

		SetActive(arg_393_1.tipsGo_, false)

		function arg_393_1.onSingleLineFinish_()
			arg_393_1.onSingleLineUpdate_ = nil
			arg_393_1.onSingleLineFinish_ = nil
			arg_393_1.state_ = "waiting"
		end

		function arg_393_1.playNext_(arg_395_0)
			if arg_395_0 == 1 then
				arg_393_0:Play1108409097(arg_393_1)
			end
		end

		function arg_393_1.onSingleLineUpdate_(arg_396_0)
			if 0 < arg_393_1.time_ and arg_393_1.time_ <= 0 + arg_396_0 then
				arg_393_1.var_.moveOldPos1084ui_story = arg_393_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_396_0 = 0.001

			if 0 <= arg_393_1.time_ and arg_393_1.time_ < 0 + var_396_0 then
				arg_393_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_393_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_393_1.time_ - 0) / var_396_0)
				arg_393_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_393_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_393_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_393_1.actors_["1084ui_story"].transform.position).z)
				arg_393_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_393_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_393_1.actors_["1084ui_story"].transform.localEulerAngles = arg_393_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_393_1.time_ >= 0 + var_396_0 and arg_393_1.time_ < 0 + var_396_0 + arg_396_0 then
				arg_393_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_393_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_393_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_393_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_393_1.actors_["1084ui_story"].transform.position).z)
				arg_393_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_393_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_393_1.actors_["1084ui_story"].transform.localEulerAngles = arg_393_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_396_1 = arg_393_1.actors_["1084ui_story"]

			if 0 < arg_393_1.time_ and arg_393_1.time_ <= 0 + arg_396_0 and not isNil(var_396_1) and arg_393_1.var_.characterEffect1084ui_story == nil then
				arg_393_1.var_.characterEffect1084ui_story = var_396_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_396_2 = 0.200000002980232

			if 0 <= arg_393_1.time_ and arg_393_1.time_ < 0 + var_396_2 and not isNil(var_396_1) then
				if arg_393_1.var_.characterEffect1084ui_story and not isNil(var_396_1) then
					arg_393_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_393_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_393_1.time_ - 0) / var_396_2)
				end
			end

			if arg_393_1.time_ >= 0 + var_396_2 and arg_393_1.time_ < 0 + var_396_2 + arg_396_0 and not isNil(var_396_1) and arg_393_1.var_.characterEffect1084ui_story then
				arg_393_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_393_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_396_3 = 0
			local var_396_4 = 0.525

			if 0 < arg_393_1.time_ and arg_393_1.time_ <= var_396_3 + arg_396_0 then
				arg_393_1.talkMaxDuration = 0
				arg_393_1.dialogCg_.alpha = 1

				arg_393_1.dialog_:SetActive(true)
				SetActive(arg_393_1.leftNameGo_, false)

				arg_393_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_393_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_393_1:RecordName(arg_393_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_393_1.iconTrs_.gameObject, false)
				arg_393_1.callingController_:SetSelectedState("normal")

				local var_396_5 = arg_393_1:FormatText(arg_393_1:GetWordFromCfg(1108409096).content)

				arg_393_1.text_.text = var_396_5

				LuaForUtil.ClearLinePrefixSymbol(arg_393_1.text_)

				local var_396_7 = 21 <= 0 and var_396_4 or var_396_4 * (utf8.len(var_396_5) / 21)

				if (21 <= 0 and var_396_4 or var_396_4 * (utf8.len(var_396_5) / 21)) > 0 and var_396_4 < var_396_7 then
					arg_393_1.talkMaxDuration = var_396_7

					if var_396_7 + var_396_3 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_7 + var_396_3
					end
				end

				arg_393_1.text_.text = var_396_5
				arg_393_1.typewritter.percent = 0

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(false)
				arg_393_1:RecordContent(arg_393_1.text_.text)
			end

			local var_396_8 = math.max(var_396_4, arg_393_1.talkMaxDuration)

			if var_396_3 <= arg_393_1.time_ and arg_393_1.time_ < var_396_3 + var_396_8 then
				arg_393_1.typewritter.percent = (arg_393_1.time_ - var_396_3) / var_396_8

				arg_393_1.typewritter:SetDirty()
			end

			if arg_393_1.time_ >= var_396_3 + var_396_8 and arg_393_1.time_ < var_396_3 + var_396_8 + arg_396_0 then
				arg_393_1.typewritter.percent = 1

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(true)
			end
		end

		arg_393_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_393_1:InitPlayNodeList()
	end,
	Play1108409097 = function(arg_397_0, arg_397_1)
		arg_397_1.time_ = 0
		arg_397_1.frameCnt_ = 0
		arg_397_1.state_ = "playing"
		arg_397_1.curTalkId_ = 1108409097
		arg_397_1.duration_ = 5

		SetActive(arg_397_1.tipsGo_, false)

		function arg_397_1.onSingleLineFinish_()
			arg_397_1.onSingleLineUpdate_ = nil
			arg_397_1.onSingleLineFinish_ = nil
			arg_397_1.state_ = "waiting"
		end

		function arg_397_1.playNext_(arg_399_0)
			if arg_399_0 == 1 then
				arg_397_0:Play1108409098(arg_397_1)
			end
		end

		function arg_397_1.onSingleLineUpdate_(arg_400_0)
			local var_400_0 = 0.475

			if 0 < arg_397_1.time_ and arg_397_1.time_ <= 0 + arg_400_0 then
				arg_397_1.talkMaxDuration = 0
				arg_397_1.dialogCg_.alpha = 1

				arg_397_1.dialog_:SetActive(true)
				SetActive(arg_397_1.leftNameGo_, true)

				arg_397_1.leftNameTxt_.text = arg_397_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_397_1.leftNameTxt_.transform)

				arg_397_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_397_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_397_1:RecordName(arg_397_1.leftNameTxt_.text)
				SetActive(arg_397_1.iconTrs_.gameObject, true)
				arg_397_1.iconController_:SetSelectedState("hero")

				arg_397_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_397_1.callingController_:SetSelectedState("normal")

				arg_397_1.keyicon_.color = Color.New(1, 1, 1)
				arg_397_1.icon_.color = Color.New(1, 1, 1)

				local var_400_1 = arg_397_1:FormatText(arg_397_1:GetWordFromCfg(1108409097).content)

				arg_397_1.text_.text = var_400_1

				LuaForUtil.ClearLinePrefixSymbol(arg_397_1.text_)

				local var_400_3 = 19 <= 0 and var_400_0 or var_400_0 * (utf8.len(var_400_1) / 19)

				if (19 <= 0 and var_400_0 or var_400_0 * (utf8.len(var_400_1) / 19)) > 0 and var_400_0 < var_400_3 then
					arg_397_1.talkMaxDuration = var_400_3

					if var_400_3 + 0 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_3 + 0
					end
				end

				arg_397_1.text_.text = var_400_1
				arg_397_1.typewritter.percent = 0

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(false)
				arg_397_1:RecordContent(arg_397_1.text_.text)
			end

			local var_400_4 = math.max(var_400_0, arg_397_1.talkMaxDuration)

			if 0 <= arg_397_1.time_ and arg_397_1.time_ < 0 + var_400_4 then
				arg_397_1.typewritter.percent = (arg_397_1.time_ - 0) / var_400_4

				arg_397_1.typewritter:SetDirty()
			end

			if arg_397_1.time_ >= 0 + var_400_4 and arg_397_1.time_ < 0 + var_400_4 + arg_400_0 then
				arg_397_1.typewritter.percent = 1

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(true)
			end
		end

		arg_397_1.nodeConfigList_ = {}

		arg_397_1:InitPlayNodeList()
	end,
	Play1108409098 = function(arg_401_0, arg_401_1)
		arg_401_1.time_ = 0
		arg_401_1.frameCnt_ = 0
		arg_401_1.state_ = "playing"
		arg_401_1.curTalkId_ = 1108409098
		arg_401_1.duration_ = 3.4

		SetActive(arg_401_1.tipsGo_, false)

		function arg_401_1.onSingleLineFinish_()
			arg_401_1.onSingleLineUpdate_ = nil
			arg_401_1.onSingleLineFinish_ = nil
			arg_401_1.state_ = "waiting"
		end

		function arg_401_1.playNext_(arg_403_0)
			if arg_403_0 == 1 then
				arg_401_0:Play1108409099(arg_401_1)
			end
		end

		function arg_401_1.onSingleLineUpdate_(arg_404_0)
			if 0 < arg_401_1.time_ and arg_401_1.time_ <= 0 + arg_404_0 then
				arg_401_1.var_.moveOldPos1084ui_story = arg_401_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_404_0 = 0.001

			if 0 <= arg_401_1.time_ and arg_401_1.time_ < 0 + var_404_0 then
				arg_401_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_401_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_401_1.time_ - 0) / var_404_0)
				arg_401_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_401_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_401_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_401_1.actors_["1084ui_story"].transform.position).z)
				arg_401_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_401_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_401_1.actors_["1084ui_story"].transform.localEulerAngles = arg_401_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_401_1.time_ >= 0 + var_404_0 and arg_401_1.time_ < 0 + var_404_0 + arg_404_0 then
				arg_401_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_401_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_401_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_401_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_401_1.actors_["1084ui_story"].transform.position).z)
				arg_401_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_401_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_401_1.actors_["1084ui_story"].transform.localEulerAngles = arg_401_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_404_1 = arg_401_1.actors_["1084ui_story"]

			if 0 < arg_401_1.time_ and arg_401_1.time_ <= 0 + arg_404_0 and not isNil(var_404_1) and arg_401_1.var_.characterEffect1084ui_story == nil then
				arg_401_1.var_.characterEffect1084ui_story = var_404_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_404_2 = 0.200000002980232

			if 0 <= arg_401_1.time_ and arg_401_1.time_ < 0 + var_404_2 and not isNil(var_404_1) then
				if arg_401_1.var_.characterEffect1084ui_story and not isNil(var_404_1) then
					arg_401_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_401_1.time_ >= 0 + var_404_2 and arg_401_1.time_ < 0 + var_404_2 + arg_404_0 and not isNil(var_404_1) and arg_401_1.var_.characterEffect1084ui_story then
				arg_401_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_401_1.time_ and arg_401_1.time_ <= 0 + arg_404_0 then
				arg_401_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action438")
			end

			if 0 < arg_401_1.time_ and arg_401_1.time_ <= 0 + arg_404_0 then
				arg_401_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_404_4 = 0
			local var_404_5 = 0.325

			if 0 < arg_401_1.time_ and arg_401_1.time_ <= var_404_4 + arg_404_0 then
				arg_401_1.talkMaxDuration = 0
				arg_401_1.dialogCg_.alpha = 1

				arg_401_1.dialog_:SetActive(true)
				SetActive(arg_401_1.leftNameGo_, true)

				arg_401_1.leftNameTxt_.text = arg_401_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_401_1.leftNameTxt_.transform)

				arg_401_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_401_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_401_1:RecordName(arg_401_1.leftNameTxt_.text)
				SetActive(arg_401_1.iconTrs_.gameObject, false)
				arg_401_1.callingController_:SetSelectedState("normal")

				local var_404_6 = arg_401_1:GetWordFromCfg(1108409098)
				local var_404_7 = arg_401_1:FormatText(var_404_6.content)

				arg_401_1.text_.text = var_404_7

				LuaForUtil.ClearLinePrefixSymbol(arg_401_1.text_)

				local var_404_9 = 13 <= 0 and var_404_5 or var_404_5 * (utf8.len(var_404_7) / 13)

				if (13 <= 0 and var_404_5 or var_404_5 * (utf8.len(var_404_7) / 13)) > 0 and var_404_5 < var_404_9 then
					arg_401_1.talkMaxDuration = var_404_9

					if var_404_9 + var_404_4 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_9 + var_404_4
					end
				end

				arg_401_1.text_.text = var_404_7
				arg_401_1.typewritter.percent = 0

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409098", "story_v_side_new_1108409.awb") ~= 0 then
					local var_404_10 = manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409098", "story_v_side_new_1108409.awb") / 1000

					if var_404_10 + var_404_4 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_10 + var_404_4
					end

					if var_404_6.prefab_name ~= "" and arg_401_1.actors_[var_404_6.prefab_name] ~= nil then
						local var_404_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_401_1.actors_[var_404_6.prefab_name].transform, "story_v_side_new_1108409", "1108409098", "story_v_side_new_1108409.awb")

						arg_401_1:RecordAudio("1108409098", var_404_11)
						arg_401_1:RecordAudio("1108409098", var_404_11)
					else
						arg_401_1:AudioAction("play", "voice", "story_v_side_new_1108409", "1108409098", "story_v_side_new_1108409.awb")
					end

					arg_401_1:RecordHistoryTalkVoice("story_v_side_new_1108409", "1108409098", "story_v_side_new_1108409.awb")
				end

				arg_401_1:RecordContent(arg_401_1.text_.text)
			end

			local var_404_12 = math.max(var_404_5, arg_401_1.talkMaxDuration)

			if var_404_4 <= arg_401_1.time_ and arg_401_1.time_ < var_404_4 + var_404_12 then
				arg_401_1.typewritter.percent = (arg_401_1.time_ - var_404_4) / var_404_12

				arg_401_1.typewritter:SetDirty()
			end

			if arg_401_1.time_ >= var_404_4 + var_404_12 and arg_401_1.time_ < var_404_4 + var_404_12 + arg_404_0 then
				arg_401_1.typewritter.percent = 1

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(true)
			end
		end

		arg_401_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_401_1:InitPlayNodeList()
	end,
	Play1108409099 = function(arg_405_0, arg_405_1)
		arg_405_1.time_ = 0
		arg_405_1.frameCnt_ = 0
		arg_405_1.state_ = "playing"
		arg_405_1.curTalkId_ = 1108409099
		arg_405_1.duration_ = 5

		SetActive(arg_405_1.tipsGo_, false)

		function arg_405_1.onSingleLineFinish_()
			arg_405_1.onSingleLineUpdate_ = nil
			arg_405_1.onSingleLineFinish_ = nil
			arg_405_1.state_ = "waiting"
		end

		function arg_405_1.playNext_(arg_407_0)
			if arg_407_0 == 1 then
				arg_405_0:Play1108409100(arg_405_1)
			end
		end

		function arg_405_1.onSingleLineUpdate_(arg_408_0)
			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 and not isNil(arg_405_1.actors_["1084ui_story"]) and arg_405_1.var_.characterEffect1084ui_story == nil then
				arg_405_1.var_.characterEffect1084ui_story = arg_405_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_408_0 = 0.200000002980232

			if 0 <= arg_405_1.time_ and arg_405_1.time_ < 0 + var_408_0 and not isNil(arg_405_1.actors_["1084ui_story"]) then
				if arg_405_1.var_.characterEffect1084ui_story and not isNil(arg_405_1.actors_["1084ui_story"]) then
					arg_405_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_405_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_405_1.time_ - 0) / var_408_0)
				end
			end

			if arg_405_1.time_ >= 0 + var_408_0 and arg_405_1.time_ < 0 + var_408_0 + arg_408_0 and not isNil(arg_405_1.actors_["1084ui_story"]) and arg_405_1.var_.characterEffect1084ui_story then
				arg_405_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_405_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_408_1 = 0
			local var_408_2 = 0.175

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= var_408_1 + arg_408_0 then
				arg_405_1.talkMaxDuration = 0
				arg_405_1.dialogCg_.alpha = 1

				arg_405_1.dialog_:SetActive(true)
				SetActive(arg_405_1.leftNameGo_, true)

				arg_405_1.leftNameTxt_.text = arg_405_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_405_1.leftNameTxt_.transform)

				arg_405_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_405_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_405_1:RecordName(arg_405_1.leftNameTxt_.text)
				SetActive(arg_405_1.iconTrs_.gameObject, true)
				arg_405_1.iconController_:SetSelectedState("hero")

				arg_405_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_405_1.callingController_:SetSelectedState("normal")

				arg_405_1.keyicon_.color = Color.New(1, 1, 1)
				arg_405_1.icon_.color = Color.New(1, 1, 1)

				local var_408_3 = arg_405_1:FormatText(arg_405_1:GetWordFromCfg(1108409099).content)

				arg_405_1.text_.text = var_408_3

				LuaForUtil.ClearLinePrefixSymbol(arg_405_1.text_)

				local var_408_5 = 7 <= 0 and var_408_2 or var_408_2 * (utf8.len(var_408_3) / 7)

				if (7 <= 0 and var_408_2 or var_408_2 * (utf8.len(var_408_3) / 7)) > 0 and var_408_2 < var_408_5 then
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
	Play1108409100 = function(arg_409_0, arg_409_1)
		arg_409_1.time_ = 0
		arg_409_1.frameCnt_ = 0
		arg_409_1.state_ = "playing"
		arg_409_1.curTalkId_ = 1108409100
		arg_409_1.duration_ = 5

		SetActive(arg_409_1.tipsGo_, false)

		function arg_409_1.onSingleLineFinish_()
			arg_409_1.onSingleLineUpdate_ = nil
			arg_409_1.onSingleLineFinish_ = nil
			arg_409_1.state_ = "waiting"
		end

		function arg_409_1.playNext_(arg_411_0)
			if arg_411_0 == 1 then
				arg_409_0:Play1108409101(arg_409_1)
			end
		end

		function arg_409_1.onSingleLineUpdate_(arg_412_0)
			if 0 < arg_409_1.time_ and arg_409_1.time_ <= 0 + arg_412_0 then
				arg_409_1.var_.moveOldPos1084ui_story = arg_409_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_412_0 = 0.001

			if 0 <= arg_409_1.time_ and arg_409_1.time_ < 0 + var_412_0 then
				arg_409_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_409_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_409_1.time_ - 0) / var_412_0)
				arg_409_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_409_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_409_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_409_1.actors_["1084ui_story"].transform.position).z)
				arg_409_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_409_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_409_1.actors_["1084ui_story"].transform.localEulerAngles = arg_409_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_409_1.time_ >= 0 + var_412_0 and arg_409_1.time_ < 0 + var_412_0 + arg_412_0 then
				arg_409_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_409_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_409_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_409_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_409_1.actors_["1084ui_story"].transform.position).z)
				arg_409_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_409_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_409_1.actors_["1084ui_story"].transform.localEulerAngles = arg_409_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_412_1 = 0
			local var_412_2 = 0.8

			if 0 < arg_409_1.time_ and arg_409_1.time_ <= var_412_1 + arg_412_0 then
				arg_409_1.talkMaxDuration = 0
				arg_409_1.dialogCg_.alpha = 1

				arg_409_1.dialog_:SetActive(true)
				SetActive(arg_409_1.leftNameGo_, false)

				arg_409_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_409_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_409_1:RecordName(arg_409_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_409_1.iconTrs_.gameObject, false)
				arg_409_1.callingController_:SetSelectedState("normal")

				local var_412_3 = arg_409_1:FormatText(arg_409_1:GetWordFromCfg(1108409100).content)

				arg_409_1.text_.text = var_412_3

				LuaForUtil.ClearLinePrefixSymbol(arg_409_1.text_)

				local var_412_5 = 32 <= 0 and var_412_2 or var_412_2 * (utf8.len(var_412_3) / 32)

				if (32 <= 0 and var_412_2 or var_412_2 * (utf8.len(var_412_3) / 32)) > 0 and var_412_2 < var_412_5 then
					arg_409_1.talkMaxDuration = var_412_5

					if var_412_5 + var_412_1 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_5 + var_412_1
					end
				end

				arg_409_1.text_.text = var_412_3
				arg_409_1.typewritter.percent = 0

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(false)
				arg_409_1:RecordContent(arg_409_1.text_.text)
			end

			local var_412_6 = math.max(var_412_2, arg_409_1.talkMaxDuration)

			if var_412_1 <= arg_409_1.time_ and arg_409_1.time_ < var_412_1 + var_412_6 then
				arg_409_1.typewritter.percent = (arg_409_1.time_ - var_412_1) / var_412_6

				arg_409_1.typewritter:SetDirty()
			end

			if arg_409_1.time_ >= var_412_1 + var_412_6 and arg_409_1.time_ < var_412_1 + var_412_6 + arg_412_0 then
				arg_409_1.typewritter.percent = 1

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(true)
			end
		end

		arg_409_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_409_1:InitPlayNodeList()
	end,
	Play1108409101 = function(arg_413_0, arg_413_1)
		arg_413_1.time_ = 0
		arg_413_1.frameCnt_ = 0
		arg_413_1.state_ = "playing"
		arg_413_1.curTalkId_ = 1108409101
		arg_413_1.duration_ = 3.73

		SetActive(arg_413_1.tipsGo_, false)

		function arg_413_1.onSingleLineFinish_()
			arg_413_1.onSingleLineUpdate_ = nil
			arg_413_1.onSingleLineFinish_ = nil
			arg_413_1.state_ = "waiting"
		end

		function arg_413_1.playNext_(arg_415_0)
			if arg_415_0 == 1 then
				arg_413_0:Play1108409102(arg_413_1)
			end
		end

		function arg_413_1.onSingleLineUpdate_(arg_416_0)
			if 0 < arg_413_1.time_ and arg_413_1.time_ <= 0 + arg_416_0 then
				arg_413_1.var_.moveOldPos1084ui_story = arg_413_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_416_0 = 0.001

			if 0 <= arg_413_1.time_ and arg_413_1.time_ < 0 + var_416_0 then
				arg_413_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_413_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_413_1.time_ - 0) / var_416_0)
				arg_413_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_413_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_413_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_413_1.actors_["1084ui_story"].transform.position).z)
				arg_413_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_413_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_413_1.actors_["1084ui_story"].transform.localEulerAngles = arg_413_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_413_1.time_ >= 0 + var_416_0 and arg_413_1.time_ < 0 + var_416_0 + arg_416_0 then
				arg_413_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_413_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_413_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_413_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_413_1.actors_["1084ui_story"].transform.position).z)
				arg_413_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_413_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_413_1.actors_["1084ui_story"].transform.localEulerAngles = arg_413_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_416_1 = arg_413_1.actors_["1084ui_story"]

			if 0 < arg_413_1.time_ and arg_413_1.time_ <= 0 + arg_416_0 and not isNil(var_416_1) and arg_413_1.var_.characterEffect1084ui_story == nil then
				arg_413_1.var_.characterEffect1084ui_story = var_416_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_416_2 = 0.200000002980232

			if 0 <= arg_413_1.time_ and arg_413_1.time_ < 0 + var_416_2 and not isNil(var_416_1) then
				if arg_413_1.var_.characterEffect1084ui_story and not isNil(var_416_1) then
					arg_413_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_413_1.time_ >= 0 + var_416_2 and arg_413_1.time_ < 0 + var_416_2 + arg_416_0 and not isNil(var_416_1) and arg_413_1.var_.characterEffect1084ui_story then
				arg_413_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_413_1.time_ and arg_413_1.time_ <= 0 + arg_416_0 then
				arg_413_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			if 0 < arg_413_1.time_ and arg_413_1.time_ <= 0 + arg_416_0 then
				arg_413_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_416_4 = 0
			local var_416_5 = 0.45

			if 0 < arg_413_1.time_ and arg_413_1.time_ <= var_416_4 + arg_416_0 then
				arg_413_1.talkMaxDuration = 0
				arg_413_1.dialogCg_.alpha = 1

				arg_413_1.dialog_:SetActive(true)
				SetActive(arg_413_1.leftNameGo_, true)

				arg_413_1.leftNameTxt_.text = arg_413_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_413_1.leftNameTxt_.transform)

				arg_413_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_413_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_413_1:RecordName(arg_413_1.leftNameTxt_.text)
				SetActive(arg_413_1.iconTrs_.gameObject, false)
				arg_413_1.callingController_:SetSelectedState("normal")

				local var_416_6 = arg_413_1:GetWordFromCfg(1108409101)
				local var_416_7 = arg_413_1:FormatText(var_416_6.content)

				arg_413_1.text_.text = var_416_7

				LuaForUtil.ClearLinePrefixSymbol(arg_413_1.text_)

				local var_416_9 = 18 <= 0 and var_416_5 or var_416_5 * (utf8.len(var_416_7) / 18)

				if (18 <= 0 and var_416_5 or var_416_5 * (utf8.len(var_416_7) / 18)) > 0 and var_416_5 < var_416_9 then
					arg_413_1.talkMaxDuration = var_416_9

					if var_416_9 + var_416_4 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_9 + var_416_4
					end
				end

				arg_413_1.text_.text = var_416_7
				arg_413_1.typewritter.percent = 0

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409101", "story_v_side_new_1108409.awb") ~= 0 then
					local var_416_10 = manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409101", "story_v_side_new_1108409.awb") / 1000

					if var_416_10 + var_416_4 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_10 + var_416_4
					end

					if var_416_6.prefab_name ~= "" and arg_413_1.actors_[var_416_6.prefab_name] ~= nil then
						local var_416_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_413_1.actors_[var_416_6.prefab_name].transform, "story_v_side_new_1108409", "1108409101", "story_v_side_new_1108409.awb")

						arg_413_1:RecordAudio("1108409101", var_416_11)
						arg_413_1:RecordAudio("1108409101", var_416_11)
					else
						arg_413_1:AudioAction("play", "voice", "story_v_side_new_1108409", "1108409101", "story_v_side_new_1108409.awb")
					end

					arg_413_1:RecordHistoryTalkVoice("story_v_side_new_1108409", "1108409101", "story_v_side_new_1108409.awb")
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
				actorName = "1084ui_story",
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
	Play1108409102 = function(arg_417_0, arg_417_1)
		arg_417_1.time_ = 0
		arg_417_1.frameCnt_ = 0
		arg_417_1.state_ = "playing"
		arg_417_1.curTalkId_ = 1108409102
		arg_417_1.duration_ = 5

		SetActive(arg_417_1.tipsGo_, false)

		function arg_417_1.onSingleLineFinish_()
			arg_417_1.onSingleLineUpdate_ = nil
			arg_417_1.onSingleLineFinish_ = nil
			arg_417_1.state_ = "waiting"
		end

		function arg_417_1.playNext_(arg_419_0)
			if arg_419_0 == 1 then
				arg_417_0:Play1108409103(arg_417_1)
			end
		end

		function arg_417_1.onSingleLineUpdate_(arg_420_0)
			if 0 < arg_417_1.time_ and arg_417_1.time_ <= 0 + arg_420_0 and not isNil(arg_417_1.actors_["1084ui_story"]) and arg_417_1.var_.characterEffect1084ui_story == nil then
				arg_417_1.var_.characterEffect1084ui_story = arg_417_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_420_0 = 0.200000002980232

			if 0 <= arg_417_1.time_ and arg_417_1.time_ < 0 + var_420_0 and not isNil(arg_417_1.actors_["1084ui_story"]) then
				if arg_417_1.var_.characterEffect1084ui_story and not isNil(arg_417_1.actors_["1084ui_story"]) then
					arg_417_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_417_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_417_1.time_ - 0) / var_420_0)
				end
			end

			if arg_417_1.time_ >= 0 + var_420_0 and arg_417_1.time_ < 0 + var_420_0 + arg_420_0 and not isNil(arg_417_1.actors_["1084ui_story"]) and arg_417_1.var_.characterEffect1084ui_story then
				arg_417_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_417_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_420_1 = 0
			local var_420_2 = 0.075

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

				local var_420_3 = arg_417_1:FormatText(arg_417_1:GetWordFromCfg(1108409102).content)

				arg_417_1.text_.text = var_420_3

				LuaForUtil.ClearLinePrefixSymbol(arg_417_1.text_)

				local var_420_5 = 3 <= 0 and var_420_2 or var_420_2 * (utf8.len(var_420_3) / 3)

				if (3 <= 0 and var_420_2 or var_420_2 * (utf8.len(var_420_3) / 3)) > 0 and var_420_2 < var_420_5 then
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
	Play1108409103 = function(arg_421_0, arg_421_1)
		arg_421_1.time_ = 0
		arg_421_1.frameCnt_ = 0
		arg_421_1.state_ = "playing"
		arg_421_1.curTalkId_ = 1108409103
		arg_421_1.duration_ = 5

		SetActive(arg_421_1.tipsGo_, false)

		function arg_421_1.onSingleLineFinish_()
			arg_421_1.onSingleLineUpdate_ = nil
			arg_421_1.onSingleLineFinish_ = nil
			arg_421_1.state_ = "waiting"
		end

		function arg_421_1.playNext_(arg_423_0)
			if arg_423_0 == 1 then
				arg_421_0:Play1108409104(arg_421_1)
			end
		end

		function arg_421_1.onSingleLineUpdate_(arg_424_0)
			if 0 < arg_421_1.time_ and arg_421_1.time_ <= 0 + arg_424_0 then
				arg_421_1.var_.moveOldPos1084ui_story = arg_421_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_424_0 = 0.001

			if 0 <= arg_421_1.time_ and arg_421_1.time_ < 0 + var_424_0 then
				arg_421_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_421_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_421_1.time_ - 0) / var_424_0)
				arg_421_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_421_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_421_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_421_1.actors_["1084ui_story"].transform.position).z)
				arg_421_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_421_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_421_1.actors_["1084ui_story"].transform.localEulerAngles = arg_421_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_421_1.time_ >= 0 + var_424_0 and arg_421_1.time_ < 0 + var_424_0 + arg_424_0 then
				arg_421_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_421_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_421_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_421_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_421_1.actors_["1084ui_story"].transform.position).z)
				arg_421_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_421_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_421_1.actors_["1084ui_story"].transform.localEulerAngles = arg_421_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_424_1 = 0
			local var_424_2 = 1.375

			if 0 < arg_421_1.time_ and arg_421_1.time_ <= var_424_1 + arg_424_0 then
				arg_421_1.talkMaxDuration = 0
				arg_421_1.dialogCg_.alpha = 1

				arg_421_1.dialog_:SetActive(true)
				SetActive(arg_421_1.leftNameGo_, false)

				arg_421_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_421_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_421_1:RecordName(arg_421_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_421_1.iconTrs_.gameObject, false)
				arg_421_1.callingController_:SetSelectedState("normal")

				local var_424_3 = arg_421_1:FormatText(arg_421_1:GetWordFromCfg(1108409103).content)

				arg_421_1.text_.text = var_424_3

				LuaForUtil.ClearLinePrefixSymbol(arg_421_1.text_)

				local var_424_5 = 55 <= 0 and var_424_2 or var_424_2 * (utf8.len(var_424_3) / 55)

				if (55 <= 0 and var_424_2 or var_424_2 * (utf8.len(var_424_3) / 55)) > 0 and var_424_2 < var_424_5 then
					arg_421_1.talkMaxDuration = var_424_5

					if var_424_5 + var_424_1 > arg_421_1.duration_ then
						arg_421_1.duration_ = var_424_5 + var_424_1
					end
				end

				arg_421_1.text_.text = var_424_3
				arg_421_1.typewritter.percent = 0

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(false)
				arg_421_1:RecordContent(arg_421_1.text_.text)
			end

			local var_424_6 = math.max(var_424_2, arg_421_1.talkMaxDuration)

			if var_424_1 <= arg_421_1.time_ and arg_421_1.time_ < var_424_1 + var_424_6 then
				arg_421_1.typewritter.percent = (arg_421_1.time_ - var_424_1) / var_424_6

				arg_421_1.typewritter:SetDirty()
			end

			if arg_421_1.time_ >= var_424_1 + var_424_6 and arg_421_1.time_ < var_424_1 + var_424_6 + arg_424_0 then
				arg_421_1.typewritter.percent = 1

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(true)
			end
		end

		arg_421_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
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
	Play1108409104 = function(arg_425_0, arg_425_1)
		arg_425_1.time_ = 0
		arg_425_1.frameCnt_ = 0
		arg_425_1.state_ = "playing"
		arg_425_1.curTalkId_ = 1108409104
		arg_425_1.duration_ = 5

		SetActive(arg_425_1.tipsGo_, false)

		function arg_425_1.onSingleLineFinish_()
			arg_425_1.onSingleLineUpdate_ = nil
			arg_425_1.onSingleLineFinish_ = nil
			arg_425_1.state_ = "waiting"
		end

		function arg_425_1.playNext_(arg_427_0)
			if arg_427_0 == 1 then
				arg_425_0:Play1108409105(arg_425_1)
			end
		end

		function arg_425_1.onSingleLineUpdate_(arg_428_0)
			local var_428_0 = 0.725

			if 0 < arg_425_1.time_ and arg_425_1.time_ <= 0 + arg_428_0 then
				arg_425_1.talkMaxDuration = 0
				arg_425_1.dialogCg_.alpha = 1

				arg_425_1.dialog_:SetActive(true)
				SetActive(arg_425_1.leftNameGo_, true)

				arg_425_1.leftNameTxt_.text = arg_425_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_425_1.leftNameTxt_.transform)

				arg_425_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_425_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_425_1:RecordName(arg_425_1.leftNameTxt_.text)
				SetActive(arg_425_1.iconTrs_.gameObject, true)
				arg_425_1.iconController_:SetSelectedState("hero")

				arg_425_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_425_1.callingController_:SetSelectedState("normal")

				arg_425_1.keyicon_.color = Color.New(1, 1, 1)
				arg_425_1.icon_.color = Color.New(1, 1, 1)

				local var_428_1 = arg_425_1:FormatText(arg_425_1:GetWordFromCfg(1108409104).content)

				arg_425_1.text_.text = var_428_1

				LuaForUtil.ClearLinePrefixSymbol(arg_425_1.text_)

				local var_428_3 = 29 <= 0 and var_428_0 or var_428_0 * (utf8.len(var_428_1) / 29)

				if (29 <= 0 and var_428_0 or var_428_0 * (utf8.len(var_428_1) / 29)) > 0 and var_428_0 < var_428_3 then
					arg_425_1.talkMaxDuration = var_428_3

					if var_428_3 + 0 > arg_425_1.duration_ then
						arg_425_1.duration_ = var_428_3 + 0
					end
				end

				arg_425_1.text_.text = var_428_1
				arg_425_1.typewritter.percent = 0

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(false)
				arg_425_1:RecordContent(arg_425_1.text_.text)
			end

			local var_428_4 = math.max(var_428_0, arg_425_1.talkMaxDuration)

			if 0 <= arg_425_1.time_ and arg_425_1.time_ < 0 + var_428_4 then
				arg_425_1.typewritter.percent = (arg_425_1.time_ - 0) / var_428_4

				arg_425_1.typewritter:SetDirty()
			end

			if arg_425_1.time_ >= 0 + var_428_4 and arg_425_1.time_ < 0 + var_428_4 + arg_428_0 then
				arg_425_1.typewritter.percent = 1

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(true)
			end
		end

		arg_425_1.nodeConfigList_ = {}

		arg_425_1:InitPlayNodeList()
	end,
	Play1108409105 = function(arg_429_0, arg_429_1)
		arg_429_1.time_ = 0
		arg_429_1.frameCnt_ = 0
		arg_429_1.state_ = "playing"
		arg_429_1.curTalkId_ = 1108409105
		arg_429_1.duration_ = 4.23

		SetActive(arg_429_1.tipsGo_, false)

		function arg_429_1.onSingleLineFinish_()
			arg_429_1.onSingleLineUpdate_ = nil
			arg_429_1.onSingleLineFinish_ = nil
			arg_429_1.state_ = "waiting"
		end

		function arg_429_1.playNext_(arg_431_0)
			if arg_431_0 == 1 then
				arg_429_0:Play1108409106(arg_429_1)
			end
		end

		function arg_429_1.onSingleLineUpdate_(arg_432_0)
			if 0 < arg_429_1.time_ and arg_429_1.time_ <= 0 + arg_432_0 then
				arg_429_1.var_.moveOldPos1084ui_story = arg_429_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_432_0 = 0.001

			if 0 <= arg_429_1.time_ and arg_429_1.time_ < 0 + var_432_0 then
				arg_429_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_429_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_429_1.time_ - 0) / var_432_0)
				arg_429_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_429_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_429_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_429_1.actors_["1084ui_story"].transform.position).z)
				arg_429_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_429_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_429_1.actors_["1084ui_story"].transform.localEulerAngles = arg_429_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_429_1.time_ >= 0 + var_432_0 and arg_429_1.time_ < 0 + var_432_0 + arg_432_0 then
				arg_429_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_429_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_429_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_429_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_429_1.actors_["1084ui_story"].transform.position).z)
				arg_429_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_429_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_429_1.actors_["1084ui_story"].transform.localEulerAngles = arg_429_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_432_1 = arg_429_1.actors_["1084ui_story"]

			if 0 < arg_429_1.time_ and arg_429_1.time_ <= 0 + arg_432_0 and not isNil(var_432_1) and arg_429_1.var_.characterEffect1084ui_story == nil then
				arg_429_1.var_.characterEffect1084ui_story = var_432_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_432_2 = 0.200000002980232

			if 0 <= arg_429_1.time_ and arg_429_1.time_ < 0 + var_432_2 and not isNil(var_432_1) then
				if arg_429_1.var_.characterEffect1084ui_story and not isNil(var_432_1) then
					arg_429_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_429_1.time_ >= 0 + var_432_2 and arg_429_1.time_ < 0 + var_432_2 + arg_432_0 and not isNil(var_432_1) and arg_429_1.var_.characterEffect1084ui_story then
				arg_429_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_429_1.time_ and arg_429_1.time_ <= 0 + arg_432_0 then
				arg_429_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action4138")
			end

			if 0 < arg_429_1.time_ and arg_429_1.time_ <= 0 + arg_432_0 then
				arg_429_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_432_4 = 0
			local var_432_5 = 0.55

			if 0 < arg_429_1.time_ and arg_429_1.time_ <= var_432_4 + arg_432_0 then
				arg_429_1.talkMaxDuration = 0
				arg_429_1.dialogCg_.alpha = 1

				arg_429_1.dialog_:SetActive(true)
				SetActive(arg_429_1.leftNameGo_, true)

				arg_429_1.leftNameTxt_.text = arg_429_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_429_1.leftNameTxt_.transform)

				arg_429_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_429_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_429_1:RecordName(arg_429_1.leftNameTxt_.text)
				SetActive(arg_429_1.iconTrs_.gameObject, false)
				arg_429_1.callingController_:SetSelectedState("normal")

				local var_432_6 = arg_429_1:GetWordFromCfg(1108409105)
				local var_432_7 = arg_429_1:FormatText(var_432_6.content)

				arg_429_1.text_.text = var_432_7

				LuaForUtil.ClearLinePrefixSymbol(arg_429_1.text_)

				local var_432_9 = 22 <= 0 and var_432_5 or var_432_5 * (utf8.len(var_432_7) / 22)

				if (22 <= 0 and var_432_5 or var_432_5 * (utf8.len(var_432_7) / 22)) > 0 and var_432_5 < var_432_9 then
					arg_429_1.talkMaxDuration = var_432_9

					if var_432_9 + var_432_4 > arg_429_1.duration_ then
						arg_429_1.duration_ = var_432_9 + var_432_4
					end
				end

				arg_429_1.text_.text = var_432_7
				arg_429_1.typewritter.percent = 0

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409105", "story_v_side_new_1108409.awb") ~= 0 then
					local var_432_10 = manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409105", "story_v_side_new_1108409.awb") / 1000

					if var_432_10 + var_432_4 > arg_429_1.duration_ then
						arg_429_1.duration_ = var_432_10 + var_432_4
					end

					if var_432_6.prefab_name ~= "" and arg_429_1.actors_[var_432_6.prefab_name] ~= nil then
						local var_432_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_429_1.actors_[var_432_6.prefab_name].transform, "story_v_side_new_1108409", "1108409105", "story_v_side_new_1108409.awb")

						arg_429_1:RecordAudio("1108409105", var_432_11)
						arg_429_1:RecordAudio("1108409105", var_432_11)
					else
						arg_429_1:AudioAction("play", "voice", "story_v_side_new_1108409", "1108409105", "story_v_side_new_1108409.awb")
					end

					arg_429_1:RecordHistoryTalkVoice("story_v_side_new_1108409", "1108409105", "story_v_side_new_1108409.awb")
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
				actorName = "1084ui_story",
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
	Play1108409106 = function(arg_433_0, arg_433_1)
		arg_433_1.time_ = 0
		arg_433_1.frameCnt_ = 0
		arg_433_1.state_ = "playing"
		arg_433_1.curTalkId_ = 1108409106
		arg_433_1.duration_ = 5

		SetActive(arg_433_1.tipsGo_, false)

		function arg_433_1.onSingleLineFinish_()
			arg_433_1.onSingleLineUpdate_ = nil
			arg_433_1.onSingleLineFinish_ = nil
			arg_433_1.state_ = "waiting"
		end

		function arg_433_1.playNext_(arg_435_0)
			if arg_435_0 == 1 then
				arg_433_0:Play1108409107(arg_433_1)
			end
		end

		function arg_433_1.onSingleLineUpdate_(arg_436_0)
			if 0 < arg_433_1.time_ and arg_433_1.time_ <= 0 + arg_436_0 and not isNil(arg_433_1.actors_["1084ui_story"]) and arg_433_1.var_.characterEffect1084ui_story == nil then
				arg_433_1.var_.characterEffect1084ui_story = arg_433_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_436_0 = 0.200000002980232

			if 0 <= arg_433_1.time_ and arg_433_1.time_ < 0 + var_436_0 and not isNil(arg_433_1.actors_["1084ui_story"]) then
				if arg_433_1.var_.characterEffect1084ui_story and not isNil(arg_433_1.actors_["1084ui_story"]) then
					arg_433_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_433_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_433_1.time_ - 0) / var_436_0)
				end
			end

			if arg_433_1.time_ >= 0 + var_436_0 and arg_433_1.time_ < 0 + var_436_0 + arg_436_0 and not isNil(arg_433_1.actors_["1084ui_story"]) and arg_433_1.var_.characterEffect1084ui_story then
				arg_433_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_433_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_436_1 = 0
			local var_436_2 = 0.95

			if 0 < arg_433_1.time_ and arg_433_1.time_ <= var_436_1 + arg_436_0 then
				arg_433_1.talkMaxDuration = 0
				arg_433_1.dialogCg_.alpha = 1

				arg_433_1.dialog_:SetActive(true)
				SetActive(arg_433_1.leftNameGo_, false)

				arg_433_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_433_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_433_1:RecordName(arg_433_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_433_1.iconTrs_.gameObject, false)
				arg_433_1.callingController_:SetSelectedState("normal")

				local var_436_3 = arg_433_1:FormatText(arg_433_1:GetWordFromCfg(1108409106).content)

				arg_433_1.text_.text = var_436_3

				LuaForUtil.ClearLinePrefixSymbol(arg_433_1.text_)

				local var_436_5 = 38 <= 0 and var_436_2 or var_436_2 * (utf8.len(var_436_3) / 38)

				if (38 <= 0 and var_436_2 or var_436_2 * (utf8.len(var_436_3) / 38)) > 0 and var_436_2 < var_436_5 then
					arg_433_1.talkMaxDuration = var_436_5

					if var_436_5 + var_436_1 > arg_433_1.duration_ then
						arg_433_1.duration_ = var_436_5 + var_436_1
					end
				end

				arg_433_1.text_.text = var_436_3
				arg_433_1.typewritter.percent = 0

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(false)
				arg_433_1:RecordContent(arg_433_1.text_.text)
			end

			local var_436_6 = math.max(var_436_2, arg_433_1.talkMaxDuration)

			if var_436_1 <= arg_433_1.time_ and arg_433_1.time_ < var_436_1 + var_436_6 then
				arg_433_1.typewritter.percent = (arg_433_1.time_ - var_436_1) / var_436_6

				arg_433_1.typewritter:SetDirty()
			end

			if arg_433_1.time_ >= var_436_1 + var_436_6 and arg_433_1.time_ < var_436_1 + var_436_6 + arg_436_0 then
				arg_433_1.typewritter.percent = 1

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(true)
			end
		end

		arg_433_1.nodeConfigList_ = {}

		arg_433_1:InitPlayNodeList()
	end,
	Play1108409107 = function(arg_437_0, arg_437_1)
		arg_437_1.time_ = 0
		arg_437_1.frameCnt_ = 0
		arg_437_1.state_ = "playing"
		arg_437_1.curTalkId_ = 1108409107
		arg_437_1.duration_ = 5

		SetActive(arg_437_1.tipsGo_, false)

		function arg_437_1.onSingleLineFinish_()
			arg_437_1.onSingleLineUpdate_ = nil
			arg_437_1.onSingleLineFinish_ = nil
			arg_437_1.state_ = "waiting"
		end

		function arg_437_1.playNext_(arg_439_0)
			if arg_439_0 == 1 then
				arg_437_0:Play1108409108(arg_437_1)
			end
		end

		function arg_437_1.onSingleLineUpdate_(arg_440_0)
			local var_440_0 = 0.55

			if 0 < arg_437_1.time_ and arg_437_1.time_ <= 0 + arg_440_0 then
				arg_437_1.talkMaxDuration = 0
				arg_437_1.dialogCg_.alpha = 1

				arg_437_1.dialog_:SetActive(true)
				SetActive(arg_437_1.leftNameGo_, true)

				arg_437_1.leftNameTxt_.text = arg_437_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_437_1.leftNameTxt_.transform)

				arg_437_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_437_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_437_1:RecordName(arg_437_1.leftNameTxt_.text)
				SetActive(arg_437_1.iconTrs_.gameObject, true)
				arg_437_1.iconController_:SetSelectedState("hero")

				arg_437_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_437_1.callingController_:SetSelectedState("normal")

				arg_437_1.keyicon_.color = Color.New(1, 1, 1)
				arg_437_1.icon_.color = Color.New(1, 1, 1)

				local var_440_1 = arg_437_1:FormatText(arg_437_1:GetWordFromCfg(1108409107).content)

				arg_437_1.text_.text = var_440_1

				LuaForUtil.ClearLinePrefixSymbol(arg_437_1.text_)

				local var_440_3 = 22 <= 0 and var_440_0 or var_440_0 * (utf8.len(var_440_1) / 22)

				if (22 <= 0 and var_440_0 or var_440_0 * (utf8.len(var_440_1) / 22)) > 0 and var_440_0 < var_440_3 then
					arg_437_1.talkMaxDuration = var_440_3

					if var_440_3 + 0 > arg_437_1.duration_ then
						arg_437_1.duration_ = var_440_3 + 0
					end
				end

				arg_437_1.text_.text = var_440_1
				arg_437_1.typewritter.percent = 0

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(false)
				arg_437_1:RecordContent(arg_437_1.text_.text)
			end

			local var_440_4 = math.max(var_440_0, arg_437_1.talkMaxDuration)

			if 0 <= arg_437_1.time_ and arg_437_1.time_ < 0 + var_440_4 then
				arg_437_1.typewritter.percent = (arg_437_1.time_ - 0) / var_440_4

				arg_437_1.typewritter:SetDirty()
			end

			if arg_437_1.time_ >= 0 + var_440_4 and arg_437_1.time_ < 0 + var_440_4 + arg_440_0 then
				arg_437_1.typewritter.percent = 1

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(true)
			end
		end

		arg_437_1.nodeConfigList_ = {}

		arg_437_1:InitPlayNodeList()
	end,
	Play1108409108 = function(arg_441_0, arg_441_1)
		arg_441_1.time_ = 0
		arg_441_1.frameCnt_ = 0
		arg_441_1.state_ = "playing"
		arg_441_1.curTalkId_ = 1108409108
		arg_441_1.duration_ = 2

		SetActive(arg_441_1.tipsGo_, false)

		function arg_441_1.onSingleLineFinish_()
			arg_441_1.onSingleLineUpdate_ = nil
			arg_441_1.onSingleLineFinish_ = nil
			arg_441_1.state_ = "waiting"
		end

		function arg_441_1.playNext_(arg_443_0)
			if arg_443_0 == 1 then
				arg_441_0:Play1108409109(arg_441_1)
			end
		end

		function arg_441_1.onSingleLineUpdate_(arg_444_0)
			if 0 < arg_441_1.time_ and arg_441_1.time_ <= 0 + arg_444_0 and not isNil(arg_441_1.actors_["1084ui_story"]) and arg_441_1.var_.characterEffect1084ui_story == nil then
				arg_441_1.var_.characterEffect1084ui_story = arg_441_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_444_0 = 0.200000002980232

			if 0 <= arg_441_1.time_ and arg_441_1.time_ < 0 + var_444_0 and not isNil(arg_441_1.actors_["1084ui_story"]) then
				if arg_441_1.var_.characterEffect1084ui_story and not isNil(arg_441_1.actors_["1084ui_story"]) then
					arg_441_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_441_1.time_ >= 0 + var_444_0 and arg_441_1.time_ < 0 + var_444_0 + arg_444_0 and not isNil(arg_441_1.actors_["1084ui_story"]) and arg_441_1.var_.characterEffect1084ui_story then
				arg_441_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_441_1.time_ and arg_441_1.time_ <= 0 + arg_444_0 then
				arg_441_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action8_2")
			end

			if 0 < arg_441_1.time_ and arg_441_1.time_ <= 0 + arg_444_0 then
				arg_441_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva", "EmotionTimelineAnimator")
			end

			local var_444_2 = 0
			local var_444_3 = 0.125

			if 0 < arg_441_1.time_ and arg_441_1.time_ <= var_444_2 + arg_444_0 then
				arg_441_1.talkMaxDuration = 0
				arg_441_1.dialogCg_.alpha = 1

				arg_441_1.dialog_:SetActive(true)
				SetActive(arg_441_1.leftNameGo_, true)

				arg_441_1.leftNameTxt_.text = arg_441_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_441_1.leftNameTxt_.transform)

				arg_441_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_441_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_441_1:RecordName(arg_441_1.leftNameTxt_.text)
				SetActive(arg_441_1.iconTrs_.gameObject, false)
				arg_441_1.callingController_:SetSelectedState("normal")

				local var_444_4 = arg_441_1:GetWordFromCfg(1108409108)
				local var_444_5 = arg_441_1:FormatText(var_444_4.content)

				arg_441_1.text_.text = var_444_5

				LuaForUtil.ClearLinePrefixSymbol(arg_441_1.text_)

				local var_444_7 = 5 <= 0 and var_444_3 or var_444_3 * (utf8.len(var_444_5) / 5)

				if (5 <= 0 and var_444_3 or var_444_3 * (utf8.len(var_444_5) / 5)) > 0 and var_444_3 < var_444_7 then
					arg_441_1.talkMaxDuration = var_444_7

					if var_444_7 + var_444_2 > arg_441_1.duration_ then
						arg_441_1.duration_ = var_444_7 + var_444_2
					end
				end

				arg_441_1.text_.text = var_444_5
				arg_441_1.typewritter.percent = 0

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409108", "story_v_side_new_1108409.awb") ~= 0 then
					local var_444_8 = manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409108", "story_v_side_new_1108409.awb") / 1000

					if var_444_8 + var_444_2 > arg_441_1.duration_ then
						arg_441_1.duration_ = var_444_8 + var_444_2
					end

					if var_444_4.prefab_name ~= "" and arg_441_1.actors_[var_444_4.prefab_name] ~= nil then
						local var_444_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_441_1.actors_[var_444_4.prefab_name].transform, "story_v_side_new_1108409", "1108409108", "story_v_side_new_1108409.awb")

						arg_441_1:RecordAudio("1108409108", var_444_9)
						arg_441_1:RecordAudio("1108409108", var_444_9)
					else
						arg_441_1:AudioAction("play", "voice", "story_v_side_new_1108409", "1108409108", "story_v_side_new_1108409.awb")
					end

					arg_441_1:RecordHistoryTalkVoice("story_v_side_new_1108409", "1108409108", "story_v_side_new_1108409.awb")
				end

				arg_441_1:RecordContent(arg_441_1.text_.text)
			end

			local var_444_10 = math.max(var_444_3, arg_441_1.talkMaxDuration)

			if var_444_2 <= arg_441_1.time_ and arg_441_1.time_ < var_444_2 + var_444_10 then
				arg_441_1.typewritter.percent = (arg_441_1.time_ - var_444_2) / var_444_10

				arg_441_1.typewritter:SetDirty()
			end

			if arg_441_1.time_ >= var_444_2 + var_444_10 and arg_441_1.time_ < var_444_2 + var_444_10 + arg_444_0 then
				arg_441_1.typewritter.percent = 1

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(true)
			end
		end

		arg_441_1.nodeConfigList_ = {}

		arg_441_1:InitPlayNodeList()
	end,
	Play1108409109 = function(arg_445_0, arg_445_1)
		arg_445_1.time_ = 0
		arg_445_1.frameCnt_ = 0
		arg_445_1.state_ = "playing"
		arg_445_1.curTalkId_ = 1108409109
		arg_445_1.duration_ = 5

		SetActive(arg_445_1.tipsGo_, false)

		function arg_445_1.onSingleLineFinish_()
			arg_445_1.onSingleLineUpdate_ = nil
			arg_445_1.onSingleLineFinish_ = nil
			arg_445_1.state_ = "waiting"
		end

		function arg_445_1.playNext_(arg_447_0)
			if arg_447_0 == 1 then
				arg_445_0:Play1108409110(arg_445_1)
			end
		end

		function arg_445_1.onSingleLineUpdate_(arg_448_0)
			if 0 < arg_445_1.time_ and arg_445_1.time_ <= 0 + arg_448_0 and not isNil(arg_445_1.actors_["1084ui_story"]) and arg_445_1.var_.characterEffect1084ui_story == nil then
				arg_445_1.var_.characterEffect1084ui_story = arg_445_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_448_0 = 0.200000002980232

			if 0 <= arg_445_1.time_ and arg_445_1.time_ < 0 + var_448_0 and not isNil(arg_445_1.actors_["1084ui_story"]) then
				if arg_445_1.var_.characterEffect1084ui_story and not isNil(arg_445_1.actors_["1084ui_story"]) then
					arg_445_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_445_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_445_1.time_ - 0) / var_448_0)
				end
			end

			if arg_445_1.time_ >= 0 + var_448_0 and arg_445_1.time_ < 0 + var_448_0 + arg_448_0 and not isNil(arg_445_1.actors_["1084ui_story"]) and arg_445_1.var_.characterEffect1084ui_story then
				arg_445_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_445_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_448_1 = 0
			local var_448_2 = 0.325

			if 0 < arg_445_1.time_ and arg_445_1.time_ <= var_448_1 + arg_448_0 then
				arg_445_1.talkMaxDuration = 0
				arg_445_1.dialogCg_.alpha = 1

				arg_445_1.dialog_:SetActive(true)
				SetActive(arg_445_1.leftNameGo_, true)

				arg_445_1.leftNameTxt_.text = arg_445_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_445_1.leftNameTxt_.transform)

				arg_445_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_445_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_445_1:RecordName(arg_445_1.leftNameTxt_.text)
				SetActive(arg_445_1.iconTrs_.gameObject, true)
				arg_445_1.iconController_:SetSelectedState("hero")

				arg_445_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_445_1.callingController_:SetSelectedState("normal")

				arg_445_1.keyicon_.color = Color.New(1, 1, 1)
				arg_445_1.icon_.color = Color.New(1, 1, 1)

				local var_448_3 = arg_445_1:FormatText(arg_445_1:GetWordFromCfg(1108409109).content)

				arg_445_1.text_.text = var_448_3

				LuaForUtil.ClearLinePrefixSymbol(arg_445_1.text_)

				local var_448_5 = 13 <= 0 and var_448_2 or var_448_2 * (utf8.len(var_448_3) / 13)

				if (13 <= 0 and var_448_2 or var_448_2 * (utf8.len(var_448_3) / 13)) > 0 and var_448_2 < var_448_5 then
					arg_445_1.talkMaxDuration = var_448_5

					if var_448_5 + var_448_1 > arg_445_1.duration_ then
						arg_445_1.duration_ = var_448_5 + var_448_1
					end
				end

				arg_445_1.text_.text = var_448_3
				arg_445_1.typewritter.percent = 0

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(false)
				arg_445_1:RecordContent(arg_445_1.text_.text)
			end

			local var_448_6 = math.max(var_448_2, arg_445_1.talkMaxDuration)

			if var_448_1 <= arg_445_1.time_ and arg_445_1.time_ < var_448_1 + var_448_6 then
				arg_445_1.typewritter.percent = (arg_445_1.time_ - var_448_1) / var_448_6

				arg_445_1.typewritter:SetDirty()
			end

			if arg_445_1.time_ >= var_448_1 + var_448_6 and arg_445_1.time_ < var_448_1 + var_448_6 + arg_448_0 then
				arg_445_1.typewritter.percent = 1

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(true)
			end
		end

		arg_445_1.nodeConfigList_ = {}

		arg_445_1:InitPlayNodeList()
	end,
	Play1108409110 = function(arg_449_0, arg_449_1)
		arg_449_1.time_ = 0
		arg_449_1.frameCnt_ = 0
		arg_449_1.state_ = "playing"
		arg_449_1.curTalkId_ = 1108409110
		arg_449_1.duration_ = 6.23

		SetActive(arg_449_1.tipsGo_, false)

		function arg_449_1.onSingleLineFinish_()
			arg_449_1.onSingleLineUpdate_ = nil
			arg_449_1.onSingleLineFinish_ = nil
			arg_449_1.state_ = "waiting"
		end

		function arg_449_1.playNext_(arg_451_0)
			if arg_451_0 == 1 then
				arg_449_0:Play1108409111(arg_449_1)
			end
		end

		function arg_449_1.onSingleLineUpdate_(arg_452_0)
			if 0 < arg_449_1.time_ and arg_449_1.time_ <= 0 + arg_452_0 and not isNil(arg_449_1.actors_["1084ui_story"]) and arg_449_1.var_.characterEffect1084ui_story == nil then
				arg_449_1.var_.characterEffect1084ui_story = arg_449_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_452_0 = 0.200000002980232

			if 0 <= arg_449_1.time_ and arg_449_1.time_ < 0 + var_452_0 and not isNil(arg_449_1.actors_["1084ui_story"]) then
				if arg_449_1.var_.characterEffect1084ui_story and not isNil(arg_449_1.actors_["1084ui_story"]) then
					arg_449_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_449_1.time_ >= 0 + var_452_0 and arg_449_1.time_ < 0 + var_452_0 + arg_452_0 and not isNil(arg_449_1.actors_["1084ui_story"]) and arg_449_1.var_.characterEffect1084ui_story then
				arg_449_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_449_1.time_ and arg_449_1.time_ <= 0 + arg_452_0 then
				arg_449_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			if 0 < arg_449_1.time_ and arg_449_1.time_ <= 0 + arg_452_0 then
				arg_449_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_452_2 = 0
			local var_452_3 = 0.7

			if 0 < arg_449_1.time_ and arg_449_1.time_ <= var_452_2 + arg_452_0 then
				arg_449_1.talkMaxDuration = 0
				arg_449_1.dialogCg_.alpha = 1

				arg_449_1.dialog_:SetActive(true)
				SetActive(arg_449_1.leftNameGo_, true)

				arg_449_1.leftNameTxt_.text = arg_449_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_449_1.leftNameTxt_.transform)

				arg_449_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_449_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_449_1:RecordName(arg_449_1.leftNameTxt_.text)
				SetActive(arg_449_1.iconTrs_.gameObject, false)
				arg_449_1.callingController_:SetSelectedState("normal")

				local var_452_4 = arg_449_1:GetWordFromCfg(1108409110)
				local var_452_5 = arg_449_1:FormatText(var_452_4.content)

				arg_449_1.text_.text = var_452_5

				LuaForUtil.ClearLinePrefixSymbol(arg_449_1.text_)

				local var_452_7 = 28 <= 0 and var_452_3 or var_452_3 * (utf8.len(var_452_5) / 28)

				if (28 <= 0 and var_452_3 or var_452_3 * (utf8.len(var_452_5) / 28)) > 0 and var_452_3 < var_452_7 then
					arg_449_1.talkMaxDuration = var_452_7

					if var_452_7 + var_452_2 > arg_449_1.duration_ then
						arg_449_1.duration_ = var_452_7 + var_452_2
					end
				end

				arg_449_1.text_.text = var_452_5
				arg_449_1.typewritter.percent = 0

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409110", "story_v_side_new_1108409.awb") ~= 0 then
					local var_452_8 = manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409110", "story_v_side_new_1108409.awb") / 1000

					if var_452_8 + var_452_2 > arg_449_1.duration_ then
						arg_449_1.duration_ = var_452_8 + var_452_2
					end

					if var_452_4.prefab_name ~= "" and arg_449_1.actors_[var_452_4.prefab_name] ~= nil then
						local var_452_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_449_1.actors_[var_452_4.prefab_name].transform, "story_v_side_new_1108409", "1108409110", "story_v_side_new_1108409.awb")

						arg_449_1:RecordAudio("1108409110", var_452_9)
						arg_449_1:RecordAudio("1108409110", var_452_9)
					else
						arg_449_1:AudioAction("play", "voice", "story_v_side_new_1108409", "1108409110", "story_v_side_new_1108409.awb")
					end

					arg_449_1:RecordHistoryTalkVoice("story_v_side_new_1108409", "1108409110", "story_v_side_new_1108409.awb")
				end

				arg_449_1:RecordContent(arg_449_1.text_.text)
			end

			local var_452_10 = math.max(var_452_3, arg_449_1.talkMaxDuration)

			if var_452_2 <= arg_449_1.time_ and arg_449_1.time_ < var_452_2 + var_452_10 then
				arg_449_1.typewritter.percent = (arg_449_1.time_ - var_452_2) / var_452_10

				arg_449_1.typewritter:SetDirty()
			end

			if arg_449_1.time_ >= var_452_2 + var_452_10 and arg_449_1.time_ < var_452_2 + var_452_10 + arg_452_0 then
				arg_449_1.typewritter.percent = 1

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(true)
			end
		end

		arg_449_1.nodeConfigList_ = {}

		arg_449_1:InitPlayNodeList()
	end,
	Play1108409111 = function(arg_453_0, arg_453_1)
		arg_453_1.time_ = 0
		arg_453_1.frameCnt_ = 0
		arg_453_1.state_ = "playing"
		arg_453_1.curTalkId_ = 1108409111
		arg_453_1.duration_ = 5

		SetActive(arg_453_1.tipsGo_, false)

		function arg_453_1.onSingleLineFinish_()
			arg_453_1.onSingleLineUpdate_ = nil
			arg_453_1.onSingleLineFinish_ = nil
			arg_453_1.state_ = "waiting"
		end

		function arg_453_1.playNext_(arg_455_0)
			if arg_455_0 == 1 then
				arg_453_0:Play1108409112(arg_453_1)
			end
		end

		function arg_453_1.onSingleLineUpdate_(arg_456_0)
			if 0 < arg_453_1.time_ and arg_453_1.time_ <= 0 + arg_456_0 and not isNil(arg_453_1.actors_["1084ui_story"]) and arg_453_1.var_.characterEffect1084ui_story == nil then
				arg_453_1.var_.characterEffect1084ui_story = arg_453_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_456_0 = 0.200000002980232

			if 0 <= arg_453_1.time_ and arg_453_1.time_ < 0 + var_456_0 and not isNil(arg_453_1.actors_["1084ui_story"]) then
				if arg_453_1.var_.characterEffect1084ui_story and not isNil(arg_453_1.actors_["1084ui_story"]) then
					arg_453_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_453_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_453_1.time_ - 0) / var_456_0)
				end
			end

			if arg_453_1.time_ >= 0 + var_456_0 and arg_453_1.time_ < 0 + var_456_0 + arg_456_0 and not isNil(arg_453_1.actors_["1084ui_story"]) and arg_453_1.var_.characterEffect1084ui_story then
				arg_453_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_453_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_456_1 = 0
			local var_456_2 = 0.575

			if 0 < arg_453_1.time_ and arg_453_1.time_ <= var_456_1 + arg_456_0 then
				arg_453_1.talkMaxDuration = 0
				arg_453_1.dialogCg_.alpha = 1

				arg_453_1.dialog_:SetActive(true)
				SetActive(arg_453_1.leftNameGo_, true)

				arg_453_1.leftNameTxt_.text = arg_453_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_453_1.leftNameTxt_.transform)

				arg_453_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_453_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_453_1:RecordName(arg_453_1.leftNameTxt_.text)
				SetActive(arg_453_1.iconTrs_.gameObject, true)
				arg_453_1.iconController_:SetSelectedState("hero")

				arg_453_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_453_1.callingController_:SetSelectedState("normal")

				arg_453_1.keyicon_.color = Color.New(1, 1, 1)
				arg_453_1.icon_.color = Color.New(1, 1, 1)

				local var_456_3 = arg_453_1:FormatText(arg_453_1:GetWordFromCfg(1108409111).content)

				arg_453_1.text_.text = var_456_3

				LuaForUtil.ClearLinePrefixSymbol(arg_453_1.text_)

				local var_456_5 = 23 <= 0 and var_456_2 or var_456_2 * (utf8.len(var_456_3) / 23)

				if (23 <= 0 and var_456_2 or var_456_2 * (utf8.len(var_456_3) / 23)) > 0 and var_456_2 < var_456_5 then
					arg_453_1.talkMaxDuration = var_456_5

					if var_456_5 + var_456_1 > arg_453_1.duration_ then
						arg_453_1.duration_ = var_456_5 + var_456_1
					end
				end

				arg_453_1.text_.text = var_456_3
				arg_453_1.typewritter.percent = 0

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(false)
				arg_453_1:RecordContent(arg_453_1.text_.text)
			end

			local var_456_6 = math.max(var_456_2, arg_453_1.talkMaxDuration)

			if var_456_1 <= arg_453_1.time_ and arg_453_1.time_ < var_456_1 + var_456_6 then
				arg_453_1.typewritter.percent = (arg_453_1.time_ - var_456_1) / var_456_6

				arg_453_1.typewritter:SetDirty()
			end

			if arg_453_1.time_ >= var_456_1 + var_456_6 and arg_453_1.time_ < var_456_1 + var_456_6 + arg_456_0 then
				arg_453_1.typewritter.percent = 1

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(true)
			end
		end

		arg_453_1.nodeConfigList_ = {}

		arg_453_1:InitPlayNodeList()
	end,
	Play1108409112 = function(arg_457_0, arg_457_1)
		arg_457_1.time_ = 0
		arg_457_1.frameCnt_ = 0
		arg_457_1.state_ = "playing"
		arg_457_1.curTalkId_ = 1108409112
		arg_457_1.duration_ = 5

		SetActive(arg_457_1.tipsGo_, false)

		function arg_457_1.onSingleLineFinish_()
			arg_457_1.onSingleLineUpdate_ = nil
			arg_457_1.onSingleLineFinish_ = nil
			arg_457_1.state_ = "waiting"
		end

		function arg_457_1.playNext_(arg_459_0)
			if arg_459_0 == 1 then
				arg_457_0:Play1108409113(arg_457_1)
			end
		end

		function arg_457_1.onSingleLineUpdate_(arg_460_0)
			local var_460_0 = 1.525

			if 0 < arg_457_1.time_ and arg_457_1.time_ <= 0 + arg_460_0 then
				arg_457_1.talkMaxDuration = 0
				arg_457_1.dialogCg_.alpha = 1

				arg_457_1.dialog_:SetActive(true)
				SetActive(arg_457_1.leftNameGo_, false)

				arg_457_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_457_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_457_1:RecordName(arg_457_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_457_1.iconTrs_.gameObject, false)
				arg_457_1.callingController_:SetSelectedState("normal")

				local var_460_1 = arg_457_1:FormatText(arg_457_1:GetWordFromCfg(1108409112).content)

				arg_457_1.text_.text = var_460_1

				LuaForUtil.ClearLinePrefixSymbol(arg_457_1.text_)

				local var_460_3 = 61 <= 0 and var_460_0 or var_460_0 * (utf8.len(var_460_1) / 61)

				if (61 <= 0 and var_460_0 or var_460_0 * (utf8.len(var_460_1) / 61)) > 0 and var_460_0 < var_460_3 then
					arg_457_1.talkMaxDuration = var_460_3

					if var_460_3 + 0 > arg_457_1.duration_ then
						arg_457_1.duration_ = var_460_3 + 0
					end
				end

				arg_457_1.text_.text = var_460_1
				arg_457_1.typewritter.percent = 0

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(false)
				arg_457_1:RecordContent(arg_457_1.text_.text)
			end

			local var_460_4 = math.max(var_460_0, arg_457_1.talkMaxDuration)

			if 0 <= arg_457_1.time_ and arg_457_1.time_ < 0 + var_460_4 then
				arg_457_1.typewritter.percent = (arg_457_1.time_ - 0) / var_460_4

				arg_457_1.typewritter:SetDirty()
			end

			if arg_457_1.time_ >= 0 + var_460_4 and arg_457_1.time_ < 0 + var_460_4 + arg_460_0 then
				arg_457_1.typewritter.percent = 1

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(true)
			end
		end

		arg_457_1.nodeConfigList_ = {}

		arg_457_1:InitPlayNodeList()
	end,
	Play1108409113 = function(arg_461_0, arg_461_1)
		arg_461_1.time_ = 0
		arg_461_1.frameCnt_ = 0
		arg_461_1.state_ = "playing"
		arg_461_1.curTalkId_ = 1108409113
		arg_461_1.duration_ = 9

		SetActive(arg_461_1.tipsGo_, false)

		function arg_461_1.onSingleLineFinish_()
			arg_461_1.onSingleLineUpdate_ = nil
			arg_461_1.onSingleLineFinish_ = nil
			arg_461_1.state_ = "waiting"
		end

		function arg_461_1.playNext_(arg_463_0)
			if arg_463_0 == 1 then
				arg_461_0:Play1108409114(arg_461_1)
			end
		end

		function arg_461_1.onSingleLineUpdate_(arg_464_0)
			if arg_461_1.bgs_.ST03 == nil then
				local var_464_0 = Object.Instantiate(arg_461_1.paintGo_)

				var_464_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST03")
				var_464_0.name = "ST03"
				var_464_0.transform.parent = arg_461_1.stage_.transform
				var_464_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_461_1.bgs_.ST03 = var_464_0
			end

			if 2 < arg_461_1.time_ and arg_461_1.time_ <= 2 + arg_464_0 then
				local var_464_1 = arg_461_1.bgs_.ST03

				arg_461_1.bgs_.ST03.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_464_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_464_2 = var_464_1:GetComponent("SpriteRenderer")

				if var_464_2 and var_464_2.sprite then
					local var_464_3 = 2 * (var_464_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_464_1.transform.localScale = Vector3.New(var_464_3 / var_464_2.sprite.bounds.size.y < var_464_3 * manager.ui.mainCameraCom_.aspect / var_464_2.sprite.bounds.size.x and var_464_3 * manager.ui.mainCameraCom_.aspect / var_464_2.sprite.bounds.size.x or var_464_3 / var_464_2.sprite.bounds.size.y, var_464_3 / var_464_2.sprite.bounds.size.y < var_464_3 * manager.ui.mainCameraCom_.aspect / var_464_2.sprite.bounds.size.x and var_464_3 * manager.ui.mainCameraCom_.aspect / var_464_2.sprite.bounds.size.x or var_464_3 / var_464_2.sprite.bounds.size.y, 0)
				end

				for iter_464_0, iter_464_1 in pairs(arg_461_1.bgs_) do
					if iter_464_0 ~= "ST03" then
						iter_464_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_464_4 = 4

			if 4 < arg_461_1.time_ and arg_461_1.time_ <= var_464_4 + arg_464_0 then
				arg_461_1.allBtn_.enabled = false
			end

			if arg_461_1.time_ >= var_464_4 + 0.3 and arg_461_1.time_ < var_464_4 + 0.3 + arg_464_0 then
				arg_461_1.allBtn_.enabled = true
			end

			local var_464_5 = 0

			if 0 < arg_461_1.time_ and arg_461_1.time_ <= var_464_5 + arg_464_0 then
				arg_461_1.mask_.enabled = true
				arg_461_1.mask_.raycastTarget = true

				arg_461_1:SetGaussion(false)
			end

			local var_464_6 = 2

			if var_464_5 <= arg_461_1.time_ and arg_461_1.time_ < var_464_5 + var_464_6 then
				local var_464_7 = Color.New(0, 0, 0)

				var_464_7.a = Mathf.Lerp(0, 1, (arg_461_1.time_ - var_464_5) / var_464_6)
				arg_461_1.mask_.color = var_464_7
			end

			if arg_461_1.time_ >= var_464_5 + var_464_6 and arg_461_1.time_ < var_464_5 + var_464_6 + arg_464_0 then
				local var_464_8 = Color.New(0, 0, 0)

				var_464_8.a = 1
				arg_461_1.mask_.color = var_464_8
			end

			local var_464_9 = 2

			if 2 < arg_461_1.time_ and arg_461_1.time_ <= var_464_9 + arg_464_0 then
				arg_461_1.mask_.enabled = true
				arg_461_1.mask_.raycastTarget = true

				arg_461_1:SetGaussion(false)
			end

			local var_464_10 = 2

			if var_464_9 <= arg_461_1.time_ and arg_461_1.time_ < var_464_9 + var_464_10 then
				local var_464_11 = Color.New(0, 0, 0)

				var_464_11.a = Mathf.Lerp(1, 0, (arg_461_1.time_ - var_464_9) / var_464_10)
				arg_461_1.mask_.color = var_464_11
			end

			if arg_461_1.time_ >= var_464_9 + var_464_10 and arg_461_1.time_ < var_464_9 + var_464_10 + arg_464_0 then
				local var_464_12 = Color.New(0, 0, 0)

				arg_461_1.mask_.enabled = false
				var_464_12.a = 0
				arg_461_1.mask_.color = var_464_12
			end

			local var_464_13 = arg_461_1.actors_["1084ui_story"].transform

			if 1.96599999815226 < arg_461_1.time_ and arg_461_1.time_ <= 1.96599999815226 + arg_464_0 then
				arg_461_1.var_.moveOldPos1084ui_story = var_464_13.localPosition
			end

			local var_464_14 = 0.001

			if 1.96599999815226 <= arg_461_1.time_ and arg_461_1.time_ < 1.96599999815226 + var_464_14 then
				var_464_13.localPosition = Vector3.Lerp(arg_461_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_461_1.time_ - 1.96599999815226) / var_464_14)
				var_464_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_464_13.position).x, (manager.ui.mainCamera.transform.position - var_464_13.position).y, (manager.ui.mainCamera.transform.position - var_464_13.position).z)
				var_464_13.localEulerAngles.z = 0
				var_464_13.localEulerAngles.x = 0
				var_464_13.localEulerAngles = var_464_13.localEulerAngles
			end

			if arg_461_1.time_ >= 1.96599999815226 + var_464_14 and arg_461_1.time_ < 1.96599999815226 + var_464_14 + arg_464_0 then
				var_464_13.localPosition = Vector3.New(0, 100, 0)
				var_464_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_464_13.position).x, (manager.ui.mainCamera.transform.position - var_464_13.position).y, (manager.ui.mainCamera.transform.position - var_464_13.position).z)
				var_464_13.localEulerAngles.z = 0
				var_464_13.localEulerAngles.x = 0
				var_464_13.localEulerAngles = var_464_13.localEulerAngles
			end

			if 1.2 < arg_461_1.time_ and arg_461_1.time_ <= 1.2 + arg_464_0 then
				arg_461_1:AudioAction("play", "effect", "se_story_140", "se_story_140_amb_street02", "")
			end

			if 0.2 < arg_461_1.time_ and arg_461_1.time_ <= 0.2 + arg_464_0 then
				arg_461_1:AudioAction("stop", "effect", "se_story_side_1095", "se_story_side_1095_amb_car", "")
			end

			if arg_461_1.frameCnt_ <= 1 then
				arg_461_1.dialog_:SetActive(false)
			end

			local var_464_17 = 4
			local var_464_18 = 0.875

			if 4 < arg_461_1.time_ and arg_461_1.time_ <= var_464_17 + arg_464_0 then
				arg_461_1.talkMaxDuration = 0

				arg_461_1.dialog_:SetActive(true)

				arg_461_1.dialogCg_.alpha = 0

				local var_464_19 = LeanTween.value(arg_461_1.dialog_, 0, 1, 0.3)

				var_464_19:setOnUpdate(LuaHelper.FloatAction(function(arg_465_0)
					arg_461_1.dialogCg_.alpha = arg_465_0
				end))
				var_464_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_461_1.dialog_)
					var_464_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_461_1.duration_ = arg_461_1.duration_ + 0.3

				SetActive(arg_461_1.leftNameGo_, true)

				arg_461_1.leftNameTxt_.text = arg_461_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_461_1.leftNameTxt_.transform)

				arg_461_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_461_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_461_1:RecordName(arg_461_1.leftNameTxt_.text)
				SetActive(arg_461_1.iconTrs_.gameObject, true)
				arg_461_1.iconController_:SetSelectedState("hero")

				arg_461_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_461_1.callingController_:SetSelectedState("normal")

				arg_461_1.keyicon_.color = Color.New(1, 1, 1)
				arg_461_1.icon_.color = Color.New(1, 1, 1)

				local var_464_20 = arg_461_1:FormatText(arg_461_1:GetWordFromCfg(1108409113).content)

				arg_461_1.text_.text = var_464_20

				LuaForUtil.ClearLinePrefixSymbol(arg_461_1.text_)

				local var_464_22 = 35 <= 0 and var_464_18 or var_464_18 * (utf8.len(var_464_20) / 35)

				if (35 <= 0 and var_464_18 or var_464_18 * (utf8.len(var_464_20) / 35)) > 0 and var_464_18 < var_464_22 then
					arg_461_1.talkMaxDuration = var_464_22
					var_464_17 = var_464_17 + 0.3

					if var_464_22 + var_464_17 > arg_461_1.duration_ then
						arg_461_1.duration_ = var_464_22 + var_464_17
					end
				end

				arg_461_1.text_.text = var_464_20
				arg_461_1.typewritter.percent = 0

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(false)
				arg_461_1:RecordContent(arg_461_1.text_.text)
			end

			local var_464_23 = var_464_17 + 0.3
			local var_464_24 = math.max(var_464_18, arg_461_1.talkMaxDuration)

			if var_464_17 + 0.3 <= arg_461_1.time_ and arg_461_1.time_ < var_464_23 + var_464_24 then
				arg_461_1.typewritter.percent = (arg_461_1.time_ - var_464_23) / var_464_24

				arg_461_1.typewritter:SetDirty()
			end

			if arg_461_1.time_ >= var_464_23 + var_464_24 and arg_461_1.time_ < var_464_23 + var_464_24 + arg_464_0 then
				arg_461_1.typewritter.percent = 1

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(true)
			end
		end

		arg_461_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_461_1:InitPlayNodeList()
	end,
	Play1108409114 = function(arg_467_0, arg_467_1)
		arg_467_1.time_ = 0
		arg_467_1.frameCnt_ = 0
		arg_467_1.state_ = "playing"
		arg_467_1.curTalkId_ = 1108409114
		arg_467_1.duration_ = 5.8

		SetActive(arg_467_1.tipsGo_, false)

		function arg_467_1.onSingleLineFinish_()
			arg_467_1.onSingleLineUpdate_ = nil
			arg_467_1.onSingleLineFinish_ = nil
			arg_467_1.state_ = "waiting"
		end

		function arg_467_1.playNext_(arg_469_0)
			if arg_469_0 == 1 then
				arg_467_0:Play1108409115(arg_467_1)
			end
		end

		function arg_467_1.onSingleLineUpdate_(arg_470_0)
			if 0 < arg_467_1.time_ and arg_467_1.time_ <= 0 + arg_470_0 then
				arg_467_1.var_.moveOldPos1084ui_story = arg_467_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_470_0 = 0.001

			if 0 <= arg_467_1.time_ and arg_467_1.time_ < 0 + var_470_0 then
				arg_467_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_467_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_467_1.time_ - 0) / var_470_0)
				arg_467_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_467_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_467_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_467_1.actors_["1084ui_story"].transform.position).z)
				arg_467_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_467_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_467_1.actors_["1084ui_story"].transform.localEulerAngles = arg_467_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_467_1.time_ >= 0 + var_470_0 and arg_467_1.time_ < 0 + var_470_0 + arg_470_0 then
				arg_467_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_467_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_467_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_467_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_467_1.actors_["1084ui_story"].transform.position).z)
				arg_467_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_467_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_467_1.actors_["1084ui_story"].transform.localEulerAngles = arg_467_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_470_1 = arg_467_1.actors_["1084ui_story"]

			if 0 < arg_467_1.time_ and arg_467_1.time_ <= 0 + arg_470_0 and not isNil(var_470_1) and arg_467_1.var_.characterEffect1084ui_story == nil then
				arg_467_1.var_.characterEffect1084ui_story = var_470_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_470_2 = 0.200000002980232

			if 0 <= arg_467_1.time_ and arg_467_1.time_ < 0 + var_470_2 and not isNil(var_470_1) then
				if arg_467_1.var_.characterEffect1084ui_story and not isNil(var_470_1) then
					arg_467_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_467_1.time_ >= 0 + var_470_2 and arg_467_1.time_ < 0 + var_470_2 + arg_470_0 and not isNil(var_470_1) and arg_467_1.var_.characterEffect1084ui_story then
				arg_467_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_467_1.time_ and arg_467_1.time_ <= 0 + arg_470_0 then
				arg_467_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			if 0 < arg_467_1.time_ and arg_467_1.time_ <= 0 + arg_470_0 then
				arg_467_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_470_4 = 0
			local var_470_5 = 0.65

			if 0 < arg_467_1.time_ and arg_467_1.time_ <= var_470_4 + arg_470_0 then
				arg_467_1.talkMaxDuration = 0
				arg_467_1.dialogCg_.alpha = 1

				arg_467_1.dialog_:SetActive(true)
				SetActive(arg_467_1.leftNameGo_, true)

				arg_467_1.leftNameTxt_.text = arg_467_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_467_1.leftNameTxt_.transform)

				arg_467_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_467_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_467_1:RecordName(arg_467_1.leftNameTxt_.text)
				SetActive(arg_467_1.iconTrs_.gameObject, false)
				arg_467_1.callingController_:SetSelectedState("normal")

				local var_470_6 = arg_467_1:GetWordFromCfg(1108409114)
				local var_470_7 = arg_467_1:FormatText(var_470_6.content)

				arg_467_1.text_.text = var_470_7

				LuaForUtil.ClearLinePrefixSymbol(arg_467_1.text_)

				local var_470_9 = 26 <= 0 and var_470_5 or var_470_5 * (utf8.len(var_470_7) / 26)

				if (26 <= 0 and var_470_5 or var_470_5 * (utf8.len(var_470_7) / 26)) > 0 and var_470_5 < var_470_9 then
					arg_467_1.talkMaxDuration = var_470_9

					if var_470_9 + var_470_4 > arg_467_1.duration_ then
						arg_467_1.duration_ = var_470_9 + var_470_4
					end
				end

				arg_467_1.text_.text = var_470_7
				arg_467_1.typewritter.percent = 0

				arg_467_1.typewritter:SetDirty()
				arg_467_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409114", "story_v_side_new_1108409.awb") ~= 0 then
					local var_470_10 = manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409114", "story_v_side_new_1108409.awb") / 1000

					if var_470_10 + var_470_4 > arg_467_1.duration_ then
						arg_467_1.duration_ = var_470_10 + var_470_4
					end

					if var_470_6.prefab_name ~= "" and arg_467_1.actors_[var_470_6.prefab_name] ~= nil then
						local var_470_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_467_1.actors_[var_470_6.prefab_name].transform, "story_v_side_new_1108409", "1108409114", "story_v_side_new_1108409.awb")

						arg_467_1:RecordAudio("1108409114", var_470_11)
						arg_467_1:RecordAudio("1108409114", var_470_11)
					else
						arg_467_1:AudioAction("play", "voice", "story_v_side_new_1108409", "1108409114", "story_v_side_new_1108409.awb")
					end

					arg_467_1:RecordHistoryTalkVoice("story_v_side_new_1108409", "1108409114", "story_v_side_new_1108409.awb")
				end

				arg_467_1:RecordContent(arg_467_1.text_.text)
			end

			local var_470_12 = math.max(var_470_5, arg_467_1.talkMaxDuration)

			if var_470_4 <= arg_467_1.time_ and arg_467_1.time_ < var_470_4 + var_470_12 then
				arg_467_1.typewritter.percent = (arg_467_1.time_ - var_470_4) / var_470_12

				arg_467_1.typewritter:SetDirty()
			end

			if arg_467_1.time_ >= var_470_4 + var_470_12 and arg_467_1.time_ < var_470_4 + var_470_12 + arg_470_0 then
				arg_467_1.typewritter.percent = 1

				arg_467_1.typewritter:SetDirty()
				arg_467_1:ShowNextGo(true)
			end
		end

		arg_467_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_467_1:InitPlayNodeList()
	end,
	Play1108409115 = function(arg_471_0, arg_471_1)
		arg_471_1.time_ = 0
		arg_471_1.frameCnt_ = 0
		arg_471_1.state_ = "playing"
		arg_471_1.curTalkId_ = 1108409115
		arg_471_1.duration_ = 5

		SetActive(arg_471_1.tipsGo_, false)

		function arg_471_1.onSingleLineFinish_()
			arg_471_1.onSingleLineUpdate_ = nil
			arg_471_1.onSingleLineFinish_ = nil
			arg_471_1.state_ = "waiting"
		end

		function arg_471_1.playNext_(arg_473_0)
			if arg_473_0 == 1 then
				arg_471_0:Play1108409116(arg_471_1)
			end
		end

		function arg_471_1.onSingleLineUpdate_(arg_474_0)
			if 0 < arg_471_1.time_ and arg_471_1.time_ <= 0 + arg_474_0 and not isNil(arg_471_1.actors_["1084ui_story"]) and arg_471_1.var_.characterEffect1084ui_story == nil then
				arg_471_1.var_.characterEffect1084ui_story = arg_471_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_474_0 = 0.200000002980232

			if 0 <= arg_471_1.time_ and arg_471_1.time_ < 0 + var_474_0 and not isNil(arg_471_1.actors_["1084ui_story"]) then
				if arg_471_1.var_.characterEffect1084ui_story and not isNil(arg_471_1.actors_["1084ui_story"]) then
					arg_471_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_471_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_471_1.time_ - 0) / var_474_0)
				end
			end

			if arg_471_1.time_ >= 0 + var_474_0 and arg_471_1.time_ < 0 + var_474_0 + arg_474_0 and not isNil(arg_471_1.actors_["1084ui_story"]) and arg_471_1.var_.characterEffect1084ui_story then
				arg_471_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_471_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_474_1 = 0
			local var_474_2 = 0.45

			if 0 < arg_471_1.time_ and arg_471_1.time_ <= var_474_1 + arg_474_0 then
				arg_471_1.talkMaxDuration = 0
				arg_471_1.dialogCg_.alpha = 1

				arg_471_1.dialog_:SetActive(true)
				SetActive(arg_471_1.leftNameGo_, true)

				arg_471_1.leftNameTxt_.text = arg_471_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_471_1.leftNameTxt_.transform)

				arg_471_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_471_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_471_1:RecordName(arg_471_1.leftNameTxt_.text)
				SetActive(arg_471_1.iconTrs_.gameObject, true)
				arg_471_1.iconController_:SetSelectedState("hero")

				arg_471_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_471_1.callingController_:SetSelectedState("normal")

				arg_471_1.keyicon_.color = Color.New(1, 1, 1)
				arg_471_1.icon_.color = Color.New(1, 1, 1)

				local var_474_3 = arg_471_1:FormatText(arg_471_1:GetWordFromCfg(1108409115).content)

				arg_471_1.text_.text = var_474_3

				LuaForUtil.ClearLinePrefixSymbol(arg_471_1.text_)

				local var_474_5 = 18 <= 0 and var_474_2 or var_474_2 * (utf8.len(var_474_3) / 18)

				if (18 <= 0 and var_474_2 or var_474_2 * (utf8.len(var_474_3) / 18)) > 0 and var_474_2 < var_474_5 then
					arg_471_1.talkMaxDuration = var_474_5

					if var_474_5 + var_474_1 > arg_471_1.duration_ then
						arg_471_1.duration_ = var_474_5 + var_474_1
					end
				end

				arg_471_1.text_.text = var_474_3
				arg_471_1.typewritter.percent = 0

				arg_471_1.typewritter:SetDirty()
				arg_471_1:ShowNextGo(false)
				arg_471_1:RecordContent(arg_471_1.text_.text)
			end

			local var_474_6 = math.max(var_474_2, arg_471_1.talkMaxDuration)

			if var_474_1 <= arg_471_1.time_ and arg_471_1.time_ < var_474_1 + var_474_6 then
				arg_471_1.typewritter.percent = (arg_471_1.time_ - var_474_1) / var_474_6

				arg_471_1.typewritter:SetDirty()
			end

			if arg_471_1.time_ >= var_474_1 + var_474_6 and arg_471_1.time_ < var_474_1 + var_474_6 + arg_474_0 then
				arg_471_1.typewritter.percent = 1

				arg_471_1.typewritter:SetDirty()
				arg_471_1:ShowNextGo(true)
			end
		end

		arg_471_1.nodeConfigList_ = {}

		arg_471_1:InitPlayNodeList()
	end,
	Play1108409116 = function(arg_475_0, arg_475_1)
		arg_475_1.time_ = 0
		arg_475_1.frameCnt_ = 0
		arg_475_1.state_ = "playing"
		arg_475_1.curTalkId_ = 1108409116
		arg_475_1.duration_ = 2.7

		SetActive(arg_475_1.tipsGo_, false)

		function arg_475_1.onSingleLineFinish_()
			arg_475_1.onSingleLineUpdate_ = nil
			arg_475_1.onSingleLineFinish_ = nil
			arg_475_1.state_ = "waiting"
		end

		function arg_475_1.playNext_(arg_477_0)
			if arg_477_0 == 1 then
				arg_475_0:Play1108409117(arg_475_1)
			end
		end

		function arg_475_1.onSingleLineUpdate_(arg_478_0)
			if 0 < arg_475_1.time_ and arg_475_1.time_ <= 0 + arg_478_0 and not isNil(arg_475_1.actors_["1084ui_story"]) and arg_475_1.var_.characterEffect1084ui_story == nil then
				arg_475_1.var_.characterEffect1084ui_story = arg_475_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_478_0 = 0.200000002980232

			if 0 <= arg_475_1.time_ and arg_475_1.time_ < 0 + var_478_0 and not isNil(arg_475_1.actors_["1084ui_story"]) then
				if arg_475_1.var_.characterEffect1084ui_story and not isNil(arg_475_1.actors_["1084ui_story"]) then
					arg_475_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_475_1.time_ >= 0 + var_478_0 and arg_475_1.time_ < 0 + var_478_0 + arg_478_0 and not isNil(arg_475_1.actors_["1084ui_story"]) and arg_475_1.var_.characterEffect1084ui_story then
				arg_475_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_475_1.time_ and arg_475_1.time_ <= 0 + arg_478_0 then
				arg_475_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action8_1")
			end

			if 0 < arg_475_1.time_ and arg_475_1.time_ <= 0 + arg_478_0 then
				arg_475_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_478_2 = 0
			local var_478_3 = 0.325

			if 0 < arg_475_1.time_ and arg_475_1.time_ <= var_478_2 + arg_478_0 then
				arg_475_1.talkMaxDuration = 0
				arg_475_1.dialogCg_.alpha = 1

				arg_475_1.dialog_:SetActive(true)
				SetActive(arg_475_1.leftNameGo_, true)

				arg_475_1.leftNameTxt_.text = arg_475_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_475_1.leftNameTxt_.transform)

				arg_475_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_475_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_475_1:RecordName(arg_475_1.leftNameTxt_.text)
				SetActive(arg_475_1.iconTrs_.gameObject, false)
				arg_475_1.callingController_:SetSelectedState("normal")

				local var_478_4 = arg_475_1:GetWordFromCfg(1108409116)
				local var_478_5 = arg_475_1:FormatText(var_478_4.content)

				arg_475_1.text_.text = var_478_5

				LuaForUtil.ClearLinePrefixSymbol(arg_475_1.text_)

				local var_478_7 = 13 <= 0 and var_478_3 or var_478_3 * (utf8.len(var_478_5) / 13)

				if (13 <= 0 and var_478_3 or var_478_3 * (utf8.len(var_478_5) / 13)) > 0 and var_478_3 < var_478_7 then
					arg_475_1.talkMaxDuration = var_478_7

					if var_478_7 + var_478_2 > arg_475_1.duration_ then
						arg_475_1.duration_ = var_478_7 + var_478_2
					end
				end

				arg_475_1.text_.text = var_478_5
				arg_475_1.typewritter.percent = 0

				arg_475_1.typewritter:SetDirty()
				arg_475_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409116", "story_v_side_new_1108409.awb") ~= 0 then
					local var_478_8 = manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409116", "story_v_side_new_1108409.awb") / 1000

					if var_478_8 + var_478_2 > arg_475_1.duration_ then
						arg_475_1.duration_ = var_478_8 + var_478_2
					end

					if var_478_4.prefab_name ~= "" and arg_475_1.actors_[var_478_4.prefab_name] ~= nil then
						local var_478_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_475_1.actors_[var_478_4.prefab_name].transform, "story_v_side_new_1108409", "1108409116", "story_v_side_new_1108409.awb")

						arg_475_1:RecordAudio("1108409116", var_478_9)
						arg_475_1:RecordAudio("1108409116", var_478_9)
					else
						arg_475_1:AudioAction("play", "voice", "story_v_side_new_1108409", "1108409116", "story_v_side_new_1108409.awb")
					end

					arg_475_1:RecordHistoryTalkVoice("story_v_side_new_1108409", "1108409116", "story_v_side_new_1108409.awb")
				end

				arg_475_1:RecordContent(arg_475_1.text_.text)
			end

			local var_478_10 = math.max(var_478_3, arg_475_1.talkMaxDuration)

			if var_478_2 <= arg_475_1.time_ and arg_475_1.time_ < var_478_2 + var_478_10 then
				arg_475_1.typewritter.percent = (arg_475_1.time_ - var_478_2) / var_478_10

				arg_475_1.typewritter:SetDirty()
			end

			if arg_475_1.time_ >= var_478_2 + var_478_10 and arg_475_1.time_ < var_478_2 + var_478_10 + arg_478_0 then
				arg_475_1.typewritter.percent = 1

				arg_475_1.typewritter:SetDirty()
				arg_475_1:ShowNextGo(true)
			end
		end

		arg_475_1.nodeConfigList_ = {}

		arg_475_1:InitPlayNodeList()
	end,
	Play1108409117 = function(arg_479_0, arg_479_1)
		arg_479_1.time_ = 0
		arg_479_1.frameCnt_ = 0
		arg_479_1.state_ = "playing"
		arg_479_1.curTalkId_ = 1108409117
		arg_479_1.duration_ = 5

		SetActive(arg_479_1.tipsGo_, false)

		function arg_479_1.onSingleLineFinish_()
			arg_479_1.onSingleLineUpdate_ = nil
			arg_479_1.onSingleLineFinish_ = nil
			arg_479_1.state_ = "waiting"
		end

		function arg_479_1.playNext_(arg_481_0)
			if arg_481_0 == 1 then
				arg_479_0:Play1108409118(arg_479_1)
			end
		end

		function arg_479_1.onSingleLineUpdate_(arg_482_0)
			if 0 < arg_479_1.time_ and arg_479_1.time_ <= 0 + arg_482_0 and not isNil(arg_479_1.actors_["1084ui_story"]) and arg_479_1.var_.characterEffect1084ui_story == nil then
				arg_479_1.var_.characterEffect1084ui_story = arg_479_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_482_0 = 0.200000002980232

			if 0 <= arg_479_1.time_ and arg_479_1.time_ < 0 + var_482_0 and not isNil(arg_479_1.actors_["1084ui_story"]) then
				if arg_479_1.var_.characterEffect1084ui_story and not isNil(arg_479_1.actors_["1084ui_story"]) then
					arg_479_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_479_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_479_1.time_ - 0) / var_482_0)
				end
			end

			if arg_479_1.time_ >= 0 + var_482_0 and arg_479_1.time_ < 0 + var_482_0 + arg_482_0 and not isNil(arg_479_1.actors_["1084ui_story"]) and arg_479_1.var_.characterEffect1084ui_story then
				arg_479_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_479_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_482_1 = 0
			local var_482_2 = 0.525

			if 0 < arg_479_1.time_ and arg_479_1.time_ <= var_482_1 + arg_482_0 then
				arg_479_1.talkMaxDuration = 0
				arg_479_1.dialogCg_.alpha = 1

				arg_479_1.dialog_:SetActive(true)
				SetActive(arg_479_1.leftNameGo_, true)

				arg_479_1.leftNameTxt_.text = arg_479_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_479_1.leftNameTxt_.transform)

				arg_479_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_479_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_479_1:RecordName(arg_479_1.leftNameTxt_.text)
				SetActive(arg_479_1.iconTrs_.gameObject, true)
				arg_479_1.iconController_:SetSelectedState("hero")

				arg_479_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_479_1.callingController_:SetSelectedState("normal")

				arg_479_1.keyicon_.color = Color.New(1, 1, 1)
				arg_479_1.icon_.color = Color.New(1, 1, 1)

				local var_482_3 = arg_479_1:FormatText(arg_479_1:GetWordFromCfg(1108409117).content)

				arg_479_1.text_.text = var_482_3

				LuaForUtil.ClearLinePrefixSymbol(arg_479_1.text_)

				local var_482_5 = 21 <= 0 and var_482_2 or var_482_2 * (utf8.len(var_482_3) / 21)

				if (21 <= 0 and var_482_2 or var_482_2 * (utf8.len(var_482_3) / 21)) > 0 and var_482_2 < var_482_5 then
					arg_479_1.talkMaxDuration = var_482_5

					if var_482_5 + var_482_1 > arg_479_1.duration_ then
						arg_479_1.duration_ = var_482_5 + var_482_1
					end
				end

				arg_479_1.text_.text = var_482_3
				arg_479_1.typewritter.percent = 0

				arg_479_1.typewritter:SetDirty()
				arg_479_1:ShowNextGo(false)
				arg_479_1:RecordContent(arg_479_1.text_.text)
			end

			local var_482_6 = math.max(var_482_2, arg_479_1.talkMaxDuration)

			if var_482_1 <= arg_479_1.time_ and arg_479_1.time_ < var_482_1 + var_482_6 then
				arg_479_1.typewritter.percent = (arg_479_1.time_ - var_482_1) / var_482_6

				arg_479_1.typewritter:SetDirty()
			end

			if arg_479_1.time_ >= var_482_1 + var_482_6 and arg_479_1.time_ < var_482_1 + var_482_6 + arg_482_0 then
				arg_479_1.typewritter.percent = 1

				arg_479_1.typewritter:SetDirty()
				arg_479_1:ShowNextGo(true)
			end
		end

		arg_479_1.nodeConfigList_ = {}

		arg_479_1:InitPlayNodeList()
	end,
	Play1108409118 = function(arg_483_0, arg_483_1)
		arg_483_1.time_ = 0
		arg_483_1.frameCnt_ = 0
		arg_483_1.state_ = "playing"
		arg_483_1.curTalkId_ = 1108409118
		arg_483_1.duration_ = 3.77

		SetActive(arg_483_1.tipsGo_, false)

		function arg_483_1.onSingleLineFinish_()
			arg_483_1.onSingleLineUpdate_ = nil
			arg_483_1.onSingleLineFinish_ = nil
			arg_483_1.state_ = "waiting"
		end

		function arg_483_1.playNext_(arg_485_0)
			if arg_485_0 == 1 then
				arg_483_0:Play1108409119(arg_483_1)
			end
		end

		function arg_483_1.onSingleLineUpdate_(arg_486_0)
			if 0 < arg_483_1.time_ and arg_483_1.time_ <= 0 + arg_486_0 and not isNil(arg_483_1.actors_["1084ui_story"]) and arg_483_1.var_.characterEffect1084ui_story == nil then
				arg_483_1.var_.characterEffect1084ui_story = arg_483_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_486_0 = 0.200000002980232

			if 0 <= arg_483_1.time_ and arg_483_1.time_ < 0 + var_486_0 and not isNil(arg_483_1.actors_["1084ui_story"]) then
				if arg_483_1.var_.characterEffect1084ui_story and not isNil(arg_483_1.actors_["1084ui_story"]) then
					arg_483_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_483_1.time_ >= 0 + var_486_0 and arg_483_1.time_ < 0 + var_486_0 + arg_486_0 and not isNil(arg_483_1.actors_["1084ui_story"]) and arg_483_1.var_.characterEffect1084ui_story then
				arg_483_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_483_1.time_ and arg_483_1.time_ <= 0 + arg_486_0 then
				arg_483_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action4812")
			end

			if 0 < arg_483_1.time_ and arg_483_1.time_ <= 0 + arg_486_0 then
				arg_483_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_486_2 = 0
			local var_486_3 = 0.65

			if 0 < arg_483_1.time_ and arg_483_1.time_ <= var_486_2 + arg_486_0 then
				arg_483_1.talkMaxDuration = 0
				arg_483_1.dialogCg_.alpha = 1

				arg_483_1.dialog_:SetActive(true)
				SetActive(arg_483_1.leftNameGo_, true)

				arg_483_1.leftNameTxt_.text = arg_483_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_483_1.leftNameTxt_.transform)

				arg_483_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_483_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_483_1:RecordName(arg_483_1.leftNameTxt_.text)
				SetActive(arg_483_1.iconTrs_.gameObject, false)
				arg_483_1.callingController_:SetSelectedState("normal")

				local var_486_4 = arg_483_1:GetWordFromCfg(1108409118)
				local var_486_5 = arg_483_1:FormatText(var_486_4.content)

				arg_483_1.text_.text = var_486_5

				LuaForUtil.ClearLinePrefixSymbol(arg_483_1.text_)

				local var_486_7 = 26 <= 0 and var_486_3 or var_486_3 * (utf8.len(var_486_5) / 26)

				if (26 <= 0 and var_486_3 or var_486_3 * (utf8.len(var_486_5) / 26)) > 0 and var_486_3 < var_486_7 then
					arg_483_1.talkMaxDuration = var_486_7

					if var_486_7 + var_486_2 > arg_483_1.duration_ then
						arg_483_1.duration_ = var_486_7 + var_486_2
					end
				end

				arg_483_1.text_.text = var_486_5
				arg_483_1.typewritter.percent = 0

				arg_483_1.typewritter:SetDirty()
				arg_483_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409118", "story_v_side_new_1108409.awb") ~= 0 then
					local var_486_8 = manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409118", "story_v_side_new_1108409.awb") / 1000

					if var_486_8 + var_486_2 > arg_483_1.duration_ then
						arg_483_1.duration_ = var_486_8 + var_486_2
					end

					if var_486_4.prefab_name ~= "" and arg_483_1.actors_[var_486_4.prefab_name] ~= nil then
						local var_486_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_483_1.actors_[var_486_4.prefab_name].transform, "story_v_side_new_1108409", "1108409118", "story_v_side_new_1108409.awb")

						arg_483_1:RecordAudio("1108409118", var_486_9)
						arg_483_1:RecordAudio("1108409118", var_486_9)
					else
						arg_483_1:AudioAction("play", "voice", "story_v_side_new_1108409", "1108409118", "story_v_side_new_1108409.awb")
					end

					arg_483_1:RecordHistoryTalkVoice("story_v_side_new_1108409", "1108409118", "story_v_side_new_1108409.awb")
				end

				arg_483_1:RecordContent(arg_483_1.text_.text)
			end

			local var_486_10 = math.max(var_486_3, arg_483_1.talkMaxDuration)

			if var_486_2 <= arg_483_1.time_ and arg_483_1.time_ < var_486_2 + var_486_10 then
				arg_483_1.typewritter.percent = (arg_483_1.time_ - var_486_2) / var_486_10

				arg_483_1.typewritter:SetDirty()
			end

			if arg_483_1.time_ >= var_486_2 + var_486_10 and arg_483_1.time_ < var_486_2 + var_486_10 + arg_486_0 then
				arg_483_1.typewritter.percent = 1

				arg_483_1.typewritter:SetDirty()
				arg_483_1:ShowNextGo(true)
			end
		end

		arg_483_1.nodeConfigList_ = {}

		arg_483_1:InitPlayNodeList()
	end,
	Play1108409119 = function(arg_487_0, arg_487_1)
		arg_487_1.time_ = 0
		arg_487_1.frameCnt_ = 0
		arg_487_1.state_ = "playing"
		arg_487_1.curTalkId_ = 1108409119
		arg_487_1.duration_ = 5

		SetActive(arg_487_1.tipsGo_, false)

		function arg_487_1.onSingleLineFinish_()
			arg_487_1.onSingleLineUpdate_ = nil
			arg_487_1.onSingleLineFinish_ = nil
			arg_487_1.state_ = "waiting"
		end

		function arg_487_1.playNext_(arg_489_0)
			if arg_489_0 == 1 then
				arg_487_0:Play1108409120(arg_487_1)
			end
		end

		function arg_487_1.onSingleLineUpdate_(arg_490_0)
			if 0 < arg_487_1.time_ and arg_487_1.time_ <= 0 + arg_490_0 and not isNil(arg_487_1.actors_["1084ui_story"]) and arg_487_1.var_.characterEffect1084ui_story == nil then
				arg_487_1.var_.characterEffect1084ui_story = arg_487_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_490_0 = 0.200000002980232

			if 0 <= arg_487_1.time_ and arg_487_1.time_ < 0 + var_490_0 and not isNil(arg_487_1.actors_["1084ui_story"]) then
				if arg_487_1.var_.characterEffect1084ui_story and not isNil(arg_487_1.actors_["1084ui_story"]) then
					arg_487_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_487_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_487_1.time_ - 0) / var_490_0)
				end
			end

			if arg_487_1.time_ >= 0 + var_490_0 and arg_487_1.time_ < 0 + var_490_0 + arg_490_0 and not isNil(arg_487_1.actors_["1084ui_story"]) and arg_487_1.var_.characterEffect1084ui_story then
				arg_487_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_487_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_490_1 = 0
			local var_490_2 = 0.35

			if 0 < arg_487_1.time_ and arg_487_1.time_ <= var_490_1 + arg_490_0 then
				arg_487_1.talkMaxDuration = 0
				arg_487_1.dialogCg_.alpha = 1

				arg_487_1.dialog_:SetActive(true)
				SetActive(arg_487_1.leftNameGo_, true)

				arg_487_1.leftNameTxt_.text = arg_487_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_487_1.leftNameTxt_.transform)

				arg_487_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_487_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_487_1:RecordName(arg_487_1.leftNameTxt_.text)
				SetActive(arg_487_1.iconTrs_.gameObject, true)
				arg_487_1.iconController_:SetSelectedState("hero")

				arg_487_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_487_1.callingController_:SetSelectedState("normal")

				arg_487_1.keyicon_.color = Color.New(1, 1, 1)
				arg_487_1.icon_.color = Color.New(1, 1, 1)

				local var_490_3 = arg_487_1:FormatText(arg_487_1:GetWordFromCfg(1108409119).content)

				arg_487_1.text_.text = var_490_3

				LuaForUtil.ClearLinePrefixSymbol(arg_487_1.text_)

				local var_490_5 = 14 <= 0 and var_490_2 or var_490_2 * (utf8.len(var_490_3) / 14)

				if (14 <= 0 and var_490_2 or var_490_2 * (utf8.len(var_490_3) / 14)) > 0 and var_490_2 < var_490_5 then
					arg_487_1.talkMaxDuration = var_490_5

					if var_490_5 + var_490_1 > arg_487_1.duration_ then
						arg_487_1.duration_ = var_490_5 + var_490_1
					end
				end

				arg_487_1.text_.text = var_490_3
				arg_487_1.typewritter.percent = 0

				arg_487_1.typewritter:SetDirty()
				arg_487_1:ShowNextGo(false)
				arg_487_1:RecordContent(arg_487_1.text_.text)
			end

			local var_490_6 = math.max(var_490_2, arg_487_1.talkMaxDuration)

			if var_490_1 <= arg_487_1.time_ and arg_487_1.time_ < var_490_1 + var_490_6 then
				arg_487_1.typewritter.percent = (arg_487_1.time_ - var_490_1) / var_490_6

				arg_487_1.typewritter:SetDirty()
			end

			if arg_487_1.time_ >= var_490_1 + var_490_6 and arg_487_1.time_ < var_490_1 + var_490_6 + arg_490_0 then
				arg_487_1.typewritter.percent = 1

				arg_487_1.typewritter:SetDirty()
				arg_487_1:ShowNextGo(true)
			end
		end

		arg_487_1.nodeConfigList_ = {}

		arg_487_1:InitPlayNodeList()
	end,
	Play1108409120 = function(arg_491_0, arg_491_1)
		arg_491_1.time_ = 0
		arg_491_1.frameCnt_ = 0
		arg_491_1.state_ = "playing"
		arg_491_1.curTalkId_ = 1108409120
		arg_491_1.duration_ = 7.7

		SetActive(arg_491_1.tipsGo_, false)

		function arg_491_1.onSingleLineFinish_()
			arg_491_1.onSingleLineUpdate_ = nil
			arg_491_1.onSingleLineFinish_ = nil
			arg_491_1.state_ = "waiting"
		end

		function arg_491_1.playNext_(arg_493_0)
			if arg_493_0 == 1 then
				arg_491_0:Play1108409121(arg_491_1)
			end
		end

		function arg_491_1.onSingleLineUpdate_(arg_494_0)
			if 0 < arg_491_1.time_ and arg_491_1.time_ <= 0 + arg_494_0 and not isNil(arg_491_1.actors_["1084ui_story"]) and arg_491_1.var_.characterEffect1084ui_story == nil then
				arg_491_1.var_.characterEffect1084ui_story = arg_491_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_494_0 = 0.200000002980232

			if 0 <= arg_491_1.time_ and arg_491_1.time_ < 0 + var_494_0 and not isNil(arg_491_1.actors_["1084ui_story"]) then
				if arg_491_1.var_.characterEffect1084ui_story and not isNil(arg_491_1.actors_["1084ui_story"]) then
					arg_491_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_491_1.time_ >= 0 + var_494_0 and arg_491_1.time_ < 0 + var_494_0 + arg_494_0 and not isNil(arg_491_1.actors_["1084ui_story"]) and arg_491_1.var_.characterEffect1084ui_story then
				arg_491_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_491_1.time_ and arg_491_1.time_ <= 0 + arg_494_0 then
				arg_491_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action4127")
			end

			if 0 < arg_491_1.time_ and arg_491_1.time_ <= 0 + arg_494_0 then
				arg_491_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_494_2 = 0
			local var_494_3 = 0.725

			if 0 < arg_491_1.time_ and arg_491_1.time_ <= var_494_2 + arg_494_0 then
				arg_491_1.talkMaxDuration = 0
				arg_491_1.dialogCg_.alpha = 1

				arg_491_1.dialog_:SetActive(true)
				SetActive(arg_491_1.leftNameGo_, true)

				arg_491_1.leftNameTxt_.text = arg_491_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_491_1.leftNameTxt_.transform)

				arg_491_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_491_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_491_1:RecordName(arg_491_1.leftNameTxt_.text)
				SetActive(arg_491_1.iconTrs_.gameObject, false)
				arg_491_1.callingController_:SetSelectedState("normal")

				local var_494_4 = arg_491_1:GetWordFromCfg(1108409120)
				local var_494_5 = arg_491_1:FormatText(var_494_4.content)

				arg_491_1.text_.text = var_494_5

				LuaForUtil.ClearLinePrefixSymbol(arg_491_1.text_)

				local var_494_7 = 29 <= 0 and var_494_3 or var_494_3 * (utf8.len(var_494_5) / 29)

				if (29 <= 0 and var_494_3 or var_494_3 * (utf8.len(var_494_5) / 29)) > 0 and var_494_3 < var_494_7 then
					arg_491_1.talkMaxDuration = var_494_7

					if var_494_7 + var_494_2 > arg_491_1.duration_ then
						arg_491_1.duration_ = var_494_7 + var_494_2
					end
				end

				arg_491_1.text_.text = var_494_5
				arg_491_1.typewritter.percent = 0

				arg_491_1.typewritter:SetDirty()
				arg_491_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409120", "story_v_side_new_1108409.awb") ~= 0 then
					local var_494_8 = manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409120", "story_v_side_new_1108409.awb") / 1000

					if var_494_8 + var_494_2 > arg_491_1.duration_ then
						arg_491_1.duration_ = var_494_8 + var_494_2
					end

					if var_494_4.prefab_name ~= "" and arg_491_1.actors_[var_494_4.prefab_name] ~= nil then
						local var_494_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_491_1.actors_[var_494_4.prefab_name].transform, "story_v_side_new_1108409", "1108409120", "story_v_side_new_1108409.awb")

						arg_491_1:RecordAudio("1108409120", var_494_9)
						arg_491_1:RecordAudio("1108409120", var_494_9)
					else
						arg_491_1:AudioAction("play", "voice", "story_v_side_new_1108409", "1108409120", "story_v_side_new_1108409.awb")
					end

					arg_491_1:RecordHistoryTalkVoice("story_v_side_new_1108409", "1108409120", "story_v_side_new_1108409.awb")
				end

				arg_491_1:RecordContent(arg_491_1.text_.text)
			end

			local var_494_10 = math.max(var_494_3, arg_491_1.talkMaxDuration)

			if var_494_2 <= arg_491_1.time_ and arg_491_1.time_ < var_494_2 + var_494_10 then
				arg_491_1.typewritter.percent = (arg_491_1.time_ - var_494_2) / var_494_10

				arg_491_1.typewritter:SetDirty()
			end

			if arg_491_1.time_ >= var_494_2 + var_494_10 and arg_491_1.time_ < var_494_2 + var_494_10 + arg_494_0 then
				arg_491_1.typewritter.percent = 1

				arg_491_1.typewritter:SetDirty()
				arg_491_1:ShowNextGo(true)
			end
		end

		arg_491_1.nodeConfigList_ = {}

		arg_491_1:InitPlayNodeList()
	end,
	Play1108409121 = function(arg_495_0, arg_495_1)
		arg_495_1.time_ = 0
		arg_495_1.frameCnt_ = 0
		arg_495_1.state_ = "playing"
		arg_495_1.curTalkId_ = 1108409121
		arg_495_1.duration_ = 5

		SetActive(arg_495_1.tipsGo_, false)

		function arg_495_1.onSingleLineFinish_()
			arg_495_1.onSingleLineUpdate_ = nil
			arg_495_1.onSingleLineFinish_ = nil
			arg_495_1.state_ = "waiting"
		end

		function arg_495_1.playNext_(arg_497_0)
			if arg_497_0 == 1 then
				arg_495_0:Play1108409122(arg_495_1)
			end
		end

		function arg_495_1.onSingleLineUpdate_(arg_498_0)
			if 0 < arg_495_1.time_ and arg_495_1.time_ <= 0 + arg_498_0 then
				arg_495_1.var_.moveOldPos1084ui_story = arg_495_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_498_0 = 0.001

			if 0 <= arg_495_1.time_ and arg_495_1.time_ < 0 + var_498_0 then
				arg_495_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_495_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_495_1.time_ - 0) / var_498_0)
				arg_495_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_495_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_495_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_495_1.actors_["1084ui_story"].transform.position).z)
				arg_495_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_495_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_495_1.actors_["1084ui_story"].transform.localEulerAngles = arg_495_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_495_1.time_ >= 0 + var_498_0 and arg_495_1.time_ < 0 + var_498_0 + arg_498_0 then
				arg_495_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_495_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_495_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_495_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_495_1.actors_["1084ui_story"].transform.position).z)
				arg_495_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_495_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_495_1.actors_["1084ui_story"].transform.localEulerAngles = arg_495_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_498_1 = arg_495_1.actors_["1084ui_story"]

			if 0 < arg_495_1.time_ and arg_495_1.time_ <= 0 + arg_498_0 and not isNil(var_498_1) and arg_495_1.var_.characterEffect1084ui_story == nil then
				arg_495_1.var_.characterEffect1084ui_story = var_498_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_498_2 = 0.200000002980232

			if 0 <= arg_495_1.time_ and arg_495_1.time_ < 0 + var_498_2 and not isNil(var_498_1) then
				if arg_495_1.var_.characterEffect1084ui_story and not isNil(var_498_1) then
					arg_495_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_495_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_495_1.time_ - 0) / var_498_2)
				end
			end

			if arg_495_1.time_ >= 0 + var_498_2 and arg_495_1.time_ < 0 + var_498_2 + arg_498_0 and not isNil(var_498_1) and arg_495_1.var_.characterEffect1084ui_story then
				arg_495_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_495_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_498_3 = 0
			local var_498_4 = 1.025

			if 0 < arg_495_1.time_ and arg_495_1.time_ <= var_498_3 + arg_498_0 then
				arg_495_1.talkMaxDuration = 0
				arg_495_1.dialogCg_.alpha = 1

				arg_495_1.dialog_:SetActive(true)
				SetActive(arg_495_1.leftNameGo_, false)

				arg_495_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_495_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_495_1:RecordName(arg_495_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_495_1.iconTrs_.gameObject, false)
				arg_495_1.callingController_:SetSelectedState("normal")

				local var_498_5 = arg_495_1:FormatText(arg_495_1:GetWordFromCfg(1108409121).content)

				arg_495_1.text_.text = var_498_5

				LuaForUtil.ClearLinePrefixSymbol(arg_495_1.text_)

				local var_498_7 = 41 <= 0 and var_498_4 or var_498_4 * (utf8.len(var_498_5) / 41)

				if (41 <= 0 and var_498_4 or var_498_4 * (utf8.len(var_498_5) / 41)) > 0 and var_498_4 < var_498_7 then
					arg_495_1.talkMaxDuration = var_498_7

					if var_498_7 + var_498_3 > arg_495_1.duration_ then
						arg_495_1.duration_ = var_498_7 + var_498_3
					end
				end

				arg_495_1.text_.text = var_498_5
				arg_495_1.typewritter.percent = 0

				arg_495_1.typewritter:SetDirty()
				arg_495_1:ShowNextGo(false)
				arg_495_1:RecordContent(arg_495_1.text_.text)
			end

			local var_498_8 = math.max(var_498_4, arg_495_1.talkMaxDuration)

			if var_498_3 <= arg_495_1.time_ and arg_495_1.time_ < var_498_3 + var_498_8 then
				arg_495_1.typewritter.percent = (arg_495_1.time_ - var_498_3) / var_498_8

				arg_495_1.typewritter:SetDirty()
			end

			if arg_495_1.time_ >= var_498_3 + var_498_8 and arg_495_1.time_ < var_498_3 + var_498_8 + arg_498_0 then
				arg_495_1.typewritter.percent = 1

				arg_495_1.typewritter:SetDirty()
				arg_495_1:ShowNextGo(true)
			end
		end

		arg_495_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_495_1:InitPlayNodeList()
	end,
	Play1108409122 = function(arg_499_0, arg_499_1)
		arg_499_1.time_ = 0
		arg_499_1.frameCnt_ = 0
		arg_499_1.state_ = "playing"
		arg_499_1.curTalkId_ = 1108409122
		arg_499_1.duration_ = 5

		SetActive(arg_499_1.tipsGo_, false)

		function arg_499_1.onSingleLineFinish_()
			arg_499_1.onSingleLineUpdate_ = nil
			arg_499_1.onSingleLineFinish_ = nil
			arg_499_1.state_ = "waiting"
		end

		function arg_499_1.playNext_(arg_501_0)
			if arg_501_0 == 1 then
				arg_499_0:Play1108409123(arg_499_1)
			end
		end

		function arg_499_1.onSingleLineUpdate_(arg_502_0)
			local var_502_0 = 0.375

			if 0 < arg_499_1.time_ and arg_499_1.time_ <= 0 + arg_502_0 then
				arg_499_1.talkMaxDuration = 0
				arg_499_1.dialogCg_.alpha = 1

				arg_499_1.dialog_:SetActive(true)
				SetActive(arg_499_1.leftNameGo_, true)

				arg_499_1.leftNameTxt_.text = arg_499_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_499_1.leftNameTxt_.transform)

				arg_499_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_499_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_499_1:RecordName(arg_499_1.leftNameTxt_.text)
				SetActive(arg_499_1.iconTrs_.gameObject, true)
				arg_499_1.iconController_:SetSelectedState("hero")

				arg_499_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_499_1.callingController_:SetSelectedState("normal")

				arg_499_1.keyicon_.color = Color.New(1, 1, 1)
				arg_499_1.icon_.color = Color.New(1, 1, 1)

				local var_502_1 = arg_499_1:FormatText(arg_499_1:GetWordFromCfg(1108409122).content)

				arg_499_1.text_.text = var_502_1

				LuaForUtil.ClearLinePrefixSymbol(arg_499_1.text_)

				local var_502_3 = 15 <= 0 and var_502_0 or var_502_0 * (utf8.len(var_502_1) / 15)

				if (15 <= 0 and var_502_0 or var_502_0 * (utf8.len(var_502_1) / 15)) > 0 and var_502_0 < var_502_3 then
					arg_499_1.talkMaxDuration = var_502_3

					if var_502_3 + 0 > arg_499_1.duration_ then
						arg_499_1.duration_ = var_502_3 + 0
					end
				end

				arg_499_1.text_.text = var_502_1
				arg_499_1.typewritter.percent = 0

				arg_499_1.typewritter:SetDirty()
				arg_499_1:ShowNextGo(false)
				arg_499_1:RecordContent(arg_499_1.text_.text)
			end

			local var_502_4 = math.max(var_502_0, arg_499_1.talkMaxDuration)

			if 0 <= arg_499_1.time_ and arg_499_1.time_ < 0 + var_502_4 then
				arg_499_1.typewritter.percent = (arg_499_1.time_ - 0) / var_502_4

				arg_499_1.typewritter:SetDirty()
			end

			if arg_499_1.time_ >= 0 + var_502_4 and arg_499_1.time_ < 0 + var_502_4 + arg_502_0 then
				arg_499_1.typewritter.percent = 1

				arg_499_1.typewritter:SetDirty()
				arg_499_1:ShowNextGo(true)
			end
		end

		arg_499_1.nodeConfigList_ = {}

		arg_499_1:InitPlayNodeList()
	end,
	Play1108409123 = function(arg_503_0, arg_503_1)
		arg_503_1.time_ = 0
		arg_503_1.frameCnt_ = 0
		arg_503_1.state_ = "playing"
		arg_503_1.curTalkId_ = 1108409123
		arg_503_1.duration_ = 8.33

		SetActive(arg_503_1.tipsGo_, false)

		function arg_503_1.onSingleLineFinish_()
			arg_503_1.onSingleLineUpdate_ = nil
			arg_503_1.onSingleLineFinish_ = nil
			arg_503_1.state_ = "waiting"
		end

		function arg_503_1.playNext_(arg_505_0)
			if arg_505_0 == 1 then
				arg_503_0:Play1108409124(arg_503_1)
			end
		end

		function arg_503_1.onSingleLineUpdate_(arg_506_0)
			local var_506_9000

			if 1.33333333333333 < arg_503_1.time_ and arg_503_1.time_ <= 1.33333333333333 + arg_506_0 then
				arg_503_1.allBtn_.enabled = false
			end

			if arg_503_1.time_ >= 1.33333333333333 + 0.3 and arg_503_1.time_ < 1.33333333333333 + 0.3 + arg_506_0 then
				arg_503_1.allBtn_.enabled = true
			end

			if 0 < arg_503_1.time_ and arg_503_1.time_ <= 0 + arg_506_0 then
				local var_506_0 = arg_503_1.var_.effectzhuanhuanchangjing1

				if not arg_503_1.var_.effectzhuanhuanchangjing1 then
					var_506_0 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zflash"), manager.ui.mainCamera.transform)
					var_506_0.name = "zhuanhuanchangjing1"
					arg_503_1.var_.effectzhuanhuanchangjing1 = var_506_0
				else
					var_506_0.transform:SetParent(var_506_9000)
				end

				var_506_0.transform.localPosition = Vector3.New(0, 0, 0)
				var_506_0.transform.localRotation = Quaternion.Euler(0, 0, 0)
				var_506_0.transform.localScale = Vector3.New(var_506_0.transform.localScale.x * (Screen.width / Screen.height / 1.7777777777777777), var_506_0.transform.localScale.y * Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1), var_506_0.transform.localScale.z)
			end

			if 1 < arg_503_1.time_ and arg_503_1.time_ <= 1 + arg_506_0 then
				arg_503_1:AudioAction("play", "music", "bgm_side_daily03", "bgm_side_daily03", "bgm_side_daily03.awb")

				local var_506_4 = manager.audio:GetAudioName("bgm_side_daily03", "bgm_side_daily03")

				if "" ~= "" then
					if arg_503_1.bgmTxt_.text ~= var_506_4 and arg_503_1.bgmTxt_.text ~= "" then
						if arg_503_1.bgmTxt2_.text ~= "" then
							arg_503_1.bgmTxt_.text = arg_503_1.bgmTxt2_.text
						end

						arg_503_1.bgmTxt2_.text = var_506_4

						arg_503_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_503_1.bgmTxt_.text = var_506_4
						arg_503_1.bgmTxt2_.text = var_506_4
					end

					if arg_503_1.bgmTimer then
						arg_503_1.bgmTimer:Stop()

						arg_503_1.bgmTimer = nil
					end

					if arg_503_1.settingData.show_music_name == 1 then
						arg_503_1.musicController:SetSelectedState("show")
						arg_503_1.musicAnimator_:Play("open", 0, 0)

						if arg_503_1.settingData.music_time ~= 0 then
							arg_503_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_503_1.settingData.music_time), function()
								if arg_503_1 == nil or isNil(arg_503_1.bgmTxt_) then
									return
								end

								arg_503_1.musicController:SetSelectedState("hide")
								arg_503_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 1.2 < arg_503_1.time_ and arg_503_1.time_ <= 1.2 + arg_506_0 then
				arg_503_1:AudioAction("play", "effect", "se_story_140", "se_story_140_amb_chinese restaurant", "")
			end

			if 0.2 < arg_503_1.time_ and arg_503_1.time_ <= 0.2 + arg_506_0 then
				arg_503_1:AudioAction("stop", "effect", "se_story_140", "se_story_140_amb_street02", "")
			end

			local var_506_7 = 0

			if 0 < arg_503_1.time_ and arg_503_1.time_ <= var_506_7 + arg_506_0 then
				arg_503_1.allBtn_.enabled = false
			end

			if arg_503_1.time_ >= var_506_7 + 2.5 and arg_503_1.time_ < var_506_7 + 2.5 + arg_506_0 then
				arg_503_1.allBtn_.enabled = true
			end

			local var_506_8 = "ST02"

			if arg_503_1.bgs_.ST02 == nil then
				local var_506_9 = Object.Instantiate(arg_503_1.paintGo_)

				var_506_9:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_506_8)
				var_506_9.name = var_506_8
				var_506_9.transform.parent = arg_503_1.stage_.transform
				var_506_9.transform.localPosition = Vector3.New(0, 100, 0)
				arg_503_1.bgs_[var_506_8] = var_506_9
			end

			if 1.33333333333333 < arg_503_1.time_ and arg_503_1.time_ <= 1.33333333333333 + arg_506_0 then
				local var_506_10 = arg_503_1.bgs_.ST02

				arg_503_1.bgs_.ST02.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_506_10.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_506_11 = var_506_10:GetComponent("SpriteRenderer")

				if var_506_11 and var_506_11.sprite then
					local var_506_12 = 2 * (var_506_10.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_506_10.transform.localScale = Vector3.New(var_506_12 / var_506_11.sprite.bounds.size.y < var_506_12 * manager.ui.mainCameraCom_.aspect / var_506_11.sprite.bounds.size.x and var_506_12 * manager.ui.mainCameraCom_.aspect / var_506_11.sprite.bounds.size.x or var_506_12 / var_506_11.sprite.bounds.size.y, var_506_12 / var_506_11.sprite.bounds.size.y < var_506_12 * manager.ui.mainCameraCom_.aspect / var_506_11.sprite.bounds.size.x and var_506_12 * manager.ui.mainCameraCom_.aspect / var_506_11.sprite.bounds.size.x or var_506_12 / var_506_11.sprite.bounds.size.y, 0)
				end

				for iter_506_0, iter_506_1 in pairs(arg_503_1.bgs_) do
					if iter_506_0 ~= "ST02" then
						iter_506_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if arg_503_1.frameCnt_ <= 1 then
				arg_503_1.dialog_:SetActive(false)
			end

			local var_506_13 = 3.33333333333333
			local var_506_14 = 1.4

			if 3.33333333333333 < arg_503_1.time_ and arg_503_1.time_ <= var_506_13 + arg_506_0 then
				arg_503_1.talkMaxDuration = 0

				arg_503_1.dialog_:SetActive(true)

				arg_503_1.dialogCg_.alpha = 0

				local var_506_15 = LeanTween.value(arg_503_1.dialog_, 0, 1, 0.3)

				var_506_15:setOnUpdate(LuaHelper.FloatAction(function(arg_508_0)
					arg_503_1.dialogCg_.alpha = arg_508_0
				end))
				var_506_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_503_1.dialog_)
					var_506_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_503_1.duration_ = arg_503_1.duration_ + 0.3

				SetActive(arg_503_1.leftNameGo_, false)

				arg_503_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_503_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_503_1:RecordName(arg_503_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_503_1.iconTrs_.gameObject, false)
				arg_503_1.callingController_:SetSelectedState("normal")

				local var_506_16 = arg_503_1:FormatText(arg_503_1:GetWordFromCfg(1108409123).content)

				arg_503_1.text_.text = var_506_16

				LuaForUtil.ClearLinePrefixSymbol(arg_503_1.text_)

				local var_506_18 = 56 <= 0 and var_506_14 or var_506_14 * (utf8.len(var_506_16) / 56)

				if (56 <= 0 and var_506_14 or var_506_14 * (utf8.len(var_506_16) / 56)) > 0 and var_506_14 < var_506_18 then
					arg_503_1.talkMaxDuration = var_506_18
					var_506_13 = var_506_13 + 0.3

					if var_506_18 + var_506_13 > arg_503_1.duration_ then
						arg_503_1.duration_ = var_506_18 + var_506_13
					end
				end

				arg_503_1.text_.text = var_506_16
				arg_503_1.typewritter.percent = 0

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(false)
				arg_503_1:RecordContent(arg_503_1.text_.text)
			end

			local var_506_19 = var_506_13 + 0.3
			local var_506_20 = math.max(var_506_14, arg_503_1.talkMaxDuration)

			if var_506_13 + 0.3 <= arg_503_1.time_ and arg_503_1.time_ < var_506_19 + var_506_20 then
				arg_503_1.typewritter.percent = (arg_503_1.time_ - var_506_19) / var_506_20

				arg_503_1.typewritter:SetDirty()
			end

			if arg_503_1.time_ >= var_506_19 + var_506_20 and arg_503_1.time_ < var_506_19 + var_506_20 + arg_506_0 then
				arg_503_1.typewritter.percent = 1

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(true)
			end
		end

		arg_503_1.nodeConfigList_ = {}

		arg_503_1:InitPlayNodeList()
	end,
	Play1108409124 = function(arg_510_0, arg_510_1)
		arg_510_1.time_ = 0
		arg_510_1.frameCnt_ = 0
		arg_510_1.state_ = "playing"
		arg_510_1.curTalkId_ = 1108409124
		arg_510_1.duration_ = 5

		SetActive(arg_510_1.tipsGo_, false)

		function arg_510_1.onSingleLineFinish_()
			arg_510_1.onSingleLineUpdate_ = nil
			arg_510_1.onSingleLineFinish_ = nil
			arg_510_1.state_ = "waiting"
		end

		function arg_510_1.playNext_(arg_512_0)
			if arg_512_0 == 1 then
				arg_510_0:Play1108409125(arg_510_1)
			end
		end

		function arg_510_1.onSingleLineUpdate_(arg_513_0)
			local var_513_0 = 0.625

			if 0 < arg_510_1.time_ and arg_510_1.time_ <= 0 + arg_513_0 then
				arg_510_1.talkMaxDuration = 0
				arg_510_1.dialogCg_.alpha = 1

				arg_510_1.dialog_:SetActive(true)
				SetActive(arg_510_1.leftNameGo_, true)

				arg_510_1.leftNameTxt_.text = arg_510_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_510_1.leftNameTxt_.transform)

				arg_510_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_510_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_510_1:RecordName(arg_510_1.leftNameTxt_.text)
				SetActive(arg_510_1.iconTrs_.gameObject, true)
				arg_510_1.iconController_:SetSelectedState("hero")

				arg_510_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_510_1.callingController_:SetSelectedState("normal")

				arg_510_1.keyicon_.color = Color.New(1, 1, 1)
				arg_510_1.icon_.color = Color.New(1, 1, 1)

				local var_513_1 = arg_510_1:FormatText(arg_510_1:GetWordFromCfg(1108409124).content)

				arg_510_1.text_.text = var_513_1

				LuaForUtil.ClearLinePrefixSymbol(arg_510_1.text_)

				local var_513_3 = 25 <= 0 and var_513_0 or var_513_0 * (utf8.len(var_513_1) / 25)

				if (25 <= 0 and var_513_0 or var_513_0 * (utf8.len(var_513_1) / 25)) > 0 and var_513_0 < var_513_3 then
					arg_510_1.talkMaxDuration = var_513_3

					if var_513_3 + 0 > arg_510_1.duration_ then
						arg_510_1.duration_ = var_513_3 + 0
					end
				end

				arg_510_1.text_.text = var_513_1
				arg_510_1.typewritter.percent = 0

				arg_510_1.typewritter:SetDirty()
				arg_510_1:ShowNextGo(false)
				arg_510_1:RecordContent(arg_510_1.text_.text)
			end

			local var_513_4 = math.max(var_513_0, arg_510_1.talkMaxDuration)

			if 0 <= arg_510_1.time_ and arg_510_1.time_ < 0 + var_513_4 then
				arg_510_1.typewritter.percent = (arg_510_1.time_ - 0) / var_513_4

				arg_510_1.typewritter:SetDirty()
			end

			if arg_510_1.time_ >= 0 + var_513_4 and arg_510_1.time_ < 0 + var_513_4 + arg_513_0 then
				arg_510_1.typewritter.percent = 1

				arg_510_1.typewritter:SetDirty()
				arg_510_1:ShowNextGo(true)
			end
		end

		arg_510_1.nodeConfigList_ = {}

		arg_510_1:InitPlayNodeList()
	end,
	Play1108409125 = function(arg_514_0, arg_514_1)
		arg_514_1.time_ = 0
		arg_514_1.frameCnt_ = 0
		arg_514_1.state_ = "playing"
		arg_514_1.curTalkId_ = 1108409125
		arg_514_1.duration_ = 4.63

		SetActive(arg_514_1.tipsGo_, false)

		function arg_514_1.onSingleLineFinish_()
			arg_514_1.onSingleLineUpdate_ = nil
			arg_514_1.onSingleLineFinish_ = nil
			arg_514_1.state_ = "waiting"
		end

		function arg_514_1.playNext_(arg_516_0)
			if arg_516_0 == 1 then
				arg_514_0:Play1108409126(arg_514_1)
			end
		end

		function arg_514_1.onSingleLineUpdate_(arg_517_0)
			if 0 < arg_514_1.time_ and arg_514_1.time_ <= 0 + arg_517_0 then
				arg_514_1.var_.moveOldPos1084ui_story = arg_514_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_517_0 = 0.001

			if 0 <= arg_514_1.time_ and arg_514_1.time_ < 0 + var_517_0 then
				arg_514_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_514_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_514_1.time_ - 0) / var_517_0)
				arg_514_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_514_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_514_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_514_1.actors_["1084ui_story"].transform.position).z)
				arg_514_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_514_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_514_1.actors_["1084ui_story"].transform.localEulerAngles = arg_514_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_514_1.time_ >= 0 + var_517_0 and arg_514_1.time_ < 0 + var_517_0 + arg_517_0 then
				arg_514_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_514_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_514_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_514_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_514_1.actors_["1084ui_story"].transform.position).z)
				arg_514_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_514_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_514_1.actors_["1084ui_story"].transform.localEulerAngles = arg_514_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_517_1 = arg_514_1.actors_["1084ui_story"]

			if 0 < arg_514_1.time_ and arg_514_1.time_ <= 0 + arg_517_0 and not isNil(var_517_1) and arg_514_1.var_.characterEffect1084ui_story == nil then
				arg_514_1.var_.characterEffect1084ui_story = var_517_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_517_2 = 0.200000002980232

			if 0 <= arg_514_1.time_ and arg_514_1.time_ < 0 + var_517_2 and not isNil(var_517_1) then
				if arg_514_1.var_.characterEffect1084ui_story and not isNil(var_517_1) then
					arg_514_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_514_1.time_ >= 0 + var_517_2 and arg_514_1.time_ < 0 + var_517_2 + arg_517_0 and not isNil(var_517_1) and arg_514_1.var_.characterEffect1084ui_story then
				arg_514_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_514_1.time_ and arg_514_1.time_ <= 0 + arg_517_0 then
				arg_514_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action8_1")
			end

			if 0 < arg_514_1.time_ and arg_514_1.time_ <= 0 + arg_517_0 then
				arg_514_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_517_4 = 0
			local var_517_5 = 0.625

			if 0 < arg_514_1.time_ and arg_514_1.time_ <= var_517_4 + arg_517_0 then
				arg_514_1.talkMaxDuration = 0
				arg_514_1.dialogCg_.alpha = 1

				arg_514_1.dialog_:SetActive(true)
				SetActive(arg_514_1.leftNameGo_, true)

				arg_514_1.leftNameTxt_.text = arg_514_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_514_1.leftNameTxt_.transform)

				arg_514_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_514_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_514_1:RecordName(arg_514_1.leftNameTxt_.text)
				SetActive(arg_514_1.iconTrs_.gameObject, false)
				arg_514_1.callingController_:SetSelectedState("normal")

				local var_517_6 = arg_514_1:GetWordFromCfg(1108409125)
				local var_517_7 = arg_514_1:FormatText(var_517_6.content)

				arg_514_1.text_.text = var_517_7

				LuaForUtil.ClearLinePrefixSymbol(arg_514_1.text_)

				local var_517_9 = 25 <= 0 and var_517_5 or var_517_5 * (utf8.len(var_517_7) / 25)

				if (25 <= 0 and var_517_5 or var_517_5 * (utf8.len(var_517_7) / 25)) > 0 and var_517_5 < var_517_9 then
					arg_514_1.talkMaxDuration = var_517_9

					if var_517_9 + var_517_4 > arg_514_1.duration_ then
						arg_514_1.duration_ = var_517_9 + var_517_4
					end
				end

				arg_514_1.text_.text = var_517_7
				arg_514_1.typewritter.percent = 0

				arg_514_1.typewritter:SetDirty()
				arg_514_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409125", "story_v_side_new_1108409.awb") ~= 0 then
					local var_517_10 = manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409125", "story_v_side_new_1108409.awb") / 1000

					if var_517_10 + var_517_4 > arg_514_1.duration_ then
						arg_514_1.duration_ = var_517_10 + var_517_4
					end

					if var_517_6.prefab_name ~= "" and arg_514_1.actors_[var_517_6.prefab_name] ~= nil then
						local var_517_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_514_1.actors_[var_517_6.prefab_name].transform, "story_v_side_new_1108409", "1108409125", "story_v_side_new_1108409.awb")

						arg_514_1:RecordAudio("1108409125", var_517_11)
						arg_514_1:RecordAudio("1108409125", var_517_11)
					else
						arg_514_1:AudioAction("play", "voice", "story_v_side_new_1108409", "1108409125", "story_v_side_new_1108409.awb")
					end

					arg_514_1:RecordHistoryTalkVoice("story_v_side_new_1108409", "1108409125", "story_v_side_new_1108409.awb")
				end

				arg_514_1:RecordContent(arg_514_1.text_.text)
			end

			local var_517_12 = math.max(var_517_5, arg_514_1.talkMaxDuration)

			if var_517_4 <= arg_514_1.time_ and arg_514_1.time_ < var_517_4 + var_517_12 then
				arg_514_1.typewritter.percent = (arg_514_1.time_ - var_517_4) / var_517_12

				arg_514_1.typewritter:SetDirty()
			end

			if arg_514_1.time_ >= var_517_4 + var_517_12 and arg_514_1.time_ < var_517_4 + var_517_12 + arg_517_0 then
				arg_514_1.typewritter.percent = 1

				arg_514_1.typewritter:SetDirty()
				arg_514_1:ShowNextGo(true)
			end
		end

		arg_514_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_514_1:InitPlayNodeList()
	end,
	Play1108409126 = function(arg_518_0, arg_518_1)
		arg_518_1.time_ = 0
		arg_518_1.frameCnt_ = 0
		arg_518_1.state_ = "playing"
		arg_518_1.curTalkId_ = 1108409126
		arg_518_1.duration_ = 4.93

		SetActive(arg_518_1.tipsGo_, false)

		function arg_518_1.onSingleLineFinish_()
			arg_518_1.onSingleLineUpdate_ = nil
			arg_518_1.onSingleLineFinish_ = nil
			arg_518_1.state_ = "waiting"
		end

		function arg_518_1.playNext_(arg_520_0)
			if arg_520_0 == 1 then
				arg_518_0:Play1108409127(arg_518_1)
			end
		end

		function arg_518_1.onSingleLineUpdate_(arg_521_0)
			if 0 < arg_518_1.time_ and arg_518_1.time_ <= 0 + arg_521_0 and not isNil(arg_518_1.actors_["1084ui_story"]) and arg_518_1.var_.characterEffect1084ui_story == nil then
				arg_518_1.var_.characterEffect1084ui_story = arg_518_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_521_0 = 0.200000002980232

			if 0 <= arg_518_1.time_ and arg_518_1.time_ < 0 + var_521_0 and not isNil(arg_518_1.actors_["1084ui_story"]) then
				if arg_518_1.var_.characterEffect1084ui_story and not isNil(arg_518_1.actors_["1084ui_story"]) then
					arg_518_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_518_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_518_1.time_ - 0) / var_521_0)
				end
			end

			if arg_518_1.time_ >= 0 + var_521_0 and arg_518_1.time_ < 0 + var_521_0 + arg_521_0 and not isNil(arg_518_1.actors_["1084ui_story"]) and arg_518_1.var_.characterEffect1084ui_story then
				arg_518_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_518_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_521_1 = 0
			local var_521_2 = 0.625

			if 0 < arg_518_1.time_ and arg_518_1.time_ <= var_521_1 + arg_521_0 then
				arg_518_1.talkMaxDuration = 0
				arg_518_1.dialogCg_.alpha = 1

				arg_518_1.dialog_:SetActive(true)
				SetActive(arg_518_1.leftNameGo_, true)

				arg_518_1.leftNameTxt_.text = arg_518_1:FormatText(StoryNameCfg[426].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_518_1.leftNameTxt_.transform)

				arg_518_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_518_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_518_1:RecordName(arg_518_1.leftNameTxt_.text)
				SetActive(arg_518_1.iconTrs_.gameObject, true)
				arg_518_1.iconController_:SetSelectedState("hero")

				arg_518_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwc")

				arg_518_1.callingController_:SetSelectedState("normal")

				arg_518_1.keyicon_.color = Color.New(1, 1, 1)
				arg_518_1.icon_.color = Color.New(1, 1, 1)

				local var_521_3 = arg_518_1:GetWordFromCfg(1108409126)
				local var_521_4 = arg_518_1:FormatText(var_521_3.content)

				arg_518_1.text_.text = var_521_4

				LuaForUtil.ClearLinePrefixSymbol(arg_518_1.text_)

				local var_521_6 = 25 <= 0 and var_521_2 or var_521_2 * (utf8.len(var_521_4) / 25)

				if (25 <= 0 and var_521_2 or var_521_2 * (utf8.len(var_521_4) / 25)) > 0 and var_521_2 < var_521_6 then
					arg_518_1.talkMaxDuration = var_521_6

					if var_521_6 + var_521_1 > arg_518_1.duration_ then
						arg_518_1.duration_ = var_521_6 + var_521_1
					end
				end

				arg_518_1.text_.text = var_521_4
				arg_518_1.typewritter.percent = 0

				arg_518_1.typewritter:SetDirty()
				arg_518_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409126", "story_v_side_new_1108409.awb") ~= 0 then
					local var_521_7 = manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409126", "story_v_side_new_1108409.awb") / 1000

					if var_521_7 + var_521_1 > arg_518_1.duration_ then
						arg_518_1.duration_ = var_521_7 + var_521_1
					end

					if var_521_3.prefab_name ~= "" and arg_518_1.actors_[var_521_3.prefab_name] ~= nil then
						local var_521_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_518_1.actors_[var_521_3.prefab_name].transform, "story_v_side_new_1108409", "1108409126", "story_v_side_new_1108409.awb")

						arg_518_1:RecordAudio("1108409126", var_521_8)
						arg_518_1:RecordAudio("1108409126", var_521_8)
					else
						arg_518_1:AudioAction("play", "voice", "story_v_side_new_1108409", "1108409126", "story_v_side_new_1108409.awb")
					end

					arg_518_1:RecordHistoryTalkVoice("story_v_side_new_1108409", "1108409126", "story_v_side_new_1108409.awb")
				end

				arg_518_1:RecordContent(arg_518_1.text_.text)
			end

			local var_521_9 = math.max(var_521_2, arg_518_1.talkMaxDuration)

			if var_521_1 <= arg_518_1.time_ and arg_518_1.time_ < var_521_1 + var_521_9 then
				arg_518_1.typewritter.percent = (arg_518_1.time_ - var_521_1) / var_521_9

				arg_518_1.typewritter:SetDirty()
			end

			if arg_518_1.time_ >= var_521_1 + var_521_9 and arg_518_1.time_ < var_521_1 + var_521_9 + arg_521_0 then
				arg_518_1.typewritter.percent = 1

				arg_518_1.typewritter:SetDirty()
				arg_518_1:ShowNextGo(true)
			end
		end

		arg_518_1.nodeConfigList_ = {}

		arg_518_1:InitPlayNodeList()
	end,
	Play1108409127 = function(arg_522_0, arg_522_1)
		arg_522_1.time_ = 0
		arg_522_1.frameCnt_ = 0
		arg_522_1.state_ = "playing"
		arg_522_1.curTalkId_ = 1108409127
		arg_522_1.duration_ = 2.47

		SetActive(arg_522_1.tipsGo_, false)

		function arg_522_1.onSingleLineFinish_()
			arg_522_1.onSingleLineUpdate_ = nil
			arg_522_1.onSingleLineFinish_ = nil
			arg_522_1.state_ = "waiting"
		end

		function arg_522_1.playNext_(arg_524_0)
			if arg_524_0 == 1 then
				arg_522_0:Play1108409128(arg_522_1)
			end
		end

		function arg_522_1.onSingleLineUpdate_(arg_525_0)
			if 0 < arg_522_1.time_ and arg_522_1.time_ <= 0 + arg_525_0 and not isNil(arg_522_1.actors_["1084ui_story"]) and arg_522_1.var_.characterEffect1084ui_story == nil then
				arg_522_1.var_.characterEffect1084ui_story = arg_522_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_525_0 = 0.200000002980232

			if 0 <= arg_522_1.time_ and arg_522_1.time_ < 0 + var_525_0 and not isNil(arg_522_1.actors_["1084ui_story"]) then
				if arg_522_1.var_.characterEffect1084ui_story and not isNil(arg_522_1.actors_["1084ui_story"]) then
					arg_522_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_522_1.time_ >= 0 + var_525_0 and arg_522_1.time_ < 0 + var_525_0 + arg_525_0 and not isNil(arg_522_1.actors_["1084ui_story"]) and arg_522_1.var_.characterEffect1084ui_story then
				arg_522_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_522_1.time_ and arg_522_1.time_ <= 0 + arg_525_0 then
				arg_522_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action8_2")
			end

			if 0 < arg_522_1.time_ and arg_522_1.time_ <= 0 + arg_525_0 then
				arg_522_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_525_2 = 0
			local var_525_3 = 0.25

			if 0 < arg_522_1.time_ and arg_522_1.time_ <= var_525_2 + arg_525_0 then
				arg_522_1.talkMaxDuration = 0
				arg_522_1.dialogCg_.alpha = 1

				arg_522_1.dialog_:SetActive(true)
				SetActive(arg_522_1.leftNameGo_, true)

				arg_522_1.leftNameTxt_.text = arg_522_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_522_1.leftNameTxt_.transform)

				arg_522_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_522_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_522_1:RecordName(arg_522_1.leftNameTxt_.text)
				SetActive(arg_522_1.iconTrs_.gameObject, false)
				arg_522_1.callingController_:SetSelectedState("normal")

				local var_525_4 = arg_522_1:GetWordFromCfg(1108409127)
				local var_525_5 = arg_522_1:FormatText(var_525_4.content)

				arg_522_1.text_.text = var_525_5

				LuaForUtil.ClearLinePrefixSymbol(arg_522_1.text_)

				local var_525_7 = 10 <= 0 and var_525_3 or var_525_3 * (utf8.len(var_525_5) / 10)

				if (10 <= 0 and var_525_3 or var_525_3 * (utf8.len(var_525_5) / 10)) > 0 and var_525_3 < var_525_7 then
					arg_522_1.talkMaxDuration = var_525_7

					if var_525_7 + var_525_2 > arg_522_1.duration_ then
						arg_522_1.duration_ = var_525_7 + var_525_2
					end
				end

				arg_522_1.text_.text = var_525_5
				arg_522_1.typewritter.percent = 0

				arg_522_1.typewritter:SetDirty()
				arg_522_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409127", "story_v_side_new_1108409.awb") ~= 0 then
					local var_525_8 = manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409127", "story_v_side_new_1108409.awb") / 1000

					if var_525_8 + var_525_2 > arg_522_1.duration_ then
						arg_522_1.duration_ = var_525_8 + var_525_2
					end

					if var_525_4.prefab_name ~= "" and arg_522_1.actors_[var_525_4.prefab_name] ~= nil then
						local var_525_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_522_1.actors_[var_525_4.prefab_name].transform, "story_v_side_new_1108409", "1108409127", "story_v_side_new_1108409.awb")

						arg_522_1:RecordAudio("1108409127", var_525_9)
						arg_522_1:RecordAudio("1108409127", var_525_9)
					else
						arg_522_1:AudioAction("play", "voice", "story_v_side_new_1108409", "1108409127", "story_v_side_new_1108409.awb")
					end

					arg_522_1:RecordHistoryTalkVoice("story_v_side_new_1108409", "1108409127", "story_v_side_new_1108409.awb")
				end

				arg_522_1:RecordContent(arg_522_1.text_.text)
			end

			local var_525_10 = math.max(var_525_3, arg_522_1.talkMaxDuration)

			if var_525_2 <= arg_522_1.time_ and arg_522_1.time_ < var_525_2 + var_525_10 then
				arg_522_1.typewritter.percent = (arg_522_1.time_ - var_525_2) / var_525_10

				arg_522_1.typewritter:SetDirty()
			end

			if arg_522_1.time_ >= var_525_2 + var_525_10 and arg_522_1.time_ < var_525_2 + var_525_10 + arg_525_0 then
				arg_522_1.typewritter.percent = 1

				arg_522_1.typewritter:SetDirty()
				arg_522_1:ShowNextGo(true)
			end
		end

		arg_522_1.nodeConfigList_ = {}

		arg_522_1:InitPlayNodeList()
	end,
	Play1108409128 = function(arg_526_0, arg_526_1)
		arg_526_1.time_ = 0
		arg_526_1.frameCnt_ = 0
		arg_526_1.state_ = "playing"
		arg_526_1.curTalkId_ = 1108409128
		arg_526_1.duration_ = 8.83

		SetActive(arg_526_1.tipsGo_, false)

		function arg_526_1.onSingleLineFinish_()
			arg_526_1.onSingleLineUpdate_ = nil
			arg_526_1.onSingleLineFinish_ = nil
			arg_526_1.state_ = "waiting"
		end

		function arg_526_1.playNext_(arg_528_0)
			if arg_528_0 == 1 then
				arg_526_0:Play1108409129(arg_526_1)
			end
		end

		function arg_526_1.onSingleLineUpdate_(arg_529_0)
			if 0 < arg_526_1.time_ and arg_526_1.time_ <= 0 + arg_529_0 and not isNil(arg_526_1.actors_["1084ui_story"]) and arg_526_1.var_.characterEffect1084ui_story == nil then
				arg_526_1.var_.characterEffect1084ui_story = arg_526_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_529_0 = 0.200000002980232

			if 0 <= arg_526_1.time_ and arg_526_1.time_ < 0 + var_529_0 and not isNil(arg_526_1.actors_["1084ui_story"]) then
				if arg_526_1.var_.characterEffect1084ui_story and not isNil(arg_526_1.actors_["1084ui_story"]) then
					arg_526_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_526_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_526_1.time_ - 0) / var_529_0)
				end
			end

			if arg_526_1.time_ >= 0 + var_529_0 and arg_526_1.time_ < 0 + var_529_0 + arg_529_0 and not isNil(arg_526_1.actors_["1084ui_story"]) and arg_526_1.var_.characterEffect1084ui_story then
				arg_526_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_526_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_529_1 = 0
			local var_529_2 = 1.225

			if 0 < arg_526_1.time_ and arg_526_1.time_ <= var_529_1 + arg_529_0 then
				arg_526_1.talkMaxDuration = 0
				arg_526_1.dialogCg_.alpha = 1

				arg_526_1.dialog_:SetActive(true)
				SetActive(arg_526_1.leftNameGo_, true)

				arg_526_1.leftNameTxt_.text = arg_526_1:FormatText(StoryNameCfg[426].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_526_1.leftNameTxt_.transform)

				arg_526_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_526_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_526_1:RecordName(arg_526_1.leftNameTxt_.text)
				SetActive(arg_526_1.iconTrs_.gameObject, true)
				arg_526_1.iconController_:SetSelectedState("hero")

				arg_526_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwc")

				arg_526_1.callingController_:SetSelectedState("normal")

				arg_526_1.keyicon_.color = Color.New(1, 1, 1)
				arg_526_1.icon_.color = Color.New(1, 1, 1)

				local var_529_3 = arg_526_1:GetWordFromCfg(1108409128)
				local var_529_4 = arg_526_1:FormatText(var_529_3.content)

				arg_526_1.text_.text = var_529_4

				LuaForUtil.ClearLinePrefixSymbol(arg_526_1.text_)

				local var_529_6 = 49 <= 0 and var_529_2 or var_529_2 * (utf8.len(var_529_4) / 49)

				if (49 <= 0 and var_529_2 or var_529_2 * (utf8.len(var_529_4) / 49)) > 0 and var_529_2 < var_529_6 then
					arg_526_1.talkMaxDuration = var_529_6

					if var_529_6 + var_529_1 > arg_526_1.duration_ then
						arg_526_1.duration_ = var_529_6 + var_529_1
					end
				end

				arg_526_1.text_.text = var_529_4
				arg_526_1.typewritter.percent = 0

				arg_526_1.typewritter:SetDirty()
				arg_526_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409128", "story_v_side_new_1108409.awb") ~= 0 then
					local var_529_7 = manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409128", "story_v_side_new_1108409.awb") / 1000

					if var_529_7 + var_529_1 > arg_526_1.duration_ then
						arg_526_1.duration_ = var_529_7 + var_529_1
					end

					if var_529_3.prefab_name ~= "" and arg_526_1.actors_[var_529_3.prefab_name] ~= nil then
						local var_529_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_526_1.actors_[var_529_3.prefab_name].transform, "story_v_side_new_1108409", "1108409128", "story_v_side_new_1108409.awb")

						arg_526_1:RecordAudio("1108409128", var_529_8)
						arg_526_1:RecordAudio("1108409128", var_529_8)
					else
						arg_526_1:AudioAction("play", "voice", "story_v_side_new_1108409", "1108409128", "story_v_side_new_1108409.awb")
					end

					arg_526_1:RecordHistoryTalkVoice("story_v_side_new_1108409", "1108409128", "story_v_side_new_1108409.awb")
				end

				arg_526_1:RecordContent(arg_526_1.text_.text)
			end

			local var_529_9 = math.max(var_529_2, arg_526_1.talkMaxDuration)

			if var_529_1 <= arg_526_1.time_ and arg_526_1.time_ < var_529_1 + var_529_9 then
				arg_526_1.typewritter.percent = (arg_526_1.time_ - var_529_1) / var_529_9

				arg_526_1.typewritter:SetDirty()
			end

			if arg_526_1.time_ >= var_529_1 + var_529_9 and arg_526_1.time_ < var_529_1 + var_529_9 + arg_529_0 then
				arg_526_1.typewritter.percent = 1

				arg_526_1.typewritter:SetDirty()
				arg_526_1:ShowNextGo(true)
			end
		end

		arg_526_1.nodeConfigList_ = {}

		arg_526_1:InitPlayNodeList()
	end,
	Play1108409129 = function(arg_530_0, arg_530_1)
		arg_530_1.time_ = 0
		arg_530_1.frameCnt_ = 0
		arg_530_1.state_ = "playing"
		arg_530_1.curTalkId_ = 1108409129
		arg_530_1.duration_ = 5

		SetActive(arg_530_1.tipsGo_, false)

		function arg_530_1.onSingleLineFinish_()
			arg_530_1.onSingleLineUpdate_ = nil
			arg_530_1.onSingleLineFinish_ = nil
			arg_530_1.state_ = "waiting"
		end

		function arg_530_1.playNext_(arg_532_0)
			if arg_532_0 == 1 then
				arg_530_0:Play1108409130(arg_530_1)
			end
		end

		function arg_530_1.onSingleLineUpdate_(arg_533_0)
			local var_533_0 = 0.125

			if 0 < arg_530_1.time_ and arg_530_1.time_ <= 0 + arg_533_0 then
				arg_530_1.talkMaxDuration = 0
				arg_530_1.dialogCg_.alpha = 1

				arg_530_1.dialog_:SetActive(true)
				SetActive(arg_530_1.leftNameGo_, true)

				arg_530_1.leftNameTxt_.text = arg_530_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_530_1.leftNameTxt_.transform)

				arg_530_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_530_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_530_1:RecordName(arg_530_1.leftNameTxt_.text)
				SetActive(arg_530_1.iconTrs_.gameObject, true)
				arg_530_1.iconController_:SetSelectedState("hero")

				arg_530_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_530_1.callingController_:SetSelectedState("normal")

				arg_530_1.keyicon_.color = Color.New(1, 1, 1)
				arg_530_1.icon_.color = Color.New(1, 1, 1)

				local var_533_1 = arg_530_1:FormatText(arg_530_1:GetWordFromCfg(1108409129).content)

				arg_530_1.text_.text = var_533_1

				LuaForUtil.ClearLinePrefixSymbol(arg_530_1.text_)

				local var_533_3 = 5 <= 0 and var_533_0 or var_533_0 * (utf8.len(var_533_1) / 5)

				if (5 <= 0 and var_533_0 or var_533_0 * (utf8.len(var_533_1) / 5)) > 0 and var_533_0 < var_533_3 then
					arg_530_1.talkMaxDuration = var_533_3

					if var_533_3 + 0 > arg_530_1.duration_ then
						arg_530_1.duration_ = var_533_3 + 0
					end
				end

				arg_530_1.text_.text = var_533_1
				arg_530_1.typewritter.percent = 0

				arg_530_1.typewritter:SetDirty()
				arg_530_1:ShowNextGo(false)
				arg_530_1:RecordContent(arg_530_1.text_.text)
			end

			local var_533_4 = math.max(var_533_0, arg_530_1.talkMaxDuration)

			if 0 <= arg_530_1.time_ and arg_530_1.time_ < 0 + var_533_4 then
				arg_530_1.typewritter.percent = (arg_530_1.time_ - 0) / var_533_4

				arg_530_1.typewritter:SetDirty()
			end

			if arg_530_1.time_ >= 0 + var_533_4 and arg_530_1.time_ < 0 + var_533_4 + arg_533_0 then
				arg_530_1.typewritter.percent = 1

				arg_530_1.typewritter:SetDirty()
				arg_530_1:ShowNextGo(true)
			end
		end

		arg_530_1.nodeConfigList_ = {}

		arg_530_1:InitPlayNodeList()
	end,
	Play1108409130 = function(arg_534_0, arg_534_1)
		arg_534_1.time_ = 0
		arg_534_1.frameCnt_ = 0
		arg_534_1.state_ = "playing"
		arg_534_1.curTalkId_ = 1108409130
		arg_534_1.duration_ = 12.6

		SetActive(arg_534_1.tipsGo_, false)

		function arg_534_1.onSingleLineFinish_()
			arg_534_1.onSingleLineUpdate_ = nil
			arg_534_1.onSingleLineFinish_ = nil
			arg_534_1.state_ = "waiting"
		end

		function arg_534_1.playNext_(arg_536_0)
			if arg_536_0 == 1 then
				arg_534_0:Play1108409131(arg_534_1)
			end
		end

		function arg_534_1.onSingleLineUpdate_(arg_537_0)
			local var_537_0 = 1.525

			if 0 < arg_534_1.time_ and arg_534_1.time_ <= 0 + arg_537_0 then
				arg_534_1.talkMaxDuration = 0
				arg_534_1.dialogCg_.alpha = 1

				arg_534_1.dialog_:SetActive(true)
				SetActive(arg_534_1.leftNameGo_, true)

				arg_534_1.leftNameTxt_.text = arg_534_1:FormatText(StoryNameCfg[426].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_534_1.leftNameTxt_.transform)

				arg_534_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_534_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_534_1:RecordName(arg_534_1.leftNameTxt_.text)
				SetActive(arg_534_1.iconTrs_.gameObject, true)
				arg_534_1.iconController_:SetSelectedState("hero")

				arg_534_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwc")

				arg_534_1.callingController_:SetSelectedState("normal")

				arg_534_1.keyicon_.color = Color.New(1, 1, 1)
				arg_534_1.icon_.color = Color.New(1, 1, 1)

				local var_537_1 = arg_534_1:GetWordFromCfg(1108409130)
				local var_537_2 = arg_534_1:FormatText(var_537_1.content)

				arg_534_1.text_.text = var_537_2

				LuaForUtil.ClearLinePrefixSymbol(arg_534_1.text_)

				local var_537_4 = 61 <= 0 and var_537_0 or var_537_0 * (utf8.len(var_537_2) / 61)

				if (61 <= 0 and var_537_0 or var_537_0 * (utf8.len(var_537_2) / 61)) > 0 and var_537_0 < var_537_4 then
					arg_534_1.talkMaxDuration = var_537_4

					if var_537_4 + 0 > arg_534_1.duration_ then
						arg_534_1.duration_ = var_537_4 + 0
					end
				end

				arg_534_1.text_.text = var_537_2
				arg_534_1.typewritter.percent = 0

				arg_534_1.typewritter:SetDirty()
				arg_534_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409130", "story_v_side_new_1108409.awb") ~= 0 then
					local var_537_5 = manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409130", "story_v_side_new_1108409.awb") / 1000

					if var_537_5 + 0 > arg_534_1.duration_ then
						arg_534_1.duration_ = var_537_5 + 0
					end

					if var_537_1.prefab_name ~= "" and arg_534_1.actors_[var_537_1.prefab_name] ~= nil then
						local var_537_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_534_1.actors_[var_537_1.prefab_name].transform, "story_v_side_new_1108409", "1108409130", "story_v_side_new_1108409.awb")

						arg_534_1:RecordAudio("1108409130", var_537_6)
						arg_534_1:RecordAudio("1108409130", var_537_6)
					else
						arg_534_1:AudioAction("play", "voice", "story_v_side_new_1108409", "1108409130", "story_v_side_new_1108409.awb")
					end

					arg_534_1:RecordHistoryTalkVoice("story_v_side_new_1108409", "1108409130", "story_v_side_new_1108409.awb")
				end

				arg_534_1:RecordContent(arg_534_1.text_.text)
			end

			local var_537_7 = math.max(var_537_0, arg_534_1.talkMaxDuration)

			if 0 <= arg_534_1.time_ and arg_534_1.time_ < 0 + var_537_7 then
				arg_534_1.typewritter.percent = (arg_534_1.time_ - 0) / var_537_7

				arg_534_1.typewritter:SetDirty()
			end

			if arg_534_1.time_ >= 0 + var_537_7 and arg_534_1.time_ < 0 + var_537_7 + arg_537_0 then
				arg_534_1.typewritter.percent = 1

				arg_534_1.typewritter:SetDirty()
				arg_534_1:ShowNextGo(true)
			end
		end

		arg_534_1.nodeConfigList_ = {}

		arg_534_1:InitPlayNodeList()
	end,
	Play1108409131 = function(arg_538_0, arg_538_1)
		arg_538_1.time_ = 0
		arg_538_1.frameCnt_ = 0
		arg_538_1.state_ = "playing"
		arg_538_1.curTalkId_ = 1108409131
		arg_538_1.duration_ = 5.87

		SetActive(arg_538_1.tipsGo_, false)

		function arg_538_1.onSingleLineFinish_()
			arg_538_1.onSingleLineUpdate_ = nil
			arg_538_1.onSingleLineFinish_ = nil
			arg_538_1.state_ = "waiting"
		end

		function arg_538_1.playNext_(arg_540_0)
			if arg_540_0 == 1 then
				arg_538_0:Play1108409132(arg_538_1)
			end
		end

		function arg_538_1.onSingleLineUpdate_(arg_541_0)
			if 0 < arg_538_1.time_ and arg_538_1.time_ <= 0 + arg_541_0 and not isNil(arg_538_1.actors_["1084ui_story"]) and arg_538_1.var_.characterEffect1084ui_story == nil then
				arg_538_1.var_.characterEffect1084ui_story = arg_538_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_541_0 = 0.200000002980232

			if 0 <= arg_538_1.time_ and arg_538_1.time_ < 0 + var_541_0 and not isNil(arg_538_1.actors_["1084ui_story"]) then
				if arg_538_1.var_.characterEffect1084ui_story and not isNil(arg_538_1.actors_["1084ui_story"]) then
					arg_538_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_538_1.time_ >= 0 + var_541_0 and arg_538_1.time_ < 0 + var_541_0 + arg_541_0 and not isNil(arg_538_1.actors_["1084ui_story"]) and arg_538_1.var_.characterEffect1084ui_story then
				arg_538_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_541_2 = 0
			local var_541_3 = 1

			if 0 < arg_538_1.time_ and arg_538_1.time_ <= var_541_2 + arg_541_0 then
				arg_538_1.talkMaxDuration = 0
				arg_538_1.dialogCg_.alpha = 1

				arg_538_1.dialog_:SetActive(true)
				SetActive(arg_538_1.leftNameGo_, true)

				arg_538_1.leftNameTxt_.text = arg_538_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_538_1.leftNameTxt_.transform)

				arg_538_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_538_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_538_1:RecordName(arg_538_1.leftNameTxt_.text)
				SetActive(arg_538_1.iconTrs_.gameObject, false)
				arg_538_1.callingController_:SetSelectedState("normal")

				local var_541_4 = arg_538_1:GetWordFromCfg(1108409131)
				local var_541_5 = arg_538_1:FormatText(var_541_4.content)

				arg_538_1.text_.text = var_541_5

				LuaForUtil.ClearLinePrefixSymbol(arg_538_1.text_)

				local var_541_7 = 40 <= 0 and var_541_3 or var_541_3 * (utf8.len(var_541_5) / 40)

				if (40 <= 0 and var_541_3 or var_541_3 * (utf8.len(var_541_5) / 40)) > 0 and var_541_3 < var_541_7 then
					arg_538_1.talkMaxDuration = var_541_7

					if var_541_7 + var_541_2 > arg_538_1.duration_ then
						arg_538_1.duration_ = var_541_7 + var_541_2
					end
				end

				arg_538_1.text_.text = var_541_5
				arg_538_1.typewritter.percent = 0

				arg_538_1.typewritter:SetDirty()
				arg_538_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409131", "story_v_side_new_1108409.awb") ~= 0 then
					local var_541_8 = manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409131", "story_v_side_new_1108409.awb") / 1000

					if var_541_8 + var_541_2 > arg_538_1.duration_ then
						arg_538_1.duration_ = var_541_8 + var_541_2
					end

					if var_541_4.prefab_name ~= "" and arg_538_1.actors_[var_541_4.prefab_name] ~= nil then
						local var_541_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_538_1.actors_[var_541_4.prefab_name].transform, "story_v_side_new_1108409", "1108409131", "story_v_side_new_1108409.awb")

						arg_538_1:RecordAudio("1108409131", var_541_9)
						arg_538_1:RecordAudio("1108409131", var_541_9)
					else
						arg_538_1:AudioAction("play", "voice", "story_v_side_new_1108409", "1108409131", "story_v_side_new_1108409.awb")
					end

					arg_538_1:RecordHistoryTalkVoice("story_v_side_new_1108409", "1108409131", "story_v_side_new_1108409.awb")
				end

				arg_538_1:RecordContent(arg_538_1.text_.text)
			end

			local var_541_10 = math.max(var_541_3, arg_538_1.talkMaxDuration)

			if var_541_2 <= arg_538_1.time_ and arg_538_1.time_ < var_541_2 + var_541_10 then
				arg_538_1.typewritter.percent = (arg_538_1.time_ - var_541_2) / var_541_10

				arg_538_1.typewritter:SetDirty()
			end

			if arg_538_1.time_ >= var_541_2 + var_541_10 and arg_538_1.time_ < var_541_2 + var_541_10 + arg_541_0 then
				arg_538_1.typewritter.percent = 1

				arg_538_1.typewritter:SetDirty()
				arg_538_1:ShowNextGo(true)
			end
		end

		arg_538_1.nodeConfigList_ = {}

		arg_538_1:InitPlayNodeList()
	end,
	Play1108409132 = function(arg_542_0, arg_542_1)
		arg_542_1.time_ = 0
		arg_542_1.frameCnt_ = 0
		arg_542_1.state_ = "playing"
		arg_542_1.curTalkId_ = 1108409132
		arg_542_1.duration_ = 5

		SetActive(arg_542_1.tipsGo_, false)

		function arg_542_1.onSingleLineFinish_()
			arg_542_1.onSingleLineUpdate_ = nil
			arg_542_1.onSingleLineFinish_ = nil
			arg_542_1.state_ = "waiting"
		end

		function arg_542_1.playNext_(arg_544_0)
			if arg_544_0 == 1 then
				arg_542_0:Play1108409133(arg_542_1)
			end
		end

		function arg_542_1.onSingleLineUpdate_(arg_545_0)
			if 0 < arg_542_1.time_ and arg_542_1.time_ <= 0 + arg_545_0 and not isNil(arg_542_1.actors_["1084ui_story"]) and arg_542_1.var_.characterEffect1084ui_story == nil then
				arg_542_1.var_.characterEffect1084ui_story = arg_542_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_545_0 = 0.200000002980232

			if 0 <= arg_542_1.time_ and arg_542_1.time_ < 0 + var_545_0 and not isNil(arg_542_1.actors_["1084ui_story"]) then
				if arg_542_1.var_.characterEffect1084ui_story and not isNil(arg_542_1.actors_["1084ui_story"]) then
					arg_542_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_542_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_542_1.time_ - 0) / var_545_0)
				end
			end

			if arg_542_1.time_ >= 0 + var_545_0 and arg_542_1.time_ < 0 + var_545_0 + arg_545_0 and not isNil(arg_542_1.actors_["1084ui_story"]) and arg_542_1.var_.characterEffect1084ui_story then
				arg_542_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_542_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_545_1 = 0
			local var_545_2 = 1.1

			if 0 < arg_542_1.time_ and arg_542_1.time_ <= var_545_1 + arg_545_0 then
				arg_542_1.talkMaxDuration = 0
				arg_542_1.dialogCg_.alpha = 1

				arg_542_1.dialog_:SetActive(true)
				SetActive(arg_542_1.leftNameGo_, true)

				arg_542_1.leftNameTxt_.text = arg_542_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_542_1.leftNameTxt_.transform)

				arg_542_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_542_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_542_1:RecordName(arg_542_1.leftNameTxt_.text)
				SetActive(arg_542_1.iconTrs_.gameObject, true)
				arg_542_1.iconController_:SetSelectedState("hero")

				arg_542_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_542_1.callingController_:SetSelectedState("normal")

				arg_542_1.keyicon_.color = Color.New(1, 1, 1)
				arg_542_1.icon_.color = Color.New(1, 1, 1)

				local var_545_3 = arg_542_1:FormatText(arg_542_1:GetWordFromCfg(1108409132).content)

				arg_542_1.text_.text = var_545_3

				LuaForUtil.ClearLinePrefixSymbol(arg_542_1.text_)

				local var_545_5 = 44 <= 0 and var_545_2 or var_545_2 * (utf8.len(var_545_3) / 44)

				if (44 <= 0 and var_545_2 or var_545_2 * (utf8.len(var_545_3) / 44)) > 0 and var_545_2 < var_545_5 then
					arg_542_1.talkMaxDuration = var_545_5

					if var_545_5 + var_545_1 > arg_542_1.duration_ then
						arg_542_1.duration_ = var_545_5 + var_545_1
					end
				end

				arg_542_1.text_.text = var_545_3
				arg_542_1.typewritter.percent = 0

				arg_542_1.typewritter:SetDirty()
				arg_542_1:ShowNextGo(false)
				arg_542_1:RecordContent(arg_542_1.text_.text)
			end

			local var_545_6 = math.max(var_545_2, arg_542_1.talkMaxDuration)

			if var_545_1 <= arg_542_1.time_ and arg_542_1.time_ < var_545_1 + var_545_6 then
				arg_542_1.typewritter.percent = (arg_542_1.time_ - var_545_1) / var_545_6

				arg_542_1.typewritter:SetDirty()
			end

			if arg_542_1.time_ >= var_545_1 + var_545_6 and arg_542_1.time_ < var_545_1 + var_545_6 + arg_545_0 then
				arg_542_1.typewritter.percent = 1

				arg_542_1.typewritter:SetDirty()
				arg_542_1:ShowNextGo(true)
			end
		end

		arg_542_1.nodeConfigList_ = {}

		arg_542_1:InitPlayNodeList()
	end,
	Play1108409133 = function(arg_546_0, arg_546_1)
		arg_546_1.time_ = 0
		arg_546_1.frameCnt_ = 0
		arg_546_1.state_ = "playing"
		arg_546_1.curTalkId_ = 1108409133
		arg_546_1.duration_ = 7.73

		SetActive(arg_546_1.tipsGo_, false)

		function arg_546_1.onSingleLineFinish_()
			arg_546_1.onSingleLineUpdate_ = nil
			arg_546_1.onSingleLineFinish_ = nil
			arg_546_1.state_ = "waiting"
		end

		function arg_546_1.playNext_(arg_548_0)
			if arg_548_0 == 1 then
				arg_546_0:Play1108409134(arg_546_1)
			end
		end

		function arg_546_1.onSingleLineUpdate_(arg_549_0)
			local var_549_0 = 0.925

			if 0 < arg_546_1.time_ and arg_546_1.time_ <= 0 + arg_549_0 then
				arg_546_1.talkMaxDuration = 0
				arg_546_1.dialogCg_.alpha = 1

				arg_546_1.dialog_:SetActive(true)
				SetActive(arg_546_1.leftNameGo_, true)

				arg_546_1.leftNameTxt_.text = arg_546_1:FormatText(StoryNameCfg[426].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_546_1.leftNameTxt_.transform)

				arg_546_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_546_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_546_1:RecordName(arg_546_1.leftNameTxt_.text)
				SetActive(arg_546_1.iconTrs_.gameObject, true)
				arg_546_1.iconController_:SetSelectedState("hero")

				arg_546_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwc")

				arg_546_1.callingController_:SetSelectedState("normal")

				arg_546_1.keyicon_.color = Color.New(1, 1, 1)
				arg_546_1.icon_.color = Color.New(1, 1, 1)

				local var_549_1 = arg_546_1:GetWordFromCfg(1108409133)
				local var_549_2 = arg_546_1:FormatText(var_549_1.content)

				arg_546_1.text_.text = var_549_2

				LuaForUtil.ClearLinePrefixSymbol(arg_546_1.text_)

				local var_549_4 = 37 <= 0 and var_549_0 or var_549_0 * (utf8.len(var_549_2) / 37)

				if (37 <= 0 and var_549_0 or var_549_0 * (utf8.len(var_549_2) / 37)) > 0 and var_549_0 < var_549_4 then
					arg_546_1.talkMaxDuration = var_549_4

					if var_549_4 + 0 > arg_546_1.duration_ then
						arg_546_1.duration_ = var_549_4 + 0
					end
				end

				arg_546_1.text_.text = var_549_2
				arg_546_1.typewritter.percent = 0

				arg_546_1.typewritter:SetDirty()
				arg_546_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409133", "story_v_side_new_1108409.awb") ~= 0 then
					local var_549_5 = manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409133", "story_v_side_new_1108409.awb") / 1000

					if var_549_5 + 0 > arg_546_1.duration_ then
						arg_546_1.duration_ = var_549_5 + 0
					end

					if var_549_1.prefab_name ~= "" and arg_546_1.actors_[var_549_1.prefab_name] ~= nil then
						local var_549_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_546_1.actors_[var_549_1.prefab_name].transform, "story_v_side_new_1108409", "1108409133", "story_v_side_new_1108409.awb")

						arg_546_1:RecordAudio("1108409133", var_549_6)
						arg_546_1:RecordAudio("1108409133", var_549_6)
					else
						arg_546_1:AudioAction("play", "voice", "story_v_side_new_1108409", "1108409133", "story_v_side_new_1108409.awb")
					end

					arg_546_1:RecordHistoryTalkVoice("story_v_side_new_1108409", "1108409133", "story_v_side_new_1108409.awb")
				end

				arg_546_1:RecordContent(arg_546_1.text_.text)
			end

			local var_549_7 = math.max(var_549_0, arg_546_1.talkMaxDuration)

			if 0 <= arg_546_1.time_ and arg_546_1.time_ < 0 + var_549_7 then
				arg_546_1.typewritter.percent = (arg_546_1.time_ - 0) / var_549_7

				arg_546_1.typewritter:SetDirty()
			end

			if arg_546_1.time_ >= 0 + var_549_7 and arg_546_1.time_ < 0 + var_549_7 + arg_549_0 then
				arg_546_1.typewritter.percent = 1

				arg_546_1.typewritter:SetDirty()
				arg_546_1:ShowNextGo(true)
			end
		end

		arg_546_1.nodeConfigList_ = {}

		arg_546_1:InitPlayNodeList()
	end,
	Play1108409134 = function(arg_550_0, arg_550_1)
		arg_550_1.time_ = 0
		arg_550_1.frameCnt_ = 0
		arg_550_1.state_ = "playing"
		arg_550_1.curTalkId_ = 1108409134
		arg_550_1.duration_ = 1

		SetActive(arg_550_1.tipsGo_, false)

		function arg_550_1.onSingleLineFinish_()
			arg_550_1.onSingleLineUpdate_ = nil
			arg_550_1.onSingleLineFinish_ = nil
			arg_550_1.state_ = "waiting"

			SetActive(arg_550_1.choicesGo_, true)

			for iter_551_0, iter_551_1 in ipairs(arg_550_1.choices_) do
				SetActive(iter_551_1.go, iter_551_0 <= 2)
			end

			arg_550_1.choices_[1].txt.text = arg_550_1:FormatText(StoryChoiceCfg[1697].name)
			arg_550_1.choices_[2].txt.text = arg_550_1:FormatText(StoryChoiceCfg[1698].name)
		end

		function arg_550_1.playNext_(arg_552_0)
			if arg_552_0 == 1 then
				arg_550_0:Play1108409135(arg_550_1)
			end

			if arg_552_0 == 2 then
				arg_550_0:Play1108409135(arg_550_1)
			end

			arg_550_1:RecordChoiceLog(1108409134, 1697, 1698)
		end

		function arg_550_1.onSingleLineUpdate_(arg_553_0)
			if 0 < arg_550_1.time_ and arg_550_1.time_ <= 0 + arg_553_0 then
				arg_550_1.allBtn_.enabled = false
			end

			if arg_550_1.time_ >= 0 + 1 and arg_550_1.time_ < 0 + 1 + arg_553_0 then
				arg_550_1.allBtn_.enabled = true
			end
		end

		arg_550_1.nodeConfigList_ = {}

		arg_550_1:InitPlayNodeList()
	end,
	Play1108409135 = function(arg_554_0, arg_554_1)
		arg_554_1.time_ = 0
		arg_554_1.frameCnt_ = 0
		arg_554_1.state_ = "playing"
		arg_554_1.curTalkId_ = 1108409135
		arg_554_1.duration_ = 3.03

		SetActive(arg_554_1.tipsGo_, false)

		function arg_554_1.onSingleLineFinish_()
			arg_554_1.onSingleLineUpdate_ = nil
			arg_554_1.onSingleLineFinish_ = nil
			arg_554_1.state_ = "waiting"
		end

		function arg_554_1.playNext_(arg_556_0)
			if arg_556_0 == 1 then
				arg_554_0:Play1108409136(arg_554_1)
			end
		end

		function arg_554_1.onSingleLineUpdate_(arg_557_0)
			if 0 < arg_554_1.time_ and arg_554_1.time_ <= 0 + arg_557_0 and not isNil(arg_554_1.actors_["1084ui_story"]) and arg_554_1.var_.characterEffect1084ui_story == nil then
				arg_554_1.var_.characterEffect1084ui_story = arg_554_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_557_0 = 0.200000002980232

			if 0 <= arg_554_1.time_ and arg_554_1.time_ < 0 + var_557_0 and not isNil(arg_554_1.actors_["1084ui_story"]) then
				if arg_554_1.var_.characterEffect1084ui_story and not isNil(arg_554_1.actors_["1084ui_story"]) then
					arg_554_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_554_1.time_ >= 0 + var_557_0 and arg_554_1.time_ < 0 + var_557_0 + arg_557_0 and not isNil(arg_554_1.actors_["1084ui_story"]) and arg_554_1.var_.characterEffect1084ui_story then
				arg_554_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_557_2 = "1084ui_story"

			if arg_554_1.actors_["1084ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1084ui_story"))) then
				local var_557_3 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_554_1.stage_.transform)

				var_557_3.name = var_557_2
				var_557_3.transform.localPosition = Vector3.New(0, 100, 0)
				arg_554_1.actors_[var_557_2] = var_557_3

				local var_557_4 = var_557_3:GetComponentInChildren(typeof(CharacterEffect))

				var_557_4.enabled = true

				local var_557_5 = GameObjectTools.GetOrAddComponent(var_557_3, typeof(DynamicBoneHelper))

				if var_557_5 then
					var_557_5:EnableDynamicBone(false)
				end

				arg_554_1:ShowWeapon(var_557_4.transform, false)

				arg_554_1.var_[var_557_2 .. "Animator"] = var_557_4.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_554_1.var_[var_557_2 .. "Animator"].applyRootMotion = true
				arg_554_1.var_[var_557_2 .. "LipSync"] = var_557_4.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_554_1.time_ and arg_554_1.time_ <= 0 + arg_557_0 then
				arg_554_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			local var_557_6 = "1084ui_story"

			if arg_554_1.actors_["1084ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1084ui_story"))) then
				local var_557_7 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_554_1.stage_.transform)

				var_557_7.name = var_557_6
				var_557_7.transform.localPosition = Vector3.New(0, 100, 0)
				arg_554_1.actors_[var_557_6] = var_557_7

				local var_557_8 = var_557_7:GetComponentInChildren(typeof(CharacterEffect))

				var_557_8.enabled = true

				local var_557_9 = GameObjectTools.GetOrAddComponent(var_557_7, typeof(DynamicBoneHelper))

				if var_557_9 then
					var_557_9:EnableDynamicBone(false)
				end

				arg_554_1:ShowWeapon(var_557_8.transform, false)

				arg_554_1.var_[var_557_6 .. "Animator"] = var_557_8.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_554_1.var_[var_557_6 .. "Animator"].applyRootMotion = true
				arg_554_1.var_[var_557_6 .. "LipSync"] = var_557_8.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_554_1.time_ and arg_554_1.time_ <= 0 + arg_557_0 then
				arg_554_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_557_10 = 0
			local var_557_11 = 0.375

			if 0 < arg_554_1.time_ and arg_554_1.time_ <= var_557_10 + arg_557_0 then
				arg_554_1.talkMaxDuration = 0
				arg_554_1.dialogCg_.alpha = 1

				arg_554_1.dialog_:SetActive(true)
				SetActive(arg_554_1.leftNameGo_, true)

				arg_554_1.leftNameTxt_.text = arg_554_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_554_1.leftNameTxt_.transform)

				arg_554_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_554_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_554_1:RecordName(arg_554_1.leftNameTxt_.text)
				SetActive(arg_554_1.iconTrs_.gameObject, false)
				arg_554_1.callingController_:SetSelectedState("normal")

				local var_557_12 = arg_554_1:GetWordFromCfg(1108409135)
				local var_557_13 = arg_554_1:FormatText(var_557_12.content)

				arg_554_1.text_.text = var_557_13

				LuaForUtil.ClearLinePrefixSymbol(arg_554_1.text_)

				local var_557_15 = 15 <= 0 and var_557_11 or var_557_11 * (utf8.len(var_557_13) / 15)

				if (15 <= 0 and var_557_11 or var_557_11 * (utf8.len(var_557_13) / 15)) > 0 and var_557_11 < var_557_15 then
					arg_554_1.talkMaxDuration = var_557_15

					if var_557_15 + var_557_10 > arg_554_1.duration_ then
						arg_554_1.duration_ = var_557_15 + var_557_10
					end
				end

				arg_554_1.text_.text = var_557_13
				arg_554_1.typewritter.percent = 0

				arg_554_1.typewritter:SetDirty()
				arg_554_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409135", "story_v_side_new_1108409.awb") ~= 0 then
					local var_557_16 = manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409135", "story_v_side_new_1108409.awb") / 1000

					if var_557_16 + var_557_10 > arg_554_1.duration_ then
						arg_554_1.duration_ = var_557_16 + var_557_10
					end

					if var_557_12.prefab_name ~= "" and arg_554_1.actors_[var_557_12.prefab_name] ~= nil then
						local var_557_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_554_1.actors_[var_557_12.prefab_name].transform, "story_v_side_new_1108409", "1108409135", "story_v_side_new_1108409.awb")

						arg_554_1:RecordAudio("1108409135", var_557_17)
						arg_554_1:RecordAudio("1108409135", var_557_17)
					else
						arg_554_1:AudioAction("play", "voice", "story_v_side_new_1108409", "1108409135", "story_v_side_new_1108409.awb")
					end

					arg_554_1:RecordHistoryTalkVoice("story_v_side_new_1108409", "1108409135", "story_v_side_new_1108409.awb")
				end

				arg_554_1:RecordContent(arg_554_1.text_.text)
			end

			local var_557_18 = math.max(var_557_11, arg_554_1.talkMaxDuration)

			if var_557_10 <= arg_554_1.time_ and arg_554_1.time_ < var_557_10 + var_557_18 then
				arg_554_1.typewritter.percent = (arg_554_1.time_ - var_557_10) / var_557_18

				arg_554_1.typewritter:SetDirty()
			end

			if arg_554_1.time_ >= var_557_10 + var_557_18 and arg_554_1.time_ < var_557_10 + var_557_18 + arg_557_0 then
				arg_554_1.typewritter.percent = 1

				arg_554_1.typewritter:SetDirty()
				arg_554_1:ShowNextGo(true)
			end
		end

		arg_554_1.nodeConfigList_ = {}

		arg_554_1:InitPlayNodeList()
	end,
	Play1108409136 = function(arg_558_0, arg_558_1)
		arg_558_1.time_ = 0
		arg_558_1.frameCnt_ = 0
		arg_558_1.state_ = "playing"
		arg_558_1.curTalkId_ = 1108409136
		arg_558_1.duration_ = 5.53

		SetActive(arg_558_1.tipsGo_, false)

		function arg_558_1.onSingleLineFinish_()
			arg_558_1.onSingleLineUpdate_ = nil
			arg_558_1.onSingleLineFinish_ = nil
			arg_558_1.state_ = "waiting"
		end

		function arg_558_1.playNext_(arg_560_0)
			if arg_560_0 == 1 then
				arg_558_0:Play1108409137(arg_558_1)
			end
		end

		function arg_558_1.onSingleLineUpdate_(arg_561_0)
			if 0 < arg_558_1.time_ and arg_558_1.time_ <= 0 + arg_561_0 and not isNil(arg_558_1.actors_["1084ui_story"]) and arg_558_1.var_.characterEffect1084ui_story == nil then
				arg_558_1.var_.characterEffect1084ui_story = arg_558_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_561_0 = 0.200000002980232

			if 0 <= arg_558_1.time_ and arg_558_1.time_ < 0 + var_561_0 and not isNil(arg_558_1.actors_["1084ui_story"]) then
				if arg_558_1.var_.characterEffect1084ui_story and not isNil(arg_558_1.actors_["1084ui_story"]) then
					arg_558_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_558_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_558_1.time_ - 0) / var_561_0)
				end
			end

			if arg_558_1.time_ >= 0 + var_561_0 and arg_558_1.time_ < 0 + var_561_0 + arg_561_0 and not isNil(arg_558_1.actors_["1084ui_story"]) and arg_558_1.var_.characterEffect1084ui_story then
				arg_558_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_558_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_561_1 = 0
			local var_561_2 = 0.625

			if 0 < arg_558_1.time_ and arg_558_1.time_ <= var_561_1 + arg_561_0 then
				arg_558_1.talkMaxDuration = 0
				arg_558_1.dialogCg_.alpha = 1

				arg_558_1.dialog_:SetActive(true)
				SetActive(arg_558_1.leftNameGo_, true)

				arg_558_1.leftNameTxt_.text = arg_558_1:FormatText(StoryNameCfg[426].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_558_1.leftNameTxt_.transform)

				arg_558_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_558_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_558_1:RecordName(arg_558_1.leftNameTxt_.text)
				SetActive(arg_558_1.iconTrs_.gameObject, true)
				arg_558_1.iconController_:SetSelectedState("hero")

				arg_558_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwc")

				arg_558_1.callingController_:SetSelectedState("normal")

				arg_558_1.keyicon_.color = Color.New(1, 1, 1)
				arg_558_1.icon_.color = Color.New(1, 1, 1)

				local var_561_3 = arg_558_1:GetWordFromCfg(1108409136)
				local var_561_4 = arg_558_1:FormatText(var_561_3.content)

				arg_558_1.text_.text = var_561_4

				LuaForUtil.ClearLinePrefixSymbol(arg_558_1.text_)

				local var_561_6 = 26 <= 0 and var_561_2 or var_561_2 * (utf8.len(var_561_4) / 26)

				if (26 <= 0 and var_561_2 or var_561_2 * (utf8.len(var_561_4) / 26)) > 0 and var_561_2 < var_561_6 then
					arg_558_1.talkMaxDuration = var_561_6

					if var_561_6 + var_561_1 > arg_558_1.duration_ then
						arg_558_1.duration_ = var_561_6 + var_561_1
					end
				end

				arg_558_1.text_.text = var_561_4
				arg_558_1.typewritter.percent = 0

				arg_558_1.typewritter:SetDirty()
				arg_558_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409136", "story_v_side_new_1108409.awb") ~= 0 then
					local var_561_7 = manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409136", "story_v_side_new_1108409.awb") / 1000

					if var_561_7 + var_561_1 > arg_558_1.duration_ then
						arg_558_1.duration_ = var_561_7 + var_561_1
					end

					if var_561_3.prefab_name ~= "" and arg_558_1.actors_[var_561_3.prefab_name] ~= nil then
						local var_561_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_558_1.actors_[var_561_3.prefab_name].transform, "story_v_side_new_1108409", "1108409136", "story_v_side_new_1108409.awb")

						arg_558_1:RecordAudio("1108409136", var_561_8)
						arg_558_1:RecordAudio("1108409136", var_561_8)
					else
						arg_558_1:AudioAction("play", "voice", "story_v_side_new_1108409", "1108409136", "story_v_side_new_1108409.awb")
					end

					arg_558_1:RecordHistoryTalkVoice("story_v_side_new_1108409", "1108409136", "story_v_side_new_1108409.awb")
				end

				arg_558_1:RecordContent(arg_558_1.text_.text)
			end

			local var_561_9 = math.max(var_561_2, arg_558_1.talkMaxDuration)

			if var_561_1 <= arg_558_1.time_ and arg_558_1.time_ < var_561_1 + var_561_9 then
				arg_558_1.typewritter.percent = (arg_558_1.time_ - var_561_1) / var_561_9

				arg_558_1.typewritter:SetDirty()
			end

			if arg_558_1.time_ >= var_561_1 + var_561_9 and arg_558_1.time_ < var_561_1 + var_561_9 + arg_561_0 then
				arg_558_1.typewritter.percent = 1

				arg_558_1.typewritter:SetDirty()
				arg_558_1:ShowNextGo(true)
			end
		end

		arg_558_1.nodeConfigList_ = {}

		arg_558_1:InitPlayNodeList()
	end,
	Play1108409137 = function(arg_562_0, arg_562_1)
		arg_562_1.time_ = 0
		arg_562_1.frameCnt_ = 0
		arg_562_1.state_ = "playing"
		arg_562_1.curTalkId_ = 1108409137
		arg_562_1.duration_ = 3.3

		SetActive(arg_562_1.tipsGo_, false)

		function arg_562_1.onSingleLineFinish_()
			arg_562_1.onSingleLineUpdate_ = nil
			arg_562_1.onSingleLineFinish_ = nil
			arg_562_1.state_ = "waiting"
		end

		function arg_562_1.playNext_(arg_564_0)
			if arg_564_0 == 1 then
				arg_562_0:Play1108409138(arg_562_1)
			end
		end

		function arg_562_1.onSingleLineUpdate_(arg_565_0)
			if 0 < arg_562_1.time_ and arg_562_1.time_ <= 0 + arg_565_0 and not isNil(arg_562_1.actors_["1084ui_story"]) and arg_562_1.var_.characterEffect1084ui_story == nil then
				arg_562_1.var_.characterEffect1084ui_story = arg_562_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_565_0 = 0.200000002980232

			if 0 <= arg_562_1.time_ and arg_562_1.time_ < 0 + var_565_0 and not isNil(arg_562_1.actors_["1084ui_story"]) then
				if arg_562_1.var_.characterEffect1084ui_story and not isNil(arg_562_1.actors_["1084ui_story"]) then
					arg_562_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_562_1.time_ >= 0 + var_565_0 and arg_562_1.time_ < 0 + var_565_0 + arg_565_0 and not isNil(arg_562_1.actors_["1084ui_story"]) and arg_562_1.var_.characterEffect1084ui_story then
				arg_562_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_562_1.time_ and arg_562_1.time_ <= 0 + arg_565_0 then
				arg_562_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_2")
			end

			if 0 < arg_562_1.time_ and arg_562_1.time_ <= 0 + arg_565_0 then
				arg_562_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_565_2 = 0
			local var_565_3 = 0.35

			if 0 < arg_562_1.time_ and arg_562_1.time_ <= var_565_2 + arg_565_0 then
				arg_562_1.talkMaxDuration = 0
				arg_562_1.dialogCg_.alpha = 1

				arg_562_1.dialog_:SetActive(true)
				SetActive(arg_562_1.leftNameGo_, true)

				arg_562_1.leftNameTxt_.text = arg_562_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_562_1.leftNameTxt_.transform)

				arg_562_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_562_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_562_1:RecordName(arg_562_1.leftNameTxt_.text)
				SetActive(arg_562_1.iconTrs_.gameObject, false)
				arg_562_1.callingController_:SetSelectedState("normal")

				local var_565_4 = arg_562_1:GetWordFromCfg(1108409137)
				local var_565_5 = arg_562_1:FormatText(var_565_4.content)

				arg_562_1.text_.text = var_565_5

				LuaForUtil.ClearLinePrefixSymbol(arg_562_1.text_)

				local var_565_7 = 14 <= 0 and var_565_3 or var_565_3 * (utf8.len(var_565_5) / 14)

				if (14 <= 0 and var_565_3 or var_565_3 * (utf8.len(var_565_5) / 14)) > 0 and var_565_3 < var_565_7 then
					arg_562_1.talkMaxDuration = var_565_7

					if var_565_7 + var_565_2 > arg_562_1.duration_ then
						arg_562_1.duration_ = var_565_7 + var_565_2
					end
				end

				arg_562_1.text_.text = var_565_5
				arg_562_1.typewritter.percent = 0

				arg_562_1.typewritter:SetDirty()
				arg_562_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409137", "story_v_side_new_1108409.awb") ~= 0 then
					local var_565_8 = manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409137", "story_v_side_new_1108409.awb") / 1000

					if var_565_8 + var_565_2 > arg_562_1.duration_ then
						arg_562_1.duration_ = var_565_8 + var_565_2
					end

					if var_565_4.prefab_name ~= "" and arg_562_1.actors_[var_565_4.prefab_name] ~= nil then
						local var_565_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_562_1.actors_[var_565_4.prefab_name].transform, "story_v_side_new_1108409", "1108409137", "story_v_side_new_1108409.awb")

						arg_562_1:RecordAudio("1108409137", var_565_9)
						arg_562_1:RecordAudio("1108409137", var_565_9)
					else
						arg_562_1:AudioAction("play", "voice", "story_v_side_new_1108409", "1108409137", "story_v_side_new_1108409.awb")
					end

					arg_562_1:RecordHistoryTalkVoice("story_v_side_new_1108409", "1108409137", "story_v_side_new_1108409.awb")
				end

				arg_562_1:RecordContent(arg_562_1.text_.text)
			end

			local var_565_10 = math.max(var_565_3, arg_562_1.talkMaxDuration)

			if var_565_2 <= arg_562_1.time_ and arg_562_1.time_ < var_565_2 + var_565_10 then
				arg_562_1.typewritter.percent = (arg_562_1.time_ - var_565_2) / var_565_10

				arg_562_1.typewritter:SetDirty()
			end

			if arg_562_1.time_ >= var_565_2 + var_565_10 and arg_562_1.time_ < var_565_2 + var_565_10 + arg_565_0 then
				arg_562_1.typewritter.percent = 1

				arg_562_1.typewritter:SetDirty()
				arg_562_1:ShowNextGo(true)
			end
		end

		arg_562_1.nodeConfigList_ = {}

		arg_562_1:InitPlayNodeList()
	end,
	Play1108409138 = function(arg_566_0, arg_566_1)
		arg_566_1.time_ = 0
		arg_566_1.frameCnt_ = 0
		arg_566_1.state_ = "playing"
		arg_566_1.curTalkId_ = 1108409138
		arg_566_1.duration_ = 2.97

		SetActive(arg_566_1.tipsGo_, false)

		function arg_566_1.onSingleLineFinish_()
			arg_566_1.onSingleLineUpdate_ = nil
			arg_566_1.onSingleLineFinish_ = nil
			arg_566_1.state_ = "waiting"
		end

		function arg_566_1.playNext_(arg_568_0)
			if arg_568_0 == 1 then
				arg_566_0:Play1108409139(arg_566_1)
			end
		end

		function arg_566_1.onSingleLineUpdate_(arg_569_0)
			if 0 < arg_566_1.time_ and arg_566_1.time_ <= 0 + arg_569_0 and not isNil(arg_566_1.actors_["1084ui_story"]) and arg_566_1.var_.characterEffect1084ui_story == nil then
				arg_566_1.var_.characterEffect1084ui_story = arg_566_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_569_0 = 0.200000002980232

			if 0 <= arg_566_1.time_ and arg_566_1.time_ < 0 + var_569_0 and not isNil(arg_566_1.actors_["1084ui_story"]) then
				if arg_566_1.var_.characterEffect1084ui_story and not isNil(arg_566_1.actors_["1084ui_story"]) then
					arg_566_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_566_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_566_1.time_ - 0) / var_569_0)
				end
			end

			if arg_566_1.time_ >= 0 + var_569_0 and arg_566_1.time_ < 0 + var_569_0 + arg_569_0 and not isNil(arg_566_1.actors_["1084ui_story"]) and arg_566_1.var_.characterEffect1084ui_story then
				arg_566_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_566_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_569_1 = 0
			local var_569_2 = 0.275

			if 0 < arg_566_1.time_ and arg_566_1.time_ <= var_569_1 + arg_569_0 then
				arg_566_1.talkMaxDuration = 0
				arg_566_1.dialogCg_.alpha = 1

				arg_566_1.dialog_:SetActive(true)
				SetActive(arg_566_1.leftNameGo_, true)

				arg_566_1.leftNameTxt_.text = arg_566_1:FormatText(StoryNameCfg[426].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_566_1.leftNameTxt_.transform)

				arg_566_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_566_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_566_1:RecordName(arg_566_1.leftNameTxt_.text)
				SetActive(arg_566_1.iconTrs_.gameObject, true)
				arg_566_1.iconController_:SetSelectedState("hero")

				arg_566_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwc")

				arg_566_1.callingController_:SetSelectedState("normal")

				arg_566_1.keyicon_.color = Color.New(1, 1, 1)
				arg_566_1.icon_.color = Color.New(1, 1, 1)

				local var_569_3 = arg_566_1:GetWordFromCfg(1108409138)
				local var_569_4 = arg_566_1:FormatText(var_569_3.content)

				arg_566_1.text_.text = var_569_4

				LuaForUtil.ClearLinePrefixSymbol(arg_566_1.text_)

				local var_569_6 = 11 <= 0 and var_569_2 or var_569_2 * (utf8.len(var_569_4) / 11)

				if (11 <= 0 and var_569_2 or var_569_2 * (utf8.len(var_569_4) / 11)) > 0 and var_569_2 < var_569_6 then
					arg_566_1.talkMaxDuration = var_569_6

					if var_569_6 + var_569_1 > arg_566_1.duration_ then
						arg_566_1.duration_ = var_569_6 + var_569_1
					end
				end

				arg_566_1.text_.text = var_569_4
				arg_566_1.typewritter.percent = 0

				arg_566_1.typewritter:SetDirty()
				arg_566_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409138", "story_v_side_new_1108409.awb") ~= 0 then
					local var_569_7 = manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409138", "story_v_side_new_1108409.awb") / 1000

					if var_569_7 + var_569_1 > arg_566_1.duration_ then
						arg_566_1.duration_ = var_569_7 + var_569_1
					end

					if var_569_3.prefab_name ~= "" and arg_566_1.actors_[var_569_3.prefab_name] ~= nil then
						local var_569_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_566_1.actors_[var_569_3.prefab_name].transform, "story_v_side_new_1108409", "1108409138", "story_v_side_new_1108409.awb")

						arg_566_1:RecordAudio("1108409138", var_569_8)
						arg_566_1:RecordAudio("1108409138", var_569_8)
					else
						arg_566_1:AudioAction("play", "voice", "story_v_side_new_1108409", "1108409138", "story_v_side_new_1108409.awb")
					end

					arg_566_1:RecordHistoryTalkVoice("story_v_side_new_1108409", "1108409138", "story_v_side_new_1108409.awb")
				end

				arg_566_1:RecordContent(arg_566_1.text_.text)
			end

			local var_569_9 = math.max(var_569_2, arg_566_1.talkMaxDuration)

			if var_569_1 <= arg_566_1.time_ and arg_566_1.time_ < var_569_1 + var_569_9 then
				arg_566_1.typewritter.percent = (arg_566_1.time_ - var_569_1) / var_569_9

				arg_566_1.typewritter:SetDirty()
			end

			if arg_566_1.time_ >= var_569_1 + var_569_9 and arg_566_1.time_ < var_569_1 + var_569_9 + arg_569_0 then
				arg_566_1.typewritter.percent = 1

				arg_566_1.typewritter:SetDirty()
				arg_566_1:ShowNextGo(true)
			end
		end

		arg_566_1.nodeConfigList_ = {}

		arg_566_1:InitPlayNodeList()
	end,
	Play1108409139 = function(arg_570_0, arg_570_1)
		arg_570_1.time_ = 0
		arg_570_1.frameCnt_ = 0
		arg_570_1.state_ = "playing"
		arg_570_1.curTalkId_ = 1108409139
		arg_570_1.duration_ = 3.13

		SetActive(arg_570_1.tipsGo_, false)

		function arg_570_1.onSingleLineFinish_()
			arg_570_1.onSingleLineUpdate_ = nil
			arg_570_1.onSingleLineFinish_ = nil
			arg_570_1.state_ = "waiting"
		end

		function arg_570_1.playNext_(arg_572_0)
			if arg_572_0 == 1 then
				arg_570_0:Play1108409140(arg_570_1)
			end
		end

		function arg_570_1.onSingleLineUpdate_(arg_573_0)
			if 0 < arg_570_1.time_ and arg_570_1.time_ <= 0 + arg_573_0 and not isNil(arg_570_1.actors_["1084ui_story"]) and arg_570_1.var_.characterEffect1084ui_story == nil then
				arg_570_1.var_.characterEffect1084ui_story = arg_570_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_573_0 = 0.200000002980232

			if 0 <= arg_570_1.time_ and arg_570_1.time_ < 0 + var_573_0 and not isNil(arg_570_1.actors_["1084ui_story"]) then
				if arg_570_1.var_.characterEffect1084ui_story and not isNil(arg_570_1.actors_["1084ui_story"]) then
					arg_570_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_570_1.time_ >= 0 + var_573_0 and arg_570_1.time_ < 0 + var_573_0 + arg_573_0 and not isNil(arg_570_1.actors_["1084ui_story"]) and arg_570_1.var_.characterEffect1084ui_story then
				arg_570_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_570_1.time_ and arg_570_1.time_ <= 0 + arg_573_0 then
				arg_570_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_1")
			end

			if 0 < arg_570_1.time_ and arg_570_1.time_ <= 0 + arg_573_0 then
				arg_570_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_573_2 = 0
			local var_573_3 = 0.325

			if 0 < arg_570_1.time_ and arg_570_1.time_ <= var_573_2 + arg_573_0 then
				arg_570_1.talkMaxDuration = 0
				arg_570_1.dialogCg_.alpha = 1

				arg_570_1.dialog_:SetActive(true)
				SetActive(arg_570_1.leftNameGo_, true)

				arg_570_1.leftNameTxt_.text = arg_570_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_570_1.leftNameTxt_.transform)

				arg_570_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_570_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_570_1:RecordName(arg_570_1.leftNameTxt_.text)
				SetActive(arg_570_1.iconTrs_.gameObject, false)
				arg_570_1.callingController_:SetSelectedState("normal")

				local var_573_4 = arg_570_1:GetWordFromCfg(1108409139)
				local var_573_5 = arg_570_1:FormatText(var_573_4.content)

				arg_570_1.text_.text = var_573_5

				LuaForUtil.ClearLinePrefixSymbol(arg_570_1.text_)

				local var_573_7 = 13 <= 0 and var_573_3 or var_573_3 * (utf8.len(var_573_5) / 13)

				if (13 <= 0 and var_573_3 or var_573_3 * (utf8.len(var_573_5) / 13)) > 0 and var_573_3 < var_573_7 then
					arg_570_1.talkMaxDuration = var_573_7

					if var_573_7 + var_573_2 > arg_570_1.duration_ then
						arg_570_1.duration_ = var_573_7 + var_573_2
					end
				end

				arg_570_1.text_.text = var_573_5
				arg_570_1.typewritter.percent = 0

				arg_570_1.typewritter:SetDirty()
				arg_570_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409139", "story_v_side_new_1108409.awb") ~= 0 then
					local var_573_8 = manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409139", "story_v_side_new_1108409.awb") / 1000

					if var_573_8 + var_573_2 > arg_570_1.duration_ then
						arg_570_1.duration_ = var_573_8 + var_573_2
					end

					if var_573_4.prefab_name ~= "" and arg_570_1.actors_[var_573_4.prefab_name] ~= nil then
						local var_573_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_570_1.actors_[var_573_4.prefab_name].transform, "story_v_side_new_1108409", "1108409139", "story_v_side_new_1108409.awb")

						arg_570_1:RecordAudio("1108409139", var_573_9)
						arg_570_1:RecordAudio("1108409139", var_573_9)
					else
						arg_570_1:AudioAction("play", "voice", "story_v_side_new_1108409", "1108409139", "story_v_side_new_1108409.awb")
					end

					arg_570_1:RecordHistoryTalkVoice("story_v_side_new_1108409", "1108409139", "story_v_side_new_1108409.awb")
				end

				arg_570_1:RecordContent(arg_570_1.text_.text)
			end

			local var_573_10 = math.max(var_573_3, arg_570_1.talkMaxDuration)

			if var_573_2 <= arg_570_1.time_ and arg_570_1.time_ < var_573_2 + var_573_10 then
				arg_570_1.typewritter.percent = (arg_570_1.time_ - var_573_2) / var_573_10

				arg_570_1.typewritter:SetDirty()
			end

			if arg_570_1.time_ >= var_573_2 + var_573_10 and arg_570_1.time_ < var_573_2 + var_573_10 + arg_573_0 then
				arg_570_1.typewritter.percent = 1

				arg_570_1.typewritter:SetDirty()
				arg_570_1:ShowNextGo(true)
			end
		end

		arg_570_1.nodeConfigList_ = {}

		arg_570_1:InitPlayNodeList()
	end,
	Play1108409140 = function(arg_574_0, arg_574_1)
		arg_574_1.time_ = 0
		arg_574_1.frameCnt_ = 0
		arg_574_1.state_ = "playing"
		arg_574_1.curTalkId_ = 1108409140
		arg_574_1.duration_ = 6.2

		SetActive(arg_574_1.tipsGo_, false)

		function arg_574_1.onSingleLineFinish_()
			arg_574_1.onSingleLineUpdate_ = nil
			arg_574_1.onSingleLineFinish_ = nil
			arg_574_1.state_ = "waiting"
		end

		function arg_574_1.playNext_(arg_576_0)
			if arg_576_0 == 1 then
				arg_574_0:Play1108409141(arg_574_1)
			end
		end

		function arg_574_1.onSingleLineUpdate_(arg_577_0)
			if 0 < arg_574_1.time_ and arg_574_1.time_ <= 0 + arg_577_0 and not isNil(arg_574_1.actors_["1084ui_story"]) and arg_574_1.var_.characterEffect1084ui_story == nil then
				arg_574_1.var_.characterEffect1084ui_story = arg_574_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_577_0 = 0.200000002980232

			if 0 <= arg_574_1.time_ and arg_574_1.time_ < 0 + var_577_0 and not isNil(arg_574_1.actors_["1084ui_story"]) then
				if arg_574_1.var_.characterEffect1084ui_story and not isNil(arg_574_1.actors_["1084ui_story"]) then
					arg_574_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_574_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_574_1.time_ - 0) / var_577_0)
				end
			end

			if arg_574_1.time_ >= 0 + var_577_0 and arg_574_1.time_ < 0 + var_577_0 + arg_577_0 and not isNil(arg_574_1.actors_["1084ui_story"]) and arg_574_1.var_.characterEffect1084ui_story then
				arg_574_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_574_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_577_1 = 0
			local var_577_2 = 0.675

			if 0 < arg_574_1.time_ and arg_574_1.time_ <= var_577_1 + arg_577_0 then
				arg_574_1.talkMaxDuration = 0
				arg_574_1.dialogCg_.alpha = 1

				arg_574_1.dialog_:SetActive(true)
				SetActive(arg_574_1.leftNameGo_, true)

				arg_574_1.leftNameTxt_.text = arg_574_1:FormatText(StoryNameCfg[426].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_574_1.leftNameTxt_.transform)

				arg_574_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_574_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_574_1:RecordName(arg_574_1.leftNameTxt_.text)
				SetActive(arg_574_1.iconTrs_.gameObject, true)
				arg_574_1.iconController_:SetSelectedState("hero")

				arg_574_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwc")

				arg_574_1.callingController_:SetSelectedState("normal")

				arg_574_1.keyicon_.color = Color.New(1, 1, 1)
				arg_574_1.icon_.color = Color.New(1, 1, 1)

				local var_577_3 = arg_574_1:GetWordFromCfg(1108409140)
				local var_577_4 = arg_574_1:FormatText(var_577_3.content)

				arg_574_1.text_.text = var_577_4

				LuaForUtil.ClearLinePrefixSymbol(arg_574_1.text_)

				local var_577_6 = 27 <= 0 and var_577_2 or var_577_2 * (utf8.len(var_577_4) / 27)

				if (27 <= 0 and var_577_2 or var_577_2 * (utf8.len(var_577_4) / 27)) > 0 and var_577_2 < var_577_6 then
					arg_574_1.talkMaxDuration = var_577_6

					if var_577_6 + var_577_1 > arg_574_1.duration_ then
						arg_574_1.duration_ = var_577_6 + var_577_1
					end
				end

				arg_574_1.text_.text = var_577_4
				arg_574_1.typewritter.percent = 0

				arg_574_1.typewritter:SetDirty()
				arg_574_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409140", "story_v_side_new_1108409.awb") ~= 0 then
					local var_577_7 = manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409140", "story_v_side_new_1108409.awb") / 1000

					if var_577_7 + var_577_1 > arg_574_1.duration_ then
						arg_574_1.duration_ = var_577_7 + var_577_1
					end

					if var_577_3.prefab_name ~= "" and arg_574_1.actors_[var_577_3.prefab_name] ~= nil then
						local var_577_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_574_1.actors_[var_577_3.prefab_name].transform, "story_v_side_new_1108409", "1108409140", "story_v_side_new_1108409.awb")

						arg_574_1:RecordAudio("1108409140", var_577_8)
						arg_574_1:RecordAudio("1108409140", var_577_8)
					else
						arg_574_1:AudioAction("play", "voice", "story_v_side_new_1108409", "1108409140", "story_v_side_new_1108409.awb")
					end

					arg_574_1:RecordHistoryTalkVoice("story_v_side_new_1108409", "1108409140", "story_v_side_new_1108409.awb")
				end

				arg_574_1:RecordContent(arg_574_1.text_.text)
			end

			local var_577_9 = math.max(var_577_2, arg_574_1.talkMaxDuration)

			if var_577_1 <= arg_574_1.time_ and arg_574_1.time_ < var_577_1 + var_577_9 then
				arg_574_1.typewritter.percent = (arg_574_1.time_ - var_577_1) / var_577_9

				arg_574_1.typewritter:SetDirty()
			end

			if arg_574_1.time_ >= var_577_1 + var_577_9 and arg_574_1.time_ < var_577_1 + var_577_9 + arg_577_0 then
				arg_574_1.typewritter.percent = 1

				arg_574_1.typewritter:SetDirty()
				arg_574_1:ShowNextGo(true)
			end
		end

		arg_574_1.nodeConfigList_ = {}

		arg_574_1:InitPlayNodeList()
	end,
	Play1108409141 = function(arg_578_0, arg_578_1)
		arg_578_1.time_ = 0
		arg_578_1.frameCnt_ = 0
		arg_578_1.state_ = "playing"
		arg_578_1.curTalkId_ = 1108409141
		arg_578_1.duration_ = 5

		SetActive(arg_578_1.tipsGo_, false)

		function arg_578_1.onSingleLineFinish_()
			arg_578_1.onSingleLineUpdate_ = nil
			arg_578_1.onSingleLineFinish_ = nil
			arg_578_1.state_ = "waiting"
		end

		function arg_578_1.playNext_(arg_580_0)
			if arg_580_0 == 1 then
				arg_578_0:Play1108409142(arg_578_1)
			end
		end

		function arg_578_1.onSingleLineUpdate_(arg_581_0)
			if 0 < arg_578_1.time_ and arg_578_1.time_ <= 0 + arg_581_0 then
				arg_578_1.var_.moveOldPos1084ui_story = arg_578_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_581_0 = 0.001

			if 0 <= arg_578_1.time_ and arg_578_1.time_ < 0 + var_581_0 then
				arg_578_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_578_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_578_1.time_ - 0) / var_581_0)
				arg_578_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_578_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_578_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_578_1.actors_["1084ui_story"].transform.position).z)
				arg_578_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_578_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_578_1.actors_["1084ui_story"].transform.localEulerAngles = arg_578_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_578_1.time_ >= 0 + var_581_0 and arg_578_1.time_ < 0 + var_581_0 + arg_581_0 then
				arg_578_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_578_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_578_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_578_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_578_1.actors_["1084ui_story"].transform.position).z)
				arg_578_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_578_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_578_1.actors_["1084ui_story"].transform.localEulerAngles = arg_578_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_581_1 = 0
			local var_581_2 = 0.85

			if 0 < arg_578_1.time_ and arg_578_1.time_ <= var_581_1 + arg_581_0 then
				arg_578_1.talkMaxDuration = 0
				arg_578_1.dialogCg_.alpha = 1

				arg_578_1.dialog_:SetActive(true)
				SetActive(arg_578_1.leftNameGo_, false)

				arg_578_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_578_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_578_1:RecordName(arg_578_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_578_1.iconTrs_.gameObject, false)
				arg_578_1.callingController_:SetSelectedState("normal")

				local var_581_3 = arg_578_1:FormatText(arg_578_1:GetWordFromCfg(1108409141).content)

				arg_578_1.text_.text = var_581_3

				LuaForUtil.ClearLinePrefixSymbol(arg_578_1.text_)

				local var_581_5 = 34 <= 0 and var_581_2 or var_581_2 * (utf8.len(var_581_3) / 34)

				if (34 <= 0 and var_581_2 or var_581_2 * (utf8.len(var_581_3) / 34)) > 0 and var_581_2 < var_581_5 then
					arg_578_1.talkMaxDuration = var_581_5

					if var_581_5 + var_581_1 > arg_578_1.duration_ then
						arg_578_1.duration_ = var_581_5 + var_581_1
					end
				end

				arg_578_1.text_.text = var_581_3
				arg_578_1.typewritter.percent = 0

				arg_578_1.typewritter:SetDirty()
				arg_578_1:ShowNextGo(false)
				arg_578_1:RecordContent(arg_578_1.text_.text)
			end

			local var_581_6 = math.max(var_581_2, arg_578_1.talkMaxDuration)

			if var_581_1 <= arg_578_1.time_ and arg_578_1.time_ < var_581_1 + var_581_6 then
				arg_578_1.typewritter.percent = (arg_578_1.time_ - var_581_1) / var_581_6

				arg_578_1.typewritter:SetDirty()
			end

			if arg_578_1.time_ >= var_581_1 + var_581_6 and arg_578_1.time_ < var_581_1 + var_581_6 + arg_581_0 then
				arg_578_1.typewritter.percent = 1

				arg_578_1.typewritter:SetDirty()
				arg_578_1:ShowNextGo(true)
			end
		end

		arg_578_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_578_1:InitPlayNodeList()
	end,
	Play1108409142 = function(arg_582_0, arg_582_1)
		arg_582_1.time_ = 0
		arg_582_1.frameCnt_ = 0
		arg_582_1.state_ = "playing"
		arg_582_1.curTalkId_ = 1108409142
		arg_582_1.duration_ = 8.27

		SetActive(arg_582_1.tipsGo_, false)

		function arg_582_1.onSingleLineFinish_()
			arg_582_1.onSingleLineUpdate_ = nil
			arg_582_1.onSingleLineFinish_ = nil
			arg_582_1.state_ = "waiting"
		end

		function arg_582_1.playNext_(arg_584_0)
			if arg_584_0 == 1 then
				arg_582_0:Play1108409143(arg_582_1)
			end
		end

		function arg_582_1.onSingleLineUpdate_(arg_585_0)
			if 0 < arg_582_1.time_ and arg_582_1.time_ <= 0 + arg_585_0 then
				arg_582_1.var_.moveOldPos1084ui_story = arg_582_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_585_0 = 0.001

			if 0 <= arg_582_1.time_ and arg_582_1.time_ < 0 + var_585_0 then
				arg_582_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_582_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_582_1.time_ - 0) / var_585_0)
				arg_582_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_582_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_582_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_582_1.actors_["1084ui_story"].transform.position).z)
				arg_582_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_582_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_582_1.actors_["1084ui_story"].transform.localEulerAngles = arg_582_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_582_1.time_ >= 0 + var_585_0 and arg_582_1.time_ < 0 + var_585_0 + arg_585_0 then
				arg_582_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_582_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_582_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_582_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_582_1.actors_["1084ui_story"].transform.position).z)
				arg_582_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_582_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_582_1.actors_["1084ui_story"].transform.localEulerAngles = arg_582_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_585_1 = arg_582_1.actors_["1084ui_story"]

			if 0 < arg_582_1.time_ and arg_582_1.time_ <= 0 + arg_585_0 and not isNil(var_585_1) and arg_582_1.var_.characterEffect1084ui_story == nil then
				arg_582_1.var_.characterEffect1084ui_story = var_585_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_585_2 = 0.200000002980232

			if 0 <= arg_582_1.time_ and arg_582_1.time_ < 0 + var_585_2 and not isNil(var_585_1) then
				if arg_582_1.var_.characterEffect1084ui_story and not isNil(var_585_1) then
					arg_582_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_582_1.time_ >= 0 + var_585_2 and arg_582_1.time_ < 0 + var_585_2 + arg_585_0 and not isNil(var_585_1) and arg_582_1.var_.characterEffect1084ui_story then
				arg_582_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_582_1.time_ and arg_582_1.time_ <= 0 + arg_585_0 then
				arg_582_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_1")
			end

			if 0 < arg_582_1.time_ and arg_582_1.time_ <= 0 + arg_585_0 then
				arg_582_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_585_4 = 0
			local var_585_5 = 0.775

			if 0 < arg_582_1.time_ and arg_582_1.time_ <= var_585_4 + arg_585_0 then
				arg_582_1.talkMaxDuration = 0
				arg_582_1.dialogCg_.alpha = 1

				arg_582_1.dialog_:SetActive(true)
				SetActive(arg_582_1.leftNameGo_, true)

				arg_582_1.leftNameTxt_.text = arg_582_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_582_1.leftNameTxt_.transform)

				arg_582_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_582_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_582_1:RecordName(arg_582_1.leftNameTxt_.text)
				SetActive(arg_582_1.iconTrs_.gameObject, false)
				arg_582_1.callingController_:SetSelectedState("normal")

				local var_585_6 = arg_582_1:GetWordFromCfg(1108409142)
				local var_585_7 = arg_582_1:FormatText(var_585_6.content)

				arg_582_1.text_.text = var_585_7

				LuaForUtil.ClearLinePrefixSymbol(arg_582_1.text_)

				local var_585_9 = 31 <= 0 and var_585_5 or var_585_5 * (utf8.len(var_585_7) / 31)

				if (31 <= 0 and var_585_5 or var_585_5 * (utf8.len(var_585_7) / 31)) > 0 and var_585_5 < var_585_9 then
					arg_582_1.talkMaxDuration = var_585_9

					if var_585_9 + var_585_4 > arg_582_1.duration_ then
						arg_582_1.duration_ = var_585_9 + var_585_4
					end
				end

				arg_582_1.text_.text = var_585_7
				arg_582_1.typewritter.percent = 0

				arg_582_1.typewritter:SetDirty()
				arg_582_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409142", "story_v_side_new_1108409.awb") ~= 0 then
					local var_585_10 = manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409142", "story_v_side_new_1108409.awb") / 1000

					if var_585_10 + var_585_4 > arg_582_1.duration_ then
						arg_582_1.duration_ = var_585_10 + var_585_4
					end

					if var_585_6.prefab_name ~= "" and arg_582_1.actors_[var_585_6.prefab_name] ~= nil then
						local var_585_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_582_1.actors_[var_585_6.prefab_name].transform, "story_v_side_new_1108409", "1108409142", "story_v_side_new_1108409.awb")

						arg_582_1:RecordAudio("1108409142", var_585_11)
						arg_582_1:RecordAudio("1108409142", var_585_11)
					else
						arg_582_1:AudioAction("play", "voice", "story_v_side_new_1108409", "1108409142", "story_v_side_new_1108409.awb")
					end

					arg_582_1:RecordHistoryTalkVoice("story_v_side_new_1108409", "1108409142", "story_v_side_new_1108409.awb")
				end

				arg_582_1:RecordContent(arg_582_1.text_.text)
			end

			local var_585_12 = math.max(var_585_5, arg_582_1.talkMaxDuration)

			if var_585_4 <= arg_582_1.time_ and arg_582_1.time_ < var_585_4 + var_585_12 then
				arg_582_1.typewritter.percent = (arg_582_1.time_ - var_585_4) / var_585_12

				arg_582_1.typewritter:SetDirty()
			end

			if arg_582_1.time_ >= var_585_4 + var_585_12 and arg_582_1.time_ < var_585_4 + var_585_12 + arg_585_0 then
				arg_582_1.typewritter.percent = 1

				arg_582_1.typewritter:SetDirty()
				arg_582_1:ShowNextGo(true)
			end
		end

		arg_582_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_582_1:InitPlayNodeList()
	end,
	Play1108409143 = function(arg_586_0, arg_586_1)
		arg_586_1.time_ = 0
		arg_586_1.frameCnt_ = 0
		arg_586_1.state_ = "playing"
		arg_586_1.curTalkId_ = 1108409143
		arg_586_1.duration_ = 5

		SetActive(arg_586_1.tipsGo_, false)

		function arg_586_1.onSingleLineFinish_()
			arg_586_1.onSingleLineUpdate_ = nil
			arg_586_1.onSingleLineFinish_ = nil
			arg_586_1.state_ = "waiting"
		end

		function arg_586_1.playNext_(arg_588_0)
			if arg_588_0 == 1 then
				arg_586_0:Play1108409144(arg_586_1)
			end
		end

		function arg_586_1.onSingleLineUpdate_(arg_589_0)
			if 0 < arg_586_1.time_ and arg_586_1.time_ <= 0 + arg_589_0 and not isNil(arg_586_1.actors_["1084ui_story"]) and arg_586_1.var_.characterEffect1084ui_story == nil then
				arg_586_1.var_.characterEffect1084ui_story = arg_586_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_589_0 = 0.200000002980232

			if 0 <= arg_586_1.time_ and arg_586_1.time_ < 0 + var_589_0 and not isNil(arg_586_1.actors_["1084ui_story"]) then
				if arg_586_1.var_.characterEffect1084ui_story and not isNil(arg_586_1.actors_["1084ui_story"]) then
					arg_586_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_586_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_586_1.time_ - 0) / var_589_0)
				end
			end

			if arg_586_1.time_ >= 0 + var_589_0 and arg_586_1.time_ < 0 + var_589_0 + arg_589_0 and not isNil(arg_586_1.actors_["1084ui_story"]) and arg_586_1.var_.characterEffect1084ui_story then
				arg_586_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_586_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_589_1 = 0
			local var_589_2 = 0.65

			if 0 < arg_586_1.time_ and arg_586_1.time_ <= var_589_1 + arg_589_0 then
				arg_586_1.talkMaxDuration = 0
				arg_586_1.dialogCg_.alpha = 1

				arg_586_1.dialog_:SetActive(true)
				SetActive(arg_586_1.leftNameGo_, true)

				arg_586_1.leftNameTxt_.text = arg_586_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_586_1.leftNameTxt_.transform)

				arg_586_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_586_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_586_1:RecordName(arg_586_1.leftNameTxt_.text)
				SetActive(arg_586_1.iconTrs_.gameObject, true)
				arg_586_1.iconController_:SetSelectedState("hero")

				arg_586_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_586_1.callingController_:SetSelectedState("normal")

				arg_586_1.keyicon_.color = Color.New(1, 1, 1)
				arg_586_1.icon_.color = Color.New(1, 1, 1)

				local var_589_3 = arg_586_1:FormatText(arg_586_1:GetWordFromCfg(1108409143).content)

				arg_586_1.text_.text = var_589_3

				LuaForUtil.ClearLinePrefixSymbol(arg_586_1.text_)

				local var_589_5 = 26 <= 0 and var_589_2 or var_589_2 * (utf8.len(var_589_3) / 26)

				if (26 <= 0 and var_589_2 or var_589_2 * (utf8.len(var_589_3) / 26)) > 0 and var_589_2 < var_589_5 then
					arg_586_1.talkMaxDuration = var_589_5

					if var_589_5 + var_589_1 > arg_586_1.duration_ then
						arg_586_1.duration_ = var_589_5 + var_589_1
					end
				end

				arg_586_1.text_.text = var_589_3
				arg_586_1.typewritter.percent = 0

				arg_586_1.typewritter:SetDirty()
				arg_586_1:ShowNextGo(false)
				arg_586_1:RecordContent(arg_586_1.text_.text)
			end

			local var_589_6 = math.max(var_589_2, arg_586_1.talkMaxDuration)

			if var_589_1 <= arg_586_1.time_ and arg_586_1.time_ < var_589_1 + var_589_6 then
				arg_586_1.typewritter.percent = (arg_586_1.time_ - var_589_1) / var_589_6

				arg_586_1.typewritter:SetDirty()
			end

			if arg_586_1.time_ >= var_589_1 + var_589_6 and arg_586_1.time_ < var_589_1 + var_589_6 + arg_589_0 then
				arg_586_1.typewritter.percent = 1

				arg_586_1.typewritter:SetDirty()
				arg_586_1:ShowNextGo(true)
			end
		end

		arg_586_1.nodeConfigList_ = {}

		arg_586_1:InitPlayNodeList()
	end,
	Play1108409144 = function(arg_590_0, arg_590_1)
		arg_590_1.time_ = 0
		arg_590_1.frameCnt_ = 0
		arg_590_1.state_ = "playing"
		arg_590_1.curTalkId_ = 1108409144
		arg_590_1.duration_ = 5.87

		SetActive(arg_590_1.tipsGo_, false)

		function arg_590_1.onSingleLineFinish_()
			arg_590_1.onSingleLineUpdate_ = nil
			arg_590_1.onSingleLineFinish_ = nil
			arg_590_1.state_ = "waiting"
		end

		function arg_590_1.playNext_(arg_592_0)
			if arg_592_0 == 1 then
				arg_590_0:Play1108409145(arg_590_1)
			end
		end

		function arg_590_1.onSingleLineUpdate_(arg_593_0)
			if 0 < arg_590_1.time_ and arg_590_1.time_ <= 0 + arg_593_0 and not isNil(arg_590_1.actors_["1084ui_story"]) and arg_590_1.var_.characterEffect1084ui_story == nil then
				arg_590_1.var_.characterEffect1084ui_story = arg_590_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_593_0 = 0.200000002980232

			if 0 <= arg_590_1.time_ and arg_590_1.time_ < 0 + var_593_0 and not isNil(arg_590_1.actors_["1084ui_story"]) then
				if arg_590_1.var_.characterEffect1084ui_story and not isNil(arg_590_1.actors_["1084ui_story"]) then
					arg_590_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_590_1.time_ >= 0 + var_593_0 and arg_590_1.time_ < 0 + var_593_0 + arg_593_0 and not isNil(arg_590_1.actors_["1084ui_story"]) and arg_590_1.var_.characterEffect1084ui_story then
				arg_590_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_590_1.time_ and arg_590_1.time_ <= 0 + arg_593_0 then
				arg_590_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_2")
			end

			if 0 < arg_590_1.time_ and arg_590_1.time_ <= 0 + arg_593_0 then
				arg_590_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_593_2 = 0
			local var_593_3 = 0.475

			if 0 < arg_590_1.time_ and arg_590_1.time_ <= var_593_2 + arg_593_0 then
				arg_590_1.talkMaxDuration = 0
				arg_590_1.dialogCg_.alpha = 1

				arg_590_1.dialog_:SetActive(true)
				SetActive(arg_590_1.leftNameGo_, true)

				arg_590_1.leftNameTxt_.text = arg_590_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_590_1.leftNameTxt_.transform)

				arg_590_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_590_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_590_1:RecordName(arg_590_1.leftNameTxt_.text)
				SetActive(arg_590_1.iconTrs_.gameObject, false)
				arg_590_1.callingController_:SetSelectedState("normal")

				local var_593_4 = arg_590_1:GetWordFromCfg(1108409144)
				local var_593_5 = arg_590_1:FormatText(var_593_4.content)

				arg_590_1.text_.text = var_593_5

				LuaForUtil.ClearLinePrefixSymbol(arg_590_1.text_)

				local var_593_7 = 19 <= 0 and var_593_3 or var_593_3 * (utf8.len(var_593_5) / 19)

				if (19 <= 0 and var_593_3 or var_593_3 * (utf8.len(var_593_5) / 19)) > 0 and var_593_3 < var_593_7 then
					arg_590_1.talkMaxDuration = var_593_7

					if var_593_7 + var_593_2 > arg_590_1.duration_ then
						arg_590_1.duration_ = var_593_7 + var_593_2
					end
				end

				arg_590_1.text_.text = var_593_5
				arg_590_1.typewritter.percent = 0

				arg_590_1.typewritter:SetDirty()
				arg_590_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409144", "story_v_side_new_1108409.awb") ~= 0 then
					local var_593_8 = manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409144", "story_v_side_new_1108409.awb") / 1000

					if var_593_8 + var_593_2 > arg_590_1.duration_ then
						arg_590_1.duration_ = var_593_8 + var_593_2
					end

					if var_593_4.prefab_name ~= "" and arg_590_1.actors_[var_593_4.prefab_name] ~= nil then
						local var_593_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_590_1.actors_[var_593_4.prefab_name].transform, "story_v_side_new_1108409", "1108409144", "story_v_side_new_1108409.awb")

						arg_590_1:RecordAudio("1108409144", var_593_9)
						arg_590_1:RecordAudio("1108409144", var_593_9)
					else
						arg_590_1:AudioAction("play", "voice", "story_v_side_new_1108409", "1108409144", "story_v_side_new_1108409.awb")
					end

					arg_590_1:RecordHistoryTalkVoice("story_v_side_new_1108409", "1108409144", "story_v_side_new_1108409.awb")
				end

				arg_590_1:RecordContent(arg_590_1.text_.text)
			end

			local var_593_10 = math.max(var_593_3, arg_590_1.talkMaxDuration)

			if var_593_2 <= arg_590_1.time_ and arg_590_1.time_ < var_593_2 + var_593_10 then
				arg_590_1.typewritter.percent = (arg_590_1.time_ - var_593_2) / var_593_10

				arg_590_1.typewritter:SetDirty()
			end

			if arg_590_1.time_ >= var_593_2 + var_593_10 and arg_590_1.time_ < var_593_2 + var_593_10 + arg_593_0 then
				arg_590_1.typewritter.percent = 1

				arg_590_1.typewritter:SetDirty()
				arg_590_1:ShowNextGo(true)
			end
		end

		arg_590_1.nodeConfigList_ = {}

		arg_590_1:InitPlayNodeList()
	end,
	Play1108409145 = function(arg_594_0, arg_594_1)
		arg_594_1.time_ = 0
		arg_594_1.frameCnt_ = 0
		arg_594_1.state_ = "playing"
		arg_594_1.curTalkId_ = 1108409145
		arg_594_1.duration_ = 5

		SetActive(arg_594_1.tipsGo_, false)

		function arg_594_1.onSingleLineFinish_()
			arg_594_1.onSingleLineUpdate_ = nil
			arg_594_1.onSingleLineFinish_ = nil
			arg_594_1.state_ = "waiting"
		end

		function arg_594_1.playNext_(arg_596_0)
			if arg_596_0 == 1 then
				arg_594_0:Play1108409146(arg_594_1)
			end
		end

		function arg_594_1.onSingleLineUpdate_(arg_597_0)
			if 0 < arg_594_1.time_ and arg_594_1.time_ <= 0 + arg_597_0 and not isNil(arg_594_1.actors_["1084ui_story"]) and arg_594_1.var_.characterEffect1084ui_story == nil then
				arg_594_1.var_.characterEffect1084ui_story = arg_594_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_597_0 = 0.200000002980232

			if 0 <= arg_594_1.time_ and arg_594_1.time_ < 0 + var_597_0 and not isNil(arg_594_1.actors_["1084ui_story"]) then
				if arg_594_1.var_.characterEffect1084ui_story and not isNil(arg_594_1.actors_["1084ui_story"]) then
					arg_594_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_594_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_594_1.time_ - 0) / var_597_0)
				end
			end

			if arg_594_1.time_ >= 0 + var_597_0 and arg_594_1.time_ < 0 + var_597_0 + arg_597_0 and not isNil(arg_594_1.actors_["1084ui_story"]) and arg_594_1.var_.characterEffect1084ui_story then
				arg_594_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_594_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_597_1 = 0
			local var_597_2 = 0.15

			if 0 < arg_594_1.time_ and arg_594_1.time_ <= var_597_1 + arg_597_0 then
				arg_594_1.talkMaxDuration = 0
				arg_594_1.dialogCg_.alpha = 1

				arg_594_1.dialog_:SetActive(true)
				SetActive(arg_594_1.leftNameGo_, true)

				arg_594_1.leftNameTxt_.text = arg_594_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_594_1.leftNameTxt_.transform)

				arg_594_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_594_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_594_1:RecordName(arg_594_1.leftNameTxt_.text)
				SetActive(arg_594_1.iconTrs_.gameObject, true)
				arg_594_1.iconController_:SetSelectedState("hero")

				arg_594_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_594_1.callingController_:SetSelectedState("normal")

				arg_594_1.keyicon_.color = Color.New(1, 1, 1)
				arg_594_1.icon_.color = Color.New(1, 1, 1)

				local var_597_3 = arg_594_1:FormatText(arg_594_1:GetWordFromCfg(1108409145).content)

				arg_594_1.text_.text = var_597_3

				LuaForUtil.ClearLinePrefixSymbol(arg_594_1.text_)

				local var_597_5 = 6 <= 0 and var_597_2 or var_597_2 * (utf8.len(var_597_3) / 6)

				if (6 <= 0 and var_597_2 or var_597_2 * (utf8.len(var_597_3) / 6)) > 0 and var_597_2 < var_597_5 then
					arg_594_1.talkMaxDuration = var_597_5

					if var_597_5 + var_597_1 > arg_594_1.duration_ then
						arg_594_1.duration_ = var_597_5 + var_597_1
					end
				end

				arg_594_1.text_.text = var_597_3
				arg_594_1.typewritter.percent = 0

				arg_594_1.typewritter:SetDirty()
				arg_594_1:ShowNextGo(false)
				arg_594_1:RecordContent(arg_594_1.text_.text)
			end

			local var_597_6 = math.max(var_597_2, arg_594_1.talkMaxDuration)

			if var_597_1 <= arg_594_1.time_ and arg_594_1.time_ < var_597_1 + var_597_6 then
				arg_594_1.typewritter.percent = (arg_594_1.time_ - var_597_1) / var_597_6

				arg_594_1.typewritter:SetDirty()
			end

			if arg_594_1.time_ >= var_597_1 + var_597_6 and arg_594_1.time_ < var_597_1 + var_597_6 + arg_597_0 then
				arg_594_1.typewritter.percent = 1

				arg_594_1.typewritter:SetDirty()
				arg_594_1:ShowNextGo(true)
			end
		end

		arg_594_1.nodeConfigList_ = {}

		arg_594_1:InitPlayNodeList()
	end,
	Play1108409146 = function(arg_598_0, arg_598_1)
		arg_598_1.time_ = 0
		arg_598_1.frameCnt_ = 0
		arg_598_1.state_ = "playing"
		arg_598_1.curTalkId_ = 1108409146
		arg_598_1.duration_ = 11.1

		SetActive(arg_598_1.tipsGo_, false)

		function arg_598_1.onSingleLineFinish_()
			arg_598_1.onSingleLineUpdate_ = nil
			arg_598_1.onSingleLineFinish_ = nil
			arg_598_1.state_ = "waiting"
		end

		function arg_598_1.playNext_(arg_600_0)
			if arg_600_0 == 1 then
				arg_598_0:Play1108409147(arg_598_1)
			end
		end

		function arg_598_1.onSingleLineUpdate_(arg_601_0)
			if 0 < arg_598_1.time_ and arg_598_1.time_ <= 0 + arg_601_0 and not isNil(arg_598_1.actors_["1084ui_story"]) and arg_598_1.var_.characterEffect1084ui_story == nil then
				arg_598_1.var_.characterEffect1084ui_story = arg_598_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_601_0 = 0.200000002980232

			if 0 <= arg_598_1.time_ and arg_598_1.time_ < 0 + var_601_0 and not isNil(arg_598_1.actors_["1084ui_story"]) then
				if arg_598_1.var_.characterEffect1084ui_story and not isNil(arg_598_1.actors_["1084ui_story"]) then
					arg_598_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_598_1.time_ >= 0 + var_601_0 and arg_598_1.time_ < 0 + var_601_0 + arg_601_0 and not isNil(arg_598_1.actors_["1084ui_story"]) and arg_598_1.var_.characterEffect1084ui_story then
				arg_598_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_598_1.time_ and arg_598_1.time_ <= 0 + arg_601_0 then
				arg_598_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action6_1")
			end

			if 0 < arg_598_1.time_ and arg_598_1.time_ <= 0 + arg_601_0 then
				arg_598_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1301cva", "EmotionTimelineAnimator")
			end

			local var_601_2 = 0
			local var_601_3 = 0.825

			if 0 < arg_598_1.time_ and arg_598_1.time_ <= var_601_2 + arg_601_0 then
				arg_598_1.talkMaxDuration = 0
				arg_598_1.dialogCg_.alpha = 1

				arg_598_1.dialog_:SetActive(true)
				SetActive(arg_598_1.leftNameGo_, true)

				arg_598_1.leftNameTxt_.text = arg_598_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_598_1.leftNameTxt_.transform)

				arg_598_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_598_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_598_1:RecordName(arg_598_1.leftNameTxt_.text)
				SetActive(arg_598_1.iconTrs_.gameObject, false)
				arg_598_1.callingController_:SetSelectedState("normal")

				local var_601_4 = arg_598_1:GetWordFromCfg(1108409146)
				local var_601_5 = arg_598_1:FormatText(var_601_4.content)

				arg_598_1.text_.text = var_601_5

				LuaForUtil.ClearLinePrefixSymbol(arg_598_1.text_)

				local var_601_7 = 33 <= 0 and var_601_3 or var_601_3 * (utf8.len(var_601_5) / 33)

				if (33 <= 0 and var_601_3 or var_601_3 * (utf8.len(var_601_5) / 33)) > 0 and var_601_3 < var_601_7 then
					arg_598_1.talkMaxDuration = var_601_7

					if var_601_7 + var_601_2 > arg_598_1.duration_ then
						arg_598_1.duration_ = var_601_7 + var_601_2
					end
				end

				arg_598_1.text_.text = var_601_5
				arg_598_1.typewritter.percent = 0

				arg_598_1.typewritter:SetDirty()
				arg_598_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409146", "story_v_side_new_1108409.awb") ~= 0 then
					local var_601_8 = manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409146", "story_v_side_new_1108409.awb") / 1000

					if var_601_8 + var_601_2 > arg_598_1.duration_ then
						arg_598_1.duration_ = var_601_8 + var_601_2
					end

					if var_601_4.prefab_name ~= "" and arg_598_1.actors_[var_601_4.prefab_name] ~= nil then
						local var_601_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_598_1.actors_[var_601_4.prefab_name].transform, "story_v_side_new_1108409", "1108409146", "story_v_side_new_1108409.awb")

						arg_598_1:RecordAudio("1108409146", var_601_9)
						arg_598_1:RecordAudio("1108409146", var_601_9)
					else
						arg_598_1:AudioAction("play", "voice", "story_v_side_new_1108409", "1108409146", "story_v_side_new_1108409.awb")
					end

					arg_598_1:RecordHistoryTalkVoice("story_v_side_new_1108409", "1108409146", "story_v_side_new_1108409.awb")
				end

				arg_598_1:RecordContent(arg_598_1.text_.text)
			end

			local var_601_10 = math.max(var_601_3, arg_598_1.talkMaxDuration)

			if var_601_2 <= arg_598_1.time_ and arg_598_1.time_ < var_601_2 + var_601_10 then
				arg_598_1.typewritter.percent = (arg_598_1.time_ - var_601_2) / var_601_10

				arg_598_1.typewritter:SetDirty()
			end

			if arg_598_1.time_ >= var_601_2 + var_601_10 and arg_598_1.time_ < var_601_2 + var_601_10 + arg_601_0 then
				arg_598_1.typewritter.percent = 1

				arg_598_1.typewritter:SetDirty()
				arg_598_1:ShowNextGo(true)
			end
		end

		arg_598_1.nodeConfigList_ = {}

		arg_598_1:InitPlayNodeList()
	end,
	Play1108409147 = function(arg_602_0, arg_602_1)
		arg_602_1.time_ = 0
		arg_602_1.frameCnt_ = 0
		arg_602_1.state_ = "playing"
		arg_602_1.curTalkId_ = 1108409147
		arg_602_1.duration_ = 5

		SetActive(arg_602_1.tipsGo_, false)

		function arg_602_1.onSingleLineFinish_()
			arg_602_1.onSingleLineUpdate_ = nil
			arg_602_1.onSingleLineFinish_ = nil
			arg_602_1.state_ = "waiting"
		end

		function arg_602_1.playNext_(arg_604_0)
			if arg_604_0 == 1 then
				arg_602_0:Play1108409148(arg_602_1)
			end
		end

		function arg_602_1.onSingleLineUpdate_(arg_605_0)
			if 0 < arg_602_1.time_ and arg_602_1.time_ <= 0 + arg_605_0 and not isNil(arg_602_1.actors_["1084ui_story"]) and arg_602_1.var_.characterEffect1084ui_story == nil then
				arg_602_1.var_.characterEffect1084ui_story = arg_602_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_605_0 = 0.200000002980232

			if 0 <= arg_602_1.time_ and arg_602_1.time_ < 0 + var_605_0 and not isNil(arg_602_1.actors_["1084ui_story"]) then
				if arg_602_1.var_.characterEffect1084ui_story and not isNil(arg_602_1.actors_["1084ui_story"]) then
					arg_602_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_602_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_602_1.time_ - 0) / var_605_0)
				end
			end

			if arg_602_1.time_ >= 0 + var_605_0 and arg_602_1.time_ < 0 + var_605_0 + arg_605_0 and not isNil(arg_602_1.actors_["1084ui_story"]) and arg_602_1.var_.characterEffect1084ui_story then
				arg_602_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_602_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_605_1 = 0
			local var_605_2 = 0.625

			if 0 < arg_602_1.time_ and arg_602_1.time_ <= var_605_1 + arg_605_0 then
				arg_602_1.talkMaxDuration = 0
				arg_602_1.dialogCg_.alpha = 1

				arg_602_1.dialog_:SetActive(true)
				SetActive(arg_602_1.leftNameGo_, true)

				arg_602_1.leftNameTxt_.text = arg_602_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_602_1.leftNameTxt_.transform)

				arg_602_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_602_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_602_1:RecordName(arg_602_1.leftNameTxt_.text)
				SetActive(arg_602_1.iconTrs_.gameObject, true)
				arg_602_1.iconController_:SetSelectedState("hero")

				arg_602_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_602_1.callingController_:SetSelectedState("normal")

				arg_602_1.keyicon_.color = Color.New(1, 1, 1)
				arg_602_1.icon_.color = Color.New(1, 1, 1)

				local var_605_3 = arg_602_1:FormatText(arg_602_1:GetWordFromCfg(1108409147).content)

				arg_602_1.text_.text = var_605_3

				LuaForUtil.ClearLinePrefixSymbol(arg_602_1.text_)

				local var_605_5 = 25 <= 0 and var_605_2 or var_605_2 * (utf8.len(var_605_3) / 25)

				if (25 <= 0 and var_605_2 or var_605_2 * (utf8.len(var_605_3) / 25)) > 0 and var_605_2 < var_605_5 then
					arg_602_1.talkMaxDuration = var_605_5

					if var_605_5 + var_605_1 > arg_602_1.duration_ then
						arg_602_1.duration_ = var_605_5 + var_605_1
					end
				end

				arg_602_1.text_.text = var_605_3
				arg_602_1.typewritter.percent = 0

				arg_602_1.typewritter:SetDirty()
				arg_602_1:ShowNextGo(false)
				arg_602_1:RecordContent(arg_602_1.text_.text)
			end

			local var_605_6 = math.max(var_605_2, arg_602_1.talkMaxDuration)

			if var_605_1 <= arg_602_1.time_ and arg_602_1.time_ < var_605_1 + var_605_6 then
				arg_602_1.typewritter.percent = (arg_602_1.time_ - var_605_1) / var_605_6

				arg_602_1.typewritter:SetDirty()
			end

			if arg_602_1.time_ >= var_605_1 + var_605_6 and arg_602_1.time_ < var_605_1 + var_605_6 + arg_605_0 then
				arg_602_1.typewritter.percent = 1

				arg_602_1.typewritter:SetDirty()
				arg_602_1:ShowNextGo(true)
			end
		end

		arg_602_1.nodeConfigList_ = {}

		arg_602_1:InitPlayNodeList()
	end,
	Play1108409148 = function(arg_606_0, arg_606_1)
		arg_606_1.time_ = 0
		arg_606_1.frameCnt_ = 0
		arg_606_1.state_ = "playing"
		arg_606_1.curTalkId_ = 1108409148
		arg_606_1.duration_ = 2.7

		SetActive(arg_606_1.tipsGo_, false)

		function arg_606_1.onSingleLineFinish_()
			arg_606_1.onSingleLineUpdate_ = nil
			arg_606_1.onSingleLineFinish_ = nil
			arg_606_1.state_ = "waiting"
		end

		function arg_606_1.playNext_(arg_608_0)
			if arg_608_0 == 1 then
				arg_606_0:Play1108409149(arg_606_1)
			end
		end

		function arg_606_1.onSingleLineUpdate_(arg_609_0)
			if 0 < arg_606_1.time_ and arg_606_1.time_ <= 0 + arg_609_0 and not isNil(arg_606_1.actors_["1084ui_story"]) and arg_606_1.var_.characterEffect1084ui_story == nil then
				arg_606_1.var_.characterEffect1084ui_story = arg_606_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_609_0 = 0.200000002980232

			if 0 <= arg_606_1.time_ and arg_606_1.time_ < 0 + var_609_0 and not isNil(arg_606_1.actors_["1084ui_story"]) then
				if arg_606_1.var_.characterEffect1084ui_story and not isNil(arg_606_1.actors_["1084ui_story"]) then
					arg_606_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_606_1.time_ >= 0 + var_609_0 and arg_606_1.time_ < 0 + var_609_0 + arg_609_0 and not isNil(arg_606_1.actors_["1084ui_story"]) and arg_606_1.var_.characterEffect1084ui_story then
				arg_606_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_606_1.time_ and arg_606_1.time_ <= 0 + arg_609_0 then
				arg_606_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action463")
			end

			if 0 < arg_606_1.time_ and arg_606_1.time_ <= 0 + arg_609_0 then
				arg_606_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_609_2 = 0
			local var_609_3 = 0.25

			if 0 < arg_606_1.time_ and arg_606_1.time_ <= var_609_2 + arg_609_0 then
				arg_606_1.talkMaxDuration = 0
				arg_606_1.dialogCg_.alpha = 1

				arg_606_1.dialog_:SetActive(true)
				SetActive(arg_606_1.leftNameGo_, true)

				arg_606_1.leftNameTxt_.text = arg_606_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_606_1.leftNameTxt_.transform)

				arg_606_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_606_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_606_1:RecordName(arg_606_1.leftNameTxt_.text)
				SetActive(arg_606_1.iconTrs_.gameObject, false)
				arg_606_1.callingController_:SetSelectedState("normal")

				local var_609_4 = arg_606_1:GetWordFromCfg(1108409148)
				local var_609_5 = arg_606_1:FormatText(var_609_4.content)

				arg_606_1.text_.text = var_609_5

				LuaForUtil.ClearLinePrefixSymbol(arg_606_1.text_)

				local var_609_7 = 10 <= 0 and var_609_3 or var_609_3 * (utf8.len(var_609_5) / 10)

				if (10 <= 0 and var_609_3 or var_609_3 * (utf8.len(var_609_5) / 10)) > 0 and var_609_3 < var_609_7 then
					arg_606_1.talkMaxDuration = var_609_7

					if var_609_7 + var_609_2 > arg_606_1.duration_ then
						arg_606_1.duration_ = var_609_7 + var_609_2
					end
				end

				arg_606_1.text_.text = var_609_5
				arg_606_1.typewritter.percent = 0

				arg_606_1.typewritter:SetDirty()
				arg_606_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409148", "story_v_side_new_1108409.awb") ~= 0 then
					local var_609_8 = manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409148", "story_v_side_new_1108409.awb") / 1000

					if var_609_8 + var_609_2 > arg_606_1.duration_ then
						arg_606_1.duration_ = var_609_8 + var_609_2
					end

					if var_609_4.prefab_name ~= "" and arg_606_1.actors_[var_609_4.prefab_name] ~= nil then
						local var_609_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_606_1.actors_[var_609_4.prefab_name].transform, "story_v_side_new_1108409", "1108409148", "story_v_side_new_1108409.awb")

						arg_606_1:RecordAudio("1108409148", var_609_9)
						arg_606_1:RecordAudio("1108409148", var_609_9)
					else
						arg_606_1:AudioAction("play", "voice", "story_v_side_new_1108409", "1108409148", "story_v_side_new_1108409.awb")
					end

					arg_606_1:RecordHistoryTalkVoice("story_v_side_new_1108409", "1108409148", "story_v_side_new_1108409.awb")
				end

				arg_606_1:RecordContent(arg_606_1.text_.text)
			end

			local var_609_10 = math.max(var_609_3, arg_606_1.talkMaxDuration)

			if var_609_2 <= arg_606_1.time_ and arg_606_1.time_ < var_609_2 + var_609_10 then
				arg_606_1.typewritter.percent = (arg_606_1.time_ - var_609_2) / var_609_10

				arg_606_1.typewritter:SetDirty()
			end

			if arg_606_1.time_ >= var_609_2 + var_609_10 and arg_606_1.time_ < var_609_2 + var_609_10 + arg_609_0 then
				arg_606_1.typewritter.percent = 1

				arg_606_1.typewritter:SetDirty()
				arg_606_1:ShowNextGo(true)
			end
		end

		arg_606_1.nodeConfigList_ = {}

		arg_606_1:InitPlayNodeList()
	end,
	Play1108409149 = function(arg_610_0, arg_610_1)
		arg_610_1.time_ = 0
		arg_610_1.frameCnt_ = 0
		arg_610_1.state_ = "playing"
		arg_610_1.curTalkId_ = 1108409149
		arg_610_1.duration_ = 5

		SetActive(arg_610_1.tipsGo_, false)

		function arg_610_1.onSingleLineFinish_()
			arg_610_1.onSingleLineUpdate_ = nil
			arg_610_1.onSingleLineFinish_ = nil
			arg_610_1.state_ = "waiting"
		end

		function arg_610_1.playNext_(arg_612_0)
			if arg_612_0 == 1 then
				arg_610_0:Play1108409150(arg_610_1)
			end
		end

		function arg_610_1.onSingleLineUpdate_(arg_613_0)
			if 0 < arg_610_1.time_ and arg_610_1.time_ <= 0 + arg_613_0 and not isNil(arg_610_1.actors_["1084ui_story"]) and arg_610_1.var_.characterEffect1084ui_story == nil then
				arg_610_1.var_.characterEffect1084ui_story = arg_610_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_613_0 = 0.200000002980232

			if 0 <= arg_610_1.time_ and arg_610_1.time_ < 0 + var_613_0 and not isNil(arg_610_1.actors_["1084ui_story"]) then
				if arg_610_1.var_.characterEffect1084ui_story and not isNil(arg_610_1.actors_["1084ui_story"]) then
					arg_610_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_610_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_610_1.time_ - 0) / var_613_0)
				end
			end

			if arg_610_1.time_ >= 0 + var_613_0 and arg_610_1.time_ < 0 + var_613_0 + arg_613_0 and not isNil(arg_610_1.actors_["1084ui_story"]) and arg_610_1.var_.characterEffect1084ui_story then
				arg_610_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_610_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_613_1 = 0
			local var_613_2 = 0.15

			if 0 < arg_610_1.time_ and arg_610_1.time_ <= var_613_1 + arg_613_0 then
				arg_610_1.talkMaxDuration = 0
				arg_610_1.dialogCg_.alpha = 1

				arg_610_1.dialog_:SetActive(true)
				SetActive(arg_610_1.leftNameGo_, true)

				arg_610_1.leftNameTxt_.text = arg_610_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_610_1.leftNameTxt_.transform)

				arg_610_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_610_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_610_1:RecordName(arg_610_1.leftNameTxt_.text)
				SetActive(arg_610_1.iconTrs_.gameObject, true)
				arg_610_1.iconController_:SetSelectedState("hero")

				arg_610_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_610_1.callingController_:SetSelectedState("normal")

				arg_610_1.keyicon_.color = Color.New(1, 1, 1)
				arg_610_1.icon_.color = Color.New(1, 1, 1)

				local var_613_3 = arg_610_1:FormatText(arg_610_1:GetWordFromCfg(1108409149).content)

				arg_610_1.text_.text = var_613_3

				LuaForUtil.ClearLinePrefixSymbol(arg_610_1.text_)

				local var_613_5 = 6 <= 0 and var_613_2 or var_613_2 * (utf8.len(var_613_3) / 6)

				if (6 <= 0 and var_613_2 or var_613_2 * (utf8.len(var_613_3) / 6)) > 0 and var_613_2 < var_613_5 then
					arg_610_1.talkMaxDuration = var_613_5

					if var_613_5 + var_613_1 > arg_610_1.duration_ then
						arg_610_1.duration_ = var_613_5 + var_613_1
					end
				end

				arg_610_1.text_.text = var_613_3
				arg_610_1.typewritter.percent = 0

				arg_610_1.typewritter:SetDirty()
				arg_610_1:ShowNextGo(false)
				arg_610_1:RecordContent(arg_610_1.text_.text)
			end

			local var_613_6 = math.max(var_613_2, arg_610_1.talkMaxDuration)

			if var_613_1 <= arg_610_1.time_ and arg_610_1.time_ < var_613_1 + var_613_6 then
				arg_610_1.typewritter.percent = (arg_610_1.time_ - var_613_1) / var_613_6

				arg_610_1.typewritter:SetDirty()
			end

			if arg_610_1.time_ >= var_613_1 + var_613_6 and arg_610_1.time_ < var_613_1 + var_613_6 + arg_613_0 then
				arg_610_1.typewritter.percent = 1

				arg_610_1.typewritter:SetDirty()
				arg_610_1:ShowNextGo(true)
			end
		end

		arg_610_1.nodeConfigList_ = {}

		arg_610_1:InitPlayNodeList()
	end,
	Play1108409150 = function(arg_614_0, arg_614_1)
		arg_614_1.time_ = 0
		arg_614_1.frameCnt_ = 0
		arg_614_1.state_ = "playing"
		arg_614_1.curTalkId_ = 1108409150
		arg_614_1.duration_ = 2.2

		SetActive(arg_614_1.tipsGo_, false)

		function arg_614_1.onSingleLineFinish_()
			arg_614_1.onSingleLineUpdate_ = nil
			arg_614_1.onSingleLineFinish_ = nil
			arg_614_1.state_ = "waiting"
		end

		function arg_614_1.playNext_(arg_616_0)
			if arg_616_0 == 1 then
				arg_614_0:Play1108409151(arg_614_1)
			end
		end

		function arg_614_1.onSingleLineUpdate_(arg_617_0)
			if 0 < arg_614_1.time_ and arg_614_1.time_ <= 0 + arg_617_0 and not isNil(arg_614_1.actors_["1084ui_story"]) and arg_614_1.var_.characterEffect1084ui_story == nil then
				arg_614_1.var_.characterEffect1084ui_story = arg_614_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_617_0 = 0.200000002980232

			if 0 <= arg_614_1.time_ and arg_614_1.time_ < 0 + var_617_0 and not isNil(arg_614_1.actors_["1084ui_story"]) then
				if arg_614_1.var_.characterEffect1084ui_story and not isNil(arg_614_1.actors_["1084ui_story"]) then
					arg_614_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_614_1.time_ >= 0 + var_617_0 and arg_614_1.time_ < 0 + var_617_0 + arg_617_0 and not isNil(arg_614_1.actors_["1084ui_story"]) and arg_614_1.var_.characterEffect1084ui_story then
				arg_614_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_614_1.time_ and arg_614_1.time_ <= 0 + arg_617_0 then
				arg_614_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_2")
			end

			if 0 < arg_614_1.time_ and arg_614_1.time_ <= 0 + arg_617_0 then
				arg_614_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_617_2 = 0
			local var_617_3 = 0.2

			if 0 < arg_614_1.time_ and arg_614_1.time_ <= var_617_2 + arg_617_0 then
				arg_614_1.talkMaxDuration = 0
				arg_614_1.dialogCg_.alpha = 1

				arg_614_1.dialog_:SetActive(true)
				SetActive(arg_614_1.leftNameGo_, true)

				arg_614_1.leftNameTxt_.text = arg_614_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_614_1.leftNameTxt_.transform)

				arg_614_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_614_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_614_1:RecordName(arg_614_1.leftNameTxt_.text)
				SetActive(arg_614_1.iconTrs_.gameObject, false)
				arg_614_1.callingController_:SetSelectedState("normal")

				local var_617_4 = arg_614_1:GetWordFromCfg(1108409150)
				local var_617_5 = arg_614_1:FormatText(var_617_4.content)

				arg_614_1.text_.text = var_617_5

				LuaForUtil.ClearLinePrefixSymbol(arg_614_1.text_)

				local var_617_7 = 8 <= 0 and var_617_3 or var_617_3 * (utf8.len(var_617_5) / 8)

				if (8 <= 0 and var_617_3 or var_617_3 * (utf8.len(var_617_5) / 8)) > 0 and var_617_3 < var_617_7 then
					arg_614_1.talkMaxDuration = var_617_7

					if var_617_7 + var_617_2 > arg_614_1.duration_ then
						arg_614_1.duration_ = var_617_7 + var_617_2
					end
				end

				arg_614_1.text_.text = var_617_5
				arg_614_1.typewritter.percent = 0

				arg_614_1.typewritter:SetDirty()
				arg_614_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409150", "story_v_side_new_1108409.awb") ~= 0 then
					local var_617_8 = manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409150", "story_v_side_new_1108409.awb") / 1000

					if var_617_8 + var_617_2 > arg_614_1.duration_ then
						arg_614_1.duration_ = var_617_8 + var_617_2
					end

					if var_617_4.prefab_name ~= "" and arg_614_1.actors_[var_617_4.prefab_name] ~= nil then
						local var_617_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_614_1.actors_[var_617_4.prefab_name].transform, "story_v_side_new_1108409", "1108409150", "story_v_side_new_1108409.awb")

						arg_614_1:RecordAudio("1108409150", var_617_9)
						arg_614_1:RecordAudio("1108409150", var_617_9)
					else
						arg_614_1:AudioAction("play", "voice", "story_v_side_new_1108409", "1108409150", "story_v_side_new_1108409.awb")
					end

					arg_614_1:RecordHistoryTalkVoice("story_v_side_new_1108409", "1108409150", "story_v_side_new_1108409.awb")
				end

				arg_614_1:RecordContent(arg_614_1.text_.text)
			end

			local var_617_10 = math.max(var_617_3, arg_614_1.talkMaxDuration)

			if var_617_2 <= arg_614_1.time_ and arg_614_1.time_ < var_617_2 + var_617_10 then
				arg_614_1.typewritter.percent = (arg_614_1.time_ - var_617_2) / var_617_10

				arg_614_1.typewritter:SetDirty()
			end

			if arg_614_1.time_ >= var_617_2 + var_617_10 and arg_614_1.time_ < var_617_2 + var_617_10 + arg_617_0 then
				arg_614_1.typewritter.percent = 1

				arg_614_1.typewritter:SetDirty()
				arg_614_1:ShowNextGo(true)
			end
		end

		arg_614_1.nodeConfigList_ = {}

		arg_614_1:InitPlayNodeList()
	end,
	Play1108409151 = function(arg_618_0, arg_618_1)
		arg_618_1.time_ = 0
		arg_618_1.frameCnt_ = 0
		arg_618_1.state_ = "playing"
		arg_618_1.curTalkId_ = 1108409151
		arg_618_1.duration_ = 5

		SetActive(arg_618_1.tipsGo_, false)

		function arg_618_1.onSingleLineFinish_()
			arg_618_1.onSingleLineUpdate_ = nil
			arg_618_1.onSingleLineFinish_ = nil
			arg_618_1.state_ = "waiting"
		end

		function arg_618_1.playNext_(arg_620_0)
			if arg_620_0 == 1 then
				arg_618_0:Play1108409152(arg_618_1)
			end
		end

		function arg_618_1.onSingleLineUpdate_(arg_621_0)
			if 0 < arg_618_1.time_ and arg_618_1.time_ <= 0 + arg_621_0 then
				arg_618_1.var_.moveOldPos1084ui_story = arg_618_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_621_0 = 0.001

			if 0 <= arg_618_1.time_ and arg_618_1.time_ < 0 + var_621_0 then
				arg_618_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_618_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_618_1.time_ - 0) / var_621_0)
				arg_618_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_618_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_618_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_618_1.actors_["1084ui_story"].transform.position).z)
				arg_618_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_618_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_618_1.actors_["1084ui_story"].transform.localEulerAngles = arg_618_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_618_1.time_ >= 0 + var_621_0 and arg_618_1.time_ < 0 + var_621_0 + arg_621_0 then
				arg_618_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_618_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_618_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_618_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_618_1.actors_["1084ui_story"].transform.position).z)
				arg_618_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_618_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_618_1.actors_["1084ui_story"].transform.localEulerAngles = arg_618_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_621_1 = arg_618_1.actors_["1084ui_story"]

			if 0 < arg_618_1.time_ and arg_618_1.time_ <= 0 + arg_621_0 and not isNil(var_621_1) and arg_618_1.var_.characterEffect1084ui_story == nil then
				arg_618_1.var_.characterEffect1084ui_story = var_621_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_621_2 = 0.200000002980232

			if 0 <= arg_618_1.time_ and arg_618_1.time_ < 0 + var_621_2 and not isNil(var_621_1) then
				if arg_618_1.var_.characterEffect1084ui_story and not isNil(var_621_1) then
					arg_618_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_618_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_618_1.time_ - 0) / var_621_2)
				end
			end

			if arg_618_1.time_ >= 0 + var_621_2 and arg_618_1.time_ < 0 + var_621_2 + arg_621_0 and not isNil(var_621_1) and arg_618_1.var_.characterEffect1084ui_story then
				arg_618_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_618_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_621_3 = 0
			local var_621_4 = 0.5

			if 0 < arg_618_1.time_ and arg_618_1.time_ <= var_621_3 + arg_621_0 then
				arg_618_1.talkMaxDuration = 0
				arg_618_1.dialogCg_.alpha = 1

				arg_618_1.dialog_:SetActive(true)
				SetActive(arg_618_1.leftNameGo_, false)

				arg_618_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_618_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_618_1:RecordName(arg_618_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_618_1.iconTrs_.gameObject, false)
				arg_618_1.callingController_:SetSelectedState("normal")

				local var_621_5 = arg_618_1:FormatText(arg_618_1:GetWordFromCfg(1108409151).content)

				arg_618_1.text_.text = var_621_5

				LuaForUtil.ClearLinePrefixSymbol(arg_618_1.text_)

				local var_621_7 = 20 <= 0 and var_621_4 or var_621_4 * (utf8.len(var_621_5) / 20)

				if (20 <= 0 and var_621_4 or var_621_4 * (utf8.len(var_621_5) / 20)) > 0 and var_621_4 < var_621_7 then
					arg_618_1.talkMaxDuration = var_621_7

					if var_621_7 + var_621_3 > arg_618_1.duration_ then
						arg_618_1.duration_ = var_621_7 + var_621_3
					end
				end

				arg_618_1.text_.text = var_621_5
				arg_618_1.typewritter.percent = 0

				arg_618_1.typewritter:SetDirty()
				arg_618_1:ShowNextGo(false)
				arg_618_1:RecordContent(arg_618_1.text_.text)
			end

			local var_621_8 = math.max(var_621_4, arg_618_1.talkMaxDuration)

			if var_621_3 <= arg_618_1.time_ and arg_618_1.time_ < var_621_3 + var_621_8 then
				arg_618_1.typewritter.percent = (arg_618_1.time_ - var_621_3) / var_621_8

				arg_618_1.typewritter:SetDirty()
			end

			if arg_618_1.time_ >= var_621_3 + var_621_8 and arg_618_1.time_ < var_621_3 + var_621_8 + arg_621_0 then
				arg_618_1.typewritter.percent = 1

				arg_618_1.typewritter:SetDirty()
				arg_618_1:ShowNextGo(true)
			end
		end

		arg_618_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_618_1:InitPlayNodeList()
	end,
	Play1108409152 = function(arg_622_0, arg_622_1)
		arg_622_1.time_ = 0
		arg_622_1.frameCnt_ = 0
		arg_622_1.state_ = "playing"
		arg_622_1.curTalkId_ = 1108409152
		arg_622_1.duration_ = 4.3

		SetActive(arg_622_1.tipsGo_, false)

		function arg_622_1.onSingleLineFinish_()
			arg_622_1.onSingleLineUpdate_ = nil
			arg_622_1.onSingleLineFinish_ = nil
			arg_622_1.state_ = "waiting"
		end

		function arg_622_1.playNext_(arg_624_0)
			if arg_624_0 == 1 then
				arg_622_0:Play1108409153(arg_622_1)
			end
		end

		function arg_622_1.onSingleLineUpdate_(arg_625_0)
			local var_625_0 = 0.45

			if 0 < arg_622_1.time_ and arg_622_1.time_ <= 0 + arg_625_0 then
				arg_622_1.talkMaxDuration = 0
				arg_622_1.dialogCg_.alpha = 1

				arg_622_1.dialog_:SetActive(true)
				SetActive(arg_622_1.leftNameGo_, true)

				arg_622_1.leftNameTxt_.text = arg_622_1:FormatText(StoryNameCfg[426].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_622_1.leftNameTxt_.transform)

				arg_622_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_622_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_622_1:RecordName(arg_622_1.leftNameTxt_.text)
				SetActive(arg_622_1.iconTrs_.gameObject, true)
				arg_622_1.iconController_:SetSelectedState("hero")

				arg_622_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwc")

				arg_622_1.callingController_:SetSelectedState("normal")

				arg_622_1.keyicon_.color = Color.New(1, 1, 1)
				arg_622_1.icon_.color = Color.New(1, 1, 1)

				local var_625_1 = arg_622_1:GetWordFromCfg(1108409152)
				local var_625_2 = arg_622_1:FormatText(var_625_1.content)

				arg_622_1.text_.text = var_625_2

				LuaForUtil.ClearLinePrefixSymbol(arg_622_1.text_)

				local var_625_4 = 18 <= 0 and var_625_0 or var_625_0 * (utf8.len(var_625_2) / 18)

				if (18 <= 0 and var_625_0 or var_625_0 * (utf8.len(var_625_2) / 18)) > 0 and var_625_0 < var_625_4 then
					arg_622_1.talkMaxDuration = var_625_4

					if var_625_4 + 0 > arg_622_1.duration_ then
						arg_622_1.duration_ = var_625_4 + 0
					end
				end

				arg_622_1.text_.text = var_625_2
				arg_622_1.typewritter.percent = 0

				arg_622_1.typewritter:SetDirty()
				arg_622_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409152", "story_v_side_new_1108409.awb") ~= 0 then
					local var_625_5 = manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409152", "story_v_side_new_1108409.awb") / 1000

					if var_625_5 + 0 > arg_622_1.duration_ then
						arg_622_1.duration_ = var_625_5 + 0
					end

					if var_625_1.prefab_name ~= "" and arg_622_1.actors_[var_625_1.prefab_name] ~= nil then
						local var_625_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_622_1.actors_[var_625_1.prefab_name].transform, "story_v_side_new_1108409", "1108409152", "story_v_side_new_1108409.awb")

						arg_622_1:RecordAudio("1108409152", var_625_6)
						arg_622_1:RecordAudio("1108409152", var_625_6)
					else
						arg_622_1:AudioAction("play", "voice", "story_v_side_new_1108409", "1108409152", "story_v_side_new_1108409.awb")
					end

					arg_622_1:RecordHistoryTalkVoice("story_v_side_new_1108409", "1108409152", "story_v_side_new_1108409.awb")
				end

				arg_622_1:RecordContent(arg_622_1.text_.text)
			end

			local var_625_7 = math.max(var_625_0, arg_622_1.talkMaxDuration)

			if 0 <= arg_622_1.time_ and arg_622_1.time_ < 0 + var_625_7 then
				arg_622_1.typewritter.percent = (arg_622_1.time_ - 0) / var_625_7

				arg_622_1.typewritter:SetDirty()
			end

			if arg_622_1.time_ >= 0 + var_625_7 and arg_622_1.time_ < 0 + var_625_7 + arg_625_0 then
				arg_622_1.typewritter.percent = 1

				arg_622_1.typewritter:SetDirty()
				arg_622_1:ShowNextGo(true)
			end
		end

		arg_622_1.nodeConfigList_ = {}

		arg_622_1:InitPlayNodeList()
	end,
	Play1108409153 = function(arg_626_0, arg_626_1)
		arg_626_1.time_ = 0
		arg_626_1.frameCnt_ = 0
		arg_626_1.state_ = "playing"
		arg_626_1.curTalkId_ = 1108409153
		arg_626_1.duration_ = 5

		SetActive(arg_626_1.tipsGo_, false)

		function arg_626_1.onSingleLineFinish_()
			arg_626_1.onSingleLineUpdate_ = nil
			arg_626_1.onSingleLineFinish_ = nil
			arg_626_1.state_ = "waiting"
		end

		function arg_626_1.playNext_(arg_628_0)
			if arg_628_0 == 1 then
				arg_626_0:Play1108409154(arg_626_1)
			end
		end

		function arg_626_1.onSingleLineUpdate_(arg_629_0)
			local var_629_0 = 1.275

			if 0 < arg_626_1.time_ and arg_626_1.time_ <= 0 + arg_629_0 then
				arg_626_1.talkMaxDuration = 0
				arg_626_1.dialogCg_.alpha = 1

				arg_626_1.dialog_:SetActive(true)
				SetActive(arg_626_1.leftNameGo_, false)

				arg_626_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_626_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_626_1:RecordName(arg_626_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_626_1.iconTrs_.gameObject, false)
				arg_626_1.callingController_:SetSelectedState("normal")

				local var_629_1 = arg_626_1:FormatText(arg_626_1:GetWordFromCfg(1108409153).content)

				arg_626_1.text_.text = var_629_1

				LuaForUtil.ClearLinePrefixSymbol(arg_626_1.text_)

				local var_629_3 = 51 <= 0 and var_629_0 or var_629_0 * (utf8.len(var_629_1) / 51)

				if (51 <= 0 and var_629_0 or var_629_0 * (utf8.len(var_629_1) / 51)) > 0 and var_629_0 < var_629_3 then
					arg_626_1.talkMaxDuration = var_629_3

					if var_629_3 + 0 > arg_626_1.duration_ then
						arg_626_1.duration_ = var_629_3 + 0
					end
				end

				arg_626_1.text_.text = var_629_1
				arg_626_1.typewritter.percent = 0

				arg_626_1.typewritter:SetDirty()
				arg_626_1:ShowNextGo(false)
				arg_626_1:RecordContent(arg_626_1.text_.text)
			end

			local var_629_4 = math.max(var_629_0, arg_626_1.talkMaxDuration)

			if 0 <= arg_626_1.time_ and arg_626_1.time_ < 0 + var_629_4 then
				arg_626_1.typewritter.percent = (arg_626_1.time_ - 0) / var_629_4

				arg_626_1.typewritter:SetDirty()
			end

			if arg_626_1.time_ >= 0 + var_629_4 and arg_626_1.time_ < 0 + var_629_4 + arg_629_0 then
				arg_626_1.typewritter.percent = 1

				arg_626_1.typewritter:SetDirty()
				arg_626_1:ShowNextGo(true)
			end
		end

		arg_626_1.nodeConfigList_ = {}

		arg_626_1:InitPlayNodeList()
	end,
	Play1108409154 = function(arg_630_0, arg_630_1)
		arg_630_1.time_ = 0
		arg_630_1.frameCnt_ = 0
		arg_630_1.state_ = "playing"
		arg_630_1.curTalkId_ = 1108409154
		arg_630_1.duration_ = 5

		SetActive(arg_630_1.tipsGo_, false)

		function arg_630_1.onSingleLineFinish_()
			arg_630_1.onSingleLineUpdate_ = nil
			arg_630_1.onSingleLineFinish_ = nil
			arg_630_1.state_ = "waiting"
		end

		function arg_630_1.playNext_(arg_632_0)
			if arg_632_0 == 1 then
				arg_630_0:Play1108409155(arg_630_1)
			end
		end

		function arg_630_1.onSingleLineUpdate_(arg_633_0)
			local var_633_0 = 0.25

			if 0 < arg_630_1.time_ and arg_630_1.time_ <= 0 + arg_633_0 then
				arg_630_1.talkMaxDuration = 0
				arg_630_1.dialogCg_.alpha = 1

				arg_630_1.dialog_:SetActive(true)
				SetActive(arg_630_1.leftNameGo_, true)

				arg_630_1.leftNameTxt_.text = arg_630_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_630_1.leftNameTxt_.transform)

				arg_630_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_630_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_630_1:RecordName(arg_630_1.leftNameTxt_.text)
				SetActive(arg_630_1.iconTrs_.gameObject, true)
				arg_630_1.iconController_:SetSelectedState("hero")

				arg_630_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_630_1.callingController_:SetSelectedState("normal")

				arg_630_1.keyicon_.color = Color.New(1, 1, 1)
				arg_630_1.icon_.color = Color.New(1, 1, 1)

				local var_633_1 = arg_630_1:FormatText(arg_630_1:GetWordFromCfg(1108409154).content)

				arg_630_1.text_.text = var_633_1

				LuaForUtil.ClearLinePrefixSymbol(arg_630_1.text_)

				local var_633_3 = 10 <= 0 and var_633_0 or var_633_0 * (utf8.len(var_633_1) / 10)

				if (10 <= 0 and var_633_0 or var_633_0 * (utf8.len(var_633_1) / 10)) > 0 and var_633_0 < var_633_3 then
					arg_630_1.talkMaxDuration = var_633_3

					if var_633_3 + 0 > arg_630_1.duration_ then
						arg_630_1.duration_ = var_633_3 + 0
					end
				end

				arg_630_1.text_.text = var_633_1
				arg_630_1.typewritter.percent = 0

				arg_630_1.typewritter:SetDirty()
				arg_630_1:ShowNextGo(false)
				arg_630_1:RecordContent(arg_630_1.text_.text)
			end

			local var_633_4 = math.max(var_633_0, arg_630_1.talkMaxDuration)

			if 0 <= arg_630_1.time_ and arg_630_1.time_ < 0 + var_633_4 then
				arg_630_1.typewritter.percent = (arg_630_1.time_ - 0) / var_633_4

				arg_630_1.typewritter:SetDirty()
			end

			if arg_630_1.time_ >= 0 + var_633_4 and arg_630_1.time_ < 0 + var_633_4 + arg_633_0 then
				arg_630_1.typewritter.percent = 1

				arg_630_1.typewritter:SetDirty()
				arg_630_1:ShowNextGo(true)
			end
		end

		arg_630_1.nodeConfigList_ = {}

		arg_630_1:InitPlayNodeList()
	end,
	Play1108409155 = function(arg_634_0, arg_634_1)
		arg_634_1.time_ = 0
		arg_634_1.frameCnt_ = 0
		arg_634_1.state_ = "playing"
		arg_634_1.curTalkId_ = 1108409155
		arg_634_1.duration_ = 1.27

		SetActive(arg_634_1.tipsGo_, false)

		function arg_634_1.onSingleLineFinish_()
			arg_634_1.onSingleLineUpdate_ = nil
			arg_634_1.onSingleLineFinish_ = nil
			arg_634_1.state_ = "waiting"
		end

		function arg_634_1.playNext_(arg_636_0)
			if arg_636_0 == 1 then
				arg_634_0:Play1108409156(arg_634_1)
			end
		end

		function arg_634_1.onSingleLineUpdate_(arg_637_0)
			if 0 < arg_634_1.time_ and arg_634_1.time_ <= 0 + arg_637_0 then
				arg_634_1.var_.moveOldPos1084ui_story = arg_634_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_637_0 = 0.001

			if 0 <= arg_634_1.time_ and arg_634_1.time_ < 0 + var_637_0 then
				arg_634_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_634_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_634_1.time_ - 0) / var_637_0)
				arg_634_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_634_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_634_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_634_1.actors_["1084ui_story"].transform.position).z)
				arg_634_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_634_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_634_1.actors_["1084ui_story"].transform.localEulerAngles = arg_634_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_634_1.time_ >= 0 + var_637_0 and arg_634_1.time_ < 0 + var_637_0 + arg_637_0 then
				arg_634_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_634_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_634_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_634_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_634_1.actors_["1084ui_story"].transform.position).z)
				arg_634_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_634_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_634_1.actors_["1084ui_story"].transform.localEulerAngles = arg_634_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_637_1 = arg_634_1.actors_["1084ui_story"]

			if 0 < arg_634_1.time_ and arg_634_1.time_ <= 0 + arg_637_0 and not isNil(var_637_1) and arg_634_1.var_.characterEffect1084ui_story == nil then
				arg_634_1.var_.characterEffect1084ui_story = var_637_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_637_2 = 0.200000002980232

			if 0 <= arg_634_1.time_ and arg_634_1.time_ < 0 + var_637_2 and not isNil(var_637_1) then
				if arg_634_1.var_.characterEffect1084ui_story and not isNil(var_637_1) then
					arg_634_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_634_1.time_ >= 0 + var_637_2 and arg_634_1.time_ < 0 + var_637_2 + arg_637_0 and not isNil(var_637_1) and arg_634_1.var_.characterEffect1084ui_story then
				arg_634_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_634_1.time_ and arg_634_1.time_ <= 0 + arg_637_0 then
				arg_634_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			if 0 < arg_634_1.time_ and arg_634_1.time_ <= 0 + arg_637_0 then
				arg_634_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_637_4 = 0
			local var_637_5 = 0.15

			if 0 < arg_634_1.time_ and arg_634_1.time_ <= var_637_4 + arg_637_0 then
				arg_634_1.talkMaxDuration = 0
				arg_634_1.dialogCg_.alpha = 1

				arg_634_1.dialog_:SetActive(true)
				SetActive(arg_634_1.leftNameGo_, true)

				arg_634_1.leftNameTxt_.text = arg_634_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_634_1.leftNameTxt_.transform)

				arg_634_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_634_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_634_1:RecordName(arg_634_1.leftNameTxt_.text)
				SetActive(arg_634_1.iconTrs_.gameObject, false)
				arg_634_1.callingController_:SetSelectedState("normal")

				local var_637_6 = arg_634_1:GetWordFromCfg(1108409155)
				local var_637_7 = arg_634_1:FormatText(var_637_6.content)

				arg_634_1.text_.text = var_637_7

				LuaForUtil.ClearLinePrefixSymbol(arg_634_1.text_)

				local var_637_9 = 6 <= 0 and var_637_5 or var_637_5 * (utf8.len(var_637_7) / 6)

				if (6 <= 0 and var_637_5 or var_637_5 * (utf8.len(var_637_7) / 6)) > 0 and var_637_5 < var_637_9 then
					arg_634_1.talkMaxDuration = var_637_9

					if var_637_9 + var_637_4 > arg_634_1.duration_ then
						arg_634_1.duration_ = var_637_9 + var_637_4
					end
				end

				arg_634_1.text_.text = var_637_7
				arg_634_1.typewritter.percent = 0

				arg_634_1.typewritter:SetDirty()
				arg_634_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409155", "story_v_side_new_1108409.awb") ~= 0 then
					local var_637_10 = manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409155", "story_v_side_new_1108409.awb") / 1000

					if var_637_10 + var_637_4 > arg_634_1.duration_ then
						arg_634_1.duration_ = var_637_10 + var_637_4
					end

					if var_637_6.prefab_name ~= "" and arg_634_1.actors_[var_637_6.prefab_name] ~= nil then
						local var_637_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_634_1.actors_[var_637_6.prefab_name].transform, "story_v_side_new_1108409", "1108409155", "story_v_side_new_1108409.awb")

						arg_634_1:RecordAudio("1108409155", var_637_11)
						arg_634_1:RecordAudio("1108409155", var_637_11)
					else
						arg_634_1:AudioAction("play", "voice", "story_v_side_new_1108409", "1108409155", "story_v_side_new_1108409.awb")
					end

					arg_634_1:RecordHistoryTalkVoice("story_v_side_new_1108409", "1108409155", "story_v_side_new_1108409.awb")
				end

				arg_634_1:RecordContent(arg_634_1.text_.text)
			end

			local var_637_12 = math.max(var_637_5, arg_634_1.talkMaxDuration)

			if var_637_4 <= arg_634_1.time_ and arg_634_1.time_ < var_637_4 + var_637_12 then
				arg_634_1.typewritter.percent = (arg_634_1.time_ - var_637_4) / var_637_12

				arg_634_1.typewritter:SetDirty()
			end

			if arg_634_1.time_ >= var_637_4 + var_637_12 and arg_634_1.time_ < var_637_4 + var_637_12 + arg_637_0 then
				arg_634_1.typewritter.percent = 1

				arg_634_1.typewritter:SetDirty()
				arg_634_1:ShowNextGo(true)
			end
		end

		arg_634_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_634_1:InitPlayNodeList()
	end,
	Play1108409156 = function(arg_638_0, arg_638_1)
		arg_638_1.time_ = 0
		arg_638_1.frameCnt_ = 0
		arg_638_1.state_ = "playing"
		arg_638_1.curTalkId_ = 1108409156
		arg_638_1.duration_ = 5.3

		SetActive(arg_638_1.tipsGo_, false)

		function arg_638_1.onSingleLineFinish_()
			arg_638_1.onSingleLineUpdate_ = nil
			arg_638_1.onSingleLineFinish_ = nil
			arg_638_1.state_ = "waiting"
		end

		function arg_638_1.playNext_(arg_640_0)
			if arg_640_0 == 1 then
				arg_638_0:Play1108409157(arg_638_1)
			end
		end

		function arg_638_1.onSingleLineUpdate_(arg_641_0)
			if 0 < arg_638_1.time_ and arg_638_1.time_ <= 0 + arg_641_0 then
				arg_638_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			if 0 < arg_638_1.time_ and arg_638_1.time_ <= 0 + arg_641_0 then
				arg_638_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_641_0 = 0
			local var_641_1 = 0.15

			if 0 < arg_638_1.time_ and arg_638_1.time_ <= var_641_0 + arg_641_0 then
				arg_638_1.talkMaxDuration = 0
				arg_638_1.dialogCg_.alpha = 1

				arg_638_1.dialog_:SetActive(true)
				SetActive(arg_638_1.leftNameGo_, true)

				arg_638_1.leftNameTxt_.text = arg_638_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_638_1.leftNameTxt_.transform)

				arg_638_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_638_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_638_1:RecordName(arg_638_1.leftNameTxt_.text)
				SetActive(arg_638_1.iconTrs_.gameObject, false)
				arg_638_1.callingController_:SetSelectedState("normal")

				local var_641_2 = arg_638_1:GetWordFromCfg(1108409156)
				local var_641_3 = arg_638_1:FormatText(var_641_2.content)

				arg_638_1.text_.text = var_641_3

				LuaForUtil.ClearLinePrefixSymbol(arg_638_1.text_)

				local var_641_5 = 6 <= 0 and var_641_1 or var_641_1 * (utf8.len(var_641_3) / 6)

				if (6 <= 0 and var_641_1 or var_641_1 * (utf8.len(var_641_3) / 6)) > 0 and var_641_1 < var_641_5 then
					arg_638_1.talkMaxDuration = var_641_5

					if var_641_5 + var_641_0 > arg_638_1.duration_ then
						arg_638_1.duration_ = var_641_5 + var_641_0
					end
				end

				arg_638_1.text_.text = var_641_3
				arg_638_1.typewritter.percent = 0

				arg_638_1.typewritter:SetDirty()
				arg_638_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409156", "story_v_side_new_1108409.awb") ~= 0 then
					local var_641_6 = manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409156", "story_v_side_new_1108409.awb") / 1000

					if var_641_6 + var_641_0 > arg_638_1.duration_ then
						arg_638_1.duration_ = var_641_6 + var_641_0
					end

					if var_641_2.prefab_name ~= "" and arg_638_1.actors_[var_641_2.prefab_name] ~= nil then
						local var_641_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_638_1.actors_[var_641_2.prefab_name].transform, "story_v_side_new_1108409", "1108409156", "story_v_side_new_1108409.awb")

						arg_638_1:RecordAudio("1108409156", var_641_7)
						arg_638_1:RecordAudio("1108409156", var_641_7)
					else
						arg_638_1:AudioAction("play", "voice", "story_v_side_new_1108409", "1108409156", "story_v_side_new_1108409.awb")
					end

					arg_638_1:RecordHistoryTalkVoice("story_v_side_new_1108409", "1108409156", "story_v_side_new_1108409.awb")
				end

				arg_638_1:RecordContent(arg_638_1.text_.text)
			end

			local var_641_8 = math.max(var_641_1, arg_638_1.talkMaxDuration)

			if var_641_0 <= arg_638_1.time_ and arg_638_1.time_ < var_641_0 + var_641_8 then
				arg_638_1.typewritter.percent = (arg_638_1.time_ - var_641_0) / var_641_8

				arg_638_1.typewritter:SetDirty()
			end

			if arg_638_1.time_ >= var_641_0 + var_641_8 and arg_638_1.time_ < var_641_0 + var_641_8 + arg_641_0 then
				arg_638_1.typewritter.percent = 1

				arg_638_1.typewritter:SetDirty()
				arg_638_1:ShowNextGo(true)
			end
		end

		arg_638_1.nodeConfigList_ = {}

		arg_638_1:InitPlayNodeList()
	end,
	Play1108409157 = function(arg_642_0, arg_642_1)
		arg_642_1.time_ = 0
		arg_642_1.frameCnt_ = 0
		arg_642_1.state_ = "playing"
		arg_642_1.curTalkId_ = 1108409157
		arg_642_1.duration_ = 5

		SetActive(arg_642_1.tipsGo_, false)

		function arg_642_1.onSingleLineFinish_()
			arg_642_1.onSingleLineUpdate_ = nil
			arg_642_1.onSingleLineFinish_ = nil
			arg_642_1.state_ = "waiting"
		end

		function arg_642_1.playNext_(arg_644_0)
			if arg_644_0 == 1 then
				arg_642_0:Play1108409158(arg_642_1)
			end
		end

		function arg_642_1.onSingleLineUpdate_(arg_645_0)
			if 0 < arg_642_1.time_ and arg_642_1.time_ <= 0 + arg_645_0 and not isNil(arg_642_1.actors_["1084ui_story"]) and arg_642_1.var_.characterEffect1084ui_story == nil then
				arg_642_1.var_.characterEffect1084ui_story = arg_642_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_645_0 = 0.200000002980232

			if 0 <= arg_642_1.time_ and arg_642_1.time_ < 0 + var_645_0 and not isNil(arg_642_1.actors_["1084ui_story"]) then
				if arg_642_1.var_.characterEffect1084ui_story and not isNil(arg_642_1.actors_["1084ui_story"]) then
					arg_642_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_642_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_642_1.time_ - 0) / var_645_0)
				end
			end

			if arg_642_1.time_ >= 0 + var_645_0 and arg_642_1.time_ < 0 + var_645_0 + arg_645_0 and not isNil(arg_642_1.actors_["1084ui_story"]) and arg_642_1.var_.characterEffect1084ui_story then
				arg_642_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_642_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_645_1 = 0
			local var_645_2 = 0.525

			if 0 < arg_642_1.time_ and arg_642_1.time_ <= var_645_1 + arg_645_0 then
				arg_642_1.talkMaxDuration = 0
				arg_642_1.dialogCg_.alpha = 1

				arg_642_1.dialog_:SetActive(true)
				SetActive(arg_642_1.leftNameGo_, true)

				arg_642_1.leftNameTxt_.text = arg_642_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_642_1.leftNameTxt_.transform)

				arg_642_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_642_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_642_1:RecordName(arg_642_1.leftNameTxt_.text)
				SetActive(arg_642_1.iconTrs_.gameObject, true)
				arg_642_1.iconController_:SetSelectedState("hero")

				arg_642_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_642_1.callingController_:SetSelectedState("normal")

				arg_642_1.keyicon_.color = Color.New(1, 1, 1)
				arg_642_1.icon_.color = Color.New(1, 1, 1)

				local var_645_3 = arg_642_1:FormatText(arg_642_1:GetWordFromCfg(1108409157).content)

				arg_642_1.text_.text = var_645_3

				LuaForUtil.ClearLinePrefixSymbol(arg_642_1.text_)

				local var_645_5 = 21 <= 0 and var_645_2 or var_645_2 * (utf8.len(var_645_3) / 21)

				if (21 <= 0 and var_645_2 or var_645_2 * (utf8.len(var_645_3) / 21)) > 0 and var_645_2 < var_645_5 then
					arg_642_1.talkMaxDuration = var_645_5

					if var_645_5 + var_645_1 > arg_642_1.duration_ then
						arg_642_1.duration_ = var_645_5 + var_645_1
					end
				end

				arg_642_1.text_.text = var_645_3
				arg_642_1.typewritter.percent = 0

				arg_642_1.typewritter:SetDirty()
				arg_642_1:ShowNextGo(false)
				arg_642_1:RecordContent(arg_642_1.text_.text)
			end

			local var_645_6 = math.max(var_645_2, arg_642_1.talkMaxDuration)

			if var_645_1 <= arg_642_1.time_ and arg_642_1.time_ < var_645_1 + var_645_6 then
				arg_642_1.typewritter.percent = (arg_642_1.time_ - var_645_1) / var_645_6

				arg_642_1.typewritter:SetDirty()
			end

			if arg_642_1.time_ >= var_645_1 + var_645_6 and arg_642_1.time_ < var_645_1 + var_645_6 + arg_645_0 then
				arg_642_1.typewritter.percent = 1

				arg_642_1.typewritter:SetDirty()
				arg_642_1:ShowNextGo(true)
			end
		end

		arg_642_1.nodeConfigList_ = {}

		arg_642_1:InitPlayNodeList()
	end,
	Play1108409158 = function(arg_646_0, arg_646_1)
		arg_646_1.time_ = 0
		arg_646_1.frameCnt_ = 0
		arg_646_1.state_ = "playing"
		arg_646_1.curTalkId_ = 1108409158
		arg_646_1.duration_ = 2.43

		SetActive(arg_646_1.tipsGo_, false)

		function arg_646_1.onSingleLineFinish_()
			arg_646_1.onSingleLineUpdate_ = nil
			arg_646_1.onSingleLineFinish_ = nil
			arg_646_1.state_ = "waiting"
		end

		function arg_646_1.playNext_(arg_648_0)
			if arg_648_0 == 1 then
				arg_646_0:Play1108409159(arg_646_1)
			end
		end

		function arg_646_1.onSingleLineUpdate_(arg_649_0)
			if 0 < arg_646_1.time_ and arg_646_1.time_ <= 0 + arg_649_0 and not isNil(arg_646_1.actors_["1084ui_story"]) and arg_646_1.var_.characterEffect1084ui_story == nil then
				arg_646_1.var_.characterEffect1084ui_story = arg_646_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_649_0 = 0.200000002980232

			if 0 <= arg_646_1.time_ and arg_646_1.time_ < 0 + var_649_0 and not isNil(arg_646_1.actors_["1084ui_story"]) then
				if arg_646_1.var_.characterEffect1084ui_story and not isNil(arg_646_1.actors_["1084ui_story"]) then
					arg_646_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_646_1.time_ >= 0 + var_649_0 and arg_646_1.time_ < 0 + var_649_0 + arg_649_0 and not isNil(arg_646_1.actors_["1084ui_story"]) and arg_646_1.var_.characterEffect1084ui_story then
				arg_646_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_646_1.time_ and arg_646_1.time_ <= 0 + arg_649_0 then
				arg_646_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			if 0 < arg_646_1.time_ and arg_646_1.time_ <= 0 + arg_649_0 then
				arg_646_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_649_2 = 0
			local var_649_3 = 0.225

			if 0 < arg_646_1.time_ and arg_646_1.time_ <= var_649_2 + arg_649_0 then
				arg_646_1.talkMaxDuration = 0
				arg_646_1.dialogCg_.alpha = 1

				arg_646_1.dialog_:SetActive(true)
				SetActive(arg_646_1.leftNameGo_, true)

				arg_646_1.leftNameTxt_.text = arg_646_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_646_1.leftNameTxt_.transform)

				arg_646_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_646_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_646_1:RecordName(arg_646_1.leftNameTxt_.text)
				SetActive(arg_646_1.iconTrs_.gameObject, false)
				arg_646_1.callingController_:SetSelectedState("normal")

				local var_649_4 = arg_646_1:GetWordFromCfg(1108409158)
				local var_649_5 = arg_646_1:FormatText(var_649_4.content)

				arg_646_1.text_.text = var_649_5

				LuaForUtil.ClearLinePrefixSymbol(arg_646_1.text_)

				local var_649_7 = 9 <= 0 and var_649_3 or var_649_3 * (utf8.len(var_649_5) / 9)

				if (9 <= 0 and var_649_3 or var_649_3 * (utf8.len(var_649_5) / 9)) > 0 and var_649_3 < var_649_7 then
					arg_646_1.talkMaxDuration = var_649_7

					if var_649_7 + var_649_2 > arg_646_1.duration_ then
						arg_646_1.duration_ = var_649_7 + var_649_2
					end
				end

				arg_646_1.text_.text = var_649_5
				arg_646_1.typewritter.percent = 0

				arg_646_1.typewritter:SetDirty()
				arg_646_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409158", "story_v_side_new_1108409.awb") ~= 0 then
					local var_649_8 = manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409158", "story_v_side_new_1108409.awb") / 1000

					if var_649_8 + var_649_2 > arg_646_1.duration_ then
						arg_646_1.duration_ = var_649_8 + var_649_2
					end

					if var_649_4.prefab_name ~= "" and arg_646_1.actors_[var_649_4.prefab_name] ~= nil then
						local var_649_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_646_1.actors_[var_649_4.prefab_name].transform, "story_v_side_new_1108409", "1108409158", "story_v_side_new_1108409.awb")

						arg_646_1:RecordAudio("1108409158", var_649_9)
						arg_646_1:RecordAudio("1108409158", var_649_9)
					else
						arg_646_1:AudioAction("play", "voice", "story_v_side_new_1108409", "1108409158", "story_v_side_new_1108409.awb")
					end

					arg_646_1:RecordHistoryTalkVoice("story_v_side_new_1108409", "1108409158", "story_v_side_new_1108409.awb")
				end

				arg_646_1:RecordContent(arg_646_1.text_.text)
			end

			local var_649_10 = math.max(var_649_3, arg_646_1.talkMaxDuration)

			if var_649_2 <= arg_646_1.time_ and arg_646_1.time_ < var_649_2 + var_649_10 then
				arg_646_1.typewritter.percent = (arg_646_1.time_ - var_649_2) / var_649_10

				arg_646_1.typewritter:SetDirty()
			end

			if arg_646_1.time_ >= var_649_2 + var_649_10 and arg_646_1.time_ < var_649_2 + var_649_10 + arg_649_0 then
				arg_646_1.typewritter.percent = 1

				arg_646_1.typewritter:SetDirty()
				arg_646_1:ShowNextGo(true)
			end
		end

		arg_646_1.nodeConfigList_ = {}

		arg_646_1:InitPlayNodeList()
	end,
	Play1108409159 = function(arg_650_0, arg_650_1)
		arg_650_1.time_ = 0
		arg_650_1.frameCnt_ = 0
		arg_650_1.state_ = "playing"
		arg_650_1.curTalkId_ = 1108409159
		arg_650_1.duration_ = 5

		SetActive(arg_650_1.tipsGo_, false)

		function arg_650_1.onSingleLineFinish_()
			arg_650_1.onSingleLineUpdate_ = nil
			arg_650_1.onSingleLineFinish_ = nil
			arg_650_1.state_ = "waiting"
		end

		function arg_650_1.playNext_(arg_652_0)
			if arg_652_0 == 1 then
				arg_650_0:Play1108409160(arg_650_1)
			end
		end

		function arg_650_1.onSingleLineUpdate_(arg_653_0)
			if 0 < arg_650_1.time_ and arg_650_1.time_ <= 0 + arg_653_0 then
				arg_650_1.var_.moveOldPos1084ui_story = arg_650_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_653_0 = 0.001

			if 0 <= arg_650_1.time_ and arg_650_1.time_ < 0 + var_653_0 then
				arg_650_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_650_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_650_1.time_ - 0) / var_653_0)
				arg_650_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_650_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_650_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_650_1.actors_["1084ui_story"].transform.position).z)
				arg_650_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_650_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_650_1.actors_["1084ui_story"].transform.localEulerAngles = arg_650_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_650_1.time_ >= 0 + var_653_0 and arg_650_1.time_ < 0 + var_653_0 + arg_653_0 then
				arg_650_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_650_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_650_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_650_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_650_1.actors_["1084ui_story"].transform.position).z)
				arg_650_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_650_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_650_1.actors_["1084ui_story"].transform.localEulerAngles = arg_650_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_653_1 = arg_650_1.actors_["1084ui_story"]

			if 0 < arg_650_1.time_ and arg_650_1.time_ <= 0 + arg_653_0 and not isNil(var_653_1) and arg_650_1.var_.characterEffect1084ui_story == nil then
				arg_650_1.var_.characterEffect1084ui_story = var_653_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_653_2 = 0.200000002980232

			if 0 <= arg_650_1.time_ and arg_650_1.time_ < 0 + var_653_2 and not isNil(var_653_1) then
				if arg_650_1.var_.characterEffect1084ui_story and not isNil(var_653_1) then
					arg_650_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_650_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_650_1.time_ - 0) / var_653_2)
				end
			end

			if arg_650_1.time_ >= 0 + var_653_2 and arg_650_1.time_ < 0 + var_653_2 + arg_653_0 and not isNil(var_653_1) and arg_650_1.var_.characterEffect1084ui_story then
				arg_650_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_650_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_653_3 = 0
			local var_653_4 = 0.425

			if 0 < arg_650_1.time_ and arg_650_1.time_ <= var_653_3 + arg_653_0 then
				arg_650_1.talkMaxDuration = 0
				arg_650_1.dialogCg_.alpha = 1

				arg_650_1.dialog_:SetActive(true)
				SetActive(arg_650_1.leftNameGo_, false)

				arg_650_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_650_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_650_1:RecordName(arg_650_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_650_1.iconTrs_.gameObject, false)
				arg_650_1.callingController_:SetSelectedState("normal")

				local var_653_5 = arg_650_1:FormatText(arg_650_1:GetWordFromCfg(1108409159).content)

				arg_650_1.text_.text = var_653_5

				LuaForUtil.ClearLinePrefixSymbol(arg_650_1.text_)

				local var_653_7 = 17 <= 0 and var_653_4 or var_653_4 * (utf8.len(var_653_5) / 17)

				if (17 <= 0 and var_653_4 or var_653_4 * (utf8.len(var_653_5) / 17)) > 0 and var_653_4 < var_653_7 then
					arg_650_1.talkMaxDuration = var_653_7

					if var_653_7 + var_653_3 > arg_650_1.duration_ then
						arg_650_1.duration_ = var_653_7 + var_653_3
					end
				end

				arg_650_1.text_.text = var_653_5
				arg_650_1.typewritter.percent = 0

				arg_650_1.typewritter:SetDirty()
				arg_650_1:ShowNextGo(false)
				arg_650_1:RecordContent(arg_650_1.text_.text)
			end

			local var_653_8 = math.max(var_653_4, arg_650_1.talkMaxDuration)

			if var_653_3 <= arg_650_1.time_ and arg_650_1.time_ < var_653_3 + var_653_8 then
				arg_650_1.typewritter.percent = (arg_650_1.time_ - var_653_3) / var_653_8

				arg_650_1.typewritter:SetDirty()
			end

			if arg_650_1.time_ >= var_653_3 + var_653_8 and arg_650_1.time_ < var_653_3 + var_653_8 + arg_653_0 then
				arg_650_1.typewritter.percent = 1

				arg_650_1.typewritter:SetDirty()
				arg_650_1:ShowNextGo(true)
			end
		end

		arg_650_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_650_1:InitPlayNodeList()
	end,
	Play1108409160 = function(arg_654_0, arg_654_1)
		arg_654_1.time_ = 0
		arg_654_1.frameCnt_ = 0
		arg_654_1.state_ = "playing"
		arg_654_1.curTalkId_ = 1108409160
		arg_654_1.duration_ = 5

		SetActive(arg_654_1.tipsGo_, false)

		function arg_654_1.onSingleLineFinish_()
			arg_654_1.onSingleLineUpdate_ = nil
			arg_654_1.onSingleLineFinish_ = nil
			arg_654_1.state_ = "waiting"
		end

		function arg_654_1.playNext_(arg_656_0)
			if arg_656_0 == 1 then
				arg_654_0:Play1108409161(arg_654_1)
			end
		end

		function arg_654_1.onSingleLineUpdate_(arg_657_0)
			local var_657_0 = 0.425

			if 0 < arg_654_1.time_ and arg_654_1.time_ <= 0 + arg_657_0 then
				arg_654_1.talkMaxDuration = 0
				arg_654_1.dialogCg_.alpha = 1

				arg_654_1.dialog_:SetActive(true)
				SetActive(arg_654_1.leftNameGo_, true)

				arg_654_1.leftNameTxt_.text = arg_654_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_654_1.leftNameTxt_.transform)

				arg_654_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_654_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_654_1:RecordName(arg_654_1.leftNameTxt_.text)
				SetActive(arg_654_1.iconTrs_.gameObject, true)
				arg_654_1.iconController_:SetSelectedState("hero")

				arg_654_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_654_1.callingController_:SetSelectedState("normal")

				arg_654_1.keyicon_.color = Color.New(1, 1, 1)
				arg_654_1.icon_.color = Color.New(1, 1, 1)

				local var_657_1 = arg_654_1:FormatText(arg_654_1:GetWordFromCfg(1108409160).content)

				arg_654_1.text_.text = var_657_1

				LuaForUtil.ClearLinePrefixSymbol(arg_654_1.text_)

				local var_657_3 = 17 <= 0 and var_657_0 or var_657_0 * (utf8.len(var_657_1) / 17)

				if (17 <= 0 and var_657_0 or var_657_0 * (utf8.len(var_657_1) / 17)) > 0 and var_657_0 < var_657_3 then
					arg_654_1.talkMaxDuration = var_657_3

					if var_657_3 + 0 > arg_654_1.duration_ then
						arg_654_1.duration_ = var_657_3 + 0
					end
				end

				arg_654_1.text_.text = var_657_1
				arg_654_1.typewritter.percent = 0

				arg_654_1.typewritter:SetDirty()
				arg_654_1:ShowNextGo(false)
				arg_654_1:RecordContent(arg_654_1.text_.text)
			end

			local var_657_4 = math.max(var_657_0, arg_654_1.talkMaxDuration)

			if 0 <= arg_654_1.time_ and arg_654_1.time_ < 0 + var_657_4 then
				arg_654_1.typewritter.percent = (arg_654_1.time_ - 0) / var_657_4

				arg_654_1.typewritter:SetDirty()
			end

			if arg_654_1.time_ >= 0 + var_657_4 and arg_654_1.time_ < 0 + var_657_4 + arg_657_0 then
				arg_654_1.typewritter.percent = 1

				arg_654_1.typewritter:SetDirty()
				arg_654_1:ShowNextGo(true)
			end
		end

		arg_654_1.nodeConfigList_ = {}

		arg_654_1:InitPlayNodeList()
	end,
	Play1108409161 = function(arg_658_0, arg_658_1)
		arg_658_1.time_ = 0
		arg_658_1.frameCnt_ = 0
		arg_658_1.state_ = "playing"
		arg_658_1.curTalkId_ = 1108409161
		arg_658_1.duration_ = 5.03

		SetActive(arg_658_1.tipsGo_, false)

		function arg_658_1.onSingleLineFinish_()
			arg_658_1.onSingleLineUpdate_ = nil
			arg_658_1.onSingleLineFinish_ = nil
			arg_658_1.state_ = "waiting"
		end

		function arg_658_1.playNext_(arg_660_0)
			if arg_660_0 == 1 then
				arg_658_0:Play1108409162(arg_658_1)
			end
		end

		function arg_658_1.onSingleLineUpdate_(arg_661_0)
			if 0 < arg_658_1.time_ and arg_658_1.time_ <= 0 + arg_661_0 then
				arg_658_1.var_.moveOldPos1084ui_story = arg_658_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_661_0 = 0.001

			if 0 <= arg_658_1.time_ and arg_658_1.time_ < 0 + var_661_0 then
				arg_658_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_658_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_658_1.time_ - 0) / var_661_0)
				arg_658_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_658_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_658_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_658_1.actors_["1084ui_story"].transform.position).z)
				arg_658_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_658_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_658_1.actors_["1084ui_story"].transform.localEulerAngles = arg_658_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_658_1.time_ >= 0 + var_661_0 and arg_658_1.time_ < 0 + var_661_0 + arg_661_0 then
				arg_658_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_658_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_658_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_658_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_658_1.actors_["1084ui_story"].transform.position).z)
				arg_658_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_658_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_658_1.actors_["1084ui_story"].transform.localEulerAngles = arg_658_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_661_1 = arg_658_1.actors_["1084ui_story"]

			if 0 < arg_658_1.time_ and arg_658_1.time_ <= 0 + arg_661_0 and not isNil(var_661_1) and arg_658_1.var_.characterEffect1084ui_story == nil then
				arg_658_1.var_.characterEffect1084ui_story = var_661_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_661_2 = 0.200000002980232

			if 0 <= arg_658_1.time_ and arg_658_1.time_ < 0 + var_661_2 and not isNil(var_661_1) then
				if arg_658_1.var_.characterEffect1084ui_story and not isNil(var_661_1) then
					arg_658_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_658_1.time_ >= 0 + var_661_2 and arg_658_1.time_ < 0 + var_661_2 + arg_661_0 and not isNil(var_661_1) and arg_658_1.var_.characterEffect1084ui_story then
				arg_658_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_658_1.time_ and arg_658_1.time_ <= 0 + arg_661_0 then
				arg_658_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			if 0 < arg_658_1.time_ and arg_658_1.time_ <= 0 + arg_661_0 then
				arg_658_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_661_4 = 0
			local var_661_5 = 0.45

			if 0 < arg_658_1.time_ and arg_658_1.time_ <= var_661_4 + arg_661_0 then
				arg_658_1.talkMaxDuration = 0
				arg_658_1.dialogCg_.alpha = 1

				arg_658_1.dialog_:SetActive(true)
				SetActive(arg_658_1.leftNameGo_, true)

				arg_658_1.leftNameTxt_.text = arg_658_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_658_1.leftNameTxt_.transform)

				arg_658_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_658_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_658_1:RecordName(arg_658_1.leftNameTxt_.text)
				SetActive(arg_658_1.iconTrs_.gameObject, false)
				arg_658_1.callingController_:SetSelectedState("normal")

				local var_661_6 = arg_658_1:GetWordFromCfg(1108409161)
				local var_661_7 = arg_658_1:FormatText(var_661_6.content)

				arg_658_1.text_.text = var_661_7

				LuaForUtil.ClearLinePrefixSymbol(arg_658_1.text_)

				local var_661_9 = 18 <= 0 and var_661_5 or var_661_5 * (utf8.len(var_661_7) / 18)

				if (18 <= 0 and var_661_5 or var_661_5 * (utf8.len(var_661_7) / 18)) > 0 and var_661_5 < var_661_9 then
					arg_658_1.talkMaxDuration = var_661_9

					if var_661_9 + var_661_4 > arg_658_1.duration_ then
						arg_658_1.duration_ = var_661_9 + var_661_4
					end
				end

				arg_658_1.text_.text = var_661_7
				arg_658_1.typewritter.percent = 0

				arg_658_1.typewritter:SetDirty()
				arg_658_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409161", "story_v_side_new_1108409.awb") ~= 0 then
					local var_661_10 = manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409161", "story_v_side_new_1108409.awb") / 1000

					if var_661_10 + var_661_4 > arg_658_1.duration_ then
						arg_658_1.duration_ = var_661_10 + var_661_4
					end

					if var_661_6.prefab_name ~= "" and arg_658_1.actors_[var_661_6.prefab_name] ~= nil then
						local var_661_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_658_1.actors_[var_661_6.prefab_name].transform, "story_v_side_new_1108409", "1108409161", "story_v_side_new_1108409.awb")

						arg_658_1:RecordAudio("1108409161", var_661_11)
						arg_658_1:RecordAudio("1108409161", var_661_11)
					else
						arg_658_1:AudioAction("play", "voice", "story_v_side_new_1108409", "1108409161", "story_v_side_new_1108409.awb")
					end

					arg_658_1:RecordHistoryTalkVoice("story_v_side_new_1108409", "1108409161", "story_v_side_new_1108409.awb")
				end

				arg_658_1:RecordContent(arg_658_1.text_.text)
			end

			local var_661_12 = math.max(var_661_5, arg_658_1.talkMaxDuration)

			if var_661_4 <= arg_658_1.time_ and arg_658_1.time_ < var_661_4 + var_661_12 then
				arg_658_1.typewritter.percent = (arg_658_1.time_ - var_661_4) / var_661_12

				arg_658_1.typewritter:SetDirty()
			end

			if arg_658_1.time_ >= var_661_4 + var_661_12 and arg_658_1.time_ < var_661_4 + var_661_12 + arg_661_0 then
				arg_658_1.typewritter.percent = 1

				arg_658_1.typewritter:SetDirty()
				arg_658_1:ShowNextGo(true)
			end
		end

		arg_658_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_658_1:InitPlayNodeList()
	end,
	Play1108409162 = function(arg_662_0, arg_662_1)
		arg_662_1.time_ = 0
		arg_662_1.frameCnt_ = 0
		arg_662_1.state_ = "playing"
		arg_662_1.curTalkId_ = 1108409162
		arg_662_1.duration_ = 5

		SetActive(arg_662_1.tipsGo_, false)

		function arg_662_1.onSingleLineFinish_()
			arg_662_1.onSingleLineUpdate_ = nil
			arg_662_1.onSingleLineFinish_ = nil
			arg_662_1.state_ = "waiting"
		end

		function arg_662_1.playNext_(arg_664_0)
			if arg_664_0 == 1 then
				arg_662_0:Play1108409163(arg_662_1)
			end
		end

		function arg_662_1.onSingleLineUpdate_(arg_665_0)
			if 0 < arg_662_1.time_ and arg_662_1.time_ <= 0 + arg_665_0 and not isNil(arg_662_1.actors_["1084ui_story"]) and arg_662_1.var_.characterEffect1084ui_story == nil then
				arg_662_1.var_.characterEffect1084ui_story = arg_662_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_665_0 = 0.200000002980232

			if 0 <= arg_662_1.time_ and arg_662_1.time_ < 0 + var_665_0 and not isNil(arg_662_1.actors_["1084ui_story"]) then
				if arg_662_1.var_.characterEffect1084ui_story and not isNil(arg_662_1.actors_["1084ui_story"]) then
					arg_662_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_662_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_662_1.time_ - 0) / var_665_0)
				end
			end

			if arg_662_1.time_ >= 0 + var_665_0 and arg_662_1.time_ < 0 + var_665_0 + arg_665_0 and not isNil(arg_662_1.actors_["1084ui_story"]) and arg_662_1.var_.characterEffect1084ui_story then
				arg_662_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_662_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_665_1 = 0
			local var_665_2 = 0.275

			if 0 < arg_662_1.time_ and arg_662_1.time_ <= var_665_1 + arg_665_0 then
				arg_662_1.talkMaxDuration = 0
				arg_662_1.dialogCg_.alpha = 1

				arg_662_1.dialog_:SetActive(true)
				SetActive(arg_662_1.leftNameGo_, true)

				arg_662_1.leftNameTxt_.text = arg_662_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_662_1.leftNameTxt_.transform)

				arg_662_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_662_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_662_1:RecordName(arg_662_1.leftNameTxt_.text)
				SetActive(arg_662_1.iconTrs_.gameObject, true)
				arg_662_1.iconController_:SetSelectedState("hero")

				arg_662_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_662_1.callingController_:SetSelectedState("normal")

				arg_662_1.keyicon_.color = Color.New(1, 1, 1)
				arg_662_1.icon_.color = Color.New(1, 1, 1)

				local var_665_3 = arg_662_1:FormatText(arg_662_1:GetWordFromCfg(1108409162).content)

				arg_662_1.text_.text = var_665_3

				LuaForUtil.ClearLinePrefixSymbol(arg_662_1.text_)

				local var_665_5 = 11 <= 0 and var_665_2 or var_665_2 * (utf8.len(var_665_3) / 11)

				if (11 <= 0 and var_665_2 or var_665_2 * (utf8.len(var_665_3) / 11)) > 0 and var_665_2 < var_665_5 then
					arg_662_1.talkMaxDuration = var_665_5

					if var_665_5 + var_665_1 > arg_662_1.duration_ then
						arg_662_1.duration_ = var_665_5 + var_665_1
					end
				end

				arg_662_1.text_.text = var_665_3
				arg_662_1.typewritter.percent = 0

				arg_662_1.typewritter:SetDirty()
				arg_662_1:ShowNextGo(false)
				arg_662_1:RecordContent(arg_662_1.text_.text)
			end

			local var_665_6 = math.max(var_665_2, arg_662_1.talkMaxDuration)

			if var_665_1 <= arg_662_1.time_ and arg_662_1.time_ < var_665_1 + var_665_6 then
				arg_662_1.typewritter.percent = (arg_662_1.time_ - var_665_1) / var_665_6

				arg_662_1.typewritter:SetDirty()
			end

			if arg_662_1.time_ >= var_665_1 + var_665_6 and arg_662_1.time_ < var_665_1 + var_665_6 + arg_665_0 then
				arg_662_1.typewritter.percent = 1

				arg_662_1.typewritter:SetDirty()
				arg_662_1:ShowNextGo(true)
			end
		end

		arg_662_1.nodeConfigList_ = {}

		arg_662_1:InitPlayNodeList()
	end,
	Play1108409163 = function(arg_666_0, arg_666_1)
		arg_666_1.time_ = 0
		arg_666_1.frameCnt_ = 0
		arg_666_1.state_ = "playing"
		arg_666_1.curTalkId_ = 1108409163
		arg_666_1.duration_ = 2.73

		SetActive(arg_666_1.tipsGo_, false)

		function arg_666_1.onSingleLineFinish_()
			arg_666_1.onSingleLineUpdate_ = nil
			arg_666_1.onSingleLineFinish_ = nil
			arg_666_1.state_ = "waiting"
		end

		function arg_666_1.playNext_(arg_668_0)
			if arg_668_0 == 1 then
				arg_666_0:Play1108409164(arg_666_1)
			end
		end

		function arg_666_1.onSingleLineUpdate_(arg_669_0)
			if 0 < arg_666_1.time_ and arg_666_1.time_ <= 0 + arg_669_0 and not isNil(arg_666_1.actors_["1084ui_story"]) and arg_666_1.var_.characterEffect1084ui_story == nil then
				arg_666_1.var_.characterEffect1084ui_story = arg_666_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_669_0 = 0.200000002980232

			if 0 <= arg_666_1.time_ and arg_666_1.time_ < 0 + var_669_0 and not isNil(arg_666_1.actors_["1084ui_story"]) then
				if arg_666_1.var_.characterEffect1084ui_story and not isNil(arg_666_1.actors_["1084ui_story"]) then
					arg_666_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_666_1.time_ >= 0 + var_669_0 and arg_666_1.time_ < 0 + var_669_0 + arg_669_0 and not isNil(arg_666_1.actors_["1084ui_story"]) and arg_666_1.var_.characterEffect1084ui_story then
				arg_666_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_666_1.time_ and arg_666_1.time_ <= 0 + arg_669_0 then
				arg_666_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action8_1")
			end

			if 0 < arg_666_1.time_ and arg_666_1.time_ <= 0 + arg_669_0 then
				arg_666_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_669_2 = 0
			local var_669_3 = 0.225

			if 0 < arg_666_1.time_ and arg_666_1.time_ <= var_669_2 + arg_669_0 then
				arg_666_1.talkMaxDuration = 0
				arg_666_1.dialogCg_.alpha = 1

				arg_666_1.dialog_:SetActive(true)
				SetActive(arg_666_1.leftNameGo_, true)

				arg_666_1.leftNameTxt_.text = arg_666_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_666_1.leftNameTxt_.transform)

				arg_666_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_666_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_666_1:RecordName(arg_666_1.leftNameTxt_.text)
				SetActive(arg_666_1.iconTrs_.gameObject, false)
				arg_666_1.callingController_:SetSelectedState("normal")

				local var_669_4 = arg_666_1:GetWordFromCfg(1108409163)
				local var_669_5 = arg_666_1:FormatText(var_669_4.content)

				arg_666_1.text_.text = var_669_5

				LuaForUtil.ClearLinePrefixSymbol(arg_666_1.text_)

				local var_669_7 = 9 <= 0 and var_669_3 or var_669_3 * (utf8.len(var_669_5) / 9)

				if (9 <= 0 and var_669_3 or var_669_3 * (utf8.len(var_669_5) / 9)) > 0 and var_669_3 < var_669_7 then
					arg_666_1.talkMaxDuration = var_669_7

					if var_669_7 + var_669_2 > arg_666_1.duration_ then
						arg_666_1.duration_ = var_669_7 + var_669_2
					end
				end

				arg_666_1.text_.text = var_669_5
				arg_666_1.typewritter.percent = 0

				arg_666_1.typewritter:SetDirty()
				arg_666_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409163", "story_v_side_new_1108409.awb") ~= 0 then
					local var_669_8 = manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409163", "story_v_side_new_1108409.awb") / 1000

					if var_669_8 + var_669_2 > arg_666_1.duration_ then
						arg_666_1.duration_ = var_669_8 + var_669_2
					end

					if var_669_4.prefab_name ~= "" and arg_666_1.actors_[var_669_4.prefab_name] ~= nil then
						local var_669_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_666_1.actors_[var_669_4.prefab_name].transform, "story_v_side_new_1108409", "1108409163", "story_v_side_new_1108409.awb")

						arg_666_1:RecordAudio("1108409163", var_669_9)
						arg_666_1:RecordAudio("1108409163", var_669_9)
					else
						arg_666_1:AudioAction("play", "voice", "story_v_side_new_1108409", "1108409163", "story_v_side_new_1108409.awb")
					end

					arg_666_1:RecordHistoryTalkVoice("story_v_side_new_1108409", "1108409163", "story_v_side_new_1108409.awb")
				end

				arg_666_1:RecordContent(arg_666_1.text_.text)
			end

			local var_669_10 = math.max(var_669_3, arg_666_1.talkMaxDuration)

			if var_669_2 <= arg_666_1.time_ and arg_666_1.time_ < var_669_2 + var_669_10 then
				arg_666_1.typewritter.percent = (arg_666_1.time_ - var_669_2) / var_669_10

				arg_666_1.typewritter:SetDirty()
			end

			if arg_666_1.time_ >= var_669_2 + var_669_10 and arg_666_1.time_ < var_669_2 + var_669_10 + arg_669_0 then
				arg_666_1.typewritter.percent = 1

				arg_666_1.typewritter:SetDirty()
				arg_666_1:ShowNextGo(true)
			end
		end

		arg_666_1.nodeConfigList_ = {}

		arg_666_1:InitPlayNodeList()
	end,
	Play1108409164 = function(arg_670_0, arg_670_1)
		arg_670_1.time_ = 0
		arg_670_1.frameCnt_ = 0
		arg_670_1.state_ = "playing"
		arg_670_1.curTalkId_ = 1108409164
		arg_670_1.duration_ = 5

		SetActive(arg_670_1.tipsGo_, false)

		function arg_670_1.onSingleLineFinish_()
			arg_670_1.onSingleLineUpdate_ = nil
			arg_670_1.onSingleLineFinish_ = nil
			arg_670_1.state_ = "waiting"
		end

		function arg_670_1.playNext_(arg_672_0)
			if arg_672_0 == 1 then
				arg_670_0:Play1108409165(arg_670_1)
			end
		end

		function arg_670_1.onSingleLineUpdate_(arg_673_0)
			if 0 < arg_670_1.time_ and arg_670_1.time_ <= 0 + arg_673_0 then
				arg_670_1.var_.moveOldPos1084ui_story = arg_670_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_673_0 = 0.001

			if 0 <= arg_670_1.time_ and arg_670_1.time_ < 0 + var_673_0 then
				arg_670_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_670_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_670_1.time_ - 0) / var_673_0)
				arg_670_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_670_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_670_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_670_1.actors_["1084ui_story"].transform.position).z)
				arg_670_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_670_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_670_1.actors_["1084ui_story"].transform.localEulerAngles = arg_670_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_670_1.time_ >= 0 + var_673_0 and arg_670_1.time_ < 0 + var_673_0 + arg_673_0 then
				arg_670_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_670_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_670_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_670_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_670_1.actors_["1084ui_story"].transform.position).z)
				arg_670_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_670_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_670_1.actors_["1084ui_story"].transform.localEulerAngles = arg_670_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_673_1 = arg_670_1.actors_["1084ui_story"]

			if 0 < arg_670_1.time_ and arg_670_1.time_ <= 0 + arg_673_0 and not isNil(var_673_1) and arg_670_1.var_.characterEffect1084ui_story == nil then
				arg_670_1.var_.characterEffect1084ui_story = var_673_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_673_2 = 0.200000002980232

			if 0 <= arg_670_1.time_ and arg_670_1.time_ < 0 + var_673_2 and not isNil(var_673_1) then
				if arg_670_1.var_.characterEffect1084ui_story and not isNil(var_673_1) then
					arg_670_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_670_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_670_1.time_ - 0) / var_673_2)
				end
			end

			if arg_670_1.time_ >= 0 + var_673_2 and arg_670_1.time_ < 0 + var_673_2 + arg_673_0 and not isNil(var_673_1) and arg_670_1.var_.characterEffect1084ui_story then
				arg_670_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_670_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_673_3 = 0
			local var_673_4 = 0.825

			if 0 < arg_670_1.time_ and arg_670_1.time_ <= var_673_3 + arg_673_0 then
				arg_670_1.talkMaxDuration = 0
				arg_670_1.dialogCg_.alpha = 1

				arg_670_1.dialog_:SetActive(true)
				SetActive(arg_670_1.leftNameGo_, false)

				arg_670_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_670_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_670_1:RecordName(arg_670_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_670_1.iconTrs_.gameObject, false)
				arg_670_1.callingController_:SetSelectedState("normal")

				local var_673_5 = arg_670_1:FormatText(arg_670_1:GetWordFromCfg(1108409164).content)

				arg_670_1.text_.text = var_673_5

				LuaForUtil.ClearLinePrefixSymbol(arg_670_1.text_)

				local var_673_7 = 33 <= 0 and var_673_4 or var_673_4 * (utf8.len(var_673_5) / 33)

				if (33 <= 0 and var_673_4 or var_673_4 * (utf8.len(var_673_5) / 33)) > 0 and var_673_4 < var_673_7 then
					arg_670_1.talkMaxDuration = var_673_7

					if var_673_7 + var_673_3 > arg_670_1.duration_ then
						arg_670_1.duration_ = var_673_7 + var_673_3
					end
				end

				arg_670_1.text_.text = var_673_5
				arg_670_1.typewritter.percent = 0

				arg_670_1.typewritter:SetDirty()
				arg_670_1:ShowNextGo(false)
				arg_670_1:RecordContent(arg_670_1.text_.text)
			end

			local var_673_8 = math.max(var_673_4, arg_670_1.talkMaxDuration)

			if var_673_3 <= arg_670_1.time_ and arg_670_1.time_ < var_673_3 + var_673_8 then
				arg_670_1.typewritter.percent = (arg_670_1.time_ - var_673_3) / var_673_8

				arg_670_1.typewritter:SetDirty()
			end

			if arg_670_1.time_ >= var_673_3 + var_673_8 and arg_670_1.time_ < var_673_3 + var_673_8 + arg_673_0 then
				arg_670_1.typewritter.percent = 1

				arg_670_1.typewritter:SetDirty()
				arg_670_1:ShowNextGo(true)
			end
		end

		arg_670_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_670_1:InitPlayNodeList()
	end,
	Play1108409165 = function(arg_674_0, arg_674_1)
		arg_674_1.time_ = 0
		arg_674_1.frameCnt_ = 0
		arg_674_1.state_ = "playing"
		arg_674_1.curTalkId_ = 1108409165
		arg_674_1.duration_ = 5.6

		SetActive(arg_674_1.tipsGo_, false)

		function arg_674_1.onSingleLineFinish_()
			arg_674_1.onSingleLineUpdate_ = nil
			arg_674_1.onSingleLineFinish_ = nil
			arg_674_1.state_ = "waiting"
		end

		function arg_674_1.playNext_(arg_676_0)
			if arg_676_0 == 1 then
				arg_674_0:Play1108409166(arg_674_1)
			end
		end

		function arg_674_1.onSingleLineUpdate_(arg_677_0)
			if 0 < arg_674_1.time_ and arg_674_1.time_ <= 0 + arg_677_0 then
				arg_674_1.var_.moveOldPos1084ui_story = arg_674_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_677_0 = 0.001

			if 0 <= arg_674_1.time_ and arg_674_1.time_ < 0 + var_677_0 then
				arg_674_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_674_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_674_1.time_ - 0) / var_677_0)
				arg_674_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_674_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_674_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_674_1.actors_["1084ui_story"].transform.position).z)
				arg_674_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_674_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_674_1.actors_["1084ui_story"].transform.localEulerAngles = arg_674_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_674_1.time_ >= 0 + var_677_0 and arg_674_1.time_ < 0 + var_677_0 + arg_677_0 then
				arg_674_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_674_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_674_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_674_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_674_1.actors_["1084ui_story"].transform.position).z)
				arg_674_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_674_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_674_1.actors_["1084ui_story"].transform.localEulerAngles = arg_674_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_677_1 = arg_674_1.actors_["1084ui_story"]

			if 0 < arg_674_1.time_ and arg_674_1.time_ <= 0 + arg_677_0 and not isNil(var_677_1) and arg_674_1.var_.characterEffect1084ui_story == nil then
				arg_674_1.var_.characterEffect1084ui_story = var_677_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_677_2 = 0.200000002980232

			if 0 <= arg_674_1.time_ and arg_674_1.time_ < 0 + var_677_2 and not isNil(var_677_1) then
				if arg_674_1.var_.characterEffect1084ui_story and not isNil(var_677_1) then
					arg_674_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_674_1.time_ >= 0 + var_677_2 and arg_674_1.time_ < 0 + var_677_2 + arg_677_0 and not isNil(var_677_1) and arg_674_1.var_.characterEffect1084ui_story then
				arg_674_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_674_1.time_ and arg_674_1.time_ <= 0 + arg_677_0 then
				arg_674_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action484")
			end

			if 0 < arg_674_1.time_ and arg_674_1.time_ <= 0 + arg_677_0 then
				arg_674_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_677_4 = 0
			local var_677_5 = 0.875

			if 0 < arg_674_1.time_ and arg_674_1.time_ <= var_677_4 + arg_677_0 then
				arg_674_1.talkMaxDuration = 0
				arg_674_1.dialogCg_.alpha = 1

				arg_674_1.dialog_:SetActive(true)
				SetActive(arg_674_1.leftNameGo_, true)

				arg_674_1.leftNameTxt_.text = arg_674_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_674_1.leftNameTxt_.transform)

				arg_674_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_674_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_674_1:RecordName(arg_674_1.leftNameTxt_.text)
				SetActive(arg_674_1.iconTrs_.gameObject, false)
				arg_674_1.callingController_:SetSelectedState("normal")

				local var_677_6 = arg_674_1:GetWordFromCfg(1108409165)
				local var_677_7 = arg_674_1:FormatText(var_677_6.content)

				arg_674_1.text_.text = var_677_7

				LuaForUtil.ClearLinePrefixSymbol(arg_674_1.text_)

				local var_677_9 = 35 <= 0 and var_677_5 or var_677_5 * (utf8.len(var_677_7) / 35)

				if (35 <= 0 and var_677_5 or var_677_5 * (utf8.len(var_677_7) / 35)) > 0 and var_677_5 < var_677_9 then
					arg_674_1.talkMaxDuration = var_677_9

					if var_677_9 + var_677_4 > arg_674_1.duration_ then
						arg_674_1.duration_ = var_677_9 + var_677_4
					end
				end

				arg_674_1.text_.text = var_677_7
				arg_674_1.typewritter.percent = 0

				arg_674_1.typewritter:SetDirty()
				arg_674_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409165", "story_v_side_new_1108409.awb") ~= 0 then
					local var_677_10 = manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409165", "story_v_side_new_1108409.awb") / 1000

					if var_677_10 + var_677_4 > arg_674_1.duration_ then
						arg_674_1.duration_ = var_677_10 + var_677_4
					end

					if var_677_6.prefab_name ~= "" and arg_674_1.actors_[var_677_6.prefab_name] ~= nil then
						local var_677_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_674_1.actors_[var_677_6.prefab_name].transform, "story_v_side_new_1108409", "1108409165", "story_v_side_new_1108409.awb")

						arg_674_1:RecordAudio("1108409165", var_677_11)
						arg_674_1:RecordAudio("1108409165", var_677_11)
					else
						arg_674_1:AudioAction("play", "voice", "story_v_side_new_1108409", "1108409165", "story_v_side_new_1108409.awb")
					end

					arg_674_1:RecordHistoryTalkVoice("story_v_side_new_1108409", "1108409165", "story_v_side_new_1108409.awb")
				end

				arg_674_1:RecordContent(arg_674_1.text_.text)
			end

			local var_677_12 = math.max(var_677_5, arg_674_1.talkMaxDuration)

			if var_677_4 <= arg_674_1.time_ and arg_674_1.time_ < var_677_4 + var_677_12 then
				arg_674_1.typewritter.percent = (arg_674_1.time_ - var_677_4) / var_677_12

				arg_674_1.typewritter:SetDirty()
			end

			if arg_674_1.time_ >= var_677_4 + var_677_12 and arg_674_1.time_ < var_677_4 + var_677_12 + arg_677_0 then
				arg_674_1.typewritter.percent = 1

				arg_674_1.typewritter:SetDirty()
				arg_674_1:ShowNextGo(true)
			end
		end

		arg_674_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_674_1:InitPlayNodeList()
	end,
	Play1108409166 = function(arg_678_0, arg_678_1)
		arg_678_1.time_ = 0
		arg_678_1.frameCnt_ = 0
		arg_678_1.state_ = "playing"
		arg_678_1.curTalkId_ = 1108409166
		arg_678_1.duration_ = 5

		SetActive(arg_678_1.tipsGo_, false)

		function arg_678_1.onSingleLineFinish_()
			arg_678_1.onSingleLineUpdate_ = nil
			arg_678_1.onSingleLineFinish_ = nil
			arg_678_1.state_ = "waiting"
		end

		function arg_678_1.playNext_(arg_680_0)
			if arg_680_0 == 1 then
				arg_678_0:Play1108409167(arg_678_1)
			end
		end

		function arg_678_1.onSingleLineUpdate_(arg_681_0)
			if 0 < arg_678_1.time_ and arg_678_1.time_ <= 0 + arg_681_0 and not isNil(arg_678_1.actors_["1084ui_story"]) and arg_678_1.var_.characterEffect1084ui_story == nil then
				arg_678_1.var_.characterEffect1084ui_story = arg_678_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_681_0 = 0.200000002980232

			if 0 <= arg_678_1.time_ and arg_678_1.time_ < 0 + var_681_0 and not isNil(arg_678_1.actors_["1084ui_story"]) then
				if arg_678_1.var_.characterEffect1084ui_story and not isNil(arg_678_1.actors_["1084ui_story"]) then
					arg_678_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_678_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_678_1.time_ - 0) / var_681_0)
				end
			end

			if arg_678_1.time_ >= 0 + var_681_0 and arg_678_1.time_ < 0 + var_681_0 + arg_681_0 and not isNil(arg_678_1.actors_["1084ui_story"]) and arg_678_1.var_.characterEffect1084ui_story then
				arg_678_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_678_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_681_1 = 0
			local var_681_2 = 1.2

			if 0 < arg_678_1.time_ and arg_678_1.time_ <= var_681_1 + arg_681_0 then
				arg_678_1.talkMaxDuration = 0
				arg_678_1.dialogCg_.alpha = 1

				arg_678_1.dialog_:SetActive(true)
				SetActive(arg_678_1.leftNameGo_, true)

				arg_678_1.leftNameTxt_.text = arg_678_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_678_1.leftNameTxt_.transform)

				arg_678_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_678_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_678_1:RecordName(arg_678_1.leftNameTxt_.text)
				SetActive(arg_678_1.iconTrs_.gameObject, true)
				arg_678_1.iconController_:SetSelectedState("hero")

				arg_678_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_678_1.callingController_:SetSelectedState("normal")

				arg_678_1.keyicon_.color = Color.New(1, 1, 1)
				arg_678_1.icon_.color = Color.New(1, 1, 1)

				local var_681_3 = arg_678_1:FormatText(arg_678_1:GetWordFromCfg(1108409166).content)

				arg_678_1.text_.text = var_681_3

				LuaForUtil.ClearLinePrefixSymbol(arg_678_1.text_)

				local var_681_5 = 48 <= 0 and var_681_2 or var_681_2 * (utf8.len(var_681_3) / 48)

				if (48 <= 0 and var_681_2 or var_681_2 * (utf8.len(var_681_3) / 48)) > 0 and var_681_2 < var_681_5 then
					arg_678_1.talkMaxDuration = var_681_5

					if var_681_5 + var_681_1 > arg_678_1.duration_ then
						arg_678_1.duration_ = var_681_5 + var_681_1
					end
				end

				arg_678_1.text_.text = var_681_3
				arg_678_1.typewritter.percent = 0

				arg_678_1.typewritter:SetDirty()
				arg_678_1:ShowNextGo(false)
				arg_678_1:RecordContent(arg_678_1.text_.text)
			end

			local var_681_6 = math.max(var_681_2, arg_678_1.talkMaxDuration)

			if var_681_1 <= arg_678_1.time_ and arg_678_1.time_ < var_681_1 + var_681_6 then
				arg_678_1.typewritter.percent = (arg_678_1.time_ - var_681_1) / var_681_6

				arg_678_1.typewritter:SetDirty()
			end

			if arg_678_1.time_ >= var_681_1 + var_681_6 and arg_678_1.time_ < var_681_1 + var_681_6 + arg_681_0 then
				arg_678_1.typewritter.percent = 1

				arg_678_1.typewritter:SetDirty()
				arg_678_1:ShowNextGo(true)
			end
		end

		arg_678_1.nodeConfigList_ = {}

		arg_678_1:InitPlayNodeList()
	end,
	Play1108409167 = function(arg_682_0, arg_682_1)
		arg_682_1.time_ = 0
		arg_682_1.frameCnt_ = 0
		arg_682_1.state_ = "playing"
		arg_682_1.curTalkId_ = 1108409167
		arg_682_1.duration_ = 5.77

		SetActive(arg_682_1.tipsGo_, false)

		function arg_682_1.onSingleLineFinish_()
			arg_682_1.onSingleLineUpdate_ = nil
			arg_682_1.onSingleLineFinish_ = nil
			arg_682_1.state_ = "waiting"
		end

		function arg_682_1.playNext_(arg_684_0)
			if arg_684_0 == 1 then
				arg_682_0:Play1108409168(arg_682_1)
			end
		end

		function arg_682_1.onSingleLineUpdate_(arg_685_0)
			if 0 < arg_682_1.time_ and arg_682_1.time_ <= 0 + arg_685_0 and not isNil(arg_682_1.actors_["1084ui_story"]) and arg_682_1.var_.characterEffect1084ui_story == nil then
				arg_682_1.var_.characterEffect1084ui_story = arg_682_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_685_0 = 0.200000002980232

			if 0 <= arg_682_1.time_ and arg_682_1.time_ < 0 + var_685_0 and not isNil(arg_682_1.actors_["1084ui_story"]) then
				if arg_682_1.var_.characterEffect1084ui_story and not isNil(arg_682_1.actors_["1084ui_story"]) then
					arg_682_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_682_1.time_ >= 0 + var_685_0 and arg_682_1.time_ < 0 + var_685_0 + arg_685_0 and not isNil(arg_682_1.actors_["1084ui_story"]) and arg_682_1.var_.characterEffect1084ui_story then
				arg_682_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_682_1.time_ and arg_682_1.time_ <= 0 + arg_685_0 then
				arg_682_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action447")
			end

			if 0 < arg_682_1.time_ and arg_682_1.time_ <= 0 + arg_685_0 then
				arg_682_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_685_2 = 0
			local var_685_3 = 0.5

			if 0 < arg_682_1.time_ and arg_682_1.time_ <= var_685_2 + arg_685_0 then
				arg_682_1.talkMaxDuration = 0
				arg_682_1.dialogCg_.alpha = 1

				arg_682_1.dialog_:SetActive(true)
				SetActive(arg_682_1.leftNameGo_, true)

				arg_682_1.leftNameTxt_.text = arg_682_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_682_1.leftNameTxt_.transform)

				arg_682_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_682_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_682_1:RecordName(arg_682_1.leftNameTxt_.text)
				SetActive(arg_682_1.iconTrs_.gameObject, false)
				arg_682_1.callingController_:SetSelectedState("normal")

				local var_685_4 = arg_682_1:GetWordFromCfg(1108409167)
				local var_685_5 = arg_682_1:FormatText(var_685_4.content)

				arg_682_1.text_.text = var_685_5

				LuaForUtil.ClearLinePrefixSymbol(arg_682_1.text_)

				local var_685_7 = 20 <= 0 and var_685_3 or var_685_3 * (utf8.len(var_685_5) / 20)

				if (20 <= 0 and var_685_3 or var_685_3 * (utf8.len(var_685_5) / 20)) > 0 and var_685_3 < var_685_7 then
					arg_682_1.talkMaxDuration = var_685_7

					if var_685_7 + var_685_2 > arg_682_1.duration_ then
						arg_682_1.duration_ = var_685_7 + var_685_2
					end
				end

				arg_682_1.text_.text = var_685_5
				arg_682_1.typewritter.percent = 0

				arg_682_1.typewritter:SetDirty()
				arg_682_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409167", "story_v_side_new_1108409.awb") ~= 0 then
					local var_685_8 = manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409167", "story_v_side_new_1108409.awb") / 1000

					if var_685_8 + var_685_2 > arg_682_1.duration_ then
						arg_682_1.duration_ = var_685_8 + var_685_2
					end

					if var_685_4.prefab_name ~= "" and arg_682_1.actors_[var_685_4.prefab_name] ~= nil then
						local var_685_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_682_1.actors_[var_685_4.prefab_name].transform, "story_v_side_new_1108409", "1108409167", "story_v_side_new_1108409.awb")

						arg_682_1:RecordAudio("1108409167", var_685_9)
						arg_682_1:RecordAudio("1108409167", var_685_9)
					else
						arg_682_1:AudioAction("play", "voice", "story_v_side_new_1108409", "1108409167", "story_v_side_new_1108409.awb")
					end

					arg_682_1:RecordHistoryTalkVoice("story_v_side_new_1108409", "1108409167", "story_v_side_new_1108409.awb")
				end

				arg_682_1:RecordContent(arg_682_1.text_.text)
			end

			local var_685_10 = math.max(var_685_3, arg_682_1.talkMaxDuration)

			if var_685_2 <= arg_682_1.time_ and arg_682_1.time_ < var_685_2 + var_685_10 then
				arg_682_1.typewritter.percent = (arg_682_1.time_ - var_685_2) / var_685_10

				arg_682_1.typewritter:SetDirty()
			end

			if arg_682_1.time_ >= var_685_2 + var_685_10 and arg_682_1.time_ < var_685_2 + var_685_10 + arg_685_0 then
				arg_682_1.typewritter.percent = 1

				arg_682_1.typewritter:SetDirty()
				arg_682_1:ShowNextGo(true)
			end
		end

		arg_682_1.nodeConfigList_ = {}

		arg_682_1:InitPlayNodeList()
	end,
	Play1108409168 = function(arg_686_0, arg_686_1)
		arg_686_1.time_ = 0
		arg_686_1.frameCnt_ = 0
		arg_686_1.state_ = "playing"
		arg_686_1.curTalkId_ = 1108409168
		arg_686_1.duration_ = 5

		SetActive(arg_686_1.tipsGo_, false)

		function arg_686_1.onSingleLineFinish_()
			arg_686_1.onSingleLineUpdate_ = nil
			arg_686_1.onSingleLineFinish_ = nil
			arg_686_1.state_ = "waiting"
		end

		function arg_686_1.playNext_(arg_688_0)
			if arg_688_0 == 1 then
				arg_686_0:Play1108409169(arg_686_1)
			end
		end

		function arg_686_1.onSingleLineUpdate_(arg_689_0)
			if 0 < arg_686_1.time_ and arg_686_1.time_ <= 0 + arg_689_0 and not isNil(arg_686_1.actors_["1084ui_story"]) and arg_686_1.var_.characterEffect1084ui_story == nil then
				arg_686_1.var_.characterEffect1084ui_story = arg_686_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_689_0 = 0.200000002980232

			if 0 <= arg_686_1.time_ and arg_686_1.time_ < 0 + var_689_0 and not isNil(arg_686_1.actors_["1084ui_story"]) then
				if arg_686_1.var_.characterEffect1084ui_story and not isNil(arg_686_1.actors_["1084ui_story"]) then
					arg_686_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_686_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_686_1.time_ - 0) / var_689_0)
				end
			end

			if arg_686_1.time_ >= 0 + var_689_0 and arg_686_1.time_ < 0 + var_689_0 + arg_689_0 and not isNil(arg_686_1.actors_["1084ui_story"]) and arg_686_1.var_.characterEffect1084ui_story then
				arg_686_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_686_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_689_1 = 0
			local var_689_2 = 0.375

			if 0 < arg_686_1.time_ and arg_686_1.time_ <= var_689_1 + arg_689_0 then
				arg_686_1.talkMaxDuration = 0
				arg_686_1.dialogCg_.alpha = 1

				arg_686_1.dialog_:SetActive(true)
				SetActive(arg_686_1.leftNameGo_, true)

				arg_686_1.leftNameTxt_.text = arg_686_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_686_1.leftNameTxt_.transform)

				arg_686_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_686_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_686_1:RecordName(arg_686_1.leftNameTxt_.text)
				SetActive(arg_686_1.iconTrs_.gameObject, true)
				arg_686_1.iconController_:SetSelectedState("hero")

				arg_686_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_686_1.callingController_:SetSelectedState("normal")

				arg_686_1.keyicon_.color = Color.New(1, 1, 1)
				arg_686_1.icon_.color = Color.New(1, 1, 1)

				local var_689_3 = arg_686_1:FormatText(arg_686_1:GetWordFromCfg(1108409168).content)

				arg_686_1.text_.text = var_689_3

				LuaForUtil.ClearLinePrefixSymbol(arg_686_1.text_)

				local var_689_5 = 15 <= 0 and var_689_2 or var_689_2 * (utf8.len(var_689_3) / 15)

				if (15 <= 0 and var_689_2 or var_689_2 * (utf8.len(var_689_3) / 15)) > 0 and var_689_2 < var_689_5 then
					arg_686_1.talkMaxDuration = var_689_5

					if var_689_5 + var_689_1 > arg_686_1.duration_ then
						arg_686_1.duration_ = var_689_5 + var_689_1
					end
				end

				arg_686_1.text_.text = var_689_3
				arg_686_1.typewritter.percent = 0

				arg_686_1.typewritter:SetDirty()
				arg_686_1:ShowNextGo(false)
				arg_686_1:RecordContent(arg_686_1.text_.text)
			end

			local var_689_6 = math.max(var_689_2, arg_686_1.talkMaxDuration)

			if var_689_1 <= arg_686_1.time_ and arg_686_1.time_ < var_689_1 + var_689_6 then
				arg_686_1.typewritter.percent = (arg_686_1.time_ - var_689_1) / var_689_6

				arg_686_1.typewritter:SetDirty()
			end

			if arg_686_1.time_ >= var_689_1 + var_689_6 and arg_686_1.time_ < var_689_1 + var_689_6 + arg_689_0 then
				arg_686_1.typewritter.percent = 1

				arg_686_1.typewritter:SetDirty()
				arg_686_1:ShowNextGo(true)
			end
		end

		arg_686_1.nodeConfigList_ = {}

		arg_686_1:InitPlayNodeList()
	end,
	Play1108409169 = function(arg_690_0, arg_690_1)
		arg_690_1.time_ = 0
		arg_690_1.frameCnt_ = 0
		arg_690_1.state_ = "playing"
		arg_690_1.curTalkId_ = 1108409169
		arg_690_1.duration_ = 5.63

		SetActive(arg_690_1.tipsGo_, false)

		function arg_690_1.onSingleLineFinish_()
			arg_690_1.onSingleLineUpdate_ = nil
			arg_690_1.onSingleLineFinish_ = nil
			arg_690_1.state_ = "waiting"
		end

		function arg_690_1.playNext_(arg_692_0)
			if arg_692_0 == 1 then
				arg_690_0:Play1108409170(arg_690_1)
			end
		end

		function arg_690_1.onSingleLineUpdate_(arg_693_0)
			if 0 < arg_690_1.time_ and arg_690_1.time_ <= 0 + arg_693_0 and not isNil(arg_690_1.actors_["1084ui_story"]) and arg_690_1.var_.characterEffect1084ui_story == nil then
				arg_690_1.var_.characterEffect1084ui_story = arg_690_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_693_0 = 0.200000002980232

			if 0 <= arg_690_1.time_ and arg_690_1.time_ < 0 + var_693_0 and not isNil(arg_690_1.actors_["1084ui_story"]) then
				if arg_690_1.var_.characterEffect1084ui_story and not isNil(arg_690_1.actors_["1084ui_story"]) then
					arg_690_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_690_1.time_ >= 0 + var_693_0 and arg_690_1.time_ < 0 + var_693_0 + arg_693_0 and not isNil(arg_690_1.actors_["1084ui_story"]) and arg_690_1.var_.characterEffect1084ui_story then
				arg_690_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_690_1.time_ and arg_690_1.time_ <= 0 + arg_693_0 then
				arg_690_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_2")
			end

			if 0 < arg_690_1.time_ and arg_690_1.time_ <= 0 + arg_693_0 then
				arg_690_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_693_2 = 0
			local var_693_3 = 0.7

			if 0 < arg_690_1.time_ and arg_690_1.time_ <= var_693_2 + arg_693_0 then
				arg_690_1.talkMaxDuration = 0
				arg_690_1.dialogCg_.alpha = 1

				arg_690_1.dialog_:SetActive(true)
				SetActive(arg_690_1.leftNameGo_, true)

				arg_690_1.leftNameTxt_.text = arg_690_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_690_1.leftNameTxt_.transform)

				arg_690_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_690_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_690_1:RecordName(arg_690_1.leftNameTxt_.text)
				SetActive(arg_690_1.iconTrs_.gameObject, false)
				arg_690_1.callingController_:SetSelectedState("normal")

				local var_693_4 = arg_690_1:GetWordFromCfg(1108409169)
				local var_693_5 = arg_690_1:FormatText(var_693_4.content)

				arg_690_1.text_.text = var_693_5

				LuaForUtil.ClearLinePrefixSymbol(arg_690_1.text_)

				local var_693_7 = 28 <= 0 and var_693_3 or var_693_3 * (utf8.len(var_693_5) / 28)

				if (28 <= 0 and var_693_3 or var_693_3 * (utf8.len(var_693_5) / 28)) > 0 and var_693_3 < var_693_7 then
					arg_690_1.talkMaxDuration = var_693_7

					if var_693_7 + var_693_2 > arg_690_1.duration_ then
						arg_690_1.duration_ = var_693_7 + var_693_2
					end
				end

				arg_690_1.text_.text = var_693_5
				arg_690_1.typewritter.percent = 0

				arg_690_1.typewritter:SetDirty()
				arg_690_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409169", "story_v_side_new_1108409.awb") ~= 0 then
					local var_693_8 = manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409169", "story_v_side_new_1108409.awb") / 1000

					if var_693_8 + var_693_2 > arg_690_1.duration_ then
						arg_690_1.duration_ = var_693_8 + var_693_2
					end

					if var_693_4.prefab_name ~= "" and arg_690_1.actors_[var_693_4.prefab_name] ~= nil then
						local var_693_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_690_1.actors_[var_693_4.prefab_name].transform, "story_v_side_new_1108409", "1108409169", "story_v_side_new_1108409.awb")

						arg_690_1:RecordAudio("1108409169", var_693_9)
						arg_690_1:RecordAudio("1108409169", var_693_9)
					else
						arg_690_1:AudioAction("play", "voice", "story_v_side_new_1108409", "1108409169", "story_v_side_new_1108409.awb")
					end

					arg_690_1:RecordHistoryTalkVoice("story_v_side_new_1108409", "1108409169", "story_v_side_new_1108409.awb")
				end

				arg_690_1:RecordContent(arg_690_1.text_.text)
			end

			local var_693_10 = math.max(var_693_3, arg_690_1.talkMaxDuration)

			if var_693_2 <= arg_690_1.time_ and arg_690_1.time_ < var_693_2 + var_693_10 then
				arg_690_1.typewritter.percent = (arg_690_1.time_ - var_693_2) / var_693_10

				arg_690_1.typewritter:SetDirty()
			end

			if arg_690_1.time_ >= var_693_2 + var_693_10 and arg_690_1.time_ < var_693_2 + var_693_10 + arg_693_0 then
				arg_690_1.typewritter.percent = 1

				arg_690_1.typewritter:SetDirty()
				arg_690_1:ShowNextGo(true)
			end
		end

		arg_690_1.nodeConfigList_ = {}

		arg_690_1:InitPlayNodeList()
	end,
	Play1108409170 = function(arg_694_0, arg_694_1)
		arg_694_1.time_ = 0
		arg_694_1.frameCnt_ = 0
		arg_694_1.state_ = "playing"
		arg_694_1.curTalkId_ = 1108409170
		arg_694_1.duration_ = 5

		SetActive(arg_694_1.tipsGo_, false)

		function arg_694_1.onSingleLineFinish_()
			arg_694_1.onSingleLineUpdate_ = nil
			arg_694_1.onSingleLineFinish_ = nil
			arg_694_1.state_ = "waiting"
		end

		function arg_694_1.playNext_(arg_696_0)
			if arg_696_0 == 1 then
				arg_694_0:Play1108409171(arg_694_1)
			end
		end

		function arg_694_1.onSingleLineUpdate_(arg_697_0)
			if 0 < arg_694_1.time_ and arg_694_1.time_ <= 0 + arg_697_0 and not isNil(arg_694_1.actors_["1084ui_story"]) and arg_694_1.var_.characterEffect1084ui_story == nil then
				arg_694_1.var_.characterEffect1084ui_story = arg_694_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_697_0 = 0.200000002980232

			if 0 <= arg_694_1.time_ and arg_694_1.time_ < 0 + var_697_0 and not isNil(arg_694_1.actors_["1084ui_story"]) then
				if arg_694_1.var_.characterEffect1084ui_story and not isNil(arg_694_1.actors_["1084ui_story"]) then
					arg_694_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_694_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_694_1.time_ - 0) / var_697_0)
				end
			end

			if arg_694_1.time_ >= 0 + var_697_0 and arg_694_1.time_ < 0 + var_697_0 + arg_697_0 and not isNil(arg_694_1.actors_["1084ui_story"]) and arg_694_1.var_.characterEffect1084ui_story then
				arg_694_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_694_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_697_1 = 0
			local var_697_2 = 0.425

			if 0 < arg_694_1.time_ and arg_694_1.time_ <= var_697_1 + arg_697_0 then
				arg_694_1.talkMaxDuration = 0
				arg_694_1.dialogCg_.alpha = 1

				arg_694_1.dialog_:SetActive(true)
				SetActive(arg_694_1.leftNameGo_, true)

				arg_694_1.leftNameTxt_.text = arg_694_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_694_1.leftNameTxt_.transform)

				arg_694_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_694_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_694_1:RecordName(arg_694_1.leftNameTxt_.text)
				SetActive(arg_694_1.iconTrs_.gameObject, true)
				arg_694_1.iconController_:SetSelectedState("hero")

				arg_694_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_694_1.callingController_:SetSelectedState("normal")

				arg_694_1.keyicon_.color = Color.New(1, 1, 1)
				arg_694_1.icon_.color = Color.New(1, 1, 1)

				local var_697_3 = arg_694_1:FormatText(arg_694_1:GetWordFromCfg(1108409170).content)

				arg_694_1.text_.text = var_697_3

				LuaForUtil.ClearLinePrefixSymbol(arg_694_1.text_)

				local var_697_5 = 17 <= 0 and var_697_2 or var_697_2 * (utf8.len(var_697_3) / 17)

				if (17 <= 0 and var_697_2 or var_697_2 * (utf8.len(var_697_3) / 17)) > 0 and var_697_2 < var_697_5 then
					arg_694_1.talkMaxDuration = var_697_5

					if var_697_5 + var_697_1 > arg_694_1.duration_ then
						arg_694_1.duration_ = var_697_5 + var_697_1
					end
				end

				arg_694_1.text_.text = var_697_3
				arg_694_1.typewritter.percent = 0

				arg_694_1.typewritter:SetDirty()
				arg_694_1:ShowNextGo(false)
				arg_694_1:RecordContent(arg_694_1.text_.text)
			end

			local var_697_6 = math.max(var_697_2, arg_694_1.talkMaxDuration)

			if var_697_1 <= arg_694_1.time_ and arg_694_1.time_ < var_697_1 + var_697_6 then
				arg_694_1.typewritter.percent = (arg_694_1.time_ - var_697_1) / var_697_6

				arg_694_1.typewritter:SetDirty()
			end

			if arg_694_1.time_ >= var_697_1 + var_697_6 and arg_694_1.time_ < var_697_1 + var_697_6 + arg_697_0 then
				arg_694_1.typewritter.percent = 1

				arg_694_1.typewritter:SetDirty()
				arg_694_1:ShowNextGo(true)
			end
		end

		arg_694_1.nodeConfigList_ = {}

		arg_694_1:InitPlayNodeList()
	end,
	Play1108409171 = function(arg_698_0, arg_698_1)
		arg_698_1.time_ = 0
		arg_698_1.frameCnt_ = 0
		arg_698_1.state_ = "playing"
		arg_698_1.curTalkId_ = 1108409171
		arg_698_1.duration_ = 5

		SetActive(arg_698_1.tipsGo_, false)

		function arg_698_1.onSingleLineFinish_()
			arg_698_1.onSingleLineUpdate_ = nil
			arg_698_1.onSingleLineFinish_ = nil
			arg_698_1.state_ = "waiting"
		end

		function arg_698_1.playNext_(arg_700_0)
			if arg_700_0 == 1 then
				arg_698_0:Play1108409172(arg_698_1)
			end
		end

		function arg_698_1.onSingleLineUpdate_(arg_701_0)
			if 0 < arg_698_1.time_ and arg_698_1.time_ <= 0 + arg_701_0 then
				arg_698_1.var_.moveOldPos1084ui_story = arg_698_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_701_0 = 0.001

			if 0 <= arg_698_1.time_ and arg_698_1.time_ < 0 + var_701_0 then
				arg_698_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_698_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_698_1.time_ - 0) / var_701_0)
				arg_698_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_698_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_698_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_698_1.actors_["1084ui_story"].transform.position).z)
				arg_698_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_698_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_698_1.actors_["1084ui_story"].transform.localEulerAngles = arg_698_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_698_1.time_ >= 0 + var_701_0 and arg_698_1.time_ < 0 + var_701_0 + arg_701_0 then
				arg_698_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_698_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_698_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_698_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_698_1.actors_["1084ui_story"].transform.position).z)
				arg_698_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_698_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_698_1.actors_["1084ui_story"].transform.localEulerAngles = arg_698_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_701_1 = 0
			local var_701_2 = 0.675

			if 0 < arg_698_1.time_ and arg_698_1.time_ <= var_701_1 + arg_701_0 then
				arg_698_1.talkMaxDuration = 0
				arg_698_1.dialogCg_.alpha = 1

				arg_698_1.dialog_:SetActive(true)
				SetActive(arg_698_1.leftNameGo_, false)

				arg_698_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_698_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_698_1:RecordName(arg_698_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_698_1.iconTrs_.gameObject, false)
				arg_698_1.callingController_:SetSelectedState("normal")

				local var_701_3 = arg_698_1:FormatText(arg_698_1:GetWordFromCfg(1108409171).content)

				arg_698_1.text_.text = var_701_3

				LuaForUtil.ClearLinePrefixSymbol(arg_698_1.text_)

				local var_701_5 = 27 <= 0 and var_701_2 or var_701_2 * (utf8.len(var_701_3) / 27)

				if (27 <= 0 and var_701_2 or var_701_2 * (utf8.len(var_701_3) / 27)) > 0 and var_701_2 < var_701_5 then
					arg_698_1.talkMaxDuration = var_701_5

					if var_701_5 + var_701_1 > arg_698_1.duration_ then
						arg_698_1.duration_ = var_701_5 + var_701_1
					end
				end

				arg_698_1.text_.text = var_701_3
				arg_698_1.typewritter.percent = 0

				arg_698_1.typewritter:SetDirty()
				arg_698_1:ShowNextGo(false)
				arg_698_1:RecordContent(arg_698_1.text_.text)
			end

			local var_701_6 = math.max(var_701_2, arg_698_1.talkMaxDuration)

			if var_701_1 <= arg_698_1.time_ and arg_698_1.time_ < var_701_1 + var_701_6 then
				arg_698_1.typewritter.percent = (arg_698_1.time_ - var_701_1) / var_701_6

				arg_698_1.typewritter:SetDirty()
			end

			if arg_698_1.time_ >= var_701_1 + var_701_6 and arg_698_1.time_ < var_701_1 + var_701_6 + arg_701_0 then
				arg_698_1.typewritter.percent = 1

				arg_698_1.typewritter:SetDirty()
				arg_698_1:ShowNextGo(true)
			end
		end

		arg_698_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_698_1:InitPlayNodeList()
	end,
	Play1108409172 = function(arg_702_0, arg_702_1)
		arg_702_1.time_ = 0
		arg_702_1.frameCnt_ = 0
		arg_702_1.state_ = "playing"
		arg_702_1.curTalkId_ = 1108409172
		arg_702_1.duration_ = 2.67

		SetActive(arg_702_1.tipsGo_, false)

		function arg_702_1.onSingleLineFinish_()
			arg_702_1.onSingleLineUpdate_ = nil
			arg_702_1.onSingleLineFinish_ = nil
			arg_702_1.state_ = "waiting"
		end

		function arg_702_1.playNext_(arg_704_0)
			if arg_704_0 == 1 then
				arg_702_0:Play1108409173(arg_702_1)
			end
		end

		function arg_702_1.onSingleLineUpdate_(arg_705_0)
			if 0 < arg_702_1.time_ and arg_702_1.time_ <= 0 + arg_705_0 then
				arg_702_1.var_.moveOldPos1084ui_story = arg_702_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_705_0 = 0.001

			if 0 <= arg_702_1.time_ and arg_702_1.time_ < 0 + var_705_0 then
				arg_702_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_702_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_702_1.time_ - 0) / var_705_0)
				arg_702_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_702_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_702_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_702_1.actors_["1084ui_story"].transform.position).z)
				arg_702_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_702_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_702_1.actors_["1084ui_story"].transform.localEulerAngles = arg_702_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_702_1.time_ >= 0 + var_705_0 and arg_702_1.time_ < 0 + var_705_0 + arg_705_0 then
				arg_702_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_702_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_702_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_702_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_702_1.actors_["1084ui_story"].transform.position).z)
				arg_702_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_702_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_702_1.actors_["1084ui_story"].transform.localEulerAngles = arg_702_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_705_1 = arg_702_1.actors_["1084ui_story"]

			if 0 < arg_702_1.time_ and arg_702_1.time_ <= 0 + arg_705_0 and not isNil(var_705_1) and arg_702_1.var_.characterEffect1084ui_story == nil then
				arg_702_1.var_.characterEffect1084ui_story = var_705_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_705_2 = 0.200000002980232

			if 0 <= arg_702_1.time_ and arg_702_1.time_ < 0 + var_705_2 and not isNil(var_705_1) then
				if arg_702_1.var_.characterEffect1084ui_story and not isNil(var_705_1) then
					arg_702_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_702_1.time_ >= 0 + var_705_2 and arg_702_1.time_ < 0 + var_705_2 + arg_705_0 and not isNil(var_705_1) and arg_702_1.var_.characterEffect1084ui_story then
				arg_702_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_702_1.time_ and arg_702_1.time_ <= 0 + arg_705_0 then
				arg_702_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			if 0 < arg_702_1.time_ and arg_702_1.time_ <= 0 + arg_705_0 then
				arg_702_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_705_4 = 0
			local var_705_5 = 0.25

			if 0 < arg_702_1.time_ and arg_702_1.time_ <= var_705_4 + arg_705_0 then
				arg_702_1.talkMaxDuration = 0
				arg_702_1.dialogCg_.alpha = 1

				arg_702_1.dialog_:SetActive(true)
				SetActive(arg_702_1.leftNameGo_, true)

				arg_702_1.leftNameTxt_.text = arg_702_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_702_1.leftNameTxt_.transform)

				arg_702_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_702_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_702_1:RecordName(arg_702_1.leftNameTxt_.text)
				SetActive(arg_702_1.iconTrs_.gameObject, false)
				arg_702_1.callingController_:SetSelectedState("normal")

				local var_705_6 = arg_702_1:GetWordFromCfg(1108409172)
				local var_705_7 = arg_702_1:FormatText(var_705_6.content)

				arg_702_1.text_.text = var_705_7

				LuaForUtil.ClearLinePrefixSymbol(arg_702_1.text_)

				local var_705_9 = 10 <= 0 and var_705_5 or var_705_5 * (utf8.len(var_705_7) / 10)

				if (10 <= 0 and var_705_5 or var_705_5 * (utf8.len(var_705_7) / 10)) > 0 and var_705_5 < var_705_9 then
					arg_702_1.talkMaxDuration = var_705_9

					if var_705_9 + var_705_4 > arg_702_1.duration_ then
						arg_702_1.duration_ = var_705_9 + var_705_4
					end
				end

				arg_702_1.text_.text = var_705_7
				arg_702_1.typewritter.percent = 0

				arg_702_1.typewritter:SetDirty()
				arg_702_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409172", "story_v_side_new_1108409.awb") ~= 0 then
					local var_705_10 = manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409172", "story_v_side_new_1108409.awb") / 1000

					if var_705_10 + var_705_4 > arg_702_1.duration_ then
						arg_702_1.duration_ = var_705_10 + var_705_4
					end

					if var_705_6.prefab_name ~= "" and arg_702_1.actors_[var_705_6.prefab_name] ~= nil then
						local var_705_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_702_1.actors_[var_705_6.prefab_name].transform, "story_v_side_new_1108409", "1108409172", "story_v_side_new_1108409.awb")

						arg_702_1:RecordAudio("1108409172", var_705_11)
						arg_702_1:RecordAudio("1108409172", var_705_11)
					else
						arg_702_1:AudioAction("play", "voice", "story_v_side_new_1108409", "1108409172", "story_v_side_new_1108409.awb")
					end

					arg_702_1:RecordHistoryTalkVoice("story_v_side_new_1108409", "1108409172", "story_v_side_new_1108409.awb")
				end

				arg_702_1:RecordContent(arg_702_1.text_.text)
			end

			local var_705_12 = math.max(var_705_5, arg_702_1.talkMaxDuration)

			if var_705_4 <= arg_702_1.time_ and arg_702_1.time_ < var_705_4 + var_705_12 then
				arg_702_1.typewritter.percent = (arg_702_1.time_ - var_705_4) / var_705_12

				arg_702_1.typewritter:SetDirty()
			end

			if arg_702_1.time_ >= var_705_4 + var_705_12 and arg_702_1.time_ < var_705_4 + var_705_12 + arg_705_0 then
				arg_702_1.typewritter.percent = 1

				arg_702_1.typewritter:SetDirty()
				arg_702_1:ShowNextGo(true)
			end
		end

		arg_702_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_702_1:InitPlayNodeList()
	end,
	Play1108409173 = function(arg_706_0, arg_706_1)
		arg_706_1.time_ = 0
		arg_706_1.frameCnt_ = 0
		arg_706_1.state_ = "playing"
		arg_706_1.curTalkId_ = 1108409173
		arg_706_1.duration_ = 9

		SetActive(arg_706_1.tipsGo_, false)

		function arg_706_1.onSingleLineFinish_()
			arg_706_1.onSingleLineUpdate_ = nil
			arg_706_1.onSingleLineFinish_ = nil
			arg_706_1.state_ = "waiting"
		end

		function arg_706_1.playNext_(arg_708_0)
			if arg_708_0 == 1 then
				arg_706_0:Play1108409174(arg_706_1)
			end
		end

		function arg_706_1.onSingleLineUpdate_(arg_709_0)
			if 2 < arg_706_1.time_ and arg_706_1.time_ <= 2 + arg_709_0 then
				local var_709_0 = arg_706_1.bgs_.ST03

				arg_706_1.bgs_.ST03.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_709_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_709_1 = var_709_0:GetComponent("SpriteRenderer")

				if var_709_1 and var_709_1.sprite then
					local var_709_2 = 2 * (var_709_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_709_0.transform.localScale = Vector3.New(var_709_2 / var_709_1.sprite.bounds.size.y < var_709_2 * manager.ui.mainCameraCom_.aspect / var_709_1.sprite.bounds.size.x and var_709_2 * manager.ui.mainCameraCom_.aspect / var_709_1.sprite.bounds.size.x or var_709_2 / var_709_1.sprite.bounds.size.y, var_709_2 / var_709_1.sprite.bounds.size.y < var_709_2 * manager.ui.mainCameraCom_.aspect / var_709_1.sprite.bounds.size.x and var_709_2 * manager.ui.mainCameraCom_.aspect / var_709_1.sprite.bounds.size.x or var_709_2 / var_709_1.sprite.bounds.size.y, 0)
				end

				for iter_709_0, iter_709_1 in pairs(arg_706_1.bgs_) do
					if iter_709_0 ~= "ST03" then
						iter_709_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_709_3 = 3.999999999999

			if 3.999999999999 < arg_706_1.time_ and arg_706_1.time_ <= var_709_3 + arg_709_0 then
				arg_706_1.allBtn_.enabled = false
			end

			if arg_706_1.time_ >= var_709_3 + 0.3 and arg_706_1.time_ < var_709_3 + 0.3 + arg_709_0 then
				arg_706_1.allBtn_.enabled = true
			end

			local var_709_4 = 0

			if 0 < arg_706_1.time_ and arg_706_1.time_ <= var_709_4 + arg_709_0 then
				arg_706_1.mask_.enabled = true
				arg_706_1.mask_.raycastTarget = true

				arg_706_1:SetGaussion(false)
			end

			local var_709_5 = 2

			if var_709_4 <= arg_706_1.time_ and arg_706_1.time_ < var_709_4 + var_709_5 then
				local var_709_6 = Color.New(0, 0, 0)

				var_709_6.a = Mathf.Lerp(0, 1, (arg_706_1.time_ - var_709_4) / var_709_5)
				arg_706_1.mask_.color = var_709_6
			end

			if arg_706_1.time_ >= var_709_4 + var_709_5 and arg_706_1.time_ < var_709_4 + var_709_5 + arg_709_0 then
				local var_709_7 = Color.New(0, 0, 0)

				var_709_7.a = 1
				arg_706_1.mask_.color = var_709_7
			end

			local var_709_8 = 2

			if 2 < arg_706_1.time_ and arg_706_1.time_ <= var_709_8 + arg_709_0 then
				arg_706_1.mask_.enabled = true
				arg_706_1.mask_.raycastTarget = true

				arg_706_1:SetGaussion(false)
			end

			local var_709_9 = 2

			if var_709_8 <= arg_706_1.time_ and arg_706_1.time_ < var_709_8 + var_709_9 then
				local var_709_10 = Color.New(0, 0, 0)

				var_709_10.a = Mathf.Lerp(1, 0, (arg_706_1.time_ - var_709_8) / var_709_9)
				arg_706_1.mask_.color = var_709_10
			end

			if arg_706_1.time_ >= var_709_8 + var_709_9 and arg_706_1.time_ < var_709_8 + var_709_9 + arg_709_0 then
				local var_709_11 = Color.New(0, 0, 0)

				arg_706_1.mask_.enabled = false
				var_709_11.a = 0
				arg_706_1.mask_.color = var_709_11
			end

			local var_709_12 = arg_706_1.actors_["1084ui_story"].transform

			if 1.96599999815226 < arg_706_1.time_ and arg_706_1.time_ <= 1.96599999815226 + arg_709_0 then
				arg_706_1.var_.moveOldPos1084ui_story = var_709_12.localPosition
			end

			local var_709_13 = 0.001

			if 1.96599999815226 <= arg_706_1.time_ and arg_706_1.time_ < 1.96599999815226 + var_709_13 then
				var_709_12.localPosition = Vector3.Lerp(arg_706_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_706_1.time_ - 1.96599999815226) / var_709_13)
				var_709_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_709_12.position).x, (manager.ui.mainCamera.transform.position - var_709_12.position).y, (manager.ui.mainCamera.transform.position - var_709_12.position).z)
				var_709_12.localEulerAngles.z = 0
				var_709_12.localEulerAngles.x = 0
				var_709_12.localEulerAngles = var_709_12.localEulerAngles
			end

			if arg_706_1.time_ >= 1.96599999815226 + var_709_13 and arg_706_1.time_ < 1.96599999815226 + var_709_13 + arg_709_0 then
				var_709_12.localPosition = Vector3.New(0, 100, 0)
				var_709_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_709_12.position).x, (manager.ui.mainCamera.transform.position - var_709_12.position).y, (manager.ui.mainCamera.transform.position - var_709_12.position).z)
				var_709_12.localEulerAngles.z = 0
				var_709_12.localEulerAngles.x = 0
				var_709_12.localEulerAngles = var_709_12.localEulerAngles
			end

			local var_709_14 = arg_706_1.actors_["1084ui_story"]

			if 1.96599999815226 < arg_706_1.time_ and arg_706_1.time_ <= 1.96599999815226 + arg_709_0 and not isNil(var_709_14) and arg_706_1.var_.characterEffect1084ui_story == nil then
				arg_706_1.var_.characterEffect1084ui_story = var_709_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_709_15 = 0.034000001847744

			if 1.96599999815226 <= arg_706_1.time_ and arg_706_1.time_ < 1.96599999815226 + var_709_15 and not isNil(var_709_14) then
				if arg_706_1.var_.characterEffect1084ui_story and not isNil(var_709_14) then
					arg_706_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_706_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_706_1.time_ - 1.96599999815226) / var_709_15)
				end
			end

			if arg_706_1.time_ >= 1.96599999815226 + var_709_15 and arg_706_1.time_ < 1.96599999815226 + var_709_15 + arg_709_0 and not isNil(var_709_14) and arg_706_1.var_.characterEffect1084ui_story then
				arg_706_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_706_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0.2 < arg_706_1.time_ and arg_706_1.time_ <= 0.2 + arg_709_0 then
				arg_706_1:AudioAction("stop", "effect", "se_story_140", "se_story_140_amb_chinese restaurant", "")
			end

			if 1.2 < arg_706_1.time_ and arg_706_1.time_ <= 1.2 + arg_709_0 then
				arg_706_1:AudioAction("play", "effect", "se_story_140", "se_story_140_amb_street02", "")
			end

			if arg_706_1.frameCnt_ <= 1 then
				arg_706_1.dialog_:SetActive(false)
			end

			local var_709_18 = 4
			local var_709_19 = 1.425

			if 4 < arg_706_1.time_ and arg_706_1.time_ <= var_709_18 + arg_709_0 then
				arg_706_1.talkMaxDuration = 0

				arg_706_1.dialog_:SetActive(true)

				arg_706_1.dialogCg_.alpha = 0

				local var_709_20 = LeanTween.value(arg_706_1.dialog_, 0, 1, 0.3)

				var_709_20:setOnUpdate(LuaHelper.FloatAction(function(arg_710_0)
					arg_706_1.dialogCg_.alpha = arg_710_0
				end))
				var_709_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_706_1.dialog_)
					var_709_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_706_1.duration_ = arg_706_1.duration_ + 0.3

				SetActive(arg_706_1.leftNameGo_, false)

				arg_706_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_706_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_706_1:RecordName(arg_706_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_706_1.iconTrs_.gameObject, false)
				arg_706_1.callingController_:SetSelectedState("normal")

				local var_709_21 = arg_706_1:FormatText(arg_706_1:GetWordFromCfg(1108409173).content)

				arg_706_1.text_.text = var_709_21

				LuaForUtil.ClearLinePrefixSymbol(arg_706_1.text_)

				local var_709_23 = 57 <= 0 and var_709_19 or var_709_19 * (utf8.len(var_709_21) / 57)

				if (57 <= 0 and var_709_19 or var_709_19 * (utf8.len(var_709_21) / 57)) > 0 and var_709_19 < var_709_23 then
					arg_706_1.talkMaxDuration = var_709_23
					var_709_18 = var_709_18 + 0.3

					if var_709_23 + var_709_18 > arg_706_1.duration_ then
						arg_706_1.duration_ = var_709_23 + var_709_18
					end
				end

				arg_706_1.text_.text = var_709_21
				arg_706_1.typewritter.percent = 0

				arg_706_1.typewritter:SetDirty()
				arg_706_1:ShowNextGo(false)
				arg_706_1:RecordContent(arg_706_1.text_.text)
			end

			local var_709_24 = var_709_18 + 0.3
			local var_709_25 = math.max(var_709_19, arg_706_1.talkMaxDuration)

			if var_709_18 + 0.3 <= arg_706_1.time_ and arg_706_1.time_ < var_709_24 + var_709_25 then
				arg_706_1.typewritter.percent = (arg_706_1.time_ - var_709_24) / var_709_25

				arg_706_1.typewritter:SetDirty()
			end

			if arg_706_1.time_ >= var_709_24 + var_709_25 and arg_706_1.time_ < var_709_24 + var_709_25 + arg_709_0 then
				arg_706_1.typewritter.percent = 1

				arg_706_1.typewritter:SetDirty()
				arg_706_1:ShowNextGo(true)
			end
		end

		arg_706_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_706_1:InitPlayNodeList()
	end,
	Play1108409174 = function(arg_712_0, arg_712_1)
		arg_712_1.time_ = 0
		arg_712_1.frameCnt_ = 0
		arg_712_1.state_ = "playing"
		arg_712_1.curTalkId_ = 1108409174
		arg_712_1.duration_ = 5

		SetActive(arg_712_1.tipsGo_, false)

		function arg_712_1.onSingleLineFinish_()
			arg_712_1.onSingleLineUpdate_ = nil
			arg_712_1.onSingleLineFinish_ = nil
			arg_712_1.state_ = "waiting"
		end

		function arg_712_1.playNext_(arg_714_0)
			if arg_714_0 == 1 then
				arg_712_0:Play1108409175(arg_712_1)
			end
		end

		function arg_712_1.onSingleLineUpdate_(arg_715_0)
			local var_715_0 = 0.825

			if 0 < arg_712_1.time_ and arg_712_1.time_ <= 0 + arg_715_0 then
				arg_712_1.talkMaxDuration = 0
				arg_712_1.dialogCg_.alpha = 1

				arg_712_1.dialog_:SetActive(true)
				SetActive(arg_712_1.leftNameGo_, false)

				arg_712_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_712_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_712_1:RecordName(arg_712_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_712_1.iconTrs_.gameObject, false)
				arg_712_1.callingController_:SetSelectedState("normal")

				local var_715_1 = arg_712_1:FormatText(arg_712_1:GetWordFromCfg(1108409174).content)

				arg_712_1.text_.text = var_715_1

				LuaForUtil.ClearLinePrefixSymbol(arg_712_1.text_)

				local var_715_3 = 33 <= 0 and var_715_0 or var_715_0 * (utf8.len(var_715_1) / 33)

				if (33 <= 0 and var_715_0 or var_715_0 * (utf8.len(var_715_1) / 33)) > 0 and var_715_0 < var_715_3 then
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
	Play1108409175 = function(arg_716_0, arg_716_1)
		arg_716_1.time_ = 0
		arg_716_1.frameCnt_ = 0
		arg_716_1.state_ = "playing"
		arg_716_1.curTalkId_ = 1108409175
		arg_716_1.duration_ = 5

		SetActive(arg_716_1.tipsGo_, false)

		function arg_716_1.onSingleLineFinish_()
			arg_716_1.onSingleLineUpdate_ = nil
			arg_716_1.onSingleLineFinish_ = nil
			arg_716_1.state_ = "waiting"
		end

		function arg_716_1.playNext_(arg_718_0)
			if arg_718_0 == 1 then
				arg_716_0:Play1108409176(arg_716_1)
			end
		end

		function arg_716_1.onSingleLineUpdate_(arg_719_0)
			if 0 < arg_716_1.time_ and arg_716_1.time_ <= 0 + arg_719_0 then
				arg_716_1.var_.moveOldPos1084ui_story = arg_716_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_719_0 = 0.001

			if 0 <= arg_716_1.time_ and arg_716_1.time_ < 0 + var_719_0 then
				arg_716_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_716_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_716_1.time_ - 0) / var_719_0)
				arg_716_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_716_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_716_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_716_1.actors_["1084ui_story"].transform.position).z)
				arg_716_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_716_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_716_1.actors_["1084ui_story"].transform.localEulerAngles = arg_716_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_716_1.time_ >= 0 + var_719_0 and arg_716_1.time_ < 0 + var_719_0 + arg_719_0 then
				arg_716_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_716_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_716_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_716_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_716_1.actors_["1084ui_story"].transform.position).z)
				arg_716_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_716_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_716_1.actors_["1084ui_story"].transform.localEulerAngles = arg_716_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_719_1 = arg_716_1.actors_["1084ui_story"]

			if 0 < arg_716_1.time_ and arg_716_1.time_ <= 0 + arg_719_0 and not isNil(var_719_1) and arg_716_1.var_.characterEffect1084ui_story == nil then
				arg_716_1.var_.characterEffect1084ui_story = var_719_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_719_2 = 0.200000002980232

			if 0 <= arg_716_1.time_ and arg_716_1.time_ < 0 + var_719_2 and not isNil(var_719_1) then
				if arg_716_1.var_.characterEffect1084ui_story and not isNil(var_719_1) then
					arg_716_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_716_1.time_ >= 0 + var_719_2 and arg_716_1.time_ < 0 + var_719_2 + arg_719_0 and not isNil(var_719_1) and arg_716_1.var_.characterEffect1084ui_story then
				arg_716_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_716_1.time_ and arg_716_1.time_ <= 0 + arg_719_0 then
				arg_716_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action8_1")
			end

			if 0 < arg_716_1.time_ and arg_716_1.time_ <= 0 + arg_719_0 then
				arg_716_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_719_4 = 0
			local var_719_5 = 0.5

			if 0 < arg_716_1.time_ and arg_716_1.time_ <= var_719_4 + arg_719_0 then
				arg_716_1.talkMaxDuration = 0
				arg_716_1.dialogCg_.alpha = 1

				arg_716_1.dialog_:SetActive(true)
				SetActive(arg_716_1.leftNameGo_, true)

				arg_716_1.leftNameTxt_.text = arg_716_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_716_1.leftNameTxt_.transform)

				arg_716_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_716_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_716_1:RecordName(arg_716_1.leftNameTxt_.text)
				SetActive(arg_716_1.iconTrs_.gameObject, false)
				arg_716_1.callingController_:SetSelectedState("normal")

				local var_719_6 = arg_716_1:GetWordFromCfg(1108409175)
				local var_719_7 = arg_716_1:FormatText(var_719_6.content)

				arg_716_1.text_.text = var_719_7

				LuaForUtil.ClearLinePrefixSymbol(arg_716_1.text_)

				local var_719_9 = 20 <= 0 and var_719_5 or var_719_5 * (utf8.len(var_719_7) / 20)

				if (20 <= 0 and var_719_5 or var_719_5 * (utf8.len(var_719_7) / 20)) > 0 and var_719_5 < var_719_9 then
					arg_716_1.talkMaxDuration = var_719_9

					if var_719_9 + var_719_4 > arg_716_1.duration_ then
						arg_716_1.duration_ = var_719_9 + var_719_4
					end
				end

				arg_716_1.text_.text = var_719_7
				arg_716_1.typewritter.percent = 0

				arg_716_1.typewritter:SetDirty()
				arg_716_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409175", "story_v_side_new_1108409.awb") ~= 0 then
					local var_719_10 = manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409175", "story_v_side_new_1108409.awb") / 1000

					if var_719_10 + var_719_4 > arg_716_1.duration_ then
						arg_716_1.duration_ = var_719_10 + var_719_4
					end

					if var_719_6.prefab_name ~= "" and arg_716_1.actors_[var_719_6.prefab_name] ~= nil then
						local var_719_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_716_1.actors_[var_719_6.prefab_name].transform, "story_v_side_new_1108409", "1108409175", "story_v_side_new_1108409.awb")

						arg_716_1:RecordAudio("1108409175", var_719_11)
						arg_716_1:RecordAudio("1108409175", var_719_11)
					else
						arg_716_1:AudioAction("play", "voice", "story_v_side_new_1108409", "1108409175", "story_v_side_new_1108409.awb")
					end

					arg_716_1:RecordHistoryTalkVoice("story_v_side_new_1108409", "1108409175", "story_v_side_new_1108409.awb")
				end

				arg_716_1:RecordContent(arg_716_1.text_.text)
			end

			local var_719_12 = math.max(var_719_5, arg_716_1.talkMaxDuration)

			if var_719_4 <= arg_716_1.time_ and arg_716_1.time_ < var_719_4 + var_719_12 then
				arg_716_1.typewritter.percent = (arg_716_1.time_ - var_719_4) / var_719_12

				arg_716_1.typewritter:SetDirty()
			end

			if arg_716_1.time_ >= var_719_4 + var_719_12 and arg_716_1.time_ < var_719_4 + var_719_12 + arg_719_0 then
				arg_716_1.typewritter.percent = 1

				arg_716_1.typewritter:SetDirty()
				arg_716_1:ShowNextGo(true)
			end
		end

		arg_716_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_716_1:InitPlayNodeList()
	end,
	Play1108409176 = function(arg_720_0, arg_720_1)
		arg_720_1.time_ = 0
		arg_720_1.frameCnt_ = 0
		arg_720_1.state_ = "playing"
		arg_720_1.curTalkId_ = 1108409176
		arg_720_1.duration_ = 5

		SetActive(arg_720_1.tipsGo_, false)

		function arg_720_1.onSingleLineFinish_()
			arg_720_1.onSingleLineUpdate_ = nil
			arg_720_1.onSingleLineFinish_ = nil
			arg_720_1.state_ = "waiting"
		end

		function arg_720_1.playNext_(arg_722_0)
			if arg_722_0 == 1 then
				arg_720_0:Play1108409177(arg_720_1)
			end
		end

		function arg_720_1.onSingleLineUpdate_(arg_723_0)
			if 0 < arg_720_1.time_ and arg_720_1.time_ <= 0 + arg_723_0 and not isNil(arg_720_1.actors_["1084ui_story"]) and arg_720_1.var_.characterEffect1084ui_story == nil then
				arg_720_1.var_.characterEffect1084ui_story = arg_720_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_723_0 = 0.200000002980232

			if 0 <= arg_720_1.time_ and arg_720_1.time_ < 0 + var_723_0 and not isNil(arg_720_1.actors_["1084ui_story"]) then
				if arg_720_1.var_.characterEffect1084ui_story and not isNil(arg_720_1.actors_["1084ui_story"]) then
					arg_720_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_720_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_720_1.time_ - 0) / var_723_0)
				end
			end

			if arg_720_1.time_ >= 0 + var_723_0 and arg_720_1.time_ < 0 + var_723_0 + arg_723_0 and not isNil(arg_720_1.actors_["1084ui_story"]) and arg_720_1.var_.characterEffect1084ui_story then
				arg_720_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_720_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_723_1 = 0
			local var_723_2 = 1

			if 0 < arg_720_1.time_ and arg_720_1.time_ <= var_723_1 + arg_723_0 then
				arg_720_1.talkMaxDuration = 0
				arg_720_1.dialogCg_.alpha = 1

				arg_720_1.dialog_:SetActive(true)
				SetActive(arg_720_1.leftNameGo_, true)

				arg_720_1.leftNameTxt_.text = arg_720_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_720_1.leftNameTxt_.transform)

				arg_720_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_720_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_720_1:RecordName(arg_720_1.leftNameTxt_.text)
				SetActive(arg_720_1.iconTrs_.gameObject, true)
				arg_720_1.iconController_:SetSelectedState("hero")

				arg_720_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_720_1.callingController_:SetSelectedState("normal")

				arg_720_1.keyicon_.color = Color.New(1, 1, 1)
				arg_720_1.icon_.color = Color.New(1, 1, 1)

				local var_723_3 = arg_720_1:FormatText(arg_720_1:GetWordFromCfg(1108409176).content)

				arg_720_1.text_.text = var_723_3

				LuaForUtil.ClearLinePrefixSymbol(arg_720_1.text_)

				local var_723_5 = 40 <= 0 and var_723_2 or var_723_2 * (utf8.len(var_723_3) / 40)

				if (40 <= 0 and var_723_2 or var_723_2 * (utf8.len(var_723_3) / 40)) > 0 and var_723_2 < var_723_5 then
					arg_720_1.talkMaxDuration = var_723_5

					if var_723_5 + var_723_1 > arg_720_1.duration_ then
						arg_720_1.duration_ = var_723_5 + var_723_1
					end
				end

				arg_720_1.text_.text = var_723_3
				arg_720_1.typewritter.percent = 0

				arg_720_1.typewritter:SetDirty()
				arg_720_1:ShowNextGo(false)
				arg_720_1:RecordContent(arg_720_1.text_.text)
			end

			local var_723_6 = math.max(var_723_2, arg_720_1.talkMaxDuration)

			if var_723_1 <= arg_720_1.time_ and arg_720_1.time_ < var_723_1 + var_723_6 then
				arg_720_1.typewritter.percent = (arg_720_1.time_ - var_723_1) / var_723_6

				arg_720_1.typewritter:SetDirty()
			end

			if arg_720_1.time_ >= var_723_1 + var_723_6 and arg_720_1.time_ < var_723_1 + var_723_6 + arg_723_0 then
				arg_720_1.typewritter.percent = 1

				arg_720_1.typewritter:SetDirty()
				arg_720_1:ShowNextGo(true)
			end
		end

		arg_720_1.nodeConfigList_ = {}

		arg_720_1:InitPlayNodeList()
	end,
	Play1108409177 = function(arg_724_0, arg_724_1)
		arg_724_1.time_ = 0
		arg_724_1.frameCnt_ = 0
		arg_724_1.state_ = "playing"
		arg_724_1.curTalkId_ = 1108409177
		arg_724_1.duration_ = 5.5

		SetActive(arg_724_1.tipsGo_, false)

		function arg_724_1.onSingleLineFinish_()
			arg_724_1.onSingleLineUpdate_ = nil
			arg_724_1.onSingleLineFinish_ = nil
			arg_724_1.state_ = "waiting"
		end

		function arg_724_1.playNext_(arg_726_0)
			if arg_726_0 == 1 then
				arg_724_0:Play1108409178(arg_724_1)
			end
		end

		function arg_724_1.onSingleLineUpdate_(arg_727_0)
			if 0 < arg_724_1.time_ and arg_724_1.time_ <= 0 + arg_727_0 and not isNil(arg_724_1.actors_["1084ui_story"]) and arg_724_1.var_.characterEffect1084ui_story == nil then
				arg_724_1.var_.characterEffect1084ui_story = arg_724_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_727_0 = 0.200000002980232

			if 0 <= arg_724_1.time_ and arg_724_1.time_ < 0 + var_727_0 and not isNil(arg_724_1.actors_["1084ui_story"]) then
				if arg_724_1.var_.characterEffect1084ui_story and not isNil(arg_724_1.actors_["1084ui_story"]) then
					arg_724_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_724_1.time_ >= 0 + var_727_0 and arg_724_1.time_ < 0 + var_727_0 + arg_727_0 and not isNil(arg_724_1.actors_["1084ui_story"]) and arg_724_1.var_.characterEffect1084ui_story then
				arg_724_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_724_1.time_ and arg_724_1.time_ <= 0 + arg_727_0 then
				arg_724_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action4813")
			end

			if 0 < arg_724_1.time_ and arg_724_1.time_ <= 0 + arg_727_0 then
				arg_724_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva", "EmotionTimelineAnimator")
			end

			local var_727_2 = 0
			local var_727_3 = 0.8

			if 0 < arg_724_1.time_ and arg_724_1.time_ <= var_727_2 + arg_727_0 then
				arg_724_1.talkMaxDuration = 0
				arg_724_1.dialogCg_.alpha = 1

				arg_724_1.dialog_:SetActive(true)
				SetActive(arg_724_1.leftNameGo_, true)

				arg_724_1.leftNameTxt_.text = arg_724_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_724_1.leftNameTxt_.transform)

				arg_724_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_724_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_724_1:RecordName(arg_724_1.leftNameTxt_.text)
				SetActive(arg_724_1.iconTrs_.gameObject, false)
				arg_724_1.callingController_:SetSelectedState("normal")

				local var_727_4 = arg_724_1:GetWordFromCfg(1108409177)
				local var_727_5 = arg_724_1:FormatText(var_727_4.content)

				arg_724_1.text_.text = var_727_5

				LuaForUtil.ClearLinePrefixSymbol(arg_724_1.text_)

				local var_727_7 = 32 <= 0 and var_727_3 or var_727_3 * (utf8.len(var_727_5) / 32)

				if (32 <= 0 and var_727_3 or var_727_3 * (utf8.len(var_727_5) / 32)) > 0 and var_727_3 < var_727_7 then
					arg_724_1.talkMaxDuration = var_727_7

					if var_727_7 + var_727_2 > arg_724_1.duration_ then
						arg_724_1.duration_ = var_727_7 + var_727_2
					end
				end

				arg_724_1.text_.text = var_727_5
				arg_724_1.typewritter.percent = 0

				arg_724_1.typewritter:SetDirty()
				arg_724_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409177", "story_v_side_new_1108409.awb") ~= 0 then
					local var_727_8 = manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409177", "story_v_side_new_1108409.awb") / 1000

					if var_727_8 + var_727_2 > arg_724_1.duration_ then
						arg_724_1.duration_ = var_727_8 + var_727_2
					end

					if var_727_4.prefab_name ~= "" and arg_724_1.actors_[var_727_4.prefab_name] ~= nil then
						local var_727_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_724_1.actors_[var_727_4.prefab_name].transform, "story_v_side_new_1108409", "1108409177", "story_v_side_new_1108409.awb")

						arg_724_1:RecordAudio("1108409177", var_727_9)
						arg_724_1:RecordAudio("1108409177", var_727_9)
					else
						arg_724_1:AudioAction("play", "voice", "story_v_side_new_1108409", "1108409177", "story_v_side_new_1108409.awb")
					end

					arg_724_1:RecordHistoryTalkVoice("story_v_side_new_1108409", "1108409177", "story_v_side_new_1108409.awb")
				end

				arg_724_1:RecordContent(arg_724_1.text_.text)
			end

			local var_727_10 = math.max(var_727_3, arg_724_1.talkMaxDuration)

			if var_727_2 <= arg_724_1.time_ and arg_724_1.time_ < var_727_2 + var_727_10 then
				arg_724_1.typewritter.percent = (arg_724_1.time_ - var_727_2) / var_727_10

				arg_724_1.typewritter:SetDirty()
			end

			if arg_724_1.time_ >= var_727_2 + var_727_10 and arg_724_1.time_ < var_727_2 + var_727_10 + arg_727_0 then
				arg_724_1.typewritter.percent = 1

				arg_724_1.typewritter:SetDirty()
				arg_724_1:ShowNextGo(true)
			end
		end

		arg_724_1.nodeConfigList_ = {}

		arg_724_1:InitPlayNodeList()
	end,
	Play1108409178 = function(arg_728_0, arg_728_1)
		arg_728_1.time_ = 0
		arg_728_1.frameCnt_ = 0
		arg_728_1.state_ = "playing"
		arg_728_1.curTalkId_ = 1108409178
		arg_728_1.duration_ = 7.2

		SetActive(arg_728_1.tipsGo_, false)

		function arg_728_1.onSingleLineFinish_()
			arg_728_1.onSingleLineUpdate_ = nil
			arg_728_1.onSingleLineFinish_ = nil
			arg_728_1.state_ = "waiting"
		end

		function arg_728_1.playNext_(arg_730_0)
			if arg_730_0 == 1 then
				arg_728_0:Play1108409179(arg_728_1)
			end
		end

		function arg_728_1.onSingleLineUpdate_(arg_731_0)
			local var_731_9000

			if arg_728_1.bgs_.ST68 == nil then
				local var_731_0 = Object.Instantiate(arg_728_1.paintGo_)

				var_731_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST68")
				var_731_0.name = "ST68"
				var_731_0.transform.parent = arg_728_1.stage_.transform
				var_731_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_728_1.bgs_.ST68 = var_731_0
			end

			if 1 < arg_728_1.time_ and arg_728_1.time_ <= 1 + arg_731_0 then
				local var_731_1 = arg_728_1.bgs_.ST68

				arg_728_1.bgs_.ST68.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_731_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_731_2 = var_731_1:GetComponent("SpriteRenderer")

				if var_731_2 and var_731_2.sprite then
					local var_731_3 = 2 * (var_731_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_731_1.transform.localScale = Vector3.New(var_731_3 / var_731_2.sprite.bounds.size.y < var_731_3 * manager.ui.mainCameraCom_.aspect / var_731_2.sprite.bounds.size.x and var_731_3 * manager.ui.mainCameraCom_.aspect / var_731_2.sprite.bounds.size.x or var_731_3 / var_731_2.sprite.bounds.size.y, var_731_3 / var_731_2.sprite.bounds.size.y < var_731_3 * manager.ui.mainCameraCom_.aspect / var_731_2.sprite.bounds.size.x and var_731_3 * manager.ui.mainCameraCom_.aspect / var_731_2.sprite.bounds.size.x or var_731_3 / var_731_2.sprite.bounds.size.y, 0)
				end

				for iter_731_0, iter_731_1 in pairs(arg_728_1.bgs_) do
					if iter_731_0 ~= "ST68" then
						iter_731_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_731_4 = 1.375

			if 1.375 < arg_728_1.time_ and arg_728_1.time_ <= var_731_4 + arg_731_0 then
				arg_728_1.allBtn_.enabled = false
			end

			if arg_728_1.time_ >= var_731_4 + 0.3 and arg_728_1.time_ < var_731_4 + 0.3 + arg_731_0 then
				arg_728_1.allBtn_.enabled = true
			end

			if 0 < arg_728_1.time_ and arg_728_1.time_ <= 0 + arg_731_0 then
				local var_731_5 = arg_728_1.var_.effectxiandaizhuanchang1

				if not arg_728_1.var_.effectxiandaizhuanchang1 then
					var_731_5 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zflash"), manager.ui.mainCamera.transform)
					var_731_5.name = "xiandaizhuanchang1"
					arg_728_1.var_.effectxiandaizhuanchang1 = var_731_5
				else
					var_731_5.transform:SetParent(var_731_9000)
				end

				var_731_5.transform.localPosition = Vector3.New(0, 0, 0)
				var_731_5.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_731_7 = arg_728_1.actors_["1084ui_story"].transform

			if 0 < arg_728_1.time_ and arg_728_1.time_ <= 0 + arg_731_0 then
				arg_728_1.var_.moveOldPos1084ui_story = var_731_7.localPosition
			end

			local var_731_8 = 0.001

			if 0 <= arg_728_1.time_ and arg_728_1.time_ < 0 + var_731_8 then
				var_731_7.localPosition = Vector3.Lerp(arg_728_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_728_1.time_ - 0) / var_731_8)
				var_731_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_731_7.position).x, (manager.ui.mainCamera.transform.position - var_731_7.position).y, (manager.ui.mainCamera.transform.position - var_731_7.position).z)
				var_731_7.localEulerAngles.z = 0
				var_731_7.localEulerAngles.x = 0
				var_731_7.localEulerAngles = var_731_7.localEulerAngles
			end

			if arg_728_1.time_ >= 0 + var_731_8 and arg_728_1.time_ < 0 + var_731_8 + arg_731_0 then
				var_731_7.localPosition = Vector3.New(0, 100, 0)
				var_731_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_731_7.position).x, (manager.ui.mainCamera.transform.position - var_731_7.position).y, (manager.ui.mainCamera.transform.position - var_731_7.position).z)
				var_731_7.localEulerAngles.z = 0
				var_731_7.localEulerAngles.x = 0
				var_731_7.localEulerAngles = var_731_7.localEulerAngles
			end

			local var_731_9 = arg_728_1.actors_["1084ui_story"]

			if 0 < arg_728_1.time_ and arg_728_1.time_ <= 0 + arg_731_0 and not isNil(var_731_9) and arg_728_1.var_.characterEffect1084ui_story == nil then
				arg_728_1.var_.characterEffect1084ui_story = var_731_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_731_10 = 0.034000001847744

			if 0 <= arg_728_1.time_ and arg_728_1.time_ < 0 + var_731_10 and not isNil(var_731_9) then
				if arg_728_1.var_.characterEffect1084ui_story and not isNil(var_731_9) then
					arg_728_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_728_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_728_1.time_ - 0) / var_731_10)
				end
			end

			if arg_728_1.time_ >= 0 + var_731_10 and arg_728_1.time_ < 0 + var_731_10 + arg_731_0 and not isNil(var_731_9) and arg_728_1.var_.characterEffect1084ui_story then
				arg_728_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_728_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if arg_728_1.frameCnt_ <= 1 then
				arg_728_1.dialog_:SetActive(false)
			end

			local var_731_11 = 2.2
			local var_731_12 = 1.675

			if 2.2 < arg_728_1.time_ and arg_728_1.time_ <= var_731_11 + arg_731_0 then
				arg_728_1.talkMaxDuration = 0

				arg_728_1.dialog_:SetActive(true)

				arg_728_1.dialogCg_.alpha = 0

				local var_731_13 = LeanTween.value(arg_728_1.dialog_, 0, 1, 0.3)

				var_731_13:setOnUpdate(LuaHelper.FloatAction(function(arg_732_0)
					arg_728_1.dialogCg_.alpha = arg_732_0
				end))
				var_731_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_728_1.dialog_)
					var_731_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_728_1.duration_ = arg_728_1.duration_ + 0.3

				SetActive(arg_728_1.leftNameGo_, false)

				arg_728_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_728_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_728_1:RecordName(arg_728_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_728_1.iconTrs_.gameObject, false)
				arg_728_1.callingController_:SetSelectedState("normal")

				local var_731_14 = arg_728_1:FormatText(arg_728_1:GetWordFromCfg(1108409178).content)

				arg_728_1.text_.text = var_731_14

				LuaForUtil.ClearLinePrefixSymbol(arg_728_1.text_)

				local var_731_16 = 67 <= 0 and var_731_12 or var_731_12 * (utf8.len(var_731_14) / 67)

				if (67 <= 0 and var_731_12 or var_731_12 * (utf8.len(var_731_14) / 67)) > 0 and var_731_12 < var_731_16 then
					arg_728_1.talkMaxDuration = var_731_16
					var_731_11 = var_731_11 + 0.3

					if var_731_16 + var_731_11 > arg_728_1.duration_ then
						arg_728_1.duration_ = var_731_16 + var_731_11
					end
				end

				arg_728_1.text_.text = var_731_14
				arg_728_1.typewritter.percent = 0

				arg_728_1.typewritter:SetDirty()
				arg_728_1:ShowNextGo(false)
				arg_728_1:RecordContent(arg_728_1.text_.text)
			end

			local var_731_17 = var_731_11 + 0.3
			local var_731_18 = math.max(var_731_12, arg_728_1.talkMaxDuration)

			if var_731_11 + 0.3 <= arg_728_1.time_ and arg_728_1.time_ < var_731_17 + var_731_18 then
				arg_728_1.typewritter.percent = (arg_728_1.time_ - var_731_17) / var_731_18

				arg_728_1.typewritter:SetDirty()
			end

			if arg_728_1.time_ >= var_731_17 + var_731_18 and arg_728_1.time_ < var_731_17 + var_731_18 + arg_731_0 then
				arg_728_1.typewritter.percent = 1

				arg_728_1.typewritter:SetDirty()
				arg_728_1:ShowNextGo(true)
			end
		end

		arg_728_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_728_1:InitPlayNodeList()
	end,
	Play1108409179 = function(arg_734_0, arg_734_1)
		arg_734_1.time_ = 0
		arg_734_1.frameCnt_ = 0
		arg_734_1.state_ = "playing"
		arg_734_1.curTalkId_ = 1108409179
		arg_734_1.duration_ = 5

		SetActive(arg_734_1.tipsGo_, false)

		function arg_734_1.onSingleLineFinish_()
			arg_734_1.onSingleLineUpdate_ = nil
			arg_734_1.onSingleLineFinish_ = nil
			arg_734_1.state_ = "waiting"
		end

		function arg_734_1.playNext_(arg_736_0)
			if arg_736_0 == 1 then
				arg_734_0:Play1108409180(arg_734_1)
			end
		end

		function arg_734_1.onSingleLineUpdate_(arg_737_0)
			local var_737_0 = 1.25

			if 0 < arg_734_1.time_ and arg_734_1.time_ <= 0 + arg_737_0 then
				arg_734_1.talkMaxDuration = 0
				arg_734_1.dialogCg_.alpha = 1

				arg_734_1.dialog_:SetActive(true)
				SetActive(arg_734_1.leftNameGo_, true)

				arg_734_1.leftNameTxt_.text = arg_734_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_734_1.leftNameTxt_.transform)

				arg_734_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_734_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_734_1:RecordName(arg_734_1.leftNameTxt_.text)
				SetActive(arg_734_1.iconTrs_.gameObject, true)
				arg_734_1.iconController_:SetSelectedState("hero")

				arg_734_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_734_1.callingController_:SetSelectedState("normal")

				arg_734_1.keyicon_.color = Color.New(1, 1, 1)
				arg_734_1.icon_.color = Color.New(1, 1, 1)

				local var_737_1 = arg_734_1:FormatText(arg_734_1:GetWordFromCfg(1108409179).content)

				arg_734_1.text_.text = var_737_1

				LuaForUtil.ClearLinePrefixSymbol(arg_734_1.text_)

				local var_737_3 = 50 <= 0 and var_737_0 or var_737_0 * (utf8.len(var_737_1) / 50)

				if (50 <= 0 and var_737_0 or var_737_0 * (utf8.len(var_737_1) / 50)) > 0 and var_737_0 < var_737_3 then
					arg_734_1.talkMaxDuration = var_737_3

					if var_737_3 + 0 > arg_734_1.duration_ then
						arg_734_1.duration_ = var_737_3 + 0
					end
				end

				arg_734_1.text_.text = var_737_1
				arg_734_1.typewritter.percent = 0

				arg_734_1.typewritter:SetDirty()
				arg_734_1:ShowNextGo(false)
				arg_734_1:RecordContent(arg_734_1.text_.text)
			end

			local var_737_4 = math.max(var_737_0, arg_734_1.talkMaxDuration)

			if 0 <= arg_734_1.time_ and arg_734_1.time_ < 0 + var_737_4 then
				arg_734_1.typewritter.percent = (arg_734_1.time_ - 0) / var_737_4

				arg_734_1.typewritter:SetDirty()
			end

			if arg_734_1.time_ >= 0 + var_737_4 and arg_734_1.time_ < 0 + var_737_4 + arg_737_0 then
				arg_734_1.typewritter.percent = 1

				arg_734_1.typewritter:SetDirty()
				arg_734_1:ShowNextGo(true)
			end
		end

		arg_734_1.nodeConfigList_ = {}

		arg_734_1:InitPlayNodeList()
	end,
	Play1108409180 = function(arg_738_0, arg_738_1)
		arg_738_1.time_ = 0
		arg_738_1.frameCnt_ = 0
		arg_738_1.state_ = "playing"
		arg_738_1.curTalkId_ = 1108409180
		arg_738_1.duration_ = 5

		SetActive(arg_738_1.tipsGo_, false)

		function arg_738_1.onSingleLineFinish_()
			arg_738_1.onSingleLineUpdate_ = nil
			arg_738_1.onSingleLineFinish_ = nil
			arg_738_1.state_ = "waiting"
		end

		function arg_738_1.playNext_(arg_740_0)
			if arg_740_0 == 1 then
				arg_738_0:Play1108409181(arg_738_1)
			end
		end

		function arg_738_1.onSingleLineUpdate_(arg_741_0)
			local var_741_0 = 1.3

			if 0 < arg_738_1.time_ and arg_738_1.time_ <= 0 + arg_741_0 then
				arg_738_1.talkMaxDuration = 0
				arg_738_1.dialogCg_.alpha = 1

				arg_738_1.dialog_:SetActive(true)
				SetActive(arg_738_1.leftNameGo_, false)

				arg_738_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_738_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_738_1:RecordName(arg_738_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_738_1.iconTrs_.gameObject, false)
				arg_738_1.callingController_:SetSelectedState("normal")

				local var_741_1 = arg_738_1:FormatText(arg_738_1:GetWordFromCfg(1108409180).content)

				arg_738_1.text_.text = var_741_1

				LuaForUtil.ClearLinePrefixSymbol(arg_738_1.text_)

				local var_741_3 = 52 <= 0 and var_741_0 or var_741_0 * (utf8.len(var_741_1) / 52)

				if (52 <= 0 and var_741_0 or var_741_0 * (utf8.len(var_741_1) / 52)) > 0 and var_741_0 < var_741_3 then
					arg_738_1.talkMaxDuration = var_741_3

					if var_741_3 + 0 > arg_738_1.duration_ then
						arg_738_1.duration_ = var_741_3 + 0
					end
				end

				arg_738_1.text_.text = var_741_1
				arg_738_1.typewritter.percent = 0

				arg_738_1.typewritter:SetDirty()
				arg_738_1:ShowNextGo(false)
				arg_738_1:RecordContent(arg_738_1.text_.text)
			end

			local var_741_4 = math.max(var_741_0, arg_738_1.talkMaxDuration)

			if 0 <= arg_738_1.time_ and arg_738_1.time_ < 0 + var_741_4 then
				arg_738_1.typewritter.percent = (arg_738_1.time_ - 0) / var_741_4

				arg_738_1.typewritter:SetDirty()
			end

			if arg_738_1.time_ >= 0 + var_741_4 and arg_738_1.time_ < 0 + var_741_4 + arg_741_0 then
				arg_738_1.typewritter.percent = 1

				arg_738_1.typewritter:SetDirty()
				arg_738_1:ShowNextGo(true)
			end
		end

		arg_738_1.nodeConfigList_ = {}

		arg_738_1:InitPlayNodeList()
	end,
	Play1108409181 = function(arg_742_0, arg_742_1)
		arg_742_1.time_ = 0
		arg_742_1.frameCnt_ = 0
		arg_742_1.state_ = "playing"
		arg_742_1.curTalkId_ = 1108409181
		arg_742_1.duration_ = 6.37

		SetActive(arg_742_1.tipsGo_, false)

		function arg_742_1.onSingleLineFinish_()
			arg_742_1.onSingleLineUpdate_ = nil
			arg_742_1.onSingleLineFinish_ = nil
			arg_742_1.state_ = "waiting"
		end

		function arg_742_1.playNext_(arg_744_0)
			if arg_744_0 == 1 then
				arg_742_0:Play1108409182(arg_742_1)
			end
		end

		function arg_742_1.onSingleLineUpdate_(arg_745_0)
			if 0 < arg_742_1.time_ and arg_742_1.time_ <= 0 + arg_745_0 then
				arg_742_1.var_.moveOldPos1084ui_story = arg_742_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_745_0 = 0.001

			if 0 <= arg_742_1.time_ and arg_742_1.time_ < 0 + var_745_0 then
				arg_742_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_742_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_742_1.time_ - 0) / var_745_0)
				arg_742_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_742_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_742_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_742_1.actors_["1084ui_story"].transform.position).z)
				arg_742_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_742_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_742_1.actors_["1084ui_story"].transform.localEulerAngles = arg_742_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_742_1.time_ >= 0 + var_745_0 and arg_742_1.time_ < 0 + var_745_0 + arg_745_0 then
				arg_742_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_742_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_742_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_742_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_742_1.actors_["1084ui_story"].transform.position).z)
				arg_742_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_742_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_742_1.actors_["1084ui_story"].transform.localEulerAngles = arg_742_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_745_1 = arg_742_1.actors_["1084ui_story"]

			if 0 < arg_742_1.time_ and arg_742_1.time_ <= 0 + arg_745_0 and not isNil(var_745_1) and arg_742_1.var_.characterEffect1084ui_story == nil then
				arg_742_1.var_.characterEffect1084ui_story = var_745_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_745_2 = 0.200000002980232

			if 0 <= arg_742_1.time_ and arg_742_1.time_ < 0 + var_745_2 and not isNil(var_745_1) then
				if arg_742_1.var_.characterEffect1084ui_story and not isNil(var_745_1) then
					arg_742_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_742_1.time_ >= 0 + var_745_2 and arg_742_1.time_ < 0 + var_745_2 + arg_745_0 and not isNil(var_745_1) and arg_742_1.var_.characterEffect1084ui_story then
				arg_742_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_742_1.time_ and arg_742_1.time_ <= 0 + arg_745_0 then
				arg_742_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			if 0 < arg_742_1.time_ and arg_742_1.time_ <= 0 + arg_745_0 then
				arg_742_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_745_4 = 0
			local var_745_5 = 0.775

			if 0 < arg_742_1.time_ and arg_742_1.time_ <= var_745_4 + arg_745_0 then
				arg_742_1.talkMaxDuration = 0
				arg_742_1.dialogCg_.alpha = 1

				arg_742_1.dialog_:SetActive(true)
				SetActive(arg_742_1.leftNameGo_, true)

				arg_742_1.leftNameTxt_.text = arg_742_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_742_1.leftNameTxt_.transform)

				arg_742_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_742_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_742_1:RecordName(arg_742_1.leftNameTxt_.text)
				SetActive(arg_742_1.iconTrs_.gameObject, false)
				arg_742_1.callingController_:SetSelectedState("normal")

				local var_745_6 = arg_742_1:GetWordFromCfg(1108409181)
				local var_745_7 = arg_742_1:FormatText(var_745_6.content)

				arg_742_1.text_.text = var_745_7

				LuaForUtil.ClearLinePrefixSymbol(arg_742_1.text_)

				local var_745_9 = 31 <= 0 and var_745_5 or var_745_5 * (utf8.len(var_745_7) / 31)

				if (31 <= 0 and var_745_5 or var_745_5 * (utf8.len(var_745_7) / 31)) > 0 and var_745_5 < var_745_9 then
					arg_742_1.talkMaxDuration = var_745_9

					if var_745_9 + var_745_4 > arg_742_1.duration_ then
						arg_742_1.duration_ = var_745_9 + var_745_4
					end
				end

				arg_742_1.text_.text = var_745_7
				arg_742_1.typewritter.percent = 0

				arg_742_1.typewritter:SetDirty()
				arg_742_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409181", "story_v_side_new_1108409.awb") ~= 0 then
					local var_745_10 = manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409181", "story_v_side_new_1108409.awb") / 1000

					if var_745_10 + var_745_4 > arg_742_1.duration_ then
						arg_742_1.duration_ = var_745_10 + var_745_4
					end

					if var_745_6.prefab_name ~= "" and arg_742_1.actors_[var_745_6.prefab_name] ~= nil then
						local var_745_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_742_1.actors_[var_745_6.prefab_name].transform, "story_v_side_new_1108409", "1108409181", "story_v_side_new_1108409.awb")

						arg_742_1:RecordAudio("1108409181", var_745_11)
						arg_742_1:RecordAudio("1108409181", var_745_11)
					else
						arg_742_1:AudioAction("play", "voice", "story_v_side_new_1108409", "1108409181", "story_v_side_new_1108409.awb")
					end

					arg_742_1:RecordHistoryTalkVoice("story_v_side_new_1108409", "1108409181", "story_v_side_new_1108409.awb")
				end

				arg_742_1:RecordContent(arg_742_1.text_.text)
			end

			local var_745_12 = math.max(var_745_5, arg_742_1.talkMaxDuration)

			if var_745_4 <= arg_742_1.time_ and arg_742_1.time_ < var_745_4 + var_745_12 then
				arg_742_1.typewritter.percent = (arg_742_1.time_ - var_745_4) / var_745_12

				arg_742_1.typewritter:SetDirty()
			end

			if arg_742_1.time_ >= var_745_4 + var_745_12 and arg_742_1.time_ < var_745_4 + var_745_12 + arg_745_0 then
				arg_742_1.typewritter.percent = 1

				arg_742_1.typewritter:SetDirty()
				arg_742_1:ShowNextGo(true)
			end
		end

		arg_742_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_742_1:InitPlayNodeList()
	end,
	Play1108409182 = function(arg_746_0, arg_746_1)
		arg_746_1.time_ = 0
		arg_746_1.frameCnt_ = 0
		arg_746_1.state_ = "playing"
		arg_746_1.curTalkId_ = 1108409182
		arg_746_1.duration_ = 5

		SetActive(arg_746_1.tipsGo_, false)

		function arg_746_1.onSingleLineFinish_()
			arg_746_1.onSingleLineUpdate_ = nil
			arg_746_1.onSingleLineFinish_ = nil
			arg_746_1.state_ = "waiting"
		end

		function arg_746_1.playNext_(arg_748_0)
			if arg_748_0 == 1 then
				arg_746_0:Play1108409183(arg_746_1)
			end
		end

		function arg_746_1.onSingleLineUpdate_(arg_749_0)
			if 0 < arg_746_1.time_ and arg_746_1.time_ <= 0 + arg_749_0 and not isNil(arg_746_1.actors_["1084ui_story"]) and arg_746_1.var_.characterEffect1084ui_story == nil then
				arg_746_1.var_.characterEffect1084ui_story = arg_746_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_749_0 = 0.200000002980232

			if 0 <= arg_746_1.time_ and arg_746_1.time_ < 0 + var_749_0 and not isNil(arg_746_1.actors_["1084ui_story"]) then
				if arg_746_1.var_.characterEffect1084ui_story and not isNil(arg_746_1.actors_["1084ui_story"]) then
					arg_746_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_746_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_746_1.time_ - 0) / var_749_0)
				end
			end

			if arg_746_1.time_ >= 0 + var_749_0 and arg_746_1.time_ < 0 + var_749_0 + arg_749_0 and not isNil(arg_746_1.actors_["1084ui_story"]) and arg_746_1.var_.characterEffect1084ui_story then
				arg_746_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_746_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_749_1 = 0
			local var_749_2 = 0.125

			if 0 < arg_746_1.time_ and arg_746_1.time_ <= var_749_1 + arg_749_0 then
				arg_746_1.talkMaxDuration = 0
				arg_746_1.dialogCg_.alpha = 1

				arg_746_1.dialog_:SetActive(true)
				SetActive(arg_746_1.leftNameGo_, true)

				arg_746_1.leftNameTxt_.text = arg_746_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_746_1.leftNameTxt_.transform)

				arg_746_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_746_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_746_1:RecordName(arg_746_1.leftNameTxt_.text)
				SetActive(arg_746_1.iconTrs_.gameObject, true)
				arg_746_1.iconController_:SetSelectedState("hero")

				arg_746_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_746_1.callingController_:SetSelectedState("normal")

				arg_746_1.keyicon_.color = Color.New(1, 1, 1)
				arg_746_1.icon_.color = Color.New(1, 1, 1)

				local var_749_3 = arg_746_1:FormatText(arg_746_1:GetWordFromCfg(1108409182).content)

				arg_746_1.text_.text = var_749_3

				LuaForUtil.ClearLinePrefixSymbol(arg_746_1.text_)

				local var_749_5 = 5 <= 0 and var_749_2 or var_749_2 * (utf8.len(var_749_3) / 5)

				if (5 <= 0 and var_749_2 or var_749_2 * (utf8.len(var_749_3) / 5)) > 0 and var_749_2 < var_749_5 then
					arg_746_1.talkMaxDuration = var_749_5

					if var_749_5 + var_749_1 > arg_746_1.duration_ then
						arg_746_1.duration_ = var_749_5 + var_749_1
					end
				end

				arg_746_1.text_.text = var_749_3
				arg_746_1.typewritter.percent = 0

				arg_746_1.typewritter:SetDirty()
				arg_746_1:ShowNextGo(false)
				arg_746_1:RecordContent(arg_746_1.text_.text)
			end

			local var_749_6 = math.max(var_749_2, arg_746_1.talkMaxDuration)

			if var_749_1 <= arg_746_1.time_ and arg_746_1.time_ < var_749_1 + var_749_6 then
				arg_746_1.typewritter.percent = (arg_746_1.time_ - var_749_1) / var_749_6

				arg_746_1.typewritter:SetDirty()
			end

			if arg_746_1.time_ >= var_749_1 + var_749_6 and arg_746_1.time_ < var_749_1 + var_749_6 + arg_749_0 then
				arg_746_1.typewritter.percent = 1

				arg_746_1.typewritter:SetDirty()
				arg_746_1:ShowNextGo(true)
			end
		end

		arg_746_1.nodeConfigList_ = {}

		arg_746_1:InitPlayNodeList()
	end,
	Play1108409183 = function(arg_750_0, arg_750_1)
		arg_750_1.time_ = 0
		arg_750_1.frameCnt_ = 0
		arg_750_1.state_ = "playing"
		arg_750_1.curTalkId_ = 1108409183
		arg_750_1.duration_ = 15

		SetActive(arg_750_1.tipsGo_, false)

		function arg_750_1.onSingleLineFinish_()
			arg_750_1.onSingleLineUpdate_ = nil
			arg_750_1.onSingleLineFinish_ = nil
			arg_750_1.state_ = "waiting"
		end

		function arg_750_1.playNext_(arg_752_0)
			if arg_752_0 == 1 then
				arg_750_0:Play1108409184(arg_750_1)
			end
		end

		function arg_750_1.onSingleLineUpdate_(arg_753_0)
			if 0 < arg_750_1.time_ and arg_750_1.time_ <= 0 + arg_753_0 and not isNil(arg_750_1.actors_["1084ui_story"]) and arg_750_1.var_.characterEffect1084ui_story == nil then
				arg_750_1.var_.characterEffect1084ui_story = arg_750_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_753_0 = 0.200000002980232

			if 0 <= arg_750_1.time_ and arg_750_1.time_ < 0 + var_753_0 and not isNil(arg_750_1.actors_["1084ui_story"]) then
				if arg_750_1.var_.characterEffect1084ui_story and not isNil(arg_750_1.actors_["1084ui_story"]) then
					arg_750_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_750_1.time_ >= 0 + var_753_0 and arg_750_1.time_ < 0 + var_753_0 + arg_753_0 and not isNil(arg_750_1.actors_["1084ui_story"]) and arg_750_1.var_.characterEffect1084ui_story then
				arg_750_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_750_1.time_ and arg_750_1.time_ <= 0 + arg_753_0 then
				arg_750_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action438")
			end

			if 0 < arg_750_1.time_ and arg_750_1.time_ <= 0 + arg_753_0 then
				arg_750_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_753_2 = 0
			local var_753_3 = 1.45

			if 0 < arg_750_1.time_ and arg_750_1.time_ <= var_753_2 + arg_753_0 then
				arg_750_1.talkMaxDuration = 0
				arg_750_1.dialogCg_.alpha = 1

				arg_750_1.dialog_:SetActive(true)
				SetActive(arg_750_1.leftNameGo_, true)

				arg_750_1.leftNameTxt_.text = arg_750_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_750_1.leftNameTxt_.transform)

				arg_750_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_750_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_750_1:RecordName(arg_750_1.leftNameTxt_.text)
				SetActive(arg_750_1.iconTrs_.gameObject, false)
				arg_750_1.callingController_:SetSelectedState("normal")

				local var_753_4 = arg_750_1:GetWordFromCfg(1108409183)
				local var_753_5 = arg_750_1:FormatText(var_753_4.content)

				arg_750_1.text_.text = var_753_5

				LuaForUtil.ClearLinePrefixSymbol(arg_750_1.text_)

				local var_753_7 = 58 <= 0 and var_753_3 or var_753_3 * (utf8.len(var_753_5) / 58)

				if (58 <= 0 and var_753_3 or var_753_3 * (utf8.len(var_753_5) / 58)) > 0 and var_753_3 < var_753_7 then
					arg_750_1.talkMaxDuration = var_753_7

					if var_753_7 + var_753_2 > arg_750_1.duration_ then
						arg_750_1.duration_ = var_753_7 + var_753_2
					end
				end

				arg_750_1.text_.text = var_753_5
				arg_750_1.typewritter.percent = 0

				arg_750_1.typewritter:SetDirty()
				arg_750_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409183", "story_v_side_new_1108409.awb") ~= 0 then
					local var_753_8 = manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409183", "story_v_side_new_1108409.awb") / 1000

					if var_753_8 + var_753_2 > arg_750_1.duration_ then
						arg_750_1.duration_ = var_753_8 + var_753_2
					end

					if var_753_4.prefab_name ~= "" and arg_750_1.actors_[var_753_4.prefab_name] ~= nil then
						local var_753_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_750_1.actors_[var_753_4.prefab_name].transform, "story_v_side_new_1108409", "1108409183", "story_v_side_new_1108409.awb")

						arg_750_1:RecordAudio("1108409183", var_753_9)
						arg_750_1:RecordAudio("1108409183", var_753_9)
					else
						arg_750_1:AudioAction("play", "voice", "story_v_side_new_1108409", "1108409183", "story_v_side_new_1108409.awb")
					end

					arg_750_1:RecordHistoryTalkVoice("story_v_side_new_1108409", "1108409183", "story_v_side_new_1108409.awb")
				end

				arg_750_1:RecordContent(arg_750_1.text_.text)
			end

			local var_753_10 = math.max(var_753_3, arg_750_1.talkMaxDuration)

			if var_753_2 <= arg_750_1.time_ and arg_750_1.time_ < var_753_2 + var_753_10 then
				arg_750_1.typewritter.percent = (arg_750_1.time_ - var_753_2) / var_753_10

				arg_750_1.typewritter:SetDirty()
			end

			if arg_750_1.time_ >= var_753_2 + var_753_10 and arg_750_1.time_ < var_753_2 + var_753_10 + arg_753_0 then
				arg_750_1.typewritter.percent = 1

				arg_750_1.typewritter:SetDirty()
				arg_750_1:ShowNextGo(true)
			end
		end

		arg_750_1.nodeConfigList_ = {}

		arg_750_1:InitPlayNodeList()
	end,
	Play1108409184 = function(arg_754_0, arg_754_1)
		arg_754_1.time_ = 0
		arg_754_1.frameCnt_ = 0
		arg_754_1.state_ = "playing"
		arg_754_1.curTalkId_ = 1108409184
		arg_754_1.duration_ = 5

		SetActive(arg_754_1.tipsGo_, false)

		function arg_754_1.onSingleLineFinish_()
			arg_754_1.onSingleLineUpdate_ = nil
			arg_754_1.onSingleLineFinish_ = nil
			arg_754_1.state_ = "waiting"
		end

		function arg_754_1.playNext_(arg_756_0)
			if arg_756_0 == 1 then
				arg_754_0:Play1108409185(arg_754_1)
			end
		end

		function arg_754_1.onSingleLineUpdate_(arg_757_0)
			if 0 < arg_754_1.time_ and arg_754_1.time_ <= 0 + arg_757_0 and not isNil(arg_754_1.actors_["1084ui_story"]) and arg_754_1.var_.characterEffect1084ui_story == nil then
				arg_754_1.var_.characterEffect1084ui_story = arg_754_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_757_0 = 0.200000002980232

			if 0 <= arg_754_1.time_ and arg_754_1.time_ < 0 + var_757_0 and not isNil(arg_754_1.actors_["1084ui_story"]) then
				if arg_754_1.var_.characterEffect1084ui_story and not isNil(arg_754_1.actors_["1084ui_story"]) then
					arg_754_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_754_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_754_1.time_ - 0) / var_757_0)
				end
			end

			if arg_754_1.time_ >= 0 + var_757_0 and arg_754_1.time_ < 0 + var_757_0 + arg_757_0 and not isNil(arg_754_1.actors_["1084ui_story"]) and arg_754_1.var_.characterEffect1084ui_story then
				arg_754_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_754_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_757_1 = 0
			local var_757_2 = 0.375

			if 0 < arg_754_1.time_ and arg_754_1.time_ <= var_757_1 + arg_757_0 then
				arg_754_1.talkMaxDuration = 0
				arg_754_1.dialogCg_.alpha = 1

				arg_754_1.dialog_:SetActive(true)
				SetActive(arg_754_1.leftNameGo_, true)

				arg_754_1.leftNameTxt_.text = arg_754_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_754_1.leftNameTxt_.transform)

				arg_754_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_754_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_754_1:RecordName(arg_754_1.leftNameTxt_.text)
				SetActive(arg_754_1.iconTrs_.gameObject, true)
				arg_754_1.iconController_:SetSelectedState("hero")

				arg_754_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_754_1.callingController_:SetSelectedState("normal")

				arg_754_1.keyicon_.color = Color.New(1, 1, 1)
				arg_754_1.icon_.color = Color.New(1, 1, 1)

				local var_757_3 = arg_754_1:FormatText(arg_754_1:GetWordFromCfg(1108409184).content)

				arg_754_1.text_.text = var_757_3

				LuaForUtil.ClearLinePrefixSymbol(arg_754_1.text_)

				local var_757_5 = 15 <= 0 and var_757_2 or var_757_2 * (utf8.len(var_757_3) / 15)

				if (15 <= 0 and var_757_2 or var_757_2 * (utf8.len(var_757_3) / 15)) > 0 and var_757_2 < var_757_5 then
					arg_754_1.talkMaxDuration = var_757_5

					if var_757_5 + var_757_1 > arg_754_1.duration_ then
						arg_754_1.duration_ = var_757_5 + var_757_1
					end
				end

				arg_754_1.text_.text = var_757_3
				arg_754_1.typewritter.percent = 0

				arg_754_1.typewritter:SetDirty()
				arg_754_1:ShowNextGo(false)
				arg_754_1:RecordContent(arg_754_1.text_.text)
			end

			local var_757_6 = math.max(var_757_2, arg_754_1.talkMaxDuration)

			if var_757_1 <= arg_754_1.time_ and arg_754_1.time_ < var_757_1 + var_757_6 then
				arg_754_1.typewritter.percent = (arg_754_1.time_ - var_757_1) / var_757_6

				arg_754_1.typewritter:SetDirty()
			end

			if arg_754_1.time_ >= var_757_1 + var_757_6 and arg_754_1.time_ < var_757_1 + var_757_6 + arg_757_0 then
				arg_754_1.typewritter.percent = 1

				arg_754_1.typewritter:SetDirty()
				arg_754_1:ShowNextGo(true)
			end
		end

		arg_754_1.nodeConfigList_ = {}

		arg_754_1:InitPlayNodeList()
	end,
	Play1108409185 = function(arg_758_0, arg_758_1)
		arg_758_1.time_ = 0
		arg_758_1.frameCnt_ = 0
		arg_758_1.state_ = "playing"
		arg_758_1.curTalkId_ = 1108409185
		arg_758_1.duration_ = 3.37

		SetActive(arg_758_1.tipsGo_, false)

		function arg_758_1.onSingleLineFinish_()
			arg_758_1.onSingleLineUpdate_ = nil
			arg_758_1.onSingleLineFinish_ = nil
			arg_758_1.state_ = "waiting"
		end

		function arg_758_1.playNext_(arg_760_0)
			if arg_760_0 == 1 then
				arg_758_0:Play1108409186(arg_758_1)
			end
		end

		function arg_758_1.onSingleLineUpdate_(arg_761_0)
			if 0 < arg_758_1.time_ and arg_758_1.time_ <= 0 + arg_761_0 then
				arg_758_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action485")
			end

			if 0 < arg_758_1.time_ and arg_758_1.time_ <= 0 + arg_761_0 then
				arg_758_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva", "EmotionTimelineAnimator")
			end

			local var_761_0 = arg_758_1.actors_["1084ui_story"]

			if 0 < arg_758_1.time_ and arg_758_1.time_ <= 0 + arg_761_0 and not isNil(var_761_0) and arg_758_1.var_.characterEffect1084ui_story == nil then
				arg_758_1.var_.characterEffect1084ui_story = var_761_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_761_1 = 0.200000002980232

			if 0 <= arg_758_1.time_ and arg_758_1.time_ < 0 + var_761_1 and not isNil(var_761_0) then
				if arg_758_1.var_.characterEffect1084ui_story and not isNil(var_761_0) then
					arg_758_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_758_1.time_ >= 0 + var_761_1 and arg_758_1.time_ < 0 + var_761_1 + arg_761_0 and not isNil(var_761_0) and arg_758_1.var_.characterEffect1084ui_story then
				arg_758_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_761_3 = 0
			local var_761_4 = 0.4

			if 0 < arg_758_1.time_ and arg_758_1.time_ <= var_761_3 + arg_761_0 then
				arg_758_1.talkMaxDuration = 0
				arg_758_1.dialogCg_.alpha = 1

				arg_758_1.dialog_:SetActive(true)
				SetActive(arg_758_1.leftNameGo_, true)

				arg_758_1.leftNameTxt_.text = arg_758_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_758_1.leftNameTxt_.transform)

				arg_758_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_758_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_758_1:RecordName(arg_758_1.leftNameTxt_.text)
				SetActive(arg_758_1.iconTrs_.gameObject, false)
				arg_758_1.callingController_:SetSelectedState("normal")

				local var_761_5 = arg_758_1:GetWordFromCfg(1108409185)
				local var_761_6 = arg_758_1:FormatText(var_761_5.content)

				arg_758_1.text_.text = var_761_6

				LuaForUtil.ClearLinePrefixSymbol(arg_758_1.text_)

				local var_761_8 = 16 <= 0 and var_761_4 or var_761_4 * (utf8.len(var_761_6) / 16)

				if (16 <= 0 and var_761_4 or var_761_4 * (utf8.len(var_761_6) / 16)) > 0 and var_761_4 < var_761_8 then
					arg_758_1.talkMaxDuration = var_761_8

					if var_761_8 + var_761_3 > arg_758_1.duration_ then
						arg_758_1.duration_ = var_761_8 + var_761_3
					end
				end

				arg_758_1.text_.text = var_761_6
				arg_758_1.typewritter.percent = 0

				arg_758_1.typewritter:SetDirty()
				arg_758_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409185", "story_v_side_new_1108409.awb") ~= 0 then
					local var_761_9 = manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409185", "story_v_side_new_1108409.awb") / 1000

					if var_761_9 + var_761_3 > arg_758_1.duration_ then
						arg_758_1.duration_ = var_761_9 + var_761_3
					end

					if var_761_5.prefab_name ~= "" and arg_758_1.actors_[var_761_5.prefab_name] ~= nil then
						local var_761_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_758_1.actors_[var_761_5.prefab_name].transform, "story_v_side_new_1108409", "1108409185", "story_v_side_new_1108409.awb")

						arg_758_1:RecordAudio("1108409185", var_761_10)
						arg_758_1:RecordAudio("1108409185", var_761_10)
					else
						arg_758_1:AudioAction("play", "voice", "story_v_side_new_1108409", "1108409185", "story_v_side_new_1108409.awb")
					end

					arg_758_1:RecordHistoryTalkVoice("story_v_side_new_1108409", "1108409185", "story_v_side_new_1108409.awb")
				end

				arg_758_1:RecordContent(arg_758_1.text_.text)
			end

			local var_761_11 = math.max(var_761_4, arg_758_1.talkMaxDuration)

			if var_761_3 <= arg_758_1.time_ and arg_758_1.time_ < var_761_3 + var_761_11 then
				arg_758_1.typewritter.percent = (arg_758_1.time_ - var_761_3) / var_761_11

				arg_758_1.typewritter:SetDirty()
			end

			if arg_758_1.time_ >= var_761_3 + var_761_11 and arg_758_1.time_ < var_761_3 + var_761_11 + arg_761_0 then
				arg_758_1.typewritter.percent = 1

				arg_758_1.typewritter:SetDirty()
				arg_758_1:ShowNextGo(true)
			end
		end

		arg_758_1.nodeConfigList_ = {}

		arg_758_1:InitPlayNodeList()
	end,
	Play1108409186 = function(arg_762_0, arg_762_1)
		arg_762_1.time_ = 0
		arg_762_1.frameCnt_ = 0
		arg_762_1.state_ = "playing"
		arg_762_1.curTalkId_ = 1108409186
		arg_762_1.duration_ = 5

		SetActive(arg_762_1.tipsGo_, false)

		function arg_762_1.onSingleLineFinish_()
			arg_762_1.onSingleLineUpdate_ = nil
			arg_762_1.onSingleLineFinish_ = nil
			arg_762_1.state_ = "waiting"
		end

		function arg_762_1.playNext_(arg_764_0)
			if arg_764_0 == 1 then
				arg_762_0:Play1108409187(arg_762_1)
			end
		end

		function arg_762_1.onSingleLineUpdate_(arg_765_0)
			if 0 < arg_762_1.time_ and arg_762_1.time_ <= 0 + arg_765_0 and not isNil(arg_762_1.actors_["1084ui_story"]) and arg_762_1.var_.characterEffect1084ui_story == nil then
				arg_762_1.var_.characterEffect1084ui_story = arg_762_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_765_0 = 0.200000002980232

			if 0 <= arg_762_1.time_ and arg_762_1.time_ < 0 + var_765_0 and not isNil(arg_762_1.actors_["1084ui_story"]) then
				if arg_762_1.var_.characterEffect1084ui_story and not isNil(arg_762_1.actors_["1084ui_story"]) then
					arg_762_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_762_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_762_1.time_ - 0) / var_765_0)
				end
			end

			if arg_762_1.time_ >= 0 + var_765_0 and arg_762_1.time_ < 0 + var_765_0 + arg_765_0 and not isNil(arg_762_1.actors_["1084ui_story"]) and arg_762_1.var_.characterEffect1084ui_story then
				arg_762_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_762_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_765_1 = 0
			local var_765_2 = 0.25

			if 0 < arg_762_1.time_ and arg_762_1.time_ <= var_765_1 + arg_765_0 then
				arg_762_1.talkMaxDuration = 0
				arg_762_1.dialogCg_.alpha = 1

				arg_762_1.dialog_:SetActive(true)
				SetActive(arg_762_1.leftNameGo_, true)

				arg_762_1.leftNameTxt_.text = arg_762_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_762_1.leftNameTxt_.transform)

				arg_762_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_762_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_762_1:RecordName(arg_762_1.leftNameTxt_.text)
				SetActive(arg_762_1.iconTrs_.gameObject, true)
				arg_762_1.iconController_:SetSelectedState("hero")

				arg_762_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_762_1.callingController_:SetSelectedState("normal")

				arg_762_1.keyicon_.color = Color.New(1, 1, 1)
				arg_762_1.icon_.color = Color.New(1, 1, 1)

				local var_765_3 = arg_762_1:FormatText(arg_762_1:GetWordFromCfg(1108409186).content)

				arg_762_1.text_.text = var_765_3

				LuaForUtil.ClearLinePrefixSymbol(arg_762_1.text_)

				local var_765_5 = 10 <= 0 and var_765_2 or var_765_2 * (utf8.len(var_765_3) / 10)

				if (10 <= 0 and var_765_2 or var_765_2 * (utf8.len(var_765_3) / 10)) > 0 and var_765_2 < var_765_5 then
					arg_762_1.talkMaxDuration = var_765_5

					if var_765_5 + var_765_1 > arg_762_1.duration_ then
						arg_762_1.duration_ = var_765_5 + var_765_1
					end
				end

				arg_762_1.text_.text = var_765_3
				arg_762_1.typewritter.percent = 0

				arg_762_1.typewritter:SetDirty()
				arg_762_1:ShowNextGo(false)
				arg_762_1:RecordContent(arg_762_1.text_.text)
			end

			local var_765_6 = math.max(var_765_2, arg_762_1.talkMaxDuration)

			if var_765_1 <= arg_762_1.time_ and arg_762_1.time_ < var_765_1 + var_765_6 then
				arg_762_1.typewritter.percent = (arg_762_1.time_ - var_765_1) / var_765_6

				arg_762_1.typewritter:SetDirty()
			end

			if arg_762_1.time_ >= var_765_1 + var_765_6 and arg_762_1.time_ < var_765_1 + var_765_6 + arg_765_0 then
				arg_762_1.typewritter.percent = 1

				arg_762_1.typewritter:SetDirty()
				arg_762_1:ShowNextGo(true)
			end
		end

		arg_762_1.nodeConfigList_ = {}

		arg_762_1:InitPlayNodeList()
	end,
	Play1108409187 = function(arg_766_0, arg_766_1)
		arg_766_1.time_ = 0
		arg_766_1.frameCnt_ = 0
		arg_766_1.state_ = "playing"
		arg_766_1.curTalkId_ = 1108409187
		arg_766_1.duration_ = 5

		SetActive(arg_766_1.tipsGo_, false)

		function arg_766_1.onSingleLineFinish_()
			arg_766_1.onSingleLineUpdate_ = nil
			arg_766_1.onSingleLineFinish_ = nil
			arg_766_1.state_ = "waiting"
		end

		function arg_766_1.playNext_(arg_768_0)
			if arg_768_0 == 1 then
				arg_766_0:Play1108409188(arg_766_1)
			end
		end

		function arg_766_1.onSingleLineUpdate_(arg_769_0)
			local var_769_0 = 1.425

			if 0 < arg_766_1.time_ and arg_766_1.time_ <= 0 + arg_769_0 then
				arg_766_1.talkMaxDuration = 0
				arg_766_1.dialogCg_.alpha = 1

				arg_766_1.dialog_:SetActive(true)
				SetActive(arg_766_1.leftNameGo_, true)

				arg_766_1.leftNameTxt_.text = arg_766_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_766_1.leftNameTxt_.transform)

				arg_766_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_766_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_766_1:RecordName(arg_766_1.leftNameTxt_.text)
				SetActive(arg_766_1.iconTrs_.gameObject, true)
				arg_766_1.iconController_:SetSelectedState("hero")

				arg_766_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_766_1.callingController_:SetSelectedState("normal")

				arg_766_1.keyicon_.color = Color.New(1, 1, 1)
				arg_766_1.icon_.color = Color.New(1, 1, 1)

				local var_769_1 = arg_766_1:FormatText(arg_766_1:GetWordFromCfg(1108409187).content)

				arg_766_1.text_.text = var_769_1

				LuaForUtil.ClearLinePrefixSymbol(arg_766_1.text_)

				local var_769_3 = 57 <= 0 and var_769_0 or var_769_0 * (utf8.len(var_769_1) / 57)

				if (57 <= 0 and var_769_0 or var_769_0 * (utf8.len(var_769_1) / 57)) > 0 and var_769_0 < var_769_3 then
					arg_766_1.talkMaxDuration = var_769_3

					if var_769_3 + 0 > arg_766_1.duration_ then
						arg_766_1.duration_ = var_769_3 + 0
					end
				end

				arg_766_1.text_.text = var_769_1
				arg_766_1.typewritter.percent = 0

				arg_766_1.typewritter:SetDirty()
				arg_766_1:ShowNextGo(false)
				arg_766_1:RecordContent(arg_766_1.text_.text)
			end

			local var_769_4 = math.max(var_769_0, arg_766_1.talkMaxDuration)

			if 0 <= arg_766_1.time_ and arg_766_1.time_ < 0 + var_769_4 then
				arg_766_1.typewritter.percent = (arg_766_1.time_ - 0) / var_769_4

				arg_766_1.typewritter:SetDirty()
			end

			if arg_766_1.time_ >= 0 + var_769_4 and arg_766_1.time_ < 0 + var_769_4 + arg_769_0 then
				arg_766_1.typewritter.percent = 1

				arg_766_1.typewritter:SetDirty()
				arg_766_1:ShowNextGo(true)
			end
		end

		arg_766_1.nodeConfigList_ = {}

		arg_766_1:InitPlayNodeList()
	end,
	Play1108409188 = function(arg_770_0, arg_770_1)
		arg_770_1.time_ = 0
		arg_770_1.frameCnt_ = 0
		arg_770_1.state_ = "playing"
		arg_770_1.curTalkId_ = 1108409188
		arg_770_1.duration_ = 7.4

		SetActive(arg_770_1.tipsGo_, false)

		function arg_770_1.onSingleLineFinish_()
			arg_770_1.onSingleLineUpdate_ = nil
			arg_770_1.onSingleLineFinish_ = nil
			arg_770_1.state_ = "waiting"
		end

		function arg_770_1.playNext_(arg_772_0)
			if arg_772_0 == 1 then
				arg_770_0:Play1108409189(arg_770_1)
			end
		end

		function arg_770_1.onSingleLineUpdate_(arg_773_0)
			if 0 < arg_770_1.time_ and arg_770_1.time_ <= 0 + arg_773_0 and not isNil(arg_770_1.actors_["1084ui_story"]) and arg_770_1.var_.characterEffect1084ui_story == nil then
				arg_770_1.var_.characterEffect1084ui_story = arg_770_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_773_0 = 0.200000002980232

			if 0 <= arg_770_1.time_ and arg_770_1.time_ < 0 + var_773_0 and not isNil(arg_770_1.actors_["1084ui_story"]) then
				if arg_770_1.var_.characterEffect1084ui_story and not isNil(arg_770_1.actors_["1084ui_story"]) then
					arg_770_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_770_1.time_ >= 0 + var_773_0 and arg_770_1.time_ < 0 + var_773_0 + arg_773_0 and not isNil(arg_770_1.actors_["1084ui_story"]) and arg_770_1.var_.characterEffect1084ui_story then
				arg_770_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_770_1.time_ and arg_770_1.time_ <= 0 + arg_773_0 then
				arg_770_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action458")
			end

			if 0 < arg_770_1.time_ and arg_770_1.time_ <= 0 + arg_773_0 then
				arg_770_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_773_2 = 0
			local var_773_3 = 1

			if 0 < arg_770_1.time_ and arg_770_1.time_ <= var_773_2 + arg_773_0 then
				arg_770_1.talkMaxDuration = 0
				arg_770_1.dialogCg_.alpha = 1

				arg_770_1.dialog_:SetActive(true)
				SetActive(arg_770_1.leftNameGo_, true)

				arg_770_1.leftNameTxt_.text = arg_770_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_770_1.leftNameTxt_.transform)

				arg_770_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_770_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_770_1:RecordName(arg_770_1.leftNameTxt_.text)
				SetActive(arg_770_1.iconTrs_.gameObject, false)
				arg_770_1.callingController_:SetSelectedState("normal")

				local var_773_4 = arg_770_1:GetWordFromCfg(1108409188)
				local var_773_5 = arg_770_1:FormatText(var_773_4.content)

				arg_770_1.text_.text = var_773_5

				LuaForUtil.ClearLinePrefixSymbol(arg_770_1.text_)

				local var_773_7 = 40 <= 0 and var_773_3 or var_773_3 * (utf8.len(var_773_5) / 40)

				if (40 <= 0 and var_773_3 or var_773_3 * (utf8.len(var_773_5) / 40)) > 0 and var_773_3 < var_773_7 then
					arg_770_1.talkMaxDuration = var_773_7

					if var_773_7 + var_773_2 > arg_770_1.duration_ then
						arg_770_1.duration_ = var_773_7 + var_773_2
					end
				end

				arg_770_1.text_.text = var_773_5
				arg_770_1.typewritter.percent = 0

				arg_770_1.typewritter:SetDirty()
				arg_770_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409188", "story_v_side_new_1108409.awb") ~= 0 then
					local var_773_8 = manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409188", "story_v_side_new_1108409.awb") / 1000

					if var_773_8 + var_773_2 > arg_770_1.duration_ then
						arg_770_1.duration_ = var_773_8 + var_773_2
					end

					if var_773_4.prefab_name ~= "" and arg_770_1.actors_[var_773_4.prefab_name] ~= nil then
						local var_773_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_770_1.actors_[var_773_4.prefab_name].transform, "story_v_side_new_1108409", "1108409188", "story_v_side_new_1108409.awb")

						arg_770_1:RecordAudio("1108409188", var_773_9)
						arg_770_1:RecordAudio("1108409188", var_773_9)
					else
						arg_770_1:AudioAction("play", "voice", "story_v_side_new_1108409", "1108409188", "story_v_side_new_1108409.awb")
					end

					arg_770_1:RecordHistoryTalkVoice("story_v_side_new_1108409", "1108409188", "story_v_side_new_1108409.awb")
				end

				arg_770_1:RecordContent(arg_770_1.text_.text)
			end

			local var_773_10 = math.max(var_773_3, arg_770_1.talkMaxDuration)

			if var_773_2 <= arg_770_1.time_ and arg_770_1.time_ < var_773_2 + var_773_10 then
				arg_770_1.typewritter.percent = (arg_770_1.time_ - var_773_2) / var_773_10

				arg_770_1.typewritter:SetDirty()
			end

			if arg_770_1.time_ >= var_773_2 + var_773_10 and arg_770_1.time_ < var_773_2 + var_773_10 + arg_773_0 then
				arg_770_1.typewritter.percent = 1

				arg_770_1.typewritter:SetDirty()
				arg_770_1:ShowNextGo(true)
			end
		end

		arg_770_1.nodeConfigList_ = {}

		arg_770_1:InitPlayNodeList()
	end,
	Play1108409189 = function(arg_774_0, arg_774_1)
		arg_774_1.time_ = 0
		arg_774_1.frameCnt_ = 0
		arg_774_1.state_ = "playing"
		arg_774_1.curTalkId_ = 1108409189
		arg_774_1.duration_ = 5

		SetActive(arg_774_1.tipsGo_, false)

		function arg_774_1.onSingleLineFinish_()
			arg_774_1.onSingleLineUpdate_ = nil
			arg_774_1.onSingleLineFinish_ = nil
			arg_774_1.state_ = "waiting"
		end

		function arg_774_1.playNext_(arg_776_0)
			if arg_776_0 == 1 then
				arg_774_0:Play1108409190(arg_774_1)
			end
		end

		function arg_774_1.onSingleLineUpdate_(arg_777_0)
			if 0 < arg_774_1.time_ and arg_774_1.time_ <= 0 + arg_777_0 and not isNil(arg_774_1.actors_["1084ui_story"]) and arg_774_1.var_.characterEffect1084ui_story == nil then
				arg_774_1.var_.characterEffect1084ui_story = arg_774_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_777_0 = 0.200000002980232

			if 0 <= arg_774_1.time_ and arg_774_1.time_ < 0 + var_777_0 and not isNil(arg_774_1.actors_["1084ui_story"]) then
				if arg_774_1.var_.characterEffect1084ui_story and not isNil(arg_774_1.actors_["1084ui_story"]) then
					arg_774_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_774_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_774_1.time_ - 0) / var_777_0)
				end
			end

			if arg_774_1.time_ >= 0 + var_777_0 and arg_774_1.time_ < 0 + var_777_0 + arg_777_0 and not isNil(arg_774_1.actors_["1084ui_story"]) and arg_774_1.var_.characterEffect1084ui_story then
				arg_774_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_774_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_777_1 = 0
			local var_777_2 = 1.4

			if 0 < arg_774_1.time_ and arg_774_1.time_ <= var_777_1 + arg_777_0 then
				arg_774_1.talkMaxDuration = 0
				arg_774_1.dialogCg_.alpha = 1

				arg_774_1.dialog_:SetActive(true)
				SetActive(arg_774_1.leftNameGo_, true)

				arg_774_1.leftNameTxt_.text = arg_774_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_774_1.leftNameTxt_.transform)

				arg_774_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_774_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_774_1:RecordName(arg_774_1.leftNameTxt_.text)
				SetActive(arg_774_1.iconTrs_.gameObject, true)
				arg_774_1.iconController_:SetSelectedState("hero")

				arg_774_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_774_1.callingController_:SetSelectedState("normal")

				arg_774_1.keyicon_.color = Color.New(1, 1, 1)
				arg_774_1.icon_.color = Color.New(1, 1, 1)

				local var_777_3 = arg_774_1:FormatText(arg_774_1:GetWordFromCfg(1108409189).content)

				arg_774_1.text_.text = var_777_3

				LuaForUtil.ClearLinePrefixSymbol(arg_774_1.text_)

				local var_777_5 = 56 <= 0 and var_777_2 or var_777_2 * (utf8.len(var_777_3) / 56)

				if (56 <= 0 and var_777_2 or var_777_2 * (utf8.len(var_777_3) / 56)) > 0 and var_777_2 < var_777_5 then
					arg_774_1.talkMaxDuration = var_777_5

					if var_777_5 + var_777_1 > arg_774_1.duration_ then
						arg_774_1.duration_ = var_777_5 + var_777_1
					end
				end

				arg_774_1.text_.text = var_777_3
				arg_774_1.typewritter.percent = 0

				arg_774_1.typewritter:SetDirty()
				arg_774_1:ShowNextGo(false)
				arg_774_1:RecordContent(arg_774_1.text_.text)
			end

			local var_777_6 = math.max(var_777_2, arg_774_1.talkMaxDuration)

			if var_777_1 <= arg_774_1.time_ and arg_774_1.time_ < var_777_1 + var_777_6 then
				arg_774_1.typewritter.percent = (arg_774_1.time_ - var_777_1) / var_777_6

				arg_774_1.typewritter:SetDirty()
			end

			if arg_774_1.time_ >= var_777_1 + var_777_6 and arg_774_1.time_ < var_777_1 + var_777_6 + arg_777_0 then
				arg_774_1.typewritter.percent = 1

				arg_774_1.typewritter:SetDirty()
				arg_774_1:ShowNextGo(true)
			end
		end

		arg_774_1.nodeConfigList_ = {}

		arg_774_1:InitPlayNodeList()
	end,
	Play1108409190 = function(arg_778_0, arg_778_1)
		arg_778_1.time_ = 0
		arg_778_1.frameCnt_ = 0
		arg_778_1.state_ = "playing"
		arg_778_1.curTalkId_ = 1108409190
		arg_778_1.duration_ = 13.17

		SetActive(arg_778_1.tipsGo_, false)

		function arg_778_1.onSingleLineFinish_()
			arg_778_1.onSingleLineUpdate_ = nil
			arg_778_1.onSingleLineFinish_ = nil
			arg_778_1.state_ = "waiting"
		end

		function arg_778_1.playNext_(arg_780_0)
			if arg_780_0 == 1 then
				arg_778_0:Play1108409191(arg_778_1)
			end
		end

		function arg_778_1.onSingleLineUpdate_(arg_781_0)
			if 0 < arg_778_1.time_ and arg_778_1.time_ <= 0 + arg_781_0 and not isNil(arg_778_1.actors_["1084ui_story"]) and arg_778_1.var_.characterEffect1084ui_story == nil then
				arg_778_1.var_.characterEffect1084ui_story = arg_778_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_781_0 = 0.200000002980232

			if 0 <= arg_778_1.time_ and arg_778_1.time_ < 0 + var_781_0 and not isNil(arg_778_1.actors_["1084ui_story"]) then
				if arg_778_1.var_.characterEffect1084ui_story and not isNil(arg_778_1.actors_["1084ui_story"]) then
					arg_778_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_778_1.time_ >= 0 + var_781_0 and arg_778_1.time_ < 0 + var_781_0 + arg_781_0 and not isNil(arg_778_1.actors_["1084ui_story"]) and arg_778_1.var_.characterEffect1084ui_story then
				arg_778_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_778_1.time_ and arg_778_1.time_ <= 0 + arg_781_0 then
				arg_778_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action486")
			end

			if 0 < arg_778_1.time_ and arg_778_1.time_ <= 0 + arg_781_0 then
				arg_778_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_781_2 = 0
			local var_781_3 = 1.075

			if 0 < arg_778_1.time_ and arg_778_1.time_ <= var_781_2 + arg_781_0 then
				arg_778_1.talkMaxDuration = 0
				arg_778_1.dialogCg_.alpha = 1

				arg_778_1.dialog_:SetActive(true)
				SetActive(arg_778_1.leftNameGo_, true)

				arg_778_1.leftNameTxt_.text = arg_778_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_778_1.leftNameTxt_.transform)

				arg_778_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_778_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_778_1:RecordName(arg_778_1.leftNameTxt_.text)
				SetActive(arg_778_1.iconTrs_.gameObject, false)
				arg_778_1.callingController_:SetSelectedState("normal")

				local var_781_4 = arg_778_1:GetWordFromCfg(1108409190)
				local var_781_5 = arg_778_1:FormatText(var_781_4.content)

				arg_778_1.text_.text = var_781_5

				LuaForUtil.ClearLinePrefixSymbol(arg_778_1.text_)

				local var_781_7 = 43 <= 0 and var_781_3 or var_781_3 * (utf8.len(var_781_5) / 43)

				if (43 <= 0 and var_781_3 or var_781_3 * (utf8.len(var_781_5) / 43)) > 0 and var_781_3 < var_781_7 then
					arg_778_1.talkMaxDuration = var_781_7

					if var_781_7 + var_781_2 > arg_778_1.duration_ then
						arg_778_1.duration_ = var_781_7 + var_781_2
					end
				end

				arg_778_1.text_.text = var_781_5
				arg_778_1.typewritter.percent = 0

				arg_778_1.typewritter:SetDirty()
				arg_778_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409190", "story_v_side_new_1108409.awb") ~= 0 then
					local var_781_8 = manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409190", "story_v_side_new_1108409.awb") / 1000

					if var_781_8 + var_781_2 > arg_778_1.duration_ then
						arg_778_1.duration_ = var_781_8 + var_781_2
					end

					if var_781_4.prefab_name ~= "" and arg_778_1.actors_[var_781_4.prefab_name] ~= nil then
						local var_781_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_778_1.actors_[var_781_4.prefab_name].transform, "story_v_side_new_1108409", "1108409190", "story_v_side_new_1108409.awb")

						arg_778_1:RecordAudio("1108409190", var_781_9)
						arg_778_1:RecordAudio("1108409190", var_781_9)
					else
						arg_778_1:AudioAction("play", "voice", "story_v_side_new_1108409", "1108409190", "story_v_side_new_1108409.awb")
					end

					arg_778_1:RecordHistoryTalkVoice("story_v_side_new_1108409", "1108409190", "story_v_side_new_1108409.awb")
				end

				arg_778_1:RecordContent(arg_778_1.text_.text)
			end

			local var_781_10 = math.max(var_781_3, arg_778_1.talkMaxDuration)

			if var_781_2 <= arg_778_1.time_ and arg_778_1.time_ < var_781_2 + var_781_10 then
				arg_778_1.typewritter.percent = (arg_778_1.time_ - var_781_2) / var_781_10

				arg_778_1.typewritter:SetDirty()
			end

			if arg_778_1.time_ >= var_781_2 + var_781_10 and arg_778_1.time_ < var_781_2 + var_781_10 + arg_781_0 then
				arg_778_1.typewritter.percent = 1

				arg_778_1.typewritter:SetDirty()
				arg_778_1:ShowNextGo(true)
			end
		end

		arg_778_1.nodeConfigList_ = {}

		arg_778_1:InitPlayNodeList()
	end,
	Play1108409191 = function(arg_782_0, arg_782_1)
		arg_782_1.time_ = 0
		arg_782_1.frameCnt_ = 0
		arg_782_1.state_ = "playing"
		arg_782_1.curTalkId_ = 1108409191
		arg_782_1.duration_ = 5

		SetActive(arg_782_1.tipsGo_, false)

		function arg_782_1.onSingleLineFinish_()
			arg_782_1.onSingleLineUpdate_ = nil
			arg_782_1.onSingleLineFinish_ = nil
			arg_782_1.state_ = "waiting"
		end

		function arg_782_1.playNext_(arg_784_0)
			if arg_784_0 == 1 then
				arg_782_0:Play1108409192(arg_782_1)
			end
		end

		function arg_782_1.onSingleLineUpdate_(arg_785_0)
			if 0 < arg_782_1.time_ and arg_782_1.time_ <= 0 + arg_785_0 and not isNil(arg_782_1.actors_["1084ui_story"]) and arg_782_1.var_.characterEffect1084ui_story == nil then
				arg_782_1.var_.characterEffect1084ui_story = arg_782_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_785_0 = 0.200000002980232

			if 0 <= arg_782_1.time_ and arg_782_1.time_ < 0 + var_785_0 and not isNil(arg_782_1.actors_["1084ui_story"]) then
				if arg_782_1.var_.characterEffect1084ui_story and not isNil(arg_782_1.actors_["1084ui_story"]) then
					arg_782_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_782_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_782_1.time_ - 0) / var_785_0)
				end
			end

			if arg_782_1.time_ >= 0 + var_785_0 and arg_782_1.time_ < 0 + var_785_0 + arg_785_0 and not isNil(arg_782_1.actors_["1084ui_story"]) and arg_782_1.var_.characterEffect1084ui_story then
				arg_782_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_782_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_785_1 = 0
			local var_785_2 = 0.75

			if 0 < arg_782_1.time_ and arg_782_1.time_ <= var_785_1 + arg_785_0 then
				arg_782_1.talkMaxDuration = 0
				arg_782_1.dialogCg_.alpha = 1

				arg_782_1.dialog_:SetActive(true)
				SetActive(arg_782_1.leftNameGo_, true)

				arg_782_1.leftNameTxt_.text = arg_782_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_782_1.leftNameTxt_.transform)

				arg_782_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_782_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_782_1:RecordName(arg_782_1.leftNameTxt_.text)
				SetActive(arg_782_1.iconTrs_.gameObject, true)
				arg_782_1.iconController_:SetSelectedState("hero")

				arg_782_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_782_1.callingController_:SetSelectedState("normal")

				arg_782_1.keyicon_.color = Color.New(1, 1, 1)
				arg_782_1.icon_.color = Color.New(1, 1, 1)

				local var_785_3 = arg_782_1:FormatText(arg_782_1:GetWordFromCfg(1108409191).content)

				arg_782_1.text_.text = var_785_3

				LuaForUtil.ClearLinePrefixSymbol(arg_782_1.text_)

				local var_785_5 = 30 <= 0 and var_785_2 or var_785_2 * (utf8.len(var_785_3) / 30)

				if (30 <= 0 and var_785_2 or var_785_2 * (utf8.len(var_785_3) / 30)) > 0 and var_785_2 < var_785_5 then
					arg_782_1.talkMaxDuration = var_785_5

					if var_785_5 + var_785_1 > arg_782_1.duration_ then
						arg_782_1.duration_ = var_785_5 + var_785_1
					end
				end

				arg_782_1.text_.text = var_785_3
				arg_782_1.typewritter.percent = 0

				arg_782_1.typewritter:SetDirty()
				arg_782_1:ShowNextGo(false)
				arg_782_1:RecordContent(arg_782_1.text_.text)
			end

			local var_785_6 = math.max(var_785_2, arg_782_1.talkMaxDuration)

			if var_785_1 <= arg_782_1.time_ and arg_782_1.time_ < var_785_1 + var_785_6 then
				arg_782_1.typewritter.percent = (arg_782_1.time_ - var_785_1) / var_785_6

				arg_782_1.typewritter:SetDirty()
			end

			if arg_782_1.time_ >= var_785_1 + var_785_6 and arg_782_1.time_ < var_785_1 + var_785_6 + arg_785_0 then
				arg_782_1.typewritter.percent = 1

				arg_782_1.typewritter:SetDirty()
				arg_782_1:ShowNextGo(true)
			end
		end

		arg_782_1.nodeConfigList_ = {}

		arg_782_1:InitPlayNodeList()
	end,
	Play1108409192 = function(arg_786_0, arg_786_1)
		arg_786_1.time_ = 0
		arg_786_1.frameCnt_ = 0
		arg_786_1.state_ = "playing"
		arg_786_1.curTalkId_ = 1108409192
		arg_786_1.duration_ = 2.43

		SetActive(arg_786_1.tipsGo_, false)

		function arg_786_1.onSingleLineFinish_()
			arg_786_1.onSingleLineUpdate_ = nil
			arg_786_1.onSingleLineFinish_ = nil
			arg_786_1.state_ = "waiting"
		end

		function arg_786_1.playNext_(arg_788_0)
			if arg_788_0 == 1 then
				arg_786_0:Play1108409193(arg_786_1)
			end
		end

		function arg_786_1.onSingleLineUpdate_(arg_789_0)
			if 0 < arg_786_1.time_ and arg_786_1.time_ <= 0 + arg_789_0 and not isNil(arg_786_1.actors_["1084ui_story"]) and arg_786_1.var_.characterEffect1084ui_story == nil then
				arg_786_1.var_.characterEffect1084ui_story = arg_786_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_789_0 = 0.200000002980232

			if 0 <= arg_786_1.time_ and arg_786_1.time_ < 0 + var_789_0 and not isNil(arg_786_1.actors_["1084ui_story"]) then
				if arg_786_1.var_.characterEffect1084ui_story and not isNil(arg_786_1.actors_["1084ui_story"]) then
					arg_786_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_786_1.time_ >= 0 + var_789_0 and arg_786_1.time_ < 0 + var_789_0 + arg_789_0 and not isNil(arg_786_1.actors_["1084ui_story"]) and arg_786_1.var_.characterEffect1084ui_story then
				arg_786_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_786_1.time_ and arg_786_1.time_ <= 0 + arg_789_0 then
				arg_786_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action6_2")
			end

			if 0 < arg_786_1.time_ and arg_786_1.time_ <= 0 + arg_789_0 then
				arg_786_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_789_2 = 0
			local var_789_3 = 0.25

			if 0 < arg_786_1.time_ and arg_786_1.time_ <= var_789_2 + arg_789_0 then
				arg_786_1.talkMaxDuration = 0
				arg_786_1.dialogCg_.alpha = 1

				arg_786_1.dialog_:SetActive(true)
				SetActive(arg_786_1.leftNameGo_, true)

				arg_786_1.leftNameTxt_.text = arg_786_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_786_1.leftNameTxt_.transform)

				arg_786_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_786_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_786_1:RecordName(arg_786_1.leftNameTxt_.text)
				SetActive(arg_786_1.iconTrs_.gameObject, false)
				arg_786_1.callingController_:SetSelectedState("normal")

				local var_789_4 = arg_786_1:GetWordFromCfg(1108409192)
				local var_789_5 = arg_786_1:FormatText(var_789_4.content)

				arg_786_1.text_.text = var_789_5

				LuaForUtil.ClearLinePrefixSymbol(arg_786_1.text_)

				local var_789_7 = 10 <= 0 and var_789_3 or var_789_3 * (utf8.len(var_789_5) / 10)

				if (10 <= 0 and var_789_3 or var_789_3 * (utf8.len(var_789_5) / 10)) > 0 and var_789_3 < var_789_7 then
					arg_786_1.talkMaxDuration = var_789_7

					if var_789_7 + var_789_2 > arg_786_1.duration_ then
						arg_786_1.duration_ = var_789_7 + var_789_2
					end
				end

				arg_786_1.text_.text = var_789_5
				arg_786_1.typewritter.percent = 0

				arg_786_1.typewritter:SetDirty()
				arg_786_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409192", "story_v_side_new_1108409.awb") ~= 0 then
					local var_789_8 = manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409192", "story_v_side_new_1108409.awb") / 1000

					if var_789_8 + var_789_2 > arg_786_1.duration_ then
						arg_786_1.duration_ = var_789_8 + var_789_2
					end

					if var_789_4.prefab_name ~= "" and arg_786_1.actors_[var_789_4.prefab_name] ~= nil then
						local var_789_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_786_1.actors_[var_789_4.prefab_name].transform, "story_v_side_new_1108409", "1108409192", "story_v_side_new_1108409.awb")

						arg_786_1:RecordAudio("1108409192", var_789_9)
						arg_786_1:RecordAudio("1108409192", var_789_9)
					else
						arg_786_1:AudioAction("play", "voice", "story_v_side_new_1108409", "1108409192", "story_v_side_new_1108409.awb")
					end

					arg_786_1:RecordHistoryTalkVoice("story_v_side_new_1108409", "1108409192", "story_v_side_new_1108409.awb")
				end

				arg_786_1:RecordContent(arg_786_1.text_.text)
			end

			local var_789_10 = math.max(var_789_3, arg_786_1.talkMaxDuration)

			if var_789_2 <= arg_786_1.time_ and arg_786_1.time_ < var_789_2 + var_789_10 then
				arg_786_1.typewritter.percent = (arg_786_1.time_ - var_789_2) / var_789_10

				arg_786_1.typewritter:SetDirty()
			end

			if arg_786_1.time_ >= var_789_2 + var_789_10 and arg_786_1.time_ < var_789_2 + var_789_10 + arg_789_0 then
				arg_786_1.typewritter.percent = 1

				arg_786_1.typewritter:SetDirty()
				arg_786_1:ShowNextGo(true)
			end
		end

		arg_786_1.nodeConfigList_ = {}

		arg_786_1:InitPlayNodeList()
	end,
	Play1108409193 = function(arg_790_0, arg_790_1)
		arg_790_1.time_ = 0
		arg_790_1.frameCnt_ = 0
		arg_790_1.state_ = "playing"
		arg_790_1.curTalkId_ = 1108409193
		arg_790_1.duration_ = 5

		SetActive(arg_790_1.tipsGo_, false)

		function arg_790_1.onSingleLineFinish_()
			arg_790_1.onSingleLineUpdate_ = nil
			arg_790_1.onSingleLineFinish_ = nil
			arg_790_1.state_ = "waiting"
		end

		function arg_790_1.playNext_(arg_792_0)
			if arg_792_0 == 1 then
				arg_790_0:Play1108409194(arg_790_1)
			end
		end

		function arg_790_1.onSingleLineUpdate_(arg_793_0)
			if 0 < arg_790_1.time_ and arg_790_1.time_ <= 0 + arg_793_0 and not isNil(arg_790_1.actors_["1084ui_story"]) and arg_790_1.var_.characterEffect1084ui_story == nil then
				arg_790_1.var_.characterEffect1084ui_story = arg_790_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_793_0 = 0.200000002980232

			if 0 <= arg_790_1.time_ and arg_790_1.time_ < 0 + var_793_0 and not isNil(arg_790_1.actors_["1084ui_story"]) then
				if arg_790_1.var_.characterEffect1084ui_story and not isNil(arg_790_1.actors_["1084ui_story"]) then
					arg_790_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_790_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_790_1.time_ - 0) / var_793_0)
				end
			end

			if arg_790_1.time_ >= 0 + var_793_0 and arg_790_1.time_ < 0 + var_793_0 + arg_793_0 and not isNil(arg_790_1.actors_["1084ui_story"]) and arg_790_1.var_.characterEffect1084ui_story then
				arg_790_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_790_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_793_1 = 0
			local var_793_2 = 1.125

			if 0 < arg_790_1.time_ and arg_790_1.time_ <= var_793_1 + arg_793_0 then
				arg_790_1.talkMaxDuration = 0
				arg_790_1.dialogCg_.alpha = 1

				arg_790_1.dialog_:SetActive(true)
				SetActive(arg_790_1.leftNameGo_, true)

				arg_790_1.leftNameTxt_.text = arg_790_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_790_1.leftNameTxt_.transform)

				arg_790_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_790_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_790_1:RecordName(arg_790_1.leftNameTxt_.text)
				SetActive(arg_790_1.iconTrs_.gameObject, true)
				arg_790_1.iconController_:SetSelectedState("hero")

				arg_790_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_790_1.callingController_:SetSelectedState("normal")

				arg_790_1.keyicon_.color = Color.New(1, 1, 1)
				arg_790_1.icon_.color = Color.New(1, 1, 1)

				local var_793_3 = arg_790_1:FormatText(arg_790_1:GetWordFromCfg(1108409193).content)

				arg_790_1.text_.text = var_793_3

				LuaForUtil.ClearLinePrefixSymbol(arg_790_1.text_)

				local var_793_5 = 45 <= 0 and var_793_2 or var_793_2 * (utf8.len(var_793_3) / 45)

				if (45 <= 0 and var_793_2 or var_793_2 * (utf8.len(var_793_3) / 45)) > 0 and var_793_2 < var_793_5 then
					arg_790_1.talkMaxDuration = var_793_5

					if var_793_5 + var_793_1 > arg_790_1.duration_ then
						arg_790_1.duration_ = var_793_5 + var_793_1
					end
				end

				arg_790_1.text_.text = var_793_3
				arg_790_1.typewritter.percent = 0

				arg_790_1.typewritter:SetDirty()
				arg_790_1:ShowNextGo(false)
				arg_790_1:RecordContent(arg_790_1.text_.text)
			end

			local var_793_6 = math.max(var_793_2, arg_790_1.talkMaxDuration)

			if var_793_1 <= arg_790_1.time_ and arg_790_1.time_ < var_793_1 + var_793_6 then
				arg_790_1.typewritter.percent = (arg_790_1.time_ - var_793_1) / var_793_6

				arg_790_1.typewritter:SetDirty()
			end

			if arg_790_1.time_ >= var_793_1 + var_793_6 and arg_790_1.time_ < var_793_1 + var_793_6 + arg_793_0 then
				arg_790_1.typewritter.percent = 1

				arg_790_1.typewritter:SetDirty()
				arg_790_1:ShowNextGo(true)
			end
		end

		arg_790_1.nodeConfigList_ = {}

		arg_790_1:InitPlayNodeList()
	end,
	Play1108409194 = function(arg_794_0, arg_794_1)
		arg_794_1.time_ = 0
		arg_794_1.frameCnt_ = 0
		arg_794_1.state_ = "playing"
		arg_794_1.curTalkId_ = 1108409194
		arg_794_1.duration_ = 10.5

		SetActive(arg_794_1.tipsGo_, false)

		function arg_794_1.onSingleLineFinish_()
			arg_794_1.onSingleLineUpdate_ = nil
			arg_794_1.onSingleLineFinish_ = nil
			arg_794_1.state_ = "waiting"
		end

		function arg_794_1.playNext_(arg_796_0)
			if arg_796_0 == 1 then
				arg_794_0:Play1108409195(arg_794_1)
			end
		end

		function arg_794_1.onSingleLineUpdate_(arg_797_0)
			if 0 < arg_794_1.time_ and arg_794_1.time_ <= 0 + arg_797_0 and not isNil(arg_794_1.actors_["1084ui_story"]) and arg_794_1.var_.characterEffect1084ui_story == nil then
				arg_794_1.var_.characterEffect1084ui_story = arg_794_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_797_0 = 0.200000002980232

			if 0 <= arg_794_1.time_ and arg_794_1.time_ < 0 + var_797_0 and not isNil(arg_794_1.actors_["1084ui_story"]) then
				if arg_794_1.var_.characterEffect1084ui_story and not isNil(arg_794_1.actors_["1084ui_story"]) then
					arg_794_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_794_1.time_ >= 0 + var_797_0 and arg_794_1.time_ < 0 + var_797_0 + arg_797_0 and not isNil(arg_794_1.actors_["1084ui_story"]) and arg_794_1.var_.characterEffect1084ui_story then
				arg_794_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_794_1.time_ and arg_794_1.time_ <= 0 + arg_797_0 then
				arg_794_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action4_1")
			end

			if 0 < arg_794_1.time_ and arg_794_1.time_ <= 0 + arg_797_0 then
				arg_794_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_797_2 = 0
			local var_797_3 = 0.825

			if 0 < arg_794_1.time_ and arg_794_1.time_ <= var_797_2 + arg_797_0 then
				arg_794_1.talkMaxDuration = 0
				arg_794_1.dialogCg_.alpha = 1

				arg_794_1.dialog_:SetActive(true)
				SetActive(arg_794_1.leftNameGo_, true)

				arg_794_1.leftNameTxt_.text = arg_794_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_794_1.leftNameTxt_.transform)

				arg_794_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_794_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_794_1:RecordName(arg_794_1.leftNameTxt_.text)
				SetActive(arg_794_1.iconTrs_.gameObject, false)
				arg_794_1.callingController_:SetSelectedState("normal")

				local var_797_4 = arg_794_1:GetWordFromCfg(1108409194)
				local var_797_5 = arg_794_1:FormatText(var_797_4.content)

				arg_794_1.text_.text = var_797_5

				LuaForUtil.ClearLinePrefixSymbol(arg_794_1.text_)

				local var_797_7 = 33 <= 0 and var_797_3 or var_797_3 * (utf8.len(var_797_5) / 33)

				if (33 <= 0 and var_797_3 or var_797_3 * (utf8.len(var_797_5) / 33)) > 0 and var_797_3 < var_797_7 then
					arg_794_1.talkMaxDuration = var_797_7

					if var_797_7 + var_797_2 > arg_794_1.duration_ then
						arg_794_1.duration_ = var_797_7 + var_797_2
					end
				end

				arg_794_1.text_.text = var_797_5
				arg_794_1.typewritter.percent = 0

				arg_794_1.typewritter:SetDirty()
				arg_794_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409194", "story_v_side_new_1108409.awb") ~= 0 then
					local var_797_8 = manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409194", "story_v_side_new_1108409.awb") / 1000

					if var_797_8 + var_797_2 > arg_794_1.duration_ then
						arg_794_1.duration_ = var_797_8 + var_797_2
					end

					if var_797_4.prefab_name ~= "" and arg_794_1.actors_[var_797_4.prefab_name] ~= nil then
						local var_797_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_794_1.actors_[var_797_4.prefab_name].transform, "story_v_side_new_1108409", "1108409194", "story_v_side_new_1108409.awb")

						arg_794_1:RecordAudio("1108409194", var_797_9)
						arg_794_1:RecordAudio("1108409194", var_797_9)
					else
						arg_794_1:AudioAction("play", "voice", "story_v_side_new_1108409", "1108409194", "story_v_side_new_1108409.awb")
					end

					arg_794_1:RecordHistoryTalkVoice("story_v_side_new_1108409", "1108409194", "story_v_side_new_1108409.awb")
				end

				arg_794_1:RecordContent(arg_794_1.text_.text)
			end

			local var_797_10 = math.max(var_797_3, arg_794_1.talkMaxDuration)

			if var_797_2 <= arg_794_1.time_ and arg_794_1.time_ < var_797_2 + var_797_10 then
				arg_794_1.typewritter.percent = (arg_794_1.time_ - var_797_2) / var_797_10

				arg_794_1.typewritter:SetDirty()
			end

			if arg_794_1.time_ >= var_797_2 + var_797_10 and arg_794_1.time_ < var_797_2 + var_797_10 + arg_797_0 then
				arg_794_1.typewritter.percent = 1

				arg_794_1.typewritter:SetDirty()
				arg_794_1:ShowNextGo(true)
			end
		end

		arg_794_1.nodeConfigList_ = {}

		arg_794_1:InitPlayNodeList()
	end,
	Play1108409195 = function(arg_798_0, arg_798_1)
		arg_798_1.time_ = 0
		arg_798_1.frameCnt_ = 0
		arg_798_1.state_ = "playing"
		arg_798_1.curTalkId_ = 1108409195
		arg_798_1.duration_ = 5

		SetActive(arg_798_1.tipsGo_, false)

		function arg_798_1.onSingleLineFinish_()
			arg_798_1.onSingleLineUpdate_ = nil
			arg_798_1.onSingleLineFinish_ = nil
			arg_798_1.state_ = "waiting"
		end

		function arg_798_1.playNext_(arg_800_0)
			if arg_800_0 == 1 then
				arg_798_0:Play1108409196(arg_798_1)
			end
		end

		function arg_798_1.onSingleLineUpdate_(arg_801_0)
			if 0 < arg_798_1.time_ and arg_798_1.time_ <= 0 + arg_801_0 then
				arg_798_1.var_.moveOldPos1084ui_story = arg_798_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_801_0 = 0.001

			if 0 <= arg_798_1.time_ and arg_798_1.time_ < 0 + var_801_0 then
				arg_798_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_798_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_798_1.time_ - 0) / var_801_0)
				arg_798_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_798_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_798_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_798_1.actors_["1084ui_story"].transform.position).z)
				arg_798_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_798_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_798_1.actors_["1084ui_story"].transform.localEulerAngles = arg_798_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_798_1.time_ >= 0 + var_801_0 and arg_798_1.time_ < 0 + var_801_0 + arg_801_0 then
				arg_798_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_798_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_798_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_798_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_798_1.actors_["1084ui_story"].transform.position).z)
				arg_798_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_798_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_798_1.actors_["1084ui_story"].transform.localEulerAngles = arg_798_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_801_1 = arg_798_1.actors_["1084ui_story"]

			if 0 < arg_798_1.time_ and arg_798_1.time_ <= 0 + arg_801_0 and not isNil(var_801_1) and arg_798_1.var_.characterEffect1084ui_story == nil then
				arg_798_1.var_.characterEffect1084ui_story = var_801_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_801_2 = 0.200000002980232

			if 0 <= arg_798_1.time_ and arg_798_1.time_ < 0 + var_801_2 and not isNil(var_801_1) then
				if arg_798_1.var_.characterEffect1084ui_story and not isNil(var_801_1) then
					arg_798_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_798_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_798_1.time_ - 0) / var_801_2)
				end
			end

			if arg_798_1.time_ >= 0 + var_801_2 and arg_798_1.time_ < 0 + var_801_2 + arg_801_0 and not isNil(var_801_1) and arg_798_1.var_.characterEffect1084ui_story then
				arg_798_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_798_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_801_3 = 0
			local var_801_4 = 0.675

			if 0 < arg_798_1.time_ and arg_798_1.time_ <= var_801_3 + arg_801_0 then
				arg_798_1.talkMaxDuration = 0
				arg_798_1.dialogCg_.alpha = 1

				arg_798_1.dialog_:SetActive(true)
				SetActive(arg_798_1.leftNameGo_, false)

				arg_798_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_798_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_798_1:RecordName(arg_798_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_798_1.iconTrs_.gameObject, false)
				arg_798_1.callingController_:SetSelectedState("normal")

				local var_801_5 = arg_798_1:FormatText(arg_798_1:GetWordFromCfg(1108409195).content)

				arg_798_1.text_.text = var_801_5

				LuaForUtil.ClearLinePrefixSymbol(arg_798_1.text_)

				local var_801_7 = 27 <= 0 and var_801_4 or var_801_4 * (utf8.len(var_801_5) / 27)

				if (27 <= 0 and var_801_4 or var_801_4 * (utf8.len(var_801_5) / 27)) > 0 and var_801_4 < var_801_7 then
					arg_798_1.talkMaxDuration = var_801_7

					if var_801_7 + var_801_3 > arg_798_1.duration_ then
						arg_798_1.duration_ = var_801_7 + var_801_3
					end
				end

				arg_798_1.text_.text = var_801_5
				arg_798_1.typewritter.percent = 0

				arg_798_1.typewritter:SetDirty()
				arg_798_1:ShowNextGo(false)
				arg_798_1:RecordContent(arg_798_1.text_.text)
			end

			local var_801_8 = math.max(var_801_4, arg_798_1.talkMaxDuration)

			if var_801_3 <= arg_798_1.time_ and arg_798_1.time_ < var_801_3 + var_801_8 then
				arg_798_1.typewritter.percent = (arg_798_1.time_ - var_801_3) / var_801_8

				arg_798_1.typewritter:SetDirty()
			end

			if arg_798_1.time_ >= var_801_3 + var_801_8 and arg_798_1.time_ < var_801_3 + var_801_8 + arg_801_0 then
				arg_798_1.typewritter.percent = 1

				arg_798_1.typewritter:SetDirty()
				arg_798_1:ShowNextGo(true)
			end
		end

		arg_798_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_798_1:InitPlayNodeList()
	end,
	Play1108409196 = function(arg_802_0, arg_802_1)
		arg_802_1.time_ = 0
		arg_802_1.frameCnt_ = 0
		arg_802_1.state_ = "playing"
		arg_802_1.curTalkId_ = 1108409196
		arg_802_1.duration_ = 5

		SetActive(arg_802_1.tipsGo_, false)

		function arg_802_1.onSingleLineFinish_()
			arg_802_1.onSingleLineUpdate_ = nil
			arg_802_1.onSingleLineFinish_ = nil
			arg_802_1.state_ = "waiting"
		end

		function arg_802_1.playNext_(arg_804_0)
			if arg_804_0 == 1 then
				arg_802_0:Play1108409197(arg_802_1)
			end
		end

		function arg_802_1.onSingleLineUpdate_(arg_805_0)
			local var_805_0 = 0.7

			if 0 < arg_802_1.time_ and arg_802_1.time_ <= 0 + arg_805_0 then
				arg_802_1.talkMaxDuration = 0
				arg_802_1.dialogCg_.alpha = 1

				arg_802_1.dialog_:SetActive(true)
				SetActive(arg_802_1.leftNameGo_, true)

				arg_802_1.leftNameTxt_.text = arg_802_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_802_1.leftNameTxt_.transform)

				arg_802_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_802_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_802_1:RecordName(arg_802_1.leftNameTxt_.text)
				SetActive(arg_802_1.iconTrs_.gameObject, true)
				arg_802_1.iconController_:SetSelectedState("hero")

				arg_802_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_802_1.callingController_:SetSelectedState("normal")

				arg_802_1.keyicon_.color = Color.New(1, 1, 1)
				arg_802_1.icon_.color = Color.New(1, 1, 1)

				local var_805_1 = arg_802_1:FormatText(arg_802_1:GetWordFromCfg(1108409196).content)

				arg_802_1.text_.text = var_805_1

				LuaForUtil.ClearLinePrefixSymbol(arg_802_1.text_)

				local var_805_3 = 28 <= 0 and var_805_0 or var_805_0 * (utf8.len(var_805_1) / 28)

				if (28 <= 0 and var_805_0 or var_805_0 * (utf8.len(var_805_1) / 28)) > 0 and var_805_0 < var_805_3 then
					arg_802_1.talkMaxDuration = var_805_3

					if var_805_3 + 0 > arg_802_1.duration_ then
						arg_802_1.duration_ = var_805_3 + 0
					end
				end

				arg_802_1.text_.text = var_805_1
				arg_802_1.typewritter.percent = 0

				arg_802_1.typewritter:SetDirty()
				arg_802_1:ShowNextGo(false)
				arg_802_1:RecordContent(arg_802_1.text_.text)
			end

			local var_805_4 = math.max(var_805_0, arg_802_1.talkMaxDuration)

			if 0 <= arg_802_1.time_ and arg_802_1.time_ < 0 + var_805_4 then
				arg_802_1.typewritter.percent = (arg_802_1.time_ - 0) / var_805_4

				arg_802_1.typewritter:SetDirty()
			end

			if arg_802_1.time_ >= 0 + var_805_4 and arg_802_1.time_ < 0 + var_805_4 + arg_805_0 then
				arg_802_1.typewritter.percent = 1

				arg_802_1.typewritter:SetDirty()
				arg_802_1:ShowNextGo(true)
			end
		end

		arg_802_1.nodeConfigList_ = {}

		arg_802_1:InitPlayNodeList()
	end,
	Play1108409197 = function(arg_806_0, arg_806_1)
		arg_806_1.time_ = 0
		arg_806_1.frameCnt_ = 0
		arg_806_1.state_ = "playing"
		arg_806_1.curTalkId_ = 1108409197
		arg_806_1.duration_ = 1.8

		SetActive(arg_806_1.tipsGo_, false)

		function arg_806_1.onSingleLineFinish_()
			arg_806_1.onSingleLineUpdate_ = nil
			arg_806_1.onSingleLineFinish_ = nil
			arg_806_1.state_ = "waiting"
		end

		function arg_806_1.playNext_(arg_808_0)
			if arg_808_0 == 1 then
				arg_806_0:Play1108409198(arg_806_1)
			end
		end

		function arg_806_1.onSingleLineUpdate_(arg_809_0)
			local var_809_0 = 0.2

			if 0 < arg_806_1.time_ and arg_806_1.time_ <= 0 + arg_809_0 then
				arg_806_1.talkMaxDuration = 0
				arg_806_1.dialogCg_.alpha = 1

				arg_806_1.dialog_:SetActive(true)
				SetActive(arg_806_1.leftNameGo_, true)

				arg_806_1.leftNameTxt_.text = arg_806_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_806_1.leftNameTxt_.transform)

				arg_806_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_806_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_806_1:RecordName(arg_806_1.leftNameTxt_.text)
				SetActive(arg_806_1.iconTrs_.gameObject, true)
				arg_806_1.iconController_:SetSelectedState("hero")

				arg_806_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_806_1.callingController_:SetSelectedState("normal")

				arg_806_1.keyicon_.color = Color.New(1, 1, 1)
				arg_806_1.icon_.color = Color.New(1, 1, 1)

				local var_809_1 = arg_806_1:GetWordFromCfg(1108409197)
				local var_809_2 = arg_806_1:FormatText(var_809_1.content)

				arg_806_1.text_.text = var_809_2

				LuaForUtil.ClearLinePrefixSymbol(arg_806_1.text_)

				local var_809_4 = 8 <= 0 and var_809_0 or var_809_0 * (utf8.len(var_809_2) / 8)

				if (8 <= 0 and var_809_0 or var_809_0 * (utf8.len(var_809_2) / 8)) > 0 and var_809_0 < var_809_4 then
					arg_806_1.talkMaxDuration = var_809_4

					if var_809_4 + 0 > arg_806_1.duration_ then
						arg_806_1.duration_ = var_809_4 + 0
					end
				end

				arg_806_1.text_.text = var_809_2
				arg_806_1.typewritter.percent = 0

				arg_806_1.typewritter:SetDirty()
				arg_806_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409197", "story_v_side_new_1108409.awb") ~= 0 then
					local var_809_5 = manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409197", "story_v_side_new_1108409.awb") / 1000

					if var_809_5 + 0 > arg_806_1.duration_ then
						arg_806_1.duration_ = var_809_5 + 0
					end

					if var_809_1.prefab_name ~= "" and arg_806_1.actors_[var_809_1.prefab_name] ~= nil then
						local var_809_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_806_1.actors_[var_809_1.prefab_name].transform, "story_v_side_new_1108409", "1108409197", "story_v_side_new_1108409.awb")

						arg_806_1:RecordAudio("1108409197", var_809_6)
						arg_806_1:RecordAudio("1108409197", var_809_6)
					else
						arg_806_1:AudioAction("play", "voice", "story_v_side_new_1108409", "1108409197", "story_v_side_new_1108409.awb")
					end

					arg_806_1:RecordHistoryTalkVoice("story_v_side_new_1108409", "1108409197", "story_v_side_new_1108409.awb")
				end

				arg_806_1:RecordContent(arg_806_1.text_.text)
			end

			local var_809_7 = math.max(var_809_0, arg_806_1.talkMaxDuration)

			if 0 <= arg_806_1.time_ and arg_806_1.time_ < 0 + var_809_7 then
				arg_806_1.typewritter.percent = (arg_806_1.time_ - 0) / var_809_7

				arg_806_1.typewritter:SetDirty()
			end

			if arg_806_1.time_ >= 0 + var_809_7 and arg_806_1.time_ < 0 + var_809_7 + arg_809_0 then
				arg_806_1.typewritter.percent = 1

				arg_806_1.typewritter:SetDirty()
				arg_806_1:ShowNextGo(true)
			end
		end

		arg_806_1.nodeConfigList_ = {}

		arg_806_1:InitPlayNodeList()
	end,
	Play1108409198 = function(arg_810_0, arg_810_1)
		arg_810_1.time_ = 0
		arg_810_1.frameCnt_ = 0
		arg_810_1.state_ = "playing"
		arg_810_1.curTalkId_ = 1108409198
		arg_810_1.duration_ = 5

		SetActive(arg_810_1.tipsGo_, false)

		function arg_810_1.onSingleLineFinish_()
			arg_810_1.onSingleLineUpdate_ = nil
			arg_810_1.onSingleLineFinish_ = nil
			arg_810_1.state_ = "waiting"
		end

		function arg_810_1.playNext_(arg_812_0)
			if arg_812_0 == 1 then
				arg_810_0:Play1108409199(arg_810_1)
			end
		end

		function arg_810_1.onSingleLineUpdate_(arg_813_0)
			if 0 < arg_810_1.time_ and arg_810_1.time_ <= 0 + arg_813_0 and not isNil(arg_810_1.actors_["1084ui_story"]) and arg_810_1.var_.characterEffect1084ui_story == nil then
				arg_810_1.var_.characterEffect1084ui_story = arg_810_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_813_0 = 0.200000002980232

			if 0 <= arg_810_1.time_ and arg_810_1.time_ < 0 + var_813_0 and not isNil(arg_810_1.actors_["1084ui_story"]) then
				if arg_810_1.var_.characterEffect1084ui_story and not isNil(arg_810_1.actors_["1084ui_story"]) then
					arg_810_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_810_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_810_1.time_ - 0) / var_813_0)
				end
			end

			if arg_810_1.time_ >= 0 + var_813_0 and arg_810_1.time_ < 0 + var_813_0 + arg_813_0 and not isNil(arg_810_1.actors_["1084ui_story"]) and arg_810_1.var_.characterEffect1084ui_story then
				arg_810_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_810_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_813_1 = 0
			local var_813_2 = 0.175

			if 0 < arg_810_1.time_ and arg_810_1.time_ <= var_813_1 + arg_813_0 then
				arg_810_1.talkMaxDuration = 0
				arg_810_1.dialogCg_.alpha = 1

				arg_810_1.dialog_:SetActive(true)
				SetActive(arg_810_1.leftNameGo_, true)

				arg_810_1.leftNameTxt_.text = arg_810_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_810_1.leftNameTxt_.transform)

				arg_810_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_810_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_810_1:RecordName(arg_810_1.leftNameTxt_.text)
				SetActive(arg_810_1.iconTrs_.gameObject, true)
				arg_810_1.iconController_:SetSelectedState("hero")

				arg_810_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_810_1.callingController_:SetSelectedState("normal")

				arg_810_1.keyicon_.color = Color.New(1, 1, 1)
				arg_810_1.icon_.color = Color.New(1, 1, 1)

				local var_813_3 = arg_810_1:FormatText(arg_810_1:GetWordFromCfg(1108409198).content)

				arg_810_1.text_.text = var_813_3

				LuaForUtil.ClearLinePrefixSymbol(arg_810_1.text_)

				local var_813_5 = 7 <= 0 and var_813_2 or var_813_2 * (utf8.len(var_813_3) / 7)

				if (7 <= 0 and var_813_2 or var_813_2 * (utf8.len(var_813_3) / 7)) > 0 and var_813_2 < var_813_5 then
					arg_810_1.talkMaxDuration = var_813_5

					if var_813_5 + var_813_1 > arg_810_1.duration_ then
						arg_810_1.duration_ = var_813_5 + var_813_1
					end
				end

				arg_810_1.text_.text = var_813_3
				arg_810_1.typewritter.percent = 0

				arg_810_1.typewritter:SetDirty()
				arg_810_1:ShowNextGo(false)
				arg_810_1:RecordContent(arg_810_1.text_.text)
			end

			local var_813_6 = math.max(var_813_2, arg_810_1.talkMaxDuration)

			if var_813_1 <= arg_810_1.time_ and arg_810_1.time_ < var_813_1 + var_813_6 then
				arg_810_1.typewritter.percent = (arg_810_1.time_ - var_813_1) / var_813_6

				arg_810_1.typewritter:SetDirty()
			end

			if arg_810_1.time_ >= var_813_1 + var_813_6 and arg_810_1.time_ < var_813_1 + var_813_6 + arg_813_0 then
				arg_810_1.typewritter.percent = 1

				arg_810_1.typewritter:SetDirty()
				arg_810_1:ShowNextGo(true)
			end
		end

		arg_810_1.nodeConfigList_ = {}

		arg_810_1:InitPlayNodeList()
	end,
	Play1108409199 = function(arg_814_0, arg_814_1)
		arg_814_1.time_ = 0
		arg_814_1.frameCnt_ = 0
		arg_814_1.state_ = "playing"
		arg_814_1.curTalkId_ = 1108409199
		arg_814_1.duration_ = 6.23

		SetActive(arg_814_1.tipsGo_, false)

		function arg_814_1.onSingleLineFinish_()
			arg_814_1.onSingleLineUpdate_ = nil
			arg_814_1.onSingleLineFinish_ = nil
			arg_814_1.state_ = "waiting"
		end

		function arg_814_1.playNext_(arg_816_0)
			if arg_816_0 == 1 then
				arg_814_0:Play1108409200(arg_814_1)
			end
		end

		function arg_814_1.onSingleLineUpdate_(arg_817_0)
			if 0 < arg_814_1.time_ and arg_814_1.time_ <= 0 + arg_817_0 and not isNil(arg_814_1.actors_["1084ui_story"]) and arg_814_1.var_.characterEffect1084ui_story == nil then
				arg_814_1.var_.characterEffect1084ui_story = arg_814_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_817_0 = 0.200000002980232

			if 0 <= arg_814_1.time_ and arg_814_1.time_ < 0 + var_817_0 and not isNil(arg_814_1.actors_["1084ui_story"]) then
				if arg_814_1.var_.characterEffect1084ui_story and not isNil(arg_814_1.actors_["1084ui_story"]) then
					arg_814_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_814_1.time_ >= 0 + var_817_0 and arg_814_1.time_ < 0 + var_817_0 + arg_817_0 and not isNil(arg_814_1.actors_["1084ui_story"]) and arg_814_1.var_.characterEffect1084ui_story then
				arg_814_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_814_1.time_ and arg_814_1.time_ <= 0 + arg_817_0 then
				arg_814_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action12_1")
			end

			if 0 < arg_814_1.time_ and arg_814_1.time_ <= 0 + arg_817_0 then
				arg_814_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_817_2 = arg_814_1.actors_["1084ui_story"].transform

			if 0 < arg_814_1.time_ and arg_814_1.time_ <= 0 + arg_817_0 then
				arg_814_1.var_.moveOldPos1084ui_story = var_817_2.localPosition
			end

			local var_817_3 = 0.001

			if 0 <= arg_814_1.time_ and arg_814_1.time_ < 0 + var_817_3 then
				var_817_2.localPosition = Vector3.Lerp(arg_814_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_814_1.time_ - 0) / var_817_3)
				var_817_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_817_2.position).x, (manager.ui.mainCamera.transform.position - var_817_2.position).y, (manager.ui.mainCamera.transform.position - var_817_2.position).z)
				var_817_2.localEulerAngles.z = 0
				var_817_2.localEulerAngles.x = 0
				var_817_2.localEulerAngles = var_817_2.localEulerAngles
			end

			if arg_814_1.time_ >= 0 + var_817_3 and arg_814_1.time_ < 0 + var_817_3 + arg_817_0 then
				var_817_2.localPosition = Vector3.New(0, -0.97, -6)
				var_817_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_817_2.position).x, (manager.ui.mainCamera.transform.position - var_817_2.position).y, (manager.ui.mainCamera.transform.position - var_817_2.position).z)
				var_817_2.localEulerAngles.z = 0
				var_817_2.localEulerAngles.x = 0
				var_817_2.localEulerAngles = var_817_2.localEulerAngles
			end

			local var_817_4 = 0
			local var_817_5 = 1.025

			if 0 < arg_814_1.time_ and arg_814_1.time_ <= var_817_4 + arg_817_0 then
				arg_814_1.talkMaxDuration = 0
				arg_814_1.dialogCg_.alpha = 1

				arg_814_1.dialog_:SetActive(true)
				SetActive(arg_814_1.leftNameGo_, true)

				arg_814_1.leftNameTxt_.text = arg_814_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_814_1.leftNameTxt_.transform)

				arg_814_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_814_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_814_1:RecordName(arg_814_1.leftNameTxt_.text)
				SetActive(arg_814_1.iconTrs_.gameObject, false)
				arg_814_1.callingController_:SetSelectedState("normal")

				local var_817_6 = arg_814_1:GetWordFromCfg(1108409199)
				local var_817_7 = arg_814_1:FormatText(var_817_6.content)

				arg_814_1.text_.text = var_817_7

				LuaForUtil.ClearLinePrefixSymbol(arg_814_1.text_)

				local var_817_9 = 41 <= 0 and var_817_5 or var_817_5 * (utf8.len(var_817_7) / 41)

				if (41 <= 0 and var_817_5 or var_817_5 * (utf8.len(var_817_7) / 41)) > 0 and var_817_5 < var_817_9 then
					arg_814_1.talkMaxDuration = var_817_9

					if var_817_9 + var_817_4 > arg_814_1.duration_ then
						arg_814_1.duration_ = var_817_9 + var_817_4
					end
				end

				arg_814_1.text_.text = var_817_7
				arg_814_1.typewritter.percent = 0

				arg_814_1.typewritter:SetDirty()
				arg_814_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409199", "story_v_side_new_1108409.awb") ~= 0 then
					local var_817_10 = manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409199", "story_v_side_new_1108409.awb") / 1000

					if var_817_10 + var_817_4 > arg_814_1.duration_ then
						arg_814_1.duration_ = var_817_10 + var_817_4
					end

					if var_817_6.prefab_name ~= "" and arg_814_1.actors_[var_817_6.prefab_name] ~= nil then
						local var_817_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_814_1.actors_[var_817_6.prefab_name].transform, "story_v_side_new_1108409", "1108409199", "story_v_side_new_1108409.awb")

						arg_814_1:RecordAudio("1108409199", var_817_11)
						arg_814_1:RecordAudio("1108409199", var_817_11)
					else
						arg_814_1:AudioAction("play", "voice", "story_v_side_new_1108409", "1108409199", "story_v_side_new_1108409.awb")
					end

					arg_814_1:RecordHistoryTalkVoice("story_v_side_new_1108409", "1108409199", "story_v_side_new_1108409.awb")
				end

				arg_814_1:RecordContent(arg_814_1.text_.text)
			end

			local var_817_12 = math.max(var_817_5, arg_814_1.talkMaxDuration)

			if var_817_4 <= arg_814_1.time_ and arg_814_1.time_ < var_817_4 + var_817_12 then
				arg_814_1.typewritter.percent = (arg_814_1.time_ - var_817_4) / var_817_12

				arg_814_1.typewritter:SetDirty()
			end

			if arg_814_1.time_ >= var_817_4 + var_817_12 and arg_814_1.time_ < var_817_4 + var_817_12 + arg_817_0 then
				arg_814_1.typewritter.percent = 1

				arg_814_1.typewritter:SetDirty()
				arg_814_1:ShowNextGo(true)
			end
		end

		arg_814_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_814_1:InitPlayNodeList()
	end,
	Play1108409200 = function(arg_818_0, arg_818_1)
		arg_818_1.time_ = 0
		arg_818_1.frameCnt_ = 0
		arg_818_1.state_ = "playing"
		arg_818_1.curTalkId_ = 1108409200
		arg_818_1.duration_ = 5.3

		SetActive(arg_818_1.tipsGo_, false)

		function arg_818_1.onSingleLineFinish_()
			arg_818_1.onSingleLineUpdate_ = nil
			arg_818_1.onSingleLineFinish_ = nil
			arg_818_1.state_ = "waiting"
		end

		function arg_818_1.playNext_(arg_820_0)
			if arg_820_0 == 1 then
				arg_818_0:Play1108409201(arg_818_1)
			end
		end

		function arg_818_1.onSingleLineUpdate_(arg_821_0)
			local var_821_9000

			if 0 < arg_818_1.time_ and arg_818_1.time_ <= 0 + arg_821_0 then
				arg_818_1.var_.moveOldPos1084ui_story = arg_818_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_821_0 = 0.001

			if 0 <= arg_818_1.time_ and arg_818_1.time_ < 0 + var_821_0 then
				arg_818_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_818_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_818_1.time_ - 0) / var_821_0)
				arg_818_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_818_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_818_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_818_1.actors_["1084ui_story"].transform.position).z)
				arg_818_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_818_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_818_1.actors_["1084ui_story"].transform.localEulerAngles = arg_818_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_818_1.time_ >= 0 + var_821_0 and arg_818_1.time_ < 0 + var_821_0 + arg_821_0 then
				arg_818_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_818_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_818_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_818_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_818_1.actors_["1084ui_story"].transform.position).z)
				arg_818_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_818_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_818_1.actors_["1084ui_story"].transform.localEulerAngles = arg_818_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_821_1 = arg_818_1.actors_["1084ui_story"]

			if 0 < arg_818_1.time_ and arg_818_1.time_ <= 0 + arg_821_0 and not isNil(var_821_1) and arg_818_1.var_.characterEffect1084ui_story == nil then
				arg_818_1.var_.characterEffect1084ui_story = var_821_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_821_2 = 0.034000001847744

			if 0 <= arg_818_1.time_ and arg_818_1.time_ < 0 + var_821_2 and not isNil(var_821_1) then
				if arg_818_1.var_.characterEffect1084ui_story and not isNil(var_821_1) then
					arg_818_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_818_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_818_1.time_ - 0) / var_821_2)
				end
			end

			if arg_818_1.time_ >= 0 + var_821_2 and arg_818_1.time_ < 0 + var_821_2 + arg_821_0 and not isNil(var_821_1) and arg_818_1.var_.characterEffect1084ui_story then
				arg_818_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_818_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < arg_818_1.time_ and arg_818_1.time_ <= 0 + arg_821_0 then
				local var_821_3 = arg_818_1.var_.effectxuanfnegban1

				if not arg_818_1.var_.effectxuanfnegban1 then
					var_821_3 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_suduxian01_out"), manager.ui.mainCamera.transform)
					var_821_3.name = "xuanfnegban1"
					arg_818_1.var_.effectxuanfnegban1 = var_821_3
				else
					var_821_3.transform:SetParent(var_821_9000)
				end

				var_821_3.transform.localPosition = Vector3.New(0, 0, 0)
				var_821_3.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 2.3 < arg_818_1.time_ and arg_818_1.time_ <= 2.3 + arg_821_0 then
				if arg_818_1.var_.effectxuanfnegban1 then
					Object.Destroy(arg_818_1.var_.effectxuanfnegban1)

					arg_818_1.var_.effectxuanfnegban1 = nil
				end
			end

			if arg_818_1.frameCnt_ <= 1 then
				arg_818_1.dialog_:SetActive(false)
			end

			local var_821_6 = 0.3
			local var_821_7 = 0.7

			if 0.3 < arg_818_1.time_ and arg_818_1.time_ <= var_821_6 + arg_821_0 then
				arg_818_1.talkMaxDuration = 0

				arg_818_1.dialog_:SetActive(true)

				arg_818_1.dialogCg_.alpha = 0

				local var_821_8 = LeanTween.value(arg_818_1.dialog_, 0, 1, 0.3)

				var_821_8:setOnUpdate(LuaHelper.FloatAction(function(arg_822_0)
					arg_818_1.dialogCg_.alpha = arg_822_0
				end))
				var_821_8:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_818_1.dialog_)
					var_821_8:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_818_1.duration_ = arg_818_1.duration_ + 0.3

				SetActive(arg_818_1.leftNameGo_, false)

				arg_818_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_818_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_818_1:RecordName(arg_818_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_818_1.iconTrs_.gameObject, false)
				arg_818_1.callingController_:SetSelectedState("normal")

				local var_821_9 = arg_818_1:FormatText(arg_818_1:GetWordFromCfg(1108409200).content)

				arg_818_1.text_.text = var_821_9

				LuaForUtil.ClearLinePrefixSymbol(arg_818_1.text_)

				local var_821_11 = 28 <= 0 and var_821_7 or var_821_7 * (utf8.len(var_821_9) / 28)

				if (28 <= 0 and var_821_7 or var_821_7 * (utf8.len(var_821_9) / 28)) > 0 and var_821_7 < var_821_11 then
					arg_818_1.talkMaxDuration = var_821_11
					var_821_6 = var_821_6 + 0.3

					if var_821_11 + var_821_6 > arg_818_1.duration_ then
						arg_818_1.duration_ = var_821_11 + var_821_6
					end
				end

				arg_818_1.text_.text = var_821_9
				arg_818_1.typewritter.percent = 0

				arg_818_1.typewritter:SetDirty()
				arg_818_1:ShowNextGo(false)
				arg_818_1:RecordContent(arg_818_1.text_.text)
			end

			local var_821_12 = var_821_6 + 0.3
			local var_821_13 = math.max(var_821_7, arg_818_1.talkMaxDuration)

			if var_821_6 + 0.3 <= arg_818_1.time_ and arg_818_1.time_ < var_821_12 + var_821_13 then
				arg_818_1.typewritter.percent = (arg_818_1.time_ - var_821_12) / var_821_13

				arg_818_1.typewritter:SetDirty()
			end

			if arg_818_1.time_ >= var_821_12 + var_821_13 and arg_818_1.time_ < var_821_12 + var_821_13 + arg_821_0 then
				arg_818_1.typewritter.percent = 1

				arg_818_1.typewritter:SetDirty()
				arg_818_1:ShowNextGo(true)
			end
		end

		arg_818_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_818_1:InitPlayNodeList()
	end,
	Play1108409201 = function(arg_824_0, arg_824_1)
		arg_824_1.time_ = 0
		arg_824_1.frameCnt_ = 0
		arg_824_1.state_ = "playing"
		arg_824_1.curTalkId_ = 1108409201
		arg_824_1.duration_ = 5

		SetActive(arg_824_1.tipsGo_, false)

		function arg_824_1.onSingleLineFinish_()
			arg_824_1.onSingleLineUpdate_ = nil
			arg_824_1.onSingleLineFinish_ = nil
			arg_824_1.state_ = "waiting"
		end

		function arg_824_1.playNext_(arg_826_0)
			if arg_826_0 == 1 then
				arg_824_0:Play1108409202(arg_824_1)
			end
		end

		function arg_824_1.onSingleLineUpdate_(arg_827_0)
			local var_827_0 = 0.4

			if 0 < arg_824_1.time_ and arg_824_1.time_ <= 0 + arg_827_0 then
				arg_824_1.talkMaxDuration = 0
				arg_824_1.dialogCg_.alpha = 1

				arg_824_1.dialog_:SetActive(true)
				SetActive(arg_824_1.leftNameGo_, true)

				arg_824_1.leftNameTxt_.text = arg_824_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_824_1.leftNameTxt_.transform)

				arg_824_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_824_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_824_1:RecordName(arg_824_1.leftNameTxt_.text)
				SetActive(arg_824_1.iconTrs_.gameObject, true)
				arg_824_1.iconController_:SetSelectedState("hero")

				arg_824_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_824_1.callingController_:SetSelectedState("normal")

				arg_824_1.keyicon_.color = Color.New(1, 1, 1)
				arg_824_1.icon_.color = Color.New(1, 1, 1)

				local var_827_1 = arg_824_1:FormatText(arg_824_1:GetWordFromCfg(1108409201).content)

				arg_824_1.text_.text = var_827_1

				LuaForUtil.ClearLinePrefixSymbol(arg_824_1.text_)

				local var_827_3 = 16 <= 0 and var_827_0 or var_827_0 * (utf8.len(var_827_1) / 16)

				if (16 <= 0 and var_827_0 or var_827_0 * (utf8.len(var_827_1) / 16)) > 0 and var_827_0 < var_827_3 then
					arg_824_1.talkMaxDuration = var_827_3

					if var_827_3 + 0 > arg_824_1.duration_ then
						arg_824_1.duration_ = var_827_3 + 0
					end
				end

				arg_824_1.text_.text = var_827_1
				arg_824_1.typewritter.percent = 0

				arg_824_1.typewritter:SetDirty()
				arg_824_1:ShowNextGo(false)
				arg_824_1:RecordContent(arg_824_1.text_.text)
			end

			local var_827_4 = math.max(var_827_0, arg_824_1.talkMaxDuration)

			if 0 <= arg_824_1.time_ and arg_824_1.time_ < 0 + var_827_4 then
				arg_824_1.typewritter.percent = (arg_824_1.time_ - 0) / var_827_4

				arg_824_1.typewritter:SetDirty()
			end

			if arg_824_1.time_ >= 0 + var_827_4 and arg_824_1.time_ < 0 + var_827_4 + arg_827_0 then
				arg_824_1.typewritter.percent = 1

				arg_824_1.typewritter:SetDirty()
				arg_824_1:ShowNextGo(true)
			end
		end

		arg_824_1.nodeConfigList_ = {}

		arg_824_1:InitPlayNodeList()
	end,
	Play1108409202 = function(arg_828_0, arg_828_1)
		arg_828_1.time_ = 0
		arg_828_1.frameCnt_ = 0
		arg_828_1.state_ = "playing"
		arg_828_1.curTalkId_ = 1108409202
		arg_828_1.duration_ = 8.13

		SetActive(arg_828_1.tipsGo_, false)

		function arg_828_1.onSingleLineFinish_()
			arg_828_1.onSingleLineUpdate_ = nil
			arg_828_1.onSingleLineFinish_ = nil
			arg_828_1.state_ = "waiting"
		end

		function arg_828_1.playNext_(arg_830_0)
			if arg_830_0 == 1 then
				arg_828_0:Play1108409203(arg_828_1)
			end
		end

		function arg_828_1.onSingleLineUpdate_(arg_831_0)
			if 2.00000000298023 < arg_828_1.time_ and arg_828_1.time_ <= 2.00000000298023 + arg_831_0 then
				local var_831_0 = arg_828_1.bgs_.ST03

				arg_828_1.bgs_.ST03.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_831_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_831_1 = var_831_0:GetComponent("SpriteRenderer")

				if var_831_1 and var_831_1.sprite then
					local var_831_2 = 2 * (var_831_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_831_0.transform.localScale = Vector3.New(var_831_2 / var_831_1.sprite.bounds.size.y < var_831_2 * manager.ui.mainCameraCom_.aspect / var_831_1.sprite.bounds.size.x and var_831_2 * manager.ui.mainCameraCom_.aspect / var_831_1.sprite.bounds.size.x or var_831_2 / var_831_1.sprite.bounds.size.y, var_831_2 / var_831_1.sprite.bounds.size.y < var_831_2 * manager.ui.mainCameraCom_.aspect / var_831_1.sprite.bounds.size.x and var_831_2 * manager.ui.mainCameraCom_.aspect / var_831_1.sprite.bounds.size.x or var_831_2 / var_831_1.sprite.bounds.size.y, 0)
				end

				for iter_831_0, iter_831_1 in pairs(arg_828_1.bgs_) do
					if iter_831_0 ~= "ST03" then
						iter_831_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_831_3 = 4

			if 4 < arg_828_1.time_ and arg_828_1.time_ <= var_831_3 + arg_831_0 then
				arg_828_1.allBtn_.enabled = false
			end

			if arg_828_1.time_ >= var_831_3 + 0.3 and arg_828_1.time_ < var_831_3 + 0.3 + arg_831_0 then
				arg_828_1.allBtn_.enabled = true
			end

			local var_831_4 = 0

			if 0 < arg_828_1.time_ and arg_828_1.time_ <= var_831_4 + arg_831_0 then
				arg_828_1.mask_.enabled = true
				arg_828_1.mask_.raycastTarget = true

				arg_828_1:SetGaussion(false)
			end

			local var_831_5 = 2

			if var_831_4 <= arg_828_1.time_ and arg_828_1.time_ < var_831_4 + var_831_5 then
				local var_831_6 = Color.New(0, 0, 0)

				var_831_6.a = Mathf.Lerp(0, 1, (arg_828_1.time_ - var_831_4) / var_831_5)
				arg_828_1.mask_.color = var_831_6
			end

			if arg_828_1.time_ >= var_831_4 + var_831_5 and arg_828_1.time_ < var_831_4 + var_831_5 + arg_831_0 then
				local var_831_7 = Color.New(0, 0, 0)

				var_831_7.a = 1
				arg_828_1.mask_.color = var_831_7
			end

			local var_831_8 = 2

			if 2 < arg_828_1.time_ and arg_828_1.time_ <= var_831_8 + arg_831_0 then
				arg_828_1.mask_.enabled = true
				arg_828_1.mask_.raycastTarget = true

				arg_828_1:SetGaussion(false)
			end

			local var_831_9 = 2

			if var_831_8 <= arg_828_1.time_ and arg_828_1.time_ < var_831_8 + var_831_9 then
				local var_831_10 = Color.New(0, 0, 0)

				var_831_10.a = Mathf.Lerp(1, 0, (arg_828_1.time_ - var_831_8) / var_831_9)
				arg_828_1.mask_.color = var_831_10
			end

			if arg_828_1.time_ >= var_831_8 + var_831_9 and arg_828_1.time_ < var_831_8 + var_831_9 + arg_831_0 then
				local var_831_11 = Color.New(0, 0, 0)

				arg_828_1.mask_.enabled = false
				var_831_11.a = 0
				arg_828_1.mask_.color = var_831_11
			end

			local var_831_12 = arg_828_1.actors_["1084ui_story"].transform

			if 3.8 < arg_828_1.time_ and arg_828_1.time_ <= 3.8 + arg_831_0 then
				arg_828_1.var_.moveOldPos1084ui_story = var_831_12.localPosition
			end

			local var_831_13 = 0.001

			if 3.8 <= arg_828_1.time_ and arg_828_1.time_ < 3.8 + var_831_13 then
				var_831_12.localPosition = Vector3.Lerp(arg_828_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_828_1.time_ - 3.8) / var_831_13)
				var_831_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_831_12.position).x, (manager.ui.mainCamera.transform.position - var_831_12.position).y, (manager.ui.mainCamera.transform.position - var_831_12.position).z)
				var_831_12.localEulerAngles.z = 0
				var_831_12.localEulerAngles.x = 0
				var_831_12.localEulerAngles = var_831_12.localEulerAngles
			end

			if arg_828_1.time_ >= 3.8 + var_831_13 and arg_828_1.time_ < 3.8 + var_831_13 + arg_831_0 then
				var_831_12.localPosition = Vector3.New(0, -0.97, -6)
				var_831_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_831_12.position).x, (manager.ui.mainCamera.transform.position - var_831_12.position).y, (manager.ui.mainCamera.transform.position - var_831_12.position).z)
				var_831_12.localEulerAngles.z = 0
				var_831_12.localEulerAngles.x = 0
				var_831_12.localEulerAngles = var_831_12.localEulerAngles
			end

			local var_831_14 = arg_828_1.actors_["1084ui_story"]

			if 3.8 < arg_828_1.time_ and arg_828_1.time_ <= 3.8 + arg_831_0 and not isNil(var_831_14) and arg_828_1.var_.characterEffect1084ui_story == nil then
				arg_828_1.var_.characterEffect1084ui_story = var_831_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_831_15 = 0.200000002980232

			if 3.8 <= arg_828_1.time_ and arg_828_1.time_ < 3.8 + var_831_15 and not isNil(var_831_14) then
				if arg_828_1.var_.characterEffect1084ui_story and not isNil(var_831_14) then
					arg_828_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_828_1.time_ >= 3.8 + var_831_15 and arg_828_1.time_ < 3.8 + var_831_15 + arg_831_0 and not isNil(var_831_14) and arg_828_1.var_.characterEffect1084ui_story then
				arg_828_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 3.8 < arg_828_1.time_ and arg_828_1.time_ <= 3.8 + arg_831_0 then
				arg_828_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			if 3.8 < arg_828_1.time_ and arg_828_1.time_ <= 3.8 + arg_831_0 then
				arg_828_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva", "EmotionTimelineAnimator")
			end

			if arg_828_1.frameCnt_ <= 1 then
				arg_828_1.dialog_:SetActive(false)
			end

			local var_831_17 = 4.00000000298023
			local var_831_18 = 0.575

			if 4.00000000298023 < arg_828_1.time_ and arg_828_1.time_ <= var_831_17 + arg_831_0 then
				arg_828_1.talkMaxDuration = 0

				arg_828_1.dialog_:SetActive(true)

				arg_828_1.dialogCg_.alpha = 0

				local var_831_19 = LeanTween.value(arg_828_1.dialog_, 0, 1, 0.3)

				var_831_19:setOnUpdate(LuaHelper.FloatAction(function(arg_832_0)
					arg_828_1.dialogCg_.alpha = arg_832_0
				end))
				var_831_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_828_1.dialog_)
					var_831_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_828_1.duration_ = arg_828_1.duration_ + 0.3

				SetActive(arg_828_1.leftNameGo_, true)

				arg_828_1.leftNameTxt_.text = arg_828_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_828_1.leftNameTxt_.transform)

				arg_828_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_828_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_828_1:RecordName(arg_828_1.leftNameTxt_.text)
				SetActive(arg_828_1.iconTrs_.gameObject, false)
				arg_828_1.callingController_:SetSelectedState("normal")

				local var_831_20 = arg_828_1:GetWordFromCfg(1108409202)
				local var_831_21 = arg_828_1:FormatText(var_831_20.content)

				arg_828_1.text_.text = var_831_21

				LuaForUtil.ClearLinePrefixSymbol(arg_828_1.text_)

				local var_831_23 = 23 <= 0 and var_831_18 or var_831_18 * (utf8.len(var_831_21) / 23)

				if (23 <= 0 and var_831_18 or var_831_18 * (utf8.len(var_831_21) / 23)) > 0 and var_831_18 < var_831_23 then
					arg_828_1.talkMaxDuration = var_831_23
					var_831_17 = var_831_17 + 0.3

					if var_831_23 + var_831_17 > arg_828_1.duration_ then
						arg_828_1.duration_ = var_831_23 + var_831_17
					end
				end

				arg_828_1.text_.text = var_831_21
				arg_828_1.typewritter.percent = 0

				arg_828_1.typewritter:SetDirty()
				arg_828_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409202", "story_v_side_new_1108409.awb") ~= 0 then
					local var_831_24 = manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409202", "story_v_side_new_1108409.awb") / 1000

					if var_831_24 + var_831_17 > arg_828_1.duration_ then
						arg_828_1.duration_ = var_831_24 + var_831_17
					end

					if var_831_20.prefab_name ~= "" and arg_828_1.actors_[var_831_20.prefab_name] ~= nil then
						local var_831_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_828_1.actors_[var_831_20.prefab_name].transform, "story_v_side_new_1108409", "1108409202", "story_v_side_new_1108409.awb")

						arg_828_1:RecordAudio("1108409202", var_831_25)
						arg_828_1:RecordAudio("1108409202", var_831_25)
					else
						arg_828_1:AudioAction("play", "voice", "story_v_side_new_1108409", "1108409202", "story_v_side_new_1108409.awb")
					end

					arg_828_1:RecordHistoryTalkVoice("story_v_side_new_1108409", "1108409202", "story_v_side_new_1108409.awb")
				end

				arg_828_1:RecordContent(arg_828_1.text_.text)
			end

			local var_831_26 = var_831_17 + 0.3
			local var_831_27 = math.max(var_831_18, arg_828_1.talkMaxDuration)

			if var_831_17 + 0.3 <= arg_828_1.time_ and arg_828_1.time_ < var_831_26 + var_831_27 then
				arg_828_1.typewritter.percent = (arg_828_1.time_ - var_831_26) / var_831_27

				arg_828_1.typewritter:SetDirty()
			end

			if arg_828_1.time_ >= var_831_26 + var_831_27 and arg_828_1.time_ < var_831_26 + var_831_27 + arg_831_0 then
				arg_828_1.typewritter.percent = 1

				arg_828_1.typewritter:SetDirty()
				arg_828_1:ShowNextGo(true)
			end
		end

		arg_828_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_828_1:InitPlayNodeList()
	end,
	Play1108409203 = function(arg_834_0, arg_834_1)
		arg_834_1.time_ = 0
		arg_834_1.frameCnt_ = 0
		arg_834_1.state_ = "playing"
		arg_834_1.curTalkId_ = 1108409203
		arg_834_1.duration_ = 5

		SetActive(arg_834_1.tipsGo_, false)

		function arg_834_1.onSingleLineFinish_()
			arg_834_1.onSingleLineUpdate_ = nil
			arg_834_1.onSingleLineFinish_ = nil
			arg_834_1.state_ = "waiting"
		end

		function arg_834_1.playNext_(arg_836_0)
			if arg_836_0 == 1 then
				arg_834_0:Play1108409204(arg_834_1)
			end
		end

		function arg_834_1.onSingleLineUpdate_(arg_837_0)
			if 0 < arg_834_1.time_ and arg_834_1.time_ <= 0 + arg_837_0 and not isNil(arg_834_1.actors_["1084ui_story"]) and arg_834_1.var_.characterEffect1084ui_story == nil then
				arg_834_1.var_.characterEffect1084ui_story = arg_834_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_837_0 = 0.200000002980232

			if 0 <= arg_834_1.time_ and arg_834_1.time_ < 0 + var_837_0 and not isNil(arg_834_1.actors_["1084ui_story"]) then
				if arg_834_1.var_.characterEffect1084ui_story and not isNil(arg_834_1.actors_["1084ui_story"]) then
					arg_834_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_834_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_834_1.time_ - 0) / var_837_0)
				end
			end

			if arg_834_1.time_ >= 0 + var_837_0 and arg_834_1.time_ < 0 + var_837_0 + arg_837_0 and not isNil(arg_834_1.actors_["1084ui_story"]) and arg_834_1.var_.characterEffect1084ui_story then
				arg_834_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_834_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_837_1 = 0
			local var_837_2 = 0.725

			if 0 < arg_834_1.time_ and arg_834_1.time_ <= var_837_1 + arg_837_0 then
				arg_834_1.talkMaxDuration = 0
				arg_834_1.dialogCg_.alpha = 1

				arg_834_1.dialog_:SetActive(true)
				SetActive(arg_834_1.leftNameGo_, true)

				arg_834_1.leftNameTxt_.text = arg_834_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_834_1.leftNameTxt_.transform)

				arg_834_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_834_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_834_1:RecordName(arg_834_1.leftNameTxt_.text)
				SetActive(arg_834_1.iconTrs_.gameObject, true)
				arg_834_1.iconController_:SetSelectedState("hero")

				arg_834_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_834_1.callingController_:SetSelectedState("normal")

				arg_834_1.keyicon_.color = Color.New(1, 1, 1)
				arg_834_1.icon_.color = Color.New(1, 1, 1)

				local var_837_3 = arg_834_1:FormatText(arg_834_1:GetWordFromCfg(1108409203).content)

				arg_834_1.text_.text = var_837_3

				LuaForUtil.ClearLinePrefixSymbol(arg_834_1.text_)

				local var_837_5 = 29 <= 0 and var_837_2 or var_837_2 * (utf8.len(var_837_3) / 29)

				if (29 <= 0 and var_837_2 or var_837_2 * (utf8.len(var_837_3) / 29)) > 0 and var_837_2 < var_837_5 then
					arg_834_1.talkMaxDuration = var_837_5

					if var_837_5 + var_837_1 > arg_834_1.duration_ then
						arg_834_1.duration_ = var_837_5 + var_837_1
					end
				end

				arg_834_1.text_.text = var_837_3
				arg_834_1.typewritter.percent = 0

				arg_834_1.typewritter:SetDirty()
				arg_834_1:ShowNextGo(false)
				arg_834_1:RecordContent(arg_834_1.text_.text)
			end

			local var_837_6 = math.max(var_837_2, arg_834_1.talkMaxDuration)

			if var_837_1 <= arg_834_1.time_ and arg_834_1.time_ < var_837_1 + var_837_6 then
				arg_834_1.typewritter.percent = (arg_834_1.time_ - var_837_1) / var_837_6

				arg_834_1.typewritter:SetDirty()
			end

			if arg_834_1.time_ >= var_837_1 + var_837_6 and arg_834_1.time_ < var_837_1 + var_837_6 + arg_837_0 then
				arg_834_1.typewritter.percent = 1

				arg_834_1.typewritter:SetDirty()
				arg_834_1:ShowNextGo(true)
			end
		end

		arg_834_1.nodeConfigList_ = {}

		arg_834_1:InitPlayNodeList()
	end,
	Play1108409204 = function(arg_838_0, arg_838_1)
		arg_838_1.time_ = 0
		arg_838_1.frameCnt_ = 0
		arg_838_1.state_ = "playing"
		arg_838_1.curTalkId_ = 1108409204
		arg_838_1.duration_ = 8.87

		SetActive(arg_838_1.tipsGo_, false)

		function arg_838_1.onSingleLineFinish_()
			arg_838_1.onSingleLineUpdate_ = nil
			arg_838_1.onSingleLineFinish_ = nil
			arg_838_1.state_ = "waiting"
			arg_838_1.auto_ = false
		end

		function arg_838_1.playNext_(arg_840_0)
			arg_838_1.onStoryFinished_()
		end

		function arg_838_1.onSingleLineUpdate_(arg_841_0)
			if 0 < arg_838_1.time_ and arg_838_1.time_ <= 0 + arg_841_0 and not isNil(arg_838_1.actors_["1084ui_story"]) and arg_838_1.var_.characterEffect1084ui_story == nil then
				arg_838_1.var_.characterEffect1084ui_story = arg_838_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_841_0 = 0.200000002980232

			if 0 <= arg_838_1.time_ and arg_838_1.time_ < 0 + var_841_0 and not isNil(arg_838_1.actors_["1084ui_story"]) then
				if arg_838_1.var_.characterEffect1084ui_story and not isNil(arg_838_1.actors_["1084ui_story"]) then
					arg_838_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_838_1.time_ >= 0 + var_841_0 and arg_838_1.time_ < 0 + var_841_0 + arg_841_0 and not isNil(arg_838_1.actors_["1084ui_story"]) and arg_838_1.var_.characterEffect1084ui_story then
				arg_838_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_838_1.time_ and arg_838_1.time_ <= 0 + arg_841_0 then
				arg_838_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action4312")
			end

			if 0 < arg_838_1.time_ and arg_838_1.time_ <= 0 + arg_841_0 then
				arg_838_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			if 0 < arg_838_1.time_ and arg_838_1.time_ <= 0 + arg_841_0 then
				arg_838_1:AudioAction("play", "effect", "ui_battle", "ui_battle_stopbgm", "")
			end

			local var_841_3 = 0
			local var_841_4 = 0.95

			if 0 < arg_838_1.time_ and arg_838_1.time_ <= var_841_3 + arg_841_0 then
				arg_838_1.talkMaxDuration = 0
				arg_838_1.dialogCg_.alpha = 1

				arg_838_1.dialog_:SetActive(true)
				SetActive(arg_838_1.leftNameGo_, true)

				arg_838_1.leftNameTxt_.text = arg_838_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_838_1.leftNameTxt_.transform)

				arg_838_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_838_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_838_1:RecordName(arg_838_1.leftNameTxt_.text)
				SetActive(arg_838_1.iconTrs_.gameObject, false)
				arg_838_1.callingController_:SetSelectedState("normal")

				local var_841_5 = arg_838_1:GetWordFromCfg(1108409204)
				local var_841_6 = arg_838_1:FormatText(var_841_5.content)

				arg_838_1.text_.text = var_841_6

				LuaForUtil.ClearLinePrefixSymbol(arg_838_1.text_)

				local var_841_8 = 38 <= 0 and var_841_4 or var_841_4 * (utf8.len(var_841_6) / 38)

				if (38 <= 0 and var_841_4 or var_841_4 * (utf8.len(var_841_6) / 38)) > 0 and var_841_4 < var_841_8 then
					arg_838_1.talkMaxDuration = var_841_8

					if var_841_8 + var_841_3 > arg_838_1.duration_ then
						arg_838_1.duration_ = var_841_8 + var_841_3
					end
				end

				arg_838_1.text_.text = var_841_6
				arg_838_1.typewritter.percent = 0

				arg_838_1.typewritter:SetDirty()
				arg_838_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409204", "story_v_side_new_1108409.awb") ~= 0 then
					local var_841_9 = manager.audio:GetVoiceLength("story_v_side_new_1108409", "1108409204", "story_v_side_new_1108409.awb") / 1000

					if var_841_9 + var_841_3 > arg_838_1.duration_ then
						arg_838_1.duration_ = var_841_9 + var_841_3
					end

					if var_841_5.prefab_name ~= "" and arg_838_1.actors_[var_841_5.prefab_name] ~= nil then
						local var_841_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_838_1.actors_[var_841_5.prefab_name].transform, "story_v_side_new_1108409", "1108409204", "story_v_side_new_1108409.awb")

						arg_838_1:RecordAudio("1108409204", var_841_10)
						arg_838_1:RecordAudio("1108409204", var_841_10)
					else
						arg_838_1:AudioAction("play", "voice", "story_v_side_new_1108409", "1108409204", "story_v_side_new_1108409.awb")
					end

					arg_838_1:RecordHistoryTalkVoice("story_v_side_new_1108409", "1108409204", "story_v_side_new_1108409.awb")
				end

				arg_838_1:RecordContent(arg_838_1.text_.text)
			end

			local var_841_11 = math.max(var_841_4, arg_838_1.talkMaxDuration)

			if var_841_3 <= arg_838_1.time_ and arg_838_1.time_ < var_841_3 + var_841_11 then
				arg_838_1.typewritter.percent = (arg_838_1.time_ - var_841_3) / var_841_11

				arg_838_1.typewritter:SetDirty()
			end

			if arg_838_1.time_ >= var_841_3 + var_841_11 and arg_838_1.time_ < var_841_3 + var_841_11 + arg_841_0 then
				arg_838_1.typewritter.percent = 1

				arg_838_1.typewritter:SetDirty()
				arg_838_1:ShowNextGo(true)
			end
		end

		arg_838_1.nodeConfigList_ = {}

		arg_838_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/A00",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/ST28",
		"TextureConfig/Background/ST04a",
		"TextureConfig/Background/ST2401",
		"TextureConfig/Background/ST03",
		"TextureConfig/Background/ST02",
		"TextureConfig/Background/ST68"
	},
	voices = {
		"story_v_side_new_1108409.awb"
	}
}
