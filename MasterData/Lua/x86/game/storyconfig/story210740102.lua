return {
	Play1107402001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 1107402001
		arg_1_1.duration_ = 6.07

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play1107402002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= 0 + 1.06666666666667 and arg_1_1.time_ < 0 + 1.06666666666667 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_0 = "ST31"

			if arg_1_1.bgs_.ST31 == nil then
				local var_4_1 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_0)
				var_4_1.name = var_4_0
				var_4_1.transform.parent = arg_1_1.stage_.transform
				var_4_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_0] = var_4_1
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_2 = arg_1_1.bgs_.ST31

				arg_1_1.bgs_.ST31.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_2.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_3 = var_4_2:GetComponent("SpriteRenderer")

				if var_4_3 and var_4_3.sprite then
					local var_4_4 = 2 * (var_4_2.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_2.transform.localScale = Vector3.New(var_4_4 / var_4_3.sprite.bounds.size.y < var_4_4 * manager.ui.mainCameraCom_.aspect / var_4_3.sprite.bounds.size.x and var_4_4 * manager.ui.mainCameraCom_.aspect / var_4_3.sprite.bounds.size.x or var_4_4 / var_4_3.sprite.bounds.size.y, var_4_4 / var_4_3.sprite.bounds.size.y < var_4_4 * manager.ui.mainCameraCom_.aspect / var_4_3.sprite.bounds.size.x and var_4_4 * manager.ui.mainCameraCom_.aspect / var_4_3.sprite.bounds.size.x or var_4_4 / var_4_3.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST31" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_5 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_5 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_6 = 1.06666666666667

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
				arg_1_1:AudioAction("play", "music", "bgm_side_daily01", "bgm_side_daily01", "bgm_side_daily01.awb")

				local var_4_14 = manager.audio:GetAudioName("bgm_side_daily01", "bgm_side_daily01")

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
				arg_1_1:AudioAction("play", "effect", "se_story", "se_story_crowdloop", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_16 = 1.06666666666667
			local var_4_17 = 1.3

			if 1.06666666666667 < arg_1_1.time_ and arg_1_1.time_ <= var_4_16 + arg_4_0 then
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

				local var_4_19 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(1107402001).content)

				arg_1_1.text_.text = var_4_19

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_21 = 52 <= 0 and var_4_17 or var_4_17 * (utf8.len(var_4_19) / 52)

				if (52 <= 0 and var_4_17 or var_4_17 * (utf8.len(var_4_19) / 52)) > 0 and var_4_17 < var_4_21 then
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
	Play1107402002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 1107402002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play1107402003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0.4

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, true)
				arg_9_1.iconController_:SetSelectedState("hero")

				arg_9_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_9_1.callingController_:SetSelectedState("normal")

				arg_9_1.keyicon_.color = Color.New(1, 1, 1)
				arg_9_1.icon_.color = Color.New(1, 1, 1)

				local var_12_1 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(1107402002).content)

				arg_9_1.text_.text = var_12_1

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_3 = 16 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 16)

				if (16 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 16)) > 0 and var_12_0 < var_12_3 then
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
	Play1107402003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 1107402003
		arg_13_1.duration_ = 4.2

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play1107402004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if arg_13_1.actors_["1074ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1074ui_story"))) then
				local var_16_0 = Object.Instantiate(Asset.Load("Char/" .. "1074ui_story"), arg_13_1.stage_.transform)

				var_16_0.name = "1074ui_story"
				var_16_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_13_1.actors_["1074ui_story"] = var_16_0

				local var_16_1 = var_16_0:GetComponentInChildren(typeof(CharacterEffect))

				var_16_1.enabled = true

				local var_16_2 = GameObjectTools.GetOrAddComponent(var_16_0, typeof(DynamicBoneHelper))

				if var_16_2 then
					var_16_2:EnableDynamicBone(false)
				end

				arg_13_1:ShowWeapon(var_16_1.transform, false)

				arg_13_1.var_["1074ui_story" .. "Animator"] = var_16_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_13_1.var_["1074ui_story" .. "Animator"].applyRootMotion = true
				arg_13_1.var_["1074ui_story" .. "LipSync"] = var_16_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_16_3 = arg_13_1.actors_["1074ui_story"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_3) and arg_13_1.var_.characterEffect1074ui_story == nil then
				arg_13_1.var_.characterEffect1074ui_story = var_16_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_4 = 0.1

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_4 and not isNil(var_16_3) then
				if arg_13_1.var_.characterEffect1074ui_story and not isNil(var_16_3) then
					arg_13_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= 0 + var_16_4 and arg_13_1.time_ < 0 + var_16_4 + arg_16_0 and not isNil(var_16_3) and arg_13_1.var_.characterEffect1074ui_story then
				arg_13_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_16_6 = arg_13_1.actors_["1074ui_story"].transform

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos1074ui_story = var_16_6.localPosition

				arg_13_1:ShowWeapon(arg_13_1.var_["1074ui_story" .. "Animator"].transform, false)
			end

			local var_16_7 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_7 then
				var_16_6.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1074ui_story, Vector3.New(0, -1.055, -6.12), (arg_13_1.time_ - 0) / var_16_7)
				var_16_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_16_6.position).x, (manager.ui.mainCamera.transform.position - var_16_6.position).y, (manager.ui.mainCamera.transform.position - var_16_6.position).z)
				var_16_6.localEulerAngles.z = 0
				var_16_6.localEulerAngles.x = 0
				var_16_6.localEulerAngles = var_16_6.localEulerAngles
			end

			if arg_13_1.time_ >= 0 + var_16_7 and arg_13_1.time_ < 0 + var_16_7 + arg_16_0 then
				var_16_6.localPosition = Vector3.New(0, -1.055, -6.12)
				var_16_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_16_6.position).x, (manager.ui.mainCamera.transform.position - var_16_6.position).y, (manager.ui.mainCamera.transform.position - var_16_6.position).z)
				var_16_6.localEulerAngles.z = 0
				var_16_6.localEulerAngles.x = 0
				var_16_6.localEulerAngles = var_16_6.localEulerAngles
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action2_1")
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_16_8 = 0
			local var_16_9 = 0.5

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_8 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_10 = arg_13_1:GetWordFromCfg(1107402003)
				local var_16_11 = arg_13_1:FormatText(var_16_10.content)

				arg_13_1.text_.text = var_16_11

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_13 = 20 <= 0 and var_16_9 or var_16_9 * (utf8.len(var_16_11) / 20)

				if (20 <= 0 and var_16_9 or var_16_9 * (utf8.len(var_16_11) / 20)) > 0 and var_16_9 < var_16_13 then
					arg_13_1.talkMaxDuration = var_16_13

					if var_16_13 + var_16_8 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_13 + var_16_8
					end
				end

				arg_13_1.text_.text = var_16_11
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107402", "1107402003", "story_v_side_new_1107402.awb") ~= 0 then
					local var_16_14 = manager.audio:GetVoiceLength("story_v_side_new_1107402", "1107402003", "story_v_side_new_1107402.awb") / 1000

					if var_16_14 + var_16_8 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_14 + var_16_8
					end

					if var_16_10.prefab_name ~= "" and arg_13_1.actors_[var_16_10.prefab_name] ~= nil then
						local var_16_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_10.prefab_name].transform, "story_v_side_new_1107402", "1107402003", "story_v_side_new_1107402.awb")

						arg_13_1:RecordAudio("1107402003", var_16_15)
						arg_13_1:RecordAudio("1107402003", var_16_15)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_side_new_1107402", "1107402003", "story_v_side_new_1107402.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_side_new_1107402", "1107402003", "story_v_side_new_1107402.awb")
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
				actorName = "1074ui_story",
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
	Play1107402004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 1107402004
		arg_17_1.duration_ = 6.97

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play1107402005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(arg_17_1.actors_["1074ui_story"]) and arg_17_1.var_.characterEffect1074ui_story == nil then
				arg_17_1.var_.characterEffect1074ui_story = arg_17_1.actors_["1074ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_0 = 0.1

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_0 and not isNil(arg_17_1.actors_["1074ui_story"]) then
				if arg_17_1.var_.characterEffect1074ui_story and not isNil(arg_17_1.actors_["1074ui_story"]) then
					arg_17_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_17_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_17_1.time_ - 0) / var_20_0)
				end
			end

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 and not isNil(arg_17_1.actors_["1074ui_story"]) and arg_17_1.var_.characterEffect1074ui_story then
				arg_17_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_17_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			local var_20_1 = 0
			local var_20_2 = 0.8

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[1050].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, true)
				arg_17_1.iconController_:SetSelectedState("hero")

				arg_17_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwc")

				arg_17_1.callingController_:SetSelectedState("normal")

				arg_17_1.keyicon_.color = Color.New(1, 1, 1)
				arg_17_1.icon_.color = Color.New(1, 1, 1)

				local var_20_3 = arg_17_1:GetWordFromCfg(1107402004)
				local var_20_4 = arg_17_1:FormatText(var_20_3.content)

				arg_17_1.text_.text = var_20_4

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_6 = 32 <= 0 and var_20_2 or var_20_2 * (utf8.len(var_20_4) / 32)

				if (32 <= 0 and var_20_2 or var_20_2 * (utf8.len(var_20_4) / 32)) > 0 and var_20_2 < var_20_6 then
					arg_17_1.talkMaxDuration = var_20_6

					if var_20_6 + var_20_1 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_6 + var_20_1
					end
				end

				arg_17_1.text_.text = var_20_4
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107402", "1107402004", "story_v_side_new_1107402.awb") ~= 0 then
					local var_20_7 = manager.audio:GetVoiceLength("story_v_side_new_1107402", "1107402004", "story_v_side_new_1107402.awb") / 1000

					if var_20_7 + var_20_1 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_7 + var_20_1
					end

					if var_20_3.prefab_name ~= "" and arg_17_1.actors_[var_20_3.prefab_name] ~= nil then
						local var_20_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_3.prefab_name].transform, "story_v_side_new_1107402", "1107402004", "story_v_side_new_1107402.awb")

						arg_17_1:RecordAudio("1107402004", var_20_8)
						arg_17_1:RecordAudio("1107402004", var_20_8)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_side_new_1107402", "1107402004", "story_v_side_new_1107402.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_side_new_1107402", "1107402004", "story_v_side_new_1107402.awb")
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
	Play1107402005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 1107402005
		arg_21_1.duration_ = 11.1

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play1107402006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 1.475

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[1050].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, true)
				arg_21_1.iconController_:SetSelectedState("hero")

				arg_21_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwc")

				arg_21_1.callingController_:SetSelectedState("normal")

				arg_21_1.keyicon_.color = Color.New(1, 1, 1)
				arg_21_1.icon_.color = Color.New(1, 1, 1)

				local var_24_1 = arg_21_1:GetWordFromCfg(1107402005)
				local var_24_2 = arg_21_1:FormatText(var_24_1.content)

				arg_21_1.text_.text = var_24_2

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_4 = 59 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_2) / 59)

				if (59 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_2) / 59)) > 0 and var_24_0 < var_24_4 then
					arg_21_1.talkMaxDuration = var_24_4

					if var_24_4 + 0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_4 + 0
					end
				end

				arg_21_1.text_.text = var_24_2
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107402", "1107402005", "story_v_side_new_1107402.awb") ~= 0 then
					local var_24_5 = manager.audio:GetVoiceLength("story_v_side_new_1107402", "1107402005", "story_v_side_new_1107402.awb") / 1000

					if var_24_5 + 0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_5 + 0
					end

					if var_24_1.prefab_name ~= "" and arg_21_1.actors_[var_24_1.prefab_name] ~= nil then
						local var_24_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_1.prefab_name].transform, "story_v_side_new_1107402", "1107402005", "story_v_side_new_1107402.awb")

						arg_21_1:RecordAudio("1107402005", var_24_6)
						arg_21_1:RecordAudio("1107402005", var_24_6)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_side_new_1107402", "1107402005", "story_v_side_new_1107402.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_side_new_1107402", "1107402005", "story_v_side_new_1107402.awb")
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
	Play1107402006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 1107402006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play1107402007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0.3

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

				local var_28_1 = arg_25_1:FormatText(arg_25_1:GetWordFromCfg(1107402006).content)

				arg_25_1.text_.text = var_28_1

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_3 = 12 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_1) / 12)

				if (12 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_1) / 12)) > 0 and var_28_0 < var_28_3 then
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
	Play1107402007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 1107402007
		arg_29_1.duration_ = 2

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play1107402008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(arg_29_1.actors_["1074ui_story"]) and arg_29_1.var_.characterEffect1074ui_story == nil then
				arg_29_1.var_.characterEffect1074ui_story = arg_29_1.actors_["1074ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_0 = 0.1

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_0 and not isNil(arg_29_1.actors_["1074ui_story"]) then
				if arg_29_1.var_.characterEffect1074ui_story and not isNil(arg_29_1.actors_["1074ui_story"]) then
					arg_29_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= 0 + var_32_0 and arg_29_1.time_ < 0 + var_32_0 + arg_32_0 and not isNil(arg_29_1.actors_["1074ui_story"]) and arg_29_1.var_.characterEffect1074ui_story then
				arg_29_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action2_2")
			end

			local var_32_2 = 0
			local var_32_3 = 0.125

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_2 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_4 = arg_29_1:GetWordFromCfg(1107402007)
				local var_32_5 = arg_29_1:FormatText(var_32_4.content)

				arg_29_1.text_.text = var_32_5

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_7 = 5 <= 0 and var_32_3 or var_32_3 * (utf8.len(var_32_5) / 5)

				if (5 <= 0 and var_32_3 or var_32_3 * (utf8.len(var_32_5) / 5)) > 0 and var_32_3 < var_32_7 then
					arg_29_1.talkMaxDuration = var_32_7

					if var_32_7 + var_32_2 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_7 + var_32_2
					end
				end

				arg_29_1.text_.text = var_32_5
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107402", "1107402007", "story_v_side_new_1107402.awb") ~= 0 then
					local var_32_8 = manager.audio:GetVoiceLength("story_v_side_new_1107402", "1107402007", "story_v_side_new_1107402.awb") / 1000

					if var_32_8 + var_32_2 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_8 + var_32_2
					end

					if var_32_4.prefab_name ~= "" and arg_29_1.actors_[var_32_4.prefab_name] ~= nil then
						local var_32_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_4.prefab_name].transform, "story_v_side_new_1107402", "1107402007", "story_v_side_new_1107402.awb")

						arg_29_1:RecordAudio("1107402007", var_32_9)
						arg_29_1:RecordAudio("1107402007", var_32_9)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_side_new_1107402", "1107402007", "story_v_side_new_1107402.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_side_new_1107402", "1107402007", "story_v_side_new_1107402.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_10 = math.max(var_32_3, arg_29_1.talkMaxDuration)

			if var_32_2 <= arg_29_1.time_ and arg_29_1.time_ < var_32_2 + var_32_10 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_2) / var_32_10

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_2 + var_32_10 and arg_29_1.time_ < var_32_2 + var_32_10 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play1107402008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 1107402008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play1107402009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(arg_33_1.actors_["1074ui_story"]) and arg_33_1.var_.characterEffect1074ui_story == nil then
				arg_33_1.var_.characterEffect1074ui_story = arg_33_1.actors_["1074ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_0 = 0.1

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 and not isNil(arg_33_1.actors_["1074ui_story"]) then
				if arg_33_1.var_.characterEffect1074ui_story and not isNil(arg_33_1.actors_["1074ui_story"]) then
					arg_33_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_33_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_33_1.time_ - 0) / var_36_0)
				end
			end

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 and not isNil(arg_33_1.actors_["1074ui_story"]) and arg_33_1.var_.characterEffect1074ui_story then
				arg_33_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_33_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			local var_36_1 = 0
			local var_36_2 = 0.825

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, false)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_3 = arg_33_1:FormatText(arg_33_1:GetWordFromCfg(1107402008).content)

				arg_33_1.text_.text = var_36_3

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_5 = 33 <= 0 and var_36_2 or var_36_2 * (utf8.len(var_36_3) / 33)

				if (33 <= 0 and var_36_2 or var_36_2 * (utf8.len(var_36_3) / 33)) > 0 and var_36_2 < var_36_5 then
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
	Play1107402009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 1107402009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play1107402010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 0.5

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, true)
				arg_37_1.iconController_:SetSelectedState("hero")

				arg_37_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_37_1.callingController_:SetSelectedState("normal")

				arg_37_1.keyicon_.color = Color.New(1, 1, 1)
				arg_37_1.icon_.color = Color.New(1, 1, 1)

				local var_40_1 = arg_37_1:FormatText(arg_37_1:GetWordFromCfg(1107402009).content)

				arg_37_1.text_.text = var_40_1

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_3 = 20 <= 0 and var_40_0 or var_40_0 * (utf8.len(var_40_1) / 20)

				if (20 <= 0 and var_40_0 or var_40_0 * (utf8.len(var_40_1) / 20)) > 0 and var_40_0 < var_40_3 then
					arg_37_1.talkMaxDuration = var_40_3

					if var_40_3 + 0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_3 + 0
					end
				end

				arg_37_1.text_.text = var_40_1
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_4 = math.max(var_40_0, arg_37_1.talkMaxDuration)

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_4 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - 0) / var_40_4

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= 0 + var_40_4 and arg_37_1.time_ < 0 + var_40_4 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play1107402010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 1107402010
		arg_41_1.duration_ = 1.43

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play1107402011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(arg_41_1.actors_["1074ui_story"]) and arg_41_1.var_.characterEffect1074ui_story == nil then
				arg_41_1.var_.characterEffect1074ui_story = arg_41_1.actors_["1074ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_0 = 0.1

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_0 and not isNil(arg_41_1.actors_["1074ui_story"]) then
				if arg_41_1.var_.characterEffect1074ui_story and not isNil(arg_41_1.actors_["1074ui_story"]) then
					arg_41_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= 0 + var_44_0 and arg_41_1.time_ < 0 + var_44_0 + arg_44_0 and not isNil(arg_41_1.actors_["1074ui_story"]) and arg_41_1.var_.characterEffect1074ui_story then
				arg_41_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_44_2 = 0
			local var_44_3 = 0.15

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_2 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_4 = arg_41_1:GetWordFromCfg(1107402010)
				local var_44_5 = arg_41_1:FormatText(var_44_4.content)

				arg_41_1.text_.text = var_44_5

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_7 = 6 <= 0 and var_44_3 or var_44_3 * (utf8.len(var_44_5) / 6)

				if (6 <= 0 and var_44_3 or var_44_3 * (utf8.len(var_44_5) / 6)) > 0 and var_44_3 < var_44_7 then
					arg_41_1.talkMaxDuration = var_44_7

					if var_44_7 + var_44_2 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_7 + var_44_2
					end
				end

				arg_41_1.text_.text = var_44_5
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107402", "1107402010", "story_v_side_new_1107402.awb") ~= 0 then
					local var_44_8 = manager.audio:GetVoiceLength("story_v_side_new_1107402", "1107402010", "story_v_side_new_1107402.awb") / 1000

					if var_44_8 + var_44_2 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_8 + var_44_2
					end

					if var_44_4.prefab_name ~= "" and arg_41_1.actors_[var_44_4.prefab_name] ~= nil then
						local var_44_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_4.prefab_name].transform, "story_v_side_new_1107402", "1107402010", "story_v_side_new_1107402.awb")

						arg_41_1:RecordAudio("1107402010", var_44_9)
						arg_41_1:RecordAudio("1107402010", var_44_9)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_side_new_1107402", "1107402010", "story_v_side_new_1107402.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_side_new_1107402", "1107402010", "story_v_side_new_1107402.awb")
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
	Play1107402011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 1107402011
		arg_45_1.duration_ = 4.33

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play1107402012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 0.525

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_1 = arg_45_1:GetWordFromCfg(1107402011)
				local var_48_2 = arg_45_1:FormatText(var_48_1.content)

				arg_45_1.text_.text = var_48_2

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_4 = 21 <= 0 and var_48_0 or var_48_0 * (utf8.len(var_48_2) / 21)

				if (21 <= 0 and var_48_0 or var_48_0 * (utf8.len(var_48_2) / 21)) > 0 and var_48_0 < var_48_4 then
					arg_45_1.talkMaxDuration = var_48_4

					if var_48_4 + 0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_4 + 0
					end
				end

				arg_45_1.text_.text = var_48_2
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107402", "1107402011", "story_v_side_new_1107402.awb") ~= 0 then
					local var_48_5 = manager.audio:GetVoiceLength("story_v_side_new_1107402", "1107402011", "story_v_side_new_1107402.awb") / 1000

					if var_48_5 + 0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_5 + 0
					end

					if var_48_1.prefab_name ~= "" and arg_45_1.actors_[var_48_1.prefab_name] ~= nil then
						local var_48_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_1.prefab_name].transform, "story_v_side_new_1107402", "1107402011", "story_v_side_new_1107402.awb")

						arg_45_1:RecordAudio("1107402011", var_48_6)
						arg_45_1:RecordAudio("1107402011", var_48_6)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_side_new_1107402", "1107402011", "story_v_side_new_1107402.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_side_new_1107402", "1107402011", "story_v_side_new_1107402.awb")
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
	Play1107402012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 1107402012
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play1107402013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(arg_49_1.actors_["1074ui_story"]) and arg_49_1.var_.characterEffect1074ui_story == nil then
				arg_49_1.var_.characterEffect1074ui_story = arg_49_1.actors_["1074ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_0 = 0.1

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_0 and not isNil(arg_49_1.actors_["1074ui_story"]) then
				if arg_49_1.var_.characterEffect1074ui_story and not isNil(arg_49_1.actors_["1074ui_story"]) then
					arg_49_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_49_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_49_1.time_ - 0) / var_52_0)
				end
			end

			if arg_49_1.time_ >= 0 + var_52_0 and arg_49_1.time_ < 0 + var_52_0 + arg_52_0 and not isNil(arg_49_1.actors_["1074ui_story"]) and arg_49_1.var_.characterEffect1074ui_story then
				arg_49_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_49_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			local var_52_1 = 0
			local var_52_2 = 0.95

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, true)
				arg_49_1.iconController_:SetSelectedState("hero")

				arg_49_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_49_1.callingController_:SetSelectedState("normal")

				arg_49_1.keyicon_.color = Color.New(1, 1, 1)
				arg_49_1.icon_.color = Color.New(1, 1, 1)

				local var_52_3 = arg_49_1:FormatText(arg_49_1:GetWordFromCfg(1107402012).content)

				arg_49_1.text_.text = var_52_3

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_5 = 38 <= 0 and var_52_2 or var_52_2 * (utf8.len(var_52_3) / 38)

				if (38 <= 0 and var_52_2 or var_52_2 * (utf8.len(var_52_3) / 38)) > 0 and var_52_2 < var_52_5 then
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
	Play1107402013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 1107402013
		arg_53_1.duration_ = 5

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play1107402014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 0.675

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, false)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_1 = arg_53_1:FormatText(arg_53_1:GetWordFromCfg(1107402013).content)

				arg_53_1.text_.text = var_56_1

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_3 = 27 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_1) / 27)

				if (27 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_1) / 27)) > 0 and var_56_0 < var_56_3 then
					arg_53_1.talkMaxDuration = var_56_3

					if var_56_3 + 0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_3 + 0
					end
				end

				arg_53_1.text_.text = var_56_1
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_4 = math.max(var_56_0, arg_53_1.talkMaxDuration)

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_4 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - 0) / var_56_4

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= 0 + var_56_4 and arg_53_1.time_ < 0 + var_56_4 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play1107402014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 1107402014
		arg_57_1.duration_ = 3.37

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play1107402015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(arg_57_1.actors_["1074ui_story"]) and arg_57_1.var_.characterEffect1074ui_story == nil then
				arg_57_1.var_.characterEffect1074ui_story = arg_57_1.actors_["1074ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_0 = 0.1

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_0 and not isNil(arg_57_1.actors_["1074ui_story"]) then
				if arg_57_1.var_.characterEffect1074ui_story and not isNil(arg_57_1.actors_["1074ui_story"]) then
					arg_57_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_57_1.time_ >= 0 + var_60_0 and arg_57_1.time_ < 0 + var_60_0 + arg_60_0 and not isNil(arg_57_1.actors_["1074ui_story"]) and arg_57_1.var_.characterEffect1074ui_story then
				arg_57_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2201cva")
			end

			local var_60_2 = 0
			local var_60_3 = 0.45

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_2 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_4 = arg_57_1:GetWordFromCfg(1107402014)
				local var_60_5 = arg_57_1:FormatText(var_60_4.content)

				arg_57_1.text_.text = var_60_5

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_7 = 18 <= 0 and var_60_3 or var_60_3 * (utf8.len(var_60_5) / 18)

				if (18 <= 0 and var_60_3 or var_60_3 * (utf8.len(var_60_5) / 18)) > 0 and var_60_3 < var_60_7 then
					arg_57_1.talkMaxDuration = var_60_7

					if var_60_7 + var_60_2 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_7 + var_60_2
					end
				end

				arg_57_1.text_.text = var_60_5
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107402", "1107402014", "story_v_side_new_1107402.awb") ~= 0 then
					local var_60_8 = manager.audio:GetVoiceLength("story_v_side_new_1107402", "1107402014", "story_v_side_new_1107402.awb") / 1000

					if var_60_8 + var_60_2 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_8 + var_60_2
					end

					if var_60_4.prefab_name ~= "" and arg_57_1.actors_[var_60_4.prefab_name] ~= nil then
						local var_60_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_4.prefab_name].transform, "story_v_side_new_1107402", "1107402014", "story_v_side_new_1107402.awb")

						arg_57_1:RecordAudio("1107402014", var_60_9)
						arg_57_1:RecordAudio("1107402014", var_60_9)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_side_new_1107402", "1107402014", "story_v_side_new_1107402.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_side_new_1107402", "1107402014", "story_v_side_new_1107402.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_10 = math.max(var_60_3, arg_57_1.talkMaxDuration)

			if var_60_2 <= arg_57_1.time_ and arg_57_1.time_ < var_60_2 + var_60_10 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_2) / var_60_10

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_2 + var_60_10 and arg_57_1.time_ < var_60_2 + var_60_10 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play1107402015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 1107402015
		arg_61_1.duration_ = 2

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play1107402016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action3_1")
			end

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_64_0 = 0
			local var_64_1 = 0.175

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_0 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_2 = arg_61_1:GetWordFromCfg(1107402015)
				local var_64_3 = arg_61_1:FormatText(var_64_2.content)

				arg_61_1.text_.text = var_64_3

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_5 = 7 <= 0 and var_64_1 or var_64_1 * (utf8.len(var_64_3) / 7)

				if (7 <= 0 and var_64_1 or var_64_1 * (utf8.len(var_64_3) / 7)) > 0 and var_64_1 < var_64_5 then
					arg_61_1.talkMaxDuration = var_64_5

					if var_64_5 + var_64_0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_5 + var_64_0
					end
				end

				arg_61_1.text_.text = var_64_3
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107402", "1107402015", "story_v_side_new_1107402.awb") ~= 0 then
					local var_64_6 = manager.audio:GetVoiceLength("story_v_side_new_1107402", "1107402015", "story_v_side_new_1107402.awb") / 1000

					if var_64_6 + var_64_0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_6 + var_64_0
					end

					if var_64_2.prefab_name ~= "" and arg_61_1.actors_[var_64_2.prefab_name] ~= nil then
						local var_64_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_2.prefab_name].transform, "story_v_side_new_1107402", "1107402015", "story_v_side_new_1107402.awb")

						arg_61_1:RecordAudio("1107402015", var_64_7)
						arg_61_1:RecordAudio("1107402015", var_64_7)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_side_new_1107402", "1107402015", "story_v_side_new_1107402.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_side_new_1107402", "1107402015", "story_v_side_new_1107402.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_8 = math.max(var_64_1, arg_61_1.talkMaxDuration)

			if var_64_0 <= arg_61_1.time_ and arg_61_1.time_ < var_64_0 + var_64_8 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_0) / var_64_8

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_0 + var_64_8 and arg_61_1.time_ < var_64_0 + var_64_8 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play1107402016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 1107402016
		arg_65_1.duration_ = 1

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"

			SetActive(arg_65_1.choicesGo_, true)

			for iter_66_0, iter_66_1 in ipairs(arg_65_1.choices_) do
				SetActive(iter_66_1.go, iter_66_0 <= 2)
			end

			arg_65_1.choices_[1].txt.text = arg_65_1:FormatText(StoryChoiceCfg[1010].name)
			arg_65_1.choices_[2].txt.text = arg_65_1:FormatText(StoryChoiceCfg[1011].name)
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play1107402017(arg_65_1)
			end

			if arg_67_0 == 2 then
				arg_65_0:Play1107402019(arg_65_1)
			end

			arg_65_1:RecordChoiceLog(1107402016, 1010, 1011)
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(arg_65_1.actors_["1074ui_story"]) and arg_65_1.var_.characterEffect1074ui_story == nil then
				arg_65_1.var_.characterEffect1074ui_story = arg_65_1.actors_["1074ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_0 = 0.1

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_0 and not isNil(arg_65_1.actors_["1074ui_story"]) then
				if arg_65_1.var_.characterEffect1074ui_story and not isNil(arg_65_1.actors_["1074ui_story"]) then
					arg_65_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_65_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_65_1.time_ - 0) / var_68_0)
				end
			end

			if arg_65_1.time_ >= 0 + var_68_0 and arg_65_1.time_ < 0 + var_68_0 + arg_68_0 and not isNil(arg_65_1.actors_["1074ui_story"]) and arg_65_1.var_.characterEffect1074ui_story then
				arg_65_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_65_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play1107402017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 1107402017
		arg_69_1.duration_ = 5

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play1107402018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = 0.4

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
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

				local var_72_1 = arg_69_1:FormatText(arg_69_1:GetWordFromCfg(1107402017).content)

				arg_69_1.text_.text = var_72_1

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_3 = 16 <= 0 and var_72_0 or var_72_0 * (utf8.len(var_72_1) / 16)

				if (16 <= 0 and var_72_0 or var_72_0 * (utf8.len(var_72_1) / 16)) > 0 and var_72_0 < var_72_3 then
					arg_69_1.talkMaxDuration = var_72_3

					if var_72_3 + 0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_3 + 0
					end
				end

				arg_69_1.text_.text = var_72_1
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)
				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_4 = math.max(var_72_0, arg_69_1.talkMaxDuration)

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_4 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - 0) / var_72_4

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= 0 + var_72_4 and arg_69_1.time_ < 0 + var_72_4 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play1107402018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 1107402018
		arg_73_1.duration_ = 2.43

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play1107402021(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(arg_73_1.actors_["1074ui_story"]) and arg_73_1.var_.characterEffect1074ui_story == nil then
				arg_73_1.var_.characterEffect1074ui_story = arg_73_1.actors_["1074ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_0 = 0.1

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_0 and not isNil(arg_73_1.actors_["1074ui_story"]) then
				if arg_73_1.var_.characterEffect1074ui_story and not isNil(arg_73_1.actors_["1074ui_story"]) then
					arg_73_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_73_1.time_ >= 0 + var_76_0 and arg_73_1.time_ < 0 + var_76_0 + arg_76_0 and not isNil(arg_73_1.actors_["1074ui_story"]) and arg_73_1.var_.characterEffect1074ui_story then
				arg_73_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action3_2")
			end

			local var_76_2 = 0
			local var_76_3 = 0.1

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_2 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_4 = arg_73_1:GetWordFromCfg(1107402018)
				local var_76_5 = arg_73_1:FormatText(var_76_4.content)

				arg_73_1.text_.text = var_76_5

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_7 = 4 <= 0 and var_76_3 or var_76_3 * (utf8.len(var_76_5) / 4)

				if (4 <= 0 and var_76_3 or var_76_3 * (utf8.len(var_76_5) / 4)) > 0 and var_76_3 < var_76_7 then
					arg_73_1.talkMaxDuration = var_76_7

					if var_76_7 + var_76_2 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_7 + var_76_2
					end
				end

				arg_73_1.text_.text = var_76_5
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107402", "1107402018", "story_v_side_new_1107402.awb") ~= 0 then
					local var_76_8 = manager.audio:GetVoiceLength("story_v_side_new_1107402", "1107402018", "story_v_side_new_1107402.awb") / 1000

					if var_76_8 + var_76_2 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_8 + var_76_2
					end

					if var_76_4.prefab_name ~= "" and arg_73_1.actors_[var_76_4.prefab_name] ~= nil then
						local var_76_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_4.prefab_name].transform, "story_v_side_new_1107402", "1107402018", "story_v_side_new_1107402.awb")

						arg_73_1:RecordAudio("1107402018", var_76_9)
						arg_73_1:RecordAudio("1107402018", var_76_9)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_side_new_1107402", "1107402018", "story_v_side_new_1107402.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_side_new_1107402", "1107402018", "story_v_side_new_1107402.awb")
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
	Play1107402021 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 1107402021
		arg_77_1.duration_ = 5

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play1107402022(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(arg_77_1.actors_["1074ui_story"]) and arg_77_1.var_.characterEffect1074ui_story == nil then
				arg_77_1.var_.characterEffect1074ui_story = arg_77_1.actors_["1074ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_0 = 0.1

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_0 and not isNil(arg_77_1.actors_["1074ui_story"]) then
				if arg_77_1.var_.characterEffect1074ui_story and not isNil(arg_77_1.actors_["1074ui_story"]) then
					arg_77_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_77_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_77_1.time_ - 0) / var_80_0)
				end
			end

			if arg_77_1.time_ >= 0 + var_80_0 and arg_77_1.time_ < 0 + var_80_0 + arg_80_0 and not isNil(arg_77_1.actors_["1074ui_story"]) and arg_77_1.var_.characterEffect1074ui_story then
				arg_77_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_77_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			local var_80_1 = 0
			local var_80_2 = 0.575

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_1 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, false)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_3 = arg_77_1:FormatText(arg_77_1:GetWordFromCfg(1107402021).content)

				arg_77_1.text_.text = var_80_3

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_5 = 23 <= 0 and var_80_2 or var_80_2 * (utf8.len(var_80_3) / 23)

				if (23 <= 0 and var_80_2 or var_80_2 * (utf8.len(var_80_3) / 23)) > 0 and var_80_2 < var_80_5 then
					arg_77_1.talkMaxDuration = var_80_5

					if var_80_5 + var_80_1 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_5 + var_80_1
					end
				end

				arg_77_1.text_.text = var_80_3
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)
				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_6 = math.max(var_80_2, arg_77_1.talkMaxDuration)

			if var_80_1 <= arg_77_1.time_ and arg_77_1.time_ < var_80_1 + var_80_6 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_1) / var_80_6

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_1 + var_80_6 and arg_77_1.time_ < var_80_1 + var_80_6 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play1107402022 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 1107402022
		arg_81_1.duration_ = 5

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play1107402023(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(arg_81_1.actors_["1074ui_story"]) and arg_81_1.var_.characterEffect1074ui_story == nil then
				arg_81_1.var_.characterEffect1074ui_story = arg_81_1.actors_["1074ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_0 = 0.1

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_0 and not isNil(arg_81_1.actors_["1074ui_story"]) then
				if arg_81_1.var_.characterEffect1074ui_story and not isNil(arg_81_1.actors_["1074ui_story"]) then
					arg_81_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_81_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_81_1.time_ - 0) / var_84_0)
				end
			end

			if arg_81_1.time_ >= 0 + var_84_0 and arg_81_1.time_ < 0 + var_84_0 + arg_84_0 and not isNil(arg_81_1.actors_["1074ui_story"]) and arg_81_1.var_.characterEffect1074ui_story then
				arg_81_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_81_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			local var_84_1 = 0
			local var_84_2 = 0.8

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_1 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, false)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_3 = arg_81_1:FormatText(arg_81_1:GetWordFromCfg(1107402022).content)

				arg_81_1.text_.text = var_84_3

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_5 = 32 <= 0 and var_84_2 or var_84_2 * (utf8.len(var_84_3) / 32)

				if (32 <= 0 and var_84_2 or var_84_2 * (utf8.len(var_84_3) / 32)) > 0 and var_84_2 < var_84_5 then
					arg_81_1.talkMaxDuration = var_84_5

					if var_84_5 + var_84_1 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_5 + var_84_1
					end
				end

				arg_81_1.text_.text = var_84_3
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)
				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_6 = math.max(var_84_2, arg_81_1.talkMaxDuration)

			if var_84_1 <= arg_81_1.time_ and arg_81_1.time_ < var_84_1 + var_84_6 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_1) / var_84_6

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_1 + var_84_6 and arg_81_1.time_ < var_84_1 + var_84_6 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play1107402023 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 1107402023
		arg_85_1.duration_ = 5

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play1107402024(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = 0.825

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[1076].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_1 = arg_85_1:FormatText(arg_85_1:GetWordFromCfg(1107402023).content)

				arg_85_1.text_.text = var_88_1

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_3 = 33 <= 0 and var_88_0 or var_88_0 * (utf8.len(var_88_1) / 33)

				if (33 <= 0 and var_88_0 or var_88_0 * (utf8.len(var_88_1) / 33)) > 0 and var_88_0 < var_88_3 then
					arg_85_1.talkMaxDuration = var_88_3

					if var_88_3 + 0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_3 + 0
					end
				end

				arg_85_1.text_.text = var_88_1
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)
				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_4 = math.max(var_88_0, arg_85_1.talkMaxDuration)

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_4 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - 0) / var_88_4

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= 0 + var_88_4 and arg_85_1.time_ < 0 + var_88_4 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play1107402024 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 1107402024
		arg_89_1.duration_ = 3.33

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play1107402025(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(arg_89_1.actors_["1074ui_story"]) and arg_89_1.var_.characterEffect1074ui_story == nil then
				arg_89_1.var_.characterEffect1074ui_story = arg_89_1.actors_["1074ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_0 = 0.1

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_0 and not isNil(arg_89_1.actors_["1074ui_story"]) then
				if arg_89_1.var_.characterEffect1074ui_story and not isNil(arg_89_1.actors_["1074ui_story"]) then
					arg_89_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_89_1.time_ >= 0 + var_92_0 and arg_89_1.time_ < 0 + var_92_0 + arg_92_0 and not isNil(arg_89_1.actors_["1074ui_story"]) and arg_89_1.var_.characterEffect1074ui_story then
				arg_89_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action2_1")
			end

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_92_2 = 0
			local var_92_3 = 0.425

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_2 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_4 = arg_89_1:GetWordFromCfg(1107402024)
				local var_92_5 = arg_89_1:FormatText(var_92_4.content)

				arg_89_1.text_.text = var_92_5

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_7 = 17 <= 0 and var_92_3 or var_92_3 * (utf8.len(var_92_5) / 17)

				if (17 <= 0 and var_92_3 or var_92_3 * (utf8.len(var_92_5) / 17)) > 0 and var_92_3 < var_92_7 then
					arg_89_1.talkMaxDuration = var_92_7

					if var_92_7 + var_92_2 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_7 + var_92_2
					end
				end

				arg_89_1.text_.text = var_92_5
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107402", "1107402024", "story_v_side_new_1107402.awb") ~= 0 then
					local var_92_8 = manager.audio:GetVoiceLength("story_v_side_new_1107402", "1107402024", "story_v_side_new_1107402.awb") / 1000

					if var_92_8 + var_92_2 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_8 + var_92_2
					end

					if var_92_4.prefab_name ~= "" and arg_89_1.actors_[var_92_4.prefab_name] ~= nil then
						local var_92_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_4.prefab_name].transform, "story_v_side_new_1107402", "1107402024", "story_v_side_new_1107402.awb")

						arg_89_1:RecordAudio("1107402024", var_92_9)
						arg_89_1:RecordAudio("1107402024", var_92_9)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_side_new_1107402", "1107402024", "story_v_side_new_1107402.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_side_new_1107402", "1107402024", "story_v_side_new_1107402.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_10 = math.max(var_92_3, arg_89_1.talkMaxDuration)

			if var_92_2 <= arg_89_1.time_ and arg_89_1.time_ < var_92_2 + var_92_10 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_2) / var_92_10

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_2 + var_92_10 and arg_89_1.time_ < var_92_2 + var_92_10 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play1107402025 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 1107402025
		arg_93_1.duration_ = 3.97

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play1107402026(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = 0.425

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_1 = arg_93_1:GetWordFromCfg(1107402025)
				local var_96_2 = arg_93_1:FormatText(var_96_1.content)

				arg_93_1.text_.text = var_96_2

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_4 = 17 <= 0 and var_96_0 or var_96_0 * (utf8.len(var_96_2) / 17)

				if (17 <= 0 and var_96_0 or var_96_0 * (utf8.len(var_96_2) / 17)) > 0 and var_96_0 < var_96_4 then
					arg_93_1.talkMaxDuration = var_96_4

					if var_96_4 + 0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_4 + 0
					end
				end

				arg_93_1.text_.text = var_96_2
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107402", "1107402025", "story_v_side_new_1107402.awb") ~= 0 then
					local var_96_5 = manager.audio:GetVoiceLength("story_v_side_new_1107402", "1107402025", "story_v_side_new_1107402.awb") / 1000

					if var_96_5 + 0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_5 + 0
					end

					if var_96_1.prefab_name ~= "" and arg_93_1.actors_[var_96_1.prefab_name] ~= nil then
						local var_96_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_1.prefab_name].transform, "story_v_side_new_1107402", "1107402025", "story_v_side_new_1107402.awb")

						arg_93_1:RecordAudio("1107402025", var_96_6)
						arg_93_1:RecordAudio("1107402025", var_96_6)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_side_new_1107402", "1107402025", "story_v_side_new_1107402.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_side_new_1107402", "1107402025", "story_v_side_new_1107402.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_7 = math.max(var_96_0, arg_93_1.talkMaxDuration)

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_7 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - 0) / var_96_7

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= 0 + var_96_7 and arg_93_1.time_ < 0 + var_96_7 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play1107402026 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 1107402026
		arg_97_1.duration_ = 4.3

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play1107402027(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = 0.6

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_1 = arg_97_1:GetWordFromCfg(1107402026)
				local var_100_2 = arg_97_1:FormatText(var_100_1.content)

				arg_97_1.text_.text = var_100_2

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_4 = 24 <= 0 and var_100_0 or var_100_0 * (utf8.len(var_100_2) / 24)

				if (24 <= 0 and var_100_0 or var_100_0 * (utf8.len(var_100_2) / 24)) > 0 and var_100_0 < var_100_4 then
					arg_97_1.talkMaxDuration = var_100_4

					if var_100_4 + 0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_4 + 0
					end
				end

				arg_97_1.text_.text = var_100_2
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107402", "1107402026", "story_v_side_new_1107402.awb") ~= 0 then
					local var_100_5 = manager.audio:GetVoiceLength("story_v_side_new_1107402", "1107402026", "story_v_side_new_1107402.awb") / 1000

					if var_100_5 + 0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_5 + 0
					end

					if var_100_1.prefab_name ~= "" and arg_97_1.actors_[var_100_1.prefab_name] ~= nil then
						local var_100_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_1.prefab_name].transform, "story_v_side_new_1107402", "1107402026", "story_v_side_new_1107402.awb")

						arg_97_1:RecordAudio("1107402026", var_100_6)
						arg_97_1:RecordAudio("1107402026", var_100_6)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_side_new_1107402", "1107402026", "story_v_side_new_1107402.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_side_new_1107402", "1107402026", "story_v_side_new_1107402.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_7 = math.max(var_100_0, arg_97_1.talkMaxDuration)

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_7 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - 0) / var_100_7

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= 0 + var_100_7 and arg_97_1.time_ < 0 + var_100_7 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play1107402027 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 1107402027
		arg_101_1.duration_ = 5

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play1107402028(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(arg_101_1.actors_["1074ui_story"]) and arg_101_1.var_.characterEffect1074ui_story == nil then
				arg_101_1.var_.characterEffect1074ui_story = arg_101_1.actors_["1074ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_0 = 0.1

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_0 and not isNil(arg_101_1.actors_["1074ui_story"]) then
				if arg_101_1.var_.characterEffect1074ui_story and not isNil(arg_101_1.actors_["1074ui_story"]) then
					arg_101_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_101_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_101_1.time_ - 0) / var_104_0)
				end
			end

			if arg_101_1.time_ >= 0 + var_104_0 and arg_101_1.time_ < 0 + var_104_0 + arg_104_0 and not isNil(arg_101_1.actors_["1074ui_story"]) and arg_101_1.var_.characterEffect1074ui_story then
				arg_101_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_101_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			local var_104_1 = 0
			local var_104_2 = 0.725

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

				local var_104_3 = arg_101_1:FormatText(arg_101_1:GetWordFromCfg(1107402027).content)

				arg_101_1.text_.text = var_104_3

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_5 = 29 <= 0 and var_104_2 or var_104_2 * (utf8.len(var_104_3) / 29)

				if (29 <= 0 and var_104_2 or var_104_2 * (utf8.len(var_104_3) / 29)) > 0 and var_104_2 < var_104_5 then
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
	Play1107402028 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 1107402028
		arg_105_1.duration_ = 5

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play1107402029(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = 0.325

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[1076].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_1 = arg_105_1:FormatText(arg_105_1:GetWordFromCfg(1107402028).content)

				arg_105_1.text_.text = var_108_1

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_3 = 13 <= 0 and var_108_0 or var_108_0 * (utf8.len(var_108_1) / 13)

				if (13 <= 0 and var_108_0 or var_108_0 * (utf8.len(var_108_1) / 13)) > 0 and var_108_0 < var_108_3 then
					arg_105_1.talkMaxDuration = var_108_3

					if var_108_3 + 0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_3 + 0
					end
				end

				arg_105_1.text_.text = var_108_1
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)
				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_4 = math.max(var_108_0, arg_105_1.talkMaxDuration)

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_4 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - 0) / var_108_4

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= 0 + var_108_4 and arg_105_1.time_ < 0 + var_108_4 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play1107402029 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 1107402029
		arg_109_1.duration_ = 4.73

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play1107402030(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(arg_109_1.actors_["1074ui_story"]) and arg_109_1.var_.characterEffect1074ui_story == nil then
				arg_109_1.var_.characterEffect1074ui_story = arg_109_1.actors_["1074ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_0 = 0.1

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_0 and not isNil(arg_109_1.actors_["1074ui_story"]) then
				if arg_109_1.var_.characterEffect1074ui_story and not isNil(arg_109_1.actors_["1074ui_story"]) then
					arg_109_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_109_1.time_ >= 0 + var_112_0 and arg_109_1.time_ < 0 + var_112_0 + arg_112_0 and not isNil(arg_109_1.actors_["1074ui_story"]) and arg_109_1.var_.characterEffect1074ui_story then
				arg_109_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_112_2 = 0
			local var_112_3 = 0.65

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_2 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_4 = arg_109_1:GetWordFromCfg(1107402029)
				local var_112_5 = arg_109_1:FormatText(var_112_4.content)

				arg_109_1.text_.text = var_112_5

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_7 = 26 <= 0 and var_112_3 or var_112_3 * (utf8.len(var_112_5) / 26)

				if (26 <= 0 and var_112_3 or var_112_3 * (utf8.len(var_112_5) / 26)) > 0 and var_112_3 < var_112_7 then
					arg_109_1.talkMaxDuration = var_112_7

					if var_112_7 + var_112_2 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_7 + var_112_2
					end
				end

				arg_109_1.text_.text = var_112_5
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107402", "1107402029", "story_v_side_new_1107402.awb") ~= 0 then
					local var_112_8 = manager.audio:GetVoiceLength("story_v_side_new_1107402", "1107402029", "story_v_side_new_1107402.awb") / 1000

					if var_112_8 + var_112_2 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_8 + var_112_2
					end

					if var_112_4.prefab_name ~= "" and arg_109_1.actors_[var_112_4.prefab_name] ~= nil then
						local var_112_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_4.prefab_name].transform, "story_v_side_new_1107402", "1107402029", "story_v_side_new_1107402.awb")

						arg_109_1:RecordAudio("1107402029", var_112_9)
						arg_109_1:RecordAudio("1107402029", var_112_9)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_side_new_1107402", "1107402029", "story_v_side_new_1107402.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_side_new_1107402", "1107402029", "story_v_side_new_1107402.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_10 = math.max(var_112_3, arg_109_1.talkMaxDuration)

			if var_112_2 <= arg_109_1.time_ and arg_109_1.time_ < var_112_2 + var_112_10 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_2) / var_112_10

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_2 + var_112_10 and arg_109_1.time_ < var_112_2 + var_112_10 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play1107402030 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 1107402030
		arg_113_1.duration_ = 4.8

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play1107402031(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = 0.675

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_1 = arg_113_1:GetWordFromCfg(1107402030)
				local var_116_2 = arg_113_1:FormatText(var_116_1.content)

				arg_113_1.text_.text = var_116_2

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_4 = 27 <= 0 and var_116_0 or var_116_0 * (utf8.len(var_116_2) / 27)

				if (27 <= 0 and var_116_0 or var_116_0 * (utf8.len(var_116_2) / 27)) > 0 and var_116_0 < var_116_4 then
					arg_113_1.talkMaxDuration = var_116_4

					if var_116_4 + 0 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_4 + 0
					end
				end

				arg_113_1.text_.text = var_116_2
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107402", "1107402030", "story_v_side_new_1107402.awb") ~= 0 then
					local var_116_5 = manager.audio:GetVoiceLength("story_v_side_new_1107402", "1107402030", "story_v_side_new_1107402.awb") / 1000

					if var_116_5 + 0 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_5 + 0
					end

					if var_116_1.prefab_name ~= "" and arg_113_1.actors_[var_116_1.prefab_name] ~= nil then
						local var_116_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_1.prefab_name].transform, "story_v_side_new_1107402", "1107402030", "story_v_side_new_1107402.awb")

						arg_113_1:RecordAudio("1107402030", var_116_6)
						arg_113_1:RecordAudio("1107402030", var_116_6)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_side_new_1107402", "1107402030", "story_v_side_new_1107402.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_side_new_1107402", "1107402030", "story_v_side_new_1107402.awb")
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
	Play1107402031 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 1107402031
		arg_117_1.duration_ = 4.93

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play1107402032(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = 0.625

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				arg_117_1.leftNameTxt_.text = arg_117_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_1 = arg_117_1:GetWordFromCfg(1107402031)
				local var_120_2 = arg_117_1:FormatText(var_120_1.content)

				arg_117_1.text_.text = var_120_2

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_4 = 25 <= 0 and var_120_0 or var_120_0 * (utf8.len(var_120_2) / 25)

				if (25 <= 0 and var_120_0 or var_120_0 * (utf8.len(var_120_2) / 25)) > 0 and var_120_0 < var_120_4 then
					arg_117_1.talkMaxDuration = var_120_4

					if var_120_4 + 0 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_4 + 0
					end
				end

				arg_117_1.text_.text = var_120_2
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107402", "1107402031", "story_v_side_new_1107402.awb") ~= 0 then
					local var_120_5 = manager.audio:GetVoiceLength("story_v_side_new_1107402", "1107402031", "story_v_side_new_1107402.awb") / 1000

					if var_120_5 + 0 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_5 + 0
					end

					if var_120_1.prefab_name ~= "" and arg_117_1.actors_[var_120_1.prefab_name] ~= nil then
						local var_120_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_1.prefab_name].transform, "story_v_side_new_1107402", "1107402031", "story_v_side_new_1107402.awb")

						arg_117_1:RecordAudio("1107402031", var_120_6)
						arg_117_1:RecordAudio("1107402031", var_120_6)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_side_new_1107402", "1107402031", "story_v_side_new_1107402.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_side_new_1107402", "1107402031", "story_v_side_new_1107402.awb")
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
	Play1107402032 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 1107402032
		arg_121_1.duration_ = 5

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play1107402033(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(arg_121_1.actors_["1074ui_story"]) and arg_121_1.var_.characterEffect1074ui_story == nil then
				arg_121_1.var_.characterEffect1074ui_story = arg_121_1.actors_["1074ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_0 = 0.1

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_0 and not isNil(arg_121_1.actors_["1074ui_story"]) then
				if arg_121_1.var_.characterEffect1074ui_story and not isNil(arg_121_1.actors_["1074ui_story"]) then
					arg_121_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_121_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_121_1.time_ - 0) / var_124_0)
				end
			end

			if arg_121_1.time_ >= 0 + var_124_0 and arg_121_1.time_ < 0 + var_124_0 + arg_124_0 and not isNil(arg_121_1.actors_["1074ui_story"]) and arg_121_1.var_.characterEffect1074ui_story then
				arg_121_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_121_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			local var_124_1 = 0
			local var_124_2 = 0.425

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_1 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				arg_121_1.leftNameTxt_.text = arg_121_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, true)
				arg_121_1.iconController_:SetSelectedState("hero")

				arg_121_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_121_1.callingController_:SetSelectedState("normal")

				arg_121_1.keyicon_.color = Color.New(1, 1, 1)
				arg_121_1.icon_.color = Color.New(1, 1, 1)

				local var_124_3 = arg_121_1:FormatText(arg_121_1:GetWordFromCfg(1107402032).content)

				arg_121_1.text_.text = var_124_3

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_5 = 17 <= 0 and var_124_2 or var_124_2 * (utf8.len(var_124_3) / 17)

				if (17 <= 0 and var_124_2 or var_124_2 * (utf8.len(var_124_3) / 17)) > 0 and var_124_2 < var_124_5 then
					arg_121_1.talkMaxDuration = var_124_5

					if var_124_5 + var_124_1 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_5 + var_124_1
					end
				end

				arg_121_1.text_.text = var_124_3
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)
				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_6 = math.max(var_124_2, arg_121_1.talkMaxDuration)

			if var_124_1 <= arg_121_1.time_ and arg_121_1.time_ < var_124_1 + var_124_6 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_1) / var_124_6

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_1 + var_124_6 and arg_121_1.time_ < var_124_1 + var_124_6 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play1107402033 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 1107402033
		arg_125_1.duration_ = 1.73

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play1107402034(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(arg_125_1.actors_["1074ui_story"]) and arg_125_1.var_.characterEffect1074ui_story == nil then
				arg_125_1.var_.characterEffect1074ui_story = arg_125_1.actors_["1074ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_0 = 0.1

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_0 and not isNil(arg_125_1.actors_["1074ui_story"]) then
				if arg_125_1.var_.characterEffect1074ui_story and not isNil(arg_125_1.actors_["1074ui_story"]) then
					arg_125_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_125_1.time_ >= 0 + var_128_0 and arg_125_1.time_ < 0 + var_128_0 + arg_128_0 and not isNil(arg_125_1.actors_["1074ui_story"]) and arg_125_1.var_.characterEffect1074ui_story then
				arg_125_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_128_2 = 0
			local var_128_3 = 0.05

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_2 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				arg_125_1.leftNameTxt_.text = arg_125_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_4 = arg_125_1:GetWordFromCfg(1107402033)
				local var_128_5 = arg_125_1:FormatText(var_128_4.content)

				arg_125_1.text_.text = var_128_5

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_7 = 2 <= 0 and var_128_3 or var_128_3 * (utf8.len(var_128_5) / 2)

				if (2 <= 0 and var_128_3 or var_128_3 * (utf8.len(var_128_5) / 2)) > 0 and var_128_3 < var_128_7 then
					arg_125_1.talkMaxDuration = var_128_7

					if var_128_7 + var_128_2 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_7 + var_128_2
					end
				end

				arg_125_1.text_.text = var_128_5
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107402", "1107402033", "story_v_side_new_1107402.awb") ~= 0 then
					local var_128_8 = manager.audio:GetVoiceLength("story_v_side_new_1107402", "1107402033", "story_v_side_new_1107402.awb") / 1000

					if var_128_8 + var_128_2 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_8 + var_128_2
					end

					if var_128_4.prefab_name ~= "" and arg_125_1.actors_[var_128_4.prefab_name] ~= nil then
						local var_128_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_4.prefab_name].transform, "story_v_side_new_1107402", "1107402033", "story_v_side_new_1107402.awb")

						arg_125_1:RecordAudio("1107402033", var_128_9)
						arg_125_1:RecordAudio("1107402033", var_128_9)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_side_new_1107402", "1107402033", "story_v_side_new_1107402.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_side_new_1107402", "1107402033", "story_v_side_new_1107402.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_10 = math.max(var_128_3, arg_125_1.talkMaxDuration)

			if var_128_2 <= arg_125_1.time_ and arg_125_1.time_ < var_128_2 + var_128_10 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_2) / var_128_10

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_2 + var_128_10 and arg_125_1.time_ < var_128_2 + var_128_10 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play1107402034 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 1107402034
		arg_129_1.duration_ = 5

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play1107402035(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 and not isNil(arg_129_1.actors_["1074ui_story"]) and arg_129_1.var_.characterEffect1074ui_story == nil then
				arg_129_1.var_.characterEffect1074ui_story = arg_129_1.actors_["1074ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_0 = 0.1

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_0 and not isNil(arg_129_1.actors_["1074ui_story"]) then
				if arg_129_1.var_.characterEffect1074ui_story and not isNil(arg_129_1.actors_["1074ui_story"]) then
					arg_129_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_129_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_129_1.time_ - 0) / var_132_0)
				end
			end

			if arg_129_1.time_ >= 0 + var_132_0 and arg_129_1.time_ < 0 + var_132_0 + arg_132_0 and not isNil(arg_129_1.actors_["1074ui_story"]) and arg_129_1.var_.characterEffect1074ui_story then
				arg_129_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_129_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			local var_132_1 = 0
			local var_132_2 = 0.625

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_1 + arg_132_0 then
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

				arg_129_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_129_1.callingController_:SetSelectedState("normal")

				arg_129_1.keyicon_.color = Color.New(1, 1, 1)
				arg_129_1.icon_.color = Color.New(1, 1, 1)

				local var_132_3 = arg_129_1:FormatText(arg_129_1:GetWordFromCfg(1107402034).content)

				arg_129_1.text_.text = var_132_3

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_5 = 25 <= 0 and var_132_2 or var_132_2 * (utf8.len(var_132_3) / 25)

				if (25 <= 0 and var_132_2 or var_132_2 * (utf8.len(var_132_3) / 25)) > 0 and var_132_2 < var_132_5 then
					arg_129_1.talkMaxDuration = var_132_5

					if var_132_5 + var_132_1 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_5 + var_132_1
					end
				end

				arg_129_1.text_.text = var_132_3
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)
				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_6 = math.max(var_132_2, arg_129_1.talkMaxDuration)

			if var_132_1 <= arg_129_1.time_ and arg_129_1.time_ < var_132_1 + var_132_6 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_1) / var_132_6

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_1 + var_132_6 and arg_129_1.time_ < var_132_1 + var_132_6 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play1107402035 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 1107402035
		arg_133_1.duration_ = 5.9

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play1107402036(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 and not isNil(arg_133_1.actors_["1074ui_story"]) and arg_133_1.var_.characterEffect1074ui_story == nil then
				arg_133_1.var_.characterEffect1074ui_story = arg_133_1.actors_["1074ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_0 = 0.1

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_0 and not isNil(arg_133_1.actors_["1074ui_story"]) then
				if arg_133_1.var_.characterEffect1074ui_story and not isNil(arg_133_1.actors_["1074ui_story"]) then
					arg_133_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_133_1.time_ >= 0 + var_136_0 and arg_133_1.time_ < 0 + var_136_0 + arg_136_0 and not isNil(arg_133_1.actors_["1074ui_story"]) and arg_133_1.var_.characterEffect1074ui_story then
				arg_133_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action2_2")
			end

			local var_136_2 = 0
			local var_136_3 = 0.5

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_2 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				arg_133_1.leftNameTxt_.text = arg_133_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_4 = arg_133_1:GetWordFromCfg(1107402035)
				local var_136_5 = arg_133_1:FormatText(var_136_4.content)

				arg_133_1.text_.text = var_136_5

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_7 = 20 <= 0 and var_136_3 or var_136_3 * (utf8.len(var_136_5) / 20)

				if (20 <= 0 and var_136_3 or var_136_3 * (utf8.len(var_136_5) / 20)) > 0 and var_136_3 < var_136_7 then
					arg_133_1.talkMaxDuration = var_136_7

					if var_136_7 + var_136_2 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_7 + var_136_2
					end
				end

				arg_133_1.text_.text = var_136_5
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107402", "1107402035", "story_v_side_new_1107402.awb") ~= 0 then
					local var_136_8 = manager.audio:GetVoiceLength("story_v_side_new_1107402", "1107402035", "story_v_side_new_1107402.awb") / 1000

					if var_136_8 + var_136_2 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_8 + var_136_2
					end

					if var_136_4.prefab_name ~= "" and arg_133_1.actors_[var_136_4.prefab_name] ~= nil then
						local var_136_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_4.prefab_name].transform, "story_v_side_new_1107402", "1107402035", "story_v_side_new_1107402.awb")

						arg_133_1:RecordAudio("1107402035", var_136_9)
						arg_133_1:RecordAudio("1107402035", var_136_9)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_side_new_1107402", "1107402035", "story_v_side_new_1107402.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_side_new_1107402", "1107402035", "story_v_side_new_1107402.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_10 = math.max(var_136_3, arg_133_1.talkMaxDuration)

			if var_136_2 <= arg_133_1.time_ and arg_133_1.time_ < var_136_2 + var_136_10 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_2) / var_136_10

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_2 + var_136_10 and arg_133_1.time_ < var_136_2 + var_136_10 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play1107402036 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 1107402036
		arg_137_1.duration_ = 5

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play1107402037(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 and not isNil(arg_137_1.actors_["1074ui_story"]) and arg_137_1.var_.characterEffect1074ui_story == nil then
				arg_137_1.var_.characterEffect1074ui_story = arg_137_1.actors_["1074ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_0 = 0.1

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_0 and not isNil(arg_137_1.actors_["1074ui_story"]) then
				if arg_137_1.var_.characterEffect1074ui_story and not isNil(arg_137_1.actors_["1074ui_story"]) then
					arg_137_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_137_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_137_1.time_ - 0) / var_140_0)
				end
			end

			if arg_137_1.time_ >= 0 + var_140_0 and arg_137_1.time_ < 0 + var_140_0 + arg_140_0 and not isNil(arg_137_1.actors_["1074ui_story"]) and arg_137_1.var_.characterEffect1074ui_story then
				arg_137_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_137_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			local var_140_1 = 0
			local var_140_2 = 0.375

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_1 + arg_140_0 then
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

				local var_140_3 = arg_137_1:FormatText(arg_137_1:GetWordFromCfg(1107402036).content)

				arg_137_1.text_.text = var_140_3

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_5 = 15 <= 0 and var_140_2 or var_140_2 * (utf8.len(var_140_3) / 15)

				if (15 <= 0 and var_140_2 or var_140_2 * (utf8.len(var_140_3) / 15)) > 0 and var_140_2 < var_140_5 then
					arg_137_1.talkMaxDuration = var_140_5

					if var_140_5 + var_140_1 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_5 + var_140_1
					end
				end

				arg_137_1.text_.text = var_140_3
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)
				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_6 = math.max(var_140_2, arg_137_1.talkMaxDuration)

			if var_140_1 <= arg_137_1.time_ and arg_137_1.time_ < var_140_1 + var_140_6 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_1) / var_140_6

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_1 + var_140_6 and arg_137_1.time_ < var_140_1 + var_140_6 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play1107402037 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 1107402037
		arg_141_1.duration_ = 5

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play1107402038(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = 0.85

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				arg_141_1.leftNameTxt_.text = arg_141_1:FormatText(StoryNameCfg[1076].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_1 = arg_141_1:FormatText(arg_141_1:GetWordFromCfg(1107402037).content)

				arg_141_1.text_.text = var_144_1

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_3 = 34 <= 0 and var_144_0 or var_144_0 * (utf8.len(var_144_1) / 34)

				if (34 <= 0 and var_144_0 or var_144_0 * (utf8.len(var_144_1) / 34)) > 0 and var_144_0 < var_144_3 then
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
	Play1107402038 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 1107402038
		arg_145_1.duration_ = 5

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play1107402039(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = 0.5

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, false)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_1 = arg_145_1:FormatText(arg_145_1:GetWordFromCfg(1107402038).content)

				arg_145_1.text_.text = var_148_1

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_3 = 20 <= 0 and var_148_0 or var_148_0 * (utf8.len(var_148_1) / 20)

				if (20 <= 0 and var_148_0 or var_148_0 * (utf8.len(var_148_1) / 20)) > 0 and var_148_0 < var_148_3 then
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
	Play1107402039 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 1107402039
		arg_149_1.duration_ = 3.87

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play1107402040(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(arg_149_1.actors_["1074ui_story"]) and arg_149_1.var_.characterEffect1074ui_story == nil then
				arg_149_1.var_.characterEffect1074ui_story = arg_149_1.actors_["1074ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_0 = 0.1

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_0 and not isNil(arg_149_1.actors_["1074ui_story"]) then
				if arg_149_1.var_.characterEffect1074ui_story and not isNil(arg_149_1.actors_["1074ui_story"]) then
					arg_149_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_149_1.time_ >= 0 + var_152_0 and arg_149_1.time_ < 0 + var_152_0 + arg_152_0 and not isNil(arg_149_1.actors_["1074ui_story"]) and arg_149_1.var_.characterEffect1074ui_story then
				arg_149_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_152_2 = 0
			local var_152_3 = 0.15

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_2 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				arg_149_1.leftNameTxt_.text = arg_149_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_4 = arg_149_1:GetWordFromCfg(1107402039)
				local var_152_5 = arg_149_1:FormatText(var_152_4.content)

				arg_149_1.text_.text = var_152_5

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_7 = 6 <= 0 and var_152_3 or var_152_3 * (utf8.len(var_152_5) / 6)

				if (6 <= 0 and var_152_3 or var_152_3 * (utf8.len(var_152_5) / 6)) > 0 and var_152_3 < var_152_7 then
					arg_149_1.talkMaxDuration = var_152_7

					if var_152_7 + var_152_2 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_7 + var_152_2
					end
				end

				arg_149_1.text_.text = var_152_5
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107402", "1107402039", "story_v_side_new_1107402.awb") ~= 0 then
					local var_152_8 = manager.audio:GetVoiceLength("story_v_side_new_1107402", "1107402039", "story_v_side_new_1107402.awb") / 1000

					if var_152_8 + var_152_2 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_8 + var_152_2
					end

					if var_152_4.prefab_name ~= "" and arg_149_1.actors_[var_152_4.prefab_name] ~= nil then
						local var_152_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_4.prefab_name].transform, "story_v_side_new_1107402", "1107402039", "story_v_side_new_1107402.awb")

						arg_149_1:RecordAudio("1107402039", var_152_9)
						arg_149_1:RecordAudio("1107402039", var_152_9)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_side_new_1107402", "1107402039", "story_v_side_new_1107402.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_side_new_1107402", "1107402039", "story_v_side_new_1107402.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_10 = math.max(var_152_3, arg_149_1.talkMaxDuration)

			if var_152_2 <= arg_149_1.time_ and arg_149_1.time_ < var_152_2 + var_152_10 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_2) / var_152_10

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_2 + var_152_10 and arg_149_1.time_ < var_152_2 + var_152_10 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play1107402040 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 1107402040
		arg_153_1.duration_ = 5

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play1107402041(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 and not isNil(arg_153_1.actors_["1074ui_story"]) and arg_153_1.var_.characterEffect1074ui_story == nil then
				arg_153_1.var_.characterEffect1074ui_story = arg_153_1.actors_["1074ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_0 = 0.1

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_0 and not isNil(arg_153_1.actors_["1074ui_story"]) then
				if arg_153_1.var_.characterEffect1074ui_story and not isNil(arg_153_1.actors_["1074ui_story"]) then
					arg_153_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_153_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_153_1.time_ - 0) / var_156_0)
				end
			end

			if arg_153_1.time_ >= 0 + var_156_0 and arg_153_1.time_ < 0 + var_156_0 + arg_156_0 and not isNil(arg_153_1.actors_["1074ui_story"]) and arg_153_1.var_.characterEffect1074ui_story then
				arg_153_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_153_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			local var_156_1 = 0
			local var_156_2 = 0.1

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_1 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				arg_153_1.leftNameTxt_.text = arg_153_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, true)
				arg_153_1.iconController_:SetSelectedState("hero")

				arg_153_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_153_1.callingController_:SetSelectedState("normal")

				arg_153_1.keyicon_.color = Color.New(1, 1, 1)
				arg_153_1.icon_.color = Color.New(1, 1, 1)

				local var_156_3 = arg_153_1:FormatText(arg_153_1:GetWordFromCfg(1107402040).content)

				arg_153_1.text_.text = var_156_3

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_5 = 4 <= 0 and var_156_2 or var_156_2 * (utf8.len(var_156_3) / 4)

				if (4 <= 0 and var_156_2 or var_156_2 * (utf8.len(var_156_3) / 4)) > 0 and var_156_2 < var_156_5 then
					arg_153_1.talkMaxDuration = var_156_5

					if var_156_5 + var_156_1 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_5 + var_156_1
					end
				end

				arg_153_1.text_.text = var_156_3
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)
				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_6 = math.max(var_156_2, arg_153_1.talkMaxDuration)

			if var_156_1 <= arg_153_1.time_ and arg_153_1.time_ < var_156_1 + var_156_6 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_1) / var_156_6

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_1 + var_156_6 and arg_153_1.time_ < var_156_1 + var_156_6 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play1107402041 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 1107402041
		arg_157_1.duration_ = 5

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play1107402042(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = 0.675

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, false)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_1 = arg_157_1:FormatText(arg_157_1:GetWordFromCfg(1107402041).content)

				arg_157_1.text_.text = var_160_1

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_3 = 27 <= 0 and var_160_0 or var_160_0 * (utf8.len(var_160_1) / 27)

				if (27 <= 0 and var_160_0 or var_160_0 * (utf8.len(var_160_1) / 27)) > 0 and var_160_0 < var_160_3 then
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
	Play1107402042 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 1107402042
		arg_161_1.duration_ = 3.67

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play1107402043(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 and not isNil(arg_161_1.actors_["1074ui_story"]) and arg_161_1.var_.characterEffect1074ui_story == nil then
				arg_161_1.var_.characterEffect1074ui_story = arg_161_1.actors_["1074ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_0 = 0.1

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_0 and not isNil(arg_161_1.actors_["1074ui_story"]) then
				if arg_161_1.var_.characterEffect1074ui_story and not isNil(arg_161_1.actors_["1074ui_story"]) then
					arg_161_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_161_1.time_ >= 0 + var_164_0 and arg_161_1.time_ < 0 + var_164_0 + arg_164_0 and not isNil(arg_161_1.actors_["1074ui_story"]) and arg_161_1.var_.characterEffect1074ui_story then
				arg_161_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action6_1")
			end

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_164_2 = 0
			local var_164_3 = 0.15

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_2 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				arg_161_1.leftNameTxt_.text = arg_161_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_4 = arg_161_1:GetWordFromCfg(1107402042)
				local var_164_5 = arg_161_1:FormatText(var_164_4.content)

				arg_161_1.text_.text = var_164_5

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_7 = 6 <= 0 and var_164_3 or var_164_3 * (utf8.len(var_164_5) / 6)

				if (6 <= 0 and var_164_3 or var_164_3 * (utf8.len(var_164_5) / 6)) > 0 and var_164_3 < var_164_7 then
					arg_161_1.talkMaxDuration = var_164_7

					if var_164_7 + var_164_2 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_7 + var_164_2
					end
				end

				arg_161_1.text_.text = var_164_5
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107402", "1107402042", "story_v_side_new_1107402.awb") ~= 0 then
					local var_164_8 = manager.audio:GetVoiceLength("story_v_side_new_1107402", "1107402042", "story_v_side_new_1107402.awb") / 1000

					if var_164_8 + var_164_2 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_8 + var_164_2
					end

					if var_164_4.prefab_name ~= "" and arg_161_1.actors_[var_164_4.prefab_name] ~= nil then
						local var_164_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_4.prefab_name].transform, "story_v_side_new_1107402", "1107402042", "story_v_side_new_1107402.awb")

						arg_161_1:RecordAudio("1107402042", var_164_9)
						arg_161_1:RecordAudio("1107402042", var_164_9)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_side_new_1107402", "1107402042", "story_v_side_new_1107402.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_side_new_1107402", "1107402042", "story_v_side_new_1107402.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_10 = math.max(var_164_3, arg_161_1.talkMaxDuration)

			if var_164_2 <= arg_161_1.time_ and arg_161_1.time_ < var_164_2 + var_164_10 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_2) / var_164_10

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_2 + var_164_10 and arg_161_1.time_ < var_164_2 + var_164_10 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play1107402043 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 1107402043
		arg_165_1.duration_ = 5

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play1107402044(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 and not isNil(arg_165_1.actors_["1074ui_story"]) and arg_165_1.var_.characterEffect1074ui_story == nil then
				arg_165_1.var_.characterEffect1074ui_story = arg_165_1.actors_["1074ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_0 = 0.1

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_0 and not isNil(arg_165_1.actors_["1074ui_story"]) then
				if arg_165_1.var_.characterEffect1074ui_story and not isNil(arg_165_1.actors_["1074ui_story"]) then
					arg_165_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_165_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_165_1.time_ - 0) / var_168_0)
				end
			end

			if arg_165_1.time_ >= 0 + var_168_0 and arg_165_1.time_ < 0 + var_168_0 + arg_168_0 and not isNil(arg_165_1.actors_["1074ui_story"]) and arg_165_1.var_.characterEffect1074ui_story then
				arg_165_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_165_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			local var_168_1 = 0
			local var_168_2 = 0.825

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_1 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, false)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_3 = arg_165_1:FormatText(arg_165_1:GetWordFromCfg(1107402043).content)

				arg_165_1.text_.text = var_168_3

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_5 = 33 <= 0 and var_168_2 or var_168_2 * (utf8.len(var_168_3) / 33)

				if (33 <= 0 and var_168_2 or var_168_2 * (utf8.len(var_168_3) / 33)) > 0 and var_168_2 < var_168_5 then
					arg_165_1.talkMaxDuration = var_168_5

					if var_168_5 + var_168_1 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_5 + var_168_1
					end
				end

				arg_165_1.text_.text = var_168_3
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)
				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_6 = math.max(var_168_2, arg_165_1.talkMaxDuration)

			if var_168_1 <= arg_165_1.time_ and arg_165_1.time_ < var_168_1 + var_168_6 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_1) / var_168_6

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_1 + var_168_6 and arg_165_1.time_ < var_168_1 + var_168_6 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play1107402044 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 1107402044
		arg_169_1.duration_ = 3.13

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play1107402045(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 and not isNil(arg_169_1.actors_["1074ui_story"]) and arg_169_1.var_.characterEffect1074ui_story == nil then
				arg_169_1.var_.characterEffect1074ui_story = arg_169_1.actors_["1074ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_0 = 0.1

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_0 and not isNil(arg_169_1.actors_["1074ui_story"]) then
				if arg_169_1.var_.characterEffect1074ui_story and not isNil(arg_169_1.actors_["1074ui_story"]) then
					arg_169_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_169_1.time_ >= 0 + var_172_0 and arg_169_1.time_ < 0 + var_172_0 + arg_172_0 and not isNil(arg_169_1.actors_["1074ui_story"]) and arg_169_1.var_.characterEffect1074ui_story then
				arg_169_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action6_2")
			end

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			if arg_169_1.frameCnt_ <= 1 then
				arg_169_1.dialog_:SetActive(false)
			end

			local var_172_2 = 0.9
			local var_172_3 = 0.075

			if 0.9 < arg_169_1.time_ and arg_169_1.time_ <= var_172_2 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0

				arg_169_1.dialog_:SetActive(true)

				arg_169_1.dialogCg_.alpha = 0

				local var_172_4 = LeanTween.value(arg_169_1.dialog_, 0, 1, 0.3)

				var_172_4:setOnUpdate(LuaHelper.FloatAction(function(arg_173_0)
					arg_169_1.dialogCg_.alpha = arg_173_0
				end))
				var_172_4:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_169_1.dialog_)
					var_172_4:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_169_1.duration_ = arg_169_1.duration_ + 0.3

				SetActive(arg_169_1.leftNameGo_, true)

				arg_169_1.leftNameTxt_.text = arg_169_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_5 = arg_169_1:GetWordFromCfg(1107402044)
				local var_172_6 = arg_169_1:FormatText(var_172_5.content)

				arg_169_1.text_.text = var_172_6

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_8 = 3 <= 0 and var_172_3 or var_172_3 * (utf8.len(var_172_6) / 3)

				if (3 <= 0 and var_172_3 or var_172_3 * (utf8.len(var_172_6) / 3)) > 0 and var_172_3 < var_172_8 then
					arg_169_1.talkMaxDuration = var_172_8
					var_172_2 = var_172_2 + 0.3

					if var_172_8 + var_172_2 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_8 + var_172_2
					end
				end

				arg_169_1.text_.text = var_172_6
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107402", "1107402044", "story_v_side_new_1107402.awb") ~= 0 then
					local var_172_9 = manager.audio:GetVoiceLength("story_v_side_new_1107402", "1107402044", "story_v_side_new_1107402.awb") / 1000

					if var_172_9 + var_172_2 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_9 + var_172_2
					end

					if var_172_5.prefab_name ~= "" and arg_169_1.actors_[var_172_5.prefab_name] ~= nil then
						local var_172_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_5.prefab_name].transform, "story_v_side_new_1107402", "1107402044", "story_v_side_new_1107402.awb")

						arg_169_1:RecordAudio("1107402044", var_172_10)
						arg_169_1:RecordAudio("1107402044", var_172_10)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_side_new_1107402", "1107402044", "story_v_side_new_1107402.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_side_new_1107402", "1107402044", "story_v_side_new_1107402.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_11 = var_172_2 + 0.3
			local var_172_12 = math.max(var_172_3, arg_169_1.talkMaxDuration)

			if var_172_2 + 0.3 <= arg_169_1.time_ and arg_169_1.time_ < var_172_11 + var_172_12 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_11) / var_172_12

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_11 + var_172_12 and arg_169_1.time_ < var_172_11 + var_172_12 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play1107402045 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 1107402045
		arg_175_1.duration_ = 7.33

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play1107402046(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			if 1 < arg_175_1.time_ and arg_175_1.time_ <= 1 + arg_178_0 then
				arg_175_1.allBtn_.enabled = false
			end

			if arg_175_1.time_ >= 1 + 0.666666666666666 and arg_175_1.time_ < 1 + 0.666666666666666 + arg_178_0 then
				arg_175_1.allBtn_.enabled = true
			end

			local var_178_0 = "STblack"

			if arg_175_1.bgs_.STblack == nil then
				local var_178_1 = Object.Instantiate(arg_175_1.paintGo_)

				var_178_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_178_0)
				var_178_1.name = var_178_0
				var_178_1.transform.parent = arg_175_1.stage_.transform
				var_178_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_175_1.bgs_[var_178_0] = var_178_1
			end

			if 1 < arg_175_1.time_ and arg_175_1.time_ <= 1 + arg_178_0 then
				local var_178_2 = arg_175_1.bgs_.STblack

				arg_175_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_178_2.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_178_3 = var_178_2:GetComponent("SpriteRenderer")

				if var_178_3 and var_178_3.sprite then
					local var_178_4 = 2 * (var_178_2.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_178_2.transform.localScale = Vector3.New(var_178_4 / var_178_3.sprite.bounds.size.y < var_178_4 * manager.ui.mainCameraCom_.aspect / var_178_3.sprite.bounds.size.x and var_178_4 * manager.ui.mainCameraCom_.aspect / var_178_3.sprite.bounds.size.x or var_178_4 / var_178_3.sprite.bounds.size.y, var_178_4 / var_178_3.sprite.bounds.size.y < var_178_4 * manager.ui.mainCameraCom_.aspect / var_178_3.sprite.bounds.size.x and var_178_4 * manager.ui.mainCameraCom_.aspect / var_178_3.sprite.bounds.size.x or var_178_4 / var_178_3.sprite.bounds.size.y, 0)
				end

				for iter_178_0, iter_178_1 in pairs(arg_175_1.bgs_) do
					if iter_178_0 ~= "STblack" then
						iter_178_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_178_5 = 0

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_5 + arg_178_0 then
				arg_175_1.mask_.enabled = true
				arg_175_1.mask_.raycastTarget = true

				arg_175_1:SetGaussion(false)
			end

			local var_178_6 = 1

			if var_178_5 <= arg_175_1.time_ and arg_175_1.time_ < var_178_5 + var_178_6 then
				local var_178_7 = Color.New(0, 0, 0)

				var_178_7.a = Mathf.Lerp(0, 1, (arg_175_1.time_ - var_178_5) / var_178_6)
				arg_175_1.mask_.color = var_178_7
			end

			if arg_175_1.time_ >= var_178_5 + var_178_6 and arg_175_1.time_ < var_178_5 + var_178_6 + arg_178_0 then
				local var_178_8 = Color.New(0, 0, 0)

				var_178_8.a = 1
				arg_175_1.mask_.color = var_178_8
			end

			local var_178_9 = 1

			if 1 < arg_175_1.time_ and arg_175_1.time_ <= var_178_9 + arg_178_0 then
				arg_175_1.mask_.enabled = true
				arg_175_1.mask_.raycastTarget = true

				arg_175_1:SetGaussion(false)
			end

			local var_178_10 = 1.33333333333333

			if var_178_9 <= arg_175_1.time_ and arg_175_1.time_ < var_178_9 + var_178_10 then
				local var_178_11 = Color.New(0, 0, 0)

				var_178_11.a = Mathf.Lerp(1, 0, (arg_175_1.time_ - var_178_9) / var_178_10)
				arg_175_1.mask_.color = var_178_11
			end

			if arg_175_1.time_ >= var_178_9 + var_178_10 and arg_175_1.time_ < var_178_9 + var_178_10 + arg_178_0 then
				local var_178_12 = Color.New(0, 0, 0)

				arg_175_1.mask_.enabled = false
				var_178_12.a = 0
				arg_175_1.mask_.color = var_178_12
			end

			local var_178_13 = arg_175_1.actors_["1074ui_story"].transform

			if 0.966 < arg_175_1.time_ and arg_175_1.time_ <= 0.966 + arg_178_0 then
				arg_175_1.var_.moveOldPos1074ui_story = var_178_13.localPosition

				arg_175_1:ShowWeapon(arg_175_1.var_["1074ui_story" .. "Animator"].transform, false)
			end

			local var_178_14 = 0.001

			if 0.966 <= arg_175_1.time_ and arg_175_1.time_ < 0.966 + var_178_14 then
				var_178_13.localPosition = Vector3.Lerp(arg_175_1.var_.moveOldPos1074ui_story, Vector3.New(0, 100, 0), (arg_175_1.time_ - 0.966) / var_178_14)
				var_178_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_178_13.position).x, (manager.ui.mainCamera.transform.position - var_178_13.position).y, (manager.ui.mainCamera.transform.position - var_178_13.position).z)
				var_178_13.localEulerAngles.z = 0
				var_178_13.localEulerAngles.x = 0
				var_178_13.localEulerAngles = var_178_13.localEulerAngles
			end

			if arg_175_1.time_ >= 0.966 + var_178_14 and arg_175_1.time_ < 0.966 + var_178_14 + arg_178_0 then
				var_178_13.localPosition = Vector3.New(0, 100, 0)
				var_178_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_178_13.position).x, (manager.ui.mainCamera.transform.position - var_178_13.position).y, (manager.ui.mainCamera.transform.position - var_178_13.position).z)
				var_178_13.localEulerAngles.z = 0
				var_178_13.localEulerAngles.x = 0
				var_178_13.localEulerAngles = var_178_13.localEulerAngles
			end

			if arg_175_1.frameCnt_ <= 1 then
				arg_175_1.dialog_:SetActive(false)
			end

			local var_178_15 = 2.33333333333333
			local var_178_16 = 0.725

			if 2.33333333333333 < arg_175_1.time_ and arg_175_1.time_ <= var_178_15 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0

				arg_175_1.dialog_:SetActive(true)

				arg_175_1.dialogCg_.alpha = 0

				local var_178_17 = LeanTween.value(arg_175_1.dialog_, 0, 1, 0.3)

				var_178_17:setOnUpdate(LuaHelper.FloatAction(function(arg_179_0)
					arg_175_1.dialogCg_.alpha = arg_179_0
				end))
				var_178_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_175_1.dialog_)
					var_178_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_175_1.duration_ = arg_175_1.duration_ + 0.3

				SetActive(arg_175_1.leftNameGo_, false)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_18 = arg_175_1:FormatText(arg_175_1:GetWordFromCfg(1107402045).content)

				arg_175_1.text_.text = var_178_18

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_20 = 29 <= 0 and var_178_16 or var_178_16 * (utf8.len(var_178_18) / 29)

				if (29 <= 0 and var_178_16 or var_178_16 * (utf8.len(var_178_18) / 29)) > 0 and var_178_16 < var_178_20 then
					arg_175_1.talkMaxDuration = var_178_20
					var_178_15 = var_178_15 + 0.3

					if var_178_20 + var_178_15 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_20 + var_178_15
					end
				end

				arg_175_1.text_.text = var_178_18
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)
				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_21 = var_178_15 + 0.3
			local var_178_22 = math.max(var_178_16, arg_175_1.talkMaxDuration)

			if var_178_15 + 0.3 <= arg_175_1.time_ and arg_175_1.time_ < var_178_21 + var_178_22 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_21) / var_178_22

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_21 + var_178_22 and arg_175_1.time_ < var_178_21 + var_178_22 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_175_1:InitPlayNodeList()
	end,
	Play1107402046 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 1107402046
		arg_181_1.duration_ = 6.47

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play1107402047(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1.allBtn_.enabled = false
			end

			if arg_181_1.time_ >= 0 + 1 and arg_181_1.time_ < 0 + 1 + arg_184_0 then
				arg_181_1.allBtn_.enabled = true
			end

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				local var_184_0 = arg_181_1.bgs_.ST31

				arg_181_1.bgs_.ST31.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_184_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_184_1 = var_184_0:GetComponent("SpriteRenderer")

				if var_184_1 and var_184_1.sprite then
					local var_184_2 = 2 * (var_184_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_184_0.transform.localScale = Vector3.New(var_184_2 / var_184_1.sprite.bounds.size.y < var_184_2 * manager.ui.mainCameraCom_.aspect / var_184_1.sprite.bounds.size.x and var_184_2 * manager.ui.mainCameraCom_.aspect / var_184_1.sprite.bounds.size.x or var_184_2 / var_184_1.sprite.bounds.size.y, var_184_2 / var_184_1.sprite.bounds.size.y < var_184_2 * manager.ui.mainCameraCom_.aspect / var_184_1.sprite.bounds.size.x and var_184_2 * manager.ui.mainCameraCom_.aspect / var_184_1.sprite.bounds.size.x or var_184_2 / var_184_1.sprite.bounds.size.y, 0)
				end

				for iter_184_0, iter_184_1 in pairs(arg_181_1.bgs_) do
					if iter_184_0 ~= "ST31" then
						iter_184_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_184_3 = 0

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_3 + arg_184_0 then
				arg_181_1.mask_.enabled = true
				arg_181_1.mask_.raycastTarget = true

				arg_181_1:SetGaussion(false)
			end

			local var_184_4 = 1

			if var_184_3 <= arg_181_1.time_ and arg_181_1.time_ < var_184_3 + var_184_4 then
				local var_184_5 = Color.New(0, 0, 0)

				var_184_5.a = Mathf.Lerp(1, 0, (arg_181_1.time_ - var_184_3) / var_184_4)
				arg_181_1.mask_.color = var_184_5
			end

			if arg_181_1.time_ >= var_184_3 + var_184_4 and arg_181_1.time_ < var_184_3 + var_184_4 + arg_184_0 then
				local var_184_6 = Color.New(0, 0, 0)

				arg_181_1.mask_.enabled = false
				var_184_6.a = 0
				arg_181_1.mask_.color = var_184_6
			end

			local var_184_7 = arg_181_1.actors_["1074ui_story"]

			if 1 < arg_181_1.time_ and arg_181_1.time_ <= 1 + arg_184_0 and not isNil(var_184_7) and arg_181_1.var_.characterEffect1074ui_story == nil then
				arg_181_1.var_.characterEffect1074ui_story = var_184_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_8 = 0.1

			if 1 <= arg_181_1.time_ and arg_181_1.time_ < 1 + var_184_8 and not isNil(var_184_7) then
				if arg_181_1.var_.characterEffect1074ui_story and not isNil(var_184_7) then
					arg_181_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_181_1.time_ >= 1 + var_184_8 and arg_181_1.time_ < 1 + var_184_8 + arg_184_0 and not isNil(var_184_7) and arg_181_1.var_.characterEffect1074ui_story then
				arg_181_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_184_10 = arg_181_1.actors_["1074ui_story"].transform

			if 1 < arg_181_1.time_ and arg_181_1.time_ <= 1 + arg_184_0 then
				arg_181_1.var_.moveOldPos1074ui_story = var_184_10.localPosition

				arg_181_1:ShowWeapon(arg_181_1.var_["1074ui_story" .. "Animator"].transform, false)
			end

			local var_184_11 = 0.001

			if 1 <= arg_181_1.time_ and arg_181_1.time_ < 1 + var_184_11 then
				var_184_10.localPosition = Vector3.Lerp(arg_181_1.var_.moveOldPos1074ui_story, Vector3.New(0, -1.055, -6.12), (arg_181_1.time_ - 1) / var_184_11)
				var_184_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_184_10.position).x, (manager.ui.mainCamera.transform.position - var_184_10.position).y, (manager.ui.mainCamera.transform.position - var_184_10.position).z)
				var_184_10.localEulerAngles.z = 0
				var_184_10.localEulerAngles.x = 0
				var_184_10.localEulerAngles = var_184_10.localEulerAngles
			end

			if arg_181_1.time_ >= 1 + var_184_11 and arg_181_1.time_ < 1 + var_184_11 + arg_184_0 then
				var_184_10.localPosition = Vector3.New(0, -1.055, -6.12)
				var_184_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_184_10.position).x, (manager.ui.mainCamera.transform.position - var_184_10.position).y, (manager.ui.mainCamera.transform.position - var_184_10.position).z)
				var_184_10.localEulerAngles.z = 0
				var_184_10.localEulerAngles.x = 0
				var_184_10.localEulerAngles = var_184_10.localEulerAngles
			end

			if 1 < arg_181_1.time_ and arg_181_1.time_ <= 1 + arg_184_0 then
				arg_181_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action1_1")
			end

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_184_14 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_181_1.bgmTxt_.text ~= var_184_14 and arg_181_1.bgmTxt_.text ~= "" then
						if arg_181_1.bgmTxt2_.text ~= "" then
							arg_181_1.bgmTxt_.text = arg_181_1.bgmTxt2_.text
						end

						arg_181_1.bgmTxt2_.text = var_184_14

						arg_181_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_181_1.bgmTxt_.text = var_184_14
						arg_181_1.bgmTxt2_.text = var_184_14
					end

					if arg_181_1.bgmTimer then
						arg_181_1.bgmTimer:Stop()

						arg_181_1.bgmTimer = nil
					end

					if arg_181_1.settingData.show_music_name == 1 then
						arg_181_1.musicController:SetSelectedState("show")
						arg_181_1.musicAnimator_:Play("open", 0, 0)

						if arg_181_1.settingData.music_time ~= 0 then
							arg_181_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_181_1.settingData.music_time), function()
								if arg_181_1 == nil or isNil(arg_181_1.bgmTxt_) then
									return
								end

								arg_181_1.musicController:SetSelectedState("hide")
								arg_181_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.4 < arg_181_1.time_ and arg_181_1.time_ <= 0.4 + arg_184_0 then
				arg_181_1:AudioAction("play", "music", "bgm_side_daily02", "bgm_side_daily02", "bgm_side_daily02.awb")

				local var_184_17 = manager.audio:GetAudioName("bgm_side_daily02", "bgm_side_daily02")

				if "" ~= "" then
					if arg_181_1.bgmTxt_.text ~= var_184_17 and arg_181_1.bgmTxt_.text ~= "" then
						if arg_181_1.bgmTxt2_.text ~= "" then
							arg_181_1.bgmTxt_.text = arg_181_1.bgmTxt2_.text
						end

						arg_181_1.bgmTxt2_.text = var_184_17

						arg_181_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_181_1.bgmTxt_.text = var_184_17
						arg_181_1.bgmTxt2_.text = var_184_17
					end

					if arg_181_1.bgmTimer then
						arg_181_1.bgmTimer:Stop()

						arg_181_1.bgmTimer = nil
					end

					if arg_181_1.settingData.show_music_name == 1 then
						arg_181_1.musicController:SetSelectedState("show")
						arg_181_1.musicAnimator_:Play("open", 0, 0)

						if arg_181_1.settingData.music_time ~= 0 then
							arg_181_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_181_1.settingData.music_time), function()
								if arg_181_1 == nil or isNil(arg_181_1.bgmTxt_) then
									return
								end

								arg_181_1.musicController:SetSelectedState("hide")
								arg_181_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_181_1.frameCnt_ <= 1 then
				arg_181_1.dialog_:SetActive(false)
			end

			local var_184_18 = 1
			local var_184_19 = 0.5

			if 1 < arg_181_1.time_ and arg_181_1.time_ <= var_184_18 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0

				arg_181_1.dialog_:SetActive(true)

				arg_181_1.dialogCg_.alpha = 0

				local var_184_20 = LeanTween.value(arg_181_1.dialog_, 0, 1, 0.3)

				var_184_20:setOnUpdate(LuaHelper.FloatAction(function(arg_187_0)
					arg_181_1.dialogCg_.alpha = arg_187_0
				end))
				var_184_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_181_1.dialog_)
					var_184_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_181_1.duration_ = arg_181_1.duration_ + 0.3

				SetActive(arg_181_1.leftNameGo_, true)

				arg_181_1.leftNameTxt_.text = arg_181_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_21 = arg_181_1:GetWordFromCfg(1107402046)
				local var_184_22 = arg_181_1:FormatText(var_184_21.content)

				arg_181_1.text_.text = var_184_22

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_24 = 20 <= 0 and var_184_19 or var_184_19 * (utf8.len(var_184_22) / 20)

				if (20 <= 0 and var_184_19 or var_184_19 * (utf8.len(var_184_22) / 20)) > 0 and var_184_19 < var_184_24 then
					arg_181_1.talkMaxDuration = var_184_24
					var_184_18 = var_184_18 + 0.3

					if var_184_24 + var_184_18 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_24 + var_184_18
					end
				end

				arg_181_1.text_.text = var_184_22
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107402", "1107402046", "story_v_side_new_1107402.awb") ~= 0 then
					local var_184_25 = manager.audio:GetVoiceLength("story_v_side_new_1107402", "1107402046", "story_v_side_new_1107402.awb") / 1000

					if var_184_25 + var_184_18 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_25 + var_184_18
					end

					if var_184_21.prefab_name ~= "" and arg_181_1.actors_[var_184_21.prefab_name] ~= nil then
						local var_184_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_21.prefab_name].transform, "story_v_side_new_1107402", "1107402046", "story_v_side_new_1107402.awb")

						arg_181_1:RecordAudio("1107402046", var_184_26)
						arg_181_1:RecordAudio("1107402046", var_184_26)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_side_new_1107402", "1107402046", "story_v_side_new_1107402.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_side_new_1107402", "1107402046", "story_v_side_new_1107402.awb")
				end

				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_27 = var_184_18 + 0.3
			local var_184_28 = math.max(var_184_19, arg_181_1.talkMaxDuration)

			if var_184_18 + 0.3 <= arg_181_1.time_ and arg_181_1.time_ < var_184_27 + var_184_28 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_27) / var_184_28

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_27 + var_184_28 and arg_181_1.time_ < var_184_27 + var_184_28 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_181_1:InitPlayNodeList()
	end,
	Play1107402047 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 1107402047
		arg_189_1.duration_ = 7.9

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play1107402048(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = 0.7

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				arg_189_1.leftNameTxt_.text = arg_189_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_1 = arg_189_1:GetWordFromCfg(1107402047)
				local var_192_2 = arg_189_1:FormatText(var_192_1.content)

				arg_189_1.text_.text = var_192_2

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_4 = 28 <= 0 and var_192_0 or var_192_0 * (utf8.len(var_192_2) / 28)

				if (28 <= 0 and var_192_0 or var_192_0 * (utf8.len(var_192_2) / 28)) > 0 and var_192_0 < var_192_4 then
					arg_189_1.talkMaxDuration = var_192_4

					if var_192_4 + 0 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_4 + 0
					end
				end

				arg_189_1.text_.text = var_192_2
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107402", "1107402047", "story_v_side_new_1107402.awb") ~= 0 then
					local var_192_5 = manager.audio:GetVoiceLength("story_v_side_new_1107402", "1107402047", "story_v_side_new_1107402.awb") / 1000

					if var_192_5 + 0 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_5 + 0
					end

					if var_192_1.prefab_name ~= "" and arg_189_1.actors_[var_192_1.prefab_name] ~= nil then
						local var_192_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_1.prefab_name].transform, "story_v_side_new_1107402", "1107402047", "story_v_side_new_1107402.awb")

						arg_189_1:RecordAudio("1107402047", var_192_6)
						arg_189_1:RecordAudio("1107402047", var_192_6)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_side_new_1107402", "1107402047", "story_v_side_new_1107402.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_side_new_1107402", "1107402047", "story_v_side_new_1107402.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_7 = math.max(var_192_0, arg_189_1.talkMaxDuration)

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_7 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - 0) / var_192_7

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= 0 + var_192_7 and arg_189_1.time_ < 0 + var_192_7 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play1107402048 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 1107402048
		arg_193_1.duration_ = 5.27

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play1107402049(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = 0.525

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				arg_193_1.leftNameTxt_.text = arg_193_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_1 = arg_193_1:GetWordFromCfg(1107402048)
				local var_196_2 = arg_193_1:FormatText(var_196_1.content)

				arg_193_1.text_.text = var_196_2

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_4 = 21 <= 0 and var_196_0 or var_196_0 * (utf8.len(var_196_2) / 21)

				if (21 <= 0 and var_196_0 or var_196_0 * (utf8.len(var_196_2) / 21)) > 0 and var_196_0 < var_196_4 then
					arg_193_1.talkMaxDuration = var_196_4

					if var_196_4 + 0 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_4 + 0
					end
				end

				arg_193_1.text_.text = var_196_2
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107402", "1107402048", "story_v_side_new_1107402.awb") ~= 0 then
					local var_196_5 = manager.audio:GetVoiceLength("story_v_side_new_1107402", "1107402048", "story_v_side_new_1107402.awb") / 1000

					if var_196_5 + 0 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_5 + 0
					end

					if var_196_1.prefab_name ~= "" and arg_193_1.actors_[var_196_1.prefab_name] ~= nil then
						local var_196_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_1.prefab_name].transform, "story_v_side_new_1107402", "1107402048", "story_v_side_new_1107402.awb")

						arg_193_1:RecordAudio("1107402048", var_196_6)
						arg_193_1:RecordAudio("1107402048", var_196_6)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_side_new_1107402", "1107402048", "story_v_side_new_1107402.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_side_new_1107402", "1107402048", "story_v_side_new_1107402.awb")
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
	Play1107402049 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 1107402049
		arg_197_1.duration_ = 5

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play1107402050(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 and not isNil(arg_197_1.actors_["1074ui_story"]) and arg_197_1.var_.characterEffect1074ui_story == nil then
				arg_197_1.var_.characterEffect1074ui_story = arg_197_1.actors_["1074ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_0 = 0.1

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_0 and not isNil(arg_197_1.actors_["1074ui_story"]) then
				if arg_197_1.var_.characterEffect1074ui_story and not isNil(arg_197_1.actors_["1074ui_story"]) then
					arg_197_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_197_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_197_1.time_ - 0) / var_200_0)
				end
			end

			if arg_197_1.time_ >= 0 + var_200_0 and arg_197_1.time_ < 0 + var_200_0 + arg_200_0 and not isNil(arg_197_1.actors_["1074ui_story"]) and arg_197_1.var_.characterEffect1074ui_story then
				arg_197_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_197_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			local var_200_1 = 0
			local var_200_2 = 0.175

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= var_200_1 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				arg_197_1.leftNameTxt_.text = arg_197_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, true)
				arg_197_1.iconController_:SetSelectedState("hero")

				arg_197_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_197_1.callingController_:SetSelectedState("normal")

				arg_197_1.keyicon_.color = Color.New(1, 1, 1)
				arg_197_1.icon_.color = Color.New(1, 1, 1)

				local var_200_3 = arg_197_1:FormatText(arg_197_1:GetWordFromCfg(1107402049).content)

				arg_197_1.text_.text = var_200_3

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_5 = 7 <= 0 and var_200_2 or var_200_2 * (utf8.len(var_200_3) / 7)

				if (7 <= 0 and var_200_2 or var_200_2 * (utf8.len(var_200_3) / 7)) > 0 and var_200_2 < var_200_5 then
					arg_197_1.talkMaxDuration = var_200_5

					if var_200_5 + var_200_1 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_5 + var_200_1
					end
				end

				arg_197_1.text_.text = var_200_3
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)
				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_6 = math.max(var_200_2, arg_197_1.talkMaxDuration)

			if var_200_1 <= arg_197_1.time_ and arg_197_1.time_ < var_200_1 + var_200_6 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_1) / var_200_6

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_1 + var_200_6 and arg_197_1.time_ < var_200_1 + var_200_6 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {}

		arg_197_1:InitPlayNodeList()
	end,
	Play1107402050 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 1107402050
		arg_201_1.duration_ = 2.27

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play1107402051(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 and not isNil(arg_201_1.actors_["1074ui_story"]) and arg_201_1.var_.characterEffect1074ui_story == nil then
				arg_201_1.var_.characterEffect1074ui_story = arg_201_1.actors_["1074ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_204_0 = 0.1

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_0 and not isNil(arg_201_1.actors_["1074ui_story"]) then
				if arg_201_1.var_.characterEffect1074ui_story and not isNil(arg_201_1.actors_["1074ui_story"]) then
					arg_201_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_201_1.time_ >= 0 + var_204_0 and arg_201_1.time_ < 0 + var_204_0 + arg_204_0 and not isNil(arg_201_1.actors_["1074ui_story"]) and arg_201_1.var_.characterEffect1074ui_story then
				arg_201_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action5_1")
			end

			local var_204_2 = 0
			local var_204_3 = 0.3

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= var_204_2 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				arg_201_1.leftNameTxt_.text = arg_201_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_4 = arg_201_1:GetWordFromCfg(1107402050)
				local var_204_5 = arg_201_1:FormatText(var_204_4.content)

				arg_201_1.text_.text = var_204_5

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_7 = 12 <= 0 and var_204_3 or var_204_3 * (utf8.len(var_204_5) / 12)

				if (12 <= 0 and var_204_3 or var_204_3 * (utf8.len(var_204_5) / 12)) > 0 and var_204_3 < var_204_7 then
					arg_201_1.talkMaxDuration = var_204_7

					if var_204_7 + var_204_2 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_7 + var_204_2
					end
				end

				arg_201_1.text_.text = var_204_5
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107402", "1107402050", "story_v_side_new_1107402.awb") ~= 0 then
					local var_204_8 = manager.audio:GetVoiceLength("story_v_side_new_1107402", "1107402050", "story_v_side_new_1107402.awb") / 1000

					if var_204_8 + var_204_2 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_8 + var_204_2
					end

					if var_204_4.prefab_name ~= "" and arg_201_1.actors_[var_204_4.prefab_name] ~= nil then
						local var_204_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_4.prefab_name].transform, "story_v_side_new_1107402", "1107402050", "story_v_side_new_1107402.awb")

						arg_201_1:RecordAudio("1107402050", var_204_9)
						arg_201_1:RecordAudio("1107402050", var_204_9)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_side_new_1107402", "1107402050", "story_v_side_new_1107402.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_side_new_1107402", "1107402050", "story_v_side_new_1107402.awb")
				end

				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_10 = math.max(var_204_3, arg_201_1.talkMaxDuration)

			if var_204_2 <= arg_201_1.time_ and arg_201_1.time_ < var_204_2 + var_204_10 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_2) / var_204_10

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_2 + var_204_10 and arg_201_1.time_ < var_204_2 + var_204_10 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {}

		arg_201_1:InitPlayNodeList()
	end,
	Play1107402051 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 1107402051
		arg_205_1.duration_ = 2.87

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play1107402052(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = 0.425

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				arg_205_1.leftNameTxt_.text = arg_205_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_1 = arg_205_1:GetWordFromCfg(1107402051)
				local var_208_2 = arg_205_1:FormatText(var_208_1.content)

				arg_205_1.text_.text = var_208_2

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_4 = 17 <= 0 and var_208_0 or var_208_0 * (utf8.len(var_208_2) / 17)

				if (17 <= 0 and var_208_0 or var_208_0 * (utf8.len(var_208_2) / 17)) > 0 and var_208_0 < var_208_4 then
					arg_205_1.talkMaxDuration = var_208_4

					if var_208_4 + 0 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_4 + 0
					end
				end

				arg_205_1.text_.text = var_208_2
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107402", "1107402051", "story_v_side_new_1107402.awb") ~= 0 then
					local var_208_5 = manager.audio:GetVoiceLength("story_v_side_new_1107402", "1107402051", "story_v_side_new_1107402.awb") / 1000

					if var_208_5 + 0 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_5 + 0
					end

					if var_208_1.prefab_name ~= "" and arg_205_1.actors_[var_208_1.prefab_name] ~= nil then
						local var_208_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_205_1.actors_[var_208_1.prefab_name].transform, "story_v_side_new_1107402", "1107402051", "story_v_side_new_1107402.awb")

						arg_205_1:RecordAudio("1107402051", var_208_6)
						arg_205_1:RecordAudio("1107402051", var_208_6)
					else
						arg_205_1:AudioAction("play", "voice", "story_v_side_new_1107402", "1107402051", "story_v_side_new_1107402.awb")
					end

					arg_205_1:RecordHistoryTalkVoice("story_v_side_new_1107402", "1107402051", "story_v_side_new_1107402.awb")
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
	Play1107402052 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 1107402052
		arg_209_1.duration_ = 5

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play1107402053(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 and not isNil(arg_209_1.actors_["1074ui_story"]) and arg_209_1.var_.characterEffect1074ui_story == nil then
				arg_209_1.var_.characterEffect1074ui_story = arg_209_1.actors_["1074ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_212_0 = 0.1

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_0 and not isNil(arg_209_1.actors_["1074ui_story"]) then
				if arg_209_1.var_.characterEffect1074ui_story and not isNil(arg_209_1.actors_["1074ui_story"]) then
					arg_209_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_209_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_209_1.time_ - 0) / var_212_0)
				end
			end

			if arg_209_1.time_ >= 0 + var_212_0 and arg_209_1.time_ < 0 + var_212_0 + arg_212_0 and not isNil(arg_209_1.actors_["1074ui_story"]) and arg_209_1.var_.characterEffect1074ui_story then
				arg_209_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_209_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			local var_212_1 = 0
			local var_212_2 = 0.15

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= var_212_1 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				arg_209_1.leftNameTxt_.text = arg_209_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, true)
				arg_209_1.iconController_:SetSelectedState("hero")

				arg_209_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_209_1.callingController_:SetSelectedState("normal")

				arg_209_1.keyicon_.color = Color.New(1, 1, 1)
				arg_209_1.icon_.color = Color.New(1, 1, 1)

				local var_212_3 = arg_209_1:FormatText(arg_209_1:GetWordFromCfg(1107402052).content)

				arg_209_1.text_.text = var_212_3

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_5 = 6 <= 0 and var_212_2 or var_212_2 * (utf8.len(var_212_3) / 6)

				if (6 <= 0 and var_212_2 or var_212_2 * (utf8.len(var_212_3) / 6)) > 0 and var_212_2 < var_212_5 then
					arg_209_1.talkMaxDuration = var_212_5

					if var_212_5 + var_212_1 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_5 + var_212_1
					end
				end

				arg_209_1.text_.text = var_212_3
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)
				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_6 = math.max(var_212_2, arg_209_1.talkMaxDuration)

			if var_212_1 <= arg_209_1.time_ and arg_209_1.time_ < var_212_1 + var_212_6 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_1) / var_212_6

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_1 + var_212_6 and arg_209_1.time_ < var_212_1 + var_212_6 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {}

		arg_209_1:InitPlayNodeList()
	end,
	Play1107402053 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 1107402053
		arg_213_1.duration_ = 7.4

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play1107402054(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 and not isNil(arg_213_1.actors_["1074ui_story"]) and arg_213_1.var_.characterEffect1074ui_story == nil then
				arg_213_1.var_.characterEffect1074ui_story = arg_213_1.actors_["1074ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_216_0 = 0.1

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_0 and not isNil(arg_213_1.actors_["1074ui_story"]) then
				if arg_213_1.var_.characterEffect1074ui_story and not isNil(arg_213_1.actors_["1074ui_story"]) then
					arg_213_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_213_1.time_ >= 0 + var_216_0 and arg_213_1.time_ < 0 + var_216_0 + arg_216_0 and not isNil(arg_213_1.actors_["1074ui_story"]) and arg_213_1.var_.characterEffect1074ui_story then
				arg_213_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action5_2")
			end

			local var_216_2 = 0
			local var_216_3 = 0.675

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= var_216_2 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				arg_213_1.leftNameTxt_.text = arg_213_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_4 = arg_213_1:GetWordFromCfg(1107402053)
				local var_216_5 = arg_213_1:FormatText(var_216_4.content)

				arg_213_1.text_.text = var_216_5

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_7 = 27 <= 0 and var_216_3 or var_216_3 * (utf8.len(var_216_5) / 27)

				if (27 <= 0 and var_216_3 or var_216_3 * (utf8.len(var_216_5) / 27)) > 0 and var_216_3 < var_216_7 then
					arg_213_1.talkMaxDuration = var_216_7

					if var_216_7 + var_216_2 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_7 + var_216_2
					end
				end

				arg_213_1.text_.text = var_216_5
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107402", "1107402053", "story_v_side_new_1107402.awb") ~= 0 then
					local var_216_8 = manager.audio:GetVoiceLength("story_v_side_new_1107402", "1107402053", "story_v_side_new_1107402.awb") / 1000

					if var_216_8 + var_216_2 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_8 + var_216_2
					end

					if var_216_4.prefab_name ~= "" and arg_213_1.actors_[var_216_4.prefab_name] ~= nil then
						local var_216_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_4.prefab_name].transform, "story_v_side_new_1107402", "1107402053", "story_v_side_new_1107402.awb")

						arg_213_1:RecordAudio("1107402053", var_216_9)
						arg_213_1:RecordAudio("1107402053", var_216_9)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_side_new_1107402", "1107402053", "story_v_side_new_1107402.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_side_new_1107402", "1107402053", "story_v_side_new_1107402.awb")
				end

				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_10 = math.max(var_216_3, arg_213_1.talkMaxDuration)

			if var_216_2 <= arg_213_1.time_ and arg_213_1.time_ < var_216_2 + var_216_10 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_2) / var_216_10

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_2 + var_216_10 and arg_213_1.time_ < var_216_2 + var_216_10 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {}

		arg_213_1:InitPlayNodeList()
	end,
	Play1107402054 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 1107402054
		arg_217_1.duration_ = 5.73

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play1107402055(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 and not isNil(arg_217_1.actors_["1074ui_story"]) and arg_217_1.var_.characterEffect1074ui_story == nil then
				arg_217_1.var_.characterEffect1074ui_story = arg_217_1.actors_["1074ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_220_0 = 0.1

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_0 and not isNil(arg_217_1.actors_["1074ui_story"]) then
				if arg_217_1.var_.characterEffect1074ui_story and not isNil(arg_217_1.actors_["1074ui_story"]) then
					arg_217_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_217_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_217_1.time_ - 0) / var_220_0)
				end
			end

			if arg_217_1.time_ >= 0 + var_220_0 and arg_217_1.time_ < 0 + var_220_0 + arg_220_0 and not isNil(arg_217_1.actors_["1074ui_story"]) and arg_217_1.var_.characterEffect1074ui_story then
				arg_217_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_217_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			local var_220_1 = 0
			local var_220_2 = 0.725

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= var_220_1 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				arg_217_1.leftNameTxt_.text = arg_217_1:FormatText(StoryNameCfg[1051].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, true)
				arg_217_1.iconController_:SetSelectedState("hero")

				arg_217_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officeladya")

				arg_217_1.callingController_:SetSelectedState("normal")

				arg_217_1.keyicon_.color = Color.New(1, 1, 1)
				arg_217_1.icon_.color = Color.New(1, 1, 1)

				local var_220_3 = arg_217_1:GetWordFromCfg(1107402054)
				local var_220_4 = arg_217_1:FormatText(var_220_3.content)

				arg_217_1.text_.text = var_220_4

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_6 = 29 <= 0 and var_220_2 or var_220_2 * (utf8.len(var_220_4) / 29)

				if (29 <= 0 and var_220_2 or var_220_2 * (utf8.len(var_220_4) / 29)) > 0 and var_220_2 < var_220_6 then
					arg_217_1.talkMaxDuration = var_220_6

					if var_220_6 + var_220_1 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_6 + var_220_1
					end
				end

				arg_217_1.text_.text = var_220_4
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107402", "1107402054", "story_v_side_new_1107402.awb") ~= 0 then
					local var_220_7 = manager.audio:GetVoiceLength("story_v_side_new_1107402", "1107402054", "story_v_side_new_1107402.awb") / 1000

					if var_220_7 + var_220_1 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_7 + var_220_1
					end

					if var_220_3.prefab_name ~= "" and arg_217_1.actors_[var_220_3.prefab_name] ~= nil then
						local var_220_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_217_1.actors_[var_220_3.prefab_name].transform, "story_v_side_new_1107402", "1107402054", "story_v_side_new_1107402.awb")

						arg_217_1:RecordAudio("1107402054", var_220_8)
						arg_217_1:RecordAudio("1107402054", var_220_8)
					else
						arg_217_1:AudioAction("play", "voice", "story_v_side_new_1107402", "1107402054", "story_v_side_new_1107402.awb")
					end

					arg_217_1:RecordHistoryTalkVoice("story_v_side_new_1107402", "1107402054", "story_v_side_new_1107402.awb")
				end

				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_9 = math.max(var_220_2, arg_217_1.talkMaxDuration)

			if var_220_1 <= arg_217_1.time_ and arg_217_1.time_ < var_220_1 + var_220_9 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_1) / var_220_9

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_1 + var_220_9 and arg_217_1.time_ < var_220_1 + var_220_9 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {}

		arg_217_1:InitPlayNodeList()
	end,
	Play1107402055 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 1107402055
		arg_221_1.duration_ = 1.97

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play1107402056(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 and not isNil(arg_221_1.actors_["1074ui_story"]) and arg_221_1.var_.characterEffect1074ui_story == nil then
				arg_221_1.var_.characterEffect1074ui_story = arg_221_1.actors_["1074ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_224_0 = 0.1

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_0 and not isNil(arg_221_1.actors_["1074ui_story"]) then
				if arg_221_1.var_.characterEffect1074ui_story and not isNil(arg_221_1.actors_["1074ui_story"]) then
					arg_221_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_221_1.time_ >= 0 + var_224_0 and arg_221_1.time_ < 0 + var_224_0 + arg_224_0 and not isNil(arg_221_1.actors_["1074ui_story"]) and arg_221_1.var_.characterEffect1074ui_story then
				arg_221_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_224_2 = 0
			local var_224_3 = 0.2

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= var_224_2 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				arg_221_1.leftNameTxt_.text = arg_221_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_4 = arg_221_1:GetWordFromCfg(1107402055)
				local var_224_5 = arg_221_1:FormatText(var_224_4.content)

				arg_221_1.text_.text = var_224_5

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_7 = 8 <= 0 and var_224_3 or var_224_3 * (utf8.len(var_224_5) / 8)

				if (8 <= 0 and var_224_3 or var_224_3 * (utf8.len(var_224_5) / 8)) > 0 and var_224_3 < var_224_7 then
					arg_221_1.talkMaxDuration = var_224_7

					if var_224_7 + var_224_2 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_7 + var_224_2
					end
				end

				arg_221_1.text_.text = var_224_5
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107402", "1107402055", "story_v_side_new_1107402.awb") ~= 0 then
					local var_224_8 = manager.audio:GetVoiceLength("story_v_side_new_1107402", "1107402055", "story_v_side_new_1107402.awb") / 1000

					if var_224_8 + var_224_2 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_8 + var_224_2
					end

					if var_224_4.prefab_name ~= "" and arg_221_1.actors_[var_224_4.prefab_name] ~= nil then
						local var_224_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_4.prefab_name].transform, "story_v_side_new_1107402", "1107402055", "story_v_side_new_1107402.awb")

						arg_221_1:RecordAudio("1107402055", var_224_9)
						arg_221_1:RecordAudio("1107402055", var_224_9)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_side_new_1107402", "1107402055", "story_v_side_new_1107402.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_side_new_1107402", "1107402055", "story_v_side_new_1107402.awb")
				end

				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_10 = math.max(var_224_3, arg_221_1.talkMaxDuration)

			if var_224_2 <= arg_221_1.time_ and arg_221_1.time_ < var_224_2 + var_224_10 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_2) / var_224_10

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_2 + var_224_10 and arg_221_1.time_ < var_224_2 + var_224_10 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {}

		arg_221_1:InitPlayNodeList()
	end,
	Play1107402056 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 1107402056
		arg_225_1.duration_ = 5

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play1107402057(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 and not isNil(arg_225_1.actors_["1074ui_story"]) and arg_225_1.var_.characterEffect1074ui_story == nil then
				arg_225_1.var_.characterEffect1074ui_story = arg_225_1.actors_["1074ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_228_0 = 0.1

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_0 and not isNil(arg_225_1.actors_["1074ui_story"]) then
				if arg_225_1.var_.characterEffect1074ui_story and not isNil(arg_225_1.actors_["1074ui_story"]) then
					arg_225_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_225_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_225_1.time_ - 0) / var_228_0)
				end
			end

			if arg_225_1.time_ >= 0 + var_228_0 and arg_225_1.time_ < 0 + var_228_0 + arg_228_0 and not isNil(arg_225_1.actors_["1074ui_story"]) and arg_225_1.var_.characterEffect1074ui_story then
				arg_225_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_225_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			local var_228_1 = 0
			local var_228_2 = 1.075

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= var_228_1 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, false)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_3 = arg_225_1:FormatText(arg_225_1:GetWordFromCfg(1107402056).content)

				arg_225_1.text_.text = var_228_3

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_5 = 43 <= 0 and var_228_2 or var_228_2 * (utf8.len(var_228_3) / 43)

				if (43 <= 0 and var_228_2 or var_228_2 * (utf8.len(var_228_3) / 43)) > 0 and var_228_2 < var_228_5 then
					arg_225_1.talkMaxDuration = var_228_5

					if var_228_5 + var_228_1 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_5 + var_228_1
					end
				end

				arg_225_1.text_.text = var_228_3
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)
				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_6 = math.max(var_228_2, arg_225_1.talkMaxDuration)

			if var_228_1 <= arg_225_1.time_ and arg_225_1.time_ < var_228_1 + var_228_6 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_1) / var_228_6

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_1 + var_228_6 and arg_225_1.time_ < var_228_1 + var_228_6 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {}

		arg_225_1:InitPlayNodeList()
	end,
	Play1107402057 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 1107402057
		arg_229_1.duration_ = 2.07

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play1107402058(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 and not isNil(arg_229_1.actors_["1074ui_story"]) and arg_229_1.var_.characterEffect1074ui_story == nil then
				arg_229_1.var_.characterEffect1074ui_story = arg_229_1.actors_["1074ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_232_0 = 0.1

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_0 and not isNil(arg_229_1.actors_["1074ui_story"]) then
				if arg_229_1.var_.characterEffect1074ui_story and not isNil(arg_229_1.actors_["1074ui_story"]) then
					arg_229_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_229_1.time_ >= 0 + var_232_0 and arg_229_1.time_ < 0 + var_232_0 + arg_232_0 and not isNil(arg_229_1.actors_["1074ui_story"]) and arg_229_1.var_.characterEffect1074ui_story then
				arg_229_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action3_1")
			end

			local var_232_2 = 0
			local var_232_3 = 0.15

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= var_232_2 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				arg_229_1.leftNameTxt_.text = arg_229_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_4 = arg_229_1:GetWordFromCfg(1107402057)
				local var_232_5 = arg_229_1:FormatText(var_232_4.content)

				arg_229_1.text_.text = var_232_5

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_7 = 6 <= 0 and var_232_3 or var_232_3 * (utf8.len(var_232_5) / 6)

				if (6 <= 0 and var_232_3 or var_232_3 * (utf8.len(var_232_5) / 6)) > 0 and var_232_3 < var_232_7 then
					arg_229_1.talkMaxDuration = var_232_7

					if var_232_7 + var_232_2 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_7 + var_232_2
					end
				end

				arg_229_1.text_.text = var_232_5
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107402", "1107402057", "story_v_side_new_1107402.awb") ~= 0 then
					local var_232_8 = manager.audio:GetVoiceLength("story_v_side_new_1107402", "1107402057", "story_v_side_new_1107402.awb") / 1000

					if var_232_8 + var_232_2 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_8 + var_232_2
					end

					if var_232_4.prefab_name ~= "" and arg_229_1.actors_[var_232_4.prefab_name] ~= nil then
						local var_232_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_4.prefab_name].transform, "story_v_side_new_1107402", "1107402057", "story_v_side_new_1107402.awb")

						arg_229_1:RecordAudio("1107402057", var_232_9)
						arg_229_1:RecordAudio("1107402057", var_232_9)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_side_new_1107402", "1107402057", "story_v_side_new_1107402.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_side_new_1107402", "1107402057", "story_v_side_new_1107402.awb")
				end

				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_10 = math.max(var_232_3, arg_229_1.talkMaxDuration)

			if var_232_2 <= arg_229_1.time_ and arg_229_1.time_ < var_232_2 + var_232_10 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_2) / var_232_10

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_2 + var_232_10 and arg_229_1.time_ < var_232_2 + var_232_10 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {}

		arg_229_1:InitPlayNodeList()
	end,
	Play1107402058 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 1107402058
		arg_233_1.duration_ = 1

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"

			SetActive(arg_233_1.choicesGo_, true)

			for iter_234_0, iter_234_1 in ipairs(arg_233_1.choices_) do
				SetActive(iter_234_1.go, iter_234_0 <= 2)
			end

			arg_233_1.choices_[1].txt.text = arg_233_1:FormatText(StoryChoiceCfg[1012].name)
			arg_233_1.choices_[2].txt.text = arg_233_1:FormatText(StoryChoiceCfg[1013].name)
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play1107402059(arg_233_1)
			end

			if arg_235_0 == 2 then
				arg_233_0:Play1107402061(arg_233_1)
			end

			arg_233_1:RecordChoiceLog(1107402058, 1012, 1013)
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 and not isNil(arg_233_1.actors_["1074ui_story"]) and arg_233_1.var_.characterEffect1074ui_story == nil then
				arg_233_1.var_.characterEffect1074ui_story = arg_233_1.actors_["1074ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_236_0 = 0.1

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_0 and not isNil(arg_233_1.actors_["1074ui_story"]) then
				if arg_233_1.var_.characterEffect1074ui_story and not isNil(arg_233_1.actors_["1074ui_story"]) then
					arg_233_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_233_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_233_1.time_ - 0) / var_236_0)
				end
			end

			if arg_233_1.time_ >= 0 + var_236_0 and arg_233_1.time_ < 0 + var_236_0 + arg_236_0 and not isNil(arg_233_1.actors_["1074ui_story"]) and arg_233_1.var_.characterEffect1074ui_story then
				arg_233_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_233_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end
		end

		arg_233_1.nodeConfigList_ = {}

		arg_233_1:InitPlayNodeList()
	end,
	Play1107402059 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 1107402059
		arg_237_1.duration_ = 5

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play1107402060(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1.var_.moveOldPos1074ui_story = arg_237_1.actors_["1074ui_story"].transform.localPosition

				arg_237_1:ShowWeapon(arg_237_1.var_["1074ui_story" .. "Animator"].transform, false)
			end

			local var_240_0 = 0.001

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_0 then
				arg_237_1.actors_["1074ui_story"].transform.localPosition = Vector3.Lerp(arg_237_1.var_.moveOldPos1074ui_story, Vector3.New(0, 100, 0), (arg_237_1.time_ - 0) / var_240_0)
				arg_237_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_237_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_237_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_237_1.actors_["1074ui_story"].transform.position).z)
				arg_237_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_237_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_237_1.actors_["1074ui_story"].transform.localEulerAngles = arg_237_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			if arg_237_1.time_ >= 0 + var_240_0 and arg_237_1.time_ < 0 + var_240_0 + arg_240_0 then
				arg_237_1.actors_["1074ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_237_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_237_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_237_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_237_1.actors_["1074ui_story"].transform.position).z)
				arg_237_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_237_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_237_1.actors_["1074ui_story"].transform.localEulerAngles = arg_237_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			local var_240_1 = 0
			local var_240_2 = 1.375

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

				local var_240_3 = arg_237_1:FormatText(arg_237_1:GetWordFromCfg(1107402059).content)

				arg_237_1.text_.text = var_240_3

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_5 = 55 <= 0 and var_240_2 or var_240_2 * (utf8.len(var_240_3) / 55)

				if (55 <= 0 and var_240_2 or var_240_2 * (utf8.len(var_240_3) / 55)) > 0 and var_240_2 < var_240_5 then
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

		arg_237_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_237_1:InitPlayNodeList()
	end,
	Play1107402060 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 1107402060
		arg_241_1.duration_ = 5

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play1107402063(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			local var_244_0 = 0.7

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, false)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_1 = arg_241_1:FormatText(arg_241_1:GetWordFromCfg(1107402060).content)

				arg_241_1.text_.text = var_244_1

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_3 = 28 <= 0 and var_244_0 or var_244_0 * (utf8.len(var_244_1) / 28)

				if (28 <= 0 and var_244_0 or var_244_0 * (utf8.len(var_244_1) / 28)) > 0 and var_244_0 < var_244_3 then
					arg_241_1.talkMaxDuration = var_244_3

					if var_244_3 + 0 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_3 + 0
					end
				end

				arg_241_1.text_.text = var_244_1
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)
				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_4 = math.max(var_244_0, arg_241_1.talkMaxDuration)

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_4 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - 0) / var_244_4

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= 0 + var_244_4 and arg_241_1.time_ < 0 + var_244_4 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {}

		arg_241_1:InitPlayNodeList()
	end,
	Play1107402063 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 1107402063
		arg_245_1.duration_ = 4.47

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play1107402064(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 and not isNil(arg_245_1.actors_["1074ui_story"]) and arg_245_1.var_.characterEffect1074ui_story == nil then
				arg_245_1.var_.characterEffect1074ui_story = arg_245_1.actors_["1074ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_248_0 = 0.1

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_0 and not isNil(arg_245_1.actors_["1074ui_story"]) then
				if arg_245_1.var_.characterEffect1074ui_story and not isNil(arg_245_1.actors_["1074ui_story"]) then
					arg_245_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_245_1.time_ >= 0 + var_248_0 and arg_245_1.time_ < 0 + var_248_0 + arg_248_0 and not isNil(arg_245_1.actors_["1074ui_story"]) and arg_245_1.var_.characterEffect1074ui_story then
				arg_245_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_248_2 = arg_245_1.actors_["1074ui_story"].transform

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1.var_.moveOldPos1074ui_story = var_248_2.localPosition

				arg_245_1:ShowWeapon(arg_245_1.var_["1074ui_story" .. "Animator"].transform, false)
			end

			local var_248_3 = 0.001

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_3 then
				var_248_2.localPosition = Vector3.Lerp(arg_245_1.var_.moveOldPos1074ui_story, Vector3.New(0, -1.055, -6.12), (arg_245_1.time_ - 0) / var_248_3)
				var_248_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_248_2.position).x, (manager.ui.mainCamera.transform.position - var_248_2.position).y, (manager.ui.mainCamera.transform.position - var_248_2.position).z)
				var_248_2.localEulerAngles.z = 0
				var_248_2.localEulerAngles.x = 0
				var_248_2.localEulerAngles = var_248_2.localEulerAngles
			end

			if arg_245_1.time_ >= 0 + var_248_3 and arg_245_1.time_ < 0 + var_248_3 + arg_248_0 then
				var_248_2.localPosition = Vector3.New(0, -1.055, -6.12)
				var_248_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_248_2.position).x, (manager.ui.mainCamera.transform.position - var_248_2.position).y, (manager.ui.mainCamera.transform.position - var_248_2.position).z)
				var_248_2.localEulerAngles.z = 0
				var_248_2.localEulerAngles.x = 0
				var_248_2.localEulerAngles = var_248_2.localEulerAngles
			end

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action3_2")
			end

			local var_248_4 = 0
			local var_248_5 = 0.275

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= var_248_4 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				arg_245_1.leftNameTxt_.text = arg_245_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_6 = arg_245_1:GetWordFromCfg(1107402063)
				local var_248_7 = arg_245_1:FormatText(var_248_6.content)

				arg_245_1.text_.text = var_248_7

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_9 = 11 <= 0 and var_248_5 or var_248_5 * (utf8.len(var_248_7) / 11)

				if (11 <= 0 and var_248_5 or var_248_5 * (utf8.len(var_248_7) / 11)) > 0 and var_248_5 < var_248_9 then
					arg_245_1.talkMaxDuration = var_248_9

					if var_248_9 + var_248_4 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_9 + var_248_4
					end
				end

				arg_245_1.text_.text = var_248_7
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107402", "1107402063", "story_v_side_new_1107402.awb") ~= 0 then
					local var_248_10 = manager.audio:GetVoiceLength("story_v_side_new_1107402", "1107402063", "story_v_side_new_1107402.awb") / 1000

					if var_248_10 + var_248_4 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_10 + var_248_4
					end

					if var_248_6.prefab_name ~= "" and arg_245_1.actors_[var_248_6.prefab_name] ~= nil then
						local var_248_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_245_1.actors_[var_248_6.prefab_name].transform, "story_v_side_new_1107402", "1107402063", "story_v_side_new_1107402.awb")

						arg_245_1:RecordAudio("1107402063", var_248_11)
						arg_245_1:RecordAudio("1107402063", var_248_11)
					else
						arg_245_1:AudioAction("play", "voice", "story_v_side_new_1107402", "1107402063", "story_v_side_new_1107402.awb")
					end

					arg_245_1:RecordHistoryTalkVoice("story_v_side_new_1107402", "1107402063", "story_v_side_new_1107402.awb")
				end

				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_12 = math.max(var_248_5, arg_245_1.talkMaxDuration)

			if var_248_4 <= arg_245_1.time_ and arg_245_1.time_ < var_248_4 + var_248_12 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_4) / var_248_12

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_4 + var_248_12 and arg_245_1.time_ < var_248_4 + var_248_12 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_245_1:InitPlayNodeList()
	end,
	Play1107402064 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 1107402064
		arg_249_1.duration_ = 4.5

		SetActive(arg_249_1.tipsGo_, false)

		function arg_249_1.onSingleLineFinish_()
			arg_249_1.onSingleLineUpdate_ = nil
			arg_249_1.onSingleLineFinish_ = nil
			arg_249_1.state_ = "waiting"
		end

		function arg_249_1.playNext_(arg_251_0)
			if arg_251_0 == 1 then
				arg_249_0:Play1107402065(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1.var_.moveOldPos1074ui_story = arg_249_1.actors_["1074ui_story"].transform.localPosition

				arg_249_1:ShowWeapon(arg_249_1.var_["1074ui_story" .. "Animator"].transform, false)
			end

			local var_252_0 = 0.001

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_0 then
				arg_249_1.actors_["1074ui_story"].transform.localPosition = Vector3.Lerp(arg_249_1.var_.moveOldPos1074ui_story, Vector3.New(0, 100, 0), (arg_249_1.time_ - 0) / var_252_0)
				arg_249_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_249_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_249_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_249_1.actors_["1074ui_story"].transform.position).z)
				arg_249_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_249_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_249_1.actors_["1074ui_story"].transform.localEulerAngles = arg_249_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			if arg_249_1.time_ >= 0 + var_252_0 and arg_249_1.time_ < 0 + var_252_0 + arg_252_0 then
				arg_249_1.actors_["1074ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_249_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_249_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_249_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_249_1.actors_["1074ui_story"].transform.position).z)
				arg_249_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_249_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_249_1.actors_["1074ui_story"].transform.localEulerAngles = arg_249_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			local var_252_1 = 0
			local var_252_2 = 0.4

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= var_252_1 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				arg_249_1.leftNameTxt_.text = arg_249_1:FormatText(StoryNameCfg[1051].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, true)
				arg_249_1.iconController_:SetSelectedState("hero")

				arg_249_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officeladya")

				arg_249_1.callingController_:SetSelectedState("normal")

				arg_249_1.keyicon_.color = Color.New(1, 1, 1)
				arg_249_1.icon_.color = Color.New(1, 1, 1)

				local var_252_3 = arg_249_1:GetWordFromCfg(1107402064)
				local var_252_4 = arg_249_1:FormatText(var_252_3.content)

				arg_249_1.text_.text = var_252_4

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_6 = 16 <= 0 and var_252_2 or var_252_2 * (utf8.len(var_252_4) / 16)

				if (16 <= 0 and var_252_2 or var_252_2 * (utf8.len(var_252_4) / 16)) > 0 and var_252_2 < var_252_6 then
					arg_249_1.talkMaxDuration = var_252_6

					if var_252_6 + var_252_1 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_6 + var_252_1
					end
				end

				arg_249_1.text_.text = var_252_4
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107402", "1107402064", "story_v_side_new_1107402.awb") ~= 0 then
					local var_252_7 = manager.audio:GetVoiceLength("story_v_side_new_1107402", "1107402064", "story_v_side_new_1107402.awb") / 1000

					if var_252_7 + var_252_1 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_7 + var_252_1
					end

					if var_252_3.prefab_name ~= "" and arg_249_1.actors_[var_252_3.prefab_name] ~= nil then
						local var_252_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_249_1.actors_[var_252_3.prefab_name].transform, "story_v_side_new_1107402", "1107402064", "story_v_side_new_1107402.awb")

						arg_249_1:RecordAudio("1107402064", var_252_8)
						arg_249_1:RecordAudio("1107402064", var_252_8)
					else
						arg_249_1:AudioAction("play", "voice", "story_v_side_new_1107402", "1107402064", "story_v_side_new_1107402.awb")
					end

					arg_249_1:RecordHistoryTalkVoice("story_v_side_new_1107402", "1107402064", "story_v_side_new_1107402.awb")
				end

				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_9 = math.max(var_252_2, arg_249_1.talkMaxDuration)

			if var_252_1 <= arg_249_1.time_ and arg_249_1.time_ < var_252_1 + var_252_9 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_1) / var_252_9

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_1 + var_252_9 and arg_249_1.time_ < var_252_1 + var_252_9 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_249_1:InitPlayNodeList()
	end,
	Play1107402065 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 1107402065
		arg_253_1.duration_ = 5

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play1107402066(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			local var_256_0 = 1.125

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, false)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_1 = arg_253_1:FormatText(arg_253_1:GetWordFromCfg(1107402065).content)

				arg_253_1.text_.text = var_256_1

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_3 = 45 <= 0 and var_256_0 or var_256_0 * (utf8.len(var_256_1) / 45)

				if (45 <= 0 and var_256_0 or var_256_0 * (utf8.len(var_256_1) / 45)) > 0 and var_256_0 < var_256_3 then
					arg_253_1.talkMaxDuration = var_256_3

					if var_256_3 + 0 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_3 + 0
					end
				end

				arg_253_1.text_.text = var_256_1
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)
				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_4 = math.max(var_256_0, arg_253_1.talkMaxDuration)

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_4 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - 0) / var_256_4

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= 0 + var_256_4 and arg_253_1.time_ < 0 + var_256_4 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {}

		arg_253_1:InitPlayNodeList()
	end,
	Play1107402066 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 1107402066
		arg_257_1.duration_ = 4.6

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play1107402067(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			local var_260_0 = 0.6

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				arg_257_1.leftNameTxt_.text = arg_257_1:FormatText(StoryNameCfg[1051].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, true)
				arg_257_1.iconController_:SetSelectedState("hero")

				arg_257_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officeladya")

				arg_257_1.callingController_:SetSelectedState("normal")

				arg_257_1.keyicon_.color = Color.New(1, 1, 1)
				arg_257_1.icon_.color = Color.New(1, 1, 1)

				local var_260_1 = arg_257_1:GetWordFromCfg(1107402066)
				local var_260_2 = arg_257_1:FormatText(var_260_1.content)

				arg_257_1.text_.text = var_260_2

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_4 = 24 <= 0 and var_260_0 or var_260_0 * (utf8.len(var_260_2) / 24)

				if (24 <= 0 and var_260_0 or var_260_0 * (utf8.len(var_260_2) / 24)) > 0 and var_260_0 < var_260_4 then
					arg_257_1.talkMaxDuration = var_260_4

					if var_260_4 + 0 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_4 + 0
					end
				end

				arg_257_1.text_.text = var_260_2
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107402", "1107402066", "story_v_side_new_1107402.awb") ~= 0 then
					local var_260_5 = manager.audio:GetVoiceLength("story_v_side_new_1107402", "1107402066", "story_v_side_new_1107402.awb") / 1000

					if var_260_5 + 0 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_5 + 0
					end

					if var_260_1.prefab_name ~= "" and arg_257_1.actors_[var_260_1.prefab_name] ~= nil then
						local var_260_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_257_1.actors_[var_260_1.prefab_name].transform, "story_v_side_new_1107402", "1107402066", "story_v_side_new_1107402.awb")

						arg_257_1:RecordAudio("1107402066", var_260_6)
						arg_257_1:RecordAudio("1107402066", var_260_6)
					else
						arg_257_1:AudioAction("play", "voice", "story_v_side_new_1107402", "1107402066", "story_v_side_new_1107402.awb")
					end

					arg_257_1:RecordHistoryTalkVoice("story_v_side_new_1107402", "1107402066", "story_v_side_new_1107402.awb")
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
	Play1107402067 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 1107402067
		arg_261_1.duration_ = 7

		SetActive(arg_261_1.tipsGo_, false)

		function arg_261_1.onSingleLineFinish_()
			arg_261_1.onSingleLineUpdate_ = nil
			arg_261_1.onSingleLineFinish_ = nil
			arg_261_1.state_ = "waiting"
		end

		function arg_261_1.playNext_(arg_263_0)
			if arg_263_0 == 1 then
				arg_261_0:Play1107402068(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			if 1 < arg_261_1.time_ and arg_261_1.time_ <= 1 + arg_264_0 then
				local var_264_0 = arg_261_1.bgs_.STblack

				arg_261_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_264_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_264_1 = var_264_0:GetComponent("SpriteRenderer")

				if var_264_1 and var_264_1.sprite then
					local var_264_2 = 2 * (var_264_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_264_0.transform.localScale = Vector3.New(var_264_2 / var_264_1.sprite.bounds.size.y < var_264_2 * manager.ui.mainCameraCom_.aspect / var_264_1.sprite.bounds.size.x and var_264_2 * manager.ui.mainCameraCom_.aspect / var_264_1.sprite.bounds.size.x or var_264_2 / var_264_1.sprite.bounds.size.y, var_264_2 / var_264_1.sprite.bounds.size.y < var_264_2 * manager.ui.mainCameraCom_.aspect / var_264_1.sprite.bounds.size.x and var_264_2 * manager.ui.mainCameraCom_.aspect / var_264_1.sprite.bounds.size.x or var_264_2 / var_264_1.sprite.bounds.size.y, 0)
				end

				for iter_264_0, iter_264_1 in pairs(arg_261_1.bgs_) do
					if iter_264_0 ~= "STblack" then
						iter_264_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_264_3 = 1

			if 1 < arg_261_1.time_ and arg_261_1.time_ <= var_264_3 + arg_264_0 then
				arg_261_1.allBtn_.enabled = false
			end

			if arg_261_1.time_ >= var_264_3 + 0.666666666666666 and arg_261_1.time_ < var_264_3 + 0.666666666666666 + arg_264_0 then
				arg_261_1.allBtn_.enabled = true
			end

			local var_264_4 = 0

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= var_264_4 + arg_264_0 then
				arg_261_1.mask_.enabled = true
				arg_261_1.mask_.raycastTarget = true

				arg_261_1:SetGaussion(false)
			end

			local var_264_5 = 1

			if var_264_4 <= arg_261_1.time_ and arg_261_1.time_ < var_264_4 + var_264_5 then
				local var_264_6 = Color.New(0, 0, 0)

				var_264_6.a = Mathf.Lerp(0, 1, (arg_261_1.time_ - var_264_4) / var_264_5)
				arg_261_1.mask_.color = var_264_6
			end

			if arg_261_1.time_ >= var_264_4 + var_264_5 and arg_261_1.time_ < var_264_4 + var_264_5 + arg_264_0 then
				local var_264_7 = Color.New(0, 0, 0)

				var_264_7.a = 1
				arg_261_1.mask_.color = var_264_7
			end

			local var_264_8 = 1

			if 1 < arg_261_1.time_ and arg_261_1.time_ <= var_264_8 + arg_264_0 then
				arg_261_1.mask_.enabled = true
				arg_261_1.mask_.raycastTarget = true

				arg_261_1:SetGaussion(false)
			end

			local var_264_9 = 1

			if var_264_8 <= arg_261_1.time_ and arg_261_1.time_ < var_264_8 + var_264_9 then
				local var_264_10 = Color.New(0, 0, 0)

				var_264_10.a = Mathf.Lerp(1, 0, (arg_261_1.time_ - var_264_8) / var_264_9)
				arg_261_1.mask_.color = var_264_10
			end

			if arg_261_1.time_ >= var_264_8 + var_264_9 and arg_261_1.time_ < var_264_8 + var_264_9 + arg_264_0 then
				local var_264_11 = Color.New(0, 0, 0)

				arg_261_1.mask_.enabled = false
				var_264_11.a = 0
				arg_261_1.mask_.color = var_264_11
			end

			if arg_261_1.frameCnt_ <= 1 then
				arg_261_1.dialog_:SetActive(false)
			end

			local var_264_12 = 2
			local var_264_13 = 0.6

			if 2 < arg_261_1.time_ and arg_261_1.time_ <= var_264_12 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0

				arg_261_1.dialog_:SetActive(true)

				arg_261_1.dialogCg_.alpha = 0

				local var_264_14 = LeanTween.value(arg_261_1.dialog_, 0, 1, 0.3)

				var_264_14:setOnUpdate(LuaHelper.FloatAction(function(arg_265_0)
					arg_261_1.dialogCg_.alpha = arg_265_0
				end))
				var_264_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_261_1.dialog_)
					var_264_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_261_1.duration_ = arg_261_1.duration_ + 0.3

				SetActive(arg_261_1.leftNameGo_, false)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_15 = arg_261_1:FormatText(arg_261_1:GetWordFromCfg(1107402067).content)

				arg_261_1.text_.text = var_264_15

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_17 = 24 <= 0 and var_264_13 or var_264_13 * (utf8.len(var_264_15) / 24)

				if (24 <= 0 and var_264_13 or var_264_13 * (utf8.len(var_264_15) / 24)) > 0 and var_264_13 < var_264_17 then
					arg_261_1.talkMaxDuration = var_264_17
					var_264_12 = var_264_12 + 0.3

					if var_264_17 + var_264_12 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_17 + var_264_12
					end
				end

				arg_261_1.text_.text = var_264_15
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)
				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_18 = var_264_12 + 0.3
			local var_264_19 = math.max(var_264_13, arg_261_1.talkMaxDuration)

			if var_264_12 + 0.3 <= arg_261_1.time_ and arg_261_1.time_ < var_264_18 + var_264_19 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_18) / var_264_19

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_18 + var_264_19 and arg_261_1.time_ < var_264_18 + var_264_19 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {}

		arg_261_1:InitPlayNodeList()
	end,
	Play1107402068 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 1107402068
		arg_267_1.duration_ = 6

		SetActive(arg_267_1.tipsGo_, false)

		function arg_267_1.onSingleLineFinish_()
			arg_267_1.onSingleLineUpdate_ = nil
			arg_267_1.onSingleLineFinish_ = nil
			arg_267_1.state_ = "waiting"
		end

		function arg_267_1.playNext_(arg_269_0)
			if arg_269_0 == 1 then
				arg_267_0:Play1107402069(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			if 4.44089209850063e-16 < arg_267_1.time_ and arg_267_1.time_ <= 4.44089209850063e-16 + arg_270_0 then
				arg_267_1.allBtn_.enabled = false
			end

			if arg_267_1.time_ >= 4.44089209850063e-16 + 1 and arg_267_1.time_ < 4.44089209850063e-16 + 1 + arg_270_0 then
				arg_267_1.allBtn_.enabled = true
			end

			local var_270_0 = "ST45"

			if arg_267_1.bgs_.ST45 == nil then
				local var_270_1 = Object.Instantiate(arg_267_1.paintGo_)

				var_270_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_270_0)
				var_270_1.name = var_270_0
				var_270_1.transform.parent = arg_267_1.stage_.transform
				var_270_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_267_1.bgs_[var_270_0] = var_270_1
			end

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 then
				local var_270_2 = arg_267_1.bgs_.ST45

				arg_267_1.bgs_.ST45.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_270_2.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_270_3 = var_270_2:GetComponent("SpriteRenderer")

				if var_270_3 and var_270_3.sprite then
					local var_270_4 = 2 * (var_270_2.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_270_2.transform.localScale = Vector3.New(var_270_4 / var_270_3.sprite.bounds.size.y < var_270_4 * manager.ui.mainCameraCom_.aspect / var_270_3.sprite.bounds.size.x and var_270_4 * manager.ui.mainCameraCom_.aspect / var_270_3.sprite.bounds.size.x or var_270_4 / var_270_3.sprite.bounds.size.y, var_270_4 / var_270_3.sprite.bounds.size.y < var_270_4 * manager.ui.mainCameraCom_.aspect / var_270_3.sprite.bounds.size.x and var_270_4 * manager.ui.mainCameraCom_.aspect / var_270_3.sprite.bounds.size.x or var_270_4 / var_270_3.sprite.bounds.size.y, 0)
				end

				for iter_270_0, iter_270_1 in pairs(arg_267_1.bgs_) do
					if iter_270_0 ~= "ST45" then
						iter_270_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_270_5 = 0

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= var_270_5 + arg_270_0 then
				arg_267_1.mask_.enabled = true
				arg_267_1.mask_.raycastTarget = true

				arg_267_1:SetGaussion(false)
			end

			local var_270_6 = 1

			if var_270_5 <= arg_267_1.time_ and arg_267_1.time_ < var_270_5 + var_270_6 then
				local var_270_7 = Color.New(0, 0, 0)

				var_270_7.a = Mathf.Lerp(1, 0, (arg_267_1.time_ - var_270_5) / var_270_6)
				arg_267_1.mask_.color = var_270_7
			end

			if arg_267_1.time_ >= var_270_5 + var_270_6 and arg_267_1.time_ < var_270_5 + var_270_6 + arg_270_0 then
				local var_270_8 = Color.New(0, 0, 0)

				arg_267_1.mask_.enabled = false
				var_270_8.a = 0
				arg_267_1.mask_.color = var_270_8
			end

			if arg_267_1.frameCnt_ <= 1 then
				arg_267_1.dialog_:SetActive(false)
			end

			local var_270_9 = 1
			local var_270_10 = 0.575

			if 1 < arg_267_1.time_ and arg_267_1.time_ <= var_270_9 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0

				arg_267_1.dialog_:SetActive(true)

				arg_267_1.dialogCg_.alpha = 0

				local var_270_11 = LeanTween.value(arg_267_1.dialog_, 0, 1, 0.3)

				var_270_11:setOnUpdate(LuaHelper.FloatAction(function(arg_271_0)
					arg_267_1.dialogCg_.alpha = arg_271_0
				end))
				var_270_11:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_267_1.dialog_)
					var_270_11:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_267_1.duration_ = arg_267_1.duration_ + 0.3

				SetActive(arg_267_1.leftNameGo_, false)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_267_1.iconTrs_.gameObject, false)
				arg_267_1.callingController_:SetSelectedState("normal")

				local var_270_12 = arg_267_1:FormatText(arg_267_1:GetWordFromCfg(1107402068).content)

				arg_267_1.text_.text = var_270_12

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_14 = 23 <= 0 and var_270_10 or var_270_10 * (utf8.len(var_270_12) / 23)

				if (23 <= 0 and var_270_10 or var_270_10 * (utf8.len(var_270_12) / 23)) > 0 and var_270_10 < var_270_14 then
					arg_267_1.talkMaxDuration = var_270_14
					var_270_9 = var_270_9 + 0.3

					if var_270_14 + var_270_9 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_14 + var_270_9
					end
				end

				arg_267_1.text_.text = var_270_12
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)
				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_15 = var_270_9 + 0.3
			local var_270_16 = math.max(var_270_10, arg_267_1.talkMaxDuration)

			if var_270_9 + 0.3 <= arg_267_1.time_ and arg_267_1.time_ < var_270_15 + var_270_16 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - var_270_15) / var_270_16

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= var_270_15 + var_270_16 and arg_267_1.time_ < var_270_15 + var_270_16 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {}

		arg_267_1:InitPlayNodeList()
	end,
	Play1107402069 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 1107402069
		arg_273_1.duration_ = 3

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play1107402070(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 and not isNil(arg_273_1.actors_["1074ui_story"]) and arg_273_1.var_.characterEffect1074ui_story == nil then
				arg_273_1.var_.characterEffect1074ui_story = arg_273_1.actors_["1074ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_276_0 = 0.1

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_0 and not isNil(arg_273_1.actors_["1074ui_story"]) then
				if arg_273_1.var_.characterEffect1074ui_story and not isNil(arg_273_1.actors_["1074ui_story"]) then
					arg_273_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_273_1.time_ >= 0 + var_276_0 and arg_273_1.time_ < 0 + var_276_0 + arg_276_0 and not isNil(arg_273_1.actors_["1074ui_story"]) and arg_273_1.var_.characterEffect1074ui_story then
				arg_273_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_276_2 = arg_273_1.actors_["1074ui_story"].transform

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1.var_.moveOldPos1074ui_story = var_276_2.localPosition

				arg_273_1:ShowWeapon(arg_273_1.var_["1074ui_story" .. "Animator"].transform, false)
			end

			local var_276_3 = 0.001

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_3 then
				var_276_2.localPosition = Vector3.Lerp(arg_273_1.var_.moveOldPos1074ui_story, Vector3.New(0, -1.055, -6.12), (arg_273_1.time_ - 0) / var_276_3)
				var_276_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_276_2.position).x, (manager.ui.mainCamera.transform.position - var_276_2.position).y, (manager.ui.mainCamera.transform.position - var_276_2.position).z)
				var_276_2.localEulerAngles.z = 0
				var_276_2.localEulerAngles.x = 0
				var_276_2.localEulerAngles = var_276_2.localEulerAngles
			end

			if arg_273_1.time_ >= 0 + var_276_3 and arg_273_1.time_ < 0 + var_276_3 + arg_276_0 then
				var_276_2.localPosition = Vector3.New(0, -1.055, -6.12)
				var_276_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_276_2.position).x, (manager.ui.mainCamera.transform.position - var_276_2.position).y, (manager.ui.mainCamera.transform.position - var_276_2.position).z)
				var_276_2.localEulerAngles.z = 0
				var_276_2.localEulerAngles.x = 0
				var_276_2.localEulerAngles = var_276_2.localEulerAngles
			end

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action2_1")
			end

			local var_276_4 = 0
			local var_276_5 = 0.2

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= var_276_4 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, true)

				arg_273_1.leftNameTxt_.text = arg_273_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_6 = arg_273_1:GetWordFromCfg(1107402069)
				local var_276_7 = arg_273_1:FormatText(var_276_6.content)

				arg_273_1.text_.text = var_276_7

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_9 = 8 <= 0 and var_276_5 or var_276_5 * (utf8.len(var_276_7) / 8)

				if (8 <= 0 and var_276_5 or var_276_5 * (utf8.len(var_276_7) / 8)) > 0 and var_276_5 < var_276_9 then
					arg_273_1.talkMaxDuration = var_276_9

					if var_276_9 + var_276_4 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_9 + var_276_4
					end
				end

				arg_273_1.text_.text = var_276_7
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107402", "1107402069", "story_v_side_new_1107402.awb") ~= 0 then
					local var_276_10 = manager.audio:GetVoiceLength("story_v_side_new_1107402", "1107402069", "story_v_side_new_1107402.awb") / 1000

					if var_276_10 + var_276_4 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_10 + var_276_4
					end

					if var_276_6.prefab_name ~= "" and arg_273_1.actors_[var_276_6.prefab_name] ~= nil then
						local var_276_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_273_1.actors_[var_276_6.prefab_name].transform, "story_v_side_new_1107402", "1107402069", "story_v_side_new_1107402.awb")

						arg_273_1:RecordAudio("1107402069", var_276_11)
						arg_273_1:RecordAudio("1107402069", var_276_11)
					else
						arg_273_1:AudioAction("play", "voice", "story_v_side_new_1107402", "1107402069", "story_v_side_new_1107402.awb")
					end

					arg_273_1:RecordHistoryTalkVoice("story_v_side_new_1107402", "1107402069", "story_v_side_new_1107402.awb")
				end

				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_12 = math.max(var_276_5, arg_273_1.talkMaxDuration)

			if var_276_4 <= arg_273_1.time_ and arg_273_1.time_ < var_276_4 + var_276_12 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_4) / var_276_12

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_4 + var_276_12 and arg_273_1.time_ < var_276_4 + var_276_12 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_273_1:InitPlayNodeList()
	end,
	Play1107402070 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 1107402070
		arg_277_1.duration_ = 5

		SetActive(arg_277_1.tipsGo_, false)

		function arg_277_1.onSingleLineFinish_()
			arg_277_1.onSingleLineUpdate_ = nil
			arg_277_1.onSingleLineFinish_ = nil
			arg_277_1.state_ = "waiting"
		end

		function arg_277_1.playNext_(arg_279_0)
			if arg_279_0 == 1 then
				arg_277_0:Play1107402071(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 and not isNil(arg_277_1.actors_["1074ui_story"]) and arg_277_1.var_.characterEffect1074ui_story == nil then
				arg_277_1.var_.characterEffect1074ui_story = arg_277_1.actors_["1074ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_280_0 = 0.1

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_0 and not isNil(arg_277_1.actors_["1074ui_story"]) then
				if arg_277_1.var_.characterEffect1074ui_story and not isNil(arg_277_1.actors_["1074ui_story"]) then
					arg_277_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_277_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_277_1.time_ - 0) / var_280_0)
				end
			end

			if arg_277_1.time_ >= 0 + var_280_0 and arg_277_1.time_ < 0 + var_280_0 + arg_280_0 and not isNil(arg_277_1.actors_["1074ui_story"]) and arg_277_1.var_.characterEffect1074ui_story then
				arg_277_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_277_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			local var_280_1 = 0
			local var_280_2 = 0.55

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= var_280_1 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				arg_277_1.leftNameTxt_.text = arg_277_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, true)
				arg_277_1.iconController_:SetSelectedState("hero")

				arg_277_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_277_1.callingController_:SetSelectedState("normal")

				arg_277_1.keyicon_.color = Color.New(1, 1, 1)
				arg_277_1.icon_.color = Color.New(1, 1, 1)

				local var_280_3 = arg_277_1:FormatText(arg_277_1:GetWordFromCfg(1107402070).content)

				arg_277_1.text_.text = var_280_3

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_5 = 22 <= 0 and var_280_2 or var_280_2 * (utf8.len(var_280_3) / 22)

				if (22 <= 0 and var_280_2 or var_280_2 * (utf8.len(var_280_3) / 22)) > 0 and var_280_2 < var_280_5 then
					arg_277_1.talkMaxDuration = var_280_5

					if var_280_5 + var_280_1 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_5 + var_280_1
					end
				end

				arg_277_1.text_.text = var_280_3
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)
				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_6 = math.max(var_280_2, arg_277_1.talkMaxDuration)

			if var_280_1 <= arg_277_1.time_ and arg_277_1.time_ < var_280_1 + var_280_6 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_1) / var_280_6

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_1 + var_280_6 and arg_277_1.time_ < var_280_1 + var_280_6 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {}

		arg_277_1:InitPlayNodeList()
	end,
	Play1107402071 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 1107402071
		arg_281_1.duration_ = 2.1

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play1107402072(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 and not isNil(arg_281_1.actors_["1074ui_story"]) and arg_281_1.var_.characterEffect1074ui_story == nil then
				arg_281_1.var_.characterEffect1074ui_story = arg_281_1.actors_["1074ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_284_0 = 0.1

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_0 and not isNil(arg_281_1.actors_["1074ui_story"]) then
				if arg_281_1.var_.characterEffect1074ui_story and not isNil(arg_281_1.actors_["1074ui_story"]) then
					arg_281_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_281_1.time_ >= 0 + var_284_0 and arg_281_1.time_ < 0 + var_284_0 + arg_284_0 and not isNil(arg_281_1.actors_["1074ui_story"]) and arg_281_1.var_.characterEffect1074ui_story then
				arg_281_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_284_2 = 0
			local var_284_3 = 0.2

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= var_284_2 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				arg_281_1.leftNameTxt_.text = arg_281_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_4 = arg_281_1:GetWordFromCfg(1107402071)
				local var_284_5 = arg_281_1:FormatText(var_284_4.content)

				arg_281_1.text_.text = var_284_5

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_7 = 8 <= 0 and var_284_3 or var_284_3 * (utf8.len(var_284_5) / 8)

				if (8 <= 0 and var_284_3 or var_284_3 * (utf8.len(var_284_5) / 8)) > 0 and var_284_3 < var_284_7 then
					arg_281_1.talkMaxDuration = var_284_7

					if var_284_7 + var_284_2 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_7 + var_284_2
					end
				end

				arg_281_1.text_.text = var_284_5
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107402", "1107402071", "story_v_side_new_1107402.awb") ~= 0 then
					local var_284_8 = manager.audio:GetVoiceLength("story_v_side_new_1107402", "1107402071", "story_v_side_new_1107402.awb") / 1000

					if var_284_8 + var_284_2 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_8 + var_284_2
					end

					if var_284_4.prefab_name ~= "" and arg_281_1.actors_[var_284_4.prefab_name] ~= nil then
						local var_284_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_281_1.actors_[var_284_4.prefab_name].transform, "story_v_side_new_1107402", "1107402071", "story_v_side_new_1107402.awb")

						arg_281_1:RecordAudio("1107402071", var_284_9)
						arg_281_1:RecordAudio("1107402071", var_284_9)
					else
						arg_281_1:AudioAction("play", "voice", "story_v_side_new_1107402", "1107402071", "story_v_side_new_1107402.awb")
					end

					arg_281_1:RecordHistoryTalkVoice("story_v_side_new_1107402", "1107402071", "story_v_side_new_1107402.awb")
				end

				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_10 = math.max(var_284_3, arg_281_1.talkMaxDuration)

			if var_284_2 <= arg_281_1.time_ and arg_281_1.time_ < var_284_2 + var_284_10 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_2) / var_284_10

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_2 + var_284_10 and arg_281_1.time_ < var_284_2 + var_284_10 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {}

		arg_281_1:InitPlayNodeList()
	end,
	Play1107402072 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 1107402072
		arg_285_1.duration_ = 5

		SetActive(arg_285_1.tipsGo_, false)

		function arg_285_1.onSingleLineFinish_()
			arg_285_1.onSingleLineUpdate_ = nil
			arg_285_1.onSingleLineFinish_ = nil
			arg_285_1.state_ = "waiting"
		end

		function arg_285_1.playNext_(arg_287_0)
			if arg_287_0 == 1 then
				arg_285_0:Play1107402073(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 and not isNil(arg_285_1.actors_["1074ui_story"]) and arg_285_1.var_.characterEffect1074ui_story == nil then
				arg_285_1.var_.characterEffect1074ui_story = arg_285_1.actors_["1074ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_288_0 = 0.1

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_0 and not isNil(arg_285_1.actors_["1074ui_story"]) then
				if arg_285_1.var_.characterEffect1074ui_story and not isNil(arg_285_1.actors_["1074ui_story"]) then
					arg_285_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_285_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_285_1.time_ - 0) / var_288_0)
				end
			end

			if arg_285_1.time_ >= 0 + var_288_0 and arg_285_1.time_ < 0 + var_288_0 + arg_288_0 and not isNil(arg_285_1.actors_["1074ui_story"]) and arg_285_1.var_.characterEffect1074ui_story then
				arg_285_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_285_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			local var_288_1 = 0
			local var_288_2 = 0.825

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= var_288_1 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, false)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_3 = arg_285_1:FormatText(arg_285_1:GetWordFromCfg(1107402072).content)

				arg_285_1.text_.text = var_288_3

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_5 = 33 <= 0 and var_288_2 or var_288_2 * (utf8.len(var_288_3) / 33)

				if (33 <= 0 and var_288_2 or var_288_2 * (utf8.len(var_288_3) / 33)) > 0 and var_288_2 < var_288_5 then
					arg_285_1.talkMaxDuration = var_288_5

					if var_288_5 + var_288_1 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_5 + var_288_1
					end
				end

				arg_285_1.text_.text = var_288_3
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)
				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_6 = math.max(var_288_2, arg_285_1.talkMaxDuration)

			if var_288_1 <= arg_285_1.time_ and arg_285_1.time_ < var_288_1 + var_288_6 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_1) / var_288_6

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_1 + var_288_6 and arg_285_1.time_ < var_288_1 + var_288_6 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {}

		arg_285_1:InitPlayNodeList()
	end,
	Play1107402073 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 1107402073
		arg_289_1.duration_ = 5

		SetActive(arg_289_1.tipsGo_, false)

		function arg_289_1.onSingleLineFinish_()
			arg_289_1.onSingleLineUpdate_ = nil
			arg_289_1.onSingleLineFinish_ = nil
			arg_289_1.state_ = "waiting"
		end

		function arg_289_1.playNext_(arg_291_0)
			if arg_291_0 == 1 then
				arg_289_0:Play1107402074(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			local var_292_0 = 0.45

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, true)

				arg_289_1.leftNameTxt_.text = arg_289_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, true)
				arg_289_1.iconController_:SetSelectedState("hero")

				arg_289_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_289_1.callingController_:SetSelectedState("normal")

				arg_289_1.keyicon_.color = Color.New(1, 1, 1)
				arg_289_1.icon_.color = Color.New(1, 1, 1)

				local var_292_1 = arg_289_1:FormatText(arg_289_1:GetWordFromCfg(1107402073).content)

				arg_289_1.text_.text = var_292_1

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_3 = 18 <= 0 and var_292_0 or var_292_0 * (utf8.len(var_292_1) / 18)

				if (18 <= 0 and var_292_0 or var_292_0 * (utf8.len(var_292_1) / 18)) > 0 and var_292_0 < var_292_3 then
					arg_289_1.talkMaxDuration = var_292_3

					if var_292_3 + 0 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_3 + 0
					end
				end

				arg_289_1.text_.text = var_292_1
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)
				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_4 = math.max(var_292_0, arg_289_1.talkMaxDuration)

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_4 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - 0) / var_292_4

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= 0 + var_292_4 and arg_289_1.time_ < 0 + var_292_4 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {}

		arg_289_1:InitPlayNodeList()
	end,
	Play1107402074 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 1107402074
		arg_293_1.duration_ = 2

		SetActive(arg_293_1.tipsGo_, false)

		function arg_293_1.onSingleLineFinish_()
			arg_293_1.onSingleLineUpdate_ = nil
			arg_293_1.onSingleLineFinish_ = nil
			arg_293_1.state_ = "waiting"
		end

		function arg_293_1.playNext_(arg_295_0)
			if arg_295_0 == 1 then
				arg_293_0:Play1107402075(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 and not isNil(arg_293_1.actors_["1074ui_story"]) and arg_293_1.var_.characterEffect1074ui_story == nil then
				arg_293_1.var_.characterEffect1074ui_story = arg_293_1.actors_["1074ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_296_0 = 0.1

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_0 and not isNil(arg_293_1.actors_["1074ui_story"]) then
				if arg_293_1.var_.characterEffect1074ui_story and not isNil(arg_293_1.actors_["1074ui_story"]) then
					arg_293_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_293_1.time_ >= 0 + var_296_0 and arg_293_1.time_ < 0 + var_296_0 + arg_296_0 and not isNil(arg_293_1.actors_["1074ui_story"]) and arg_293_1.var_.characterEffect1074ui_story then
				arg_293_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_296_2 = arg_293_1.actors_["1074ui_story"].transform

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1.var_.moveOldPos1074ui_story = var_296_2.localPosition

				arg_293_1:ShowWeapon(arg_293_1.var_["1074ui_story" .. "Animator"].transform, false)
			end

			local var_296_3 = 0.001

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_3 then
				var_296_2.localPosition = Vector3.Lerp(arg_293_1.var_.moveOldPos1074ui_story, Vector3.New(0, -1.055, -6.12), (arg_293_1.time_ - 0) / var_296_3)
				var_296_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_296_2.position).x, (manager.ui.mainCamera.transform.position - var_296_2.position).y, (manager.ui.mainCamera.transform.position - var_296_2.position).z)
				var_296_2.localEulerAngles.z = 0
				var_296_2.localEulerAngles.x = 0
				var_296_2.localEulerAngles = var_296_2.localEulerAngles
			end

			if arg_293_1.time_ >= 0 + var_296_3 and arg_293_1.time_ < 0 + var_296_3 + arg_296_0 then
				var_296_2.localPosition = Vector3.New(0, -1.055, -6.12)
				var_296_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_296_2.position).x, (manager.ui.mainCamera.transform.position - var_296_2.position).y, (manager.ui.mainCamera.transform.position - var_296_2.position).z)
				var_296_2.localEulerAngles.z = 0
				var_296_2.localEulerAngles.x = 0
				var_296_2.localEulerAngles = var_296_2.localEulerAngles
			end

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action2_2")
			end

			local var_296_4 = 0
			local var_296_5 = 0.1

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= var_296_4 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, true)

				arg_293_1.leftNameTxt_.text = arg_293_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_293_1.leftNameTxt_.transform)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1.leftNameTxt_.text)
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_6 = arg_293_1:GetWordFromCfg(1107402074)
				local var_296_7 = arg_293_1:FormatText(var_296_6.content)

				arg_293_1.text_.text = var_296_7

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_9 = 4 <= 0 and var_296_5 or var_296_5 * (utf8.len(var_296_7) / 4)

				if (4 <= 0 and var_296_5 or var_296_5 * (utf8.len(var_296_7) / 4)) > 0 and var_296_5 < var_296_9 then
					arg_293_1.talkMaxDuration = var_296_9

					if var_296_9 + var_296_4 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_9 + var_296_4
					end
				end

				arg_293_1.text_.text = var_296_7
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107402", "1107402074", "story_v_side_new_1107402.awb") ~= 0 then
					local var_296_10 = manager.audio:GetVoiceLength("story_v_side_new_1107402", "1107402074", "story_v_side_new_1107402.awb") / 1000

					if var_296_10 + var_296_4 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_10 + var_296_4
					end

					if var_296_6.prefab_name ~= "" and arg_293_1.actors_[var_296_6.prefab_name] ~= nil then
						local var_296_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_293_1.actors_[var_296_6.prefab_name].transform, "story_v_side_new_1107402", "1107402074", "story_v_side_new_1107402.awb")

						arg_293_1:RecordAudio("1107402074", var_296_11)
						arg_293_1:RecordAudio("1107402074", var_296_11)
					else
						arg_293_1:AudioAction("play", "voice", "story_v_side_new_1107402", "1107402074", "story_v_side_new_1107402.awb")
					end

					arg_293_1:RecordHistoryTalkVoice("story_v_side_new_1107402", "1107402074", "story_v_side_new_1107402.awb")
				end

				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_12 = math.max(var_296_5, arg_293_1.talkMaxDuration)

			if var_296_4 <= arg_293_1.time_ and arg_293_1.time_ < var_296_4 + var_296_12 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_4) / var_296_12

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_4 + var_296_12 and arg_293_1.time_ < var_296_4 + var_296_12 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_293_1:InitPlayNodeList()
	end,
	Play1107402075 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 1107402075
		arg_297_1.duration_ = 5

		SetActive(arg_297_1.tipsGo_, false)

		function arg_297_1.onSingleLineFinish_()
			arg_297_1.onSingleLineUpdate_ = nil
			arg_297_1.onSingleLineFinish_ = nil
			arg_297_1.state_ = "waiting"
		end

		function arg_297_1.playNext_(arg_299_0)
			if arg_299_0 == 1 then
				arg_297_0:Play1107402076(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 and not isNil(arg_297_1.actors_["1074ui_story"]) and arg_297_1.var_.characterEffect1074ui_story == nil then
				arg_297_1.var_.characterEffect1074ui_story = arg_297_1.actors_["1074ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_300_0 = 0.1

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_0 and not isNil(arg_297_1.actors_["1074ui_story"]) then
				if arg_297_1.var_.characterEffect1074ui_story and not isNil(arg_297_1.actors_["1074ui_story"]) then
					arg_297_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_297_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_297_1.time_ - 0) / var_300_0)
				end
			end

			if arg_297_1.time_ >= 0 + var_300_0 and arg_297_1.time_ < 0 + var_300_0 + arg_300_0 and not isNil(arg_297_1.actors_["1074ui_story"]) and arg_297_1.var_.characterEffect1074ui_story then
				arg_297_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_297_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			local var_300_1 = 0
			local var_300_2 = 0.575

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= var_300_1 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, true)

				arg_297_1.leftNameTxt_.text = arg_297_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_297_1.leftNameTxt_.transform)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1.leftNameTxt_.text)
				SetActive(arg_297_1.iconTrs_.gameObject, true)
				arg_297_1.iconController_:SetSelectedState("hero")

				arg_297_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_297_1.callingController_:SetSelectedState("normal")

				arg_297_1.keyicon_.color = Color.New(1, 1, 1)
				arg_297_1.icon_.color = Color.New(1, 1, 1)

				local var_300_3 = arg_297_1:FormatText(arg_297_1:GetWordFromCfg(1107402075).content)

				arg_297_1.text_.text = var_300_3

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_5 = 23 <= 0 and var_300_2 or var_300_2 * (utf8.len(var_300_3) / 23)

				if (23 <= 0 and var_300_2 or var_300_2 * (utf8.len(var_300_3) / 23)) > 0 and var_300_2 < var_300_5 then
					arg_297_1.talkMaxDuration = var_300_5

					if var_300_5 + var_300_1 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_5 + var_300_1
					end
				end

				arg_297_1.text_.text = var_300_3
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)
				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_6 = math.max(var_300_2, arg_297_1.talkMaxDuration)

			if var_300_1 <= arg_297_1.time_ and arg_297_1.time_ < var_300_1 + var_300_6 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_1) / var_300_6

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_1 + var_300_6 and arg_297_1.time_ < var_300_1 + var_300_6 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {}

		arg_297_1:InitPlayNodeList()
	end,
	Play1107402076 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 1107402076
		arg_301_1.duration_ = 1.77

		SetActive(arg_301_1.tipsGo_, false)

		function arg_301_1.onSingleLineFinish_()
			arg_301_1.onSingleLineUpdate_ = nil
			arg_301_1.onSingleLineFinish_ = nil
			arg_301_1.state_ = "waiting"
		end

		function arg_301_1.playNext_(arg_303_0)
			if arg_303_0 == 1 then
				arg_301_0:Play1107402077(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 and not isNil(arg_301_1.actors_["1074ui_story"]) and arg_301_1.var_.characterEffect1074ui_story == nil then
				arg_301_1.var_.characterEffect1074ui_story = arg_301_1.actors_["1074ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_304_0 = 0.1

			if 0 <= arg_301_1.time_ and arg_301_1.time_ < 0 + var_304_0 and not isNil(arg_301_1.actors_["1074ui_story"]) then
				if arg_301_1.var_.characterEffect1074ui_story and not isNil(arg_301_1.actors_["1074ui_story"]) then
					arg_301_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_301_1.time_ >= 0 + var_304_0 and arg_301_1.time_ < 0 + var_304_0 + arg_304_0 and not isNil(arg_301_1.actors_["1074ui_story"]) and arg_301_1.var_.characterEffect1074ui_story then
				arg_301_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_304_2 = 0
			local var_304_3 = 0.2

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= var_304_2 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, true)

				arg_301_1.leftNameTxt_.text = arg_301_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_301_1.leftNameTxt_.transform)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1.leftNameTxt_.text)
				SetActive(arg_301_1.iconTrs_.gameObject, false)
				arg_301_1.callingController_:SetSelectedState("normal")

				local var_304_4 = arg_301_1:GetWordFromCfg(1107402076)
				local var_304_5 = arg_301_1:FormatText(var_304_4.content)

				arg_301_1.text_.text = var_304_5

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_7 = 8 <= 0 and var_304_3 or var_304_3 * (utf8.len(var_304_5) / 8)

				if (8 <= 0 and var_304_3 or var_304_3 * (utf8.len(var_304_5) / 8)) > 0 and var_304_3 < var_304_7 then
					arg_301_1.talkMaxDuration = var_304_7

					if var_304_7 + var_304_2 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_7 + var_304_2
					end
				end

				arg_301_1.text_.text = var_304_5
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107402", "1107402076", "story_v_side_new_1107402.awb") ~= 0 then
					local var_304_8 = manager.audio:GetVoiceLength("story_v_side_new_1107402", "1107402076", "story_v_side_new_1107402.awb") / 1000

					if var_304_8 + var_304_2 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_8 + var_304_2
					end

					if var_304_4.prefab_name ~= "" and arg_301_1.actors_[var_304_4.prefab_name] ~= nil then
						local var_304_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_301_1.actors_[var_304_4.prefab_name].transform, "story_v_side_new_1107402", "1107402076", "story_v_side_new_1107402.awb")

						arg_301_1:RecordAudio("1107402076", var_304_9)
						arg_301_1:RecordAudio("1107402076", var_304_9)
					else
						arg_301_1:AudioAction("play", "voice", "story_v_side_new_1107402", "1107402076", "story_v_side_new_1107402.awb")
					end

					arg_301_1:RecordHistoryTalkVoice("story_v_side_new_1107402", "1107402076", "story_v_side_new_1107402.awb")
				end

				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_10 = math.max(var_304_3, arg_301_1.talkMaxDuration)

			if var_304_2 <= arg_301_1.time_ and arg_301_1.time_ < var_304_2 + var_304_10 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - var_304_2) / var_304_10

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= var_304_2 + var_304_10 and arg_301_1.time_ < var_304_2 + var_304_10 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {}

		arg_301_1:InitPlayNodeList()
	end,
	Play1107402077 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 1107402077
		arg_305_1.duration_ = 4.5

		SetActive(arg_305_1.tipsGo_, false)

		function arg_305_1.onSingleLineFinish_()
			arg_305_1.onSingleLineUpdate_ = nil
			arg_305_1.onSingleLineFinish_ = nil
			arg_305_1.state_ = "waiting"
		end

		function arg_305_1.playNext_(arg_307_0)
			if arg_307_0 == 1 then
				arg_305_0:Play1107402078(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			local var_308_0 = 0.55

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, true)

				arg_305_1.leftNameTxt_.text = arg_305_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_305_1.leftNameTxt_.transform)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1.leftNameTxt_.text)
				SetActive(arg_305_1.iconTrs_.gameObject, false)
				arg_305_1.callingController_:SetSelectedState("normal")

				local var_308_1 = arg_305_1:GetWordFromCfg(1107402077)
				local var_308_2 = arg_305_1:FormatText(var_308_1.content)

				arg_305_1.text_.text = var_308_2

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_4 = 22 <= 0 and var_308_0 or var_308_0 * (utf8.len(var_308_2) / 22)

				if (22 <= 0 and var_308_0 or var_308_0 * (utf8.len(var_308_2) / 22)) > 0 and var_308_0 < var_308_4 then
					arg_305_1.talkMaxDuration = var_308_4

					if var_308_4 + 0 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_4 + 0
					end
				end

				arg_305_1.text_.text = var_308_2
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107402", "1107402077", "story_v_side_new_1107402.awb") ~= 0 then
					local var_308_5 = manager.audio:GetVoiceLength("story_v_side_new_1107402", "1107402077", "story_v_side_new_1107402.awb") / 1000

					if var_308_5 + 0 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_5 + 0
					end

					if var_308_1.prefab_name ~= "" and arg_305_1.actors_[var_308_1.prefab_name] ~= nil then
						local var_308_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_305_1.actors_[var_308_1.prefab_name].transform, "story_v_side_new_1107402", "1107402077", "story_v_side_new_1107402.awb")

						arg_305_1:RecordAudio("1107402077", var_308_6)
						arg_305_1:RecordAudio("1107402077", var_308_6)
					else
						arg_305_1:AudioAction("play", "voice", "story_v_side_new_1107402", "1107402077", "story_v_side_new_1107402.awb")
					end

					arg_305_1:RecordHistoryTalkVoice("story_v_side_new_1107402", "1107402077", "story_v_side_new_1107402.awb")
				end

				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_7 = math.max(var_308_0, arg_305_1.talkMaxDuration)

			if 0 <= arg_305_1.time_ and arg_305_1.time_ < 0 + var_308_7 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - 0) / var_308_7

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= 0 + var_308_7 and arg_305_1.time_ < 0 + var_308_7 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {}

		arg_305_1:InitPlayNodeList()
	end,
	Play1107402078 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 1107402078
		arg_309_1.duration_ = 8.53

		SetActive(arg_309_1.tipsGo_, false)

		function arg_309_1.onSingleLineFinish_()
			arg_309_1.onSingleLineUpdate_ = nil
			arg_309_1.onSingleLineFinish_ = nil
			arg_309_1.state_ = "waiting"
		end

		function arg_309_1.playNext_(arg_311_0)
			if arg_311_0 == 1 then
				arg_309_0:Play1107402079(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			local var_312_0 = 0.975

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, true)

				arg_309_1.leftNameTxt_.text = arg_309_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_309_1.leftNameTxt_.transform)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1.leftNameTxt_.text)
				SetActive(arg_309_1.iconTrs_.gameObject, false)
				arg_309_1.callingController_:SetSelectedState("normal")

				local var_312_1 = arg_309_1:GetWordFromCfg(1107402078)
				local var_312_2 = arg_309_1:FormatText(var_312_1.content)

				arg_309_1.text_.text = var_312_2

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_4 = 39 <= 0 and var_312_0 or var_312_0 * (utf8.len(var_312_2) / 39)

				if (39 <= 0 and var_312_0 or var_312_0 * (utf8.len(var_312_2) / 39)) > 0 and var_312_0 < var_312_4 then
					arg_309_1.talkMaxDuration = var_312_4

					if var_312_4 + 0 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_4 + 0
					end
				end

				arg_309_1.text_.text = var_312_2
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107402", "1107402078", "story_v_side_new_1107402.awb") ~= 0 then
					local var_312_5 = manager.audio:GetVoiceLength("story_v_side_new_1107402", "1107402078", "story_v_side_new_1107402.awb") / 1000

					if var_312_5 + 0 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_5 + 0
					end

					if var_312_1.prefab_name ~= "" and arg_309_1.actors_[var_312_1.prefab_name] ~= nil then
						local var_312_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_309_1.actors_[var_312_1.prefab_name].transform, "story_v_side_new_1107402", "1107402078", "story_v_side_new_1107402.awb")

						arg_309_1:RecordAudio("1107402078", var_312_6)
						arg_309_1:RecordAudio("1107402078", var_312_6)
					else
						arg_309_1:AudioAction("play", "voice", "story_v_side_new_1107402", "1107402078", "story_v_side_new_1107402.awb")
					end

					arg_309_1:RecordHistoryTalkVoice("story_v_side_new_1107402", "1107402078", "story_v_side_new_1107402.awb")
				end

				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_7 = math.max(var_312_0, arg_309_1.talkMaxDuration)

			if 0 <= arg_309_1.time_ and arg_309_1.time_ < 0 + var_312_7 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - 0) / var_312_7

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= 0 + var_312_7 and arg_309_1.time_ < 0 + var_312_7 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {}

		arg_309_1:InitPlayNodeList()
	end,
	Play1107402079 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 1107402079
		arg_313_1.duration_ = 5

		SetActive(arg_313_1.tipsGo_, false)

		function arg_313_1.onSingleLineFinish_()
			arg_313_1.onSingleLineUpdate_ = nil
			arg_313_1.onSingleLineFinish_ = nil
			arg_313_1.state_ = "waiting"
		end

		function arg_313_1.playNext_(arg_315_0)
			if arg_315_0 == 1 then
				arg_313_0:Play1107402080(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 and not isNil(arg_313_1.actors_["1074ui_story"]) and arg_313_1.var_.characterEffect1074ui_story == nil then
				arg_313_1.var_.characterEffect1074ui_story = arg_313_1.actors_["1074ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_316_0 = 0.1

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_0 and not isNil(arg_313_1.actors_["1074ui_story"]) then
				if arg_313_1.var_.characterEffect1074ui_story and not isNil(arg_313_1.actors_["1074ui_story"]) then
					arg_313_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_313_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_313_1.time_ - 0) / var_316_0)
				end
			end

			if arg_313_1.time_ >= 0 + var_316_0 and arg_313_1.time_ < 0 + var_316_0 + arg_316_0 and not isNil(arg_313_1.actors_["1074ui_story"]) and arg_313_1.var_.characterEffect1074ui_story then
				arg_313_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_313_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			local var_316_1 = 0
			local var_316_2 = 0.425

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= var_316_1 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, true)

				arg_313_1.leftNameTxt_.text = arg_313_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_313_1.leftNameTxt_.transform)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1.leftNameTxt_.text)
				SetActive(arg_313_1.iconTrs_.gameObject, true)
				arg_313_1.iconController_:SetSelectedState("hero")

				arg_313_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_313_1.callingController_:SetSelectedState("normal")

				arg_313_1.keyicon_.color = Color.New(1, 1, 1)
				arg_313_1.icon_.color = Color.New(1, 1, 1)

				local var_316_3 = arg_313_1:FormatText(arg_313_1:GetWordFromCfg(1107402079).content)

				arg_313_1.text_.text = var_316_3

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_5 = 17 <= 0 and var_316_2 or var_316_2 * (utf8.len(var_316_3) / 17)

				if (17 <= 0 and var_316_2 or var_316_2 * (utf8.len(var_316_3) / 17)) > 0 and var_316_2 < var_316_5 then
					arg_313_1.talkMaxDuration = var_316_5

					if var_316_5 + var_316_1 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_5 + var_316_1
					end
				end

				arg_313_1.text_.text = var_316_3
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)
				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_6 = math.max(var_316_2, arg_313_1.talkMaxDuration)

			if var_316_1 <= arg_313_1.time_ and arg_313_1.time_ < var_316_1 + var_316_6 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_1) / var_316_6

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_1 + var_316_6 and arg_313_1.time_ < var_316_1 + var_316_6 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {}

		arg_313_1:InitPlayNodeList()
	end,
	Play1107402080 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 1107402080
		arg_317_1.duration_ = 5

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play1107402081(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			local var_320_0 = 0.925

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 then
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

				arg_317_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_317_1.callingController_:SetSelectedState("normal")

				arg_317_1.keyicon_.color = Color.New(1, 1, 1)
				arg_317_1.icon_.color = Color.New(1, 1, 1)

				local var_320_1 = arg_317_1:FormatText(arg_317_1:GetWordFromCfg(1107402080).content)

				arg_317_1.text_.text = var_320_1

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_3 = 37 <= 0 and var_320_0 or var_320_0 * (utf8.len(var_320_1) / 37)

				if (37 <= 0 and var_320_0 or var_320_0 * (utf8.len(var_320_1) / 37)) > 0 and var_320_0 < var_320_3 then
					arg_317_1.talkMaxDuration = var_320_3

					if var_320_3 + 0 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_3 + 0
					end
				end

				arg_317_1.text_.text = var_320_1
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)
				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_4 = math.max(var_320_0, arg_317_1.talkMaxDuration)

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_4 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - 0) / var_320_4

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= 0 + var_320_4 and arg_317_1.time_ < 0 + var_320_4 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {}

		arg_317_1:InitPlayNodeList()
	end,
	Play1107402081 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 1107402081
		arg_321_1.duration_ = 2.3

		SetActive(arg_321_1.tipsGo_, false)

		function arg_321_1.onSingleLineFinish_()
			arg_321_1.onSingleLineUpdate_ = nil
			arg_321_1.onSingleLineFinish_ = nil
			arg_321_1.state_ = "waiting"
		end

		function arg_321_1.playNext_(arg_323_0)
			if arg_323_0 == 1 then
				arg_321_0:Play1107402082(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 and not isNil(arg_321_1.actors_["1074ui_story"]) and arg_321_1.var_.characterEffect1074ui_story == nil then
				arg_321_1.var_.characterEffect1074ui_story = arg_321_1.actors_["1074ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_324_0 = 0.1

			if 0 <= arg_321_1.time_ and arg_321_1.time_ < 0 + var_324_0 and not isNil(arg_321_1.actors_["1074ui_story"]) then
				if arg_321_1.var_.characterEffect1074ui_story and not isNil(arg_321_1.actors_["1074ui_story"]) then
					arg_321_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_321_1.time_ >= 0 + var_324_0 and arg_321_1.time_ < 0 + var_324_0 + arg_324_0 and not isNil(arg_321_1.actors_["1074ui_story"]) and arg_321_1.var_.characterEffect1074ui_story then
				arg_321_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_324_2 = 0
			local var_324_3 = 0.15

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= var_324_2 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, true)

				arg_321_1.leftNameTxt_.text = arg_321_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_321_1.leftNameTxt_.transform)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1.leftNameTxt_.text)
				SetActive(arg_321_1.iconTrs_.gameObject, false)
				arg_321_1.callingController_:SetSelectedState("normal")

				local var_324_4 = arg_321_1:GetWordFromCfg(1107402081)
				local var_324_5 = arg_321_1:FormatText(var_324_4.content)

				arg_321_1.text_.text = var_324_5

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_7 = 6 <= 0 and var_324_3 or var_324_3 * (utf8.len(var_324_5) / 6)

				if (6 <= 0 and var_324_3 or var_324_3 * (utf8.len(var_324_5) / 6)) > 0 and var_324_3 < var_324_7 then
					arg_321_1.talkMaxDuration = var_324_7

					if var_324_7 + var_324_2 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_7 + var_324_2
					end
				end

				arg_321_1.text_.text = var_324_5
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107402", "1107402081", "story_v_side_new_1107402.awb") ~= 0 then
					local var_324_8 = manager.audio:GetVoiceLength("story_v_side_new_1107402", "1107402081", "story_v_side_new_1107402.awb") / 1000

					if var_324_8 + var_324_2 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_8 + var_324_2
					end

					if var_324_4.prefab_name ~= "" and arg_321_1.actors_[var_324_4.prefab_name] ~= nil then
						local var_324_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_321_1.actors_[var_324_4.prefab_name].transform, "story_v_side_new_1107402", "1107402081", "story_v_side_new_1107402.awb")

						arg_321_1:RecordAudio("1107402081", var_324_9)
						arg_321_1:RecordAudio("1107402081", var_324_9)
					else
						arg_321_1:AudioAction("play", "voice", "story_v_side_new_1107402", "1107402081", "story_v_side_new_1107402.awb")
					end

					arg_321_1:RecordHistoryTalkVoice("story_v_side_new_1107402", "1107402081", "story_v_side_new_1107402.awb")
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
	Play1107402082 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 1107402082
		arg_325_1.duration_ = 6.78

		SetActive(arg_325_1.tipsGo_, false)

		function arg_325_1.onSingleLineFinish_()
			arg_325_1.onSingleLineUpdate_ = nil
			arg_325_1.onSingleLineFinish_ = nil
			arg_325_1.state_ = "waiting"
		end

		function arg_325_1.playNext_(arg_327_0)
			if arg_327_0 == 1 then
				arg_325_0:Play1107402083(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			if 1.03333333333333 < arg_325_1.time_ and arg_325_1.time_ <= 1.03333333333333 + arg_328_0 then
				arg_325_1.allBtn_.enabled = false
			end

			if arg_325_1.time_ >= 1.03333333333333 + 0.633333333333333 and arg_325_1.time_ < 1.03333333333333 + 0.633333333333333 + arg_328_0 then
				arg_325_1.allBtn_.enabled = true
			end

			if 1 < arg_325_1.time_ and arg_325_1.time_ <= 1 + arg_328_0 then
				local var_328_0 = arg_325_1.bgs_.ST45

				arg_325_1.bgs_.ST45.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_328_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_328_1 = var_328_0:GetComponent("SpriteRenderer")

				if var_328_1 and var_328_1.sprite then
					local var_328_2 = 2 * (var_328_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_328_0.transform.localScale = Vector3.New(var_328_2 / var_328_1.sprite.bounds.size.y < var_328_2 * manager.ui.mainCameraCom_.aspect / var_328_1.sprite.bounds.size.x and var_328_2 * manager.ui.mainCameraCom_.aspect / var_328_1.sprite.bounds.size.x or var_328_2 / var_328_1.sprite.bounds.size.y, var_328_2 / var_328_1.sprite.bounds.size.y < var_328_2 * manager.ui.mainCameraCom_.aspect / var_328_1.sprite.bounds.size.x and var_328_2 * manager.ui.mainCameraCom_.aspect / var_328_1.sprite.bounds.size.x or var_328_2 / var_328_1.sprite.bounds.size.y, 0)
				end

				for iter_328_0, iter_328_1 in pairs(arg_325_1.bgs_) do
					if iter_328_0 ~= "ST45" then
						iter_328_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_328_3 = 0

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= var_328_3 + arg_328_0 then
				arg_325_1.mask_.enabled = true
				arg_325_1.mask_.raycastTarget = true

				arg_325_1:SetGaussion(false)
			end

			local var_328_4 = 1

			if var_328_3 <= arg_325_1.time_ and arg_325_1.time_ < var_328_3 + var_328_4 then
				local var_328_5 = Color.New(0, 0, 0)

				var_328_5.a = Mathf.Lerp(0, 1, (arg_325_1.time_ - var_328_3) / var_328_4)
				arg_325_1.mask_.color = var_328_5
			end

			if arg_325_1.time_ >= var_328_3 + var_328_4 and arg_325_1.time_ < var_328_3 + var_328_4 + arg_328_0 then
				local var_328_6 = Color.New(0, 0, 0)

				var_328_6.a = 1
				arg_325_1.mask_.color = var_328_6
			end

			local var_328_7 = 1

			if 1 < arg_325_1.time_ and arg_325_1.time_ <= var_328_7 + arg_328_0 then
				arg_325_1.mask_.enabled = true
				arg_325_1.mask_.raycastTarget = true

				arg_325_1:SetGaussion(false)
			end

			local var_328_8 = 1

			if var_328_7 <= arg_325_1.time_ and arg_325_1.time_ < var_328_7 + var_328_8 then
				local var_328_9 = Color.New(0, 0, 0)

				var_328_9.a = Mathf.Lerp(1, 0, (arg_325_1.time_ - var_328_7) / var_328_8)
				arg_325_1.mask_.color = var_328_9
			end

			if arg_325_1.time_ >= var_328_7 + var_328_8 and arg_325_1.time_ < var_328_7 + var_328_8 + arg_328_0 then
				local var_328_10 = Color.New(0, 0, 0)

				arg_325_1.mask_.enabled = false
				var_328_10.a = 0
				arg_325_1.mask_.color = var_328_10
			end

			local var_328_11 = arg_325_1.actors_["1074ui_story"].transform

			if 0.966 < arg_325_1.time_ and arg_325_1.time_ <= 0.966 + arg_328_0 then
				arg_325_1.var_.moveOldPos1074ui_story = var_328_11.localPosition

				arg_325_1:ShowWeapon(arg_325_1.var_["1074ui_story" .. "Animator"].transform, false)
			end

			local var_328_12 = 0.001

			if 0.966 <= arg_325_1.time_ and arg_325_1.time_ < 0.966 + var_328_12 then
				var_328_11.localPosition = Vector3.Lerp(arg_325_1.var_.moveOldPos1074ui_story, Vector3.New(0, 100, 0), (arg_325_1.time_ - 0.966) / var_328_12)
				var_328_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_328_11.position).x, (manager.ui.mainCamera.transform.position - var_328_11.position).y, (manager.ui.mainCamera.transform.position - var_328_11.position).z)
				var_328_11.localEulerAngles.z = 0
				var_328_11.localEulerAngles.x = 0
				var_328_11.localEulerAngles = var_328_11.localEulerAngles
			end

			if arg_325_1.time_ >= 0.966 + var_328_12 and arg_325_1.time_ < 0.966 + var_328_12 + arg_328_0 then
				var_328_11.localPosition = Vector3.New(0, 100, 0)
				var_328_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_328_11.position).x, (manager.ui.mainCamera.transform.position - var_328_11.position).y, (manager.ui.mainCamera.transform.position - var_328_11.position).z)
				var_328_11.localEulerAngles.z = 0
				var_328_11.localEulerAngles.x = 0
				var_328_11.localEulerAngles = var_328_11.localEulerAngles
			end

			if arg_325_1.frameCnt_ <= 1 then
				arg_325_1.dialog_:SetActive(false)
			end

			local var_328_13 = 1.775
			local var_328_14 = 0.225

			if 1.775 < arg_325_1.time_ and arg_325_1.time_ <= var_328_13 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0

				arg_325_1.dialog_:SetActive(true)

				arg_325_1.dialogCg_.alpha = 0

				local var_328_15 = LeanTween.value(arg_325_1.dialog_, 0, 1, 0.3)

				var_328_15:setOnUpdate(LuaHelper.FloatAction(function(arg_329_0)
					arg_325_1.dialogCg_.alpha = arg_329_0
				end))
				var_328_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_325_1.dialog_)
					var_328_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_325_1.duration_ = arg_325_1.duration_ + 0.3

				SetActive(arg_325_1.leftNameGo_, true)

				arg_325_1.leftNameTxt_.text = arg_325_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_325_1.leftNameTxt_.transform)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1.leftNameTxt_.text)
				SetActive(arg_325_1.iconTrs_.gameObject, true)
				arg_325_1.iconController_:SetSelectedState("hero")

				arg_325_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_325_1.callingController_:SetSelectedState("normal")

				arg_325_1.keyicon_.color = Color.New(1, 1, 1)
				arg_325_1.icon_.color = Color.New(1, 1, 1)

				local var_328_16 = arg_325_1:FormatText(arg_325_1:GetWordFromCfg(1107402082).content)

				arg_325_1.text_.text = var_328_16

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_18 = 9 <= 0 and var_328_14 or var_328_14 * (utf8.len(var_328_16) / 9)

				if (9 <= 0 and var_328_14 or var_328_14 * (utf8.len(var_328_16) / 9)) > 0 and var_328_14 < var_328_18 then
					arg_325_1.talkMaxDuration = var_328_18
					var_328_13 = var_328_13 + 0.3

					if var_328_18 + var_328_13 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_18 + var_328_13
					end
				end

				arg_325_1.text_.text = var_328_16
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)
				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_19 = var_328_13 + 0.3
			local var_328_20 = math.max(var_328_14, arg_325_1.talkMaxDuration)

			if var_328_13 + 0.3 <= arg_325_1.time_ and arg_325_1.time_ < var_328_19 + var_328_20 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - var_328_19) / var_328_20

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= var_328_19 + var_328_20 and arg_325_1.time_ < var_328_19 + var_328_20 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_325_1:InitPlayNodeList()
	end,
	Play1107402083 = function(arg_331_0, arg_331_1)
		arg_331_1.time_ = 0
		arg_331_1.frameCnt_ = 0
		arg_331_1.state_ = "playing"
		arg_331_1.curTalkId_ = 1107402083
		arg_331_1.duration_ = 6.03

		SetActive(arg_331_1.tipsGo_, false)

		function arg_331_1.onSingleLineFinish_()
			arg_331_1.onSingleLineUpdate_ = nil
			arg_331_1.onSingleLineFinish_ = nil
			arg_331_1.state_ = "waiting"
		end

		function arg_331_1.playNext_(arg_333_0)
			if arg_333_0 == 1 then
				arg_331_0:Play1107402084(arg_331_1)
			end
		end

		function arg_331_1.onSingleLineUpdate_(arg_334_0)
			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 and not isNil(arg_331_1.actors_["1074ui_story"]) and arg_331_1.var_.characterEffect1074ui_story == nil then
				arg_331_1.var_.characterEffect1074ui_story = arg_331_1.actors_["1074ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_334_0 = 0.1

			if 0 <= arg_331_1.time_ and arg_331_1.time_ < 0 + var_334_0 and not isNil(arg_331_1.actors_["1074ui_story"]) then
				if arg_331_1.var_.characterEffect1074ui_story and not isNil(arg_331_1.actors_["1074ui_story"]) then
					arg_331_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_331_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_331_1.time_ - 0) / var_334_0)
				end
			end

			if arg_331_1.time_ >= 0 + var_334_0 and arg_331_1.time_ < 0 + var_334_0 + arg_334_0 and not isNil(arg_331_1.actors_["1074ui_story"]) and arg_331_1.var_.characterEffect1074ui_story then
				arg_331_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_331_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			local var_334_1 = 0
			local var_334_2 = 0.7

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= var_334_1 + arg_334_0 then
				arg_331_1.talkMaxDuration = 0
				arg_331_1.dialogCg_.alpha = 1

				arg_331_1.dialog_:SetActive(true)
				SetActive(arg_331_1.leftNameGo_, true)

				arg_331_1.leftNameTxt_.text = arg_331_1:FormatText(StoryNameCfg[1052].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_331_1.leftNameTxt_.transform)

				arg_331_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_331_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_331_1:RecordName(arg_331_1.leftNameTxt_.text)
				SetActive(arg_331_1.iconTrs_.gameObject, true)
				arg_331_1.iconController_:SetSelectedState("hero")

				arg_331_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_clerka")

				arg_331_1.callingController_:SetSelectedState("normal")

				arg_331_1.keyicon_.color = Color.New(1, 1, 1)
				arg_331_1.icon_.color = Color.New(1, 1, 1)

				local var_334_3 = arg_331_1:GetWordFromCfg(1107402083)
				local var_334_4 = arg_331_1:FormatText(var_334_3.content)

				arg_331_1.text_.text = var_334_4

				LuaForUtil.ClearLinePrefixSymbol(arg_331_1.text_)

				local var_334_6 = 28 <= 0 and var_334_2 or var_334_2 * (utf8.len(var_334_4) / 28)

				if (28 <= 0 and var_334_2 or var_334_2 * (utf8.len(var_334_4) / 28)) > 0 and var_334_2 < var_334_6 then
					arg_331_1.talkMaxDuration = var_334_6

					if var_334_6 + var_334_1 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_6 + var_334_1
					end
				end

				arg_331_1.text_.text = var_334_4
				arg_331_1.typewritter.percent = 0

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107402", "1107402083", "story_v_side_new_1107402.awb") ~= 0 then
					local var_334_7 = manager.audio:GetVoiceLength("story_v_side_new_1107402", "1107402083", "story_v_side_new_1107402.awb") / 1000

					if var_334_7 + var_334_1 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_7 + var_334_1
					end

					if var_334_3.prefab_name ~= "" and arg_331_1.actors_[var_334_3.prefab_name] ~= nil then
						local var_334_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_331_1.actors_[var_334_3.prefab_name].transform, "story_v_side_new_1107402", "1107402083", "story_v_side_new_1107402.awb")

						arg_331_1:RecordAudio("1107402083", var_334_8)
						arg_331_1:RecordAudio("1107402083", var_334_8)
					else
						arg_331_1:AudioAction("play", "voice", "story_v_side_new_1107402", "1107402083", "story_v_side_new_1107402.awb")
					end

					arg_331_1:RecordHistoryTalkVoice("story_v_side_new_1107402", "1107402083", "story_v_side_new_1107402.awb")
				end

				arg_331_1:RecordContent(arg_331_1.text_.text)
			end

			local var_334_9 = math.max(var_334_2, arg_331_1.talkMaxDuration)

			if var_334_1 <= arg_331_1.time_ and arg_331_1.time_ < var_334_1 + var_334_9 then
				arg_331_1.typewritter.percent = (arg_331_1.time_ - var_334_1) / var_334_9

				arg_331_1.typewritter:SetDirty()
			end

			if arg_331_1.time_ >= var_334_1 + var_334_9 and arg_331_1.time_ < var_334_1 + var_334_9 + arg_334_0 then
				arg_331_1.typewritter.percent = 1

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(true)
			end
		end

		arg_331_1.nodeConfigList_ = {}

		arg_331_1:InitPlayNodeList()
	end,
	Play1107402084 = function(arg_335_0, arg_335_1)
		arg_335_1.time_ = 0
		arg_335_1.frameCnt_ = 0
		arg_335_1.state_ = "playing"
		arg_335_1.curTalkId_ = 1107402084
		arg_335_1.duration_ = 4.53

		SetActive(arg_335_1.tipsGo_, false)

		function arg_335_1.onSingleLineFinish_()
			arg_335_1.onSingleLineUpdate_ = nil
			arg_335_1.onSingleLineFinish_ = nil
			arg_335_1.state_ = "waiting"
		end

		function arg_335_1.playNext_(arg_337_0)
			if arg_337_0 == 1 then
				arg_335_0:Play1107402085(arg_335_1)
			end
		end

		function arg_335_1.onSingleLineUpdate_(arg_338_0)
			local var_338_0 = 0.425

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 then
				arg_335_1.talkMaxDuration = 0
				arg_335_1.dialogCg_.alpha = 1

				arg_335_1.dialog_:SetActive(true)
				SetActive(arg_335_1.leftNameGo_, true)

				arg_335_1.leftNameTxt_.text = arg_335_1:FormatText(StoryNameCfg[171].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_335_1.leftNameTxt_.transform)

				arg_335_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_335_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_335_1:RecordName(arg_335_1.leftNameTxt_.text)
				SetActive(arg_335_1.iconTrs_.gameObject, true)
				arg_335_1.iconController_:SetSelectedState("hero")

				arg_335_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_lolia")

				arg_335_1.callingController_:SetSelectedState("normal")

				arg_335_1.keyicon_.color = Color.New(1, 1, 1)
				arg_335_1.icon_.color = Color.New(1, 1, 1)

				local var_338_1 = arg_335_1:GetWordFromCfg(1107402084)
				local var_338_2 = arg_335_1:FormatText(var_338_1.content)

				arg_335_1.text_.text = var_338_2

				LuaForUtil.ClearLinePrefixSymbol(arg_335_1.text_)

				local var_338_4 = 17 <= 0 and var_338_0 or var_338_0 * (utf8.len(var_338_2) / 17)

				if (17 <= 0 and var_338_0 or var_338_0 * (utf8.len(var_338_2) / 17)) > 0 and var_338_0 < var_338_4 then
					arg_335_1.talkMaxDuration = var_338_4

					if var_338_4 + 0 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_4 + 0
					end
				end

				arg_335_1.text_.text = var_338_2
				arg_335_1.typewritter.percent = 0

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107402", "1107402084", "story_v_side_new_1107402.awb") ~= 0 then
					local var_338_5 = manager.audio:GetVoiceLength("story_v_side_new_1107402", "1107402084", "story_v_side_new_1107402.awb") / 1000

					if var_338_5 + 0 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_5 + 0
					end

					if var_338_1.prefab_name ~= "" and arg_335_1.actors_[var_338_1.prefab_name] ~= nil then
						local var_338_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_335_1.actors_[var_338_1.prefab_name].transform, "story_v_side_new_1107402", "1107402084", "story_v_side_new_1107402.awb")

						arg_335_1:RecordAudio("1107402084", var_338_6)
						arg_335_1:RecordAudio("1107402084", var_338_6)
					else
						arg_335_1:AudioAction("play", "voice", "story_v_side_new_1107402", "1107402084", "story_v_side_new_1107402.awb")
					end

					arg_335_1:RecordHistoryTalkVoice("story_v_side_new_1107402", "1107402084", "story_v_side_new_1107402.awb")
				end

				arg_335_1:RecordContent(arg_335_1.text_.text)
			end

			local var_338_7 = math.max(var_338_0, arg_335_1.talkMaxDuration)

			if 0 <= arg_335_1.time_ and arg_335_1.time_ < 0 + var_338_7 then
				arg_335_1.typewritter.percent = (arg_335_1.time_ - 0) / var_338_7

				arg_335_1.typewritter:SetDirty()
			end

			if arg_335_1.time_ >= 0 + var_338_7 and arg_335_1.time_ < 0 + var_338_7 + arg_338_0 then
				arg_335_1.typewritter.percent = 1

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(true)
			end
		end

		arg_335_1.nodeConfigList_ = {}

		arg_335_1:InitPlayNodeList()
	end,
	Play1107402085 = function(arg_339_0, arg_339_1)
		arg_339_1.time_ = 0
		arg_339_1.frameCnt_ = 0
		arg_339_1.state_ = "playing"
		arg_339_1.curTalkId_ = 1107402085
		arg_339_1.duration_ = 2.87

		SetActive(arg_339_1.tipsGo_, false)

		function arg_339_1.onSingleLineFinish_()
			arg_339_1.onSingleLineUpdate_ = nil
			arg_339_1.onSingleLineFinish_ = nil
			arg_339_1.state_ = "waiting"
		end

		function arg_339_1.playNext_(arg_341_0)
			if arg_341_0 == 1 then
				arg_339_0:Play1107402086(arg_339_1)
			end
		end

		function arg_339_1.onSingleLineUpdate_(arg_342_0)
			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 and not isNil(arg_339_1.actors_["1074ui_story"]) and arg_339_1.var_.characterEffect1074ui_story == nil then
				arg_339_1.var_.characterEffect1074ui_story = arg_339_1.actors_["1074ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_342_0 = 0.1

			if 0 <= arg_339_1.time_ and arg_339_1.time_ < 0 + var_342_0 and not isNil(arg_339_1.actors_["1074ui_story"]) then
				if arg_339_1.var_.characterEffect1074ui_story and not isNil(arg_339_1.actors_["1074ui_story"]) then
					arg_339_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_339_1.time_ >= 0 + var_342_0 and arg_339_1.time_ < 0 + var_342_0 + arg_342_0 and not isNil(arg_339_1.actors_["1074ui_story"]) and arg_339_1.var_.characterEffect1074ui_story then
				arg_339_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_342_2 = 0
			local var_342_3 = 0.25

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= var_342_2 + arg_342_0 then
				arg_339_1.talkMaxDuration = 0
				arg_339_1.dialogCg_.alpha = 1

				arg_339_1.dialog_:SetActive(true)
				SetActive(arg_339_1.leftNameGo_, true)

				arg_339_1.leftNameTxt_.text = arg_339_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_339_1.leftNameTxt_.transform)

				arg_339_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_339_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_339_1:RecordName(arg_339_1.leftNameTxt_.text)
				SetActive(arg_339_1.iconTrs_.gameObject, true)
				arg_339_1.iconController_:SetSelectedState("hero")

				arg_339_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1074")

				arg_339_1.callingController_:SetSelectedState("normal")

				arg_339_1.keyicon_.color = Color.New(1, 1, 1)
				arg_339_1.icon_.color = Color.New(1, 1, 1)

				local var_342_4 = arg_339_1:GetWordFromCfg(1107402085)
				local var_342_5 = arg_339_1:FormatText(var_342_4.content)

				arg_339_1.text_.text = var_342_5

				LuaForUtil.ClearLinePrefixSymbol(arg_339_1.text_)

				local var_342_7 = 10 <= 0 and var_342_3 or var_342_3 * (utf8.len(var_342_5) / 10)

				if (10 <= 0 and var_342_3 or var_342_3 * (utf8.len(var_342_5) / 10)) > 0 and var_342_3 < var_342_7 then
					arg_339_1.talkMaxDuration = var_342_7

					if var_342_7 + var_342_2 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_7 + var_342_2
					end
				end

				arg_339_1.text_.text = var_342_5
				arg_339_1.typewritter.percent = 0

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107402", "1107402085", "story_v_side_new_1107402.awb") ~= 0 then
					local var_342_8 = manager.audio:GetVoiceLength("story_v_side_new_1107402", "1107402085", "story_v_side_new_1107402.awb") / 1000

					if var_342_8 + var_342_2 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_8 + var_342_2
					end

					if var_342_4.prefab_name ~= "" and arg_339_1.actors_[var_342_4.prefab_name] ~= nil then
						local var_342_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_339_1.actors_[var_342_4.prefab_name].transform, "story_v_side_new_1107402", "1107402085", "story_v_side_new_1107402.awb")

						arg_339_1:RecordAudio("1107402085", var_342_9)
						arg_339_1:RecordAudio("1107402085", var_342_9)
					else
						arg_339_1:AudioAction("play", "voice", "story_v_side_new_1107402", "1107402085", "story_v_side_new_1107402.awb")
					end

					arg_339_1:RecordHistoryTalkVoice("story_v_side_new_1107402", "1107402085", "story_v_side_new_1107402.awb")
				end

				arg_339_1:RecordContent(arg_339_1.text_.text)
			end

			local var_342_10 = math.max(var_342_3, arg_339_1.talkMaxDuration)

			if var_342_2 <= arg_339_1.time_ and arg_339_1.time_ < var_342_2 + var_342_10 then
				arg_339_1.typewritter.percent = (arg_339_1.time_ - var_342_2) / var_342_10

				arg_339_1.typewritter:SetDirty()
			end

			if arg_339_1.time_ >= var_342_2 + var_342_10 and arg_339_1.time_ < var_342_2 + var_342_10 + arg_342_0 then
				arg_339_1.typewritter.percent = 1

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(true)
			end
		end

		arg_339_1.nodeConfigList_ = {}

		arg_339_1:InitPlayNodeList()
	end,
	Play1107402086 = function(arg_343_0, arg_343_1)
		arg_343_1.time_ = 0
		arg_343_1.frameCnt_ = 0
		arg_343_1.state_ = "playing"
		arg_343_1.curTalkId_ = 1107402086
		arg_343_1.duration_ = 3.5

		SetActive(arg_343_1.tipsGo_, false)

		function arg_343_1.onSingleLineFinish_()
			arg_343_1.onSingleLineUpdate_ = nil
			arg_343_1.onSingleLineFinish_ = nil
			arg_343_1.state_ = "waiting"
		end

		function arg_343_1.playNext_(arg_345_0)
			if arg_345_0 == 1 then
				arg_343_0:Play1107402087(arg_343_1)
			end
		end

		function arg_343_1.onSingleLineUpdate_(arg_346_0)
			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 and not isNil(arg_343_1.actors_["1074ui_story"]) and arg_343_1.var_.characterEffect1074ui_story == nil then
				arg_343_1.var_.characterEffect1074ui_story = arg_343_1.actors_["1074ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_346_0 = 0.1

			if 0 <= arg_343_1.time_ and arg_343_1.time_ < 0 + var_346_0 and not isNil(arg_343_1.actors_["1074ui_story"]) then
				if arg_343_1.var_.characterEffect1074ui_story and not isNil(arg_343_1.actors_["1074ui_story"]) then
					arg_343_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_343_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_343_1.time_ - 0) / var_346_0)
				end
			end

			if arg_343_1.time_ >= 0 + var_346_0 and arg_343_1.time_ < 0 + var_346_0 + arg_346_0 and not isNil(arg_343_1.actors_["1074ui_story"]) and arg_343_1.var_.characterEffect1074ui_story then
				arg_343_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_343_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			local var_346_1 = 0
			local var_346_2 = 0.325

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= var_346_1 + arg_346_0 then
				arg_343_1.talkMaxDuration = 0
				arg_343_1.dialogCg_.alpha = 1

				arg_343_1.dialog_:SetActive(true)
				SetActive(arg_343_1.leftNameGo_, true)

				arg_343_1.leftNameTxt_.text = arg_343_1:FormatText(StoryNameCfg[171].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_343_1.leftNameTxt_.transform)

				arg_343_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_343_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_343_1:RecordName(arg_343_1.leftNameTxt_.text)
				SetActive(arg_343_1.iconTrs_.gameObject, true)
				arg_343_1.iconController_:SetSelectedState("hero")

				arg_343_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_lolia")

				arg_343_1.callingController_:SetSelectedState("normal")

				arg_343_1.keyicon_.color = Color.New(1, 1, 1)
				arg_343_1.icon_.color = Color.New(1, 1, 1)

				local var_346_3 = arg_343_1:GetWordFromCfg(1107402086)
				local var_346_4 = arg_343_1:FormatText(var_346_3.content)

				arg_343_1.text_.text = var_346_4

				LuaForUtil.ClearLinePrefixSymbol(arg_343_1.text_)

				local var_346_6 = 13 <= 0 and var_346_2 or var_346_2 * (utf8.len(var_346_4) / 13)

				if (13 <= 0 and var_346_2 or var_346_2 * (utf8.len(var_346_4) / 13)) > 0 and var_346_2 < var_346_6 then
					arg_343_1.talkMaxDuration = var_346_6

					if var_346_6 + var_346_1 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_6 + var_346_1
					end
				end

				arg_343_1.text_.text = var_346_4
				arg_343_1.typewritter.percent = 0

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107402", "1107402086", "story_v_side_new_1107402.awb") ~= 0 then
					local var_346_7 = manager.audio:GetVoiceLength("story_v_side_new_1107402", "1107402086", "story_v_side_new_1107402.awb") / 1000

					if var_346_7 + var_346_1 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_7 + var_346_1
					end

					if var_346_3.prefab_name ~= "" and arg_343_1.actors_[var_346_3.prefab_name] ~= nil then
						local var_346_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_343_1.actors_[var_346_3.prefab_name].transform, "story_v_side_new_1107402", "1107402086", "story_v_side_new_1107402.awb")

						arg_343_1:RecordAudio("1107402086", var_346_8)
						arg_343_1:RecordAudio("1107402086", var_346_8)
					else
						arg_343_1:AudioAction("play", "voice", "story_v_side_new_1107402", "1107402086", "story_v_side_new_1107402.awb")
					end

					arg_343_1:RecordHistoryTalkVoice("story_v_side_new_1107402", "1107402086", "story_v_side_new_1107402.awb")
				end

				arg_343_1:RecordContent(arg_343_1.text_.text)
			end

			local var_346_9 = math.max(var_346_2, arg_343_1.talkMaxDuration)

			if var_346_1 <= arg_343_1.time_ and arg_343_1.time_ < var_346_1 + var_346_9 then
				arg_343_1.typewritter.percent = (arg_343_1.time_ - var_346_1) / var_346_9

				arg_343_1.typewritter:SetDirty()
			end

			if arg_343_1.time_ >= var_346_1 + var_346_9 and arg_343_1.time_ < var_346_1 + var_346_9 + arg_346_0 then
				arg_343_1.typewritter.percent = 1

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(true)
			end
		end

		arg_343_1.nodeConfigList_ = {}

		arg_343_1:InitPlayNodeList()
	end,
	Play1107402087 = function(arg_347_0, arg_347_1)
		arg_347_1.time_ = 0
		arg_347_1.frameCnt_ = 0
		arg_347_1.state_ = "playing"
		arg_347_1.curTalkId_ = 1107402087
		arg_347_1.duration_ = 4.03

		SetActive(arg_347_1.tipsGo_, false)

		function arg_347_1.onSingleLineFinish_()
			arg_347_1.onSingleLineUpdate_ = nil
			arg_347_1.onSingleLineFinish_ = nil
			arg_347_1.state_ = "waiting"
		end

		function arg_347_1.playNext_(arg_349_0)
			if arg_349_0 == 1 then
				arg_347_0:Play1107402088(arg_347_1)
			end
		end

		function arg_347_1.onSingleLineUpdate_(arg_350_0)
			local var_350_0 = 0.5

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 then
				arg_347_1.talkMaxDuration = 0
				arg_347_1.dialogCg_.alpha = 1

				arg_347_1.dialog_:SetActive(true)
				SetActive(arg_347_1.leftNameGo_, true)

				arg_347_1.leftNameTxt_.text = arg_347_1:FormatText(StoryNameCfg[1053].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_347_1.leftNameTxt_.transform)

				arg_347_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_347_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_347_1:RecordName(arg_347_1.leftNameTxt_.text)
				SetActive(arg_347_1.iconTrs_.gameObject, true)
				arg_347_1.iconController_:SetSelectedState("hero")

				arg_347_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_littleboya")

				arg_347_1.callingController_:SetSelectedState("normal")

				arg_347_1.keyicon_.color = Color.New(1, 1, 1)
				arg_347_1.icon_.color = Color.New(1, 1, 1)

				local var_350_1 = arg_347_1:GetWordFromCfg(1107402087)
				local var_350_2 = arg_347_1:FormatText(var_350_1.content)

				arg_347_1.text_.text = var_350_2

				LuaForUtil.ClearLinePrefixSymbol(arg_347_1.text_)

				local var_350_4 = 20 <= 0 and var_350_0 or var_350_0 * (utf8.len(var_350_2) / 20)

				if (20 <= 0 and var_350_0 or var_350_0 * (utf8.len(var_350_2) / 20)) > 0 and var_350_0 < var_350_4 then
					arg_347_1.talkMaxDuration = var_350_4

					if var_350_4 + 0 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_4 + 0
					end
				end

				arg_347_1.text_.text = var_350_2
				arg_347_1.typewritter.percent = 0

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107402", "1107402087", "story_v_side_new_1107402.awb") ~= 0 then
					local var_350_5 = manager.audio:GetVoiceLength("story_v_side_new_1107402", "1107402087", "story_v_side_new_1107402.awb") / 1000

					if var_350_5 + 0 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_5 + 0
					end

					if var_350_1.prefab_name ~= "" and arg_347_1.actors_[var_350_1.prefab_name] ~= nil then
						local var_350_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_347_1.actors_[var_350_1.prefab_name].transform, "story_v_side_new_1107402", "1107402087", "story_v_side_new_1107402.awb")

						arg_347_1:RecordAudio("1107402087", var_350_6)
						arg_347_1:RecordAudio("1107402087", var_350_6)
					else
						arg_347_1:AudioAction("play", "voice", "story_v_side_new_1107402", "1107402087", "story_v_side_new_1107402.awb")
					end

					arg_347_1:RecordHistoryTalkVoice("story_v_side_new_1107402", "1107402087", "story_v_side_new_1107402.awb")
				end

				arg_347_1:RecordContent(arg_347_1.text_.text)
			end

			local var_350_7 = math.max(var_350_0, arg_347_1.talkMaxDuration)

			if 0 <= arg_347_1.time_ and arg_347_1.time_ < 0 + var_350_7 then
				arg_347_1.typewritter.percent = (arg_347_1.time_ - 0) / var_350_7

				arg_347_1.typewritter:SetDirty()
			end

			if arg_347_1.time_ >= 0 + var_350_7 and arg_347_1.time_ < 0 + var_350_7 + arg_350_0 then
				arg_347_1.typewritter.percent = 1

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(true)
			end
		end

		arg_347_1.nodeConfigList_ = {}

		arg_347_1:InitPlayNodeList()
	end,
	Play1107402088 = function(arg_351_0, arg_351_1)
		arg_351_1.time_ = 0
		arg_351_1.frameCnt_ = 0
		arg_351_1.state_ = "playing"
		arg_351_1.curTalkId_ = 1107402088
		arg_351_1.duration_ = 1.63

		SetActive(arg_351_1.tipsGo_, false)

		function arg_351_1.onSingleLineFinish_()
			arg_351_1.onSingleLineUpdate_ = nil
			arg_351_1.onSingleLineFinish_ = nil
			arg_351_1.state_ = "waiting"
		end

		function arg_351_1.playNext_(arg_353_0)
			if arg_353_0 == 1 then
				arg_351_0:Play1107402089(arg_351_1)
			end
		end

		function arg_351_1.onSingleLineUpdate_(arg_354_0)
			local var_354_0 = 0.125

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 then
				arg_351_1.talkMaxDuration = 0
				arg_351_1.dialogCg_.alpha = 1

				arg_351_1.dialog_:SetActive(true)
				SetActive(arg_351_1.leftNameGo_, true)

				arg_351_1.leftNameTxt_.text = arg_351_1:FormatText(StoryNameCfg[171].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_351_1.leftNameTxt_.transform)

				arg_351_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_351_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_351_1:RecordName(arg_351_1.leftNameTxt_.text)
				SetActive(arg_351_1.iconTrs_.gameObject, true)
				arg_351_1.iconController_:SetSelectedState("hero")

				arg_351_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_lolia")

				arg_351_1.callingController_:SetSelectedState("normal")

				arg_351_1.keyicon_.color = Color.New(1, 1, 1)
				arg_351_1.icon_.color = Color.New(1, 1, 1)

				local var_354_1 = arg_351_1:GetWordFromCfg(1107402088)
				local var_354_2 = arg_351_1:FormatText(var_354_1.content)

				arg_351_1.text_.text = var_354_2

				LuaForUtil.ClearLinePrefixSymbol(arg_351_1.text_)

				local var_354_4 = 5 <= 0 and var_354_0 or var_354_0 * (utf8.len(var_354_2) / 5)

				if (5 <= 0 and var_354_0 or var_354_0 * (utf8.len(var_354_2) / 5)) > 0 and var_354_0 < var_354_4 then
					arg_351_1.talkMaxDuration = var_354_4

					if var_354_4 + 0 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_4 + 0
					end
				end

				arg_351_1.text_.text = var_354_2
				arg_351_1.typewritter.percent = 0

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107402", "1107402088", "story_v_side_new_1107402.awb") ~= 0 then
					local var_354_5 = manager.audio:GetVoiceLength("story_v_side_new_1107402", "1107402088", "story_v_side_new_1107402.awb") / 1000

					if var_354_5 + 0 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_5 + 0
					end

					if var_354_1.prefab_name ~= "" and arg_351_1.actors_[var_354_1.prefab_name] ~= nil then
						local var_354_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_351_1.actors_[var_354_1.prefab_name].transform, "story_v_side_new_1107402", "1107402088", "story_v_side_new_1107402.awb")

						arg_351_1:RecordAudio("1107402088", var_354_6)
						arg_351_1:RecordAudio("1107402088", var_354_6)
					else
						arg_351_1:AudioAction("play", "voice", "story_v_side_new_1107402", "1107402088", "story_v_side_new_1107402.awb")
					end

					arg_351_1:RecordHistoryTalkVoice("story_v_side_new_1107402", "1107402088", "story_v_side_new_1107402.awb")
				end

				arg_351_1:RecordContent(arg_351_1.text_.text)
			end

			local var_354_7 = math.max(var_354_0, arg_351_1.talkMaxDuration)

			if 0 <= arg_351_1.time_ and arg_351_1.time_ < 0 + var_354_7 then
				arg_351_1.typewritter.percent = (arg_351_1.time_ - 0) / var_354_7

				arg_351_1.typewritter:SetDirty()
			end

			if arg_351_1.time_ >= 0 + var_354_7 and arg_351_1.time_ < 0 + var_354_7 + arg_354_0 then
				arg_351_1.typewritter.percent = 1

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(true)
			end
		end

		arg_351_1.nodeConfigList_ = {}

		arg_351_1:InitPlayNodeList()
	end,
	Play1107402089 = function(arg_355_0, arg_355_1)
		arg_355_1.time_ = 0
		arg_355_1.frameCnt_ = 0
		arg_355_1.state_ = "playing"
		arg_355_1.curTalkId_ = 1107402089
		arg_355_1.duration_ = 7.47

		SetActive(arg_355_1.tipsGo_, false)

		function arg_355_1.onSingleLineFinish_()
			arg_355_1.onSingleLineUpdate_ = nil
			arg_355_1.onSingleLineFinish_ = nil
			arg_355_1.state_ = "waiting"
		end

		function arg_355_1.playNext_(arg_357_0)
			if arg_357_0 == 1 then
				arg_355_0:Play1107402090(arg_355_1)
			end
		end

		function arg_355_1.onSingleLineUpdate_(arg_358_0)
			local var_358_0 = 0.925

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 then
				arg_355_1.talkMaxDuration = 0
				arg_355_1.dialogCg_.alpha = 1

				arg_355_1.dialog_:SetActive(true)
				SetActive(arg_355_1.leftNameGo_, true)

				arg_355_1.leftNameTxt_.text = arg_355_1:FormatText(StoryNameCfg[1053].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_355_1.leftNameTxt_.transform)

				arg_355_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_355_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_355_1:RecordName(arg_355_1.leftNameTxt_.text)
				SetActive(arg_355_1.iconTrs_.gameObject, true)
				arg_355_1.iconController_:SetSelectedState("hero")

				arg_355_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_littleboya")

				arg_355_1.callingController_:SetSelectedState("normal")

				arg_355_1.keyicon_.color = Color.New(1, 1, 1)
				arg_355_1.icon_.color = Color.New(1, 1, 1)

				local var_358_1 = arg_355_1:GetWordFromCfg(1107402089)
				local var_358_2 = arg_355_1:FormatText(var_358_1.content)

				arg_355_1.text_.text = var_358_2

				LuaForUtil.ClearLinePrefixSymbol(arg_355_1.text_)

				local var_358_4 = 38 <= 0 and var_358_0 or var_358_0 * (utf8.len(var_358_2) / 38)

				if (38 <= 0 and var_358_0 or var_358_0 * (utf8.len(var_358_2) / 38)) > 0 and var_358_0 < var_358_4 then
					arg_355_1.talkMaxDuration = var_358_4

					if var_358_4 + 0 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_4 + 0
					end
				end

				arg_355_1.text_.text = var_358_2
				arg_355_1.typewritter.percent = 0

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107402", "1107402089", "story_v_side_new_1107402.awb") ~= 0 then
					local var_358_5 = manager.audio:GetVoiceLength("story_v_side_new_1107402", "1107402089", "story_v_side_new_1107402.awb") / 1000

					if var_358_5 + 0 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_5 + 0
					end

					if var_358_1.prefab_name ~= "" and arg_355_1.actors_[var_358_1.prefab_name] ~= nil then
						local var_358_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_355_1.actors_[var_358_1.prefab_name].transform, "story_v_side_new_1107402", "1107402089", "story_v_side_new_1107402.awb")

						arg_355_1:RecordAudio("1107402089", var_358_6)
						arg_355_1:RecordAudio("1107402089", var_358_6)
					else
						arg_355_1:AudioAction("play", "voice", "story_v_side_new_1107402", "1107402089", "story_v_side_new_1107402.awb")
					end

					arg_355_1:RecordHistoryTalkVoice("story_v_side_new_1107402", "1107402089", "story_v_side_new_1107402.awb")
				end

				arg_355_1:RecordContent(arg_355_1.text_.text)
			end

			local var_358_7 = math.max(var_358_0, arg_355_1.talkMaxDuration)

			if 0 <= arg_355_1.time_ and arg_355_1.time_ < 0 + var_358_7 then
				arg_355_1.typewritter.percent = (arg_355_1.time_ - 0) / var_358_7

				arg_355_1.typewritter:SetDirty()
			end

			if arg_355_1.time_ >= 0 + var_358_7 and arg_355_1.time_ < 0 + var_358_7 + arg_358_0 then
				arg_355_1.typewritter.percent = 1

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(true)
			end
		end

		arg_355_1.nodeConfigList_ = {}

		arg_355_1:InitPlayNodeList()
	end,
	Play1107402090 = function(arg_359_0, arg_359_1)
		arg_359_1.time_ = 0
		arg_359_1.frameCnt_ = 0
		arg_359_1.state_ = "playing"
		arg_359_1.curTalkId_ = 1107402090
		arg_359_1.duration_ = 8.67

		SetActive(arg_359_1.tipsGo_, false)

		function arg_359_1.onSingleLineFinish_()
			arg_359_1.onSingleLineUpdate_ = nil
			arg_359_1.onSingleLineFinish_ = nil
			arg_359_1.state_ = "waiting"
		end

		function arg_359_1.playNext_(arg_361_0)
			if arg_361_0 == 1 then
				arg_359_0:Play1107402091(arg_359_1)
			end
		end

		function arg_359_1.onSingleLineUpdate_(arg_362_0)
			local var_362_0 = 0.875

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 then
				arg_359_1.talkMaxDuration = 0
				arg_359_1.dialogCg_.alpha = 1

				arg_359_1.dialog_:SetActive(true)
				SetActive(arg_359_1.leftNameGo_, true)

				arg_359_1.leftNameTxt_.text = arg_359_1:FormatText(StoryNameCfg[171].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_359_1.leftNameTxt_.transform)

				arg_359_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_359_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_359_1:RecordName(arg_359_1.leftNameTxt_.text)
				SetActive(arg_359_1.iconTrs_.gameObject, true)
				arg_359_1.iconController_:SetSelectedState("hero")

				arg_359_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_lolia")

				arg_359_1.callingController_:SetSelectedState("normal")

				arg_359_1.keyicon_.color = Color.New(1, 1, 1)
				arg_359_1.icon_.color = Color.New(1, 1, 1)

				local var_362_1 = arg_359_1:GetWordFromCfg(1107402090)
				local var_362_2 = arg_359_1:FormatText(var_362_1.content)

				arg_359_1.text_.text = var_362_2

				LuaForUtil.ClearLinePrefixSymbol(arg_359_1.text_)

				local var_362_4 = 35 <= 0 and var_362_0 or var_362_0 * (utf8.len(var_362_2) / 35)

				if (35 <= 0 and var_362_0 or var_362_0 * (utf8.len(var_362_2) / 35)) > 0 and var_362_0 < var_362_4 then
					arg_359_1.talkMaxDuration = var_362_4

					if var_362_4 + 0 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_4 + 0
					end
				end

				arg_359_1.text_.text = var_362_2
				arg_359_1.typewritter.percent = 0

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107402", "1107402090", "story_v_side_new_1107402.awb") ~= 0 then
					local var_362_5 = manager.audio:GetVoiceLength("story_v_side_new_1107402", "1107402090", "story_v_side_new_1107402.awb") / 1000

					if var_362_5 + 0 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_5 + 0
					end

					if var_362_1.prefab_name ~= "" and arg_359_1.actors_[var_362_1.prefab_name] ~= nil then
						local var_362_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_359_1.actors_[var_362_1.prefab_name].transform, "story_v_side_new_1107402", "1107402090", "story_v_side_new_1107402.awb")

						arg_359_1:RecordAudio("1107402090", var_362_6)
						arg_359_1:RecordAudio("1107402090", var_362_6)
					else
						arg_359_1:AudioAction("play", "voice", "story_v_side_new_1107402", "1107402090", "story_v_side_new_1107402.awb")
					end

					arg_359_1:RecordHistoryTalkVoice("story_v_side_new_1107402", "1107402090", "story_v_side_new_1107402.awb")
				end

				arg_359_1:RecordContent(arg_359_1.text_.text)
			end

			local var_362_7 = math.max(var_362_0, arg_359_1.talkMaxDuration)

			if 0 <= arg_359_1.time_ and arg_359_1.time_ < 0 + var_362_7 then
				arg_359_1.typewritter.percent = (arg_359_1.time_ - 0) / var_362_7

				arg_359_1.typewritter:SetDirty()
			end

			if arg_359_1.time_ >= 0 + var_362_7 and arg_359_1.time_ < 0 + var_362_7 + arg_362_0 then
				arg_359_1.typewritter.percent = 1

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(true)
			end
		end

		arg_359_1.nodeConfigList_ = {}

		arg_359_1:InitPlayNodeList()
	end,
	Play1107402091 = function(arg_363_0, arg_363_1)
		arg_363_1.time_ = 0
		arg_363_1.frameCnt_ = 0
		arg_363_1.state_ = "playing"
		arg_363_1.curTalkId_ = 1107402091
		arg_363_1.duration_ = 3.2

		SetActive(arg_363_1.tipsGo_, false)

		function arg_363_1.onSingleLineFinish_()
			arg_363_1.onSingleLineUpdate_ = nil
			arg_363_1.onSingleLineFinish_ = nil
			arg_363_1.state_ = "waiting"
		end

		function arg_363_1.playNext_(arg_365_0)
			if arg_365_0 == 1 then
				arg_363_0:Play1107402092(arg_363_1)
			end
		end

		function arg_363_1.onSingleLineUpdate_(arg_366_0)
			local var_366_0 = 0.45

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 then
				arg_363_1.talkMaxDuration = 0
				arg_363_1.dialogCg_.alpha = 1

				arg_363_1.dialog_:SetActive(true)
				SetActive(arg_363_1.leftNameGo_, true)

				arg_363_1.leftNameTxt_.text = arg_363_1:FormatText(StoryNameCfg[1053].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_363_1.leftNameTxt_.transform)

				arg_363_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_363_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_363_1:RecordName(arg_363_1.leftNameTxt_.text)
				SetActive(arg_363_1.iconTrs_.gameObject, true)
				arg_363_1.iconController_:SetSelectedState("hero")

				arg_363_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_littleboya")

				arg_363_1.callingController_:SetSelectedState("normal")

				arg_363_1.keyicon_.color = Color.New(1, 1, 1)
				arg_363_1.icon_.color = Color.New(1, 1, 1)

				local var_366_1 = arg_363_1:GetWordFromCfg(1107402091)
				local var_366_2 = arg_363_1:FormatText(var_366_1.content)

				arg_363_1.text_.text = var_366_2

				LuaForUtil.ClearLinePrefixSymbol(arg_363_1.text_)

				local var_366_4 = 18 <= 0 and var_366_0 or var_366_0 * (utf8.len(var_366_2) / 18)

				if (18 <= 0 and var_366_0 or var_366_0 * (utf8.len(var_366_2) / 18)) > 0 and var_366_0 < var_366_4 then
					arg_363_1.talkMaxDuration = var_366_4

					if var_366_4 + 0 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_4 + 0
					end
				end

				arg_363_1.text_.text = var_366_2
				arg_363_1.typewritter.percent = 0

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107402", "1107402091", "story_v_side_new_1107402.awb") ~= 0 then
					local var_366_5 = manager.audio:GetVoiceLength("story_v_side_new_1107402", "1107402091", "story_v_side_new_1107402.awb") / 1000

					if var_366_5 + 0 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_5 + 0
					end

					if var_366_1.prefab_name ~= "" and arg_363_1.actors_[var_366_1.prefab_name] ~= nil then
						local var_366_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_363_1.actors_[var_366_1.prefab_name].transform, "story_v_side_new_1107402", "1107402091", "story_v_side_new_1107402.awb")

						arg_363_1:RecordAudio("1107402091", var_366_6)
						arg_363_1:RecordAudio("1107402091", var_366_6)
					else
						arg_363_1:AudioAction("play", "voice", "story_v_side_new_1107402", "1107402091", "story_v_side_new_1107402.awb")
					end

					arg_363_1:RecordHistoryTalkVoice("story_v_side_new_1107402", "1107402091", "story_v_side_new_1107402.awb")
				end

				arg_363_1:RecordContent(arg_363_1.text_.text)
			end

			local var_366_7 = math.max(var_366_0, arg_363_1.talkMaxDuration)

			if 0 <= arg_363_1.time_ and arg_363_1.time_ < 0 + var_366_7 then
				arg_363_1.typewritter.percent = (arg_363_1.time_ - 0) / var_366_7

				arg_363_1.typewritter:SetDirty()
			end

			if arg_363_1.time_ >= 0 + var_366_7 and arg_363_1.time_ < 0 + var_366_7 + arg_366_0 then
				arg_363_1.typewritter.percent = 1

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(true)
			end
		end

		arg_363_1.nodeConfigList_ = {}

		arg_363_1:InitPlayNodeList()
	end,
	Play1107402092 = function(arg_367_0, arg_367_1)
		arg_367_1.time_ = 0
		arg_367_1.frameCnt_ = 0
		arg_367_1.state_ = "playing"
		arg_367_1.curTalkId_ = 1107402092
		arg_367_1.duration_ = 1.93

		SetActive(arg_367_1.tipsGo_, false)

		function arg_367_1.onSingleLineFinish_()
			arg_367_1.onSingleLineUpdate_ = nil
			arg_367_1.onSingleLineFinish_ = nil
			arg_367_1.state_ = "waiting"
		end

		function arg_367_1.playNext_(arg_369_0)
			if arg_369_0 == 1 then
				arg_367_0:Play1107402093(arg_367_1)
			end
		end

		function arg_367_1.onSingleLineUpdate_(arg_370_0)
			local var_370_0 = 0.225

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 then
				arg_367_1.talkMaxDuration = 0
				arg_367_1.dialogCg_.alpha = 1

				arg_367_1.dialog_:SetActive(true)
				SetActive(arg_367_1.leftNameGo_, true)

				arg_367_1.leftNameTxt_.text = arg_367_1:FormatText(StoryNameCfg[1052].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_367_1.leftNameTxt_.transform)

				arg_367_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_367_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_367_1:RecordName(arg_367_1.leftNameTxt_.text)
				SetActive(arg_367_1.iconTrs_.gameObject, true)
				arg_367_1.iconController_:SetSelectedState("hero")

				arg_367_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_clerka")

				arg_367_1.callingController_:SetSelectedState("normal")

				arg_367_1.keyicon_.color = Color.New(1, 1, 1)
				arg_367_1.icon_.color = Color.New(1, 1, 1)

				local var_370_1 = arg_367_1:GetWordFromCfg(1107402092)
				local var_370_2 = arg_367_1:FormatText(var_370_1.content)

				arg_367_1.text_.text = var_370_2

				LuaForUtil.ClearLinePrefixSymbol(arg_367_1.text_)

				local var_370_4 = 9 <= 0 and var_370_0 or var_370_0 * (utf8.len(var_370_2) / 9)

				if (9 <= 0 and var_370_0 or var_370_0 * (utf8.len(var_370_2) / 9)) > 0 and var_370_0 < var_370_4 then
					arg_367_1.talkMaxDuration = var_370_4

					if var_370_4 + 0 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_4 + 0
					end
				end

				arg_367_1.text_.text = var_370_2
				arg_367_1.typewritter.percent = 0

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107402", "1107402092", "story_v_side_new_1107402.awb") ~= 0 then
					local var_370_5 = manager.audio:GetVoiceLength("story_v_side_new_1107402", "1107402092", "story_v_side_new_1107402.awb") / 1000

					if var_370_5 + 0 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_5 + 0
					end

					if var_370_1.prefab_name ~= "" and arg_367_1.actors_[var_370_1.prefab_name] ~= nil then
						local var_370_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_367_1.actors_[var_370_1.prefab_name].transform, "story_v_side_new_1107402", "1107402092", "story_v_side_new_1107402.awb")

						arg_367_1:RecordAudio("1107402092", var_370_6)
						arg_367_1:RecordAudio("1107402092", var_370_6)
					else
						arg_367_1:AudioAction("play", "voice", "story_v_side_new_1107402", "1107402092", "story_v_side_new_1107402.awb")
					end

					arg_367_1:RecordHistoryTalkVoice("story_v_side_new_1107402", "1107402092", "story_v_side_new_1107402.awb")
				end

				arg_367_1:RecordContent(arg_367_1.text_.text)
			end

			local var_370_7 = math.max(var_370_0, arg_367_1.talkMaxDuration)

			if 0 <= arg_367_1.time_ and arg_367_1.time_ < 0 + var_370_7 then
				arg_367_1.typewritter.percent = (arg_367_1.time_ - 0) / var_370_7

				arg_367_1.typewritter:SetDirty()
			end

			if arg_367_1.time_ >= 0 + var_370_7 and arg_367_1.time_ < 0 + var_370_7 + arg_370_0 then
				arg_367_1.typewritter.percent = 1

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(true)
			end
		end

		arg_367_1.nodeConfigList_ = {}

		arg_367_1:InitPlayNodeList()
	end,
	Play1107402093 = function(arg_371_0, arg_371_1)
		arg_371_1.time_ = 0
		arg_371_1.frameCnt_ = 0
		arg_371_1.state_ = "playing"
		arg_371_1.curTalkId_ = 1107402093
		arg_371_1.duration_ = 5

		SetActive(arg_371_1.tipsGo_, false)

		function arg_371_1.onSingleLineFinish_()
			arg_371_1.onSingleLineUpdate_ = nil
			arg_371_1.onSingleLineFinish_ = nil
			arg_371_1.state_ = "waiting"
		end

		function arg_371_1.playNext_(arg_373_0)
			if arg_373_0 == 1 then
				arg_371_0:Play1107402094(arg_371_1)
			end
		end

		function arg_371_1.onSingleLineUpdate_(arg_374_0)
			local var_374_0 = 0.825

			if 0 < arg_371_1.time_ and arg_371_1.time_ <= 0 + arg_374_0 then
				arg_371_1.talkMaxDuration = 0
				arg_371_1.dialogCg_.alpha = 1

				arg_371_1.dialog_:SetActive(true)
				SetActive(arg_371_1.leftNameGo_, false)

				arg_371_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_371_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_371_1:RecordName(arg_371_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_371_1.iconTrs_.gameObject, false)
				arg_371_1.callingController_:SetSelectedState("normal")

				local var_374_1 = arg_371_1:FormatText(arg_371_1:GetWordFromCfg(1107402093).content)

				arg_371_1.text_.text = var_374_1

				LuaForUtil.ClearLinePrefixSymbol(arg_371_1.text_)

				local var_374_3 = 33 <= 0 and var_374_0 or var_374_0 * (utf8.len(var_374_1) / 33)

				if (33 <= 0 and var_374_0 or var_374_0 * (utf8.len(var_374_1) / 33)) > 0 and var_374_0 < var_374_3 then
					arg_371_1.talkMaxDuration = var_374_3

					if var_374_3 + 0 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_3 + 0
					end
				end

				arg_371_1.text_.text = var_374_1
				arg_371_1.typewritter.percent = 0

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(false)
				arg_371_1:RecordContent(arg_371_1.text_.text)
			end

			local var_374_4 = math.max(var_374_0, arg_371_1.talkMaxDuration)

			if 0 <= arg_371_1.time_ and arg_371_1.time_ < 0 + var_374_4 then
				arg_371_1.typewritter.percent = (arg_371_1.time_ - 0) / var_374_4

				arg_371_1.typewritter:SetDirty()
			end

			if arg_371_1.time_ >= 0 + var_374_4 and arg_371_1.time_ < 0 + var_374_4 + arg_374_0 then
				arg_371_1.typewritter.percent = 1

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(true)
			end
		end

		arg_371_1.nodeConfigList_ = {}

		arg_371_1:InitPlayNodeList()
	end,
	Play1107402094 = function(arg_375_0, arg_375_1)
		arg_375_1.time_ = 0
		arg_375_1.frameCnt_ = 0
		arg_375_1.state_ = "playing"
		arg_375_1.curTalkId_ = 1107402094
		arg_375_1.duration_ = 8.6

		SetActive(arg_375_1.tipsGo_, false)

		function arg_375_1.onSingleLineFinish_()
			arg_375_1.onSingleLineUpdate_ = nil
			arg_375_1.onSingleLineFinish_ = nil
			arg_375_1.state_ = "waiting"
		end

		function arg_375_1.playNext_(arg_377_0)
			if arg_377_0 == 1 then
				arg_375_0:Play1107402095(arg_375_1)
			end
		end

		function arg_375_1.onSingleLineUpdate_(arg_378_0)
			local var_378_0 = 0.9

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 then
				arg_375_1.talkMaxDuration = 0
				arg_375_1.dialogCg_.alpha = 1

				arg_375_1.dialog_:SetActive(true)
				SetActive(arg_375_1.leftNameGo_, true)

				arg_375_1.leftNameTxt_.text = arg_375_1:FormatText(StoryNameCfg[171].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_375_1.leftNameTxt_.transform)

				arg_375_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_375_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_375_1:RecordName(arg_375_1.leftNameTxt_.text)
				SetActive(arg_375_1.iconTrs_.gameObject, true)
				arg_375_1.iconController_:SetSelectedState("hero")

				arg_375_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_lolia")

				arg_375_1.callingController_:SetSelectedState("normal")

				arg_375_1.keyicon_.color = Color.New(1, 1, 1)
				arg_375_1.icon_.color = Color.New(1, 1, 1)

				local var_378_1 = arg_375_1:GetWordFromCfg(1107402094)
				local var_378_2 = arg_375_1:FormatText(var_378_1.content)

				arg_375_1.text_.text = var_378_2

				LuaForUtil.ClearLinePrefixSymbol(arg_375_1.text_)

				local var_378_4 = 36 <= 0 and var_378_0 or var_378_0 * (utf8.len(var_378_2) / 36)

				if (36 <= 0 and var_378_0 or var_378_0 * (utf8.len(var_378_2) / 36)) > 0 and var_378_0 < var_378_4 then
					arg_375_1.talkMaxDuration = var_378_4

					if var_378_4 + 0 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_4 + 0
					end
				end

				arg_375_1.text_.text = var_378_2
				arg_375_1.typewritter.percent = 0

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107402", "1107402094", "story_v_side_new_1107402.awb") ~= 0 then
					local var_378_5 = manager.audio:GetVoiceLength("story_v_side_new_1107402", "1107402094", "story_v_side_new_1107402.awb") / 1000

					if var_378_5 + 0 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_5 + 0
					end

					if var_378_1.prefab_name ~= "" and arg_375_1.actors_[var_378_1.prefab_name] ~= nil then
						local var_378_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_375_1.actors_[var_378_1.prefab_name].transform, "story_v_side_new_1107402", "1107402094", "story_v_side_new_1107402.awb")

						arg_375_1:RecordAudio("1107402094", var_378_6)
						arg_375_1:RecordAudio("1107402094", var_378_6)
					else
						arg_375_1:AudioAction("play", "voice", "story_v_side_new_1107402", "1107402094", "story_v_side_new_1107402.awb")
					end

					arg_375_1:RecordHistoryTalkVoice("story_v_side_new_1107402", "1107402094", "story_v_side_new_1107402.awb")
				end

				arg_375_1:RecordContent(arg_375_1.text_.text)
			end

			local var_378_7 = math.max(var_378_0, arg_375_1.talkMaxDuration)

			if 0 <= arg_375_1.time_ and arg_375_1.time_ < 0 + var_378_7 then
				arg_375_1.typewritter.percent = (arg_375_1.time_ - 0) / var_378_7

				arg_375_1.typewritter:SetDirty()
			end

			if arg_375_1.time_ >= 0 + var_378_7 and arg_375_1.time_ < 0 + var_378_7 + arg_378_0 then
				arg_375_1.typewritter.percent = 1

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(true)
			end
		end

		arg_375_1.nodeConfigList_ = {}

		arg_375_1:InitPlayNodeList()
	end,
	Play1107402095 = function(arg_379_0, arg_379_1)
		arg_379_1.time_ = 0
		arg_379_1.frameCnt_ = 0
		arg_379_1.state_ = "playing"
		arg_379_1.curTalkId_ = 1107402095
		arg_379_1.duration_ = 2.1

		SetActive(arg_379_1.tipsGo_, false)

		function arg_379_1.onSingleLineFinish_()
			arg_379_1.onSingleLineUpdate_ = nil
			arg_379_1.onSingleLineFinish_ = nil
			arg_379_1.state_ = "waiting"
		end

		function arg_379_1.playNext_(arg_381_0)
			if arg_381_0 == 1 then
				arg_379_0:Play1107402096(arg_379_1)
			end
		end

		function arg_379_1.onSingleLineUpdate_(arg_382_0)
			local var_382_0 = 0.25

			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 then
				arg_379_1.talkMaxDuration = 0
				arg_379_1.dialogCg_.alpha = 1

				arg_379_1.dialog_:SetActive(true)
				SetActive(arg_379_1.leftNameGo_, true)

				arg_379_1.leftNameTxt_.text = arg_379_1:FormatText(StoryNameCfg[1053].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_379_1.leftNameTxt_.transform)

				arg_379_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_379_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_379_1:RecordName(arg_379_1.leftNameTxt_.text)
				SetActive(arg_379_1.iconTrs_.gameObject, true)
				arg_379_1.iconController_:SetSelectedState("hero")

				arg_379_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_littleboya")

				arg_379_1.callingController_:SetSelectedState("normal")

				arg_379_1.keyicon_.color = Color.New(1, 1, 1)
				arg_379_1.icon_.color = Color.New(1, 1, 1)

				local var_382_1 = arg_379_1:GetWordFromCfg(1107402095)
				local var_382_2 = arg_379_1:FormatText(var_382_1.content)

				arg_379_1.text_.text = var_382_2

				LuaForUtil.ClearLinePrefixSymbol(arg_379_1.text_)

				local var_382_4 = 10 <= 0 and var_382_0 or var_382_0 * (utf8.len(var_382_2) / 10)

				if (10 <= 0 and var_382_0 or var_382_0 * (utf8.len(var_382_2) / 10)) > 0 and var_382_0 < var_382_4 then
					arg_379_1.talkMaxDuration = var_382_4

					if var_382_4 + 0 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_4 + 0
					end
				end

				arg_379_1.text_.text = var_382_2
				arg_379_1.typewritter.percent = 0

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107402", "1107402095", "story_v_side_new_1107402.awb") ~= 0 then
					local var_382_5 = manager.audio:GetVoiceLength("story_v_side_new_1107402", "1107402095", "story_v_side_new_1107402.awb") / 1000

					if var_382_5 + 0 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_5 + 0
					end

					if var_382_1.prefab_name ~= "" and arg_379_1.actors_[var_382_1.prefab_name] ~= nil then
						local var_382_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_379_1.actors_[var_382_1.prefab_name].transform, "story_v_side_new_1107402", "1107402095", "story_v_side_new_1107402.awb")

						arg_379_1:RecordAudio("1107402095", var_382_6)
						arg_379_1:RecordAudio("1107402095", var_382_6)
					else
						arg_379_1:AudioAction("play", "voice", "story_v_side_new_1107402", "1107402095", "story_v_side_new_1107402.awb")
					end

					arg_379_1:RecordHistoryTalkVoice("story_v_side_new_1107402", "1107402095", "story_v_side_new_1107402.awb")
				end

				arg_379_1:RecordContent(arg_379_1.text_.text)
			end

			local var_382_7 = math.max(var_382_0, arg_379_1.talkMaxDuration)

			if 0 <= arg_379_1.time_ and arg_379_1.time_ < 0 + var_382_7 then
				arg_379_1.typewritter.percent = (arg_379_1.time_ - 0) / var_382_7

				arg_379_1.typewritter:SetDirty()
			end

			if arg_379_1.time_ >= 0 + var_382_7 and arg_379_1.time_ < 0 + var_382_7 + arg_382_0 then
				arg_379_1.typewritter.percent = 1

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(true)
			end
		end

		arg_379_1.nodeConfigList_ = {}

		arg_379_1:InitPlayNodeList()
	end,
	Play1107402096 = function(arg_383_0, arg_383_1)
		arg_383_1.time_ = 0
		arg_383_1.frameCnt_ = 0
		arg_383_1.state_ = "playing"
		arg_383_1.curTalkId_ = 1107402096
		arg_383_1.duration_ = 1.47

		SetActive(arg_383_1.tipsGo_, false)

		function arg_383_1.onSingleLineFinish_()
			arg_383_1.onSingleLineUpdate_ = nil
			arg_383_1.onSingleLineFinish_ = nil
			arg_383_1.state_ = "waiting"
		end

		function arg_383_1.playNext_(arg_385_0)
			if arg_385_0 == 1 then
				arg_383_0:Play1107402097(arg_383_1)
			end
		end

		function arg_383_1.onSingleLineUpdate_(arg_386_0)
			if 0 < arg_383_1.time_ and arg_383_1.time_ <= 0 + arg_386_0 and not isNil(arg_383_1.actors_["1074ui_story"]) and arg_383_1.var_.characterEffect1074ui_story == nil then
				arg_383_1.var_.characterEffect1074ui_story = arg_383_1.actors_["1074ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_386_0 = 0.1

			if 0 <= arg_383_1.time_ and arg_383_1.time_ < 0 + var_386_0 and not isNil(arg_383_1.actors_["1074ui_story"]) then
				if arg_383_1.var_.characterEffect1074ui_story and not isNil(arg_383_1.actors_["1074ui_story"]) then
					arg_383_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_383_1.time_ >= 0 + var_386_0 and arg_383_1.time_ < 0 + var_386_0 + arg_386_0 and not isNil(arg_383_1.actors_["1074ui_story"]) and arg_383_1.var_.characterEffect1074ui_story then
				arg_383_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_386_2 = 0
			local var_386_3 = 0.125

			if 0 < arg_383_1.time_ and arg_383_1.time_ <= var_386_2 + arg_386_0 then
				arg_383_1.talkMaxDuration = 0
				arg_383_1.dialogCg_.alpha = 1

				arg_383_1.dialog_:SetActive(true)
				SetActive(arg_383_1.leftNameGo_, true)

				arg_383_1.leftNameTxt_.text = arg_383_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_383_1.leftNameTxt_.transform)

				arg_383_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_383_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_383_1:RecordName(arg_383_1.leftNameTxt_.text)
				SetActive(arg_383_1.iconTrs_.gameObject, true)
				arg_383_1.iconController_:SetSelectedState("hero")

				arg_383_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1074")

				arg_383_1.callingController_:SetSelectedState("normal")

				arg_383_1.keyicon_.color = Color.New(1, 1, 1)
				arg_383_1.icon_.color = Color.New(1, 1, 1)

				local var_386_4 = arg_383_1:GetWordFromCfg(1107402096)
				local var_386_5 = arg_383_1:FormatText(var_386_4.content)

				arg_383_1.text_.text = var_386_5

				LuaForUtil.ClearLinePrefixSymbol(arg_383_1.text_)

				local var_386_7 = 5 <= 0 and var_386_3 or var_386_3 * (utf8.len(var_386_5) / 5)

				if (5 <= 0 and var_386_3 or var_386_3 * (utf8.len(var_386_5) / 5)) > 0 and var_386_3 < var_386_7 then
					arg_383_1.talkMaxDuration = var_386_7

					if var_386_7 + var_386_2 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_7 + var_386_2
					end
				end

				arg_383_1.text_.text = var_386_5
				arg_383_1.typewritter.percent = 0

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107402", "1107402096", "story_v_side_new_1107402.awb") ~= 0 then
					local var_386_8 = manager.audio:GetVoiceLength("story_v_side_new_1107402", "1107402096", "story_v_side_new_1107402.awb") / 1000

					if var_386_8 + var_386_2 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_8 + var_386_2
					end

					if var_386_4.prefab_name ~= "" and arg_383_1.actors_[var_386_4.prefab_name] ~= nil then
						local var_386_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_383_1.actors_[var_386_4.prefab_name].transform, "story_v_side_new_1107402", "1107402096", "story_v_side_new_1107402.awb")

						arg_383_1:RecordAudio("1107402096", var_386_9)
						arg_383_1:RecordAudio("1107402096", var_386_9)
					else
						arg_383_1:AudioAction("play", "voice", "story_v_side_new_1107402", "1107402096", "story_v_side_new_1107402.awb")
					end

					arg_383_1:RecordHistoryTalkVoice("story_v_side_new_1107402", "1107402096", "story_v_side_new_1107402.awb")
				end

				arg_383_1:RecordContent(arg_383_1.text_.text)
			end

			local var_386_10 = math.max(var_386_3, arg_383_1.talkMaxDuration)

			if var_386_2 <= arg_383_1.time_ and arg_383_1.time_ < var_386_2 + var_386_10 then
				arg_383_1.typewritter.percent = (arg_383_1.time_ - var_386_2) / var_386_10

				arg_383_1.typewritter:SetDirty()
			end

			if arg_383_1.time_ >= var_386_2 + var_386_10 and arg_383_1.time_ < var_386_2 + var_386_10 + arg_386_0 then
				arg_383_1.typewritter.percent = 1

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(true)
			end
		end

		arg_383_1.nodeConfigList_ = {}

		arg_383_1:InitPlayNodeList()
	end,
	Play1107402097 = function(arg_387_0, arg_387_1)
		arg_387_1.time_ = 0
		arg_387_1.frameCnt_ = 0
		arg_387_1.state_ = "playing"
		arg_387_1.curTalkId_ = 1107402097
		arg_387_1.duration_ = 5

		SetActive(arg_387_1.tipsGo_, false)

		function arg_387_1.onSingleLineFinish_()
			arg_387_1.onSingleLineUpdate_ = nil
			arg_387_1.onSingleLineFinish_ = nil
			arg_387_1.state_ = "waiting"
		end

		function arg_387_1.playNext_(arg_389_0)
			if arg_389_0 == 1 then
				arg_387_0:Play1107402098(arg_387_1)
			end
		end

		function arg_387_1.onSingleLineUpdate_(arg_390_0)
			if 0 < arg_387_1.time_ and arg_387_1.time_ <= 0 + arg_390_0 and not isNil(arg_387_1.actors_["1074ui_story"]) and arg_387_1.var_.characterEffect1074ui_story == nil then
				arg_387_1.var_.characterEffect1074ui_story = arg_387_1.actors_["1074ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_390_0 = 0.1

			if 0 <= arg_387_1.time_ and arg_387_1.time_ < 0 + var_390_0 and not isNil(arg_387_1.actors_["1074ui_story"]) then
				if arg_387_1.var_.characterEffect1074ui_story and not isNil(arg_387_1.actors_["1074ui_story"]) then
					arg_387_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_387_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_387_1.time_ - 0) / var_390_0)
				end
			end

			if arg_387_1.time_ >= 0 + var_390_0 and arg_387_1.time_ < 0 + var_390_0 + arg_390_0 and not isNil(arg_387_1.actors_["1074ui_story"]) and arg_387_1.var_.characterEffect1074ui_story then
				arg_387_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_387_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			local var_390_1 = arg_387_1.actors_["1074ui_story"].transform

			if 0 < arg_387_1.time_ and arg_387_1.time_ <= 0 + arg_390_0 then
				arg_387_1.var_.moveOldPos1074ui_story = var_390_1.localPosition

				arg_387_1:ShowWeapon(arg_387_1.var_["1074ui_story" .. "Animator"].transform, false)
			end

			local var_390_2 = 0.001

			if 0 <= arg_387_1.time_ and arg_387_1.time_ < 0 + var_390_2 then
				var_390_1.localPosition = Vector3.Lerp(arg_387_1.var_.moveOldPos1074ui_story, Vector3.New(0, 100, 0), (arg_387_1.time_ - 0) / var_390_2)
				var_390_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_390_1.position).x, (manager.ui.mainCamera.transform.position - var_390_1.position).y, (manager.ui.mainCamera.transform.position - var_390_1.position).z)
				var_390_1.localEulerAngles.z = 0
				var_390_1.localEulerAngles.x = 0
				var_390_1.localEulerAngles = var_390_1.localEulerAngles
			end

			if arg_387_1.time_ >= 0 + var_390_2 and arg_387_1.time_ < 0 + var_390_2 + arg_390_0 then
				var_390_1.localPosition = Vector3.New(0, 100, 0)
				var_390_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_390_1.position).x, (manager.ui.mainCamera.transform.position - var_390_1.position).y, (manager.ui.mainCamera.transform.position - var_390_1.position).z)
				var_390_1.localEulerAngles.z = 0
				var_390_1.localEulerAngles.x = 0
				var_390_1.localEulerAngles = var_390_1.localEulerAngles
			end

			local var_390_3 = 0
			local var_390_4 = 0.775

			if 0 < arg_387_1.time_ and arg_387_1.time_ <= var_390_3 + arg_390_0 then
				arg_387_1.talkMaxDuration = 0
				arg_387_1.dialogCg_.alpha = 1

				arg_387_1.dialog_:SetActive(true)
				SetActive(arg_387_1.leftNameGo_, false)

				arg_387_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_387_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_387_1:RecordName(arg_387_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_387_1.iconTrs_.gameObject, false)
				arg_387_1.callingController_:SetSelectedState("normal")

				local var_390_5 = arg_387_1:FormatText(arg_387_1:GetWordFromCfg(1107402097).content)

				arg_387_1.text_.text = var_390_5

				LuaForUtil.ClearLinePrefixSymbol(arg_387_1.text_)

				local var_390_7 = 31 <= 0 and var_390_4 or var_390_4 * (utf8.len(var_390_5) / 31)

				if (31 <= 0 and var_390_4 or var_390_4 * (utf8.len(var_390_5) / 31)) > 0 and var_390_4 < var_390_7 then
					arg_387_1.talkMaxDuration = var_390_7

					if var_390_7 + var_390_3 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_7 + var_390_3
					end
				end

				arg_387_1.text_.text = var_390_5
				arg_387_1.typewritter.percent = 0

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(false)
				arg_387_1:RecordContent(arg_387_1.text_.text)
			end

			local var_390_8 = math.max(var_390_4, arg_387_1.talkMaxDuration)

			if var_390_3 <= arg_387_1.time_ and arg_387_1.time_ < var_390_3 + var_390_8 then
				arg_387_1.typewritter.percent = (arg_387_1.time_ - var_390_3) / var_390_8

				arg_387_1.typewritter:SetDirty()
			end

			if arg_387_1.time_ >= var_390_3 + var_390_8 and arg_387_1.time_ < var_390_3 + var_390_8 + arg_390_0 then
				arg_387_1.typewritter.percent = 1

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(true)
			end
		end

		arg_387_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_387_1:InitPlayNodeList()
	end,
	Play1107402098 = function(arg_391_0, arg_391_1)
		arg_391_1.time_ = 0
		arg_391_1.frameCnt_ = 0
		arg_391_1.state_ = "playing"
		arg_391_1.curTalkId_ = 1107402098
		arg_391_1.duration_ = 5

		SetActive(arg_391_1.tipsGo_, false)

		function arg_391_1.onSingleLineFinish_()
			arg_391_1.onSingleLineUpdate_ = nil
			arg_391_1.onSingleLineFinish_ = nil
			arg_391_1.state_ = "waiting"
		end

		function arg_391_1.playNext_(arg_393_0)
			if arg_393_0 == 1 then
				arg_391_0:Play1107402099(arg_391_1)
			end
		end

		function arg_391_1.onSingleLineUpdate_(arg_394_0)
			local var_394_0 = 0.65

			if 0 < arg_391_1.time_ and arg_391_1.time_ <= 0 + arg_394_0 then
				arg_391_1.talkMaxDuration = 0
				arg_391_1.dialogCg_.alpha = 1

				arg_391_1.dialog_:SetActive(true)
				SetActive(arg_391_1.leftNameGo_, true)

				arg_391_1.leftNameTxt_.text = arg_391_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_391_1.leftNameTxt_.transform)

				arg_391_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_391_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_391_1:RecordName(arg_391_1.leftNameTxt_.text)
				SetActive(arg_391_1.iconTrs_.gameObject, true)
				arg_391_1.iconController_:SetSelectedState("hero")

				arg_391_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_391_1.callingController_:SetSelectedState("normal")

				arg_391_1.keyicon_.color = Color.New(1, 1, 1)
				arg_391_1.icon_.color = Color.New(1, 1, 1)

				local var_394_1 = arg_391_1:FormatText(arg_391_1:GetWordFromCfg(1107402098).content)

				arg_391_1.text_.text = var_394_1

				LuaForUtil.ClearLinePrefixSymbol(arg_391_1.text_)

				local var_394_3 = 26 <= 0 and var_394_0 or var_394_0 * (utf8.len(var_394_1) / 26)

				if (26 <= 0 and var_394_0 or var_394_0 * (utf8.len(var_394_1) / 26)) > 0 and var_394_0 < var_394_3 then
					arg_391_1.talkMaxDuration = var_394_3

					if var_394_3 + 0 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_3 + 0
					end
				end

				arg_391_1.text_.text = var_394_1
				arg_391_1.typewritter.percent = 0

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(false)
				arg_391_1:RecordContent(arg_391_1.text_.text)
			end

			local var_394_4 = math.max(var_394_0, arg_391_1.talkMaxDuration)

			if 0 <= arg_391_1.time_ and arg_391_1.time_ < 0 + var_394_4 then
				arg_391_1.typewritter.percent = (arg_391_1.time_ - 0) / var_394_4

				arg_391_1.typewritter:SetDirty()
			end

			if arg_391_1.time_ >= 0 + var_394_4 and arg_391_1.time_ < 0 + var_394_4 + arg_394_0 then
				arg_391_1.typewritter.percent = 1

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(true)
			end
		end

		arg_391_1.nodeConfigList_ = {}

		arg_391_1:InitPlayNodeList()
	end,
	Play1107402099 = function(arg_395_0, arg_395_1)
		arg_395_1.time_ = 0
		arg_395_1.frameCnt_ = 0
		arg_395_1.state_ = "playing"
		arg_395_1.curTalkId_ = 1107402099
		arg_395_1.duration_ = 5

		SetActive(arg_395_1.tipsGo_, false)

		function arg_395_1.onSingleLineFinish_()
			arg_395_1.onSingleLineUpdate_ = nil
			arg_395_1.onSingleLineFinish_ = nil
			arg_395_1.state_ = "waiting"
		end

		function arg_395_1.playNext_(arg_397_0)
			if arg_397_0 == 1 then
				arg_395_0:Play1107402100(arg_395_1)
			end
		end

		function arg_395_1.onSingleLineUpdate_(arg_398_0)
			local var_398_0 = 0.575

			if 0 < arg_395_1.time_ and arg_395_1.time_ <= 0 + arg_398_0 then
				arg_395_1.talkMaxDuration = 0
				arg_395_1.dialogCg_.alpha = 1

				arg_395_1.dialog_:SetActive(true)
				SetActive(arg_395_1.leftNameGo_, true)

				arg_395_1.leftNameTxt_.text = arg_395_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_395_1.leftNameTxt_.transform)

				arg_395_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_395_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_395_1:RecordName(arg_395_1.leftNameTxt_.text)
				SetActive(arg_395_1.iconTrs_.gameObject, true)
				arg_395_1.iconController_:SetSelectedState("hero")

				arg_395_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_395_1.callingController_:SetSelectedState("normal")

				arg_395_1.keyicon_.color = Color.New(1, 1, 1)
				arg_395_1.icon_.color = Color.New(1, 1, 1)

				local var_398_1 = arg_395_1:FormatText(arg_395_1:GetWordFromCfg(1107402099).content)

				arg_395_1.text_.text = var_398_1

				LuaForUtil.ClearLinePrefixSymbol(arg_395_1.text_)

				local var_398_3 = 23 <= 0 and var_398_0 or var_398_0 * (utf8.len(var_398_1) / 23)

				if (23 <= 0 and var_398_0 or var_398_0 * (utf8.len(var_398_1) / 23)) > 0 and var_398_0 < var_398_3 then
					arg_395_1.talkMaxDuration = var_398_3

					if var_398_3 + 0 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_3 + 0
					end
				end

				arg_395_1.text_.text = var_398_1
				arg_395_1.typewritter.percent = 0

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(false)
				arg_395_1:RecordContent(arg_395_1.text_.text)
			end

			local var_398_4 = math.max(var_398_0, arg_395_1.talkMaxDuration)

			if 0 <= arg_395_1.time_ and arg_395_1.time_ < 0 + var_398_4 then
				arg_395_1.typewritter.percent = (arg_395_1.time_ - 0) / var_398_4

				arg_395_1.typewritter:SetDirty()
			end

			if arg_395_1.time_ >= 0 + var_398_4 and arg_395_1.time_ < 0 + var_398_4 + arg_398_0 then
				arg_395_1.typewritter.percent = 1

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(true)
			end
		end

		arg_395_1.nodeConfigList_ = {}

		arg_395_1:InitPlayNodeList()
	end,
	Play1107402100 = function(arg_399_0, arg_399_1)
		arg_399_1.time_ = 0
		arg_399_1.frameCnt_ = 0
		arg_399_1.state_ = "playing"
		arg_399_1.curTalkId_ = 1107402100
		arg_399_1.duration_ = 6.2

		SetActive(arg_399_1.tipsGo_, false)

		function arg_399_1.onSingleLineFinish_()
			arg_399_1.onSingleLineUpdate_ = nil
			arg_399_1.onSingleLineFinish_ = nil
			arg_399_1.state_ = "waiting"
		end

		function arg_399_1.playNext_(arg_401_0)
			if arg_401_0 == 1 then
				arg_399_0:Play1107402101(arg_399_1)
			end
		end

		function arg_399_1.onSingleLineUpdate_(arg_402_0)
			if 0 < arg_399_1.time_ and arg_399_1.time_ <= 0 + arg_402_0 then
				arg_399_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action1_1")
			end

			if 0 < arg_399_1.time_ and arg_399_1.time_ <= 0 + arg_402_0 then
				arg_399_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_402_0 = arg_399_1.actors_["1074ui_story"]

			if 0 < arg_399_1.time_ and arg_399_1.time_ <= 0 + arg_402_0 and not isNil(var_402_0) and arg_399_1.var_.characterEffect1074ui_story == nil then
				arg_399_1.var_.characterEffect1074ui_story = var_402_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_402_1 = 0.1

			if 0 <= arg_399_1.time_ and arg_399_1.time_ < 0 + var_402_1 and not isNil(var_402_0) then
				if arg_399_1.var_.characterEffect1074ui_story and not isNil(var_402_0) then
					arg_399_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_399_1.time_ >= 0 + var_402_1 and arg_399_1.time_ < 0 + var_402_1 + arg_402_0 and not isNil(var_402_0) and arg_399_1.var_.characterEffect1074ui_story then
				arg_399_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_402_3 = arg_399_1.actors_["1074ui_story"].transform

			if 0 < arg_399_1.time_ and arg_399_1.time_ <= 0 + arg_402_0 then
				arg_399_1.var_.moveOldPos1074ui_story = var_402_3.localPosition

				arg_399_1:ShowWeapon(arg_399_1.var_["1074ui_story" .. "Animator"].transform, false)
			end

			local var_402_4 = 0.001

			if 0 <= arg_399_1.time_ and arg_399_1.time_ < 0 + var_402_4 then
				var_402_3.localPosition = Vector3.Lerp(arg_399_1.var_.moveOldPos1074ui_story, Vector3.New(0, -1.055, -6.12), (arg_399_1.time_ - 0) / var_402_4)
				var_402_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_402_3.position).x, (manager.ui.mainCamera.transform.position - var_402_3.position).y, (manager.ui.mainCamera.transform.position - var_402_3.position).z)
				var_402_3.localEulerAngles.z = 0
				var_402_3.localEulerAngles.x = 0
				var_402_3.localEulerAngles = var_402_3.localEulerAngles
			end

			if arg_399_1.time_ >= 0 + var_402_4 and arg_399_1.time_ < 0 + var_402_4 + arg_402_0 then
				var_402_3.localPosition = Vector3.New(0, -1.055, -6.12)
				var_402_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_402_3.position).x, (manager.ui.mainCamera.transform.position - var_402_3.position).y, (manager.ui.mainCamera.transform.position - var_402_3.position).z)
				var_402_3.localEulerAngles.z = 0
				var_402_3.localEulerAngles.x = 0
				var_402_3.localEulerAngles = var_402_3.localEulerAngles
			end

			local var_402_5 = 0
			local var_402_6 = 0.725

			if 0 < arg_399_1.time_ and arg_399_1.time_ <= var_402_5 + arg_402_0 then
				arg_399_1.talkMaxDuration = 0
				arg_399_1.dialogCg_.alpha = 1

				arg_399_1.dialog_:SetActive(true)
				SetActive(arg_399_1.leftNameGo_, true)

				arg_399_1.leftNameTxt_.text = arg_399_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_399_1.leftNameTxt_.transform)

				arg_399_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_399_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_399_1:RecordName(arg_399_1.leftNameTxt_.text)
				SetActive(arg_399_1.iconTrs_.gameObject, false)
				arg_399_1.callingController_:SetSelectedState("normal")

				local var_402_7 = arg_399_1:GetWordFromCfg(1107402100)
				local var_402_8 = arg_399_1:FormatText(var_402_7.content)

				arg_399_1.text_.text = var_402_8

				LuaForUtil.ClearLinePrefixSymbol(arg_399_1.text_)

				local var_402_10 = 29 <= 0 and var_402_6 or var_402_6 * (utf8.len(var_402_8) / 29)

				if (29 <= 0 and var_402_6 or var_402_6 * (utf8.len(var_402_8) / 29)) > 0 and var_402_6 < var_402_10 then
					arg_399_1.talkMaxDuration = var_402_10

					if var_402_10 + var_402_5 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_10 + var_402_5
					end
				end

				arg_399_1.text_.text = var_402_8
				arg_399_1.typewritter.percent = 0

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107402", "1107402100", "story_v_side_new_1107402.awb") ~= 0 then
					local var_402_11 = manager.audio:GetVoiceLength("story_v_side_new_1107402", "1107402100", "story_v_side_new_1107402.awb") / 1000

					if var_402_11 + var_402_5 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_11 + var_402_5
					end

					if var_402_7.prefab_name ~= "" and arg_399_1.actors_[var_402_7.prefab_name] ~= nil then
						local var_402_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_399_1.actors_[var_402_7.prefab_name].transform, "story_v_side_new_1107402", "1107402100", "story_v_side_new_1107402.awb")

						arg_399_1:RecordAudio("1107402100", var_402_12)
						arg_399_1:RecordAudio("1107402100", var_402_12)
					else
						arg_399_1:AudioAction("play", "voice", "story_v_side_new_1107402", "1107402100", "story_v_side_new_1107402.awb")
					end

					arg_399_1:RecordHistoryTalkVoice("story_v_side_new_1107402", "1107402100", "story_v_side_new_1107402.awb")
				end

				arg_399_1:RecordContent(arg_399_1.text_.text)
			end

			local var_402_13 = math.max(var_402_6, arg_399_1.talkMaxDuration)

			if var_402_5 <= arg_399_1.time_ and arg_399_1.time_ < var_402_5 + var_402_13 then
				arg_399_1.typewritter.percent = (arg_399_1.time_ - var_402_5) / var_402_13

				arg_399_1.typewritter:SetDirty()
			end

			if arg_399_1.time_ >= var_402_5 + var_402_13 and arg_399_1.time_ < var_402_5 + var_402_13 + arg_402_0 then
				arg_399_1.typewritter.percent = 1

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(true)
			end
		end

		arg_399_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_399_1:InitPlayNodeList()
	end,
	Play1107402101 = function(arg_403_0, arg_403_1)
		arg_403_1.time_ = 0
		arg_403_1.frameCnt_ = 0
		arg_403_1.state_ = "playing"
		arg_403_1.curTalkId_ = 1107402101
		arg_403_1.duration_ = 5

		SetActive(arg_403_1.tipsGo_, false)

		function arg_403_1.onSingleLineFinish_()
			arg_403_1.onSingleLineUpdate_ = nil
			arg_403_1.onSingleLineFinish_ = nil
			arg_403_1.state_ = "waiting"
		end

		function arg_403_1.playNext_(arg_405_0)
			if arg_405_0 == 1 then
				arg_403_0:Play1107402102(arg_403_1)
			end
		end

		function arg_403_1.onSingleLineUpdate_(arg_406_0)
			if 0 < arg_403_1.time_ and arg_403_1.time_ <= 0 + arg_406_0 and not isNil(arg_403_1.actors_["1074ui_story"]) and arg_403_1.var_.characterEffect1074ui_story == nil then
				arg_403_1.var_.characterEffect1074ui_story = arg_403_1.actors_["1074ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_406_0 = 0.1

			if 0 <= arg_403_1.time_ and arg_403_1.time_ < 0 + var_406_0 and not isNil(arg_403_1.actors_["1074ui_story"]) then
				if arg_403_1.var_.characterEffect1074ui_story and not isNil(arg_403_1.actors_["1074ui_story"]) then
					arg_403_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_403_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_403_1.time_ - 0) / var_406_0)
				end
			end

			if arg_403_1.time_ >= 0 + var_406_0 and arg_403_1.time_ < 0 + var_406_0 + arg_406_0 and not isNil(arg_403_1.actors_["1074ui_story"]) and arg_403_1.var_.characterEffect1074ui_story then
				arg_403_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_403_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			local var_406_1 = 0
			local var_406_2 = 1.1

			if 0 < arg_403_1.time_ and arg_403_1.time_ <= var_406_1 + arg_406_0 then
				arg_403_1.talkMaxDuration = 0
				arg_403_1.dialogCg_.alpha = 1

				arg_403_1.dialog_:SetActive(true)
				SetActive(arg_403_1.leftNameGo_, true)

				arg_403_1.leftNameTxt_.text = arg_403_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_403_1.leftNameTxt_.transform)

				arg_403_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_403_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_403_1:RecordName(arg_403_1.leftNameTxt_.text)
				SetActive(arg_403_1.iconTrs_.gameObject, true)
				arg_403_1.iconController_:SetSelectedState("hero")

				arg_403_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_403_1.callingController_:SetSelectedState("normal")

				arg_403_1.keyicon_.color = Color.New(1, 1, 1)
				arg_403_1.icon_.color = Color.New(1, 1, 1)

				local var_406_3 = arg_403_1:FormatText(arg_403_1:GetWordFromCfg(1107402101).content)

				arg_403_1.text_.text = var_406_3

				LuaForUtil.ClearLinePrefixSymbol(arg_403_1.text_)

				local var_406_5 = 44 <= 0 and var_406_2 or var_406_2 * (utf8.len(var_406_3) / 44)

				if (44 <= 0 and var_406_2 or var_406_2 * (utf8.len(var_406_3) / 44)) > 0 and var_406_2 < var_406_5 then
					arg_403_1.talkMaxDuration = var_406_5

					if var_406_5 + var_406_1 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_5 + var_406_1
					end
				end

				arg_403_1.text_.text = var_406_3
				arg_403_1.typewritter.percent = 0

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(false)
				arg_403_1:RecordContent(arg_403_1.text_.text)
			end

			local var_406_6 = math.max(var_406_2, arg_403_1.talkMaxDuration)

			if var_406_1 <= arg_403_1.time_ and arg_403_1.time_ < var_406_1 + var_406_6 then
				arg_403_1.typewritter.percent = (arg_403_1.time_ - var_406_1) / var_406_6

				arg_403_1.typewritter:SetDirty()
			end

			if arg_403_1.time_ >= var_406_1 + var_406_6 and arg_403_1.time_ < var_406_1 + var_406_6 + arg_406_0 then
				arg_403_1.typewritter.percent = 1

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(true)
			end
		end

		arg_403_1.nodeConfigList_ = {}

		arg_403_1:InitPlayNodeList()
	end,
	Play1107402102 = function(arg_407_0, arg_407_1)
		arg_407_1.time_ = 0
		arg_407_1.frameCnt_ = 0
		arg_407_1.state_ = "playing"
		arg_407_1.curTalkId_ = 1107402102
		arg_407_1.duration_ = 5

		SetActive(arg_407_1.tipsGo_, false)

		function arg_407_1.onSingleLineFinish_()
			arg_407_1.onSingleLineUpdate_ = nil
			arg_407_1.onSingleLineFinish_ = nil
			arg_407_1.state_ = "waiting"
		end

		function arg_407_1.playNext_(arg_409_0)
			if arg_409_0 == 1 then
				arg_407_0:Play1107402103(arg_407_1)
			end
		end

		function arg_407_1.onSingleLineUpdate_(arg_410_0)
			local var_410_0 = 0.475

			if 0 < arg_407_1.time_ and arg_407_1.time_ <= 0 + arg_410_0 then
				arg_407_1.talkMaxDuration = 0
				arg_407_1.dialogCg_.alpha = 1

				arg_407_1.dialog_:SetActive(true)
				SetActive(arg_407_1.leftNameGo_, true)

				arg_407_1.leftNameTxt_.text = arg_407_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_407_1.leftNameTxt_.transform)

				arg_407_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_407_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_407_1:RecordName(arg_407_1.leftNameTxt_.text)
				SetActive(arg_407_1.iconTrs_.gameObject, true)
				arg_407_1.iconController_:SetSelectedState("hero")

				arg_407_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_407_1.callingController_:SetSelectedState("normal")

				arg_407_1.keyicon_.color = Color.New(1, 1, 1)
				arg_407_1.icon_.color = Color.New(1, 1, 1)

				local var_410_1 = arg_407_1:FormatText(arg_407_1:GetWordFromCfg(1107402102).content)

				arg_407_1.text_.text = var_410_1

				LuaForUtil.ClearLinePrefixSymbol(arg_407_1.text_)

				local var_410_3 = 19 <= 0 and var_410_0 or var_410_0 * (utf8.len(var_410_1) / 19)

				if (19 <= 0 and var_410_0 or var_410_0 * (utf8.len(var_410_1) / 19)) > 0 and var_410_0 < var_410_3 then
					arg_407_1.talkMaxDuration = var_410_3

					if var_410_3 + 0 > arg_407_1.duration_ then
						arg_407_1.duration_ = var_410_3 + 0
					end
				end

				arg_407_1.text_.text = var_410_1
				arg_407_1.typewritter.percent = 0

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(false)
				arg_407_1:RecordContent(arg_407_1.text_.text)
			end

			local var_410_4 = math.max(var_410_0, arg_407_1.talkMaxDuration)

			if 0 <= arg_407_1.time_ and arg_407_1.time_ < 0 + var_410_4 then
				arg_407_1.typewritter.percent = (arg_407_1.time_ - 0) / var_410_4

				arg_407_1.typewritter:SetDirty()
			end

			if arg_407_1.time_ >= 0 + var_410_4 and arg_407_1.time_ < 0 + var_410_4 + arg_410_0 then
				arg_407_1.typewritter.percent = 1

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(true)
			end
		end

		arg_407_1.nodeConfigList_ = {}

		arg_407_1:InitPlayNodeList()
	end,
	Play1107402103 = function(arg_411_0, arg_411_1)
		arg_411_1.time_ = 0
		arg_411_1.frameCnt_ = 0
		arg_411_1.state_ = "playing"
		arg_411_1.curTalkId_ = 1107402103
		arg_411_1.duration_ = 2

		SetActive(arg_411_1.tipsGo_, false)

		function arg_411_1.onSingleLineFinish_()
			arg_411_1.onSingleLineUpdate_ = nil
			arg_411_1.onSingleLineFinish_ = nil
			arg_411_1.state_ = "waiting"
		end

		function arg_411_1.playNext_(arg_413_0)
			if arg_413_0 == 1 then
				arg_411_0:Play1107402104(arg_411_1)
			end
		end

		function arg_411_1.onSingleLineUpdate_(arg_414_0)
			if 0 < arg_411_1.time_ and arg_411_1.time_ <= 0 + arg_414_0 and not isNil(arg_411_1.actors_["1074ui_story"]) and arg_411_1.var_.characterEffect1074ui_story == nil then
				arg_411_1.var_.characterEffect1074ui_story = arg_411_1.actors_["1074ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_414_0 = 0.1

			if 0 <= arg_411_1.time_ and arg_411_1.time_ < 0 + var_414_0 and not isNil(arg_411_1.actors_["1074ui_story"]) then
				if arg_411_1.var_.characterEffect1074ui_story and not isNil(arg_411_1.actors_["1074ui_story"]) then
					arg_411_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_411_1.time_ >= 0 + var_414_0 and arg_411_1.time_ < 0 + var_414_0 + arg_414_0 and not isNil(arg_411_1.actors_["1074ui_story"]) and arg_411_1.var_.characterEffect1074ui_story then
				arg_411_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			if 0 < arg_411_1.time_ and arg_411_1.time_ <= 0 + arg_414_0 then
				arg_411_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action6_1")
			end

			local var_414_2 = 0
			local var_414_3 = 0.125

			if 0 < arg_411_1.time_ and arg_411_1.time_ <= var_414_2 + arg_414_0 then
				arg_411_1.talkMaxDuration = 0
				arg_411_1.dialogCg_.alpha = 1

				arg_411_1.dialog_:SetActive(true)
				SetActive(arg_411_1.leftNameGo_, true)

				arg_411_1.leftNameTxt_.text = arg_411_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_411_1.leftNameTxt_.transform)

				arg_411_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_411_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_411_1:RecordName(arg_411_1.leftNameTxt_.text)
				SetActive(arg_411_1.iconTrs_.gameObject, false)
				arg_411_1.callingController_:SetSelectedState("normal")

				local var_414_4 = arg_411_1:GetWordFromCfg(1107402103)
				local var_414_5 = arg_411_1:FormatText(var_414_4.content)

				arg_411_1.text_.text = var_414_5

				LuaForUtil.ClearLinePrefixSymbol(arg_411_1.text_)

				local var_414_7 = 5 <= 0 and var_414_3 or var_414_3 * (utf8.len(var_414_5) / 5)

				if (5 <= 0 and var_414_3 or var_414_3 * (utf8.len(var_414_5) / 5)) > 0 and var_414_3 < var_414_7 then
					arg_411_1.talkMaxDuration = var_414_7

					if var_414_7 + var_414_2 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_7 + var_414_2
					end
				end

				arg_411_1.text_.text = var_414_5
				arg_411_1.typewritter.percent = 0

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107402", "1107402103", "story_v_side_new_1107402.awb") ~= 0 then
					local var_414_8 = manager.audio:GetVoiceLength("story_v_side_new_1107402", "1107402103", "story_v_side_new_1107402.awb") / 1000

					if var_414_8 + var_414_2 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_8 + var_414_2
					end

					if var_414_4.prefab_name ~= "" and arg_411_1.actors_[var_414_4.prefab_name] ~= nil then
						local var_414_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_411_1.actors_[var_414_4.prefab_name].transform, "story_v_side_new_1107402", "1107402103", "story_v_side_new_1107402.awb")

						arg_411_1:RecordAudio("1107402103", var_414_9)
						arg_411_1:RecordAudio("1107402103", var_414_9)
					else
						arg_411_1:AudioAction("play", "voice", "story_v_side_new_1107402", "1107402103", "story_v_side_new_1107402.awb")
					end

					arg_411_1:RecordHistoryTalkVoice("story_v_side_new_1107402", "1107402103", "story_v_side_new_1107402.awb")
				end

				arg_411_1:RecordContent(arg_411_1.text_.text)
			end

			local var_414_10 = math.max(var_414_3, arg_411_1.talkMaxDuration)

			if var_414_2 <= arg_411_1.time_ and arg_411_1.time_ < var_414_2 + var_414_10 then
				arg_411_1.typewritter.percent = (arg_411_1.time_ - var_414_2) / var_414_10

				arg_411_1.typewritter:SetDirty()
			end

			if arg_411_1.time_ >= var_414_2 + var_414_10 and arg_411_1.time_ < var_414_2 + var_414_10 + arg_414_0 then
				arg_411_1.typewritter.percent = 1

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(true)
			end
		end

		arg_411_1.nodeConfigList_ = {}

		arg_411_1:InitPlayNodeList()
	end,
	Play1107402104 = function(arg_415_0, arg_415_1)
		arg_415_1.time_ = 0
		arg_415_1.frameCnt_ = 0
		arg_415_1.state_ = "playing"
		arg_415_1.curTalkId_ = 1107402104
		arg_415_1.duration_ = 5

		SetActive(arg_415_1.tipsGo_, false)

		function arg_415_1.onSingleLineFinish_()
			arg_415_1.onSingleLineUpdate_ = nil
			arg_415_1.onSingleLineFinish_ = nil
			arg_415_1.state_ = "waiting"
		end

		function arg_415_1.playNext_(arg_417_0)
			if arg_417_0 == 1 then
				arg_415_0:Play1107402105(arg_415_1)
			end
		end

		function arg_415_1.onSingleLineUpdate_(arg_418_0)
			if 0 < arg_415_1.time_ and arg_415_1.time_ <= 0 + arg_418_0 and not isNil(arg_415_1.actors_["1074ui_story"]) and arg_415_1.var_.characterEffect1074ui_story == nil then
				arg_415_1.var_.characterEffect1074ui_story = arg_415_1.actors_["1074ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_418_0 = 0.1

			if 0 <= arg_415_1.time_ and arg_415_1.time_ < 0 + var_418_0 and not isNil(arg_415_1.actors_["1074ui_story"]) then
				if arg_415_1.var_.characterEffect1074ui_story and not isNil(arg_415_1.actors_["1074ui_story"]) then
					arg_415_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_415_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_415_1.time_ - 0) / var_418_0)
				end
			end

			if arg_415_1.time_ >= 0 + var_418_0 and arg_415_1.time_ < 0 + var_418_0 + arg_418_0 and not isNil(arg_415_1.actors_["1074ui_story"]) and arg_415_1.var_.characterEffect1074ui_story then
				arg_415_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_415_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			local var_418_1 = 0
			local var_418_2 = 0.2

			if 0 < arg_415_1.time_ and arg_415_1.time_ <= var_418_1 + arg_418_0 then
				arg_415_1.talkMaxDuration = 0
				arg_415_1.dialogCg_.alpha = 1

				arg_415_1.dialog_:SetActive(true)
				SetActive(arg_415_1.leftNameGo_, true)

				arg_415_1.leftNameTxt_.text = arg_415_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_415_1.leftNameTxt_.transform)

				arg_415_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_415_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_415_1:RecordName(arg_415_1.leftNameTxt_.text)
				SetActive(arg_415_1.iconTrs_.gameObject, true)
				arg_415_1.iconController_:SetSelectedState("hero")

				arg_415_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_415_1.callingController_:SetSelectedState("normal")

				arg_415_1.keyicon_.color = Color.New(1, 1, 1)
				arg_415_1.icon_.color = Color.New(1, 1, 1)

				local var_418_3 = arg_415_1:FormatText(arg_415_1:GetWordFromCfg(1107402104).content)

				arg_415_1.text_.text = var_418_3

				LuaForUtil.ClearLinePrefixSymbol(arg_415_1.text_)

				local var_418_5 = 8 <= 0 and var_418_2 or var_418_2 * (utf8.len(var_418_3) / 8)

				if (8 <= 0 and var_418_2 or var_418_2 * (utf8.len(var_418_3) / 8)) > 0 and var_418_2 < var_418_5 then
					arg_415_1.talkMaxDuration = var_418_5

					if var_418_5 + var_418_1 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_5 + var_418_1
					end
				end

				arg_415_1.text_.text = var_418_3
				arg_415_1.typewritter.percent = 0

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(false)
				arg_415_1:RecordContent(arg_415_1.text_.text)
			end

			local var_418_6 = math.max(var_418_2, arg_415_1.talkMaxDuration)

			if var_418_1 <= arg_415_1.time_ and arg_415_1.time_ < var_418_1 + var_418_6 then
				arg_415_1.typewritter.percent = (arg_415_1.time_ - var_418_1) / var_418_6

				arg_415_1.typewritter:SetDirty()
			end

			if arg_415_1.time_ >= var_418_1 + var_418_6 and arg_415_1.time_ < var_418_1 + var_418_6 + arg_418_0 then
				arg_415_1.typewritter.percent = 1

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(true)
			end
		end

		arg_415_1.nodeConfigList_ = {}

		arg_415_1:InitPlayNodeList()
	end,
	Play1107402105 = function(arg_419_0, arg_419_1)
		arg_419_1.time_ = 0
		arg_419_1.frameCnt_ = 0
		arg_419_1.state_ = "playing"
		arg_419_1.curTalkId_ = 1107402105
		arg_419_1.duration_ = 4.37

		SetActive(arg_419_1.tipsGo_, false)

		function arg_419_1.onSingleLineFinish_()
			arg_419_1.onSingleLineUpdate_ = nil
			arg_419_1.onSingleLineFinish_ = nil
			arg_419_1.state_ = "waiting"
		end

		function arg_419_1.playNext_(arg_421_0)
			if arg_421_0 == 1 then
				arg_419_0:Play1107402106(arg_419_1)
			end
		end

		function arg_419_1.onSingleLineUpdate_(arg_422_0)
			if 0 < arg_419_1.time_ and arg_419_1.time_ <= 0 + arg_422_0 and not isNil(arg_419_1.actors_["1074ui_story"]) and arg_419_1.var_.characterEffect1074ui_story == nil then
				arg_419_1.var_.characterEffect1074ui_story = arg_419_1.actors_["1074ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_422_0 = 0.1

			if 0 <= arg_419_1.time_ and arg_419_1.time_ < 0 + var_422_0 and not isNil(arg_419_1.actors_["1074ui_story"]) then
				if arg_419_1.var_.characterEffect1074ui_story and not isNil(arg_419_1.actors_["1074ui_story"]) then
					arg_419_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_419_1.time_ >= 0 + var_422_0 and arg_419_1.time_ < 0 + var_422_0 + arg_422_0 and not isNil(arg_419_1.actors_["1074ui_story"]) and arg_419_1.var_.characterEffect1074ui_story then
				arg_419_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_422_2 = 0
			local var_422_3 = 0.6

			if 0 < arg_419_1.time_ and arg_419_1.time_ <= var_422_2 + arg_422_0 then
				arg_419_1.talkMaxDuration = 0
				arg_419_1.dialogCg_.alpha = 1

				arg_419_1.dialog_:SetActive(true)
				SetActive(arg_419_1.leftNameGo_, true)

				arg_419_1.leftNameTxt_.text = arg_419_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_419_1.leftNameTxt_.transform)

				arg_419_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_419_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_419_1:RecordName(arg_419_1.leftNameTxt_.text)
				SetActive(arg_419_1.iconTrs_.gameObject, false)
				arg_419_1.callingController_:SetSelectedState("normal")

				local var_422_4 = arg_419_1:GetWordFromCfg(1107402105)
				local var_422_5 = arg_419_1:FormatText(var_422_4.content)

				arg_419_1.text_.text = var_422_5

				LuaForUtil.ClearLinePrefixSymbol(arg_419_1.text_)

				local var_422_7 = 24 <= 0 and var_422_3 or var_422_3 * (utf8.len(var_422_5) / 24)

				if (24 <= 0 and var_422_3 or var_422_3 * (utf8.len(var_422_5) / 24)) > 0 and var_422_3 < var_422_7 then
					arg_419_1.talkMaxDuration = var_422_7

					if var_422_7 + var_422_2 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_7 + var_422_2
					end
				end

				arg_419_1.text_.text = var_422_5
				arg_419_1.typewritter.percent = 0

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107402", "1107402105", "story_v_side_new_1107402.awb") ~= 0 then
					local var_422_8 = manager.audio:GetVoiceLength("story_v_side_new_1107402", "1107402105", "story_v_side_new_1107402.awb") / 1000

					if var_422_8 + var_422_2 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_8 + var_422_2
					end

					if var_422_4.prefab_name ~= "" and arg_419_1.actors_[var_422_4.prefab_name] ~= nil then
						local var_422_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_419_1.actors_[var_422_4.prefab_name].transform, "story_v_side_new_1107402", "1107402105", "story_v_side_new_1107402.awb")

						arg_419_1:RecordAudio("1107402105", var_422_9)
						arg_419_1:RecordAudio("1107402105", var_422_9)
					else
						arg_419_1:AudioAction("play", "voice", "story_v_side_new_1107402", "1107402105", "story_v_side_new_1107402.awb")
					end

					arg_419_1:RecordHistoryTalkVoice("story_v_side_new_1107402", "1107402105", "story_v_side_new_1107402.awb")
				end

				arg_419_1:RecordContent(arg_419_1.text_.text)
			end

			local var_422_10 = math.max(var_422_3, arg_419_1.talkMaxDuration)

			if var_422_2 <= arg_419_1.time_ and arg_419_1.time_ < var_422_2 + var_422_10 then
				arg_419_1.typewritter.percent = (arg_419_1.time_ - var_422_2) / var_422_10

				arg_419_1.typewritter:SetDirty()
			end

			if arg_419_1.time_ >= var_422_2 + var_422_10 and arg_419_1.time_ < var_422_2 + var_422_10 + arg_422_0 then
				arg_419_1.typewritter.percent = 1

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(true)
			end
		end

		arg_419_1.nodeConfigList_ = {}

		arg_419_1:InitPlayNodeList()
	end,
	Play1107402106 = function(arg_423_0, arg_423_1)
		arg_423_1.time_ = 0
		arg_423_1.frameCnt_ = 0
		arg_423_1.state_ = "playing"
		arg_423_1.curTalkId_ = 1107402106
		arg_423_1.duration_ = 5

		SetActive(arg_423_1.tipsGo_, false)

		function arg_423_1.onSingleLineFinish_()
			arg_423_1.onSingleLineUpdate_ = nil
			arg_423_1.onSingleLineFinish_ = nil
			arg_423_1.state_ = "waiting"
		end

		function arg_423_1.playNext_(arg_425_0)
			if arg_425_0 == 1 then
				arg_423_0:Play1107402107(arg_423_1)
			end
		end

		function arg_423_1.onSingleLineUpdate_(arg_426_0)
			if 0 < arg_423_1.time_ and arg_423_1.time_ <= 0 + arg_426_0 and not isNil(arg_423_1.actors_["1074ui_story"]) and arg_423_1.var_.characterEffect1074ui_story == nil then
				arg_423_1.var_.characterEffect1074ui_story = arg_423_1.actors_["1074ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_426_0 = 0.1

			if 0 <= arg_423_1.time_ and arg_423_1.time_ < 0 + var_426_0 and not isNil(arg_423_1.actors_["1074ui_story"]) then
				if arg_423_1.var_.characterEffect1074ui_story and not isNil(arg_423_1.actors_["1074ui_story"]) then
					arg_423_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_423_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_423_1.time_ - 0) / var_426_0)
				end
			end

			if arg_423_1.time_ >= 0 + var_426_0 and arg_423_1.time_ < 0 + var_426_0 + arg_426_0 and not isNil(arg_423_1.actors_["1074ui_story"]) and arg_423_1.var_.characterEffect1074ui_story then
				arg_423_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_423_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			local var_426_1 = 0
			local var_426_2 = 0.6

			if 0 < arg_423_1.time_ and arg_423_1.time_ <= var_426_1 + arg_426_0 then
				arg_423_1.talkMaxDuration = 0
				arg_423_1.dialogCg_.alpha = 1

				arg_423_1.dialog_:SetActive(true)
				SetActive(arg_423_1.leftNameGo_, false)

				arg_423_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_423_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_423_1:RecordName(arg_423_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_423_1.iconTrs_.gameObject, false)
				arg_423_1.callingController_:SetSelectedState("normal")

				local var_426_3 = arg_423_1:FormatText(arg_423_1:GetWordFromCfg(1107402106).content)

				arg_423_1.text_.text = var_426_3

				LuaForUtil.ClearLinePrefixSymbol(arg_423_1.text_)

				local var_426_5 = 24 <= 0 and var_426_2 or var_426_2 * (utf8.len(var_426_3) / 24)

				if (24 <= 0 and var_426_2 or var_426_2 * (utf8.len(var_426_3) / 24)) > 0 and var_426_2 < var_426_5 then
					arg_423_1.talkMaxDuration = var_426_5

					if var_426_5 + var_426_1 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_5 + var_426_1
					end
				end

				arg_423_1.text_.text = var_426_3
				arg_423_1.typewritter.percent = 0

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(false)
				arg_423_1:RecordContent(arg_423_1.text_.text)
			end

			local var_426_6 = math.max(var_426_2, arg_423_1.talkMaxDuration)

			if var_426_1 <= arg_423_1.time_ and arg_423_1.time_ < var_426_1 + var_426_6 then
				arg_423_1.typewritter.percent = (arg_423_1.time_ - var_426_1) / var_426_6

				arg_423_1.typewritter:SetDirty()
			end

			if arg_423_1.time_ >= var_426_1 + var_426_6 and arg_423_1.time_ < var_426_1 + var_426_6 + arg_426_0 then
				arg_423_1.typewritter.percent = 1

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(true)
			end
		end

		arg_423_1.nodeConfigList_ = {}

		arg_423_1:InitPlayNodeList()
	end,
	Play1107402107 = function(arg_427_0, arg_427_1)
		arg_427_1.time_ = 0
		arg_427_1.frameCnt_ = 0
		arg_427_1.state_ = "playing"
		arg_427_1.curTalkId_ = 1107402107
		arg_427_1.duration_ = 6.23

		SetActive(arg_427_1.tipsGo_, false)

		function arg_427_1.onSingleLineFinish_()
			arg_427_1.onSingleLineUpdate_ = nil
			arg_427_1.onSingleLineFinish_ = nil
			arg_427_1.state_ = "waiting"
		end

		function arg_427_1.playNext_(arg_429_0)
			if arg_429_0 == 1 then
				arg_427_0:Play1107402108(arg_427_1)
			end
		end

		function arg_427_1.onSingleLineUpdate_(arg_430_0)
			if 0 < arg_427_1.time_ and arg_427_1.time_ <= 0 + arg_430_0 and not isNil(arg_427_1.actors_["1074ui_story"]) and arg_427_1.var_.characterEffect1074ui_story == nil then
				arg_427_1.var_.characterEffect1074ui_story = arg_427_1.actors_["1074ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_430_0 = 0.1

			if 0 <= arg_427_1.time_ and arg_427_1.time_ < 0 + var_430_0 and not isNil(arg_427_1.actors_["1074ui_story"]) then
				if arg_427_1.var_.characterEffect1074ui_story and not isNil(arg_427_1.actors_["1074ui_story"]) then
					arg_427_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_427_1.time_ >= 0 + var_430_0 and arg_427_1.time_ < 0 + var_430_0 + arg_430_0 and not isNil(arg_427_1.actors_["1074ui_story"]) and arg_427_1.var_.characterEffect1074ui_story then
				arg_427_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_430_2 = 0
			local var_430_3 = 0.525

			if 0 < arg_427_1.time_ and arg_427_1.time_ <= var_430_2 + arg_430_0 then
				arg_427_1.talkMaxDuration = 0
				arg_427_1.dialogCg_.alpha = 1

				arg_427_1.dialog_:SetActive(true)
				SetActive(arg_427_1.leftNameGo_, true)

				arg_427_1.leftNameTxt_.text = arg_427_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_427_1.leftNameTxt_.transform)

				arg_427_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_427_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_427_1:RecordName(arg_427_1.leftNameTxt_.text)
				SetActive(arg_427_1.iconTrs_.gameObject, false)
				arg_427_1.callingController_:SetSelectedState("normal")

				local var_430_4 = arg_427_1:GetWordFromCfg(1107402107)
				local var_430_5 = arg_427_1:FormatText(var_430_4.content)

				arg_427_1.text_.text = var_430_5

				LuaForUtil.ClearLinePrefixSymbol(arg_427_1.text_)

				local var_430_7 = 21 <= 0 and var_430_3 or var_430_3 * (utf8.len(var_430_5) / 21)

				if (21 <= 0 and var_430_3 or var_430_3 * (utf8.len(var_430_5) / 21)) > 0 and var_430_3 < var_430_7 then
					arg_427_1.talkMaxDuration = var_430_7

					if var_430_7 + var_430_2 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_7 + var_430_2
					end
				end

				arg_427_1.text_.text = var_430_5
				arg_427_1.typewritter.percent = 0

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107402", "1107402107", "story_v_side_new_1107402.awb") ~= 0 then
					local var_430_8 = manager.audio:GetVoiceLength("story_v_side_new_1107402", "1107402107", "story_v_side_new_1107402.awb") / 1000

					if var_430_8 + var_430_2 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_8 + var_430_2
					end

					if var_430_4.prefab_name ~= "" and arg_427_1.actors_[var_430_4.prefab_name] ~= nil then
						local var_430_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_427_1.actors_[var_430_4.prefab_name].transform, "story_v_side_new_1107402", "1107402107", "story_v_side_new_1107402.awb")

						arg_427_1:RecordAudio("1107402107", var_430_9)
						arg_427_1:RecordAudio("1107402107", var_430_9)
					else
						arg_427_1:AudioAction("play", "voice", "story_v_side_new_1107402", "1107402107", "story_v_side_new_1107402.awb")
					end

					arg_427_1:RecordHistoryTalkVoice("story_v_side_new_1107402", "1107402107", "story_v_side_new_1107402.awb")
				end

				arg_427_1:RecordContent(arg_427_1.text_.text)
			end

			local var_430_10 = math.max(var_430_3, arg_427_1.talkMaxDuration)

			if var_430_2 <= arg_427_1.time_ and arg_427_1.time_ < var_430_2 + var_430_10 then
				arg_427_1.typewritter.percent = (arg_427_1.time_ - var_430_2) / var_430_10

				arg_427_1.typewritter:SetDirty()
			end

			if arg_427_1.time_ >= var_430_2 + var_430_10 and arg_427_1.time_ < var_430_2 + var_430_10 + arg_430_0 then
				arg_427_1.typewritter.percent = 1

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(true)
			end
		end

		arg_427_1.nodeConfigList_ = {}

		arg_427_1:InitPlayNodeList()
	end,
	Play1107402108 = function(arg_431_0, arg_431_1)
		arg_431_1.time_ = 0
		arg_431_1.frameCnt_ = 0
		arg_431_1.state_ = "playing"
		arg_431_1.curTalkId_ = 1107402108
		arg_431_1.duration_ = 4.27

		SetActive(arg_431_1.tipsGo_, false)

		function arg_431_1.onSingleLineFinish_()
			arg_431_1.onSingleLineUpdate_ = nil
			arg_431_1.onSingleLineFinish_ = nil
			arg_431_1.state_ = "waiting"
		end

		function arg_431_1.playNext_(arg_433_0)
			if arg_433_0 == 1 then
				arg_431_0:Play1107402109(arg_431_1)
			end
		end

		function arg_431_1.onSingleLineUpdate_(arg_434_0)
			local var_434_0 = 0.325

			if 0 < arg_431_1.time_ and arg_431_1.time_ <= 0 + arg_434_0 then
				arg_431_1.talkMaxDuration = 0
				arg_431_1.dialogCg_.alpha = 1

				arg_431_1.dialog_:SetActive(true)
				SetActive(arg_431_1.leftNameGo_, true)

				arg_431_1.leftNameTxt_.text = arg_431_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_431_1.leftNameTxt_.transform)

				arg_431_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_431_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_431_1:RecordName(arg_431_1.leftNameTxt_.text)
				SetActive(arg_431_1.iconTrs_.gameObject, false)
				arg_431_1.callingController_:SetSelectedState("normal")

				local var_434_1 = arg_431_1:GetWordFromCfg(1107402108)
				local var_434_2 = arg_431_1:FormatText(var_434_1.content)

				arg_431_1.text_.text = var_434_2

				LuaForUtil.ClearLinePrefixSymbol(arg_431_1.text_)

				local var_434_4 = 13 <= 0 and var_434_0 or var_434_0 * (utf8.len(var_434_2) / 13)

				if (13 <= 0 and var_434_0 or var_434_0 * (utf8.len(var_434_2) / 13)) > 0 and var_434_0 < var_434_4 then
					arg_431_1.talkMaxDuration = var_434_4

					if var_434_4 + 0 > arg_431_1.duration_ then
						arg_431_1.duration_ = var_434_4 + 0
					end
				end

				arg_431_1.text_.text = var_434_2
				arg_431_1.typewritter.percent = 0

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107402", "1107402108", "story_v_side_new_1107402.awb") ~= 0 then
					local var_434_5 = manager.audio:GetVoiceLength("story_v_side_new_1107402", "1107402108", "story_v_side_new_1107402.awb") / 1000

					if var_434_5 + 0 > arg_431_1.duration_ then
						arg_431_1.duration_ = var_434_5 + 0
					end

					if var_434_1.prefab_name ~= "" and arg_431_1.actors_[var_434_1.prefab_name] ~= nil then
						local var_434_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_431_1.actors_[var_434_1.prefab_name].transform, "story_v_side_new_1107402", "1107402108", "story_v_side_new_1107402.awb")

						arg_431_1:RecordAudio("1107402108", var_434_6)
						arg_431_1:RecordAudio("1107402108", var_434_6)
					else
						arg_431_1:AudioAction("play", "voice", "story_v_side_new_1107402", "1107402108", "story_v_side_new_1107402.awb")
					end

					arg_431_1:RecordHistoryTalkVoice("story_v_side_new_1107402", "1107402108", "story_v_side_new_1107402.awb")
				end

				arg_431_1:RecordContent(arg_431_1.text_.text)
			end

			local var_434_7 = math.max(var_434_0, arg_431_1.talkMaxDuration)

			if 0 <= arg_431_1.time_ and arg_431_1.time_ < 0 + var_434_7 then
				arg_431_1.typewritter.percent = (arg_431_1.time_ - 0) / var_434_7

				arg_431_1.typewritter:SetDirty()
			end

			if arg_431_1.time_ >= 0 + var_434_7 and arg_431_1.time_ < 0 + var_434_7 + arg_434_0 then
				arg_431_1.typewritter.percent = 1

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(true)
			end
		end

		arg_431_1.nodeConfigList_ = {}

		arg_431_1:InitPlayNodeList()
	end,
	Play1107402109 = function(arg_435_0, arg_435_1)
		arg_435_1.time_ = 0
		arg_435_1.frameCnt_ = 0
		arg_435_1.state_ = "playing"
		arg_435_1.curTalkId_ = 1107402109
		arg_435_1.duration_ = 1

		SetActive(arg_435_1.tipsGo_, false)

		function arg_435_1.onSingleLineFinish_()
			arg_435_1.onSingleLineUpdate_ = nil
			arg_435_1.onSingleLineFinish_ = nil
			arg_435_1.state_ = "waiting"

			SetActive(arg_435_1.choicesGo_, true)

			for iter_436_0, iter_436_1 in ipairs(arg_435_1.choices_) do
				SetActive(iter_436_1.go, iter_436_0 <= 2)
			end

			arg_435_1.choices_[1].txt.text = arg_435_1:FormatText(StoryChoiceCfg[1014].name)
			arg_435_1.choices_[2].txt.text = arg_435_1:FormatText(StoryChoiceCfg[1015].name)
		end

		function arg_435_1.playNext_(arg_437_0)
			if arg_437_0 == 1 then
				arg_435_0:Play1107402110(arg_435_1)
			end

			if arg_437_0 == 2 then
				arg_435_0:Play1107402115(arg_435_1)
			end

			arg_435_1:RecordChoiceLog(1107402109, 1014, 1015)
		end

		function arg_435_1.onSingleLineUpdate_(arg_438_0)
			if 0 < arg_435_1.time_ and arg_435_1.time_ <= 0 + arg_438_0 and not isNil(arg_435_1.actors_["1074ui_story"]) and arg_435_1.var_.characterEffect1074ui_story == nil then
				arg_435_1.var_.characterEffect1074ui_story = arg_435_1.actors_["1074ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_438_0 = 0.1

			if 0 <= arg_435_1.time_ and arg_435_1.time_ < 0 + var_438_0 and not isNil(arg_435_1.actors_["1074ui_story"]) then
				if arg_435_1.var_.characterEffect1074ui_story and not isNil(arg_435_1.actors_["1074ui_story"]) then
					arg_435_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_435_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_435_1.time_ - 0) / var_438_0)
				end
			end

			if arg_435_1.time_ >= 0 + var_438_0 and arg_435_1.time_ < 0 + var_438_0 + arg_438_0 and not isNil(arg_435_1.actors_["1074ui_story"]) and arg_435_1.var_.characterEffect1074ui_story then
				arg_435_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_435_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end
		end

		arg_435_1.nodeConfigList_ = {}

		arg_435_1:InitPlayNodeList()
	end,
	Play1107402110 = function(arg_439_0, arg_439_1)
		arg_439_1.time_ = 0
		arg_439_1.frameCnt_ = 0
		arg_439_1.state_ = "playing"
		arg_439_1.curTalkId_ = 1107402110
		arg_439_1.duration_ = 5

		SetActive(arg_439_1.tipsGo_, false)

		function arg_439_1.onSingleLineFinish_()
			arg_439_1.onSingleLineUpdate_ = nil
			arg_439_1.onSingleLineFinish_ = nil
			arg_439_1.state_ = "waiting"
		end

		function arg_439_1.playNext_(arg_441_0)
			if arg_441_0 == 1 then
				arg_439_0:Play1107402111(arg_439_1)
			end
		end

		function arg_439_1.onSingleLineUpdate_(arg_442_0)
			local var_442_0 = 0.8

			if 0 < arg_439_1.time_ and arg_439_1.time_ <= 0 + arg_442_0 then
				arg_439_1.talkMaxDuration = 0
				arg_439_1.dialogCg_.alpha = 1

				arg_439_1.dialog_:SetActive(true)
				SetActive(arg_439_1.leftNameGo_, true)

				arg_439_1.leftNameTxt_.text = arg_439_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_439_1.leftNameTxt_.transform)

				arg_439_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_439_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_439_1:RecordName(arg_439_1.leftNameTxt_.text)
				SetActive(arg_439_1.iconTrs_.gameObject, true)
				arg_439_1.iconController_:SetSelectedState("hero")

				arg_439_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_439_1.callingController_:SetSelectedState("normal")

				arg_439_1.keyicon_.color = Color.New(1, 1, 1)
				arg_439_1.icon_.color = Color.New(1, 1, 1)

				local var_442_1 = arg_439_1:FormatText(arg_439_1:GetWordFromCfg(1107402110).content)

				arg_439_1.text_.text = var_442_1

				LuaForUtil.ClearLinePrefixSymbol(arg_439_1.text_)

				local var_442_3 = 32 <= 0 and var_442_0 or var_442_0 * (utf8.len(var_442_1) / 32)

				if (32 <= 0 and var_442_0 or var_442_0 * (utf8.len(var_442_1) / 32)) > 0 and var_442_0 < var_442_3 then
					arg_439_1.talkMaxDuration = var_442_3

					if var_442_3 + 0 > arg_439_1.duration_ then
						arg_439_1.duration_ = var_442_3 + 0
					end
				end

				arg_439_1.text_.text = var_442_1
				arg_439_1.typewritter.percent = 0

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(false)
				arg_439_1:RecordContent(arg_439_1.text_.text)
			end

			local var_442_4 = math.max(var_442_0, arg_439_1.talkMaxDuration)

			if 0 <= arg_439_1.time_ and arg_439_1.time_ < 0 + var_442_4 then
				arg_439_1.typewritter.percent = (arg_439_1.time_ - 0) / var_442_4

				arg_439_1.typewritter:SetDirty()
			end

			if arg_439_1.time_ >= 0 + var_442_4 and arg_439_1.time_ < 0 + var_442_4 + arg_442_0 then
				arg_439_1.typewritter.percent = 1

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(true)
			end
		end

		arg_439_1.nodeConfigList_ = {}

		arg_439_1:InitPlayNodeList()
	end,
	Play1107402111 = function(arg_443_0, arg_443_1)
		arg_443_1.time_ = 0
		arg_443_1.frameCnt_ = 0
		arg_443_1.state_ = "playing"
		arg_443_1.curTalkId_ = 1107402111
		arg_443_1.duration_ = 5

		SetActive(arg_443_1.tipsGo_, false)

		function arg_443_1.onSingleLineFinish_()
			arg_443_1.onSingleLineUpdate_ = nil
			arg_443_1.onSingleLineFinish_ = nil
			arg_443_1.state_ = "waiting"
		end

		function arg_443_1.playNext_(arg_445_0)
			if arg_445_0 == 1 then
				arg_443_0:Play1107402112(arg_443_1)
			end
		end

		function arg_443_1.onSingleLineUpdate_(arg_446_0)
			local var_446_0 = 0.925

			if 0 < arg_443_1.time_ and arg_443_1.time_ <= 0 + arg_446_0 then
				arg_443_1.talkMaxDuration = 0
				arg_443_1.dialogCg_.alpha = 1

				arg_443_1.dialog_:SetActive(true)
				SetActive(arg_443_1.leftNameGo_, false)

				arg_443_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_443_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_443_1:RecordName(arg_443_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_443_1.iconTrs_.gameObject, false)
				arg_443_1.callingController_:SetSelectedState("normal")

				local var_446_1 = arg_443_1:FormatText(arg_443_1:GetWordFromCfg(1107402111).content)

				arg_443_1.text_.text = var_446_1

				LuaForUtil.ClearLinePrefixSymbol(arg_443_1.text_)

				local var_446_3 = 37 <= 0 and var_446_0 or var_446_0 * (utf8.len(var_446_1) / 37)

				if (37 <= 0 and var_446_0 or var_446_0 * (utf8.len(var_446_1) / 37)) > 0 and var_446_0 < var_446_3 then
					arg_443_1.talkMaxDuration = var_446_3

					if var_446_3 + 0 > arg_443_1.duration_ then
						arg_443_1.duration_ = var_446_3 + 0
					end
				end

				arg_443_1.text_.text = var_446_1
				arg_443_1.typewritter.percent = 0

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(false)
				arg_443_1:RecordContent(arg_443_1.text_.text)
			end

			local var_446_4 = math.max(var_446_0, arg_443_1.talkMaxDuration)

			if 0 <= arg_443_1.time_ and arg_443_1.time_ < 0 + var_446_4 then
				arg_443_1.typewritter.percent = (arg_443_1.time_ - 0) / var_446_4

				arg_443_1.typewritter:SetDirty()
			end

			if arg_443_1.time_ >= 0 + var_446_4 and arg_443_1.time_ < 0 + var_446_4 + arg_446_0 then
				arg_443_1.typewritter.percent = 1

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(true)
			end
		end

		arg_443_1.nodeConfigList_ = {}

		arg_443_1:InitPlayNodeList()
	end,
	Play1107402112 = function(arg_447_0, arg_447_1)
		arg_447_1.time_ = 0
		arg_447_1.frameCnt_ = 0
		arg_447_1.state_ = "playing"
		arg_447_1.curTalkId_ = 1107402112
		arg_447_1.duration_ = 3.7

		SetActive(arg_447_1.tipsGo_, false)

		function arg_447_1.onSingleLineFinish_()
			arg_447_1.onSingleLineUpdate_ = nil
			arg_447_1.onSingleLineFinish_ = nil
			arg_447_1.state_ = "waiting"
		end

		function arg_447_1.playNext_(arg_449_0)
			if arg_449_0 == 1 then
				arg_447_0:Play1107402113(arg_447_1)
			end
		end

		function arg_447_1.onSingleLineUpdate_(arg_450_0)
			if 0 < arg_447_1.time_ and arg_447_1.time_ <= 0 + arg_450_0 and not isNil(arg_447_1.actors_["1074ui_story"]) and arg_447_1.var_.characterEffect1074ui_story == nil then
				arg_447_1.var_.characterEffect1074ui_story = arg_447_1.actors_["1074ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_450_0 = 0.1

			if 0 <= arg_447_1.time_ and arg_447_1.time_ < 0 + var_450_0 and not isNil(arg_447_1.actors_["1074ui_story"]) then
				if arg_447_1.var_.characterEffect1074ui_story and not isNil(arg_447_1.actors_["1074ui_story"]) then
					arg_447_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_447_1.time_ >= 0 + var_450_0 and arg_447_1.time_ < 0 + var_450_0 + arg_450_0 and not isNil(arg_447_1.actors_["1074ui_story"]) and arg_447_1.var_.characterEffect1074ui_story then
				arg_447_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			if 0 < arg_447_1.time_ and arg_447_1.time_ <= 0 + arg_450_0 then
				arg_447_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action6_2")
			end

			local var_450_2 = 0
			local var_450_3 = 0.175

			if 0 < arg_447_1.time_ and arg_447_1.time_ <= var_450_2 + arg_450_0 then
				arg_447_1.talkMaxDuration = 0
				arg_447_1.dialogCg_.alpha = 1

				arg_447_1.dialog_:SetActive(true)
				SetActive(arg_447_1.leftNameGo_, true)

				arg_447_1.leftNameTxt_.text = arg_447_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_447_1.leftNameTxt_.transform)

				arg_447_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_447_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_447_1:RecordName(arg_447_1.leftNameTxt_.text)
				SetActive(arg_447_1.iconTrs_.gameObject, false)
				arg_447_1.callingController_:SetSelectedState("normal")

				local var_450_4 = arg_447_1:GetWordFromCfg(1107402112)
				local var_450_5 = arg_447_1:FormatText(var_450_4.content)

				arg_447_1.text_.text = var_450_5

				LuaForUtil.ClearLinePrefixSymbol(arg_447_1.text_)

				local var_450_7 = 7 <= 0 and var_450_3 or var_450_3 * (utf8.len(var_450_5) / 7)

				if (7 <= 0 and var_450_3 or var_450_3 * (utf8.len(var_450_5) / 7)) > 0 and var_450_3 < var_450_7 then
					arg_447_1.talkMaxDuration = var_450_7

					if var_450_7 + var_450_2 > arg_447_1.duration_ then
						arg_447_1.duration_ = var_450_7 + var_450_2
					end
				end

				arg_447_1.text_.text = var_450_5
				arg_447_1.typewritter.percent = 0

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107402", "1107402112", "story_v_side_new_1107402.awb") ~= 0 then
					local var_450_8 = manager.audio:GetVoiceLength("story_v_side_new_1107402", "1107402112", "story_v_side_new_1107402.awb") / 1000

					if var_450_8 + var_450_2 > arg_447_1.duration_ then
						arg_447_1.duration_ = var_450_8 + var_450_2
					end

					if var_450_4.prefab_name ~= "" and arg_447_1.actors_[var_450_4.prefab_name] ~= nil then
						local var_450_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_447_1.actors_[var_450_4.prefab_name].transform, "story_v_side_new_1107402", "1107402112", "story_v_side_new_1107402.awb")

						arg_447_1:RecordAudio("1107402112", var_450_9)
						arg_447_1:RecordAudio("1107402112", var_450_9)
					else
						arg_447_1:AudioAction("play", "voice", "story_v_side_new_1107402", "1107402112", "story_v_side_new_1107402.awb")
					end

					arg_447_1:RecordHistoryTalkVoice("story_v_side_new_1107402", "1107402112", "story_v_side_new_1107402.awb")
				end

				arg_447_1:RecordContent(arg_447_1.text_.text)
			end

			local var_450_10 = math.max(var_450_3, arg_447_1.talkMaxDuration)

			if var_450_2 <= arg_447_1.time_ and arg_447_1.time_ < var_450_2 + var_450_10 then
				arg_447_1.typewritter.percent = (arg_447_1.time_ - var_450_2) / var_450_10

				arg_447_1.typewritter:SetDirty()
			end

			if arg_447_1.time_ >= var_450_2 + var_450_10 and arg_447_1.time_ < var_450_2 + var_450_10 + arg_450_0 then
				arg_447_1.typewritter.percent = 1

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(true)
			end
		end

		arg_447_1.nodeConfigList_ = {}

		arg_447_1:InitPlayNodeList()
	end,
	Play1107402113 = function(arg_451_0, arg_451_1)
		arg_451_1.time_ = 0
		arg_451_1.frameCnt_ = 0
		arg_451_1.state_ = "playing"
		arg_451_1.curTalkId_ = 1107402113
		arg_451_1.duration_ = 5

		SetActive(arg_451_1.tipsGo_, false)

		function arg_451_1.onSingleLineFinish_()
			arg_451_1.onSingleLineUpdate_ = nil
			arg_451_1.onSingleLineFinish_ = nil
			arg_451_1.state_ = "waiting"
		end

		function arg_451_1.playNext_(arg_453_0)
			if arg_453_0 == 1 then
				arg_451_0:Play1107402114(arg_451_1)
			end
		end

		function arg_451_1.onSingleLineUpdate_(arg_454_0)
			if 0 < arg_451_1.time_ and arg_451_1.time_ <= 0 + arg_454_0 and not isNil(arg_451_1.actors_["1074ui_story"]) and arg_451_1.var_.characterEffect1074ui_story == nil then
				arg_451_1.var_.characterEffect1074ui_story = arg_451_1.actors_["1074ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_454_0 = 0.1

			if 0 <= arg_451_1.time_ and arg_451_1.time_ < 0 + var_454_0 and not isNil(arg_451_1.actors_["1074ui_story"]) then
				if arg_451_1.var_.characterEffect1074ui_story and not isNil(arg_451_1.actors_["1074ui_story"]) then
					arg_451_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_451_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_451_1.time_ - 0) / var_454_0)
				end
			end

			if arg_451_1.time_ >= 0 + var_454_0 and arg_451_1.time_ < 0 + var_454_0 + arg_454_0 and not isNil(arg_451_1.actors_["1074ui_story"]) and arg_451_1.var_.characterEffect1074ui_story then
				arg_451_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_451_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			local var_454_1 = 0
			local var_454_2 = 0.525

			if 0 < arg_451_1.time_ and arg_451_1.time_ <= var_454_1 + arg_454_0 then
				arg_451_1.talkMaxDuration = 0
				arg_451_1.dialogCg_.alpha = 1

				arg_451_1.dialog_:SetActive(true)
				SetActive(arg_451_1.leftNameGo_, false)

				arg_451_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_451_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_451_1:RecordName(arg_451_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_451_1.iconTrs_.gameObject, false)
				arg_451_1.callingController_:SetSelectedState("normal")

				local var_454_3 = arg_451_1:FormatText(arg_451_1:GetWordFromCfg(1107402113).content)

				arg_451_1.text_.text = var_454_3

				LuaForUtil.ClearLinePrefixSymbol(arg_451_1.text_)

				local var_454_5 = 21 <= 0 and var_454_2 or var_454_2 * (utf8.len(var_454_3) / 21)

				if (21 <= 0 and var_454_2 or var_454_2 * (utf8.len(var_454_3) / 21)) > 0 and var_454_2 < var_454_5 then
					arg_451_1.talkMaxDuration = var_454_5

					if var_454_5 + var_454_1 > arg_451_1.duration_ then
						arg_451_1.duration_ = var_454_5 + var_454_1
					end
				end

				arg_451_1.text_.text = var_454_3
				arg_451_1.typewritter.percent = 0

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(false)
				arg_451_1:RecordContent(arg_451_1.text_.text)
			end

			local var_454_6 = math.max(var_454_2, arg_451_1.talkMaxDuration)

			if var_454_1 <= arg_451_1.time_ and arg_451_1.time_ < var_454_1 + var_454_6 then
				arg_451_1.typewritter.percent = (arg_451_1.time_ - var_454_1) / var_454_6

				arg_451_1.typewritter:SetDirty()
			end

			if arg_451_1.time_ >= var_454_1 + var_454_6 and arg_451_1.time_ < var_454_1 + var_454_6 + arg_454_0 then
				arg_451_1.typewritter.percent = 1

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(true)
			end
		end

		arg_451_1.nodeConfigList_ = {}

		arg_451_1:InitPlayNodeList()
	end,
	Play1107402114 = function(arg_455_0, arg_455_1)
		arg_455_1.time_ = 0
		arg_455_1.frameCnt_ = 0
		arg_455_1.state_ = "playing"
		arg_455_1.curTalkId_ = 1107402114
		arg_455_1.duration_ = 5

		SetActive(arg_455_1.tipsGo_, false)

		function arg_455_1.onSingleLineFinish_()
			arg_455_1.onSingleLineUpdate_ = nil
			arg_455_1.onSingleLineFinish_ = nil
			arg_455_1.state_ = "waiting"
		end

		function arg_455_1.playNext_(arg_457_0)
			if arg_457_0 == 1 then
				arg_455_0:Play1107402120(arg_455_1)
			end
		end

		function arg_455_1.onSingleLineUpdate_(arg_458_0)
			local var_458_0 = 0.85

			if 0 < arg_455_1.time_ and arg_455_1.time_ <= 0 + arg_458_0 then
				arg_455_1.talkMaxDuration = 0
				arg_455_1.dialogCg_.alpha = 1

				arg_455_1.dialog_:SetActive(true)
				SetActive(arg_455_1.leftNameGo_, false)

				arg_455_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_455_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_455_1:RecordName(arg_455_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_455_1.iconTrs_.gameObject, false)
				arg_455_1.callingController_:SetSelectedState("normal")

				local var_458_1 = arg_455_1:FormatText(arg_455_1:GetWordFromCfg(1107402114).content)

				arg_455_1.text_.text = var_458_1

				LuaForUtil.ClearLinePrefixSymbol(arg_455_1.text_)

				local var_458_3 = 34 <= 0 and var_458_0 or var_458_0 * (utf8.len(var_458_1) / 34)

				if (34 <= 0 and var_458_0 or var_458_0 * (utf8.len(var_458_1) / 34)) > 0 and var_458_0 < var_458_3 then
					arg_455_1.talkMaxDuration = var_458_3

					if var_458_3 + 0 > arg_455_1.duration_ then
						arg_455_1.duration_ = var_458_3 + 0
					end
				end

				arg_455_1.text_.text = var_458_1
				arg_455_1.typewritter.percent = 0

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(false)
				arg_455_1:RecordContent(arg_455_1.text_.text)
			end

			local var_458_4 = math.max(var_458_0, arg_455_1.talkMaxDuration)

			if 0 <= arg_455_1.time_ and arg_455_1.time_ < 0 + var_458_4 then
				arg_455_1.typewritter.percent = (arg_455_1.time_ - 0) / var_458_4

				arg_455_1.typewritter:SetDirty()
			end

			if arg_455_1.time_ >= 0 + var_458_4 and arg_455_1.time_ < 0 + var_458_4 + arg_458_0 then
				arg_455_1.typewritter.percent = 1

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(true)
			end
		end

		arg_455_1.nodeConfigList_ = {}

		arg_455_1:InitPlayNodeList()
	end,
	Play1107402120 = function(arg_459_0, arg_459_1)
		arg_459_1.time_ = 0
		arg_459_1.frameCnt_ = 0
		arg_459_1.state_ = "playing"
		arg_459_1.curTalkId_ = 1107402120
		arg_459_1.duration_ = 5

		SetActive(arg_459_1.tipsGo_, false)

		function arg_459_1.onSingleLineFinish_()
			arg_459_1.onSingleLineUpdate_ = nil
			arg_459_1.onSingleLineFinish_ = nil
			arg_459_1.state_ = "waiting"
		end

		function arg_459_1.playNext_(arg_461_0)
			if arg_461_0 == 1 then
				arg_459_0:Play1107402121(arg_459_1)
			end
		end

		function arg_459_1.onSingleLineUpdate_(arg_462_0)
			local var_462_0 = 0.35

			if 0 < arg_459_1.time_ and arg_459_1.time_ <= 0 + arg_462_0 then
				arg_459_1.talkMaxDuration = 0
				arg_459_1.dialogCg_.alpha = 1

				arg_459_1.dialog_:SetActive(true)
				SetActive(arg_459_1.leftNameGo_, false)

				arg_459_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_459_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_459_1:RecordName(arg_459_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_459_1.iconTrs_.gameObject, false)
				arg_459_1.callingController_:SetSelectedState("normal")

				local var_462_1 = arg_459_1:FormatText(arg_459_1:GetWordFromCfg(1107402120).content)

				arg_459_1.text_.text = var_462_1

				LuaForUtil.ClearLinePrefixSymbol(arg_459_1.text_)

				local var_462_3 = 14 <= 0 and var_462_0 or var_462_0 * (utf8.len(var_462_1) / 14)

				if (14 <= 0 and var_462_0 or var_462_0 * (utf8.len(var_462_1) / 14)) > 0 and var_462_0 < var_462_3 then
					arg_459_1.talkMaxDuration = var_462_3

					if var_462_3 + 0 > arg_459_1.duration_ then
						arg_459_1.duration_ = var_462_3 + 0
					end
				end

				arg_459_1.text_.text = var_462_1
				arg_459_1.typewritter.percent = 0

				arg_459_1.typewritter:SetDirty()
				arg_459_1:ShowNextGo(false)
				arg_459_1:RecordContent(arg_459_1.text_.text)
			end

			local var_462_4 = math.max(var_462_0, arg_459_1.talkMaxDuration)

			if 0 <= arg_459_1.time_ and arg_459_1.time_ < 0 + var_462_4 then
				arg_459_1.typewritter.percent = (arg_459_1.time_ - 0) / var_462_4

				arg_459_1.typewritter:SetDirty()
			end

			if arg_459_1.time_ >= 0 + var_462_4 and arg_459_1.time_ < 0 + var_462_4 + arg_462_0 then
				arg_459_1.typewritter.percent = 1

				arg_459_1.typewritter:SetDirty()
				arg_459_1:ShowNextGo(true)
			end
		end

		arg_459_1.nodeConfigList_ = {}

		arg_459_1:InitPlayNodeList()
	end,
	Play1107402121 = function(arg_463_0, arg_463_1)
		arg_463_1.time_ = 0
		arg_463_1.frameCnt_ = 0
		arg_463_1.state_ = "playing"
		arg_463_1.curTalkId_ = 1107402121
		arg_463_1.duration_ = 5.6

		SetActive(arg_463_1.tipsGo_, false)

		function arg_463_1.onSingleLineFinish_()
			arg_463_1.onSingleLineUpdate_ = nil
			arg_463_1.onSingleLineFinish_ = nil
			arg_463_1.state_ = "waiting"
		end

		function arg_463_1.playNext_(arg_465_0)
			if arg_465_0 == 1 then
				arg_463_0:Play1107402122(arg_463_1)
			end
		end

		function arg_463_1.onSingleLineUpdate_(arg_466_0)
			if 0 < arg_463_1.time_ and arg_463_1.time_ <= 0 + arg_466_0 and not isNil(arg_463_1.actors_["1074ui_story"]) and arg_463_1.var_.characterEffect1074ui_story == nil then
				arg_463_1.var_.characterEffect1074ui_story = arg_463_1.actors_["1074ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_466_0 = 0.1

			if 0 <= arg_463_1.time_ and arg_463_1.time_ < 0 + var_466_0 and not isNil(arg_463_1.actors_["1074ui_story"]) then
				if arg_463_1.var_.characterEffect1074ui_story and not isNil(arg_463_1.actors_["1074ui_story"]) then
					arg_463_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_463_1.time_ >= 0 + var_466_0 and arg_463_1.time_ < 0 + var_466_0 + arg_466_0 and not isNil(arg_463_1.actors_["1074ui_story"]) and arg_463_1.var_.characterEffect1074ui_story then
				arg_463_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_466_2 = 0
			local var_466_3 = 0.4

			if 0 < arg_463_1.time_ and arg_463_1.time_ <= var_466_2 + arg_466_0 then
				arg_463_1.talkMaxDuration = 0
				arg_463_1.dialogCg_.alpha = 1

				arg_463_1.dialog_:SetActive(true)
				SetActive(arg_463_1.leftNameGo_, true)

				arg_463_1.leftNameTxt_.text = arg_463_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_463_1.leftNameTxt_.transform)

				arg_463_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_463_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_463_1:RecordName(arg_463_1.leftNameTxt_.text)
				SetActive(arg_463_1.iconTrs_.gameObject, false)
				arg_463_1.callingController_:SetSelectedState("normal")

				local var_466_4 = arg_463_1:GetWordFromCfg(1107402121)
				local var_466_5 = arg_463_1:FormatText(var_466_4.content)

				arg_463_1.text_.text = var_466_5

				LuaForUtil.ClearLinePrefixSymbol(arg_463_1.text_)

				local var_466_7 = 16 <= 0 and var_466_3 or var_466_3 * (utf8.len(var_466_5) / 16)

				if (16 <= 0 and var_466_3 or var_466_3 * (utf8.len(var_466_5) / 16)) > 0 and var_466_3 < var_466_7 then
					arg_463_1.talkMaxDuration = var_466_7

					if var_466_7 + var_466_2 > arg_463_1.duration_ then
						arg_463_1.duration_ = var_466_7 + var_466_2
					end
				end

				arg_463_1.text_.text = var_466_5
				arg_463_1.typewritter.percent = 0

				arg_463_1.typewritter:SetDirty()
				arg_463_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107402", "1107402121", "story_v_side_new_1107402.awb") ~= 0 then
					local var_466_8 = manager.audio:GetVoiceLength("story_v_side_new_1107402", "1107402121", "story_v_side_new_1107402.awb") / 1000

					if var_466_8 + var_466_2 > arg_463_1.duration_ then
						arg_463_1.duration_ = var_466_8 + var_466_2
					end

					if var_466_4.prefab_name ~= "" and arg_463_1.actors_[var_466_4.prefab_name] ~= nil then
						local var_466_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_463_1.actors_[var_466_4.prefab_name].transform, "story_v_side_new_1107402", "1107402121", "story_v_side_new_1107402.awb")

						arg_463_1:RecordAudio("1107402121", var_466_9)
						arg_463_1:RecordAudio("1107402121", var_466_9)
					else
						arg_463_1:AudioAction("play", "voice", "story_v_side_new_1107402", "1107402121", "story_v_side_new_1107402.awb")
					end

					arg_463_1:RecordHistoryTalkVoice("story_v_side_new_1107402", "1107402121", "story_v_side_new_1107402.awb")
				end

				arg_463_1:RecordContent(arg_463_1.text_.text)
			end

			local var_466_10 = math.max(var_466_3, arg_463_1.talkMaxDuration)

			if var_466_2 <= arg_463_1.time_ and arg_463_1.time_ < var_466_2 + var_466_10 then
				arg_463_1.typewritter.percent = (arg_463_1.time_ - var_466_2) / var_466_10

				arg_463_1.typewritter:SetDirty()
			end

			if arg_463_1.time_ >= var_466_2 + var_466_10 and arg_463_1.time_ < var_466_2 + var_466_10 + arg_466_0 then
				arg_463_1.typewritter.percent = 1

				arg_463_1.typewritter:SetDirty()
				arg_463_1:ShowNextGo(true)
			end
		end

		arg_463_1.nodeConfigList_ = {}

		arg_463_1:InitPlayNodeList()
	end,
	Play1107402122 = function(arg_467_0, arg_467_1)
		arg_467_1.time_ = 0
		arg_467_1.frameCnt_ = 0
		arg_467_1.state_ = "playing"
		arg_467_1.curTalkId_ = 1107402122
		arg_467_1.duration_ = 5

		SetActive(arg_467_1.tipsGo_, false)

		function arg_467_1.onSingleLineFinish_()
			arg_467_1.onSingleLineUpdate_ = nil
			arg_467_1.onSingleLineFinish_ = nil
			arg_467_1.state_ = "waiting"
		end

		function arg_467_1.playNext_(arg_469_0)
			if arg_469_0 == 1 then
				arg_467_0:Play1107402123(arg_467_1)
			end
		end

		function arg_467_1.onSingleLineUpdate_(arg_470_0)
			if 0 < arg_467_1.time_ and arg_467_1.time_ <= 0 + arg_470_0 and not isNil(arg_467_1.actors_["1074ui_story"]) and arg_467_1.var_.characterEffect1074ui_story == nil then
				arg_467_1.var_.characterEffect1074ui_story = arg_467_1.actors_["1074ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_470_0 = 0.1

			if 0 <= arg_467_1.time_ and arg_467_1.time_ < 0 + var_470_0 and not isNil(arg_467_1.actors_["1074ui_story"]) then
				if arg_467_1.var_.characterEffect1074ui_story and not isNil(arg_467_1.actors_["1074ui_story"]) then
					arg_467_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_467_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_467_1.time_ - 0) / var_470_0)
				end
			end

			if arg_467_1.time_ >= 0 + var_470_0 and arg_467_1.time_ < 0 + var_470_0 + arg_470_0 and not isNil(arg_467_1.actors_["1074ui_story"]) and arg_467_1.var_.characterEffect1074ui_story then
				arg_467_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_467_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			local var_470_1 = 0
			local var_470_2 = 0.725

			if 0 < arg_467_1.time_ and arg_467_1.time_ <= var_470_1 + arg_470_0 then
				arg_467_1.talkMaxDuration = 0
				arg_467_1.dialogCg_.alpha = 1

				arg_467_1.dialog_:SetActive(true)
				SetActive(arg_467_1.leftNameGo_, true)

				arg_467_1.leftNameTxt_.text = arg_467_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_467_1.leftNameTxt_.transform)

				arg_467_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_467_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_467_1:RecordName(arg_467_1.leftNameTxt_.text)
				SetActive(arg_467_1.iconTrs_.gameObject, true)
				arg_467_1.iconController_:SetSelectedState("hero")

				arg_467_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_467_1.callingController_:SetSelectedState("normal")

				arg_467_1.keyicon_.color = Color.New(1, 1, 1)
				arg_467_1.icon_.color = Color.New(1, 1, 1)

				local var_470_3 = arg_467_1:FormatText(arg_467_1:GetWordFromCfg(1107402122).content)

				arg_467_1.text_.text = var_470_3

				LuaForUtil.ClearLinePrefixSymbol(arg_467_1.text_)

				local var_470_5 = 29 <= 0 and var_470_2 or var_470_2 * (utf8.len(var_470_3) / 29)

				if (29 <= 0 and var_470_2 or var_470_2 * (utf8.len(var_470_3) / 29)) > 0 and var_470_2 < var_470_5 then
					arg_467_1.talkMaxDuration = var_470_5

					if var_470_5 + var_470_1 > arg_467_1.duration_ then
						arg_467_1.duration_ = var_470_5 + var_470_1
					end
				end

				arg_467_1.text_.text = var_470_3
				arg_467_1.typewritter.percent = 0

				arg_467_1.typewritter:SetDirty()
				arg_467_1:ShowNextGo(false)
				arg_467_1:RecordContent(arg_467_1.text_.text)
			end

			local var_470_6 = math.max(var_470_2, arg_467_1.talkMaxDuration)

			if var_470_1 <= arg_467_1.time_ and arg_467_1.time_ < var_470_1 + var_470_6 then
				arg_467_1.typewritter.percent = (arg_467_1.time_ - var_470_1) / var_470_6

				arg_467_1.typewritter:SetDirty()
			end

			if arg_467_1.time_ >= var_470_1 + var_470_6 and arg_467_1.time_ < var_470_1 + var_470_6 + arg_470_0 then
				arg_467_1.typewritter.percent = 1

				arg_467_1.typewritter:SetDirty()
				arg_467_1:ShowNextGo(true)
			end
		end

		arg_467_1.nodeConfigList_ = {}

		arg_467_1:InitPlayNodeList()
	end,
	Play1107402123 = function(arg_471_0, arg_471_1)
		arg_471_1.time_ = 0
		arg_471_1.frameCnt_ = 0
		arg_471_1.state_ = "playing"
		arg_471_1.curTalkId_ = 1107402123
		arg_471_1.duration_ = 5

		SetActive(arg_471_1.tipsGo_, false)

		function arg_471_1.onSingleLineFinish_()
			arg_471_1.onSingleLineUpdate_ = nil
			arg_471_1.onSingleLineFinish_ = nil
			arg_471_1.state_ = "waiting"
		end

		function arg_471_1.playNext_(arg_473_0)
			if arg_473_0 == 1 then
				arg_471_0:Play1107402124(arg_471_1)
			end
		end

		function arg_471_1.onSingleLineUpdate_(arg_474_0)
			local var_474_0 = 0.325

			if 0 < arg_471_1.time_ and arg_471_1.time_ <= 0 + arg_474_0 then
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

				arg_471_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_471_1.callingController_:SetSelectedState("normal")

				arg_471_1.keyicon_.color = Color.New(1, 1, 1)
				arg_471_1.icon_.color = Color.New(1, 1, 1)

				local var_474_1 = arg_471_1:FormatText(arg_471_1:GetWordFromCfg(1107402123).content)

				arg_471_1.text_.text = var_474_1

				LuaForUtil.ClearLinePrefixSymbol(arg_471_1.text_)

				local var_474_3 = 13 <= 0 and var_474_0 or var_474_0 * (utf8.len(var_474_1) / 13)

				if (13 <= 0 and var_474_0 or var_474_0 * (utf8.len(var_474_1) / 13)) > 0 and var_474_0 < var_474_3 then
					arg_471_1.talkMaxDuration = var_474_3

					if var_474_3 + 0 > arg_471_1.duration_ then
						arg_471_1.duration_ = var_474_3 + 0
					end
				end

				arg_471_1.text_.text = var_474_1
				arg_471_1.typewritter.percent = 0

				arg_471_1.typewritter:SetDirty()
				arg_471_1:ShowNextGo(false)
				arg_471_1:RecordContent(arg_471_1.text_.text)
			end

			local var_474_4 = math.max(var_474_0, arg_471_1.talkMaxDuration)

			if 0 <= arg_471_1.time_ and arg_471_1.time_ < 0 + var_474_4 then
				arg_471_1.typewritter.percent = (arg_471_1.time_ - 0) / var_474_4

				arg_471_1.typewritter:SetDirty()
			end

			if arg_471_1.time_ >= 0 + var_474_4 and arg_471_1.time_ < 0 + var_474_4 + arg_474_0 then
				arg_471_1.typewritter.percent = 1

				arg_471_1.typewritter:SetDirty()
				arg_471_1:ShowNextGo(true)
			end
		end

		arg_471_1.nodeConfigList_ = {}

		arg_471_1:InitPlayNodeList()
	end,
	Play1107402124 = function(arg_475_0, arg_475_1)
		arg_475_1.time_ = 0
		arg_475_1.frameCnt_ = 0
		arg_475_1.state_ = "playing"
		arg_475_1.curTalkId_ = 1107402124
		arg_475_1.duration_ = 1

		SetActive(arg_475_1.tipsGo_, false)

		function arg_475_1.onSingleLineFinish_()
			arg_475_1.onSingleLineUpdate_ = nil
			arg_475_1.onSingleLineFinish_ = nil
			arg_475_1.state_ = "waiting"
		end

		function arg_475_1.playNext_(arg_477_0)
			if arg_477_0 == 1 then
				arg_475_0:Play1107402125(arg_475_1)
			end
		end

		function arg_475_1.onSingleLineUpdate_(arg_478_0)
			if 0 < arg_475_1.time_ and arg_475_1.time_ <= 0 + arg_478_0 and not isNil(arg_475_1.actors_["1074ui_story"]) and arg_475_1.var_.characterEffect1074ui_story == nil then
				arg_475_1.var_.characterEffect1074ui_story = arg_475_1.actors_["1074ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_478_0 = 0.1

			if 0 <= arg_475_1.time_ and arg_475_1.time_ < 0 + var_478_0 and not isNil(arg_475_1.actors_["1074ui_story"]) then
				if arg_475_1.var_.characterEffect1074ui_story and not isNil(arg_475_1.actors_["1074ui_story"]) then
					arg_475_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_475_1.time_ >= 0 + var_478_0 and arg_475_1.time_ < 0 + var_478_0 + arg_478_0 and not isNil(arg_475_1.actors_["1074ui_story"]) and arg_475_1.var_.characterEffect1074ui_story then
				arg_475_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_478_2 = 0
			local var_478_3 = 0.05

			if 0 < arg_475_1.time_ and arg_475_1.time_ <= var_478_2 + arg_478_0 then
				arg_475_1.talkMaxDuration = 0
				arg_475_1.dialogCg_.alpha = 1

				arg_475_1.dialog_:SetActive(true)
				SetActive(arg_475_1.leftNameGo_, true)

				arg_475_1.leftNameTxt_.text = arg_475_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_475_1.leftNameTxt_.transform)

				arg_475_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_475_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_475_1:RecordName(arg_475_1.leftNameTxt_.text)
				SetActive(arg_475_1.iconTrs_.gameObject, false)
				arg_475_1.callingController_:SetSelectedState("normal")

				local var_478_4 = arg_475_1:GetWordFromCfg(1107402124)
				local var_478_5 = arg_475_1:FormatText(var_478_4.content)

				arg_475_1.text_.text = var_478_5

				LuaForUtil.ClearLinePrefixSymbol(arg_475_1.text_)

				local var_478_7 = 2 <= 0 and var_478_3 or var_478_3 * (utf8.len(var_478_5) / 2)

				if (2 <= 0 and var_478_3 or var_478_3 * (utf8.len(var_478_5) / 2)) > 0 and var_478_3 < var_478_7 then
					arg_475_1.talkMaxDuration = var_478_7

					if var_478_7 + var_478_2 > arg_475_1.duration_ then
						arg_475_1.duration_ = var_478_7 + var_478_2
					end
				end

				arg_475_1.text_.text = var_478_5
				arg_475_1.typewritter.percent = 0

				arg_475_1.typewritter:SetDirty()
				arg_475_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107402", "1107402124", "story_v_side_new_1107402.awb") ~= 0 then
					local var_478_8 = manager.audio:GetVoiceLength("story_v_side_new_1107402", "1107402124", "story_v_side_new_1107402.awb") / 1000

					if var_478_8 + var_478_2 > arg_475_1.duration_ then
						arg_475_1.duration_ = var_478_8 + var_478_2
					end

					if var_478_4.prefab_name ~= "" and arg_475_1.actors_[var_478_4.prefab_name] ~= nil then
						local var_478_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_475_1.actors_[var_478_4.prefab_name].transform, "story_v_side_new_1107402", "1107402124", "story_v_side_new_1107402.awb")

						arg_475_1:RecordAudio("1107402124", var_478_9)
						arg_475_1:RecordAudio("1107402124", var_478_9)
					else
						arg_475_1:AudioAction("play", "voice", "story_v_side_new_1107402", "1107402124", "story_v_side_new_1107402.awb")
					end

					arg_475_1:RecordHistoryTalkVoice("story_v_side_new_1107402", "1107402124", "story_v_side_new_1107402.awb")
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
	Play1107402125 = function(arg_479_0, arg_479_1)
		arg_479_1.time_ = 0
		arg_479_1.frameCnt_ = 0
		arg_479_1.state_ = "playing"
		arg_479_1.curTalkId_ = 1107402125
		arg_479_1.duration_ = 5

		SetActive(arg_479_1.tipsGo_, false)

		function arg_479_1.onSingleLineFinish_()
			arg_479_1.onSingleLineUpdate_ = nil
			arg_479_1.onSingleLineFinish_ = nil
			arg_479_1.state_ = "waiting"
		end

		function arg_479_1.playNext_(arg_481_0)
			if arg_481_0 == 1 then
				arg_479_0:Play1107402126(arg_479_1)
			end
		end

		function arg_479_1.onSingleLineUpdate_(arg_482_0)
			if 0 < arg_479_1.time_ and arg_479_1.time_ <= 0 + arg_482_0 and not isNil(arg_479_1.actors_["1074ui_story"]) and arg_479_1.var_.characterEffect1074ui_story == nil then
				arg_479_1.var_.characterEffect1074ui_story = arg_479_1.actors_["1074ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_482_0 = 0.1

			if 0 <= arg_479_1.time_ and arg_479_1.time_ < 0 + var_482_0 and not isNil(arg_479_1.actors_["1074ui_story"]) then
				if arg_479_1.var_.characterEffect1074ui_story and not isNil(arg_479_1.actors_["1074ui_story"]) then
					arg_479_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_479_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_479_1.time_ - 0) / var_482_0)
				end
			end

			if arg_479_1.time_ >= 0 + var_482_0 and arg_479_1.time_ < 0 + var_482_0 + arg_482_0 and not isNil(arg_479_1.actors_["1074ui_story"]) and arg_479_1.var_.characterEffect1074ui_story then
				arg_479_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_479_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			local var_482_1 = 0
			local var_482_2 = 0.6

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

				arg_479_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_479_1.callingController_:SetSelectedState("normal")

				arg_479_1.keyicon_.color = Color.New(1, 1, 1)
				arg_479_1.icon_.color = Color.New(1, 1, 1)

				local var_482_3 = arg_479_1:FormatText(arg_479_1:GetWordFromCfg(1107402125).content)

				arg_479_1.text_.text = var_482_3

				LuaForUtil.ClearLinePrefixSymbol(arg_479_1.text_)

				local var_482_5 = 24 <= 0 and var_482_2 or var_482_2 * (utf8.len(var_482_3) / 24)

				if (24 <= 0 and var_482_2 or var_482_2 * (utf8.len(var_482_3) / 24)) > 0 and var_482_2 < var_482_5 then
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
	Play1107402126 = function(arg_483_0, arg_483_1)
		arg_483_1.time_ = 0
		arg_483_1.frameCnt_ = 0
		arg_483_1.state_ = "playing"
		arg_483_1.curTalkId_ = 1107402126
		arg_483_1.duration_ = 4.8

		SetActive(arg_483_1.tipsGo_, false)

		function arg_483_1.onSingleLineFinish_()
			arg_483_1.onSingleLineUpdate_ = nil
			arg_483_1.onSingleLineFinish_ = nil
			arg_483_1.state_ = "waiting"
		end

		function arg_483_1.playNext_(arg_485_0)
			if arg_485_0 == 1 then
				arg_483_0:Play1107402127(arg_483_1)
			end
		end

		function arg_483_1.onSingleLineUpdate_(arg_486_0)
			if 0 < arg_483_1.time_ and arg_483_1.time_ <= 0 + arg_486_0 and not isNil(arg_483_1.actors_["1074ui_story"]) and arg_483_1.var_.characterEffect1074ui_story == nil then
				arg_483_1.var_.characterEffect1074ui_story = arg_483_1.actors_["1074ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_486_0 = 0.1

			if 0 <= arg_483_1.time_ and arg_483_1.time_ < 0 + var_486_0 and not isNil(arg_483_1.actors_["1074ui_story"]) then
				if arg_483_1.var_.characterEffect1074ui_story and not isNil(arg_483_1.actors_["1074ui_story"]) then
					arg_483_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_483_1.time_ >= 0 + var_486_0 and arg_483_1.time_ < 0 + var_486_0 + arg_486_0 and not isNil(arg_483_1.actors_["1074ui_story"]) and arg_483_1.var_.characterEffect1074ui_story then
				arg_483_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_486_2 = 0
			local var_486_3 = 0.6

			if 0 < arg_483_1.time_ and arg_483_1.time_ <= var_486_2 + arg_486_0 then
				arg_483_1.talkMaxDuration = 0
				arg_483_1.dialogCg_.alpha = 1

				arg_483_1.dialog_:SetActive(true)
				SetActive(arg_483_1.leftNameGo_, true)

				arg_483_1.leftNameTxt_.text = arg_483_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_483_1.leftNameTxt_.transform)

				arg_483_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_483_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_483_1:RecordName(arg_483_1.leftNameTxt_.text)
				SetActive(arg_483_1.iconTrs_.gameObject, false)
				arg_483_1.callingController_:SetSelectedState("normal")

				local var_486_4 = arg_483_1:GetWordFromCfg(1107402126)
				local var_486_5 = arg_483_1:FormatText(var_486_4.content)

				arg_483_1.text_.text = var_486_5

				LuaForUtil.ClearLinePrefixSymbol(arg_483_1.text_)

				local var_486_7 = 24 <= 0 and var_486_3 or var_486_3 * (utf8.len(var_486_5) / 24)

				if (24 <= 0 and var_486_3 or var_486_3 * (utf8.len(var_486_5) / 24)) > 0 and var_486_3 < var_486_7 then
					arg_483_1.talkMaxDuration = var_486_7

					if var_486_7 + var_486_2 > arg_483_1.duration_ then
						arg_483_1.duration_ = var_486_7 + var_486_2
					end
				end

				arg_483_1.text_.text = var_486_5
				arg_483_1.typewritter.percent = 0

				arg_483_1.typewritter:SetDirty()
				arg_483_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107402", "1107402126", "story_v_side_new_1107402.awb") ~= 0 then
					local var_486_8 = manager.audio:GetVoiceLength("story_v_side_new_1107402", "1107402126", "story_v_side_new_1107402.awb") / 1000

					if var_486_8 + var_486_2 > arg_483_1.duration_ then
						arg_483_1.duration_ = var_486_8 + var_486_2
					end

					if var_486_4.prefab_name ~= "" and arg_483_1.actors_[var_486_4.prefab_name] ~= nil then
						local var_486_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_483_1.actors_[var_486_4.prefab_name].transform, "story_v_side_new_1107402", "1107402126", "story_v_side_new_1107402.awb")

						arg_483_1:RecordAudio("1107402126", var_486_9)
						arg_483_1:RecordAudio("1107402126", var_486_9)
					else
						arg_483_1:AudioAction("play", "voice", "story_v_side_new_1107402", "1107402126", "story_v_side_new_1107402.awb")
					end

					arg_483_1:RecordHistoryTalkVoice("story_v_side_new_1107402", "1107402126", "story_v_side_new_1107402.awb")
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
	Play1107402127 = function(arg_487_0, arg_487_1)
		arg_487_1.time_ = 0
		arg_487_1.frameCnt_ = 0
		arg_487_1.state_ = "playing"
		arg_487_1.curTalkId_ = 1107402127
		arg_487_1.duration_ = 5

		SetActive(arg_487_1.tipsGo_, false)

		function arg_487_1.onSingleLineFinish_()
			arg_487_1.onSingleLineUpdate_ = nil
			arg_487_1.onSingleLineFinish_ = nil
			arg_487_1.state_ = "waiting"
		end

		function arg_487_1.playNext_(arg_489_0)
			if arg_489_0 == 1 then
				arg_487_0:Play1107402128(arg_487_1)
			end
		end

		function arg_487_1.onSingleLineUpdate_(arg_490_0)
			if 0 < arg_487_1.time_ and arg_487_1.time_ <= 0 + arg_490_0 and not isNil(arg_487_1.actors_["1074ui_story"]) and arg_487_1.var_.characterEffect1074ui_story == nil then
				arg_487_1.var_.characterEffect1074ui_story = arg_487_1.actors_["1074ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_490_0 = 0.1

			if 0 <= arg_487_1.time_ and arg_487_1.time_ < 0 + var_490_0 and not isNil(arg_487_1.actors_["1074ui_story"]) then
				if arg_487_1.var_.characterEffect1074ui_story and not isNil(arg_487_1.actors_["1074ui_story"]) then
					arg_487_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_487_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_487_1.time_ - 0) / var_490_0)
				end
			end

			if arg_487_1.time_ >= 0 + var_490_0 and arg_487_1.time_ < 0 + var_490_0 + arg_490_0 and not isNil(arg_487_1.actors_["1074ui_story"]) and arg_487_1.var_.characterEffect1074ui_story then
				arg_487_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_487_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			local var_490_1 = 0
			local var_490_2 = 0.225

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

				arg_487_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_487_1.callingController_:SetSelectedState("normal")

				arg_487_1.keyicon_.color = Color.New(1, 1, 1)
				arg_487_1.icon_.color = Color.New(1, 1, 1)

				local var_490_3 = arg_487_1:FormatText(arg_487_1:GetWordFromCfg(1107402127).content)

				arg_487_1.text_.text = var_490_3

				LuaForUtil.ClearLinePrefixSymbol(arg_487_1.text_)

				local var_490_5 = 9 <= 0 and var_490_2 or var_490_2 * (utf8.len(var_490_3) / 9)

				if (9 <= 0 and var_490_2 or var_490_2 * (utf8.len(var_490_3) / 9)) > 0 and var_490_2 < var_490_5 then
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
	Play1107402128 = function(arg_491_0, arg_491_1)
		arg_491_1.time_ = 0
		arg_491_1.frameCnt_ = 0
		arg_491_1.state_ = "playing"
		arg_491_1.curTalkId_ = 1107402128
		arg_491_1.duration_ = 2

		SetActive(arg_491_1.tipsGo_, false)

		function arg_491_1.onSingleLineFinish_()
			arg_491_1.onSingleLineUpdate_ = nil
			arg_491_1.onSingleLineFinish_ = nil
			arg_491_1.state_ = "waiting"
		end

		function arg_491_1.playNext_(arg_493_0)
			if arg_493_0 == 1 then
				arg_491_0:Play1107402129(arg_491_1)
			end
		end

		function arg_491_1.onSingleLineUpdate_(arg_494_0)
			if 0 < arg_491_1.time_ and arg_491_1.time_ <= 0 + arg_494_0 and not isNil(arg_491_1.actors_["1074ui_story"]) and arg_491_1.var_.characterEffect1074ui_story == nil then
				arg_491_1.var_.characterEffect1074ui_story = arg_491_1.actors_["1074ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_494_0 = 0.1

			if 0 <= arg_491_1.time_ and arg_491_1.time_ < 0 + var_494_0 and not isNil(arg_491_1.actors_["1074ui_story"]) then
				if arg_491_1.var_.characterEffect1074ui_story and not isNil(arg_491_1.actors_["1074ui_story"]) then
					arg_491_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_491_1.time_ >= 0 + var_494_0 and arg_491_1.time_ < 0 + var_494_0 + arg_494_0 and not isNil(arg_491_1.actors_["1074ui_story"]) and arg_491_1.var_.characterEffect1074ui_story then
				arg_491_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			if 0 < arg_491_1.time_ and arg_491_1.time_ <= 0 + arg_494_0 then
				arg_491_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action2_1")
			end

			if 0 < arg_491_1.time_ and arg_491_1.time_ <= 0 + arg_494_0 then
				arg_491_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_494_2 = 0
			local var_494_3 = 0.175

			if 0 < arg_491_1.time_ and arg_491_1.time_ <= var_494_2 + arg_494_0 then
				arg_491_1.talkMaxDuration = 0
				arg_491_1.dialogCg_.alpha = 1

				arg_491_1.dialog_:SetActive(true)
				SetActive(arg_491_1.leftNameGo_, true)

				arg_491_1.leftNameTxt_.text = arg_491_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_491_1.leftNameTxt_.transform)

				arg_491_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_491_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_491_1:RecordName(arg_491_1.leftNameTxt_.text)
				SetActive(arg_491_1.iconTrs_.gameObject, false)
				arg_491_1.callingController_:SetSelectedState("normal")

				local var_494_4 = arg_491_1:GetWordFromCfg(1107402128)
				local var_494_5 = arg_491_1:FormatText(var_494_4.content)

				arg_491_1.text_.text = var_494_5

				LuaForUtil.ClearLinePrefixSymbol(arg_491_1.text_)

				local var_494_7 = 7 <= 0 and var_494_3 or var_494_3 * (utf8.len(var_494_5) / 7)

				if (7 <= 0 and var_494_3 or var_494_3 * (utf8.len(var_494_5) / 7)) > 0 and var_494_3 < var_494_7 then
					arg_491_1.talkMaxDuration = var_494_7

					if var_494_7 + var_494_2 > arg_491_1.duration_ then
						arg_491_1.duration_ = var_494_7 + var_494_2
					end
				end

				arg_491_1.text_.text = var_494_5
				arg_491_1.typewritter.percent = 0

				arg_491_1.typewritter:SetDirty()
				arg_491_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107402", "1107402128", "story_v_side_new_1107402.awb") ~= 0 then
					local var_494_8 = manager.audio:GetVoiceLength("story_v_side_new_1107402", "1107402128", "story_v_side_new_1107402.awb") / 1000

					if var_494_8 + var_494_2 > arg_491_1.duration_ then
						arg_491_1.duration_ = var_494_8 + var_494_2
					end

					if var_494_4.prefab_name ~= "" and arg_491_1.actors_[var_494_4.prefab_name] ~= nil then
						local var_494_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_491_1.actors_[var_494_4.prefab_name].transform, "story_v_side_new_1107402", "1107402128", "story_v_side_new_1107402.awb")

						arg_491_1:RecordAudio("1107402128", var_494_9)
						arg_491_1:RecordAudio("1107402128", var_494_9)
					else
						arg_491_1:AudioAction("play", "voice", "story_v_side_new_1107402", "1107402128", "story_v_side_new_1107402.awb")
					end

					arg_491_1:RecordHistoryTalkVoice("story_v_side_new_1107402", "1107402128", "story_v_side_new_1107402.awb")
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
	Play1107402129 = function(arg_495_0, arg_495_1)
		arg_495_1.time_ = 0
		arg_495_1.frameCnt_ = 0
		arg_495_1.state_ = "playing"
		arg_495_1.curTalkId_ = 1107402129
		arg_495_1.duration_ = 8.13

		SetActive(arg_495_1.tipsGo_, false)

		function arg_495_1.onSingleLineFinish_()
			arg_495_1.onSingleLineUpdate_ = nil
			arg_495_1.onSingleLineFinish_ = nil
			arg_495_1.state_ = "waiting"
		end

		function arg_495_1.playNext_(arg_497_0)
			if arg_497_0 == 1 then
				arg_495_0:Play1107402130(arg_495_1)
			end
		end

		function arg_495_1.onSingleLineUpdate_(arg_498_0)
			local var_498_0 = 0.9

			if 0 < arg_495_1.time_ and arg_495_1.time_ <= 0 + arg_498_0 then
				arg_495_1.talkMaxDuration = 0
				arg_495_1.dialogCg_.alpha = 1

				arg_495_1.dialog_:SetActive(true)
				SetActive(arg_495_1.leftNameGo_, true)

				arg_495_1.leftNameTxt_.text = arg_495_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_495_1.leftNameTxt_.transform)

				arg_495_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_495_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_495_1:RecordName(arg_495_1.leftNameTxt_.text)
				SetActive(arg_495_1.iconTrs_.gameObject, false)
				arg_495_1.callingController_:SetSelectedState("normal")

				local var_498_1 = arg_495_1:GetWordFromCfg(1107402129)
				local var_498_2 = arg_495_1:FormatText(var_498_1.content)

				arg_495_1.text_.text = var_498_2

				LuaForUtil.ClearLinePrefixSymbol(arg_495_1.text_)

				local var_498_4 = 36 <= 0 and var_498_0 or var_498_0 * (utf8.len(var_498_2) / 36)

				if (36 <= 0 and var_498_0 or var_498_0 * (utf8.len(var_498_2) / 36)) > 0 and var_498_0 < var_498_4 then
					arg_495_1.talkMaxDuration = var_498_4

					if var_498_4 + 0 > arg_495_1.duration_ then
						arg_495_1.duration_ = var_498_4 + 0
					end
				end

				arg_495_1.text_.text = var_498_2
				arg_495_1.typewritter.percent = 0

				arg_495_1.typewritter:SetDirty()
				arg_495_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107402", "1107402129", "story_v_side_new_1107402.awb") ~= 0 then
					local var_498_5 = manager.audio:GetVoiceLength("story_v_side_new_1107402", "1107402129", "story_v_side_new_1107402.awb") / 1000

					if var_498_5 + 0 > arg_495_1.duration_ then
						arg_495_1.duration_ = var_498_5 + 0
					end

					if var_498_1.prefab_name ~= "" and arg_495_1.actors_[var_498_1.prefab_name] ~= nil then
						local var_498_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_495_1.actors_[var_498_1.prefab_name].transform, "story_v_side_new_1107402", "1107402129", "story_v_side_new_1107402.awb")

						arg_495_1:RecordAudio("1107402129", var_498_6)
						arg_495_1:RecordAudio("1107402129", var_498_6)
					else
						arg_495_1:AudioAction("play", "voice", "story_v_side_new_1107402", "1107402129", "story_v_side_new_1107402.awb")
					end

					arg_495_1:RecordHistoryTalkVoice("story_v_side_new_1107402", "1107402129", "story_v_side_new_1107402.awb")
				end

				arg_495_1:RecordContent(arg_495_1.text_.text)
			end

			local var_498_7 = math.max(var_498_0, arg_495_1.talkMaxDuration)

			if 0 <= arg_495_1.time_ and arg_495_1.time_ < 0 + var_498_7 then
				arg_495_1.typewritter.percent = (arg_495_1.time_ - 0) / var_498_7

				arg_495_1.typewritter:SetDirty()
			end

			if arg_495_1.time_ >= 0 + var_498_7 and arg_495_1.time_ < 0 + var_498_7 + arg_498_0 then
				arg_495_1.typewritter.percent = 1

				arg_495_1.typewritter:SetDirty()
				arg_495_1:ShowNextGo(true)
			end
		end

		arg_495_1.nodeConfigList_ = {}

		arg_495_1:InitPlayNodeList()
	end,
	Play1107402130 = function(arg_499_0, arg_499_1)
		arg_499_1.time_ = 0
		arg_499_1.frameCnt_ = 0
		arg_499_1.state_ = "playing"
		arg_499_1.curTalkId_ = 1107402130
		arg_499_1.duration_ = 4.67

		SetActive(arg_499_1.tipsGo_, false)

		function arg_499_1.onSingleLineFinish_()
			arg_499_1.onSingleLineUpdate_ = nil
			arg_499_1.onSingleLineFinish_ = nil
			arg_499_1.state_ = "waiting"
		end

		function arg_499_1.playNext_(arg_501_0)
			if arg_501_0 == 1 then
				arg_499_0:Play1107402131(arg_499_1)
			end
		end

		function arg_499_1.onSingleLineUpdate_(arg_502_0)
			local var_502_0 = 0.475

			if 0 < arg_499_1.time_ and arg_499_1.time_ <= 0 + arg_502_0 then
				arg_499_1.talkMaxDuration = 0
				arg_499_1.dialogCg_.alpha = 1

				arg_499_1.dialog_:SetActive(true)
				SetActive(arg_499_1.leftNameGo_, true)

				arg_499_1.leftNameTxt_.text = arg_499_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_499_1.leftNameTxt_.transform)

				arg_499_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_499_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_499_1:RecordName(arg_499_1.leftNameTxt_.text)
				SetActive(arg_499_1.iconTrs_.gameObject, false)
				arg_499_1.callingController_:SetSelectedState("normal")

				local var_502_1 = arg_499_1:GetWordFromCfg(1107402130)
				local var_502_2 = arg_499_1:FormatText(var_502_1.content)

				arg_499_1.text_.text = var_502_2

				LuaForUtil.ClearLinePrefixSymbol(arg_499_1.text_)

				local var_502_4 = 19 <= 0 and var_502_0 or var_502_0 * (utf8.len(var_502_2) / 19)

				if (19 <= 0 and var_502_0 or var_502_0 * (utf8.len(var_502_2) / 19)) > 0 and var_502_0 < var_502_4 then
					arg_499_1.talkMaxDuration = var_502_4

					if var_502_4 + 0 > arg_499_1.duration_ then
						arg_499_1.duration_ = var_502_4 + 0
					end
				end

				arg_499_1.text_.text = var_502_2
				arg_499_1.typewritter.percent = 0

				arg_499_1.typewritter:SetDirty()
				arg_499_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107402", "1107402130", "story_v_side_new_1107402.awb") ~= 0 then
					local var_502_5 = manager.audio:GetVoiceLength("story_v_side_new_1107402", "1107402130", "story_v_side_new_1107402.awb") / 1000

					if var_502_5 + 0 > arg_499_1.duration_ then
						arg_499_1.duration_ = var_502_5 + 0
					end

					if var_502_1.prefab_name ~= "" and arg_499_1.actors_[var_502_1.prefab_name] ~= nil then
						local var_502_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_499_1.actors_[var_502_1.prefab_name].transform, "story_v_side_new_1107402", "1107402130", "story_v_side_new_1107402.awb")

						arg_499_1:RecordAudio("1107402130", var_502_6)
						arg_499_1:RecordAudio("1107402130", var_502_6)
					else
						arg_499_1:AudioAction("play", "voice", "story_v_side_new_1107402", "1107402130", "story_v_side_new_1107402.awb")
					end

					arg_499_1:RecordHistoryTalkVoice("story_v_side_new_1107402", "1107402130", "story_v_side_new_1107402.awb")
				end

				arg_499_1:RecordContent(arg_499_1.text_.text)
			end

			local var_502_7 = math.max(var_502_0, arg_499_1.talkMaxDuration)

			if 0 <= arg_499_1.time_ and arg_499_1.time_ < 0 + var_502_7 then
				arg_499_1.typewritter.percent = (arg_499_1.time_ - 0) / var_502_7

				arg_499_1.typewritter:SetDirty()
			end

			if arg_499_1.time_ >= 0 + var_502_7 and arg_499_1.time_ < 0 + var_502_7 + arg_502_0 then
				arg_499_1.typewritter.percent = 1

				arg_499_1.typewritter:SetDirty()
				arg_499_1:ShowNextGo(true)
			end
		end

		arg_499_1.nodeConfigList_ = {}

		arg_499_1:InitPlayNodeList()
	end,
	Play1107402131 = function(arg_503_0, arg_503_1)
		arg_503_1.time_ = 0
		arg_503_1.frameCnt_ = 0
		arg_503_1.state_ = "playing"
		arg_503_1.curTalkId_ = 1107402131
		arg_503_1.duration_ = 5

		SetActive(arg_503_1.tipsGo_, false)

		function arg_503_1.onSingleLineFinish_()
			arg_503_1.onSingleLineUpdate_ = nil
			arg_503_1.onSingleLineFinish_ = nil
			arg_503_1.state_ = "waiting"
		end

		function arg_503_1.playNext_(arg_505_0)
			if arg_505_0 == 1 then
				arg_503_0:Play1107402132(arg_503_1)
			end
		end

		function arg_503_1.onSingleLineUpdate_(arg_506_0)
			if 0 < arg_503_1.time_ and arg_503_1.time_ <= 0 + arg_506_0 and not isNil(arg_503_1.actors_["1074ui_story"]) and arg_503_1.var_.characterEffect1074ui_story == nil then
				arg_503_1.var_.characterEffect1074ui_story = arg_503_1.actors_["1074ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_506_0 = 0.1

			if 0 <= arg_503_1.time_ and arg_503_1.time_ < 0 + var_506_0 and not isNil(arg_503_1.actors_["1074ui_story"]) then
				if arg_503_1.var_.characterEffect1074ui_story and not isNil(arg_503_1.actors_["1074ui_story"]) then
					arg_503_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_503_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_503_1.time_ - 0) / var_506_0)
				end
			end

			if arg_503_1.time_ >= 0 + var_506_0 and arg_503_1.time_ < 0 + var_506_0 + arg_506_0 and not isNil(arg_503_1.actors_["1074ui_story"]) and arg_503_1.var_.characterEffect1074ui_story then
				arg_503_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_503_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			local var_506_1 = 0
			local var_506_2 = 0.9

			if 0 < arg_503_1.time_ and arg_503_1.time_ <= var_506_1 + arg_506_0 then
				arg_503_1.talkMaxDuration = 0
				arg_503_1.dialogCg_.alpha = 1

				arg_503_1.dialog_:SetActive(true)
				SetActive(arg_503_1.leftNameGo_, true)

				arg_503_1.leftNameTxt_.text = arg_503_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_503_1.leftNameTxt_.transform)

				arg_503_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_503_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_503_1:RecordName(arg_503_1.leftNameTxt_.text)
				SetActive(arg_503_1.iconTrs_.gameObject, true)
				arg_503_1.iconController_:SetSelectedState("hero")

				arg_503_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_503_1.callingController_:SetSelectedState("normal")

				arg_503_1.keyicon_.color = Color.New(1, 1, 1)
				arg_503_1.icon_.color = Color.New(1, 1, 1)

				local var_506_3 = arg_503_1:FormatText(arg_503_1:GetWordFromCfg(1107402131).content)

				arg_503_1.text_.text = var_506_3

				LuaForUtil.ClearLinePrefixSymbol(arg_503_1.text_)

				local var_506_5 = 36 <= 0 and var_506_2 or var_506_2 * (utf8.len(var_506_3) / 36)

				if (36 <= 0 and var_506_2 or var_506_2 * (utf8.len(var_506_3) / 36)) > 0 and var_506_2 < var_506_5 then
					arg_503_1.talkMaxDuration = var_506_5

					if var_506_5 + var_506_1 > arg_503_1.duration_ then
						arg_503_1.duration_ = var_506_5 + var_506_1
					end
				end

				arg_503_1.text_.text = var_506_3
				arg_503_1.typewritter.percent = 0

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(false)
				arg_503_1:RecordContent(arg_503_1.text_.text)
			end

			local var_506_6 = math.max(var_506_2, arg_503_1.talkMaxDuration)

			if var_506_1 <= arg_503_1.time_ and arg_503_1.time_ < var_506_1 + var_506_6 then
				arg_503_1.typewritter.percent = (arg_503_1.time_ - var_506_1) / var_506_6

				arg_503_1.typewritter:SetDirty()
			end

			if arg_503_1.time_ >= var_506_1 + var_506_6 and arg_503_1.time_ < var_506_1 + var_506_6 + arg_506_0 then
				arg_503_1.typewritter.percent = 1

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(true)
			end
		end

		arg_503_1.nodeConfigList_ = {}

		arg_503_1:InitPlayNodeList()
	end,
	Play1107402132 = function(arg_507_0, arg_507_1)
		arg_507_1.time_ = 0
		arg_507_1.frameCnt_ = 0
		arg_507_1.state_ = "playing"
		arg_507_1.curTalkId_ = 1107402132
		arg_507_1.duration_ = 6.57

		SetActive(arg_507_1.tipsGo_, false)

		function arg_507_1.onSingleLineFinish_()
			arg_507_1.onSingleLineUpdate_ = nil
			arg_507_1.onSingleLineFinish_ = nil
			arg_507_1.state_ = "waiting"
		end

		function arg_507_1.playNext_(arg_509_0)
			if arg_509_0 == 1 then
				arg_507_0:Play1107402133(arg_507_1)
			end
		end

		function arg_507_1.onSingleLineUpdate_(arg_510_0)
			if 0 < arg_507_1.time_ and arg_507_1.time_ <= 0 + arg_510_0 and not isNil(arg_507_1.actors_["1074ui_story"]) and arg_507_1.var_.characterEffect1074ui_story == nil then
				arg_507_1.var_.characterEffect1074ui_story = arg_507_1.actors_["1074ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_510_0 = 0.1

			if 0 <= arg_507_1.time_ and arg_507_1.time_ < 0 + var_510_0 and not isNil(arg_507_1.actors_["1074ui_story"]) then
				if arg_507_1.var_.characterEffect1074ui_story and not isNil(arg_507_1.actors_["1074ui_story"]) then
					arg_507_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_507_1.time_ >= 0 + var_510_0 and arg_507_1.time_ < 0 + var_510_0 + arg_510_0 and not isNil(arg_507_1.actors_["1074ui_story"]) and arg_507_1.var_.characterEffect1074ui_story then
				arg_507_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			if 0 < arg_507_1.time_ and arg_507_1.time_ <= 0 + arg_510_0 then
				arg_507_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_510_2 = 0
			local var_510_3 = 0.475

			if 0 < arg_507_1.time_ and arg_507_1.time_ <= var_510_2 + arg_510_0 then
				arg_507_1.talkMaxDuration = 0
				arg_507_1.dialogCg_.alpha = 1

				arg_507_1.dialog_:SetActive(true)
				SetActive(arg_507_1.leftNameGo_, true)

				arg_507_1.leftNameTxt_.text = arg_507_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_507_1.leftNameTxt_.transform)

				arg_507_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_507_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_507_1:RecordName(arg_507_1.leftNameTxt_.text)
				SetActive(arg_507_1.iconTrs_.gameObject, false)
				arg_507_1.callingController_:SetSelectedState("normal")

				local var_510_4 = arg_507_1:GetWordFromCfg(1107402132)
				local var_510_5 = arg_507_1:FormatText(var_510_4.content)

				arg_507_1.text_.text = var_510_5

				LuaForUtil.ClearLinePrefixSymbol(arg_507_1.text_)

				local var_510_7 = 19 <= 0 and var_510_3 or var_510_3 * (utf8.len(var_510_5) / 19)

				if (19 <= 0 and var_510_3 or var_510_3 * (utf8.len(var_510_5) / 19)) > 0 and var_510_3 < var_510_7 then
					arg_507_1.talkMaxDuration = var_510_7

					if var_510_7 + var_510_2 > arg_507_1.duration_ then
						arg_507_1.duration_ = var_510_7 + var_510_2
					end
				end

				arg_507_1.text_.text = var_510_5
				arg_507_1.typewritter.percent = 0

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107402", "1107402132", "story_v_side_new_1107402.awb") ~= 0 then
					local var_510_8 = manager.audio:GetVoiceLength("story_v_side_new_1107402", "1107402132", "story_v_side_new_1107402.awb") / 1000

					if var_510_8 + var_510_2 > arg_507_1.duration_ then
						arg_507_1.duration_ = var_510_8 + var_510_2
					end

					if var_510_4.prefab_name ~= "" and arg_507_1.actors_[var_510_4.prefab_name] ~= nil then
						local var_510_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_507_1.actors_[var_510_4.prefab_name].transform, "story_v_side_new_1107402", "1107402132", "story_v_side_new_1107402.awb")

						arg_507_1:RecordAudio("1107402132", var_510_9)
						arg_507_1:RecordAudio("1107402132", var_510_9)
					else
						arg_507_1:AudioAction("play", "voice", "story_v_side_new_1107402", "1107402132", "story_v_side_new_1107402.awb")
					end

					arg_507_1:RecordHistoryTalkVoice("story_v_side_new_1107402", "1107402132", "story_v_side_new_1107402.awb")
				end

				arg_507_1:RecordContent(arg_507_1.text_.text)
			end

			local var_510_10 = math.max(var_510_3, arg_507_1.talkMaxDuration)

			if var_510_2 <= arg_507_1.time_ and arg_507_1.time_ < var_510_2 + var_510_10 then
				arg_507_1.typewritter.percent = (arg_507_1.time_ - var_510_2) / var_510_10

				arg_507_1.typewritter:SetDirty()
			end

			if arg_507_1.time_ >= var_510_2 + var_510_10 and arg_507_1.time_ < var_510_2 + var_510_10 + arg_510_0 then
				arg_507_1.typewritter.percent = 1

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(true)
			end
		end

		arg_507_1.nodeConfigList_ = {}

		arg_507_1:InitPlayNodeList()
	end,
	Play1107402133 = function(arg_511_0, arg_511_1)
		arg_511_1.time_ = 0
		arg_511_1.frameCnt_ = 0
		arg_511_1.state_ = "playing"
		arg_511_1.curTalkId_ = 1107402133
		arg_511_1.duration_ = 5

		SetActive(arg_511_1.tipsGo_, false)

		function arg_511_1.onSingleLineFinish_()
			arg_511_1.onSingleLineUpdate_ = nil
			arg_511_1.onSingleLineFinish_ = nil
			arg_511_1.state_ = "waiting"
		end

		function arg_511_1.playNext_(arg_513_0)
			if arg_513_0 == 1 then
				arg_511_0:Play1107402134(arg_511_1)
			end
		end

		function arg_511_1.onSingleLineUpdate_(arg_514_0)
			if 0 < arg_511_1.time_ and arg_511_1.time_ <= 0 + arg_514_0 and not isNil(arg_511_1.actors_["1074ui_story"]) and arg_511_1.var_.characterEffect1074ui_story == nil then
				arg_511_1.var_.characterEffect1074ui_story = arg_511_1.actors_["1074ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_514_0 = 0.1

			if 0 <= arg_511_1.time_ and arg_511_1.time_ < 0 + var_514_0 and not isNil(arg_511_1.actors_["1074ui_story"]) then
				if arg_511_1.var_.characterEffect1074ui_story and not isNil(arg_511_1.actors_["1074ui_story"]) then
					arg_511_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_511_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_511_1.time_ - 0) / var_514_0)
				end
			end

			if arg_511_1.time_ >= 0 + var_514_0 and arg_511_1.time_ < 0 + var_514_0 + arg_514_0 and not isNil(arg_511_1.actors_["1074ui_story"]) and arg_511_1.var_.characterEffect1074ui_story then
				arg_511_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_511_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			local var_514_1 = 0
			local var_514_2 = 0.375

			if 0 < arg_511_1.time_ and arg_511_1.time_ <= var_514_1 + arg_514_0 then
				arg_511_1.talkMaxDuration = 0
				arg_511_1.dialogCg_.alpha = 1

				arg_511_1.dialog_:SetActive(true)
				SetActive(arg_511_1.leftNameGo_, false)

				arg_511_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_511_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_511_1:RecordName(arg_511_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_511_1.iconTrs_.gameObject, false)
				arg_511_1.callingController_:SetSelectedState("normal")

				local var_514_3 = arg_511_1:FormatText(arg_511_1:GetWordFromCfg(1107402133).content)

				arg_511_1.text_.text = var_514_3

				LuaForUtil.ClearLinePrefixSymbol(arg_511_1.text_)

				local var_514_5 = 15 <= 0 and var_514_2 or var_514_2 * (utf8.len(var_514_3) / 15)

				if (15 <= 0 and var_514_2 or var_514_2 * (utf8.len(var_514_3) / 15)) > 0 and var_514_2 < var_514_5 then
					arg_511_1.talkMaxDuration = var_514_5

					if var_514_5 + var_514_1 > arg_511_1.duration_ then
						arg_511_1.duration_ = var_514_5 + var_514_1
					end
				end

				arg_511_1.text_.text = var_514_3
				arg_511_1.typewritter.percent = 0

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(false)
				arg_511_1:RecordContent(arg_511_1.text_.text)
			end

			local var_514_6 = math.max(var_514_2, arg_511_1.talkMaxDuration)

			if var_514_1 <= arg_511_1.time_ and arg_511_1.time_ < var_514_1 + var_514_6 then
				arg_511_1.typewritter.percent = (arg_511_1.time_ - var_514_1) / var_514_6

				arg_511_1.typewritter:SetDirty()
			end

			if arg_511_1.time_ >= var_514_1 + var_514_6 and arg_511_1.time_ < var_514_1 + var_514_6 + arg_514_0 then
				arg_511_1.typewritter.percent = 1

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(true)
			end
		end

		arg_511_1.nodeConfigList_ = {}

		arg_511_1:InitPlayNodeList()
	end,
	Play1107402134 = function(arg_515_0, arg_515_1)
		arg_515_1.time_ = 0
		arg_515_1.frameCnt_ = 0
		arg_515_1.state_ = "playing"
		arg_515_1.curTalkId_ = 1107402134
		arg_515_1.duration_ = 5

		SetActive(arg_515_1.tipsGo_, false)

		function arg_515_1.onSingleLineFinish_()
			arg_515_1.onSingleLineUpdate_ = nil
			arg_515_1.onSingleLineFinish_ = nil
			arg_515_1.state_ = "waiting"
		end

		function arg_515_1.playNext_(arg_517_0)
			if arg_517_0 == 1 then
				arg_515_0:Play1107402135(arg_515_1)
			end
		end

		function arg_515_1.onSingleLineUpdate_(arg_518_0)
			local var_518_0 = 1.225

			if 0 < arg_515_1.time_ and arg_515_1.time_ <= 0 + arg_518_0 then
				arg_515_1.talkMaxDuration = 0
				arg_515_1.dialogCg_.alpha = 1

				arg_515_1.dialog_:SetActive(true)
				SetActive(arg_515_1.leftNameGo_, false)

				arg_515_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_515_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_515_1:RecordName(arg_515_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_515_1.iconTrs_.gameObject, false)
				arg_515_1.callingController_:SetSelectedState("normal")

				local var_518_1 = arg_515_1:FormatText(arg_515_1:GetWordFromCfg(1107402134).content)

				arg_515_1.text_.text = var_518_1

				LuaForUtil.ClearLinePrefixSymbol(arg_515_1.text_)

				local var_518_3 = 49 <= 0 and var_518_0 or var_518_0 * (utf8.len(var_518_1) / 49)

				if (49 <= 0 and var_518_0 or var_518_0 * (utf8.len(var_518_1) / 49)) > 0 and var_518_0 < var_518_3 then
					arg_515_1.talkMaxDuration = var_518_3

					if var_518_3 + 0 > arg_515_1.duration_ then
						arg_515_1.duration_ = var_518_3 + 0
					end
				end

				arg_515_1.text_.text = var_518_1
				arg_515_1.typewritter.percent = 0

				arg_515_1.typewritter:SetDirty()
				arg_515_1:ShowNextGo(false)
				arg_515_1:RecordContent(arg_515_1.text_.text)
			end

			local var_518_4 = math.max(var_518_0, arg_515_1.talkMaxDuration)

			if 0 <= arg_515_1.time_ and arg_515_1.time_ < 0 + var_518_4 then
				arg_515_1.typewritter.percent = (arg_515_1.time_ - 0) / var_518_4

				arg_515_1.typewritter:SetDirty()
			end

			if arg_515_1.time_ >= 0 + var_518_4 and arg_515_1.time_ < 0 + var_518_4 + arg_518_0 then
				arg_515_1.typewritter.percent = 1

				arg_515_1.typewritter:SetDirty()
				arg_515_1:ShowNextGo(true)
			end
		end

		arg_515_1.nodeConfigList_ = {}

		arg_515_1:InitPlayNodeList()
	end,
	Play1107402135 = function(arg_519_0, arg_519_1)
		arg_519_1.time_ = 0
		arg_519_1.frameCnt_ = 0
		arg_519_1.state_ = "playing"
		arg_519_1.curTalkId_ = 1107402135
		arg_519_1.duration_ = 2

		SetActive(arg_519_1.tipsGo_, false)

		function arg_519_1.onSingleLineFinish_()
			arg_519_1.onSingleLineUpdate_ = nil
			arg_519_1.onSingleLineFinish_ = nil
			arg_519_1.state_ = "waiting"
		end

		function arg_519_1.playNext_(arg_521_0)
			if arg_521_0 == 1 then
				arg_519_0:Play1107402136(arg_519_1)
			end
		end

		function arg_519_1.onSingleLineUpdate_(arg_522_0)
			if 0 < arg_519_1.time_ and arg_519_1.time_ <= 0 + arg_522_0 and not isNil(arg_519_1.actors_["1074ui_story"]) and arg_519_1.var_.characterEffect1074ui_story == nil then
				arg_519_1.var_.characterEffect1074ui_story = arg_519_1.actors_["1074ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_522_0 = 0.1

			if 0 <= arg_519_1.time_ and arg_519_1.time_ < 0 + var_522_0 and not isNil(arg_519_1.actors_["1074ui_story"]) then
				if arg_519_1.var_.characterEffect1074ui_story and not isNil(arg_519_1.actors_["1074ui_story"]) then
					arg_519_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_519_1.time_ >= 0 + var_522_0 and arg_519_1.time_ < 0 + var_522_0 + arg_522_0 and not isNil(arg_519_1.actors_["1074ui_story"]) and arg_519_1.var_.characterEffect1074ui_story then
				arg_519_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			if 0 < arg_519_1.time_ and arg_519_1.time_ <= 0 + arg_522_0 then
				arg_519_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action2_2")
			end

			if 0 < arg_519_1.time_ and arg_519_1.time_ <= 0 + arg_522_0 then
				arg_519_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_522_2 = 0
			local var_522_3 = 0.125

			if 0 < arg_519_1.time_ and arg_519_1.time_ <= var_522_2 + arg_522_0 then
				arg_519_1.talkMaxDuration = 0
				arg_519_1.dialogCg_.alpha = 1

				arg_519_1.dialog_:SetActive(true)
				SetActive(arg_519_1.leftNameGo_, true)

				arg_519_1.leftNameTxt_.text = arg_519_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_519_1.leftNameTxt_.transform)

				arg_519_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_519_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_519_1:RecordName(arg_519_1.leftNameTxt_.text)
				SetActive(arg_519_1.iconTrs_.gameObject, false)
				arg_519_1.callingController_:SetSelectedState("normal")

				local var_522_4 = arg_519_1:GetWordFromCfg(1107402135)
				local var_522_5 = arg_519_1:FormatText(var_522_4.content)

				arg_519_1.text_.text = var_522_5

				LuaForUtil.ClearLinePrefixSymbol(arg_519_1.text_)

				local var_522_7 = 5 <= 0 and var_522_3 or var_522_3 * (utf8.len(var_522_5) / 5)

				if (5 <= 0 and var_522_3 or var_522_3 * (utf8.len(var_522_5) / 5)) > 0 and var_522_3 < var_522_7 then
					arg_519_1.talkMaxDuration = var_522_7

					if var_522_7 + var_522_2 > arg_519_1.duration_ then
						arg_519_1.duration_ = var_522_7 + var_522_2
					end
				end

				arg_519_1.text_.text = var_522_5
				arg_519_1.typewritter.percent = 0

				arg_519_1.typewritter:SetDirty()
				arg_519_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107402", "1107402135", "story_v_side_new_1107402.awb") ~= 0 then
					local var_522_8 = manager.audio:GetVoiceLength("story_v_side_new_1107402", "1107402135", "story_v_side_new_1107402.awb") / 1000

					if var_522_8 + var_522_2 > arg_519_1.duration_ then
						arg_519_1.duration_ = var_522_8 + var_522_2
					end

					if var_522_4.prefab_name ~= "" and arg_519_1.actors_[var_522_4.prefab_name] ~= nil then
						local var_522_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_519_1.actors_[var_522_4.prefab_name].transform, "story_v_side_new_1107402", "1107402135", "story_v_side_new_1107402.awb")

						arg_519_1:RecordAudio("1107402135", var_522_9)
						arg_519_1:RecordAudio("1107402135", var_522_9)
					else
						arg_519_1:AudioAction("play", "voice", "story_v_side_new_1107402", "1107402135", "story_v_side_new_1107402.awb")
					end

					arg_519_1:RecordHistoryTalkVoice("story_v_side_new_1107402", "1107402135", "story_v_side_new_1107402.awb")
				end

				arg_519_1:RecordContent(arg_519_1.text_.text)
			end

			local var_522_10 = math.max(var_522_3, arg_519_1.talkMaxDuration)

			if var_522_2 <= arg_519_1.time_ and arg_519_1.time_ < var_522_2 + var_522_10 then
				arg_519_1.typewritter.percent = (arg_519_1.time_ - var_522_2) / var_522_10

				arg_519_1.typewritter:SetDirty()
			end

			if arg_519_1.time_ >= var_522_2 + var_522_10 and arg_519_1.time_ < var_522_2 + var_522_10 + arg_522_0 then
				arg_519_1.typewritter.percent = 1

				arg_519_1.typewritter:SetDirty()
				arg_519_1:ShowNextGo(true)
			end
		end

		arg_519_1.nodeConfigList_ = {}

		arg_519_1:InitPlayNodeList()
	end,
	Play1107402136 = function(arg_523_0, arg_523_1)
		arg_523_1.time_ = 0
		arg_523_1.frameCnt_ = 0
		arg_523_1.state_ = "playing"
		arg_523_1.curTalkId_ = 1107402136
		arg_523_1.duration_ = 5

		SetActive(arg_523_1.tipsGo_, false)

		function arg_523_1.onSingleLineFinish_()
			arg_523_1.onSingleLineUpdate_ = nil
			arg_523_1.onSingleLineFinish_ = nil
			arg_523_1.state_ = "waiting"
		end

		function arg_523_1.playNext_(arg_525_0)
			if arg_525_0 == 1 then
				arg_523_0:Play1107402137(arg_523_1)
			end
		end

		function arg_523_1.onSingleLineUpdate_(arg_526_0)
			if 0 < arg_523_1.time_ and arg_523_1.time_ <= 0 + arg_526_0 and not isNil(arg_523_1.actors_["1074ui_story"]) and arg_523_1.var_.characterEffect1074ui_story == nil then
				arg_523_1.var_.characterEffect1074ui_story = arg_523_1.actors_["1074ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_526_0 = 0.1

			if 0 <= arg_523_1.time_ and arg_523_1.time_ < 0 + var_526_0 and not isNil(arg_523_1.actors_["1074ui_story"]) then
				if arg_523_1.var_.characterEffect1074ui_story and not isNil(arg_523_1.actors_["1074ui_story"]) then
					arg_523_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_523_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_523_1.time_ - 0) / var_526_0)
				end
			end

			if arg_523_1.time_ >= 0 + var_526_0 and arg_523_1.time_ < 0 + var_526_0 + arg_526_0 and not isNil(arg_523_1.actors_["1074ui_story"]) and arg_523_1.var_.characterEffect1074ui_story then
				arg_523_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_523_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			local var_526_1 = 0
			local var_526_2 = 0.475

			if 0 < arg_523_1.time_ and arg_523_1.time_ <= var_526_1 + arg_526_0 then
				arg_523_1.talkMaxDuration = 0
				arg_523_1.dialogCg_.alpha = 1

				arg_523_1.dialog_:SetActive(true)
				SetActive(arg_523_1.leftNameGo_, false)

				arg_523_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_523_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_523_1:RecordName(arg_523_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_523_1.iconTrs_.gameObject, false)
				arg_523_1.callingController_:SetSelectedState("normal")

				local var_526_3 = arg_523_1:FormatText(arg_523_1:GetWordFromCfg(1107402136).content)

				arg_523_1.text_.text = var_526_3

				LuaForUtil.ClearLinePrefixSymbol(arg_523_1.text_)

				local var_526_5 = 19 <= 0 and var_526_2 or var_526_2 * (utf8.len(var_526_3) / 19)

				if (19 <= 0 and var_526_2 or var_526_2 * (utf8.len(var_526_3) / 19)) > 0 and var_526_2 < var_526_5 then
					arg_523_1.talkMaxDuration = var_526_5

					if var_526_5 + var_526_1 > arg_523_1.duration_ then
						arg_523_1.duration_ = var_526_5 + var_526_1
					end
				end

				arg_523_1.text_.text = var_526_3
				arg_523_1.typewritter.percent = 0

				arg_523_1.typewritter:SetDirty()
				arg_523_1:ShowNextGo(false)
				arg_523_1:RecordContent(arg_523_1.text_.text)
			end

			local var_526_6 = math.max(var_526_2, arg_523_1.talkMaxDuration)

			if var_526_1 <= arg_523_1.time_ and arg_523_1.time_ < var_526_1 + var_526_6 then
				arg_523_1.typewritter.percent = (arg_523_1.time_ - var_526_1) / var_526_6

				arg_523_1.typewritter:SetDirty()
			end

			if arg_523_1.time_ >= var_526_1 + var_526_6 and arg_523_1.time_ < var_526_1 + var_526_6 + arg_526_0 then
				arg_523_1.typewritter.percent = 1

				arg_523_1.typewritter:SetDirty()
				arg_523_1:ShowNextGo(true)
			end
		end

		arg_523_1.nodeConfigList_ = {}

		arg_523_1:InitPlayNodeList()
	end,
	Play1107402137 = function(arg_527_0, arg_527_1)
		arg_527_1.time_ = 0
		arg_527_1.frameCnt_ = 0
		arg_527_1.state_ = "playing"
		arg_527_1.curTalkId_ = 1107402137
		arg_527_1.duration_ = 5

		SetActive(arg_527_1.tipsGo_, false)

		function arg_527_1.onSingleLineFinish_()
			arg_527_1.onSingleLineUpdate_ = nil
			arg_527_1.onSingleLineFinish_ = nil
			arg_527_1.state_ = "waiting"
			arg_527_1.auto_ = false
		end

		function arg_527_1.playNext_(arg_529_0)
			arg_527_1.onStoryFinished_()
		end

		function arg_527_1.onSingleLineUpdate_(arg_530_0)
			local var_530_0 = 0.25

			if 0 < arg_527_1.time_ and arg_527_1.time_ <= 0 + arg_530_0 then
				arg_527_1.talkMaxDuration = 0
				arg_527_1.dialogCg_.alpha = 1

				arg_527_1.dialog_:SetActive(true)
				SetActive(arg_527_1.leftNameGo_, true)

				arg_527_1.leftNameTxt_.text = arg_527_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_527_1.leftNameTxt_.transform)

				arg_527_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_527_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_527_1:RecordName(arg_527_1.leftNameTxt_.text)
				SetActive(arg_527_1.iconTrs_.gameObject, true)
				arg_527_1.iconController_:SetSelectedState("hero")

				arg_527_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_527_1.callingController_:SetSelectedState("normal")

				arg_527_1.keyicon_.color = Color.New(1, 1, 1)
				arg_527_1.icon_.color = Color.New(1, 1, 1)

				local var_530_1 = arg_527_1:FormatText(arg_527_1:GetWordFromCfg(1107402137).content)

				arg_527_1.text_.text = var_530_1

				LuaForUtil.ClearLinePrefixSymbol(arg_527_1.text_)

				local var_530_3 = 10 <= 0 and var_530_0 or var_530_0 * (utf8.len(var_530_1) / 10)

				if (10 <= 0 and var_530_0 or var_530_0 * (utf8.len(var_530_1) / 10)) > 0 and var_530_0 < var_530_3 then
					arg_527_1.talkMaxDuration = var_530_3

					if var_530_3 + 0 > arg_527_1.duration_ then
						arg_527_1.duration_ = var_530_3 + 0
					end
				end

				arg_527_1.text_.text = var_530_1
				arg_527_1.typewritter.percent = 0

				arg_527_1.typewritter:SetDirty()
				arg_527_1:ShowNextGo(false)
				arg_527_1:RecordContent(arg_527_1.text_.text)
			end

			local var_530_4 = math.max(var_530_0, arg_527_1.talkMaxDuration)

			if 0 <= arg_527_1.time_ and arg_527_1.time_ < 0 + var_530_4 then
				arg_527_1.typewritter.percent = (arg_527_1.time_ - 0) / var_530_4

				arg_527_1.typewritter:SetDirty()
			end

			if arg_527_1.time_ >= 0 + var_530_4 and arg_527_1.time_ < 0 + var_530_4 + arg_530_0 then
				arg_527_1.typewritter.percent = 1

				arg_527_1.typewritter:SetDirty()
				arg_527_1:ShowNextGo(true)
			end
		end

		arg_527_1.nodeConfigList_ = {}

		arg_527_1:InitPlayNodeList()
	end,
	Play1107402115 = function(arg_531_0, arg_531_1)
		arg_531_1.time_ = 0
		arg_531_1.frameCnt_ = 0
		arg_531_1.state_ = "playing"
		arg_531_1.curTalkId_ = 1107402115
		arg_531_1.duration_ = 5

		SetActive(arg_531_1.tipsGo_, false)

		function arg_531_1.onSingleLineFinish_()
			arg_531_1.onSingleLineUpdate_ = nil
			arg_531_1.onSingleLineFinish_ = nil
			arg_531_1.state_ = "waiting"
		end

		function arg_531_1.playNext_(arg_533_0)
			if arg_533_0 == 1 then
				arg_531_0:Play1107402116(arg_531_1)
			end
		end

		function arg_531_1.onSingleLineUpdate_(arg_534_0)
			local var_534_0 = 0.625

			if 0 < arg_531_1.time_ and arg_531_1.time_ <= 0 + arg_534_0 then
				arg_531_1.talkMaxDuration = 0
				arg_531_1.dialogCg_.alpha = 1

				arg_531_1.dialog_:SetActive(true)
				SetActive(arg_531_1.leftNameGo_, true)

				arg_531_1.leftNameTxt_.text = arg_531_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_531_1.leftNameTxt_.transform)

				arg_531_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_531_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_531_1:RecordName(arg_531_1.leftNameTxt_.text)
				SetActive(arg_531_1.iconTrs_.gameObject, true)
				arg_531_1.iconController_:SetSelectedState("hero")

				arg_531_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_531_1.callingController_:SetSelectedState("normal")

				arg_531_1.keyicon_.color = Color.New(1, 1, 1)
				arg_531_1.icon_.color = Color.New(1, 1, 1)

				local var_534_1 = arg_531_1:FormatText(arg_531_1:GetWordFromCfg(1107402115).content)

				arg_531_1.text_.text = var_534_1

				LuaForUtil.ClearLinePrefixSymbol(arg_531_1.text_)

				local var_534_3 = 25 <= 0 and var_534_0 or var_534_0 * (utf8.len(var_534_1) / 25)

				if (25 <= 0 and var_534_0 or var_534_0 * (utf8.len(var_534_1) / 25)) > 0 and var_534_0 < var_534_3 then
					arg_531_1.talkMaxDuration = var_534_3

					if var_534_3 + 0 > arg_531_1.duration_ then
						arg_531_1.duration_ = var_534_3 + 0
					end
				end

				arg_531_1.text_.text = var_534_1
				arg_531_1.typewritter.percent = 0

				arg_531_1.typewritter:SetDirty()
				arg_531_1:ShowNextGo(false)
				arg_531_1:RecordContent(arg_531_1.text_.text)
			end

			local var_534_4 = math.max(var_534_0, arg_531_1.talkMaxDuration)

			if 0 <= arg_531_1.time_ and arg_531_1.time_ < 0 + var_534_4 then
				arg_531_1.typewritter.percent = (arg_531_1.time_ - 0) / var_534_4

				arg_531_1.typewritter:SetDirty()
			end

			if arg_531_1.time_ >= 0 + var_534_4 and arg_531_1.time_ < 0 + var_534_4 + arg_534_0 then
				arg_531_1.typewritter.percent = 1

				arg_531_1.typewritter:SetDirty()
				arg_531_1:ShowNextGo(true)
			end
		end

		arg_531_1.nodeConfigList_ = {}

		arg_531_1:InitPlayNodeList()
	end,
	Play1107402116 = function(arg_535_0, arg_535_1)
		arg_535_1.time_ = 0
		arg_535_1.frameCnt_ = 0
		arg_535_1.state_ = "playing"
		arg_535_1.curTalkId_ = 1107402116
		arg_535_1.duration_ = 5

		SetActive(arg_535_1.tipsGo_, false)

		function arg_535_1.onSingleLineFinish_()
			arg_535_1.onSingleLineUpdate_ = nil
			arg_535_1.onSingleLineFinish_ = nil
			arg_535_1.state_ = "waiting"
		end

		function arg_535_1.playNext_(arg_537_0)
			if arg_537_0 == 1 then
				arg_535_0:Play1107402117(arg_535_1)
			end
		end

		function arg_535_1.onSingleLineUpdate_(arg_538_0)
			local var_538_0 = 0.6

			if 0 < arg_535_1.time_ and arg_535_1.time_ <= 0 + arg_538_0 then
				arg_535_1.talkMaxDuration = 0
				arg_535_1.dialogCg_.alpha = 1

				arg_535_1.dialog_:SetActive(true)
				SetActive(arg_535_1.leftNameGo_, false)

				arg_535_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_535_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_535_1:RecordName(arg_535_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_535_1.iconTrs_.gameObject, false)
				arg_535_1.callingController_:SetSelectedState("normal")

				local var_538_1 = arg_535_1:FormatText(arg_535_1:GetWordFromCfg(1107402116).content)

				arg_535_1.text_.text = var_538_1

				LuaForUtil.ClearLinePrefixSymbol(arg_535_1.text_)

				local var_538_3 = 24 <= 0 and var_538_0 or var_538_0 * (utf8.len(var_538_1) / 24)

				if (24 <= 0 and var_538_0 or var_538_0 * (utf8.len(var_538_1) / 24)) > 0 and var_538_0 < var_538_3 then
					arg_535_1.talkMaxDuration = var_538_3

					if var_538_3 + 0 > arg_535_1.duration_ then
						arg_535_1.duration_ = var_538_3 + 0
					end
				end

				arg_535_1.text_.text = var_538_1
				arg_535_1.typewritter.percent = 0

				arg_535_1.typewritter:SetDirty()
				arg_535_1:ShowNextGo(false)
				arg_535_1:RecordContent(arg_535_1.text_.text)
			end

			local var_538_4 = math.max(var_538_0, arg_535_1.talkMaxDuration)

			if 0 <= arg_535_1.time_ and arg_535_1.time_ < 0 + var_538_4 then
				arg_535_1.typewritter.percent = (arg_535_1.time_ - 0) / var_538_4

				arg_535_1.typewritter:SetDirty()
			end

			if arg_535_1.time_ >= 0 + var_538_4 and arg_535_1.time_ < 0 + var_538_4 + arg_538_0 then
				arg_535_1.typewritter.percent = 1

				arg_535_1.typewritter:SetDirty()
				arg_535_1:ShowNextGo(true)
			end
		end

		arg_535_1.nodeConfigList_ = {}

		arg_535_1:InitPlayNodeList()
	end,
	Play1107402117 = function(arg_539_0, arg_539_1)
		arg_539_1.time_ = 0
		arg_539_1.frameCnt_ = 0
		arg_539_1.state_ = "playing"
		arg_539_1.curTalkId_ = 1107402117
		arg_539_1.duration_ = 2.2

		SetActive(arg_539_1.tipsGo_, false)

		function arg_539_1.onSingleLineFinish_()
			arg_539_1.onSingleLineUpdate_ = nil
			arg_539_1.onSingleLineFinish_ = nil
			arg_539_1.state_ = "waiting"
		end

		function arg_539_1.playNext_(arg_541_0)
			if arg_541_0 == 1 then
				arg_539_0:Play1107402118(arg_539_1)
			end
		end

		function arg_539_1.onSingleLineUpdate_(arg_542_0)
			if 0 < arg_539_1.time_ and arg_539_1.time_ <= 0 + arg_542_0 and not isNil(arg_539_1.actors_["1074ui_story"]) and arg_539_1.var_.characterEffect1074ui_story == nil then
				arg_539_1.var_.characterEffect1074ui_story = arg_539_1.actors_["1074ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_542_0 = 0.1

			if 0 <= arg_539_1.time_ and arg_539_1.time_ < 0 + var_542_0 and not isNil(arg_539_1.actors_["1074ui_story"]) then
				if arg_539_1.var_.characterEffect1074ui_story and not isNil(arg_539_1.actors_["1074ui_story"]) then
					arg_539_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_539_1.time_ >= 0 + var_542_0 and arg_539_1.time_ < 0 + var_542_0 + arg_542_0 and not isNil(arg_539_1.actors_["1074ui_story"]) and arg_539_1.var_.characterEffect1074ui_story then
				arg_539_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			if 0 < arg_539_1.time_ and arg_539_1.time_ <= 0 + arg_542_0 then
				arg_539_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action6_2")
			end

			local var_542_2 = 0
			local var_542_3 = 0.15

			if 0 < arg_539_1.time_ and arg_539_1.time_ <= var_542_2 + arg_542_0 then
				arg_539_1.talkMaxDuration = 0
				arg_539_1.dialogCg_.alpha = 1

				arg_539_1.dialog_:SetActive(true)
				SetActive(arg_539_1.leftNameGo_, true)

				arg_539_1.leftNameTxt_.text = arg_539_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_539_1.leftNameTxt_.transform)

				arg_539_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_539_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_539_1:RecordName(arg_539_1.leftNameTxt_.text)
				SetActive(arg_539_1.iconTrs_.gameObject, false)
				arg_539_1.callingController_:SetSelectedState("normal")

				local var_542_4 = arg_539_1:GetWordFromCfg(1107402117)
				local var_542_5 = arg_539_1:FormatText(var_542_4.content)

				arg_539_1.text_.text = var_542_5

				LuaForUtil.ClearLinePrefixSymbol(arg_539_1.text_)

				local var_542_7 = 6 <= 0 and var_542_3 or var_542_3 * (utf8.len(var_542_5) / 6)

				if (6 <= 0 and var_542_3 or var_542_3 * (utf8.len(var_542_5) / 6)) > 0 and var_542_3 < var_542_7 then
					arg_539_1.talkMaxDuration = var_542_7

					if var_542_7 + var_542_2 > arg_539_1.duration_ then
						arg_539_1.duration_ = var_542_7 + var_542_2
					end
				end

				arg_539_1.text_.text = var_542_5
				arg_539_1.typewritter.percent = 0

				arg_539_1.typewritter:SetDirty()
				arg_539_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107402", "1107402117", "story_v_side_new_1107402.awb") ~= 0 then
					local var_542_8 = manager.audio:GetVoiceLength("story_v_side_new_1107402", "1107402117", "story_v_side_new_1107402.awb") / 1000

					if var_542_8 + var_542_2 > arg_539_1.duration_ then
						arg_539_1.duration_ = var_542_8 + var_542_2
					end

					if var_542_4.prefab_name ~= "" and arg_539_1.actors_[var_542_4.prefab_name] ~= nil then
						local var_542_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_539_1.actors_[var_542_4.prefab_name].transform, "story_v_side_new_1107402", "1107402117", "story_v_side_new_1107402.awb")

						arg_539_1:RecordAudio("1107402117", var_542_9)
						arg_539_1:RecordAudio("1107402117", var_542_9)
					else
						arg_539_1:AudioAction("play", "voice", "story_v_side_new_1107402", "1107402117", "story_v_side_new_1107402.awb")
					end

					arg_539_1:RecordHistoryTalkVoice("story_v_side_new_1107402", "1107402117", "story_v_side_new_1107402.awb")
				end

				arg_539_1:RecordContent(arg_539_1.text_.text)
			end

			local var_542_10 = math.max(var_542_3, arg_539_1.talkMaxDuration)

			if var_542_2 <= arg_539_1.time_ and arg_539_1.time_ < var_542_2 + var_542_10 then
				arg_539_1.typewritter.percent = (arg_539_1.time_ - var_542_2) / var_542_10

				arg_539_1.typewritter:SetDirty()
			end

			if arg_539_1.time_ >= var_542_2 + var_542_10 and arg_539_1.time_ < var_542_2 + var_542_10 + arg_542_0 then
				arg_539_1.typewritter.percent = 1

				arg_539_1.typewritter:SetDirty()
				arg_539_1:ShowNextGo(true)
			end
		end

		arg_539_1.nodeConfigList_ = {}

		arg_539_1:InitPlayNodeList()
	end,
	Play1107402118 = function(arg_543_0, arg_543_1)
		arg_543_1.time_ = 0
		arg_543_1.frameCnt_ = 0
		arg_543_1.state_ = "playing"
		arg_543_1.curTalkId_ = 1107402118
		arg_543_1.duration_ = 5

		SetActive(arg_543_1.tipsGo_, false)

		function arg_543_1.onSingleLineFinish_()
			arg_543_1.onSingleLineUpdate_ = nil
			arg_543_1.onSingleLineFinish_ = nil
			arg_543_1.state_ = "waiting"
		end

		function arg_543_1.playNext_(arg_545_0)
			if arg_545_0 == 1 then
				arg_543_0:Play1107402119(arg_543_1)
			end
		end

		function arg_543_1.onSingleLineUpdate_(arg_546_0)
			if 0 < arg_543_1.time_ and arg_543_1.time_ <= 0 + arg_546_0 and not isNil(arg_543_1.actors_["1074ui_story"]) and arg_543_1.var_.characterEffect1074ui_story == nil then
				arg_543_1.var_.characterEffect1074ui_story = arg_543_1.actors_["1074ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_546_0 = 0.1

			if 0 <= arg_543_1.time_ and arg_543_1.time_ < 0 + var_546_0 and not isNil(arg_543_1.actors_["1074ui_story"]) then
				if arg_543_1.var_.characterEffect1074ui_story and not isNil(arg_543_1.actors_["1074ui_story"]) then
					arg_543_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_543_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_543_1.time_ - 0) / var_546_0)
				end
			end

			if arg_543_1.time_ >= 0 + var_546_0 and arg_543_1.time_ < 0 + var_546_0 + arg_546_0 and not isNil(arg_543_1.actors_["1074ui_story"]) and arg_543_1.var_.characterEffect1074ui_story then
				arg_543_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_543_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			local var_546_1 = 0
			local var_546_2 = 0.875

			if 0 < arg_543_1.time_ and arg_543_1.time_ <= var_546_1 + arg_546_0 then
				arg_543_1.talkMaxDuration = 0
				arg_543_1.dialogCg_.alpha = 1

				arg_543_1.dialog_:SetActive(true)
				SetActive(arg_543_1.leftNameGo_, false)

				arg_543_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_543_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_543_1:RecordName(arg_543_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_543_1.iconTrs_.gameObject, false)
				arg_543_1.callingController_:SetSelectedState("normal")

				local var_546_3 = arg_543_1:FormatText(arg_543_1:GetWordFromCfg(1107402118).content)

				arg_543_1.text_.text = var_546_3

				LuaForUtil.ClearLinePrefixSymbol(arg_543_1.text_)

				local var_546_5 = 35 <= 0 and var_546_2 or var_546_2 * (utf8.len(var_546_3) / 35)

				if (35 <= 0 and var_546_2 or var_546_2 * (utf8.len(var_546_3) / 35)) > 0 and var_546_2 < var_546_5 then
					arg_543_1.talkMaxDuration = var_546_5

					if var_546_5 + var_546_1 > arg_543_1.duration_ then
						arg_543_1.duration_ = var_546_5 + var_546_1
					end
				end

				arg_543_1.text_.text = var_546_3
				arg_543_1.typewritter.percent = 0

				arg_543_1.typewritter:SetDirty()
				arg_543_1:ShowNextGo(false)
				arg_543_1:RecordContent(arg_543_1.text_.text)
			end

			local var_546_6 = math.max(var_546_2, arg_543_1.talkMaxDuration)

			if var_546_1 <= arg_543_1.time_ and arg_543_1.time_ < var_546_1 + var_546_6 then
				arg_543_1.typewritter.percent = (arg_543_1.time_ - var_546_1) / var_546_6

				arg_543_1.typewritter:SetDirty()
			end

			if arg_543_1.time_ >= var_546_1 + var_546_6 and arg_543_1.time_ < var_546_1 + var_546_6 + arg_546_0 then
				arg_543_1.typewritter.percent = 1

				arg_543_1.typewritter:SetDirty()
				arg_543_1:ShowNextGo(true)
			end
		end

		arg_543_1.nodeConfigList_ = {}

		arg_543_1:InitPlayNodeList()
	end,
	Play1107402119 = function(arg_547_0, arg_547_1)
		arg_547_1.time_ = 0
		arg_547_1.frameCnt_ = 0
		arg_547_1.state_ = "playing"
		arg_547_1.curTalkId_ = 1107402119
		arg_547_1.duration_ = 5

		SetActive(arg_547_1.tipsGo_, false)

		function arg_547_1.onSingleLineFinish_()
			arg_547_1.onSingleLineUpdate_ = nil
			arg_547_1.onSingleLineFinish_ = nil
			arg_547_1.state_ = "waiting"
		end

		function arg_547_1.playNext_(arg_549_0)
			if arg_549_0 == 1 then
				arg_547_0:Play1107402120(arg_547_1)
			end
		end

		function arg_547_1.onSingleLineUpdate_(arg_550_0)
			local var_550_0 = 0.725

			if 0 < arg_547_1.time_ and arg_547_1.time_ <= 0 + arg_550_0 then
				arg_547_1.talkMaxDuration = 0
				arg_547_1.dialogCg_.alpha = 1

				arg_547_1.dialog_:SetActive(true)
				SetActive(arg_547_1.leftNameGo_, false)

				arg_547_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_547_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_547_1:RecordName(arg_547_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_547_1.iconTrs_.gameObject, false)
				arg_547_1.callingController_:SetSelectedState("normal")

				local var_550_1 = arg_547_1:FormatText(arg_547_1:GetWordFromCfg(1107402119).content)

				arg_547_1.text_.text = var_550_1

				LuaForUtil.ClearLinePrefixSymbol(arg_547_1.text_)

				local var_550_3 = 29 <= 0 and var_550_0 or var_550_0 * (utf8.len(var_550_1) / 29)

				if (29 <= 0 and var_550_0 or var_550_0 * (utf8.len(var_550_1) / 29)) > 0 and var_550_0 < var_550_3 then
					arg_547_1.talkMaxDuration = var_550_3

					if var_550_3 + 0 > arg_547_1.duration_ then
						arg_547_1.duration_ = var_550_3 + 0
					end
				end

				arg_547_1.text_.text = var_550_1
				arg_547_1.typewritter.percent = 0

				arg_547_1.typewritter:SetDirty()
				arg_547_1:ShowNextGo(false)
				arg_547_1:RecordContent(arg_547_1.text_.text)
			end

			local var_550_4 = math.max(var_550_0, arg_547_1.talkMaxDuration)

			if 0 <= arg_547_1.time_ and arg_547_1.time_ < 0 + var_550_4 then
				arg_547_1.typewritter.percent = (arg_547_1.time_ - 0) / var_550_4

				arg_547_1.typewritter:SetDirty()
			end

			if arg_547_1.time_ >= 0 + var_550_4 and arg_547_1.time_ < 0 + var_550_4 + arg_550_0 then
				arg_547_1.typewritter.percent = 1

				arg_547_1.typewritter:SetDirty()
				arg_547_1:ShowNextGo(true)
			end
		end

		arg_547_1.nodeConfigList_ = {}

		arg_547_1:InitPlayNodeList()
	end,
	Play1107402061 = function(arg_551_0, arg_551_1)
		arg_551_1.time_ = 0
		arg_551_1.frameCnt_ = 0
		arg_551_1.state_ = "playing"
		arg_551_1.curTalkId_ = 1107402061
		arg_551_1.duration_ = 5

		SetActive(arg_551_1.tipsGo_, false)

		function arg_551_1.onSingleLineFinish_()
			arg_551_1.onSingleLineUpdate_ = nil
			arg_551_1.onSingleLineFinish_ = nil
			arg_551_1.state_ = "waiting"
		end

		function arg_551_1.playNext_(arg_553_0)
			if arg_553_0 == 1 then
				arg_551_0:Play1107402062(arg_551_1)
			end
		end

		function arg_551_1.onSingleLineUpdate_(arg_554_0)
			if 0 < arg_551_1.time_ and arg_551_1.time_ <= 0 + arg_554_0 then
				arg_551_1.var_.moveOldPos1074ui_story = arg_551_1.actors_["1074ui_story"].transform.localPosition

				arg_551_1:ShowWeapon(arg_551_1.var_["1074ui_story" .. "Animator"].transform, false)
			end

			local var_554_0 = 0.001

			if 0 <= arg_551_1.time_ and arg_551_1.time_ < 0 + var_554_0 then
				arg_551_1.actors_["1074ui_story"].transform.localPosition = Vector3.Lerp(arg_551_1.var_.moveOldPos1074ui_story, Vector3.New(0, 100, 0), (arg_551_1.time_ - 0) / var_554_0)
				arg_551_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_551_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_551_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_551_1.actors_["1074ui_story"].transform.position).z)
				arg_551_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_551_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_551_1.actors_["1074ui_story"].transform.localEulerAngles = arg_551_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			if arg_551_1.time_ >= 0 + var_554_0 and arg_551_1.time_ < 0 + var_554_0 + arg_554_0 then
				arg_551_1.actors_["1074ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_551_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_551_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_551_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_551_1.actors_["1074ui_story"].transform.position).z)
				arg_551_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_551_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_551_1.actors_["1074ui_story"].transform.localEulerAngles = arg_551_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			local var_554_1 = 0
			local var_554_2 = 1.175

			if 0 < arg_551_1.time_ and arg_551_1.time_ <= var_554_1 + arg_554_0 then
				arg_551_1.talkMaxDuration = 0
				arg_551_1.dialogCg_.alpha = 1

				arg_551_1.dialog_:SetActive(true)
				SetActive(arg_551_1.leftNameGo_, false)

				arg_551_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_551_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_551_1:RecordName(arg_551_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_551_1.iconTrs_.gameObject, false)
				arg_551_1.callingController_:SetSelectedState("normal")

				local var_554_3 = arg_551_1:FormatText(arg_551_1:GetWordFromCfg(1107402061).content)

				arg_551_1.text_.text = var_554_3

				LuaForUtil.ClearLinePrefixSymbol(arg_551_1.text_)

				local var_554_5 = 47 <= 0 and var_554_2 or var_554_2 * (utf8.len(var_554_3) / 47)

				if (47 <= 0 and var_554_2 or var_554_2 * (utf8.len(var_554_3) / 47)) > 0 and var_554_2 < var_554_5 then
					arg_551_1.talkMaxDuration = var_554_5

					if var_554_5 + var_554_1 > arg_551_1.duration_ then
						arg_551_1.duration_ = var_554_5 + var_554_1
					end
				end

				arg_551_1.text_.text = var_554_3
				arg_551_1.typewritter.percent = 0

				arg_551_1.typewritter:SetDirty()
				arg_551_1:ShowNextGo(false)
				arg_551_1:RecordContent(arg_551_1.text_.text)
			end

			local var_554_6 = math.max(var_554_2, arg_551_1.talkMaxDuration)

			if var_554_1 <= arg_551_1.time_ and arg_551_1.time_ < var_554_1 + var_554_6 then
				arg_551_1.typewritter.percent = (arg_551_1.time_ - var_554_1) / var_554_6

				arg_551_1.typewritter:SetDirty()
			end

			if arg_551_1.time_ >= var_554_1 + var_554_6 and arg_551_1.time_ < var_554_1 + var_554_6 + arg_554_0 then
				arg_551_1.typewritter.percent = 1

				arg_551_1.typewritter:SetDirty()
				arg_551_1:ShowNextGo(true)
			end
		end

		arg_551_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_551_1:InitPlayNodeList()
	end,
	Play1107402062 = function(arg_555_0, arg_555_1)
		arg_555_1.time_ = 0
		arg_555_1.frameCnt_ = 0
		arg_555_1.state_ = "playing"
		arg_555_1.curTalkId_ = 1107402062
		arg_555_1.duration_ = 5

		SetActive(arg_555_1.tipsGo_, false)

		function arg_555_1.onSingleLineFinish_()
			arg_555_1.onSingleLineUpdate_ = nil
			arg_555_1.onSingleLineFinish_ = nil
			arg_555_1.state_ = "waiting"
		end

		function arg_555_1.playNext_(arg_557_0)
			if arg_557_0 == 1 then
				arg_555_0:Play1107402063(arg_555_1)
			end
		end

		function arg_555_1.onSingleLineUpdate_(arg_558_0)
			local var_558_0 = 1.25

			if 0 < arg_555_1.time_ and arg_555_1.time_ <= 0 + arg_558_0 then
				arg_555_1.talkMaxDuration = 0
				arg_555_1.dialogCg_.alpha = 1

				arg_555_1.dialog_:SetActive(true)
				SetActive(arg_555_1.leftNameGo_, false)

				arg_555_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_555_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_555_1:RecordName(arg_555_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_555_1.iconTrs_.gameObject, false)
				arg_555_1.callingController_:SetSelectedState("normal")

				local var_558_1 = arg_555_1:FormatText(arg_555_1:GetWordFromCfg(1107402062).content)

				arg_555_1.text_.text = var_558_1

				LuaForUtil.ClearLinePrefixSymbol(arg_555_1.text_)

				local var_558_3 = 50 <= 0 and var_558_0 or var_558_0 * (utf8.len(var_558_1) / 50)

				if (50 <= 0 and var_558_0 or var_558_0 * (utf8.len(var_558_1) / 50)) > 0 and var_558_0 < var_558_3 then
					arg_555_1.talkMaxDuration = var_558_3

					if var_558_3 + 0 > arg_555_1.duration_ then
						arg_555_1.duration_ = var_558_3 + 0
					end
				end

				arg_555_1.text_.text = var_558_1
				arg_555_1.typewritter.percent = 0

				arg_555_1.typewritter:SetDirty()
				arg_555_1:ShowNextGo(false)
				arg_555_1:RecordContent(arg_555_1.text_.text)
			end

			local var_558_4 = math.max(var_558_0, arg_555_1.talkMaxDuration)

			if 0 <= arg_555_1.time_ and arg_555_1.time_ < 0 + var_558_4 then
				arg_555_1.typewritter.percent = (arg_555_1.time_ - 0) / var_558_4

				arg_555_1.typewritter:SetDirty()
			end

			if arg_555_1.time_ >= 0 + var_558_4 and arg_555_1.time_ < 0 + var_558_4 + arg_558_0 then
				arg_555_1.typewritter.percent = 1

				arg_555_1.typewritter:SetDirty()
				arg_555_1:ShowNextGo(true)
			end
		end

		arg_555_1.nodeConfigList_ = {}

		arg_555_1:InitPlayNodeList()
	end,
	Play1107402019 = function(arg_559_0, arg_559_1)
		arg_559_1.time_ = 0
		arg_559_1.frameCnt_ = 0
		arg_559_1.state_ = "playing"
		arg_559_1.curTalkId_ = 1107402019
		arg_559_1.duration_ = 3.03

		SetActive(arg_559_1.tipsGo_, false)

		function arg_559_1.onSingleLineFinish_()
			arg_559_1.onSingleLineUpdate_ = nil
			arg_559_1.onSingleLineFinish_ = nil
			arg_559_1.state_ = "waiting"
		end

		function arg_559_1.playNext_(arg_561_0)
			if arg_561_0 == 1 then
				arg_559_0:Play1107402020(arg_559_1)
			end
		end

		function arg_559_1.onSingleLineUpdate_(arg_562_0)
			if 0 < arg_559_1.time_ and arg_559_1.time_ <= 0 + arg_562_0 and not isNil(arg_559_1.actors_["1074ui_story"]) and arg_559_1.var_.characterEffect1074ui_story == nil then
				arg_559_1.var_.characterEffect1074ui_story = arg_559_1.actors_["1074ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_562_0 = 0.1

			if 0 <= arg_559_1.time_ and arg_559_1.time_ < 0 + var_562_0 and not isNil(arg_559_1.actors_["1074ui_story"]) then
				if arg_559_1.var_.characterEffect1074ui_story and not isNil(arg_559_1.actors_["1074ui_story"]) then
					arg_559_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_559_1.time_ >= 0 + var_562_0 and arg_559_1.time_ < 0 + var_562_0 + arg_562_0 and not isNil(arg_559_1.actors_["1074ui_story"]) and arg_559_1.var_.characterEffect1074ui_story then
				arg_559_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_562_2 = 0
			local var_562_3 = 0.4

			if 0 < arg_559_1.time_ and arg_559_1.time_ <= var_562_2 + arg_562_0 then
				arg_559_1.talkMaxDuration = 0
				arg_559_1.dialogCg_.alpha = 1

				arg_559_1.dialog_:SetActive(true)
				SetActive(arg_559_1.leftNameGo_, true)

				arg_559_1.leftNameTxt_.text = arg_559_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_559_1.leftNameTxt_.transform)

				arg_559_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_559_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_559_1:RecordName(arg_559_1.leftNameTxt_.text)
				SetActive(arg_559_1.iconTrs_.gameObject, false)
				arg_559_1.callingController_:SetSelectedState("normal")

				local var_562_4 = arg_559_1:GetWordFromCfg(1107402019)
				local var_562_5 = arg_559_1:FormatText(var_562_4.content)

				arg_559_1.text_.text = var_562_5

				LuaForUtil.ClearLinePrefixSymbol(arg_559_1.text_)

				local var_562_7 = 16 <= 0 and var_562_3 or var_562_3 * (utf8.len(var_562_5) / 16)

				if (16 <= 0 and var_562_3 or var_562_3 * (utf8.len(var_562_5) / 16)) > 0 and var_562_3 < var_562_7 then
					arg_559_1.talkMaxDuration = var_562_7

					if var_562_7 + var_562_2 > arg_559_1.duration_ then
						arg_559_1.duration_ = var_562_7 + var_562_2
					end
				end

				arg_559_1.text_.text = var_562_5
				arg_559_1.typewritter.percent = 0

				arg_559_1.typewritter:SetDirty()
				arg_559_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107402", "1107402019", "story_v_side_new_1107402.awb") ~= 0 then
					local var_562_8 = manager.audio:GetVoiceLength("story_v_side_new_1107402", "1107402019", "story_v_side_new_1107402.awb") / 1000

					if var_562_8 + var_562_2 > arg_559_1.duration_ then
						arg_559_1.duration_ = var_562_8 + var_562_2
					end

					if var_562_4.prefab_name ~= "" and arg_559_1.actors_[var_562_4.prefab_name] ~= nil then
						local var_562_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_559_1.actors_[var_562_4.prefab_name].transform, "story_v_side_new_1107402", "1107402019", "story_v_side_new_1107402.awb")

						arg_559_1:RecordAudio("1107402019", var_562_9)
						arg_559_1:RecordAudio("1107402019", var_562_9)
					else
						arg_559_1:AudioAction("play", "voice", "story_v_side_new_1107402", "1107402019", "story_v_side_new_1107402.awb")
					end

					arg_559_1:RecordHistoryTalkVoice("story_v_side_new_1107402", "1107402019", "story_v_side_new_1107402.awb")
				end

				arg_559_1:RecordContent(arg_559_1.text_.text)
			end

			local var_562_10 = math.max(var_562_3, arg_559_1.talkMaxDuration)

			if var_562_2 <= arg_559_1.time_ and arg_559_1.time_ < var_562_2 + var_562_10 then
				arg_559_1.typewritter.percent = (arg_559_1.time_ - var_562_2) / var_562_10

				arg_559_1.typewritter:SetDirty()
			end

			if arg_559_1.time_ >= var_562_2 + var_562_10 and arg_559_1.time_ < var_562_2 + var_562_10 + arg_562_0 then
				arg_559_1.typewritter.percent = 1

				arg_559_1.typewritter:SetDirty()
				arg_559_1:ShowNextGo(true)
			end
		end

		arg_559_1.nodeConfigList_ = {}

		arg_559_1:InitPlayNodeList()
	end,
	Play1107402020 = function(arg_563_0, arg_563_1)
		arg_563_1.time_ = 0
		arg_563_1.frameCnt_ = 0
		arg_563_1.state_ = "playing"
		arg_563_1.curTalkId_ = 1107402020
		arg_563_1.duration_ = 4.1

		SetActive(arg_563_1.tipsGo_, false)

		function arg_563_1.onSingleLineFinish_()
			arg_563_1.onSingleLineUpdate_ = nil
			arg_563_1.onSingleLineFinish_ = nil
			arg_563_1.state_ = "waiting"
		end

		function arg_563_1.playNext_(arg_565_0)
			if arg_565_0 == 1 then
				arg_563_0:Play1107402021(arg_563_1)
			end
		end

		function arg_563_1.onSingleLineUpdate_(arg_566_0)
			if 0 < arg_563_1.time_ and arg_563_1.time_ <= 0 + arg_566_0 then
				arg_563_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action3_2")
			end

			local var_566_0 = 0
			local var_566_1 = 0.2

			if 0 < arg_563_1.time_ and arg_563_1.time_ <= var_566_0 + arg_566_0 then
				arg_563_1.talkMaxDuration = 0
				arg_563_1.dialogCg_.alpha = 1

				arg_563_1.dialog_:SetActive(true)
				SetActive(arg_563_1.leftNameGo_, true)

				arg_563_1.leftNameTxt_.text = arg_563_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_563_1.leftNameTxt_.transform)

				arg_563_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_563_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_563_1:RecordName(arg_563_1.leftNameTxt_.text)
				SetActive(arg_563_1.iconTrs_.gameObject, false)
				arg_563_1.callingController_:SetSelectedState("normal")

				local var_566_2 = arg_563_1:GetWordFromCfg(1107402020)
				local var_566_3 = arg_563_1:FormatText(var_566_2.content)

				arg_563_1.text_.text = var_566_3

				LuaForUtil.ClearLinePrefixSymbol(arg_563_1.text_)

				local var_566_5 = 8 <= 0 and var_566_1 or var_566_1 * (utf8.len(var_566_3) / 8)

				if (8 <= 0 and var_566_1 or var_566_1 * (utf8.len(var_566_3) / 8)) > 0 and var_566_1 < var_566_5 then
					arg_563_1.talkMaxDuration = var_566_5

					if var_566_5 + var_566_0 > arg_563_1.duration_ then
						arg_563_1.duration_ = var_566_5 + var_566_0
					end
				end

				arg_563_1.text_.text = var_566_3
				arg_563_1.typewritter.percent = 0

				arg_563_1.typewritter:SetDirty()
				arg_563_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107402", "1107402020", "story_v_side_new_1107402.awb") ~= 0 then
					local var_566_6 = manager.audio:GetVoiceLength("story_v_side_new_1107402", "1107402020", "story_v_side_new_1107402.awb") / 1000

					if var_566_6 + var_566_0 > arg_563_1.duration_ then
						arg_563_1.duration_ = var_566_6 + var_566_0
					end

					if var_566_2.prefab_name ~= "" and arg_563_1.actors_[var_566_2.prefab_name] ~= nil then
						local var_566_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_563_1.actors_[var_566_2.prefab_name].transform, "story_v_side_new_1107402", "1107402020", "story_v_side_new_1107402.awb")

						arg_563_1:RecordAudio("1107402020", var_566_7)
						arg_563_1:RecordAudio("1107402020", var_566_7)
					else
						arg_563_1:AudioAction("play", "voice", "story_v_side_new_1107402", "1107402020", "story_v_side_new_1107402.awb")
					end

					arg_563_1:RecordHistoryTalkVoice("story_v_side_new_1107402", "1107402020", "story_v_side_new_1107402.awb")
				end

				arg_563_1:RecordContent(arg_563_1.text_.text)
			end

			local var_566_8 = math.max(var_566_1, arg_563_1.talkMaxDuration)

			if var_566_0 <= arg_563_1.time_ and arg_563_1.time_ < var_566_0 + var_566_8 then
				arg_563_1.typewritter.percent = (arg_563_1.time_ - var_566_0) / var_566_8

				arg_563_1.typewritter:SetDirty()
			end

			if arg_563_1.time_ >= var_566_0 + var_566_8 and arg_563_1.time_ < var_566_0 + var_566_8 + arg_566_0 then
				arg_563_1.typewritter.percent = 1

				arg_563_1.typewritter:SetDirty()
				arg_563_1:ShowNextGo(true)
			end
		end

		arg_563_1.nodeConfigList_ = {}

		arg_563_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST31",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/ST45"
	},
	voices = {
		"story_v_side_new_1107402.awb"
	}
}
