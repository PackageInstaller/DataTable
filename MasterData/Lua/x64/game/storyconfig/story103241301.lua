return {
	Play324131001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 324131001
		arg_1_1.duration_ = 4.17

		local var_1_0 = {
			zh = 3.7,
			ja = 4.166
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
				arg_1_0:Play324131002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST2003 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST2003")
				var_4_0.name = "ST2003"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST2003 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST2003

				arg_1_1.bgs_.ST2003.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST2003" then
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

			local var_4_9 = "1070ui_story"

			if arg_1_1.actors_["1070ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1070ui_story"))) then
				local var_4_10 = Object.Instantiate(Asset.Load("Char/" .. "1070ui_story"), arg_1_1.stage_.transform)

				var_4_10.name = var_4_9
				var_4_10.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.actors_[var_4_9] = var_4_10

				local var_4_11 = var_4_10:GetComponentInChildren(typeof(CharacterEffect))

				var_4_11.enabled = true

				local var_4_12 = GameObjectTools.GetOrAddComponent(var_4_10, typeof(DynamicBoneHelper))

				if var_4_12 then
					var_4_12:EnableDynamicBone(false)
				end

				arg_1_1:ShowWeapon(var_4_11.transform, false)

				arg_1_1.var_[var_4_9 .. "Animator"] = var_4_11.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_1_1.var_[var_4_9 .. "Animator"].applyRootMotion = true
				arg_1_1.var_[var_4_9 .. "LipSync"] = var_4_11.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_4_13 = arg_1_1.actors_["1070ui_story"]

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 and not isNil(var_4_13) and arg_1_1.var_.characterEffect1070ui_story == nil then
				arg_1_1.var_.characterEffect1070ui_story = var_4_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_14 = 0.200000002980232

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_14 and not isNil(var_4_13) then
				if arg_1_1.var_.characterEffect1070ui_story and not isNil(var_4_13) then
					arg_1_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 0 + var_4_14 and arg_1_1.time_ < 0 + var_4_14 + arg_4_0 and not isNil(var_4_13) and arg_1_1.var_.characterEffect1070ui_story then
				arg_1_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0.1 < arg_1_1.time_ and arg_1_1.time_ <= 0.1 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_side_1049", "se_story_side_1049_amb_room", "")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "ui_battle", "ui_battle_stopbgm", "")
			end

			if 1 < arg_1_1.time_ and arg_1_1.time_ <= 1 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_4_8_story_ruomugong", "bgm_activity_4_8_story_ruomugong", "bgm_activity_4_8_story_ruomugong.awb")

				local var_4_20 = manager.audio:GetAudioName("bgm_activity_4_8_story_ruomugong", "bgm_activity_4_8_story_ruomugong")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_20 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_20

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_20
						arg_1_1.bgmTxt2_.text = var_4_20
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

			local var_4_21 = 1.7
			local var_4_22 = 0.15

			if 1.7 < arg_1_1.time_ and arg_1_1.time_ <= var_4_21 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_23 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_23:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1070_split_7")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_24 = arg_1_1:GetWordFromCfg(324131001)
				local var_4_25 = arg_1_1:FormatText(var_4_24.content)

				arg_1_1.text_.text = var_4_25

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_27 = 6 <= 0 and var_4_22 or var_4_22 * (utf8.len(var_4_25) / 6)

				if (6 <= 0 and var_4_22 or var_4_22 * (utf8.len(var_4_25) / 6)) > 0 and var_4_22 < var_4_27 then
					arg_1_1.talkMaxDuration = var_4_27
					var_4_21 = var_4_21 + 0.3

					if var_4_27 + var_4_21 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_27 + var_4_21
					end
				end

				arg_1_1.text_.text = var_4_25
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324131", "324131001", "story_v_out_324131.awb") ~= 0 then
					local var_4_28 = manager.audio:GetVoiceLength("story_v_out_324131", "324131001", "story_v_out_324131.awb") / 1000

					if var_4_28 + var_4_21 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_28 + var_4_21
					end

					if var_4_24.prefab_name ~= "" and arg_1_1.actors_[var_4_24.prefab_name] ~= nil then
						local var_4_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_24.prefab_name].transform, "story_v_out_324131", "324131001", "story_v_out_324131.awb")

						arg_1_1:RecordAudio("324131001", var_4_29)
						arg_1_1:RecordAudio("324131001", var_4_29)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_324131", "324131001", "story_v_out_324131.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_324131", "324131001", "story_v_out_324131.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_30 = var_4_21 + 0.3
			local var_4_31 = math.max(var_4_22, arg_1_1.talkMaxDuration)

			if var_4_21 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_30 + var_4_31 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_30) / var_4_31

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_30 + var_4_31 and arg_1_1.time_ < var_4_30 + var_4_31 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play324131002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 324131002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play324131003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 and not isNil(arg_8_1.actors_["1070ui_story"]) and arg_8_1.var_.characterEffect1070ui_story == nil then
				arg_8_1.var_.characterEffect1070ui_story = arg_8_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_0 = 0.200000002980232

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_0 and not isNil(arg_8_1.actors_["1070ui_story"]) then
				if arg_8_1.var_.characterEffect1070ui_story and not isNil(arg_8_1.actors_["1070ui_story"]) then
					arg_8_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_8_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_8_1.time_ - 0) / var_11_0)
				end
			end

			if arg_8_1.time_ >= 0 + var_11_0 and arg_8_1.time_ < 0 + var_11_0 + arg_11_0 and not isNil(arg_8_1.actors_["1070ui_story"]) and arg_8_1.var_.characterEffect1070ui_story then
				arg_8_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_8_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_11_1 = 0
			local var_11_2 = 1.1

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_1 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, false)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_3 = arg_8_1:FormatText(arg_8_1:GetWordFromCfg(324131002).content)

				arg_8_1.text_.text = var_11_3

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_5 = 44 <= 0 and var_11_2 or var_11_2 * (utf8.len(var_11_3) / 44)

				if (44 <= 0 and var_11_2 or var_11_2 * (utf8.len(var_11_3) / 44)) > 0 and var_11_2 < var_11_5 then
					arg_8_1.talkMaxDuration = var_11_5

					if var_11_5 + var_11_1 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_5 + var_11_1
					end
				end

				arg_8_1.text_.text = var_11_3
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)
				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_6 = math.max(var_11_2, arg_8_1.talkMaxDuration)

			if var_11_1 <= arg_8_1.time_ and arg_8_1.time_ < var_11_1 + var_11_6 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_1) / var_11_6

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_1 + var_11_6 and arg_8_1.time_ < var_11_1 + var_11_6 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play324131003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 324131003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play324131004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			if 0.7 < arg_12_1.time_ and arg_12_1.time_ <= 0.7 + arg_15_0 then
				arg_12_1:AudioAction("play", "effect", "se_story_side_1039", "se_story_1039_run", "")
			end

			local var_15_1 = 0
			local var_15_2 = 1.5

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_1 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, false)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_3 = arg_12_1:FormatText(arg_12_1:GetWordFromCfg(324131003).content)

				arg_12_1.text_.text = var_15_3

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_5 = 60 <= 0 and var_15_2 or var_15_2 * (utf8.len(var_15_3) / 60)

				if (60 <= 0 and var_15_2 or var_15_2 * (utf8.len(var_15_3) / 60)) > 0 and var_15_2 < var_15_5 then
					arg_12_1.talkMaxDuration = var_15_5

					if var_15_5 + var_15_1 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_5 + var_15_1
					end
				end

				arg_12_1.text_.text = var_15_3
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)
				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_6 = math.max(var_15_2, arg_12_1.talkMaxDuration)

			if var_15_1 <= arg_12_1.time_ and arg_12_1.time_ < var_15_1 + var_15_6 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_1) / var_15_6

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_1 + var_15_6 and arg_12_1.time_ < var_15_1 + var_15_6 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play324131004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 324131004
		arg_16_1.duration_ = 4.13

		local var_16_0 = {
			zh = 3.666,
			ja = 4.133
		}
		local var_16_1 = manager.audio:GetLocalizationFlag()

		if var_16_0[var_16_1] ~= nil then
			arg_16_1.duration_ = var_16_0[var_16_1]
		end

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play324131005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.var_.moveOldPos1070ui_story = arg_16_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_19_0 = 0.001

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_0 then
				arg_16_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos1070ui_story, Vector3.New(-0.7, -0.95, -6.05), (arg_16_1.time_ - 0) / var_19_0)
				arg_16_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_16_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_16_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_16_1.actors_["1070ui_story"].transform.position).z)
				arg_16_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_16_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_16_1.actors_["1070ui_story"].transform.localEulerAngles = arg_16_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_16_1.time_ >= 0 + var_19_0 and arg_16_1.time_ < 0 + var_19_0 + arg_19_0 then
				arg_16_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(-0.7, -0.95, -6.05)
				arg_16_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_16_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_16_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_16_1.actors_["1070ui_story"].transform.position).z)
				arg_16_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_16_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_16_1.actors_["1070ui_story"].transform.localEulerAngles = arg_16_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_19_1 = arg_16_1.actors_["1070ui_story"]

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 and not isNil(var_19_1) and arg_16_1.var_.characterEffect1070ui_story == nil then
				arg_16_1.var_.characterEffect1070ui_story = var_19_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_2 = 0.200000002980232

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_2 and not isNil(var_19_1) then
				if arg_16_1.var_.characterEffect1070ui_story and not isNil(var_19_1) then
					arg_16_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_16_1.time_ >= 0 + var_19_2 and arg_16_1.time_ < 0 + var_19_2 + arg_19_0 and not isNil(var_19_1) and arg_16_1.var_.characterEffect1070ui_story then
				arg_16_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action1_1")
			end

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_19_4 = 0
			local var_19_5 = 0.25

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_4 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				arg_16_1.leftNameTxt_.text = arg_16_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_6 = arg_16_1:GetWordFromCfg(324131004)
				local var_19_7 = arg_16_1:FormatText(var_19_6.content)

				arg_16_1.text_.text = var_19_7

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_9 = 10 <= 0 and var_19_5 or var_19_5 * (utf8.len(var_19_7) / 10)

				if (10 <= 0 and var_19_5 or var_19_5 * (utf8.len(var_19_7) / 10)) > 0 and var_19_5 < var_19_9 then
					arg_16_1.talkMaxDuration = var_19_9

					if var_19_9 + var_19_4 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_9 + var_19_4
					end
				end

				arg_16_1.text_.text = var_19_7
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324131", "324131004", "story_v_out_324131.awb") ~= 0 then
					local var_19_10 = manager.audio:GetVoiceLength("story_v_out_324131", "324131004", "story_v_out_324131.awb") / 1000

					if var_19_10 + var_19_4 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_10 + var_19_4
					end

					if var_19_6.prefab_name ~= "" and arg_16_1.actors_[var_19_6.prefab_name] ~= nil then
						local var_19_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_6.prefab_name].transform, "story_v_out_324131", "324131004", "story_v_out_324131.awb")

						arg_16_1:RecordAudio("324131004", var_19_11)
						arg_16_1:RecordAudio("324131004", var_19_11)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_324131", "324131004", "story_v_out_324131.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_324131", "324131004", "story_v_out_324131.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_12 = math.max(var_19_5, arg_16_1.talkMaxDuration)

			if var_19_4 <= arg_16_1.time_ and arg_16_1.time_ < var_19_4 + var_19_12 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_4) / var_19_12

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_4 + var_19_12 and arg_16_1.time_ < var_19_4 + var_19_12 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_16_1:InitPlayNodeList()
	end,
	Play324131005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 324131005
		arg_20_1.duration_ = 2.77

		local var_20_0 = {
			zh = 1.999999999999,
			ja = 2.766
		}
		local var_20_1 = manager.audio:GetLocalizationFlag()

		if var_20_0[var_20_1] ~= nil then
			arg_20_1.duration_ = var_20_0[var_20_1]
		end

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play324131006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			if arg_20_1.actors_["1053ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1053ui_story"))) then
				local var_23_0 = Object.Instantiate(Asset.Load("Char/" .. "1053ui_story"), arg_20_1.stage_.transform)

				var_23_0.name = "1053ui_story"
				var_23_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_20_1.actors_["1053ui_story"] = var_23_0

				local var_23_1 = var_23_0:GetComponentInChildren(typeof(CharacterEffect))

				var_23_1.enabled = true

				local var_23_2 = GameObjectTools.GetOrAddComponent(var_23_0, typeof(DynamicBoneHelper))

				if var_23_2 then
					var_23_2:EnableDynamicBone(false)
				end

				arg_20_1:ShowWeapon(var_23_1.transform, false)

				arg_20_1.var_["1053ui_story" .. "Animator"] = var_23_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_20_1.var_["1053ui_story" .. "Animator"].applyRootMotion = true
				arg_20_1.var_["1053ui_story" .. "LipSync"] = var_23_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_23_3 = arg_20_1.actors_["1053ui_story"].transform

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1.var_.moveOldPos1053ui_story = var_23_3.localPosition

				local var_23_4 = GameObjectTools.GetOrAddComponent(var_23_3.gameObject, typeof(DynamicBoneHelper))

				if var_23_4 then
					var_23_4:EnableDynamicBone(false)
				end
			end

			local var_23_5 = 0.001

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_5 then
				var_23_3.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos1053ui_story, Vector3.New(0.7, -1.08, -6), (arg_20_1.time_ - 0) / var_23_5)
				var_23_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_23_3.position).x, (manager.ui.mainCamera.transform.position - var_23_3.position).y, (manager.ui.mainCamera.transform.position - var_23_3.position).z)
				var_23_3.localEulerAngles.z = 0
				var_23_3.localEulerAngles.x = 0
				var_23_3.localEulerAngles = var_23_3.localEulerAngles
			end

			if arg_20_1.time_ >= 0 + var_23_5 and arg_20_1.time_ < 0 + var_23_5 + arg_23_0 then
				var_23_3.localPosition = Vector3.New(0.7, -1.08, -6)
				var_23_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_23_3.position).x, (manager.ui.mainCamera.transform.position - var_23_3.position).y, (manager.ui.mainCamera.transform.position - var_23_3.position).z)
				var_23_3.localEulerAngles.z = 0
				var_23_3.localEulerAngles.x = 0
				var_23_3.localEulerAngles = var_23_3.localEulerAngles

				local var_23_6 = GameObjectTools.GetOrAddComponent(var_23_3.gameObject, typeof(DynamicBoneHelper))

				if var_23_6 then
					var_23_6:EnableDynamicBone(true)
				end
			end

			local var_23_7 = arg_20_1.actors_["1053ui_story"]

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 and not isNil(var_23_7) and arg_20_1.var_.characterEffect1053ui_story == nil then
				arg_20_1.var_.characterEffect1053ui_story = var_23_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_8 = 0.200000002980232

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_8 and not isNil(var_23_7) then
				if arg_20_1.var_.characterEffect1053ui_story and not isNil(var_23_7) then
					arg_20_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_20_1.time_ >= 0 + var_23_8 and arg_20_1.time_ < 0 + var_23_8 + arg_23_0 and not isNil(var_23_7) and arg_20_1.var_.characterEffect1053ui_story then
				arg_20_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_23_10 = arg_20_1.actors_["1070ui_story"]

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 and not isNil(var_23_10) and arg_20_1.var_.characterEffect1070ui_story == nil then
				arg_20_1.var_.characterEffect1070ui_story = var_23_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_11 = 0.200000002980232

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_11 and not isNil(var_23_10) then
				if arg_20_1.var_.characterEffect1070ui_story and not isNil(var_23_10) then
					arg_20_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_20_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_20_1.time_ - 0) / var_23_11)
				end
			end

			if arg_20_1.time_ >= 0 + var_23_11 and arg_20_1.time_ < 0 + var_23_11 + arg_23_0 and not isNil(var_23_10) and arg_20_1.var_.characterEffect1070ui_story then
				arg_20_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_20_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053action/1053action3_1")
			end

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_23_12 = 0
			local var_23_13 = 0.175

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_12 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				arg_20_1.leftNameTxt_.text = arg_20_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_14 = arg_20_1:GetWordFromCfg(324131005)
				local var_23_15 = arg_20_1:FormatText(var_23_14.content)

				arg_20_1.text_.text = var_23_15

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_17 = 7 <= 0 and var_23_13 or var_23_13 * (utf8.len(var_23_15) / 7)

				if (7 <= 0 and var_23_13 or var_23_13 * (utf8.len(var_23_15) / 7)) > 0 and var_23_13 < var_23_17 then
					arg_20_1.talkMaxDuration = var_23_17

					if var_23_17 + var_23_12 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_17 + var_23_12
					end
				end

				arg_20_1.text_.text = var_23_15
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324131", "324131005", "story_v_out_324131.awb") ~= 0 then
					local var_23_18 = manager.audio:GetVoiceLength("story_v_out_324131", "324131005", "story_v_out_324131.awb") / 1000

					if var_23_18 + var_23_12 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_18 + var_23_12
					end

					if var_23_14.prefab_name ~= "" and arg_20_1.actors_[var_23_14.prefab_name] ~= nil then
						local var_23_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_14.prefab_name].transform, "story_v_out_324131", "324131005", "story_v_out_324131.awb")

						arg_20_1:RecordAudio("324131005", var_23_19)
						arg_20_1:RecordAudio("324131005", var_23_19)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_324131", "324131005", "story_v_out_324131.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_324131", "324131005", "story_v_out_324131.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_20 = math.max(var_23_13, arg_20_1.talkMaxDuration)

			if var_23_12 <= arg_20_1.time_ and arg_20_1.time_ < var_23_12 + var_23_20 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_12) / var_23_20

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_12 + var_23_20 and arg_20_1.time_ < var_23_12 + var_23_20 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1053ui_story",
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
	Play324131006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 324131006
		arg_24_1.duration_ = 5.57

		local var_24_0 = {
			zh = 4.633,
			ja = 5.566
		}
		local var_24_1 = manager.audio:GetLocalizationFlag()

		if var_24_0[var_24_1] ~= nil then
			arg_24_1.duration_ = var_24_0[var_24_1]
		end

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play324131007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 and not isNil(arg_24_1.actors_["1070ui_story"]) and arg_24_1.var_.characterEffect1070ui_story == nil then
				arg_24_1.var_.characterEffect1070ui_story = arg_24_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_0 = 0.200000002980232

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_0 and not isNil(arg_24_1.actors_["1070ui_story"]) then
				if arg_24_1.var_.characterEffect1070ui_story and not isNil(arg_24_1.actors_["1070ui_story"]) then
					arg_24_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_24_1.time_ >= 0 + var_27_0 and arg_24_1.time_ < 0 + var_27_0 + arg_27_0 and not isNil(arg_24_1.actors_["1070ui_story"]) and arg_24_1.var_.characterEffect1070ui_story then
				arg_24_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_27_2 = arg_24_1.actors_["1053ui_story"]

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 and not isNil(var_27_2) and arg_24_1.var_.characterEffect1053ui_story == nil then
				arg_24_1.var_.characterEffect1053ui_story = var_27_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_3 = 0.200000002980232

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_3 and not isNil(var_27_2) then
				if arg_24_1.var_.characterEffect1053ui_story and not isNil(var_27_2) then
					arg_24_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_24_1.var_.characterEffect1053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_24_1.time_ - 0) / var_27_3)
				end
			end

			if arg_24_1.time_ >= 0 + var_27_3 and arg_24_1.time_ < 0 + var_27_3 + arg_27_0 and not isNil(var_27_2) and arg_24_1.var_.characterEffect1053ui_story then
				arg_24_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_24_1.var_.characterEffect1053ui_story.fillRatio = 0.5
			end

			local var_27_4 = 0
			local var_27_5 = 0.35

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_4 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				arg_24_1.leftNameTxt_.text = arg_24_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_6 = arg_24_1:GetWordFromCfg(324131006)
				local var_27_7 = arg_24_1:FormatText(var_27_6.content)

				arg_24_1.text_.text = var_27_7

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_9 = 14 <= 0 and var_27_5 or var_27_5 * (utf8.len(var_27_7) / 14)

				if (14 <= 0 and var_27_5 or var_27_5 * (utf8.len(var_27_7) / 14)) > 0 and var_27_5 < var_27_9 then
					arg_24_1.talkMaxDuration = var_27_9

					if var_27_9 + var_27_4 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_9 + var_27_4
					end
				end

				arg_24_1.text_.text = var_27_7
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324131", "324131006", "story_v_out_324131.awb") ~= 0 then
					local var_27_10 = manager.audio:GetVoiceLength("story_v_out_324131", "324131006", "story_v_out_324131.awb") / 1000

					if var_27_10 + var_27_4 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_10 + var_27_4
					end

					if var_27_6.prefab_name ~= "" and arg_24_1.actors_[var_27_6.prefab_name] ~= nil then
						local var_27_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_6.prefab_name].transform, "story_v_out_324131", "324131006", "story_v_out_324131.awb")

						arg_24_1:RecordAudio("324131006", var_27_11)
						arg_24_1:RecordAudio("324131006", var_27_11)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_324131", "324131006", "story_v_out_324131.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_324131", "324131006", "story_v_out_324131.awb")
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
	Play324131007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 324131007
		arg_28_1.duration_ = 12.97

		local var_28_0 = {
			zh = 9.033,
			ja = 12.966
		}
		local var_28_1 = manager.audio:GetLocalizationFlag()

		if var_28_0[var_28_1] ~= nil then
			arg_28_1.duration_ = var_28_0[var_28_1]
		end

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play324131008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 and not isNil(arg_28_1.actors_["1053ui_story"]) and arg_28_1.var_.characterEffect1053ui_story == nil then
				arg_28_1.var_.characterEffect1053ui_story = arg_28_1.actors_["1053ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_0 = 0.200000002980232

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_0 and not isNil(arg_28_1.actors_["1053ui_story"]) then
				if arg_28_1.var_.characterEffect1053ui_story and not isNil(arg_28_1.actors_["1053ui_story"]) then
					arg_28_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_28_1.time_ >= 0 + var_31_0 and arg_28_1.time_ < 0 + var_31_0 + arg_31_0 and not isNil(arg_28_1.actors_["1053ui_story"]) and arg_28_1.var_.characterEffect1053ui_story then
				arg_28_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_31_2 = arg_28_1.actors_["1070ui_story"]

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 and not isNil(var_31_2) and arg_28_1.var_.characterEffect1070ui_story == nil then
				arg_28_1.var_.characterEffect1070ui_story = var_31_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_3 = 0.200000002980232

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_3 and not isNil(var_31_2) then
				if arg_28_1.var_.characterEffect1070ui_story and not isNil(var_31_2) then
					arg_28_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_28_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_28_1.time_ - 0) / var_31_3)
				end
			end

			if arg_28_1.time_ >= 0 + var_31_3 and arg_28_1.time_ < 0 + var_31_3 + arg_31_0 and not isNil(var_31_2) and arg_28_1.var_.characterEffect1070ui_story then
				arg_28_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_28_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_31_4 = 0
			local var_31_5 = 1

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_4 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				arg_28_1.leftNameTxt_.text = arg_28_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_6 = arg_28_1:GetWordFromCfg(324131007)
				local var_31_7 = arg_28_1:FormatText(var_31_6.content)

				arg_28_1.text_.text = var_31_7

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_9 = 40 <= 0 and var_31_5 or var_31_5 * (utf8.len(var_31_7) / 40)

				if (40 <= 0 and var_31_5 or var_31_5 * (utf8.len(var_31_7) / 40)) > 0 and var_31_5 < var_31_9 then
					arg_28_1.talkMaxDuration = var_31_9

					if var_31_9 + var_31_4 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_9 + var_31_4
					end
				end

				arg_28_1.text_.text = var_31_7
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324131", "324131007", "story_v_out_324131.awb") ~= 0 then
					local var_31_10 = manager.audio:GetVoiceLength("story_v_out_324131", "324131007", "story_v_out_324131.awb") / 1000

					if var_31_10 + var_31_4 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_10 + var_31_4
					end

					if var_31_6.prefab_name ~= "" and arg_28_1.actors_[var_31_6.prefab_name] ~= nil then
						local var_31_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_6.prefab_name].transform, "story_v_out_324131", "324131007", "story_v_out_324131.awb")

						arg_28_1:RecordAudio("324131007", var_31_11)
						arg_28_1:RecordAudio("324131007", var_31_11)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_324131", "324131007", "story_v_out_324131.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_324131", "324131007", "story_v_out_324131.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_12 = math.max(var_31_5, arg_28_1.talkMaxDuration)

			if var_31_4 <= arg_28_1.time_ and arg_28_1.time_ < var_31_4 + var_31_12 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_4) / var_31_12

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_4 + var_31_12 and arg_28_1.time_ < var_31_4 + var_31_12 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play324131008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 324131008
		arg_32_1.duration_ = 4.1

		local var_32_0 = {
			zh = 4.1,
			ja = 3.733
		}
		local var_32_1 = manager.audio:GetLocalizationFlag()

		if var_32_0[var_32_1] ~= nil then
			arg_32_1.duration_ = var_32_0[var_32_1]
		end

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play324131009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 and not isNil(arg_32_1.actors_["1070ui_story"]) and arg_32_1.var_.characterEffect1070ui_story == nil then
				arg_32_1.var_.characterEffect1070ui_story = arg_32_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_0 = 0.200000002980232

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_0 and not isNil(arg_32_1.actors_["1070ui_story"]) then
				if arg_32_1.var_.characterEffect1070ui_story and not isNil(arg_32_1.actors_["1070ui_story"]) then
					arg_32_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_32_1.time_ >= 0 + var_35_0 and arg_32_1.time_ < 0 + var_35_0 + arg_35_0 and not isNil(arg_32_1.actors_["1070ui_story"]) and arg_32_1.var_.characterEffect1070ui_story then
				arg_32_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_35_2 = arg_32_1.actors_["1053ui_story"]

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 and not isNil(var_35_2) and arg_32_1.var_.characterEffect1053ui_story == nil then
				arg_32_1.var_.characterEffect1053ui_story = var_35_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_3 = 0.200000002980232

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_3 and not isNil(var_35_2) then
				if arg_32_1.var_.characterEffect1053ui_story and not isNil(var_35_2) then
					arg_32_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_32_1.var_.characterEffect1053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_32_1.time_ - 0) / var_35_3)
				end
			end

			if arg_32_1.time_ >= 0 + var_35_3 and arg_32_1.time_ < 0 + var_35_3 + arg_35_0 and not isNil(var_35_2) and arg_32_1.var_.characterEffect1053ui_story then
				arg_32_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_32_1.var_.characterEffect1053ui_story.fillRatio = 0.5
			end

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action4_1")
			end

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_35_4 = 0
			local var_35_5 = 0.325

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_4 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				arg_32_1.leftNameTxt_.text = arg_32_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_6 = arg_32_1:GetWordFromCfg(324131008)
				local var_35_7 = arg_32_1:FormatText(var_35_6.content)

				arg_32_1.text_.text = var_35_7

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_9 = 13 <= 0 and var_35_5 or var_35_5 * (utf8.len(var_35_7) / 13)

				if (13 <= 0 and var_35_5 or var_35_5 * (utf8.len(var_35_7) / 13)) > 0 and var_35_5 < var_35_9 then
					arg_32_1.talkMaxDuration = var_35_9

					if var_35_9 + var_35_4 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_9 + var_35_4
					end
				end

				arg_32_1.text_.text = var_35_7
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324131", "324131008", "story_v_out_324131.awb") ~= 0 then
					local var_35_10 = manager.audio:GetVoiceLength("story_v_out_324131", "324131008", "story_v_out_324131.awb") / 1000

					if var_35_10 + var_35_4 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_10 + var_35_4
					end

					if var_35_6.prefab_name ~= "" and arg_32_1.actors_[var_35_6.prefab_name] ~= nil then
						local var_35_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_6.prefab_name].transform, "story_v_out_324131", "324131008", "story_v_out_324131.awb")

						arg_32_1:RecordAudio("324131008", var_35_11)
						arg_32_1:RecordAudio("324131008", var_35_11)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_324131", "324131008", "story_v_out_324131.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_324131", "324131008", "story_v_out_324131.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_12 = math.max(var_35_5, arg_32_1.talkMaxDuration)

			if var_35_4 <= arg_32_1.time_ and arg_32_1.time_ < var_35_4 + var_35_12 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_4) / var_35_12

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_4 + var_35_12 and arg_32_1.time_ < var_35_4 + var_35_12 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play324131009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 324131009
		arg_36_1.duration_ = 8.5

		local var_36_0 = {
			zh = 4.8,
			ja = 8.5
		}
		local var_36_1 = manager.audio:GetLocalizationFlag()

		if var_36_0[var_36_1] ~= nil then
			arg_36_1.duration_ = var_36_0[var_36_1]
		end

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play324131010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 and not isNil(arg_36_1.actors_["1053ui_story"]) and arg_36_1.var_.characterEffect1053ui_story == nil then
				arg_36_1.var_.characterEffect1053ui_story = arg_36_1.actors_["1053ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_0 = 0.200000002980232

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_0 and not isNil(arg_36_1.actors_["1053ui_story"]) then
				if arg_36_1.var_.characterEffect1053ui_story and not isNil(arg_36_1.actors_["1053ui_story"]) then
					arg_36_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_36_1.time_ >= 0 + var_39_0 and arg_36_1.time_ < 0 + var_39_0 + arg_39_0 and not isNil(arg_36_1.actors_["1053ui_story"]) and arg_36_1.var_.characterEffect1053ui_story then
				arg_36_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_39_2 = arg_36_1.actors_["1070ui_story"]

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 and not isNil(var_39_2) and arg_36_1.var_.characterEffect1070ui_story == nil then
				arg_36_1.var_.characterEffect1070ui_story = var_39_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_3 = 0.200000002980232

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_3 and not isNil(var_39_2) then
				if arg_36_1.var_.characterEffect1070ui_story and not isNil(var_39_2) then
					arg_36_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_36_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_36_1.time_ - 0) / var_39_3)
				end
			end

			if arg_36_1.time_ >= 0 + var_39_3 and arg_36_1.time_ < 0 + var_39_3 + arg_39_0 and not isNil(var_39_2) and arg_36_1.var_.characterEffect1070ui_story then
				arg_36_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_36_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053action/1053action3_2")
			end

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_39_4 = 0
			local var_39_5 = 0.475

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_4 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				arg_36_1.leftNameTxt_.text = arg_36_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_6 = arg_36_1:GetWordFromCfg(324131009)
				local var_39_7 = arg_36_1:FormatText(var_39_6.content)

				arg_36_1.text_.text = var_39_7

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_9 = 19 <= 0 and var_39_5 or var_39_5 * (utf8.len(var_39_7) / 19)

				if (19 <= 0 and var_39_5 or var_39_5 * (utf8.len(var_39_7) / 19)) > 0 and var_39_5 < var_39_9 then
					arg_36_1.talkMaxDuration = var_39_9

					if var_39_9 + var_39_4 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_9 + var_39_4
					end
				end

				arg_36_1.text_.text = var_39_7
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324131", "324131009", "story_v_out_324131.awb") ~= 0 then
					local var_39_10 = manager.audio:GetVoiceLength("story_v_out_324131", "324131009", "story_v_out_324131.awb") / 1000

					if var_39_10 + var_39_4 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_10 + var_39_4
					end

					if var_39_6.prefab_name ~= "" and arg_36_1.actors_[var_39_6.prefab_name] ~= nil then
						local var_39_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_6.prefab_name].transform, "story_v_out_324131", "324131009", "story_v_out_324131.awb")

						arg_36_1:RecordAudio("324131009", var_39_11)
						arg_36_1:RecordAudio("324131009", var_39_11)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_324131", "324131009", "story_v_out_324131.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_324131", "324131009", "story_v_out_324131.awb")
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
	Play324131010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 324131010
		arg_40_1.duration_ = 6.17

		local var_40_0 = {
			zh = 4.5,
			ja = 6.166
		}
		local var_40_1 = manager.audio:GetLocalizationFlag()

		if var_40_0[var_40_1] ~= nil then
			arg_40_1.duration_ = var_40_0[var_40_1]
		end

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play324131011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 and not isNil(arg_40_1.actors_["1070ui_story"]) and arg_40_1.var_.characterEffect1070ui_story == nil then
				arg_40_1.var_.characterEffect1070ui_story = arg_40_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_0 = 0.200000002980232

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_0 and not isNil(arg_40_1.actors_["1070ui_story"]) then
				if arg_40_1.var_.characterEffect1070ui_story and not isNil(arg_40_1.actors_["1070ui_story"]) then
					arg_40_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_40_1.time_ >= 0 + var_43_0 and arg_40_1.time_ < 0 + var_43_0 + arg_43_0 and not isNil(arg_40_1.actors_["1070ui_story"]) and arg_40_1.var_.characterEffect1070ui_story then
				arg_40_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_43_2 = arg_40_1.actors_["1053ui_story"]

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 and not isNil(var_43_2) and arg_40_1.var_.characterEffect1053ui_story == nil then
				arg_40_1.var_.characterEffect1053ui_story = var_43_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_3 = 0.200000002980232

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_3 and not isNil(var_43_2) then
				if arg_40_1.var_.characterEffect1053ui_story and not isNil(var_43_2) then
					arg_40_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_40_1.var_.characterEffect1053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_40_1.time_ - 0) / var_43_3)
				end
			end

			if arg_40_1.time_ >= 0 + var_43_3 and arg_40_1.time_ < 0 + var_43_3 + arg_43_0 and not isNil(var_43_2) and arg_40_1.var_.characterEffect1053ui_story then
				arg_40_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_40_1.var_.characterEffect1053ui_story.fillRatio = 0.5
			end

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action4_2")
			end

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_43_4 = 0
			local var_43_5 = 0.55

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_4 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				arg_40_1.leftNameTxt_.text = arg_40_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_6 = arg_40_1:GetWordFromCfg(324131010)
				local var_43_7 = arg_40_1:FormatText(var_43_6.content)

				arg_40_1.text_.text = var_43_7

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_9 = 22 <= 0 and var_43_5 or var_43_5 * (utf8.len(var_43_7) / 22)

				if (22 <= 0 and var_43_5 or var_43_5 * (utf8.len(var_43_7) / 22)) > 0 and var_43_5 < var_43_9 then
					arg_40_1.talkMaxDuration = var_43_9

					if var_43_9 + var_43_4 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_9 + var_43_4
					end
				end

				arg_40_1.text_.text = var_43_7
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324131", "324131010", "story_v_out_324131.awb") ~= 0 then
					local var_43_10 = manager.audio:GetVoiceLength("story_v_out_324131", "324131010", "story_v_out_324131.awb") / 1000

					if var_43_10 + var_43_4 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_10 + var_43_4
					end

					if var_43_6.prefab_name ~= "" and arg_40_1.actors_[var_43_6.prefab_name] ~= nil then
						local var_43_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_6.prefab_name].transform, "story_v_out_324131", "324131010", "story_v_out_324131.awb")

						arg_40_1:RecordAudio("324131010", var_43_11)
						arg_40_1:RecordAudio("324131010", var_43_11)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_324131", "324131010", "story_v_out_324131.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_324131", "324131010", "story_v_out_324131.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_12 = math.max(var_43_5, arg_40_1.talkMaxDuration)

			if var_43_4 <= arg_40_1.time_ and arg_40_1.time_ < var_43_4 + var_43_12 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_4) / var_43_12

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_4 + var_43_12 and arg_40_1.time_ < var_43_4 + var_43_12 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play324131011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 324131011
		arg_44_1.duration_ = 7.83

		local var_44_0 = {
			zh = 4.766,
			ja = 7.833
		}
		local var_44_1 = manager.audio:GetLocalizationFlag()

		if var_44_0[var_44_1] ~= nil then
			arg_44_1.duration_ = var_44_0[var_44_1]
		end

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play324131012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 and not isNil(arg_44_1.actors_["1053ui_story"]) and arg_44_1.var_.characterEffect1053ui_story == nil then
				arg_44_1.var_.characterEffect1053ui_story = arg_44_1.actors_["1053ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_0 = 0.200000002980232

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_0 and not isNil(arg_44_1.actors_["1053ui_story"]) then
				if arg_44_1.var_.characterEffect1053ui_story and not isNil(arg_44_1.actors_["1053ui_story"]) then
					arg_44_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_44_1.time_ >= 0 + var_47_0 and arg_44_1.time_ < 0 + var_47_0 + arg_47_0 and not isNil(arg_44_1.actors_["1053ui_story"]) and arg_44_1.var_.characterEffect1053ui_story then
				arg_44_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_47_2 = arg_44_1.actors_["1070ui_story"]

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 and not isNil(var_47_2) and arg_44_1.var_.characterEffect1070ui_story == nil then
				arg_44_1.var_.characterEffect1070ui_story = var_47_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_3 = 0.200000002980232

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_3 and not isNil(var_47_2) then
				if arg_44_1.var_.characterEffect1070ui_story and not isNil(var_47_2) then
					arg_44_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_44_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_44_1.time_ - 0) / var_47_3)
				end
			end

			if arg_44_1.time_ >= 0 + var_47_3 and arg_44_1.time_ < 0 + var_47_3 + arg_47_0 and not isNil(var_47_2) and arg_44_1.var_.characterEffect1070ui_story then
				arg_44_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_44_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_47_4 = 0
			local var_47_5 = 0.575

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_4 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				arg_44_1.leftNameTxt_.text = arg_44_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_6 = arg_44_1:GetWordFromCfg(324131011)
				local var_47_7 = arg_44_1:FormatText(var_47_6.content)

				arg_44_1.text_.text = var_47_7

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_9 = 23 <= 0 and var_47_5 or var_47_5 * (utf8.len(var_47_7) / 23)

				if (23 <= 0 and var_47_5 or var_47_5 * (utf8.len(var_47_7) / 23)) > 0 and var_47_5 < var_47_9 then
					arg_44_1.talkMaxDuration = var_47_9

					if var_47_9 + var_47_4 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_9 + var_47_4
					end
				end

				arg_44_1.text_.text = var_47_7
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324131", "324131011", "story_v_out_324131.awb") ~= 0 then
					local var_47_10 = manager.audio:GetVoiceLength("story_v_out_324131", "324131011", "story_v_out_324131.awb") / 1000

					if var_47_10 + var_47_4 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_10 + var_47_4
					end

					if var_47_6.prefab_name ~= "" and arg_44_1.actors_[var_47_6.prefab_name] ~= nil then
						local var_47_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_6.prefab_name].transform, "story_v_out_324131", "324131011", "story_v_out_324131.awb")

						arg_44_1:RecordAudio("324131011", var_47_11)
						arg_44_1:RecordAudio("324131011", var_47_11)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_324131", "324131011", "story_v_out_324131.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_324131", "324131011", "story_v_out_324131.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_12 = math.max(var_47_5, arg_44_1.talkMaxDuration)

			if var_47_4 <= arg_44_1.time_ and arg_44_1.time_ < var_47_4 + var_47_12 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_4) / var_47_12

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_4 + var_47_12 and arg_44_1.time_ < var_47_4 + var_47_12 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play324131012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 324131012
		arg_48_1.duration_ = 10.67

		local var_48_0 = {
			zh = 7.933,
			ja = 10.666
		}
		local var_48_1 = manager.audio:GetLocalizationFlag()

		if var_48_0[var_48_1] ~= nil then
			arg_48_1.duration_ = var_48_0[var_48_1]
		end

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play324131013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 and not isNil(arg_48_1.actors_["1070ui_story"]) and arg_48_1.var_.characterEffect1070ui_story == nil then
				arg_48_1.var_.characterEffect1070ui_story = arg_48_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_0 = 0.200000002980232

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_0 and not isNil(arg_48_1.actors_["1070ui_story"]) then
				if arg_48_1.var_.characterEffect1070ui_story and not isNil(arg_48_1.actors_["1070ui_story"]) then
					arg_48_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_48_1.time_ >= 0 + var_51_0 and arg_48_1.time_ < 0 + var_51_0 + arg_51_0 and not isNil(arg_48_1.actors_["1070ui_story"]) and arg_48_1.var_.characterEffect1070ui_story then
				arg_48_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_51_2 = arg_48_1.actors_["1053ui_story"]

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 and not isNil(var_51_2) and arg_48_1.var_.characterEffect1053ui_story == nil then
				arg_48_1.var_.characterEffect1053ui_story = var_51_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_3 = 0.200000002980232

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_3 and not isNil(var_51_2) then
				if arg_48_1.var_.characterEffect1053ui_story and not isNil(var_51_2) then
					arg_48_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_48_1.var_.characterEffect1053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_48_1.time_ - 0) / var_51_3)
				end
			end

			if arg_48_1.time_ >= 0 + var_51_3 and arg_48_1.time_ < 0 + var_51_3 + arg_51_0 and not isNil(var_51_2) and arg_48_1.var_.characterEffect1053ui_story then
				arg_48_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_48_1.var_.characterEffect1053ui_story.fillRatio = 0.5
			end

			local var_51_4 = 0
			local var_51_5 = 0.85

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_4 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				arg_48_1.leftNameTxt_.text = arg_48_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_6 = arg_48_1:GetWordFromCfg(324131012)
				local var_51_7 = arg_48_1:FormatText(var_51_6.content)

				arg_48_1.text_.text = var_51_7

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_9 = 34 <= 0 and var_51_5 or var_51_5 * (utf8.len(var_51_7) / 34)

				if (34 <= 0 and var_51_5 or var_51_5 * (utf8.len(var_51_7) / 34)) > 0 and var_51_5 < var_51_9 then
					arg_48_1.talkMaxDuration = var_51_9

					if var_51_9 + var_51_4 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_9 + var_51_4
					end
				end

				arg_48_1.text_.text = var_51_7
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324131", "324131012", "story_v_out_324131.awb") ~= 0 then
					local var_51_10 = manager.audio:GetVoiceLength("story_v_out_324131", "324131012", "story_v_out_324131.awb") / 1000

					if var_51_10 + var_51_4 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_10 + var_51_4
					end

					if var_51_6.prefab_name ~= "" and arg_48_1.actors_[var_51_6.prefab_name] ~= nil then
						local var_51_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_6.prefab_name].transform, "story_v_out_324131", "324131012", "story_v_out_324131.awb")

						arg_48_1:RecordAudio("324131012", var_51_11)
						arg_48_1:RecordAudio("324131012", var_51_11)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_324131", "324131012", "story_v_out_324131.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_324131", "324131012", "story_v_out_324131.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_12 = math.max(var_51_5, arg_48_1.talkMaxDuration)

			if var_51_4 <= arg_48_1.time_ and arg_48_1.time_ < var_51_4 + var_51_12 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_4) / var_51_12

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_4 + var_51_12 and arg_48_1.time_ < var_51_4 + var_51_12 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play324131013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 324131013
		arg_52_1.duration_ = 9.9

		local var_52_0 = {
			zh = 9.9,
			ja = 9.566
		}
		local var_52_1 = manager.audio:GetLocalizationFlag()

		if var_52_0[var_52_1] ~= nil then
			arg_52_1.duration_ = var_52_0[var_52_1]
		end

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play324131014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 and not isNil(arg_52_1.actors_["1053ui_story"]) and arg_52_1.var_.characterEffect1053ui_story == nil then
				arg_52_1.var_.characterEffect1053ui_story = arg_52_1.actors_["1053ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_0 = 0.200000002980232

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_0 and not isNil(arg_52_1.actors_["1053ui_story"]) then
				if arg_52_1.var_.characterEffect1053ui_story and not isNil(arg_52_1.actors_["1053ui_story"]) then
					arg_52_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_52_1.time_ >= 0 + var_55_0 and arg_52_1.time_ < 0 + var_55_0 + arg_55_0 and not isNil(arg_52_1.actors_["1053ui_story"]) and arg_52_1.var_.characterEffect1053ui_story then
				arg_52_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_55_2 = arg_52_1.actors_["1070ui_story"]

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 and not isNil(var_55_2) and arg_52_1.var_.characterEffect1070ui_story == nil then
				arg_52_1.var_.characterEffect1070ui_story = var_55_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_3 = 0.200000002980232

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_3 and not isNil(var_55_2) then
				if arg_52_1.var_.characterEffect1070ui_story and not isNil(var_55_2) then
					arg_52_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_52_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_52_1.time_ - 0) / var_55_3)
				end
			end

			if arg_52_1.time_ >= 0 + var_55_3 and arg_52_1.time_ < 0 + var_55_3 + arg_55_0 and not isNil(var_55_2) and arg_52_1.var_.characterEffect1070ui_story then
				arg_52_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_52_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053action/1053action6_1")
			end

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_55_4 = 0
			local var_55_5 = 0.975

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_4 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				arg_52_1.leftNameTxt_.text = arg_52_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_6 = arg_52_1:GetWordFromCfg(324131013)
				local var_55_7 = arg_52_1:FormatText(var_55_6.content)

				arg_52_1.text_.text = var_55_7

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_9 = 39 <= 0 and var_55_5 or var_55_5 * (utf8.len(var_55_7) / 39)

				if (39 <= 0 and var_55_5 or var_55_5 * (utf8.len(var_55_7) / 39)) > 0 and var_55_5 < var_55_9 then
					arg_52_1.talkMaxDuration = var_55_9

					if var_55_9 + var_55_4 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_9 + var_55_4
					end
				end

				arg_52_1.text_.text = var_55_7
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324131", "324131013", "story_v_out_324131.awb") ~= 0 then
					local var_55_10 = manager.audio:GetVoiceLength("story_v_out_324131", "324131013", "story_v_out_324131.awb") / 1000

					if var_55_10 + var_55_4 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_10 + var_55_4
					end

					if var_55_6.prefab_name ~= "" and arg_52_1.actors_[var_55_6.prefab_name] ~= nil then
						local var_55_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_6.prefab_name].transform, "story_v_out_324131", "324131013", "story_v_out_324131.awb")

						arg_52_1:RecordAudio("324131013", var_55_11)
						arg_52_1:RecordAudio("324131013", var_55_11)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_324131", "324131013", "story_v_out_324131.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_324131", "324131013", "story_v_out_324131.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_12 = math.max(var_55_5, arg_52_1.talkMaxDuration)

			if var_55_4 <= arg_52_1.time_ and arg_52_1.time_ < var_55_4 + var_55_12 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_4) / var_55_12

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_4 + var_55_12 and arg_52_1.time_ < var_55_4 + var_55_12 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play324131014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 324131014
		arg_56_1.duration_ = 4.17

		local var_56_0 = {
			zh = 3.9,
			ja = 4.166
		}
		local var_56_1 = manager.audio:GetLocalizationFlag()

		if var_56_0[var_56_1] ~= nil then
			arg_56_1.duration_ = var_56_0[var_56_1]
		end

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play324131015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = 0.425

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				arg_56_1.leftNameTxt_.text = arg_56_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_1 = arg_56_1:GetWordFromCfg(324131014)
				local var_59_2 = arg_56_1:FormatText(var_59_1.content)

				arg_56_1.text_.text = var_59_2

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_4 = 17 <= 0 and var_59_0 or var_59_0 * (utf8.len(var_59_2) / 17)

				if (17 <= 0 and var_59_0 or var_59_0 * (utf8.len(var_59_2) / 17)) > 0 and var_59_0 < var_59_4 then
					arg_56_1.talkMaxDuration = var_59_4

					if var_59_4 + 0 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_4 + 0
					end
				end

				arg_56_1.text_.text = var_59_2
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324131", "324131014", "story_v_out_324131.awb") ~= 0 then
					local var_59_5 = manager.audio:GetVoiceLength("story_v_out_324131", "324131014", "story_v_out_324131.awb") / 1000

					if var_59_5 + 0 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_5 + 0
					end

					if var_59_1.prefab_name ~= "" and arg_56_1.actors_[var_59_1.prefab_name] ~= nil then
						local var_59_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_1.prefab_name].transform, "story_v_out_324131", "324131014", "story_v_out_324131.awb")

						arg_56_1:RecordAudio("324131014", var_59_6)
						arg_56_1:RecordAudio("324131014", var_59_6)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_324131", "324131014", "story_v_out_324131.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_324131", "324131014", "story_v_out_324131.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_7 = math.max(var_59_0, arg_56_1.talkMaxDuration)

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_7 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - 0) / var_59_7

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= 0 + var_59_7 and arg_56_1.time_ < 0 + var_59_7 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play324131015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 324131015
		arg_60_1.duration_ = 5

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play324131016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1.var_.moveOldPos1070ui_story = arg_60_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_63_0 = 0.001

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_0 then
				arg_60_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_60_1.var_.moveOldPos1070ui_story, Vector3.New(0, 100, 0), (arg_60_1.time_ - 0) / var_63_0)
				arg_60_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_60_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_60_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_60_1.actors_["1070ui_story"].transform.position).z)
				arg_60_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_60_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_60_1.actors_["1070ui_story"].transform.localEulerAngles = arg_60_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_60_1.time_ >= 0 + var_63_0 and arg_60_1.time_ < 0 + var_63_0 + arg_63_0 then
				arg_60_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_60_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_60_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_60_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_60_1.actors_["1070ui_story"].transform.position).z)
				arg_60_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_60_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_60_1.actors_["1070ui_story"].transform.localEulerAngles = arg_60_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_63_1 = arg_60_1.actors_["1053ui_story"].transform

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1.var_.moveOldPos1053ui_story = var_63_1.localPosition

				local var_63_2 = GameObjectTools.GetOrAddComponent(var_63_1.gameObject, typeof(DynamicBoneHelper))

				if var_63_2 then
					var_63_2:EnableDynamicBone(false)
				end
			end

			local var_63_3 = 0.001

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_3 then
				var_63_1.localPosition = Vector3.Lerp(arg_60_1.var_.moveOldPos1053ui_story, Vector3.New(0, 100, 0), (arg_60_1.time_ - 0) / var_63_3)
				var_63_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_63_1.position).x, (manager.ui.mainCamera.transform.position - var_63_1.position).y, (manager.ui.mainCamera.transform.position - var_63_1.position).z)
				var_63_1.localEulerAngles.z = 0
				var_63_1.localEulerAngles.x = 0
				var_63_1.localEulerAngles = var_63_1.localEulerAngles
			end

			if arg_60_1.time_ >= 0 + var_63_3 and arg_60_1.time_ < 0 + var_63_3 + arg_63_0 then
				var_63_1.localPosition = Vector3.New(0, 100, 0)
				var_63_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_63_1.position).x, (manager.ui.mainCamera.transform.position - var_63_1.position).y, (manager.ui.mainCamera.transform.position - var_63_1.position).z)
				var_63_1.localEulerAngles.z = 0
				var_63_1.localEulerAngles.x = 0
				var_63_1.localEulerAngles = var_63_1.localEulerAngles

				local var_63_4 = GameObjectTools.GetOrAddComponent(var_63_1.gameObject, typeof(DynamicBoneHelper))

				if var_63_4 then
					var_63_4:EnableDynamicBone(true)
				end
			end

			local var_63_5 = arg_60_1.actors_["1053ui_story"]

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 and not isNil(var_63_5) and arg_60_1.var_.characterEffect1053ui_story == nil then
				arg_60_1.var_.characterEffect1053ui_story = var_63_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_6 = 0.200000002980232

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_6 and not isNil(var_63_5) then
				if arg_60_1.var_.characterEffect1053ui_story and not isNil(var_63_5) then
					arg_60_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_60_1.var_.characterEffect1053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_60_1.time_ - 0) / var_63_6)
				end
			end

			if arg_60_1.time_ >= 0 + var_63_6 and arg_60_1.time_ < 0 + var_63_6 + arg_63_0 and not isNil(var_63_5) and arg_60_1.var_.characterEffect1053ui_story then
				arg_60_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_60_1.var_.characterEffect1053ui_story.fillRatio = 0.5
			end

			local var_63_7 = 0
			local var_63_8 = 1.275

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_7 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, false)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_9 = arg_60_1:FormatText(arg_60_1:GetWordFromCfg(324131015).content)

				arg_60_1.text_.text = var_63_9

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_11 = 51 <= 0 and var_63_8 or var_63_8 * (utf8.len(var_63_9) / 51)

				if (51 <= 0 and var_63_8 or var_63_8 * (utf8.len(var_63_9) / 51)) > 0 and var_63_8 < var_63_11 then
					arg_60_1.talkMaxDuration = var_63_11

					if var_63_11 + var_63_7 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_11 + var_63_7
					end
				end

				arg_60_1.text_.text = var_63_9
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)
				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_12 = math.max(var_63_8, arg_60_1.talkMaxDuration)

			if var_63_7 <= arg_60_1.time_ and arg_60_1.time_ < var_63_7 + var_63_12 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_7) / var_63_12

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_7 + var_63_12 and arg_60_1.time_ < var_63_7 + var_63_12 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_60_1:InitPlayNodeList()
	end,
	Play324131016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 324131016
		arg_64_1.duration_ = 5.4

		local var_64_0 = {
			zh = 2.833,
			ja = 5.4
		}
		local var_64_1 = manager.audio:GetLocalizationFlag()

		if var_64_0[var_64_1] ~= nil then
			arg_64_1.duration_ = var_64_0[var_64_1]
		end

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play324131017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1.var_.moveOldPos1070ui_story = arg_64_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_67_0 = 0.001

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_0 then
				arg_64_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos1070ui_story, Vector3.New(-0.7, -0.95, -6.05), (arg_64_1.time_ - 0) / var_67_0)
				arg_64_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_64_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_64_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_64_1.actors_["1070ui_story"].transform.position).z)
				arg_64_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_64_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_64_1.actors_["1070ui_story"].transform.localEulerAngles = arg_64_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_64_1.time_ >= 0 + var_67_0 and arg_64_1.time_ < 0 + var_67_0 + arg_67_0 then
				arg_64_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(-0.7, -0.95, -6.05)
				arg_64_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_64_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_64_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_64_1.actors_["1070ui_story"].transform.position).z)
				arg_64_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_64_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_64_1.actors_["1070ui_story"].transform.localEulerAngles = arg_64_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_67_1 = arg_64_1.actors_["1070ui_story"]

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 and not isNil(var_67_1) and arg_64_1.var_.characterEffect1070ui_story == nil then
				arg_64_1.var_.characterEffect1070ui_story = var_67_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_2 = 0.200000002980232

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_2 and not isNil(var_67_1) then
				if arg_64_1.var_.characterEffect1070ui_story and not isNil(var_67_1) then
					arg_64_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_64_1.time_ >= 0 + var_67_2 and arg_64_1.time_ < 0 + var_67_2 + arg_67_0 and not isNil(var_67_1) and arg_64_1.var_.characterEffect1070ui_story then
				arg_64_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action5_1")
			end

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_67_4 = 0
			local var_67_5 = 0.325

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= var_67_4 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				arg_64_1.leftNameTxt_.text = arg_64_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_6 = arg_64_1:GetWordFromCfg(324131016)
				local var_67_7 = arg_64_1:FormatText(var_67_6.content)

				arg_64_1.text_.text = var_67_7

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_9 = 13 <= 0 and var_67_5 or var_67_5 * (utf8.len(var_67_7) / 13)

				if (13 <= 0 and var_67_5 or var_67_5 * (utf8.len(var_67_7) / 13)) > 0 and var_67_5 < var_67_9 then
					arg_64_1.talkMaxDuration = var_67_9

					if var_67_9 + var_67_4 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_9 + var_67_4
					end
				end

				arg_64_1.text_.text = var_67_7
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324131", "324131016", "story_v_out_324131.awb") ~= 0 then
					local var_67_10 = manager.audio:GetVoiceLength("story_v_out_324131", "324131016", "story_v_out_324131.awb") / 1000

					if var_67_10 + var_67_4 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_10 + var_67_4
					end

					if var_67_6.prefab_name ~= "" and arg_64_1.actors_[var_67_6.prefab_name] ~= nil then
						local var_67_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_6.prefab_name].transform, "story_v_out_324131", "324131016", "story_v_out_324131.awb")

						arg_64_1:RecordAudio("324131016", var_67_11)
						arg_64_1:RecordAudio("324131016", var_67_11)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_324131", "324131016", "story_v_out_324131.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_324131", "324131016", "story_v_out_324131.awb")
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

		arg_64_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_64_1:InitPlayNodeList()
	end,
	Play324131017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 324131017
		arg_68_1.duration_ = 3.6

		local var_68_0 = {
			zh = 3.533,
			ja = 3.6
		}
		local var_68_1 = manager.audio:GetLocalizationFlag()

		if var_68_0[var_68_1] ~= nil then
			arg_68_1.duration_ = var_68_0[var_68_1]
		end

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play324131018(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1.var_.moveOldPos1053ui_story = arg_68_1.actors_["1053ui_story"].transform.localPosition

				local var_71_0 = GameObjectTools.GetOrAddComponent(arg_68_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_71_0 then
					var_71_0:EnableDynamicBone(false)
				end
			end

			local var_71_1 = 0.001

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_1 then
				arg_68_1.actors_["1053ui_story"].transform.localPosition = Vector3.Lerp(arg_68_1.var_.moveOldPos1053ui_story, Vector3.New(0.7, -1.08, -6), (arg_68_1.time_ - 0) / var_71_1)
				arg_68_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_68_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_68_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_68_1.actors_["1053ui_story"].transform.position).z)
				arg_68_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_68_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_68_1.actors_["1053ui_story"].transform.localEulerAngles = arg_68_1.actors_["1053ui_story"].transform.localEulerAngles
			end

			if arg_68_1.time_ >= 0 + var_71_1 and arg_68_1.time_ < 0 + var_71_1 + arg_71_0 then
				arg_68_1.actors_["1053ui_story"].transform.localPosition = Vector3.New(0.7, -1.08, -6)
				arg_68_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_68_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_68_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_68_1.actors_["1053ui_story"].transform.position).z)
				arg_68_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_68_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_68_1.actors_["1053ui_story"].transform.localEulerAngles = arg_68_1.actors_["1053ui_story"].transform.localEulerAngles

				local var_71_2 = GameObjectTools.GetOrAddComponent(arg_68_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_71_2 then
					var_71_2:EnableDynamicBone(true)
				end
			end

			local var_71_3 = arg_68_1.actors_["1053ui_story"]

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 and not isNil(var_71_3) and arg_68_1.var_.characterEffect1053ui_story == nil then
				arg_68_1.var_.characterEffect1053ui_story = var_71_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_4 = 0.200000002980232

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_4 and not isNil(var_71_3) then
				if arg_68_1.var_.characterEffect1053ui_story and not isNil(var_71_3) then
					arg_68_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_68_1.time_ >= 0 + var_71_4 and arg_68_1.time_ < 0 + var_71_4 + arg_71_0 and not isNil(var_71_3) and arg_68_1.var_.characterEffect1053ui_story then
				arg_68_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_71_6 = arg_68_1.actors_["1070ui_story"]

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 and not isNil(var_71_6) and arg_68_1.var_.characterEffect1070ui_story == nil then
				arg_68_1.var_.characterEffect1070ui_story = var_71_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_7 = 0.200000002980232

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_7 and not isNil(var_71_6) then
				if arg_68_1.var_.characterEffect1070ui_story and not isNil(var_71_6) then
					arg_68_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_68_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_68_1.time_ - 0) / var_71_7)
				end
			end

			if arg_68_1.time_ >= 0 + var_71_7 and arg_68_1.time_ < 0 + var_71_7 + arg_71_0 and not isNil(var_71_6) and arg_68_1.var_.characterEffect1070ui_story then
				arg_68_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_68_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053actionlink/1053action464")
			end

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_71_8 = 0
			local var_71_9 = 0.375

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= var_71_8 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				arg_68_1.leftNameTxt_.text = arg_68_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_10 = arg_68_1:GetWordFromCfg(324131017)
				local var_71_11 = arg_68_1:FormatText(var_71_10.content)

				arg_68_1.text_.text = var_71_11

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_13 = 15 <= 0 and var_71_9 or var_71_9 * (utf8.len(var_71_11) / 15)

				if (15 <= 0 and var_71_9 or var_71_9 * (utf8.len(var_71_11) / 15)) > 0 and var_71_9 < var_71_13 then
					arg_68_1.talkMaxDuration = var_71_13

					if var_71_13 + var_71_8 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_13 + var_71_8
					end
				end

				arg_68_1.text_.text = var_71_11
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324131", "324131017", "story_v_out_324131.awb") ~= 0 then
					local var_71_14 = manager.audio:GetVoiceLength("story_v_out_324131", "324131017", "story_v_out_324131.awb") / 1000

					if var_71_14 + var_71_8 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_14 + var_71_8
					end

					if var_71_10.prefab_name ~= "" and arg_68_1.actors_[var_71_10.prefab_name] ~= nil then
						local var_71_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_10.prefab_name].transform, "story_v_out_324131", "324131017", "story_v_out_324131.awb")

						arg_68_1:RecordAudio("324131017", var_71_15)
						arg_68_1:RecordAudio("324131017", var_71_15)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_324131", "324131017", "story_v_out_324131.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_324131", "324131017", "story_v_out_324131.awb")
				end

				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_16 = math.max(var_71_9, arg_68_1.talkMaxDuration)

			if var_71_8 <= arg_68_1.time_ and arg_68_1.time_ < var_71_8 + var_71_16 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_8) / var_71_16

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_8 + var_71_16 and arg_68_1.time_ < var_71_8 + var_71_16 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_68_1:InitPlayNodeList()
	end,
	Play324131018 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 324131018
		arg_72_1.duration_ = 5

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play324131019(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1.var_.moveOldPos1070ui_story = arg_72_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_75_0 = 0.001

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_0 then
				arg_72_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos1070ui_story, Vector3.New(0, 100, 0), (arg_72_1.time_ - 0) / var_75_0)
				arg_72_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_72_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_72_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_72_1.actors_["1070ui_story"].transform.position).z)
				arg_72_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_72_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_72_1.actors_["1070ui_story"].transform.localEulerAngles = arg_72_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_72_1.time_ >= 0 + var_75_0 and arg_72_1.time_ < 0 + var_75_0 + arg_75_0 then
				arg_72_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_72_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_72_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_72_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_72_1.actors_["1070ui_story"].transform.position).z)
				arg_72_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_72_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_72_1.actors_["1070ui_story"].transform.localEulerAngles = arg_72_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_75_1 = arg_72_1.actors_["1053ui_story"].transform

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1.var_.moveOldPos1053ui_story = var_75_1.localPosition

				local var_75_2 = GameObjectTools.GetOrAddComponent(var_75_1.gameObject, typeof(DynamicBoneHelper))

				if var_75_2 then
					var_75_2:EnableDynamicBone(false)
				end
			end

			local var_75_3 = 0.001

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_3 then
				var_75_1.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos1053ui_story, Vector3.New(0, 100, 0), (arg_72_1.time_ - 0) / var_75_3)
				var_75_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_75_1.position).x, (manager.ui.mainCamera.transform.position - var_75_1.position).y, (manager.ui.mainCamera.transform.position - var_75_1.position).z)
				var_75_1.localEulerAngles.z = 0
				var_75_1.localEulerAngles.x = 0
				var_75_1.localEulerAngles = var_75_1.localEulerAngles
			end

			if arg_72_1.time_ >= 0 + var_75_3 and arg_72_1.time_ < 0 + var_75_3 + arg_75_0 then
				var_75_1.localPosition = Vector3.New(0, 100, 0)
				var_75_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_75_1.position).x, (manager.ui.mainCamera.transform.position - var_75_1.position).y, (manager.ui.mainCamera.transform.position - var_75_1.position).z)
				var_75_1.localEulerAngles.z = 0
				var_75_1.localEulerAngles.x = 0
				var_75_1.localEulerAngles = var_75_1.localEulerAngles

				local var_75_4 = GameObjectTools.GetOrAddComponent(var_75_1.gameObject, typeof(DynamicBoneHelper))

				if var_75_4 then
					var_75_4:EnableDynamicBone(true)
				end
			end

			local var_75_5 = arg_72_1.actors_["1053ui_story"]

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 and not isNil(var_75_5) and arg_72_1.var_.characterEffect1053ui_story == nil then
				arg_72_1.var_.characterEffect1053ui_story = var_75_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_6 = 0.200000002980232

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_6 and not isNil(var_75_5) then
				if arg_72_1.var_.characterEffect1053ui_story and not isNil(var_75_5) then
					arg_72_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_72_1.var_.characterEffect1053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_72_1.time_ - 0) / var_75_6)
				end
			end

			if arg_72_1.time_ >= 0 + var_75_6 and arg_72_1.time_ < 0 + var_75_6 + arg_75_0 and not isNil(var_75_5) and arg_72_1.var_.characterEffect1053ui_story then
				arg_72_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_72_1.var_.characterEffect1053ui_story.fillRatio = 0.5
			end

			local var_75_7 = 0
			local var_75_8 = 0.975

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= var_75_7 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, false)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_9 = arg_72_1:FormatText(arg_72_1:GetWordFromCfg(324131018).content)

				arg_72_1.text_.text = var_75_9

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_11 = 39 <= 0 and var_75_8 or var_75_8 * (utf8.len(var_75_9) / 39)

				if (39 <= 0 and var_75_8 or var_75_8 * (utf8.len(var_75_9) / 39)) > 0 and var_75_8 < var_75_11 then
					arg_72_1.talkMaxDuration = var_75_11

					if var_75_11 + var_75_7 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_11 + var_75_7
					end
				end

				arg_72_1.text_.text = var_75_9
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)
				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_12 = math.max(var_75_8, arg_72_1.talkMaxDuration)

			if var_75_7 <= arg_72_1.time_ and arg_72_1.time_ < var_75_7 + var_75_12 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_7) / var_75_12

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_7 + var_75_12 and arg_72_1.time_ < var_75_7 + var_75_12 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_72_1:InitPlayNodeList()
	end,
	Play324131019 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 324131019
		arg_76_1.duration_ = 3.03

		local var_76_0 = {
			zh = 2.033,
			ja = 3.033
		}
		local var_76_1 = manager.audio:GetLocalizationFlag()

		if var_76_0[var_76_1] ~= nil then
			arg_76_1.duration_ = var_76_0[var_76_1]
		end

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play324131020(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1.var_.moveOldPos1053ui_story = arg_76_1.actors_["1053ui_story"].transform.localPosition

				local var_79_0 = GameObjectTools.GetOrAddComponent(arg_76_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_79_0 then
					var_79_0:EnableDynamicBone(false)
				end
			end

			local var_79_1 = 0.001

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_1 then
				arg_76_1.actors_["1053ui_story"].transform.localPosition = Vector3.Lerp(arg_76_1.var_.moveOldPos1053ui_story, Vector3.New(0.7, -1.08, -6), (arg_76_1.time_ - 0) / var_79_1)
				arg_76_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_76_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_76_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_76_1.actors_["1053ui_story"].transform.position).z)
				arg_76_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_76_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_76_1.actors_["1053ui_story"].transform.localEulerAngles = arg_76_1.actors_["1053ui_story"].transform.localEulerAngles
			end

			if arg_76_1.time_ >= 0 + var_79_1 and arg_76_1.time_ < 0 + var_79_1 + arg_79_0 then
				arg_76_1.actors_["1053ui_story"].transform.localPosition = Vector3.New(0.7, -1.08, -6)
				arg_76_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_76_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_76_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_76_1.actors_["1053ui_story"].transform.position).z)
				arg_76_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_76_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_76_1.actors_["1053ui_story"].transform.localEulerAngles = arg_76_1.actors_["1053ui_story"].transform.localEulerAngles

				local var_79_2 = GameObjectTools.GetOrAddComponent(arg_76_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_79_2 then
					var_79_2:EnableDynamicBone(true)
				end
			end

			local var_79_3 = arg_76_1.actors_["1053ui_story"]

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 and not isNil(var_79_3) and arg_76_1.var_.characterEffect1053ui_story == nil then
				arg_76_1.var_.characterEffect1053ui_story = var_79_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_4 = 0.200000002980232

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_4 and not isNil(var_79_3) then
				if arg_76_1.var_.characterEffect1053ui_story and not isNil(var_79_3) then
					arg_76_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_76_1.time_ >= 0 + var_79_4 and arg_76_1.time_ < 0 + var_79_4 + arg_79_0 and not isNil(var_79_3) and arg_76_1.var_.characterEffect1053ui_story then
				arg_76_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053action/1053action4_2")
			end

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_79_6 = 0
			local var_79_7 = 0.3

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= var_79_6 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				arg_76_1.leftNameTxt_.text = arg_76_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_8 = arg_76_1:GetWordFromCfg(324131019)
				local var_79_9 = arg_76_1:FormatText(var_79_8.content)

				arg_76_1.text_.text = var_79_9

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_11 = 12 <= 0 and var_79_7 or var_79_7 * (utf8.len(var_79_9) / 12)

				if (12 <= 0 and var_79_7 or var_79_7 * (utf8.len(var_79_9) / 12)) > 0 and var_79_7 < var_79_11 then
					arg_76_1.talkMaxDuration = var_79_11

					if var_79_11 + var_79_6 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_11 + var_79_6
					end
				end

				arg_76_1.text_.text = var_79_9
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324131", "324131019", "story_v_out_324131.awb") ~= 0 then
					local var_79_12 = manager.audio:GetVoiceLength("story_v_out_324131", "324131019", "story_v_out_324131.awb") / 1000

					if var_79_12 + var_79_6 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_12 + var_79_6
					end

					if var_79_8.prefab_name ~= "" and arg_76_1.actors_[var_79_8.prefab_name] ~= nil then
						local var_79_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_8.prefab_name].transform, "story_v_out_324131", "324131019", "story_v_out_324131.awb")

						arg_76_1:RecordAudio("324131019", var_79_13)
						arg_76_1:RecordAudio("324131019", var_79_13)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_324131", "324131019", "story_v_out_324131.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_324131", "324131019", "story_v_out_324131.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_14 = math.max(var_79_7, arg_76_1.talkMaxDuration)

			if var_79_6 <= arg_76_1.time_ and arg_76_1.time_ < var_79_6 + var_79_14 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_6) / var_79_14

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_6 + var_79_14 and arg_76_1.time_ < var_79_6 + var_79_14 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_76_1:InitPlayNodeList()
	end,
	Play324131020 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 324131020
		arg_80_1.duration_ = 8.6

		local var_80_0 = {
			zh = 8.6,
			ja = 8.066
		}
		local var_80_1 = manager.audio:GetLocalizationFlag()

		if var_80_0[var_80_1] ~= nil then
			arg_80_1.duration_ = var_80_0[var_80_1]
		end

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play324131021(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1.var_.moveOldPos1070ui_story = arg_80_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_83_0 = 0.001

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_0 then
				arg_80_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPos1070ui_story, Vector3.New(-0.7, -0.95, -6.05), (arg_80_1.time_ - 0) / var_83_0)
				arg_80_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_80_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_80_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_80_1.actors_["1070ui_story"].transform.position).z)
				arg_80_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_80_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_80_1.actors_["1070ui_story"].transform.localEulerAngles = arg_80_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_80_1.time_ >= 0 + var_83_0 and arg_80_1.time_ < 0 + var_83_0 + arg_83_0 then
				arg_80_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(-0.7, -0.95, -6.05)
				arg_80_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_80_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_80_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_80_1.actors_["1070ui_story"].transform.position).z)
				arg_80_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_80_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_80_1.actors_["1070ui_story"].transform.localEulerAngles = arg_80_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_83_1 = arg_80_1.actors_["1070ui_story"]

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 and not isNil(var_83_1) and arg_80_1.var_.characterEffect1070ui_story == nil then
				arg_80_1.var_.characterEffect1070ui_story = var_83_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_2 = 0.200000002980232

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_2 and not isNil(var_83_1) then
				if arg_80_1.var_.characterEffect1070ui_story and not isNil(var_83_1) then
					arg_80_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_80_1.time_ >= 0 + var_83_2 and arg_80_1.time_ < 0 + var_83_2 + arg_83_0 and not isNil(var_83_1) and arg_80_1.var_.characterEffect1070ui_story then
				arg_80_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_83_4 = arg_80_1.actors_["1053ui_story"]

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 and not isNil(var_83_4) and arg_80_1.var_.characterEffect1053ui_story == nil then
				arg_80_1.var_.characterEffect1053ui_story = var_83_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_5 = 0.200000002980232

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_5 and not isNil(var_83_4) then
				if arg_80_1.var_.characterEffect1053ui_story and not isNil(var_83_4) then
					arg_80_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_80_1.var_.characterEffect1053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_80_1.time_ - 0) / var_83_5)
				end
			end

			if arg_80_1.time_ >= 0 + var_83_5 and arg_80_1.time_ < 0 + var_83_5 + arg_83_0 and not isNil(var_83_4) and arg_80_1.var_.characterEffect1053ui_story then
				arg_80_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_80_1.var_.characterEffect1053ui_story.fillRatio = 0.5
			end

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070actionlink/1070action457")
			end

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_83_6 = 0
			local var_83_7 = 0.6

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_6 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				arg_80_1.leftNameTxt_.text = arg_80_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_8 = arg_80_1:GetWordFromCfg(324131020)
				local var_83_9 = arg_80_1:FormatText(var_83_8.content)

				arg_80_1.text_.text = var_83_9

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_11 = 24 <= 0 and var_83_7 or var_83_7 * (utf8.len(var_83_9) / 24)

				if (24 <= 0 and var_83_7 or var_83_7 * (utf8.len(var_83_9) / 24)) > 0 and var_83_7 < var_83_11 then
					arg_80_1.talkMaxDuration = var_83_11

					if var_83_11 + var_83_6 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_11 + var_83_6
					end
				end

				arg_80_1.text_.text = var_83_9
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324131", "324131020", "story_v_out_324131.awb") ~= 0 then
					local var_83_12 = manager.audio:GetVoiceLength("story_v_out_324131", "324131020", "story_v_out_324131.awb") / 1000

					if var_83_12 + var_83_6 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_12 + var_83_6
					end

					if var_83_8.prefab_name ~= "" and arg_80_1.actors_[var_83_8.prefab_name] ~= nil then
						local var_83_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_8.prefab_name].transform, "story_v_out_324131", "324131020", "story_v_out_324131.awb")

						arg_80_1:RecordAudio("324131020", var_83_13)
						arg_80_1:RecordAudio("324131020", var_83_13)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_out_324131", "324131020", "story_v_out_324131.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_out_324131", "324131020", "story_v_out_324131.awb")
				end

				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_14 = math.max(var_83_7, arg_80_1.talkMaxDuration)

			if var_83_6 <= arg_80_1.time_ and arg_80_1.time_ < var_83_6 + var_83_14 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_6) / var_83_14

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_6 + var_83_14 and arg_80_1.time_ < var_83_6 + var_83_14 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_80_1:InitPlayNodeList()
	end,
	Play324131021 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 324131021
		arg_84_1.duration_ = 11.03

		local var_84_0 = {
			zh = 10.8,
			ja = 11.033
		}
		local var_84_1 = manager.audio:GetLocalizationFlag()

		if var_84_0[var_84_1] ~= nil then
			arg_84_1.duration_ = var_84_0[var_84_1]
		end

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play324131022(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 and not isNil(arg_84_1.actors_["1053ui_story"]) and arg_84_1.var_.characterEffect1053ui_story == nil then
				arg_84_1.var_.characterEffect1053ui_story = arg_84_1.actors_["1053ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_0 = 0.200000002980232

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_0 and not isNil(arg_84_1.actors_["1053ui_story"]) then
				if arg_84_1.var_.characterEffect1053ui_story and not isNil(arg_84_1.actors_["1053ui_story"]) then
					arg_84_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_84_1.time_ >= 0 + var_87_0 and arg_84_1.time_ < 0 + var_87_0 + arg_87_0 and not isNil(arg_84_1.actors_["1053ui_story"]) and arg_84_1.var_.characterEffect1053ui_story then
				arg_84_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_87_2 = arg_84_1.actors_["1070ui_story"]

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 and not isNil(var_87_2) and arg_84_1.var_.characterEffect1070ui_story == nil then
				arg_84_1.var_.characterEffect1070ui_story = var_87_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_3 = 0.200000002980232

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_3 and not isNil(var_87_2) then
				if arg_84_1.var_.characterEffect1070ui_story and not isNil(var_87_2) then
					arg_84_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_84_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_84_1.time_ - 0) / var_87_3)
				end
			end

			if arg_84_1.time_ >= 0 + var_87_3 and arg_84_1.time_ < 0 + var_87_3 + arg_87_0 and not isNil(var_87_2) and arg_84_1.var_.characterEffect1070ui_story then
				arg_84_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_84_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_87_4 = 0
			local var_87_5 = 1.05

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= var_87_4 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				arg_84_1.leftNameTxt_.text = arg_84_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_6 = arg_84_1:GetWordFromCfg(324131021)
				local var_87_7 = arg_84_1:FormatText(var_87_6.content)

				arg_84_1.text_.text = var_87_7

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_9 = 42 <= 0 and var_87_5 or var_87_5 * (utf8.len(var_87_7) / 42)

				if (42 <= 0 and var_87_5 or var_87_5 * (utf8.len(var_87_7) / 42)) > 0 and var_87_5 < var_87_9 then
					arg_84_1.talkMaxDuration = var_87_9

					if var_87_9 + var_87_4 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_9 + var_87_4
					end
				end

				arg_84_1.text_.text = var_87_7
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324131", "324131021", "story_v_out_324131.awb") ~= 0 then
					local var_87_10 = manager.audio:GetVoiceLength("story_v_out_324131", "324131021", "story_v_out_324131.awb") / 1000

					if var_87_10 + var_87_4 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_10 + var_87_4
					end

					if var_87_6.prefab_name ~= "" and arg_84_1.actors_[var_87_6.prefab_name] ~= nil then
						local var_87_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_6.prefab_name].transform, "story_v_out_324131", "324131021", "story_v_out_324131.awb")

						arg_84_1:RecordAudio("324131021", var_87_11)
						arg_84_1:RecordAudio("324131021", var_87_11)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_out_324131", "324131021", "story_v_out_324131.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_out_324131", "324131021", "story_v_out_324131.awb")
				end

				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_12 = math.max(var_87_5, arg_84_1.talkMaxDuration)

			if var_87_4 <= arg_84_1.time_ and arg_84_1.time_ < var_87_4 + var_87_12 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_4) / var_87_12

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_4 + var_87_12 and arg_84_1.time_ < var_87_4 + var_87_12 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {}

		arg_84_1:InitPlayNodeList()
	end,
	Play324131022 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 324131022
		arg_88_1.duration_ = 8.23

		local var_88_0 = {
			zh = 8.233,
			ja = 6.933
		}
		local var_88_1 = manager.audio:GetLocalizationFlag()

		if var_88_0[var_88_1] ~= nil then
			arg_88_1.duration_ = var_88_0[var_88_1]
		end

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play324131023(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = 0.8

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				arg_88_1.leftNameTxt_.text = arg_88_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_1 = arg_88_1:GetWordFromCfg(324131022)
				local var_91_2 = arg_88_1:FormatText(var_91_1.content)

				arg_88_1.text_.text = var_91_2

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_4 = 32 <= 0 and var_91_0 or var_91_0 * (utf8.len(var_91_2) / 32)

				if (32 <= 0 and var_91_0 or var_91_0 * (utf8.len(var_91_2) / 32)) > 0 and var_91_0 < var_91_4 then
					arg_88_1.talkMaxDuration = var_91_4

					if var_91_4 + 0 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_4 + 0
					end
				end

				arg_88_1.text_.text = var_91_2
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324131", "324131022", "story_v_out_324131.awb") ~= 0 then
					local var_91_5 = manager.audio:GetVoiceLength("story_v_out_324131", "324131022", "story_v_out_324131.awb") / 1000

					if var_91_5 + 0 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_5 + 0
					end

					if var_91_1.prefab_name ~= "" and arg_88_1.actors_[var_91_1.prefab_name] ~= nil then
						local var_91_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_1.prefab_name].transform, "story_v_out_324131", "324131022", "story_v_out_324131.awb")

						arg_88_1:RecordAudio("324131022", var_91_6)
						arg_88_1:RecordAudio("324131022", var_91_6)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_out_324131", "324131022", "story_v_out_324131.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_out_324131", "324131022", "story_v_out_324131.awb")
				end

				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_7 = math.max(var_91_0, arg_88_1.talkMaxDuration)

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_7 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - 0) / var_91_7

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= 0 + var_91_7 and arg_88_1.time_ < 0 + var_91_7 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {}

		arg_88_1:InitPlayNodeList()
	end,
	Play324131023 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 324131023
		arg_92_1.duration_ = 4.8

		local var_92_0 = {
			zh = 4.2,
			ja = 4.8
		}
		local var_92_1 = manager.audio:GetLocalizationFlag()

		if var_92_0[var_92_1] ~= nil then
			arg_92_1.duration_ = var_92_0[var_92_1]
		end

		SetActive(arg_92_1.tipsGo_, false)

		function arg_92_1.onSingleLineFinish_()
			arg_92_1.onSingleLineUpdate_ = nil
			arg_92_1.onSingleLineFinish_ = nil
			arg_92_1.state_ = "waiting"
		end

		function arg_92_1.playNext_(arg_94_0)
			if arg_94_0 == 1 then
				arg_92_0:Play324131024(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 and not isNil(arg_92_1.actors_["1070ui_story"]) and arg_92_1.var_.characterEffect1070ui_story == nil then
				arg_92_1.var_.characterEffect1070ui_story = arg_92_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_0 = 0.200000002980232

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_0 and not isNil(arg_92_1.actors_["1070ui_story"]) then
				if arg_92_1.var_.characterEffect1070ui_story and not isNil(arg_92_1.actors_["1070ui_story"]) then
					arg_92_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_92_1.time_ >= 0 + var_95_0 and arg_92_1.time_ < 0 + var_95_0 + arg_95_0 and not isNil(arg_92_1.actors_["1070ui_story"]) and arg_92_1.var_.characterEffect1070ui_story then
				arg_92_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_95_2 = arg_92_1.actors_["1053ui_story"]

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 and not isNil(var_95_2) and arg_92_1.var_.characterEffect1053ui_story == nil then
				arg_92_1.var_.characterEffect1053ui_story = var_95_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_3 = 0.200000002980232

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_3 and not isNil(var_95_2) then
				if arg_92_1.var_.characterEffect1053ui_story and not isNil(var_95_2) then
					arg_92_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_92_1.var_.characterEffect1053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_92_1.time_ - 0) / var_95_3)
				end
			end

			if arg_92_1.time_ >= 0 + var_95_3 and arg_92_1.time_ < 0 + var_95_3 + arg_95_0 and not isNil(var_95_2) and arg_92_1.var_.characterEffect1053ui_story then
				arg_92_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_92_1.var_.characterEffect1053ui_story.fillRatio = 0.5
			end

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action7_2")
			end

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_95_4 = 0
			local var_95_5 = 0.475

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= var_95_4 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				arg_92_1.leftNameTxt_.text = arg_92_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_6 = arg_92_1:GetWordFromCfg(324131023)
				local var_95_7 = arg_92_1:FormatText(var_95_6.content)

				arg_92_1.text_.text = var_95_7

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_9 = 19 <= 0 and var_95_5 or var_95_5 * (utf8.len(var_95_7) / 19)

				if (19 <= 0 and var_95_5 or var_95_5 * (utf8.len(var_95_7) / 19)) > 0 and var_95_5 < var_95_9 then
					arg_92_1.talkMaxDuration = var_95_9

					if var_95_9 + var_95_4 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_9 + var_95_4
					end
				end

				arg_92_1.text_.text = var_95_7
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324131", "324131023", "story_v_out_324131.awb") ~= 0 then
					local var_95_10 = manager.audio:GetVoiceLength("story_v_out_324131", "324131023", "story_v_out_324131.awb") / 1000

					if var_95_10 + var_95_4 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_10 + var_95_4
					end

					if var_95_6.prefab_name ~= "" and arg_92_1.actors_[var_95_6.prefab_name] ~= nil then
						local var_95_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_6.prefab_name].transform, "story_v_out_324131", "324131023", "story_v_out_324131.awb")

						arg_92_1:RecordAudio("324131023", var_95_11)
						arg_92_1:RecordAudio("324131023", var_95_11)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_out_324131", "324131023", "story_v_out_324131.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_out_324131", "324131023", "story_v_out_324131.awb")
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
	Play324131024 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 324131024
		arg_96_1.duration_ = 4.13

		local var_96_0 = {
			zh = 4,
			ja = 4.133
		}
		local var_96_1 = manager.audio:GetLocalizationFlag()

		if var_96_0[var_96_1] ~= nil then
			arg_96_1.duration_ = var_96_0[var_96_1]
		end

		SetActive(arg_96_1.tipsGo_, false)

		function arg_96_1.onSingleLineFinish_()
			arg_96_1.onSingleLineUpdate_ = nil
			arg_96_1.onSingleLineFinish_ = nil
			arg_96_1.state_ = "waiting"
		end

		function arg_96_1.playNext_(arg_98_0)
			if arg_98_0 == 1 then
				arg_96_0:Play324131025(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 and not isNil(arg_96_1.actors_["1053ui_story"]) and arg_96_1.var_.characterEffect1053ui_story == nil then
				arg_96_1.var_.characterEffect1053ui_story = arg_96_1.actors_["1053ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_0 = 0.200000002980232

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_0 and not isNil(arg_96_1.actors_["1053ui_story"]) then
				if arg_96_1.var_.characterEffect1053ui_story and not isNil(arg_96_1.actors_["1053ui_story"]) then
					arg_96_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_96_1.time_ >= 0 + var_99_0 and arg_96_1.time_ < 0 + var_99_0 + arg_99_0 and not isNil(arg_96_1.actors_["1053ui_story"]) and arg_96_1.var_.characterEffect1053ui_story then
				arg_96_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_99_2 = arg_96_1.actors_["1070ui_story"]

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 and not isNil(var_99_2) and arg_96_1.var_.characterEffect1070ui_story == nil then
				arg_96_1.var_.characterEffect1070ui_story = var_99_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_3 = 0.200000002980232

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_3 and not isNil(var_99_2) then
				if arg_96_1.var_.characterEffect1070ui_story and not isNil(var_99_2) then
					arg_96_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_96_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_96_1.time_ - 0) / var_99_3)
				end
			end

			if arg_96_1.time_ >= 0 + var_99_3 and arg_96_1.time_ < 0 + var_99_3 + arg_99_0 and not isNil(var_99_2) and arg_96_1.var_.characterEffect1070ui_story then
				arg_96_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_96_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053action/1053action7_1")
			end

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_99_4 = 0
			local var_99_5 = 0.325

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= var_99_4 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				arg_96_1.leftNameTxt_.text = arg_96_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_6 = arg_96_1:GetWordFromCfg(324131024)
				local var_99_7 = arg_96_1:FormatText(var_99_6.content)

				arg_96_1.text_.text = var_99_7

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_9 = 13 <= 0 and var_99_5 or var_99_5 * (utf8.len(var_99_7) / 13)

				if (13 <= 0 and var_99_5 or var_99_5 * (utf8.len(var_99_7) / 13)) > 0 and var_99_5 < var_99_9 then
					arg_96_1.talkMaxDuration = var_99_9

					if var_99_9 + var_99_4 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_9 + var_99_4
					end
				end

				arg_96_1.text_.text = var_99_7
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324131", "324131024", "story_v_out_324131.awb") ~= 0 then
					local var_99_10 = manager.audio:GetVoiceLength("story_v_out_324131", "324131024", "story_v_out_324131.awb") / 1000

					if var_99_10 + var_99_4 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_10 + var_99_4
					end

					if var_99_6.prefab_name ~= "" and arg_96_1.actors_[var_99_6.prefab_name] ~= nil then
						local var_99_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_6.prefab_name].transform, "story_v_out_324131", "324131024", "story_v_out_324131.awb")

						arg_96_1:RecordAudio("324131024", var_99_11)
						arg_96_1:RecordAudio("324131024", var_99_11)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_out_324131", "324131024", "story_v_out_324131.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_out_324131", "324131024", "story_v_out_324131.awb")
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
	Play324131025 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 324131025
		arg_100_1.duration_ = 10.1

		local var_100_0 = {
			zh = 9,
			ja = 10.1
		}
		local var_100_1 = manager.audio:GetLocalizationFlag()

		if var_100_0[var_100_1] ~= nil then
			arg_100_1.duration_ = var_100_0[var_100_1]
		end

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play324131026(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 and not isNil(arg_100_1.actors_["1070ui_story"]) and arg_100_1.var_.characterEffect1070ui_story == nil then
				arg_100_1.var_.characterEffect1070ui_story = arg_100_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_103_0 = 0.200000002980232

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_0 and not isNil(arg_100_1.actors_["1070ui_story"]) then
				if arg_100_1.var_.characterEffect1070ui_story and not isNil(arg_100_1.actors_["1070ui_story"]) then
					arg_100_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_100_1.time_ >= 0 + var_103_0 and arg_100_1.time_ < 0 + var_103_0 + arg_103_0 and not isNil(arg_100_1.actors_["1070ui_story"]) and arg_100_1.var_.characterEffect1070ui_story then
				arg_100_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_103_2 = arg_100_1.actors_["1053ui_story"]

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 and not isNil(var_103_2) and arg_100_1.var_.characterEffect1053ui_story == nil then
				arg_100_1.var_.characterEffect1053ui_story = var_103_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_103_3 = 0.200000002980232

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_3 and not isNil(var_103_2) then
				if arg_100_1.var_.characterEffect1053ui_story and not isNil(var_103_2) then
					arg_100_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_100_1.var_.characterEffect1053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_100_1.time_ - 0) / var_103_3)
				end
			end

			if arg_100_1.time_ >= 0 + var_103_3 and arg_100_1.time_ < 0 + var_103_3 + arg_103_0 and not isNil(var_103_2) and arg_100_1.var_.characterEffect1053ui_story then
				arg_100_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_100_1.var_.characterEffect1053ui_story.fillRatio = 0.5
			end

			local var_103_4 = 0
			local var_103_5 = 1.15

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= var_103_4 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				arg_100_1.leftNameTxt_.text = arg_100_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_6 = arg_100_1:GetWordFromCfg(324131025)
				local var_103_7 = arg_100_1:FormatText(var_103_6.content)

				arg_100_1.text_.text = var_103_7

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_9 = 46 <= 0 and var_103_5 or var_103_5 * (utf8.len(var_103_7) / 46)

				if (46 <= 0 and var_103_5 or var_103_5 * (utf8.len(var_103_7) / 46)) > 0 and var_103_5 < var_103_9 then
					arg_100_1.talkMaxDuration = var_103_9

					if var_103_9 + var_103_4 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_9 + var_103_4
					end
				end

				arg_100_1.text_.text = var_103_7
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324131", "324131025", "story_v_out_324131.awb") ~= 0 then
					local var_103_10 = manager.audio:GetVoiceLength("story_v_out_324131", "324131025", "story_v_out_324131.awb") / 1000

					if var_103_10 + var_103_4 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_10 + var_103_4
					end

					if var_103_6.prefab_name ~= "" and arg_100_1.actors_[var_103_6.prefab_name] ~= nil then
						local var_103_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_100_1.actors_[var_103_6.prefab_name].transform, "story_v_out_324131", "324131025", "story_v_out_324131.awb")

						arg_100_1:RecordAudio("324131025", var_103_11)
						arg_100_1:RecordAudio("324131025", var_103_11)
					else
						arg_100_1:AudioAction("play", "voice", "story_v_out_324131", "324131025", "story_v_out_324131.awb")
					end

					arg_100_1:RecordHistoryTalkVoice("story_v_out_324131", "324131025", "story_v_out_324131.awb")
				end

				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_12 = math.max(var_103_5, arg_100_1.talkMaxDuration)

			if var_103_4 <= arg_100_1.time_ and arg_100_1.time_ < var_103_4 + var_103_12 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_4) / var_103_12

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_4 + var_103_12 and arg_100_1.time_ < var_103_4 + var_103_12 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {}

		arg_100_1:InitPlayNodeList()
	end,
	Play324131026 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 324131026
		arg_104_1.duration_ = 22.27

		local var_104_0 = {
			zh = 14.033,
			ja = 22.266
		}
		local var_104_1 = manager.audio:GetLocalizationFlag()

		if var_104_0[var_104_1] ~= nil then
			arg_104_1.duration_ = var_104_0[var_104_1]
		end

		SetActive(arg_104_1.tipsGo_, false)

		function arg_104_1.onSingleLineFinish_()
			arg_104_1.onSingleLineUpdate_ = nil
			arg_104_1.onSingleLineFinish_ = nil
			arg_104_1.state_ = "waiting"
		end

		function arg_104_1.playNext_(arg_106_0)
			if arg_106_0 == 1 then
				arg_104_0:Play324131027(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			local var_107_0 = 1.525

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				arg_104_1.leftNameTxt_.text = arg_104_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_1 = arg_104_1:GetWordFromCfg(324131026)
				local var_107_2 = arg_104_1:FormatText(var_107_1.content)

				arg_104_1.text_.text = var_107_2

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_4 = 61 <= 0 and var_107_0 or var_107_0 * (utf8.len(var_107_2) / 61)

				if (61 <= 0 and var_107_0 or var_107_0 * (utf8.len(var_107_2) / 61)) > 0 and var_107_0 < var_107_4 then
					arg_104_1.talkMaxDuration = var_107_4

					if var_107_4 + 0 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_4 + 0
					end
				end

				arg_104_1.text_.text = var_107_2
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324131", "324131026", "story_v_out_324131.awb") ~= 0 then
					local var_107_5 = manager.audio:GetVoiceLength("story_v_out_324131", "324131026", "story_v_out_324131.awb") / 1000

					if var_107_5 + 0 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_5 + 0
					end

					if var_107_1.prefab_name ~= "" and arg_104_1.actors_[var_107_1.prefab_name] ~= nil then
						local var_107_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_1.prefab_name].transform, "story_v_out_324131", "324131026", "story_v_out_324131.awb")

						arg_104_1:RecordAudio("324131026", var_107_6)
						arg_104_1:RecordAudio("324131026", var_107_6)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_out_324131", "324131026", "story_v_out_324131.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_out_324131", "324131026", "story_v_out_324131.awb")
				end

				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_7 = math.max(var_107_0, arg_104_1.talkMaxDuration)

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_7 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - 0) / var_107_7

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= 0 + var_107_7 and arg_104_1.time_ < 0 + var_107_7 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {}

		arg_104_1:InitPlayNodeList()
	end,
	Play324131027 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 324131027
		arg_108_1.duration_ = 16.07

		local var_108_0 = {
			zh = 11.766,
			ja = 16.066
		}
		local var_108_1 = manager.audio:GetLocalizationFlag()

		if var_108_0[var_108_1] ~= nil then
			arg_108_1.duration_ = var_108_0[var_108_1]
		end

		SetActive(arg_108_1.tipsGo_, false)

		function arg_108_1.onSingleLineFinish_()
			arg_108_1.onSingleLineUpdate_ = nil
			arg_108_1.onSingleLineFinish_ = nil
			arg_108_1.state_ = "waiting"
		end

		function arg_108_1.playNext_(arg_110_0)
			if arg_110_0 == 1 then
				arg_108_0:Play324131028(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 then
				arg_108_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action4_1")
			end

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 then
				arg_108_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_111_0 = 0
			local var_111_1 = 0.95

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= var_111_0 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				arg_108_1.leftNameTxt_.text = arg_108_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_2 = arg_108_1:GetWordFromCfg(324131027)
				local var_111_3 = arg_108_1:FormatText(var_111_2.content)

				arg_108_1.text_.text = var_111_3

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_5 = 38 <= 0 and var_111_1 or var_111_1 * (utf8.len(var_111_3) / 38)

				if (38 <= 0 and var_111_1 or var_111_1 * (utf8.len(var_111_3) / 38)) > 0 and var_111_1 < var_111_5 then
					arg_108_1.talkMaxDuration = var_111_5

					if var_111_5 + var_111_0 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_5 + var_111_0
					end
				end

				arg_108_1.text_.text = var_111_3
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324131", "324131027", "story_v_out_324131.awb") ~= 0 then
					local var_111_6 = manager.audio:GetVoiceLength("story_v_out_324131", "324131027", "story_v_out_324131.awb") / 1000

					if var_111_6 + var_111_0 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_6 + var_111_0
					end

					if var_111_2.prefab_name ~= "" and arg_108_1.actors_[var_111_2.prefab_name] ~= nil then
						local var_111_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_108_1.actors_[var_111_2.prefab_name].transform, "story_v_out_324131", "324131027", "story_v_out_324131.awb")

						arg_108_1:RecordAudio("324131027", var_111_7)
						arg_108_1:RecordAudio("324131027", var_111_7)
					else
						arg_108_1:AudioAction("play", "voice", "story_v_out_324131", "324131027", "story_v_out_324131.awb")
					end

					arg_108_1:RecordHistoryTalkVoice("story_v_out_324131", "324131027", "story_v_out_324131.awb")
				end

				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_8 = math.max(var_111_1, arg_108_1.talkMaxDuration)

			if var_111_0 <= arg_108_1.time_ and arg_108_1.time_ < var_111_0 + var_111_8 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_0) / var_111_8

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_0 + var_111_8 and arg_108_1.time_ < var_111_0 + var_111_8 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {}

		arg_108_1:InitPlayNodeList()
	end,
	Play324131028 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 324131028
		arg_112_1.duration_ = 2

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play324131029(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 and not isNil(arg_112_1.actors_["1053ui_story"]) and arg_112_1.var_.characterEffect1053ui_story == nil then
				arg_112_1.var_.characterEffect1053ui_story = arg_112_1.actors_["1053ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_115_0 = 0.200000002980232

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_0 and not isNil(arg_112_1.actors_["1053ui_story"]) then
				if arg_112_1.var_.characterEffect1053ui_story and not isNil(arg_112_1.actors_["1053ui_story"]) then
					arg_112_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_112_1.time_ >= 0 + var_115_0 and arg_112_1.time_ < 0 + var_115_0 + arg_115_0 and not isNil(arg_112_1.actors_["1053ui_story"]) and arg_112_1.var_.characterEffect1053ui_story then
				arg_112_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_115_2 = arg_112_1.actors_["1070ui_story"]

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 and not isNil(var_115_2) and arg_112_1.var_.characterEffect1070ui_story == nil then
				arg_112_1.var_.characterEffect1070ui_story = var_115_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_115_3 = 0.200000002980232

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_3 and not isNil(var_115_2) then
				if arg_112_1.var_.characterEffect1070ui_story and not isNil(var_115_2) then
					arg_112_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_112_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_112_1.time_ - 0) / var_115_3)
				end
			end

			if arg_112_1.time_ >= 0 + var_115_3 and arg_112_1.time_ < 0 + var_115_3 + arg_115_0 and not isNil(var_115_2) and arg_112_1.var_.characterEffect1070ui_story then
				arg_112_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_112_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
				arg_112_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053actionlink/1053action476")
			end

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
				arg_112_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_115_4 = 0
			local var_115_5 = 0.05

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= var_115_4 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				arg_112_1.leftNameTxt_.text = arg_112_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_6 = arg_112_1:GetWordFromCfg(324131028)
				local var_115_7 = arg_112_1:FormatText(var_115_6.content)

				arg_112_1.text_.text = var_115_7

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_9 = 2 <= 0 and var_115_5 or var_115_5 * (utf8.len(var_115_7) / 2)

				if (2 <= 0 and var_115_5 or var_115_5 * (utf8.len(var_115_7) / 2)) > 0 and var_115_5 < var_115_9 then
					arg_112_1.talkMaxDuration = var_115_9

					if var_115_9 + var_115_4 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_9 + var_115_4
					end
				end

				arg_112_1.text_.text = var_115_7
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324131", "324131028", "story_v_out_324131.awb") ~= 0 then
					local var_115_10 = manager.audio:GetVoiceLength("story_v_out_324131", "324131028", "story_v_out_324131.awb") / 1000

					if var_115_10 + var_115_4 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_10 + var_115_4
					end

					if var_115_6.prefab_name ~= "" and arg_112_1.actors_[var_115_6.prefab_name] ~= nil then
						local var_115_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_6.prefab_name].transform, "story_v_out_324131", "324131028", "story_v_out_324131.awb")

						arg_112_1:RecordAudio("324131028", var_115_11)
						arg_112_1:RecordAudio("324131028", var_115_11)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_out_324131", "324131028", "story_v_out_324131.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_out_324131", "324131028", "story_v_out_324131.awb")
				end

				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_12 = math.max(var_115_5, arg_112_1.talkMaxDuration)

			if var_115_4 <= arg_112_1.time_ and arg_112_1.time_ < var_115_4 + var_115_12 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_4) / var_115_12

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_4 + var_115_12 and arg_112_1.time_ < var_115_4 + var_115_12 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {}

		arg_112_1:InitPlayNodeList()
	end,
	Play324131029 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 324131029
		arg_116_1.duration_ = 5

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play324131030(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				arg_116_1.var_.moveOldPos1070ui_story = arg_116_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_119_0 = 0.001

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_0 then
				arg_116_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_116_1.var_.moveOldPos1070ui_story, Vector3.New(0, 100, 0), (arg_116_1.time_ - 0) / var_119_0)
				arg_116_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_116_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_116_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_116_1.actors_["1070ui_story"].transform.position).z)
				arg_116_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_116_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_116_1.actors_["1070ui_story"].transform.localEulerAngles = arg_116_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_116_1.time_ >= 0 + var_119_0 and arg_116_1.time_ < 0 + var_119_0 + arg_119_0 then
				arg_116_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_116_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_116_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_116_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_116_1.actors_["1070ui_story"].transform.position).z)
				arg_116_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_116_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_116_1.actors_["1070ui_story"].transform.localEulerAngles = arg_116_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_119_1 = arg_116_1.actors_["1053ui_story"].transform

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				arg_116_1.var_.moveOldPos1053ui_story = var_119_1.localPosition

				local var_119_2 = GameObjectTools.GetOrAddComponent(var_119_1.gameObject, typeof(DynamicBoneHelper))

				if var_119_2 then
					var_119_2:EnableDynamicBone(false)
				end
			end

			local var_119_3 = 0.001

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_3 then
				var_119_1.localPosition = Vector3.Lerp(arg_116_1.var_.moveOldPos1053ui_story, Vector3.New(0, 100, 0), (arg_116_1.time_ - 0) / var_119_3)
				var_119_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_119_1.position).x, (manager.ui.mainCamera.transform.position - var_119_1.position).y, (manager.ui.mainCamera.transform.position - var_119_1.position).z)
				var_119_1.localEulerAngles.z = 0
				var_119_1.localEulerAngles.x = 0
				var_119_1.localEulerAngles = var_119_1.localEulerAngles
			end

			if arg_116_1.time_ >= 0 + var_119_3 and arg_116_1.time_ < 0 + var_119_3 + arg_119_0 then
				var_119_1.localPosition = Vector3.New(0, 100, 0)
				var_119_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_119_1.position).x, (manager.ui.mainCamera.transform.position - var_119_1.position).y, (manager.ui.mainCamera.transform.position - var_119_1.position).z)
				var_119_1.localEulerAngles.z = 0
				var_119_1.localEulerAngles.x = 0
				var_119_1.localEulerAngles = var_119_1.localEulerAngles

				local var_119_4 = GameObjectTools.GetOrAddComponent(var_119_1.gameObject, typeof(DynamicBoneHelper))

				if var_119_4 then
					var_119_4:EnableDynamicBone(true)
				end
			end

			local var_119_5 = arg_116_1.actors_["1053ui_story"]

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 and not isNil(var_119_5) and arg_116_1.var_.characterEffect1053ui_story == nil then
				arg_116_1.var_.characterEffect1053ui_story = var_119_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_119_6 = 0.200000002980232

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_6 and not isNil(var_119_5) then
				if arg_116_1.var_.characterEffect1053ui_story and not isNil(var_119_5) then
					arg_116_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_116_1.var_.characterEffect1053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_116_1.time_ - 0) / var_119_6)
				end
			end

			if arg_116_1.time_ >= 0 + var_119_6 and arg_116_1.time_ < 0 + var_119_6 + arg_119_0 and not isNil(var_119_5) and arg_116_1.var_.characterEffect1053ui_story then
				arg_116_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_116_1.var_.characterEffect1053ui_story.fillRatio = 0.5
			end

			local var_119_7 = 0
			local var_119_8 = 0.925

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= var_119_7 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, false)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_9 = arg_116_1:FormatText(arg_116_1:GetWordFromCfg(324131029).content)

				arg_116_1.text_.text = var_119_9

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_11 = 37 <= 0 and var_119_8 or var_119_8 * (utf8.len(var_119_9) / 37)

				if (37 <= 0 and var_119_8 or var_119_8 * (utf8.len(var_119_9) / 37)) > 0 and var_119_8 < var_119_11 then
					arg_116_1.talkMaxDuration = var_119_11

					if var_119_11 + var_119_7 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_11 + var_119_7
					end
				end

				arg_116_1.text_.text = var_119_9
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)
				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_12 = math.max(var_119_8, arg_116_1.talkMaxDuration)

			if var_119_7 <= arg_116_1.time_ and arg_116_1.time_ < var_119_7 + var_119_12 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_7) / var_119_12

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_7 + var_119_12 and arg_116_1.time_ < var_119_7 + var_119_12 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_116_1:InitPlayNodeList()
	end,
	Play324131030 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 324131030
		arg_120_1.duration_ = 5

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play324131031(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			if 0.4 < arg_120_1.time_ and arg_120_1.time_ <= 0.4 + arg_123_0 then
				arg_120_1:AudioAction("play", "effect", "se_story_120", "se_story_120_clap", "")
			end

			if 0.4 < arg_120_1.time_ and arg_120_1.time_ <= 0.4 + arg_123_0 then
				arg_120_1:AudioAction("play", "effect", "se_story_141", "se_story_141_footstep_walk02", "")
			end

			local var_123_2 = 0
			local var_123_3 = 0.75

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= var_123_2 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, false)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_4 = arg_120_1:FormatText(arg_120_1:GetWordFromCfg(324131030).content)

				arg_120_1.text_.text = var_123_4

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_6 = 30 <= 0 and var_123_3 or var_123_3 * (utf8.len(var_123_4) / 30)

				if (30 <= 0 and var_123_3 or var_123_3 * (utf8.len(var_123_4) / 30)) > 0 and var_123_3 < var_123_6 then
					arg_120_1.talkMaxDuration = var_123_6

					if var_123_6 + var_123_2 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_6 + var_123_2
					end
				end

				arg_120_1.text_.text = var_123_4
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)
				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_7 = math.max(var_123_3, arg_120_1.talkMaxDuration)

			if var_123_2 <= arg_120_1.time_ and arg_120_1.time_ < var_123_2 + var_123_7 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_2) / var_123_7

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_2 + var_123_7 and arg_120_1.time_ < var_123_2 + var_123_7 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {}

		arg_120_1:InitPlayNodeList()
	end,
	Play324131031 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 324131031
		arg_124_1.duration_ = 11.23

		local var_124_0 = {
			zh = 7.5,
			ja = 11.233
		}
		local var_124_1 = manager.audio:GetLocalizationFlag()

		if var_124_0[var_124_1] ~= nil then
			arg_124_1.duration_ = var_124_0[var_124_1]
		end

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play324131032(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1.var_.moveOldPos1053ui_story = arg_124_1.actors_["1053ui_story"].transform.localPosition

				local var_127_0 = GameObjectTools.GetOrAddComponent(arg_124_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_127_0 then
					var_127_0:EnableDynamicBone(false)
				end
			end

			local var_127_1 = 0.001

			if 0 <= arg_124_1.time_ and arg_124_1.time_ < 0 + var_127_1 then
				arg_124_1.actors_["1053ui_story"].transform.localPosition = Vector3.Lerp(arg_124_1.var_.moveOldPos1053ui_story, Vector3.New(0.7, -1.08, -6), (arg_124_1.time_ - 0) / var_127_1)
				arg_124_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_124_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_124_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_124_1.actors_["1053ui_story"].transform.position).z)
				arg_124_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_124_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_124_1.actors_["1053ui_story"].transform.localEulerAngles = arg_124_1.actors_["1053ui_story"].transform.localEulerAngles
			end

			if arg_124_1.time_ >= 0 + var_127_1 and arg_124_1.time_ < 0 + var_127_1 + arg_127_0 then
				arg_124_1.actors_["1053ui_story"].transform.localPosition = Vector3.New(0.7, -1.08, -6)
				arg_124_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_124_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_124_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_124_1.actors_["1053ui_story"].transform.position).z)
				arg_124_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_124_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_124_1.actors_["1053ui_story"].transform.localEulerAngles = arg_124_1.actors_["1053ui_story"].transform.localEulerAngles

				local var_127_2 = GameObjectTools.GetOrAddComponent(arg_124_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_127_2 then
					var_127_2:EnableDynamicBone(true)
				end
			end

			local var_127_3 = arg_124_1.actors_["1053ui_story"]

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 and not isNil(var_127_3) and arg_124_1.var_.characterEffect1053ui_story == nil then
				arg_124_1.var_.characterEffect1053ui_story = var_127_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_127_4 = 0.200000002980232

			if 0 <= arg_124_1.time_ and arg_124_1.time_ < 0 + var_127_4 and not isNil(var_127_3) then
				if arg_124_1.var_.characterEffect1053ui_story and not isNil(var_127_3) then
					arg_124_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_124_1.time_ >= 0 + var_127_4 and arg_124_1.time_ < 0 + var_127_4 + arg_127_0 and not isNil(var_127_3) and arg_124_1.var_.characterEffect1053ui_story then
				arg_124_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053actionlink/1053action465")
			end

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_127_6 = 0
			local var_127_7 = 0.725

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= var_127_6 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				arg_124_1.leftNameTxt_.text = arg_124_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_8 = arg_124_1:GetWordFromCfg(324131031)
				local var_127_9 = arg_124_1:FormatText(var_127_8.content)

				arg_124_1.text_.text = var_127_9

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_11 = 29 <= 0 and var_127_7 or var_127_7 * (utf8.len(var_127_9) / 29)

				if (29 <= 0 and var_127_7 or var_127_7 * (utf8.len(var_127_9) / 29)) > 0 and var_127_7 < var_127_11 then
					arg_124_1.talkMaxDuration = var_127_11

					if var_127_11 + var_127_6 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_11 + var_127_6
					end
				end

				arg_124_1.text_.text = var_127_9
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324131", "324131031", "story_v_out_324131.awb") ~= 0 then
					local var_127_12 = manager.audio:GetVoiceLength("story_v_out_324131", "324131031", "story_v_out_324131.awb") / 1000

					if var_127_12 + var_127_6 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_12 + var_127_6
					end

					if var_127_8.prefab_name ~= "" and arg_124_1.actors_[var_127_8.prefab_name] ~= nil then
						local var_127_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_124_1.actors_[var_127_8.prefab_name].transform, "story_v_out_324131", "324131031", "story_v_out_324131.awb")

						arg_124_1:RecordAudio("324131031", var_127_13)
						arg_124_1:RecordAudio("324131031", var_127_13)
					else
						arg_124_1:AudioAction("play", "voice", "story_v_out_324131", "324131031", "story_v_out_324131.awb")
					end

					arg_124_1:RecordHistoryTalkVoice("story_v_out_324131", "324131031", "story_v_out_324131.awb")
				end

				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_14 = math.max(var_127_7, arg_124_1.talkMaxDuration)

			if var_127_6 <= arg_124_1.time_ and arg_124_1.time_ < var_127_6 + var_127_14 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_6) / var_127_14

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_6 + var_127_14 and arg_124_1.time_ < var_127_6 + var_127_14 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_124_1:InitPlayNodeList()
	end,
	Play324131032 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 324131032
		arg_128_1.duration_ = 10.13

		local var_128_0 = {
			zh = 10.133,
			ja = 9.8
		}
		local var_128_1 = manager.audio:GetLocalizationFlag()

		if var_128_0[var_128_1] ~= nil then
			arg_128_1.duration_ = var_128_0[var_128_1]
		end

		SetActive(arg_128_1.tipsGo_, false)

		function arg_128_1.onSingleLineFinish_()
			arg_128_1.onSingleLineUpdate_ = nil
			arg_128_1.onSingleLineFinish_ = nil
			arg_128_1.state_ = "waiting"
		end

		function arg_128_1.playNext_(arg_130_0)
			if arg_130_0 == 1 then
				arg_128_0:Play324131033(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				arg_128_1.var_.moveOldPos1070ui_story = arg_128_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_131_0 = 0.001

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_0 then
				arg_128_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_128_1.var_.moveOldPos1070ui_story, Vector3.New(-0.7, -0.95, -6.05), (arg_128_1.time_ - 0) / var_131_0)
				arg_128_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_128_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_128_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_128_1.actors_["1070ui_story"].transform.position).z)
				arg_128_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_128_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_128_1.actors_["1070ui_story"].transform.localEulerAngles = arg_128_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_128_1.time_ >= 0 + var_131_0 and arg_128_1.time_ < 0 + var_131_0 + arg_131_0 then
				arg_128_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(-0.7, -0.95, -6.05)
				arg_128_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_128_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_128_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_128_1.actors_["1070ui_story"].transform.position).z)
				arg_128_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_128_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_128_1.actors_["1070ui_story"].transform.localEulerAngles = arg_128_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_131_1 = arg_128_1.actors_["1070ui_story"]

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 and not isNil(var_131_1) and arg_128_1.var_.characterEffect1070ui_story == nil then
				arg_128_1.var_.characterEffect1070ui_story = var_131_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_131_2 = 0.200000002980232

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_2 and not isNil(var_131_1) then
				if arg_128_1.var_.characterEffect1070ui_story and not isNil(var_131_1) then
					arg_128_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_128_1.time_ >= 0 + var_131_2 and arg_128_1.time_ < 0 + var_131_2 + arg_131_0 and not isNil(var_131_1) and arg_128_1.var_.characterEffect1070ui_story then
				arg_128_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_131_4 = arg_128_1.actors_["1053ui_story"]

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 and not isNil(var_131_4) and arg_128_1.var_.characterEffect1053ui_story == nil then
				arg_128_1.var_.characterEffect1053ui_story = var_131_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_131_5 = 0.200000002980232

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_5 and not isNil(var_131_4) then
				if arg_128_1.var_.characterEffect1053ui_story and not isNil(var_131_4) then
					arg_128_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_128_1.var_.characterEffect1053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_128_1.time_ - 0) / var_131_5)
				end
			end

			if arg_128_1.time_ >= 0 + var_131_5 and arg_128_1.time_ < 0 + var_131_5 + arg_131_0 and not isNil(var_131_4) and arg_128_1.var_.characterEffect1053ui_story then
				arg_128_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_128_1.var_.characterEffect1053ui_story.fillRatio = 0.5
			end

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				arg_128_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070actionlink/1070action446")
			end

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				arg_128_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_131_6 = 0
			local var_131_7 = 1.025

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= var_131_6 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				arg_128_1.leftNameTxt_.text = arg_128_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_8 = arg_128_1:GetWordFromCfg(324131032)
				local var_131_9 = arg_128_1:FormatText(var_131_8.content)

				arg_128_1.text_.text = var_131_9

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_11 = 41 <= 0 and var_131_7 or var_131_7 * (utf8.len(var_131_9) / 41)

				if (41 <= 0 and var_131_7 or var_131_7 * (utf8.len(var_131_9) / 41)) > 0 and var_131_7 < var_131_11 then
					arg_128_1.talkMaxDuration = var_131_11

					if var_131_11 + var_131_6 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_11 + var_131_6
					end
				end

				arg_128_1.text_.text = var_131_9
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324131", "324131032", "story_v_out_324131.awb") ~= 0 then
					local var_131_12 = manager.audio:GetVoiceLength("story_v_out_324131", "324131032", "story_v_out_324131.awb") / 1000

					if var_131_12 + var_131_6 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_12 + var_131_6
					end

					if var_131_8.prefab_name ~= "" and arg_128_1.actors_[var_131_8.prefab_name] ~= nil then
						local var_131_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_8.prefab_name].transform, "story_v_out_324131", "324131032", "story_v_out_324131.awb")

						arg_128_1:RecordAudio("324131032", var_131_13)
						arg_128_1:RecordAudio("324131032", var_131_13)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_out_324131", "324131032", "story_v_out_324131.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_out_324131", "324131032", "story_v_out_324131.awb")
				end

				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_14 = math.max(var_131_7, arg_128_1.talkMaxDuration)

			if var_131_6 <= arg_128_1.time_ and arg_128_1.time_ < var_131_6 + var_131_14 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_6) / var_131_14

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_6 + var_131_14 and arg_128_1.time_ < var_131_6 + var_131_14 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_128_1:InitPlayNodeList()
	end,
	Play324131033 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 324131033
		arg_132_1.duration_ = 9

		local var_132_0 = {
			zh = 8.233,
			ja = 9
		}
		local var_132_1 = manager.audio:GetLocalizationFlag()

		if var_132_0[var_132_1] ~= nil then
			arg_132_1.duration_ = var_132_0[var_132_1]
		end

		SetActive(arg_132_1.tipsGo_, false)

		function arg_132_1.onSingleLineFinish_()
			arg_132_1.onSingleLineUpdate_ = nil
			arg_132_1.onSingleLineFinish_ = nil
			arg_132_1.state_ = "waiting"
		end

		function arg_132_1.playNext_(arg_134_0)
			if arg_134_0 == 1 then
				arg_132_0:Play324131034(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			local var_135_0 = 0.825

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				arg_132_1.leftNameTxt_.text = arg_132_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_1 = arg_132_1:GetWordFromCfg(324131033)
				local var_135_2 = arg_132_1:FormatText(var_135_1.content)

				arg_132_1.text_.text = var_135_2

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_4 = 33 <= 0 and var_135_0 or var_135_0 * (utf8.len(var_135_2) / 33)

				if (33 <= 0 and var_135_0 or var_135_0 * (utf8.len(var_135_2) / 33)) > 0 and var_135_0 < var_135_4 then
					arg_132_1.talkMaxDuration = var_135_4

					if var_135_4 + 0 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_4 + 0
					end
				end

				arg_132_1.text_.text = var_135_2
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324131", "324131033", "story_v_out_324131.awb") ~= 0 then
					local var_135_5 = manager.audio:GetVoiceLength("story_v_out_324131", "324131033", "story_v_out_324131.awb") / 1000

					if var_135_5 + 0 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_5 + 0
					end

					if var_135_1.prefab_name ~= "" and arg_132_1.actors_[var_135_1.prefab_name] ~= nil then
						local var_135_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_1.prefab_name].transform, "story_v_out_324131", "324131033", "story_v_out_324131.awb")

						arg_132_1:RecordAudio("324131033", var_135_6)
						arg_132_1:RecordAudio("324131033", var_135_6)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_out_324131", "324131033", "story_v_out_324131.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_out_324131", "324131033", "story_v_out_324131.awb")
				end

				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_7 = math.max(var_135_0, arg_132_1.talkMaxDuration)

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_7 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - 0) / var_135_7

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= 0 + var_135_7 and arg_132_1.time_ < 0 + var_135_7 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {}

		arg_132_1:InitPlayNodeList()
	end,
	Play324131034 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 324131034
		arg_136_1.duration_ = 3.17

		local var_136_0 = {
			zh = 2.6,
			ja = 3.166
		}
		local var_136_1 = manager.audio:GetLocalizationFlag()

		if var_136_0[var_136_1] ~= nil then
			arg_136_1.duration_ = var_136_0[var_136_1]
		end

		SetActive(arg_136_1.tipsGo_, false)

		function arg_136_1.onSingleLineFinish_()
			arg_136_1.onSingleLineUpdate_ = nil
			arg_136_1.onSingleLineFinish_ = nil
			arg_136_1.state_ = "waiting"
		end

		function arg_136_1.playNext_(arg_138_0)
			if arg_138_0 == 1 then
				arg_136_0:Play324131035(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 and not isNil(arg_136_1.actors_["1053ui_story"]) and arg_136_1.var_.characterEffect1053ui_story == nil then
				arg_136_1.var_.characterEffect1053ui_story = arg_136_1.actors_["1053ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_139_0 = 0.200000002980232

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_0 and not isNil(arg_136_1.actors_["1053ui_story"]) then
				if arg_136_1.var_.characterEffect1053ui_story and not isNil(arg_136_1.actors_["1053ui_story"]) then
					arg_136_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_136_1.time_ >= 0 + var_139_0 and arg_136_1.time_ < 0 + var_139_0 + arg_139_0 and not isNil(arg_136_1.actors_["1053ui_story"]) and arg_136_1.var_.characterEffect1053ui_story then
				arg_136_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_139_2 = arg_136_1.actors_["1070ui_story"]

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 and not isNil(var_139_2) and arg_136_1.var_.characterEffect1070ui_story == nil then
				arg_136_1.var_.characterEffect1070ui_story = var_139_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_139_3 = 0.200000002980232

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_3 and not isNil(var_139_2) then
				if arg_136_1.var_.characterEffect1070ui_story and not isNil(var_139_2) then
					arg_136_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_136_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_136_1.time_ - 0) / var_139_3)
				end
			end

			if arg_136_1.time_ >= 0 + var_139_3 and arg_136_1.time_ < 0 + var_139_3 + arg_139_0 and not isNil(var_139_2) and arg_136_1.var_.characterEffect1070ui_story then
				arg_136_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_136_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 then
				arg_136_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053action/1053action5_2")
			end

			local var_139_4 = 0
			local var_139_5 = 0.225

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= var_139_4 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				arg_136_1.leftNameTxt_.text = arg_136_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_6 = arg_136_1:GetWordFromCfg(324131034)
				local var_139_7 = arg_136_1:FormatText(var_139_6.content)

				arg_136_1.text_.text = var_139_7

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_9 = 9 <= 0 and var_139_5 or var_139_5 * (utf8.len(var_139_7) / 9)

				if (9 <= 0 and var_139_5 or var_139_5 * (utf8.len(var_139_7) / 9)) > 0 and var_139_5 < var_139_9 then
					arg_136_1.talkMaxDuration = var_139_9

					if var_139_9 + var_139_4 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_9 + var_139_4
					end
				end

				arg_136_1.text_.text = var_139_7
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324131", "324131034", "story_v_out_324131.awb") ~= 0 then
					local var_139_10 = manager.audio:GetVoiceLength("story_v_out_324131", "324131034", "story_v_out_324131.awb") / 1000

					if var_139_10 + var_139_4 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_10 + var_139_4
					end

					if var_139_6.prefab_name ~= "" and arg_136_1.actors_[var_139_6.prefab_name] ~= nil then
						local var_139_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_136_1.actors_[var_139_6.prefab_name].transform, "story_v_out_324131", "324131034", "story_v_out_324131.awb")

						arg_136_1:RecordAudio("324131034", var_139_11)
						arg_136_1:RecordAudio("324131034", var_139_11)
					else
						arg_136_1:AudioAction("play", "voice", "story_v_out_324131", "324131034", "story_v_out_324131.awb")
					end

					arg_136_1:RecordHistoryTalkVoice("story_v_out_324131", "324131034", "story_v_out_324131.awb")
				end

				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_12 = math.max(var_139_5, arg_136_1.talkMaxDuration)

			if var_139_4 <= arg_136_1.time_ and arg_136_1.time_ < var_139_4 + var_139_12 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_4) / var_139_12

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_4 + var_139_12 and arg_136_1.time_ < var_139_4 + var_139_12 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {}

		arg_136_1:InitPlayNodeList()
	end,
	Play324131035 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 324131035
		arg_140_1.duration_ = 17.2

		local var_140_0 = {
			zh = 11.466,
			ja = 17.2
		}
		local var_140_1 = manager.audio:GetLocalizationFlag()

		if var_140_0[var_140_1] ~= nil then
			arg_140_1.duration_ = var_140_0[var_140_1]
		end

		SetActive(arg_140_1.tipsGo_, false)

		function arg_140_1.onSingleLineFinish_()
			arg_140_1.onSingleLineUpdate_ = nil
			arg_140_1.onSingleLineFinish_ = nil
			arg_140_1.state_ = "waiting"
		end

		function arg_140_1.playNext_(arg_142_0)
			if arg_142_0 == 1 then
				arg_140_0:Play324131036(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 and not isNil(arg_140_1.actors_["1070ui_story"]) and arg_140_1.var_.characterEffect1070ui_story == nil then
				arg_140_1.var_.characterEffect1070ui_story = arg_140_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_143_0 = 0.200000002980232

			if 0 <= arg_140_1.time_ and arg_140_1.time_ < 0 + var_143_0 and not isNil(arg_140_1.actors_["1070ui_story"]) then
				if arg_140_1.var_.characterEffect1070ui_story and not isNil(arg_140_1.actors_["1070ui_story"]) then
					arg_140_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_140_1.time_ >= 0 + var_143_0 and arg_140_1.time_ < 0 + var_143_0 + arg_143_0 and not isNil(arg_140_1.actors_["1070ui_story"]) and arg_140_1.var_.characterEffect1070ui_story then
				arg_140_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_143_2 = arg_140_1.actors_["1053ui_story"]

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 and not isNil(var_143_2) and arg_140_1.var_.characterEffect1053ui_story == nil then
				arg_140_1.var_.characterEffect1053ui_story = var_143_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_143_3 = 0.200000002980232

			if 0 <= arg_140_1.time_ and arg_140_1.time_ < 0 + var_143_3 and not isNil(var_143_2) then
				if arg_140_1.var_.characterEffect1053ui_story and not isNil(var_143_2) then
					arg_140_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_140_1.var_.characterEffect1053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_140_1.time_ - 0) / var_143_3)
				end
			end

			if arg_140_1.time_ >= 0 + var_143_3 and arg_140_1.time_ < 0 + var_143_3 + arg_143_0 and not isNil(var_143_2) and arg_140_1.var_.characterEffect1053ui_story then
				arg_140_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_140_1.var_.characterEffect1053ui_story.fillRatio = 0.5
			end

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 then
				arg_140_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action6_2")
			end

			local var_143_4 = 0
			local var_143_5 = 1.175

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= var_143_4 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				arg_140_1.leftNameTxt_.text = arg_140_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, false)
				arg_140_1.callingController_:SetSelectedState("normal")

				local var_143_6 = arg_140_1:GetWordFromCfg(324131035)
				local var_143_7 = arg_140_1:FormatText(var_143_6.content)

				arg_140_1.text_.text = var_143_7

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_9 = 47 <= 0 and var_143_5 or var_143_5 * (utf8.len(var_143_7) / 47)

				if (47 <= 0 and var_143_5 or var_143_5 * (utf8.len(var_143_7) / 47)) > 0 and var_143_5 < var_143_9 then
					arg_140_1.talkMaxDuration = var_143_9

					if var_143_9 + var_143_4 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_9 + var_143_4
					end
				end

				arg_140_1.text_.text = var_143_7
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324131", "324131035", "story_v_out_324131.awb") ~= 0 then
					local var_143_10 = manager.audio:GetVoiceLength("story_v_out_324131", "324131035", "story_v_out_324131.awb") / 1000

					if var_143_10 + var_143_4 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_10 + var_143_4
					end

					if var_143_6.prefab_name ~= "" and arg_140_1.actors_[var_143_6.prefab_name] ~= nil then
						local var_143_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_140_1.actors_[var_143_6.prefab_name].transform, "story_v_out_324131", "324131035", "story_v_out_324131.awb")

						arg_140_1:RecordAudio("324131035", var_143_11)
						arg_140_1:RecordAudio("324131035", var_143_11)
					else
						arg_140_1:AudioAction("play", "voice", "story_v_out_324131", "324131035", "story_v_out_324131.awb")
					end

					arg_140_1:RecordHistoryTalkVoice("story_v_out_324131", "324131035", "story_v_out_324131.awb")
				end

				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_12 = math.max(var_143_5, arg_140_1.talkMaxDuration)

			if var_143_4 <= arg_140_1.time_ and arg_140_1.time_ < var_143_4 + var_143_12 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_4) / var_143_12

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_4 + var_143_12 and arg_140_1.time_ < var_143_4 + var_143_12 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {}

		arg_140_1:InitPlayNodeList()
	end,
	Play324131036 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 324131036
		arg_144_1.duration_ = 5.4

		local var_144_0 = {
			zh = 3.033,
			ja = 5.4
		}
		local var_144_1 = manager.audio:GetLocalizationFlag()

		if var_144_0[var_144_1] ~= nil then
			arg_144_1.duration_ = var_144_0[var_144_1]
		end

		SetActive(arg_144_1.tipsGo_, false)

		function arg_144_1.onSingleLineFinish_()
			arg_144_1.onSingleLineUpdate_ = nil
			arg_144_1.onSingleLineFinish_ = nil
			arg_144_1.state_ = "waiting"
		end

		function arg_144_1.playNext_(arg_146_0)
			if arg_146_0 == 1 then
				arg_144_0:Play324131037(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			local var_147_0 = 0.225

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				arg_144_1.leftNameTxt_.text = arg_144_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, false)
				arg_144_1.callingController_:SetSelectedState("normal")

				local var_147_1 = arg_144_1:GetWordFromCfg(324131036)
				local var_147_2 = arg_144_1:FormatText(var_147_1.content)

				arg_144_1.text_.text = var_147_2

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_4 = 9 <= 0 and var_147_0 or var_147_0 * (utf8.len(var_147_2) / 9)

				if (9 <= 0 and var_147_0 or var_147_0 * (utf8.len(var_147_2) / 9)) > 0 and var_147_0 < var_147_4 then
					arg_144_1.talkMaxDuration = var_147_4

					if var_147_4 + 0 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_4 + 0
					end
				end

				arg_144_1.text_.text = var_147_2
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324131", "324131036", "story_v_out_324131.awb") ~= 0 then
					local var_147_5 = manager.audio:GetVoiceLength("story_v_out_324131", "324131036", "story_v_out_324131.awb") / 1000

					if var_147_5 + 0 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_5 + 0
					end

					if var_147_1.prefab_name ~= "" and arg_144_1.actors_[var_147_1.prefab_name] ~= nil then
						local var_147_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_144_1.actors_[var_147_1.prefab_name].transform, "story_v_out_324131", "324131036", "story_v_out_324131.awb")

						arg_144_1:RecordAudio("324131036", var_147_6)
						arg_144_1:RecordAudio("324131036", var_147_6)
					else
						arg_144_1:AudioAction("play", "voice", "story_v_out_324131", "324131036", "story_v_out_324131.awb")
					end

					arg_144_1:RecordHistoryTalkVoice("story_v_out_324131", "324131036", "story_v_out_324131.awb")
				end

				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_7 = math.max(var_147_0, arg_144_1.talkMaxDuration)

			if 0 <= arg_144_1.time_ and arg_144_1.time_ < 0 + var_147_7 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - 0) / var_147_7

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= 0 + var_147_7 and arg_144_1.time_ < 0 + var_147_7 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {}

		arg_144_1:InitPlayNodeList()
	end,
	Play324131037 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 324131037
		arg_148_1.duration_ = 5

		SetActive(arg_148_1.tipsGo_, false)

		function arg_148_1.onSingleLineFinish_()
			arg_148_1.onSingleLineUpdate_ = nil
			arg_148_1.onSingleLineFinish_ = nil
			arg_148_1.state_ = "waiting"
		end

		function arg_148_1.playNext_(arg_150_0)
			if arg_150_0 == 1 then
				arg_148_0:Play324131038(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 then
				arg_148_1.var_.moveOldPos1070ui_story = arg_148_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_151_0 = 0.001

			if 0 <= arg_148_1.time_ and arg_148_1.time_ < 0 + var_151_0 then
				arg_148_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_148_1.var_.moveOldPos1070ui_story, Vector3.New(0, 100, 0), (arg_148_1.time_ - 0) / var_151_0)
				arg_148_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_148_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_148_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_148_1.actors_["1070ui_story"].transform.position).z)
				arg_148_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_148_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_148_1.actors_["1070ui_story"].transform.localEulerAngles = arg_148_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_148_1.time_ >= 0 + var_151_0 and arg_148_1.time_ < 0 + var_151_0 + arg_151_0 then
				arg_148_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_148_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_148_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_148_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_148_1.actors_["1070ui_story"].transform.position).z)
				arg_148_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_148_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_148_1.actors_["1070ui_story"].transform.localEulerAngles = arg_148_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_151_1 = arg_148_1.actors_["1053ui_story"].transform

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 then
				arg_148_1.var_.moveOldPos1053ui_story = var_151_1.localPosition

				local var_151_2 = GameObjectTools.GetOrAddComponent(var_151_1.gameObject, typeof(DynamicBoneHelper))

				if var_151_2 then
					var_151_2:EnableDynamicBone(false)
				end
			end

			local var_151_3 = 0.001

			if 0 <= arg_148_1.time_ and arg_148_1.time_ < 0 + var_151_3 then
				var_151_1.localPosition = Vector3.Lerp(arg_148_1.var_.moveOldPos1053ui_story, Vector3.New(0, 100, 0), (arg_148_1.time_ - 0) / var_151_3)
				var_151_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_151_1.position).x, (manager.ui.mainCamera.transform.position - var_151_1.position).y, (manager.ui.mainCamera.transform.position - var_151_1.position).z)
				var_151_1.localEulerAngles.z = 0
				var_151_1.localEulerAngles.x = 0
				var_151_1.localEulerAngles = var_151_1.localEulerAngles
			end

			if arg_148_1.time_ >= 0 + var_151_3 and arg_148_1.time_ < 0 + var_151_3 + arg_151_0 then
				var_151_1.localPosition = Vector3.New(0, 100, 0)
				var_151_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_151_1.position).x, (manager.ui.mainCamera.transform.position - var_151_1.position).y, (manager.ui.mainCamera.transform.position - var_151_1.position).z)
				var_151_1.localEulerAngles.z = 0
				var_151_1.localEulerAngles.x = 0
				var_151_1.localEulerAngles = var_151_1.localEulerAngles

				local var_151_4 = GameObjectTools.GetOrAddComponent(var_151_1.gameObject, typeof(DynamicBoneHelper))

				if var_151_4 then
					var_151_4:EnableDynamicBone(true)
				end
			end

			local var_151_5 = arg_148_1.actors_["1070ui_story"]

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 and not isNil(var_151_5) and arg_148_1.var_.characterEffect1070ui_story == nil then
				arg_148_1.var_.characterEffect1070ui_story = var_151_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_151_6 = 0.200000002980232

			if 0 <= arg_148_1.time_ and arg_148_1.time_ < 0 + var_151_6 and not isNil(var_151_5) then
				if arg_148_1.var_.characterEffect1070ui_story and not isNil(var_151_5) then
					arg_148_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_148_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_148_1.time_ - 0) / var_151_6)
				end
			end

			if arg_148_1.time_ >= 0 + var_151_6 and arg_148_1.time_ < 0 + var_151_6 + arg_151_0 and not isNil(var_151_5) and arg_148_1.var_.characterEffect1070ui_story then
				arg_148_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_148_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_151_7 = 0
			local var_151_8 = 0.825

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= var_151_7 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, false)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_148_1.iconTrs_.gameObject, false)
				arg_148_1.callingController_:SetSelectedState("normal")

				local var_151_9 = arg_148_1:FormatText(arg_148_1:GetWordFromCfg(324131037).content)

				arg_148_1.text_.text = var_151_9

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_11 = 33 <= 0 and var_151_8 or var_151_8 * (utf8.len(var_151_9) / 33)

				if (33 <= 0 and var_151_8 or var_151_8 * (utf8.len(var_151_9) / 33)) > 0 and var_151_8 < var_151_11 then
					arg_148_1.talkMaxDuration = var_151_11

					if var_151_11 + var_151_7 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_11 + var_151_7
					end
				end

				arg_148_1.text_.text = var_151_9
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)
				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_12 = math.max(var_151_8, arg_148_1.talkMaxDuration)

			if var_151_7 <= arg_148_1.time_ and arg_148_1.time_ < var_151_7 + var_151_12 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_7) / var_151_12

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_7 + var_151_12 and arg_148_1.time_ < var_151_7 + var_151_12 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_148_1:InitPlayNodeList()
	end,
	Play324131038 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 324131038
		arg_152_1.duration_ = 11.6

		local var_152_0 = {
			zh = 9.3,
			ja = 11.6
		}
		local var_152_1 = manager.audio:GetLocalizationFlag()

		if var_152_0[var_152_1] ~= nil then
			arg_152_1.duration_ = var_152_0[var_152_1]
		end

		SetActive(arg_152_1.tipsGo_, false)

		function arg_152_1.onSingleLineFinish_()
			arg_152_1.onSingleLineUpdate_ = nil
			arg_152_1.onSingleLineFinish_ = nil
			arg_152_1.state_ = "waiting"
		end

		function arg_152_1.playNext_(arg_154_0)
			if arg_154_0 == 1 then
				arg_152_0:Play324131039(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 then
				arg_152_1.var_.moveOldPos1070ui_story = arg_152_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_155_0 = 0.001

			if 0 <= arg_152_1.time_ and arg_152_1.time_ < 0 + var_155_0 then
				arg_152_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_152_1.var_.moveOldPos1070ui_story, Vector3.New(0, -0.95, -6.05), (arg_152_1.time_ - 0) / var_155_0)
				arg_152_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_152_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_152_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_152_1.actors_["1070ui_story"].transform.position).z)
				arg_152_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_152_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_152_1.actors_["1070ui_story"].transform.localEulerAngles = arg_152_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_152_1.time_ >= 0 + var_155_0 and arg_152_1.time_ < 0 + var_155_0 + arg_155_0 then
				arg_152_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(0, -0.95, -6.05)
				arg_152_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_152_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_152_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_152_1.actors_["1070ui_story"].transform.position).z)
				arg_152_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_152_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_152_1.actors_["1070ui_story"].transform.localEulerAngles = arg_152_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_155_1 = arg_152_1.actors_["1070ui_story"]

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 and not isNil(var_155_1) and arg_152_1.var_.characterEffect1070ui_story == nil then
				arg_152_1.var_.characterEffect1070ui_story = var_155_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_155_2 = 0.200000002980232

			if 0 <= arg_152_1.time_ and arg_152_1.time_ < 0 + var_155_2 and not isNil(var_155_1) then
				if arg_152_1.var_.characterEffect1070ui_story and not isNil(var_155_1) then
					arg_152_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_152_1.time_ >= 0 + var_155_2 and arg_152_1.time_ < 0 + var_155_2 + arg_155_0 and not isNil(var_155_1) and arg_152_1.var_.characterEffect1070ui_story then
				arg_152_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 then
				arg_152_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action4_1")
			end

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 then
				arg_152_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_155_4 = 0
			local var_155_5 = 1.1

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= var_155_4 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				arg_152_1.leftNameTxt_.text = arg_152_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, false)
				arg_152_1.callingController_:SetSelectedState("normal")

				local var_155_6 = arg_152_1:GetWordFromCfg(324131038)
				local var_155_7 = arg_152_1:FormatText(var_155_6.content)

				arg_152_1.text_.text = var_155_7

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_9 = 44 <= 0 and var_155_5 or var_155_5 * (utf8.len(var_155_7) / 44)

				if (44 <= 0 and var_155_5 or var_155_5 * (utf8.len(var_155_7) / 44)) > 0 and var_155_5 < var_155_9 then
					arg_152_1.talkMaxDuration = var_155_9

					if var_155_9 + var_155_4 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_9 + var_155_4
					end
				end

				arg_152_1.text_.text = var_155_7
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324131", "324131038", "story_v_out_324131.awb") ~= 0 then
					local var_155_10 = manager.audio:GetVoiceLength("story_v_out_324131", "324131038", "story_v_out_324131.awb") / 1000

					if var_155_10 + var_155_4 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_10 + var_155_4
					end

					if var_155_6.prefab_name ~= "" and arg_152_1.actors_[var_155_6.prefab_name] ~= nil then
						local var_155_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_152_1.actors_[var_155_6.prefab_name].transform, "story_v_out_324131", "324131038", "story_v_out_324131.awb")

						arg_152_1:RecordAudio("324131038", var_155_11)
						arg_152_1:RecordAudio("324131038", var_155_11)
					else
						arg_152_1:AudioAction("play", "voice", "story_v_out_324131", "324131038", "story_v_out_324131.awb")
					end

					arg_152_1:RecordHistoryTalkVoice("story_v_out_324131", "324131038", "story_v_out_324131.awb")
				end

				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_12 = math.max(var_155_5, arg_152_1.talkMaxDuration)

			if var_155_4 <= arg_152_1.time_ and arg_152_1.time_ < var_155_4 + var_155_12 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_4) / var_155_12

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_4 + var_155_12 and arg_152_1.time_ < var_155_4 + var_155_12 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_152_1:InitPlayNodeList()
	end,
	Play324131039 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 324131039
		arg_156_1.duration_ = 11.93

		local var_156_0 = {
			zh = 11.933,
			ja = 9.333
		}
		local var_156_1 = manager.audio:GetLocalizationFlag()

		if var_156_0[var_156_1] ~= nil then
			arg_156_1.duration_ = var_156_0[var_156_1]
		end

		SetActive(arg_156_1.tipsGo_, false)

		function arg_156_1.onSingleLineFinish_()
			arg_156_1.onSingleLineUpdate_ = nil
			arg_156_1.onSingleLineFinish_ = nil
			arg_156_1.state_ = "waiting"
		end

		function arg_156_1.playNext_(arg_158_0)
			if arg_158_0 == 1 then
				arg_156_0:Play324131040(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			local var_159_0 = 1.275

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, true)

				arg_156_1.leftNameTxt_.text = arg_156_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_156_1.leftNameTxt_.transform)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1.leftNameTxt_.text)
				SetActive(arg_156_1.iconTrs_.gameObject, false)
				arg_156_1.callingController_:SetSelectedState("normal")

				local var_159_1 = arg_156_1:GetWordFromCfg(324131039)
				local var_159_2 = arg_156_1:FormatText(var_159_1.content)

				arg_156_1.text_.text = var_159_2

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_4 = 51 <= 0 and var_159_0 or var_159_0 * (utf8.len(var_159_2) / 51)

				if (51 <= 0 and var_159_0 or var_159_0 * (utf8.len(var_159_2) / 51)) > 0 and var_159_0 < var_159_4 then
					arg_156_1.talkMaxDuration = var_159_4

					if var_159_4 + 0 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_4 + 0
					end
				end

				arg_156_1.text_.text = var_159_2
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324131", "324131039", "story_v_out_324131.awb") ~= 0 then
					local var_159_5 = manager.audio:GetVoiceLength("story_v_out_324131", "324131039", "story_v_out_324131.awb") / 1000

					if var_159_5 + 0 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_5 + 0
					end

					if var_159_1.prefab_name ~= "" and arg_156_1.actors_[var_159_1.prefab_name] ~= nil then
						local var_159_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_156_1.actors_[var_159_1.prefab_name].transform, "story_v_out_324131", "324131039", "story_v_out_324131.awb")

						arg_156_1:RecordAudio("324131039", var_159_6)
						arg_156_1:RecordAudio("324131039", var_159_6)
					else
						arg_156_1:AudioAction("play", "voice", "story_v_out_324131", "324131039", "story_v_out_324131.awb")
					end

					arg_156_1:RecordHistoryTalkVoice("story_v_out_324131", "324131039", "story_v_out_324131.awb")
				end

				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_7 = math.max(var_159_0, arg_156_1.talkMaxDuration)

			if 0 <= arg_156_1.time_ and arg_156_1.time_ < 0 + var_159_7 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - 0) / var_159_7

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= 0 + var_159_7 and arg_156_1.time_ < 0 + var_159_7 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {}

		arg_156_1:InitPlayNodeList()
	end,
	Play324131040 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 324131040
		arg_160_1.duration_ = 12.53

		local var_160_0 = {
			zh = 11.9,
			ja = 12.533
		}
		local var_160_1 = manager.audio:GetLocalizationFlag()

		if var_160_0[var_160_1] ~= nil then
			arg_160_1.duration_ = var_160_0[var_160_1]
		end

		SetActive(arg_160_1.tipsGo_, false)

		function arg_160_1.onSingleLineFinish_()
			arg_160_1.onSingleLineUpdate_ = nil
			arg_160_1.onSingleLineFinish_ = nil
			arg_160_1.state_ = "waiting"
		end

		function arg_160_1.playNext_(arg_162_0)
			if arg_162_0 == 1 then
				arg_160_0:Play324131041(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			local var_163_0 = 1.25

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, true)

				arg_160_1.leftNameTxt_.text = arg_160_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_160_1.leftNameTxt_.transform)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1.leftNameTxt_.text)
				SetActive(arg_160_1.iconTrs_.gameObject, false)
				arg_160_1.callingController_:SetSelectedState("normal")

				local var_163_1 = arg_160_1:GetWordFromCfg(324131040)
				local var_163_2 = arg_160_1:FormatText(var_163_1.content)

				arg_160_1.text_.text = var_163_2

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_4 = 50 <= 0 and var_163_0 or var_163_0 * (utf8.len(var_163_2) / 50)

				if (50 <= 0 and var_163_0 or var_163_0 * (utf8.len(var_163_2) / 50)) > 0 and var_163_0 < var_163_4 then
					arg_160_1.talkMaxDuration = var_163_4

					if var_163_4 + 0 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_4 + 0
					end
				end

				arg_160_1.text_.text = var_163_2
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324131", "324131040", "story_v_out_324131.awb") ~= 0 then
					local var_163_5 = manager.audio:GetVoiceLength("story_v_out_324131", "324131040", "story_v_out_324131.awb") / 1000

					if var_163_5 + 0 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_5 + 0
					end

					if var_163_1.prefab_name ~= "" and arg_160_1.actors_[var_163_1.prefab_name] ~= nil then
						local var_163_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_160_1.actors_[var_163_1.prefab_name].transform, "story_v_out_324131", "324131040", "story_v_out_324131.awb")

						arg_160_1:RecordAudio("324131040", var_163_6)
						arg_160_1:RecordAudio("324131040", var_163_6)
					else
						arg_160_1:AudioAction("play", "voice", "story_v_out_324131", "324131040", "story_v_out_324131.awb")
					end

					arg_160_1:RecordHistoryTalkVoice("story_v_out_324131", "324131040", "story_v_out_324131.awb")
				end

				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_7 = math.max(var_163_0, arg_160_1.talkMaxDuration)

			if 0 <= arg_160_1.time_ and arg_160_1.time_ < 0 + var_163_7 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - 0) / var_163_7

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= 0 + var_163_7 and arg_160_1.time_ < 0 + var_163_7 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {}

		arg_160_1:InitPlayNodeList()
	end,
	Play324131041 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 324131041
		arg_164_1.duration_ = 11.4

		local var_164_0 = {
			zh = 11.4,
			ja = 9.433
		}
		local var_164_1 = manager.audio:GetLocalizationFlag()

		if var_164_0[var_164_1] ~= nil then
			arg_164_1.duration_ = var_164_0[var_164_1]
		end

		SetActive(arg_164_1.tipsGo_, false)

		function arg_164_1.onSingleLineFinish_()
			arg_164_1.onSingleLineUpdate_ = nil
			arg_164_1.onSingleLineFinish_ = nil
			arg_164_1.state_ = "waiting"
		end

		function arg_164_1.playNext_(arg_166_0)
			if arg_166_0 == 1 then
				arg_164_0:Play324131042(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 then
				arg_164_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action4_2")
			end

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 then
				arg_164_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_167_0 = 0
			local var_167_1 = 1.15

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= var_167_0 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0
				arg_164_1.dialogCg_.alpha = 1

				arg_164_1.dialog_:SetActive(true)
				SetActive(arg_164_1.leftNameGo_, true)

				arg_164_1.leftNameTxt_.text = arg_164_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_164_1.leftNameTxt_.transform)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1.leftNameTxt_.text)
				SetActive(arg_164_1.iconTrs_.gameObject, false)
				arg_164_1.callingController_:SetSelectedState("normal")

				local var_167_2 = arg_164_1:GetWordFromCfg(324131041)
				local var_167_3 = arg_164_1:FormatText(var_167_2.content)

				arg_164_1.text_.text = var_167_3

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_5 = 46 <= 0 and var_167_1 or var_167_1 * (utf8.len(var_167_3) / 46)

				if (46 <= 0 and var_167_1 or var_167_1 * (utf8.len(var_167_3) / 46)) > 0 and var_167_1 < var_167_5 then
					arg_164_1.talkMaxDuration = var_167_5

					if var_167_5 + var_167_0 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_5 + var_167_0
					end
				end

				arg_164_1.text_.text = var_167_3
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324131", "324131041", "story_v_out_324131.awb") ~= 0 then
					local var_167_6 = manager.audio:GetVoiceLength("story_v_out_324131", "324131041", "story_v_out_324131.awb") / 1000

					if var_167_6 + var_167_0 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_6 + var_167_0
					end

					if var_167_2.prefab_name ~= "" and arg_164_1.actors_[var_167_2.prefab_name] ~= nil then
						local var_167_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_164_1.actors_[var_167_2.prefab_name].transform, "story_v_out_324131", "324131041", "story_v_out_324131.awb")

						arg_164_1:RecordAudio("324131041", var_167_7)
						arg_164_1:RecordAudio("324131041", var_167_7)
					else
						arg_164_1:AudioAction("play", "voice", "story_v_out_324131", "324131041", "story_v_out_324131.awb")
					end

					arg_164_1:RecordHistoryTalkVoice("story_v_out_324131", "324131041", "story_v_out_324131.awb")
				end

				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_8 = math.max(var_167_1, arg_164_1.talkMaxDuration)

			if var_167_0 <= arg_164_1.time_ and arg_164_1.time_ < var_167_0 + var_167_8 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - var_167_0) / var_167_8

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= var_167_0 + var_167_8 and arg_164_1.time_ < var_167_0 + var_167_8 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {}

		arg_164_1:InitPlayNodeList()
	end,
	Play324131042 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 324131042
		arg_168_1.duration_ = 6.4

		local var_168_0 = {
			zh = 4.3,
			ja = 6.4
		}
		local var_168_1 = manager.audio:GetLocalizationFlag()

		if var_168_0[var_168_1] ~= nil then
			arg_168_1.duration_ = var_168_0[var_168_1]
		end

		SetActive(arg_168_1.tipsGo_, false)

		function arg_168_1.onSingleLineFinish_()
			arg_168_1.onSingleLineUpdate_ = nil
			arg_168_1.onSingleLineFinish_ = nil
			arg_168_1.state_ = "waiting"
		end

		function arg_168_1.playNext_(arg_170_0)
			if arg_170_0 == 1 then
				arg_168_0:Play324131043(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 then
				arg_168_1.var_.moveOldPos1070ui_story = arg_168_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_171_0 = 0.001

			if 0 <= arg_168_1.time_ and arg_168_1.time_ < 0 + var_171_0 then
				arg_168_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_168_1.var_.moveOldPos1070ui_story, Vector3.New(0, 100, 0), (arg_168_1.time_ - 0) / var_171_0)
				arg_168_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_168_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_168_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_168_1.actors_["1070ui_story"].transform.position).z)
				arg_168_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_168_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_168_1.actors_["1070ui_story"].transform.localEulerAngles = arg_168_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_168_1.time_ >= 0 + var_171_0 and arg_168_1.time_ < 0 + var_171_0 + arg_171_0 then
				arg_168_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_168_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_168_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_168_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_168_1.actors_["1070ui_story"].transform.position).z)
				arg_168_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_168_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_168_1.actors_["1070ui_story"].transform.localEulerAngles = arg_168_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_171_1 = arg_168_1.actors_["1053ui_story"].transform

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 then
				arg_168_1.var_.moveOldPos1053ui_story = var_171_1.localPosition

				local var_171_2 = GameObjectTools.GetOrAddComponent(var_171_1.gameObject, typeof(DynamicBoneHelper))

				if var_171_2 then
					var_171_2:EnableDynamicBone(false)
				end
			end

			local var_171_3 = 0.001

			if 0 <= arg_168_1.time_ and arg_168_1.time_ < 0 + var_171_3 then
				var_171_1.localPosition = Vector3.Lerp(arg_168_1.var_.moveOldPos1053ui_story, Vector3.New(0, -1.08, -6), (arg_168_1.time_ - 0) / var_171_3)
				var_171_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_171_1.position).x, (manager.ui.mainCamera.transform.position - var_171_1.position).y, (manager.ui.mainCamera.transform.position - var_171_1.position).z)
				var_171_1.localEulerAngles.z = 0
				var_171_1.localEulerAngles.x = 0
				var_171_1.localEulerAngles = var_171_1.localEulerAngles
			end

			if arg_168_1.time_ >= 0 + var_171_3 and arg_168_1.time_ < 0 + var_171_3 + arg_171_0 then
				var_171_1.localPosition = Vector3.New(0, -1.08, -6)
				var_171_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_171_1.position).x, (manager.ui.mainCamera.transform.position - var_171_1.position).y, (manager.ui.mainCamera.transform.position - var_171_1.position).z)
				var_171_1.localEulerAngles.z = 0
				var_171_1.localEulerAngles.x = 0
				var_171_1.localEulerAngles = var_171_1.localEulerAngles

				local var_171_4 = GameObjectTools.GetOrAddComponent(var_171_1.gameObject, typeof(DynamicBoneHelper))

				if var_171_4 then
					var_171_4:EnableDynamicBone(true)
				end
			end

			local var_171_5 = arg_168_1.actors_["1053ui_story"]

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 and not isNil(var_171_5) and arg_168_1.var_.characterEffect1053ui_story == nil then
				arg_168_1.var_.characterEffect1053ui_story = var_171_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_171_6 = 0.200000002980232

			if 0 <= arg_168_1.time_ and arg_168_1.time_ < 0 + var_171_6 and not isNil(var_171_5) then
				if arg_168_1.var_.characterEffect1053ui_story and not isNil(var_171_5) then
					arg_168_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_168_1.time_ >= 0 + var_171_6 and arg_168_1.time_ < 0 + var_171_6 + arg_171_0 and not isNil(var_171_5) and arg_168_1.var_.characterEffect1053ui_story then
				arg_168_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_171_8 = arg_168_1.actors_["1070ui_story"]

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 and not isNil(var_171_8) and arg_168_1.var_.characterEffect1070ui_story == nil then
				arg_168_1.var_.characterEffect1070ui_story = var_171_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_171_9 = 0.200000002980232

			if 0 <= arg_168_1.time_ and arg_168_1.time_ < 0 + var_171_9 and not isNil(var_171_8) then
				if arg_168_1.var_.characterEffect1070ui_story and not isNil(var_171_8) then
					arg_168_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_168_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_168_1.time_ - 0) / var_171_9)
				end
			end

			if arg_168_1.time_ >= 0 + var_171_9 and arg_168_1.time_ < 0 + var_171_9 + arg_171_0 and not isNil(var_171_8) and arg_168_1.var_.characterEffect1070ui_story then
				arg_168_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_168_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 then
				arg_168_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053action/1053action1_1")
			end

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 then
				arg_168_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_171_10 = 0
			local var_171_11 = 0.475

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= var_171_10 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, true)

				arg_168_1.leftNameTxt_.text = arg_168_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_168_1.leftNameTxt_.transform)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1.leftNameTxt_.text)
				SetActive(arg_168_1.iconTrs_.gameObject, false)
				arg_168_1.callingController_:SetSelectedState("normal")

				local var_171_12 = arg_168_1:GetWordFromCfg(324131042)
				local var_171_13 = arg_168_1:FormatText(var_171_12.content)

				arg_168_1.text_.text = var_171_13

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_15 = 19 <= 0 and var_171_11 or var_171_11 * (utf8.len(var_171_13) / 19)

				if (19 <= 0 and var_171_11 or var_171_11 * (utf8.len(var_171_13) / 19)) > 0 and var_171_11 < var_171_15 then
					arg_168_1.talkMaxDuration = var_171_15

					if var_171_15 + var_171_10 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_15 + var_171_10
					end
				end

				arg_168_1.text_.text = var_171_13
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324131", "324131042", "story_v_out_324131.awb") ~= 0 then
					local var_171_16 = manager.audio:GetVoiceLength("story_v_out_324131", "324131042", "story_v_out_324131.awb") / 1000

					if var_171_16 + var_171_10 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_16 + var_171_10
					end

					if var_171_12.prefab_name ~= "" and arg_168_1.actors_[var_171_12.prefab_name] ~= nil then
						local var_171_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_168_1.actors_[var_171_12.prefab_name].transform, "story_v_out_324131", "324131042", "story_v_out_324131.awb")

						arg_168_1:RecordAudio("324131042", var_171_17)
						arg_168_1:RecordAudio("324131042", var_171_17)
					else
						arg_168_1:AudioAction("play", "voice", "story_v_out_324131", "324131042", "story_v_out_324131.awb")
					end

					arg_168_1:RecordHistoryTalkVoice("story_v_out_324131", "324131042", "story_v_out_324131.awb")
				end

				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_18 = math.max(var_171_11, arg_168_1.talkMaxDuration)

			if var_171_10 <= arg_168_1.time_ and arg_168_1.time_ < var_171_10 + var_171_18 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - var_171_10) / var_171_18

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= var_171_10 + var_171_18 and arg_168_1.time_ < var_171_10 + var_171_18 + arg_171_0 then
				arg_168_1.typewritter.percent = 1

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(true)
			end
		end

		arg_168_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_168_1:InitPlayNodeList()
	end,
	Play324131043 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 324131043
		arg_172_1.duration_ = 15.07

		local var_172_0 = {
			zh = 11.066,
			ja = 15.066
		}
		local var_172_1 = manager.audio:GetLocalizationFlag()

		if var_172_0[var_172_1] ~= nil then
			arg_172_1.duration_ = var_172_0[var_172_1]
		end

		SetActive(arg_172_1.tipsGo_, false)

		function arg_172_1.onSingleLineFinish_()
			arg_172_1.onSingleLineUpdate_ = nil
			arg_172_1.onSingleLineFinish_ = nil
			arg_172_1.state_ = "waiting"
		end

		function arg_172_1.playNext_(arg_174_0)
			if arg_174_0 == 1 then
				arg_172_0:Play324131044(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 then
				arg_172_1.var_.moveOldPos1070ui_story = arg_172_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_175_0 = 0.001

			if 0 <= arg_172_1.time_ and arg_172_1.time_ < 0 + var_175_0 then
				arg_172_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_172_1.var_.moveOldPos1070ui_story, Vector3.New(0, -0.95, -6.05), (arg_172_1.time_ - 0) / var_175_0)
				arg_172_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_172_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_172_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_172_1.actors_["1070ui_story"].transform.position).z)
				arg_172_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_172_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_172_1.actors_["1070ui_story"].transform.localEulerAngles = arg_172_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_172_1.time_ >= 0 + var_175_0 and arg_172_1.time_ < 0 + var_175_0 + arg_175_0 then
				arg_172_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(0, -0.95, -6.05)
				arg_172_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_172_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_172_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_172_1.actors_["1070ui_story"].transform.position).z)
				arg_172_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_172_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_172_1.actors_["1070ui_story"].transform.localEulerAngles = arg_172_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_175_1 = arg_172_1.actors_["1053ui_story"].transform

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 then
				arg_172_1.var_.moveOldPos1053ui_story = var_175_1.localPosition

				local var_175_2 = GameObjectTools.GetOrAddComponent(var_175_1.gameObject, typeof(DynamicBoneHelper))

				if var_175_2 then
					var_175_2:EnableDynamicBone(false)
				end
			end

			local var_175_3 = 0.001

			if 0 <= arg_172_1.time_ and arg_172_1.time_ < 0 + var_175_3 then
				var_175_1.localPosition = Vector3.Lerp(arg_172_1.var_.moveOldPos1053ui_story, Vector3.New(0, 100, 0), (arg_172_1.time_ - 0) / var_175_3)
				var_175_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_175_1.position).x, (manager.ui.mainCamera.transform.position - var_175_1.position).y, (manager.ui.mainCamera.transform.position - var_175_1.position).z)
				var_175_1.localEulerAngles.z = 0
				var_175_1.localEulerAngles.x = 0
				var_175_1.localEulerAngles = var_175_1.localEulerAngles
			end

			if arg_172_1.time_ >= 0 + var_175_3 and arg_172_1.time_ < 0 + var_175_3 + arg_175_0 then
				var_175_1.localPosition = Vector3.New(0, 100, 0)
				var_175_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_175_1.position).x, (manager.ui.mainCamera.transform.position - var_175_1.position).y, (manager.ui.mainCamera.transform.position - var_175_1.position).z)
				var_175_1.localEulerAngles.z = 0
				var_175_1.localEulerAngles.x = 0
				var_175_1.localEulerAngles = var_175_1.localEulerAngles

				local var_175_4 = GameObjectTools.GetOrAddComponent(var_175_1.gameObject, typeof(DynamicBoneHelper))

				if var_175_4 then
					var_175_4:EnableDynamicBone(true)
				end
			end

			local var_175_5 = arg_172_1.actors_["1070ui_story"]

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 and not isNil(var_175_5) and arg_172_1.var_.characterEffect1070ui_story == nil then
				arg_172_1.var_.characterEffect1070ui_story = var_175_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_175_6 = 0.200000002980232

			if 0 <= arg_172_1.time_ and arg_172_1.time_ < 0 + var_175_6 and not isNil(var_175_5) then
				if arg_172_1.var_.characterEffect1070ui_story and not isNil(var_175_5) then
					arg_172_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_172_1.time_ >= 0 + var_175_6 and arg_172_1.time_ < 0 + var_175_6 + arg_175_0 and not isNil(var_175_5) and arg_172_1.var_.characterEffect1070ui_story then
				arg_172_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_175_8 = arg_172_1.actors_["1053ui_story"]

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 and not isNil(var_175_8) and arg_172_1.var_.characterEffect1053ui_story == nil then
				arg_172_1.var_.characterEffect1053ui_story = var_175_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_175_9 = 0.200000002980232

			if 0 <= arg_172_1.time_ and arg_172_1.time_ < 0 + var_175_9 and not isNil(var_175_8) then
				if arg_172_1.var_.characterEffect1053ui_story and not isNil(var_175_8) then
					arg_172_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_172_1.var_.characterEffect1053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_172_1.time_ - 0) / var_175_9)
				end
			end

			if arg_172_1.time_ >= 0 + var_175_9 and arg_172_1.time_ < 0 + var_175_9 + arg_175_0 and not isNil(var_175_8) and arg_172_1.var_.characterEffect1053ui_story then
				arg_172_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_172_1.var_.characterEffect1053ui_story.fillRatio = 0.5
			end

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 then
				arg_172_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action1_1")
			end

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 then
				arg_172_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_175_10 = 0
			local var_175_11 = 1.2

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= var_175_10 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, true)

				arg_172_1.leftNameTxt_.text = arg_172_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_172_1.leftNameTxt_.transform)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1.leftNameTxt_.text)
				SetActive(arg_172_1.iconTrs_.gameObject, false)
				arg_172_1.callingController_:SetSelectedState("normal")

				local var_175_12 = arg_172_1:GetWordFromCfg(324131043)
				local var_175_13 = arg_172_1:FormatText(var_175_12.content)

				arg_172_1.text_.text = var_175_13

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_15 = 48 <= 0 and var_175_11 or var_175_11 * (utf8.len(var_175_13) / 48)

				if (48 <= 0 and var_175_11 or var_175_11 * (utf8.len(var_175_13) / 48)) > 0 and var_175_11 < var_175_15 then
					arg_172_1.talkMaxDuration = var_175_15

					if var_175_15 + var_175_10 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_15 + var_175_10
					end
				end

				arg_172_1.text_.text = var_175_13
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324131", "324131043", "story_v_out_324131.awb") ~= 0 then
					local var_175_16 = manager.audio:GetVoiceLength("story_v_out_324131", "324131043", "story_v_out_324131.awb") / 1000

					if var_175_16 + var_175_10 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_16 + var_175_10
					end

					if var_175_12.prefab_name ~= "" and arg_172_1.actors_[var_175_12.prefab_name] ~= nil then
						local var_175_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_172_1.actors_[var_175_12.prefab_name].transform, "story_v_out_324131", "324131043", "story_v_out_324131.awb")

						arg_172_1:RecordAudio("324131043", var_175_17)
						arg_172_1:RecordAudio("324131043", var_175_17)
					else
						arg_172_1:AudioAction("play", "voice", "story_v_out_324131", "324131043", "story_v_out_324131.awb")
					end

					arg_172_1:RecordHistoryTalkVoice("story_v_out_324131", "324131043", "story_v_out_324131.awb")
				end

				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_18 = math.max(var_175_11, arg_172_1.talkMaxDuration)

			if var_175_10 <= arg_172_1.time_ and arg_172_1.time_ < var_175_10 + var_175_18 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - var_175_10) / var_175_18

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= var_175_10 + var_175_18 and arg_172_1.time_ < var_175_10 + var_175_18 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_172_1:InitPlayNodeList()
	end,
	Play324131044 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 324131044
		arg_176_1.duration_ = 12.73

		local var_176_0 = {
			zh = 11.566,
			ja = 12.733
		}
		local var_176_1 = manager.audio:GetLocalizationFlag()

		if var_176_0[var_176_1] ~= nil then
			arg_176_1.duration_ = var_176_0[var_176_1]
		end

		SetActive(arg_176_1.tipsGo_, false)

		function arg_176_1.onSingleLineFinish_()
			arg_176_1.onSingleLineUpdate_ = nil
			arg_176_1.onSingleLineFinish_ = nil
			arg_176_1.state_ = "waiting"
		end

		function arg_176_1.playNext_(arg_178_0)
			if arg_178_0 == 1 then
				arg_176_0:Play324131045(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			local var_179_0 = 1.325

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0
				arg_176_1.dialogCg_.alpha = 1

				arg_176_1.dialog_:SetActive(true)
				SetActive(arg_176_1.leftNameGo_, true)

				arg_176_1.leftNameTxt_.text = arg_176_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_176_1.leftNameTxt_.transform)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1.leftNameTxt_.text)
				SetActive(arg_176_1.iconTrs_.gameObject, false)
				arg_176_1.callingController_:SetSelectedState("normal")

				local var_179_1 = arg_176_1:GetWordFromCfg(324131044)
				local var_179_2 = arg_176_1:FormatText(var_179_1.content)

				arg_176_1.text_.text = var_179_2

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_4 = 53 <= 0 and var_179_0 or var_179_0 * (utf8.len(var_179_2) / 53)

				if (53 <= 0 and var_179_0 or var_179_0 * (utf8.len(var_179_2) / 53)) > 0 and var_179_0 < var_179_4 then
					arg_176_1.talkMaxDuration = var_179_4

					if var_179_4 + 0 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_4 + 0
					end
				end

				arg_176_1.text_.text = var_179_2
				arg_176_1.typewritter.percent = 0

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324131", "324131044", "story_v_out_324131.awb") ~= 0 then
					local var_179_5 = manager.audio:GetVoiceLength("story_v_out_324131", "324131044", "story_v_out_324131.awb") / 1000

					if var_179_5 + 0 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_5 + 0
					end

					if var_179_1.prefab_name ~= "" and arg_176_1.actors_[var_179_1.prefab_name] ~= nil then
						local var_179_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_176_1.actors_[var_179_1.prefab_name].transform, "story_v_out_324131", "324131044", "story_v_out_324131.awb")

						arg_176_1:RecordAudio("324131044", var_179_6)
						arg_176_1:RecordAudio("324131044", var_179_6)
					else
						arg_176_1:AudioAction("play", "voice", "story_v_out_324131", "324131044", "story_v_out_324131.awb")
					end

					arg_176_1:RecordHistoryTalkVoice("story_v_out_324131", "324131044", "story_v_out_324131.awb")
				end

				arg_176_1:RecordContent(arg_176_1.text_.text)
			end

			local var_179_7 = math.max(var_179_0, arg_176_1.talkMaxDuration)

			if 0 <= arg_176_1.time_ and arg_176_1.time_ < 0 + var_179_7 then
				arg_176_1.typewritter.percent = (arg_176_1.time_ - 0) / var_179_7

				arg_176_1.typewritter:SetDirty()
			end

			if arg_176_1.time_ >= 0 + var_179_7 and arg_176_1.time_ < 0 + var_179_7 + arg_179_0 then
				arg_176_1.typewritter.percent = 1

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(true)
			end
		end

		arg_176_1.nodeConfigList_ = {}

		arg_176_1:InitPlayNodeList()
	end,
	Play324131045 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 324131045
		arg_180_1.duration_ = 8.8

		local var_180_0 = {
			zh = 8.8,
			ja = 8.433
		}
		local var_180_1 = manager.audio:GetLocalizationFlag()

		if var_180_0[var_180_1] ~= nil then
			arg_180_1.duration_ = var_180_0[var_180_1]
		end

		SetActive(arg_180_1.tipsGo_, false)

		function arg_180_1.onSingleLineFinish_()
			arg_180_1.onSingleLineUpdate_ = nil
			arg_180_1.onSingleLineFinish_ = nil
			arg_180_1.state_ = "waiting"
		end

		function arg_180_1.playNext_(arg_182_0)
			if arg_182_0 == 1 then
				arg_180_0:Play324131046(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 then
				arg_180_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action1_1")
			end

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 then
				arg_180_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_183_0 = 0
			local var_183_1 = 0.65

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= var_183_0 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0
				arg_180_1.dialogCg_.alpha = 1

				arg_180_1.dialog_:SetActive(true)
				SetActive(arg_180_1.leftNameGo_, true)

				arg_180_1.leftNameTxt_.text = arg_180_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_180_1.leftNameTxt_.transform)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1.leftNameTxt_.text)
				SetActive(arg_180_1.iconTrs_.gameObject, false)
				arg_180_1.callingController_:SetSelectedState("normal")

				local var_183_2 = arg_180_1:GetWordFromCfg(324131045)
				local var_183_3 = arg_180_1:FormatText(var_183_2.content)

				arg_180_1.text_.text = var_183_3

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_5 = 26 <= 0 and var_183_1 or var_183_1 * (utf8.len(var_183_3) / 26)

				if (26 <= 0 and var_183_1 or var_183_1 * (utf8.len(var_183_3) / 26)) > 0 and var_183_1 < var_183_5 then
					arg_180_1.talkMaxDuration = var_183_5

					if var_183_5 + var_183_0 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_5 + var_183_0
					end
				end

				arg_180_1.text_.text = var_183_3
				arg_180_1.typewritter.percent = 0

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324131", "324131045", "story_v_out_324131.awb") ~= 0 then
					local var_183_6 = manager.audio:GetVoiceLength("story_v_out_324131", "324131045", "story_v_out_324131.awb") / 1000

					if var_183_6 + var_183_0 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_6 + var_183_0
					end

					if var_183_2.prefab_name ~= "" and arg_180_1.actors_[var_183_2.prefab_name] ~= nil then
						local var_183_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_180_1.actors_[var_183_2.prefab_name].transform, "story_v_out_324131", "324131045", "story_v_out_324131.awb")

						arg_180_1:RecordAudio("324131045", var_183_7)
						arg_180_1:RecordAudio("324131045", var_183_7)
					else
						arg_180_1:AudioAction("play", "voice", "story_v_out_324131", "324131045", "story_v_out_324131.awb")
					end

					arg_180_1:RecordHistoryTalkVoice("story_v_out_324131", "324131045", "story_v_out_324131.awb")
				end

				arg_180_1:RecordContent(arg_180_1.text_.text)
			end

			local var_183_8 = math.max(var_183_1, arg_180_1.talkMaxDuration)

			if var_183_0 <= arg_180_1.time_ and arg_180_1.time_ < var_183_0 + var_183_8 then
				arg_180_1.typewritter.percent = (arg_180_1.time_ - var_183_0) / var_183_8

				arg_180_1.typewritter:SetDirty()
			end

			if arg_180_1.time_ >= var_183_0 + var_183_8 and arg_180_1.time_ < var_183_0 + var_183_8 + arg_183_0 then
				arg_180_1.typewritter.percent = 1

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(true)
			end
		end

		arg_180_1.nodeConfigList_ = {}

		arg_180_1:InitPlayNodeList()
	end,
	Play324131046 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 324131046
		arg_184_1.duration_ = 5

		SetActive(arg_184_1.tipsGo_, false)

		function arg_184_1.onSingleLineFinish_()
			arg_184_1.onSingleLineUpdate_ = nil
			arg_184_1.onSingleLineFinish_ = nil
			arg_184_1.state_ = "waiting"
		end

		function arg_184_1.playNext_(arg_186_0)
			if arg_186_0 == 1 then
				arg_184_0:Play324131047(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 then
				arg_184_1.var_.moveOldPos1070ui_story = arg_184_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_187_0 = 0.001

			if 0 <= arg_184_1.time_ and arg_184_1.time_ < 0 + var_187_0 then
				arg_184_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_184_1.var_.moveOldPos1070ui_story, Vector3.New(0, 100, 0), (arg_184_1.time_ - 0) / var_187_0)
				arg_184_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_184_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_184_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_184_1.actors_["1070ui_story"].transform.position).z)
				arg_184_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_184_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_184_1.actors_["1070ui_story"].transform.localEulerAngles = arg_184_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_184_1.time_ >= 0 + var_187_0 and arg_184_1.time_ < 0 + var_187_0 + arg_187_0 then
				arg_184_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_184_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_184_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_184_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_184_1.actors_["1070ui_story"].transform.position).z)
				arg_184_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_184_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_184_1.actors_["1070ui_story"].transform.localEulerAngles = arg_184_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_187_1 = arg_184_1.actors_["1070ui_story"]

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 and not isNil(var_187_1) and arg_184_1.var_.characterEffect1070ui_story == nil then
				arg_184_1.var_.characterEffect1070ui_story = var_187_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_187_2 = 0.200000002980232

			if 0 <= arg_184_1.time_ and arg_184_1.time_ < 0 + var_187_2 and not isNil(var_187_1) then
				if arg_184_1.var_.characterEffect1070ui_story and not isNil(var_187_1) then
					arg_184_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_184_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_184_1.time_ - 0) / var_187_2)
				end
			end

			if arg_184_1.time_ >= 0 + var_187_2 and arg_184_1.time_ < 0 + var_187_2 + arg_187_0 and not isNil(var_187_1) and arg_184_1.var_.characterEffect1070ui_story then
				arg_184_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_184_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_187_3 = 0
			local var_187_4 = 0.6

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= var_187_3 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0
				arg_184_1.dialogCg_.alpha = 1

				arg_184_1.dialog_:SetActive(true)
				SetActive(arg_184_1.leftNameGo_, false)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_184_1.iconTrs_.gameObject, false)
				arg_184_1.callingController_:SetSelectedState("normal")

				local var_187_5 = arg_184_1:FormatText(arg_184_1:GetWordFromCfg(324131046).content)

				arg_184_1.text_.text = var_187_5

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_7 = 24 <= 0 and var_187_4 or var_187_4 * (utf8.len(var_187_5) / 24)

				if (24 <= 0 and var_187_4 or var_187_4 * (utf8.len(var_187_5) / 24)) > 0 and var_187_4 < var_187_7 then
					arg_184_1.talkMaxDuration = var_187_7

					if var_187_7 + var_187_3 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_7 + var_187_3
					end
				end

				arg_184_1.text_.text = var_187_5
				arg_184_1.typewritter.percent = 0

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(false)
				arg_184_1:RecordContent(arg_184_1.text_.text)
			end

			local var_187_8 = math.max(var_187_4, arg_184_1.talkMaxDuration)

			if var_187_3 <= arg_184_1.time_ and arg_184_1.time_ < var_187_3 + var_187_8 then
				arg_184_1.typewritter.percent = (arg_184_1.time_ - var_187_3) / var_187_8

				arg_184_1.typewritter:SetDirty()
			end

			if arg_184_1.time_ >= var_187_3 + var_187_8 and arg_184_1.time_ < var_187_3 + var_187_8 + arg_187_0 then
				arg_184_1.typewritter.percent = 1

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(true)
			end
		end

		arg_184_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_184_1:InitPlayNodeList()
	end,
	Play324131047 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 324131047
		arg_188_1.duration_ = 7.87

		SetActive(arg_188_1.tipsGo_, false)

		function arg_188_1.onSingleLineFinish_()
			arg_188_1.onSingleLineUpdate_ = nil
			arg_188_1.onSingleLineFinish_ = nil
			arg_188_1.state_ = "waiting"
		end

		function arg_188_1.playNext_(arg_190_0)
			if arg_190_0 == 1 then
				arg_188_0:Play324131048(arg_188_1)
			end
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			if arg_188_1.bgs_.J22f == nil then
				local var_191_0 = Object.Instantiate(arg_188_1.paintGo_)

				var_191_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "J22f")
				var_191_0.name = "J22f"
				var_191_0.transform.parent = arg_188_1.stage_.transform
				var_191_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_188_1.bgs_.J22f = var_191_0
			end

			if 1.46666666666567 < arg_188_1.time_ and arg_188_1.time_ <= 1.46666666666567 + arg_191_0 then
				local var_191_1 = arg_188_1.bgs_.J22f

				arg_188_1.bgs_.J22f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_191_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_191_2 = var_191_1:GetComponent("SpriteRenderer")

				if var_191_2 and var_191_2.sprite then
					local var_191_3 = 2 * (var_191_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_191_1.transform.localScale = Vector3.New(var_191_3 / var_191_2.sprite.bounds.size.y < var_191_3 * manager.ui.mainCameraCom_.aspect / var_191_2.sprite.bounds.size.x and var_191_3 * manager.ui.mainCameraCom_.aspect / var_191_2.sprite.bounds.size.x or var_191_3 / var_191_2.sprite.bounds.size.y, var_191_3 / var_191_2.sprite.bounds.size.y < var_191_3 * manager.ui.mainCameraCom_.aspect / var_191_2.sprite.bounds.size.x and var_191_3 * manager.ui.mainCameraCom_.aspect / var_191_2.sprite.bounds.size.x or var_191_3 / var_191_2.sprite.bounds.size.y, 0)
				end

				for iter_191_0, iter_191_1 in pairs(arg_188_1.bgs_) do
					if iter_191_0 ~= "J22f" then
						iter_191_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_191_4 = 0.466666666666667

			if 0.466666666666667 < arg_188_1.time_ and arg_188_1.time_ <= var_191_4 + arg_191_0 then
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

			local var_191_6 = 1.46666666666667

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

			local var_191_9 = 1.46666666666667

			if 1.46666666666667 < arg_188_1.time_ and arg_188_1.time_ <= var_191_9 + arg_191_0 then
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

			local var_191_13 = 1.46666666666567

			arg_188_1.isInRecall_ = true

			if var_191_13 < arg_188_1.time_ and arg_188_1.time_ <= var_191_13 + arg_191_0 then
				arg_188_1.screenFilterGo_:SetActive(true)

				arg_188_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile.asset")
				arg_188_1.hightColor1 = Color.New(0.82, 0.77, 0.62)
				arg_188_1.hightColor2 = Color.New(0.46, 0.43, 0.35)

				for iter_191_2, iter_191_3 in pairs(arg_188_1.actors_) do
					for iter_191_4, iter_191_5 in ipairs((iter_191_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_191_5.color = iter_191_5.color.r > 0.51 and Color.New(0.82, 0.77, 0.62) or Color.New(0.46, 0.43, 0.35)
					end
				end
			end

			local var_191_14 = 0.0166666666666667

			if var_191_13 <= arg_188_1.time_ and arg_188_1.time_ < var_191_13 + var_191_14 then
				arg_188_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, (arg_188_1.time_ - var_191_13) / var_191_14)
			end

			if arg_188_1.time_ >= var_191_13 + var_191_14 and arg_188_1.time_ < var_191_13 + var_191_14 + arg_191_0 then
				arg_188_1.screenFilterEffect_.weight = 1
			end

			if 1.2 < arg_188_1.time_ and arg_188_1.time_ <= 1.2 + arg_191_0 then
				arg_188_1:AudioAction("play", "effect", "se_story_148", "se_story_148_amb_lost_city", "")
			end

			if arg_188_1.frameCnt_ <= 1 then
				arg_188_1.dialog_:SetActive(false)
			end

			local var_191_16 = 2.86666666666667
			local var_191_17 = 0.425

			if 2.86666666666667 < arg_188_1.time_ and arg_188_1.time_ <= var_191_16 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0

				arg_188_1.dialog_:SetActive(true)

				arg_188_1.dialogCg_.alpha = 0

				local var_191_18 = LeanTween.value(arg_188_1.dialog_, 0, 1, 0.3)

				var_191_18:setOnUpdate(LuaHelper.FloatAction(function(arg_192_0)
					arg_188_1.dialogCg_.alpha = arg_192_0
				end))
				var_191_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_188_1.dialog_)
					var_191_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_188_1.duration_ = arg_188_1.duration_ + 0.3

				SetActive(arg_188_1.leftNameGo_, true)

				arg_188_1.leftNameTxt_.text = arg_188_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_188_1.leftNameTxt_.transform)

				arg_188_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_188_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_188_1:RecordName(arg_188_1.leftNameTxt_.text)
				SetActive(arg_188_1.iconTrs_.gameObject, true)
				arg_188_1.iconController_:SetSelectedState("hero")

				arg_188_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_188_1.callingController_:SetSelectedState("normal")

				arg_188_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_188_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_191_19 = arg_188_1:FormatText(arg_188_1:GetWordFromCfg(324131047).content)

				arg_188_1.text_.text = var_191_19

				LuaForUtil.ClearLinePrefixSymbol(arg_188_1.text_)

				local var_191_21 = 17 <= 0 and var_191_17 or var_191_17 * (utf8.len(var_191_19) / 17)

				if (17 <= 0 and var_191_17 or var_191_17 * (utf8.len(var_191_19) / 17)) > 0 and var_191_17 < var_191_21 then
					arg_188_1.talkMaxDuration = var_191_21
					var_191_16 = var_191_16 + 0.3

					if var_191_21 + var_191_16 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_21 + var_191_16
					end
				end

				arg_188_1.text_.text = var_191_19
				arg_188_1.typewritter.percent = 0

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(false)
				arg_188_1:RecordContent(arg_188_1.text_.text)
			end

			local var_191_22 = var_191_16 + 0.3
			local var_191_23 = math.max(var_191_17, arg_188_1.talkMaxDuration)

			if var_191_16 + 0.3 <= arg_188_1.time_ and arg_188_1.time_ < var_191_22 + var_191_23 then
				arg_188_1.typewritter.percent = (arg_188_1.time_ - var_191_22) / var_191_23

				arg_188_1.typewritter:SetDirty()
			end

			if arg_188_1.time_ >= var_191_22 + var_191_23 and arg_188_1.time_ < var_191_22 + var_191_23 + arg_191_0 then
				arg_188_1.typewritter.percent = 1

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(true)
			end
		end

		arg_188_1.nodeConfigList_ = {}

		arg_188_1:InitPlayNodeList()
	end,
	Play324131048 = function(arg_194_0, arg_194_1)
		arg_194_1.time_ = 0
		arg_194_1.frameCnt_ = 0
		arg_194_1.state_ = "playing"
		arg_194_1.curTalkId_ = 324131048
		arg_194_1.duration_ = 11.4

		local var_194_0 = {
			zh = 9.29933333333333,
			ja = 11.3993333333333
		}
		local var_194_1 = manager.audio:GetLocalizationFlag()

		if var_194_0[var_194_1] ~= nil then
			arg_194_1.duration_ = var_194_0[var_194_1]
		end

		SetActive(arg_194_1.tipsGo_, false)

		function arg_194_1.onSingleLineFinish_()
			arg_194_1.onSingleLineUpdate_ = nil
			arg_194_1.onSingleLineFinish_ = nil
			arg_194_1.state_ = "waiting"
		end

		function arg_194_1.playNext_(arg_196_0)
			if arg_196_0 == 1 then
				arg_194_0:Play324131049(arg_194_1)
			end
		end

		function arg_194_1.onSingleLineUpdate_(arg_197_0)
			if 1.76666666666667 < arg_194_1.time_ and arg_194_1.time_ <= 1.76666666666667 + arg_197_0 then
				local var_197_0 = arg_194_1.bgs_.ST2003

				arg_194_1.bgs_.ST2003.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_197_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_197_1 = var_197_0:GetComponent("SpriteRenderer")

				if var_197_1 and var_197_1.sprite then
					local var_197_2 = 2 * (var_197_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_197_0.transform.localScale = Vector3.New(var_197_2 / var_197_1.sprite.bounds.size.y < var_197_2 * manager.ui.mainCameraCom_.aspect / var_197_1.sprite.bounds.size.x and var_197_2 * manager.ui.mainCameraCom_.aspect / var_197_1.sprite.bounds.size.x or var_197_2 / var_197_1.sprite.bounds.size.y, var_197_2 / var_197_1.sprite.bounds.size.y < var_197_2 * manager.ui.mainCameraCom_.aspect / var_197_1.sprite.bounds.size.x and var_197_2 * manager.ui.mainCameraCom_.aspect / var_197_1.sprite.bounds.size.x or var_197_2 / var_197_1.sprite.bounds.size.y, 0)
				end

				for iter_197_0, iter_197_1 in pairs(arg_194_1.bgs_) do
					if iter_197_0 ~= "ST2003" then
						iter_197_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_197_3 = 1.76666666666667

			if 1.76666666666667 < arg_194_1.time_ and arg_194_1.time_ <= var_197_3 + arg_197_0 then
				arg_194_1.allBtn_.enabled = false
			end

			if arg_194_1.time_ >= var_197_3 + 0.3 and arg_194_1.time_ < var_197_3 + 0.3 + arg_197_0 then
				arg_194_1.allBtn_.enabled = true
			end

			local var_197_4 = 0

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= var_197_4 + arg_197_0 then
				arg_194_1.mask_.enabled = true
				arg_194_1.mask_.raycastTarget = true

				arg_194_1:SetGaussion(false)
			end

			local var_197_5 = 1.76666666666667

			if var_197_4 <= arg_194_1.time_ and arg_194_1.time_ < var_197_4 + var_197_5 then
				local var_197_6 = Color.New(0, 0, 0)

				var_197_6.a = Mathf.Lerp(0, 1, (arg_194_1.time_ - var_197_4) / var_197_5)
				arg_194_1.mask_.color = var_197_6
			end

			if arg_194_1.time_ >= var_197_4 + var_197_5 and arg_194_1.time_ < var_197_4 + var_197_5 + arg_197_0 then
				local var_197_7 = Color.New(0, 0, 0)

				var_197_7.a = 1
				arg_194_1.mask_.color = var_197_7
			end

			local var_197_8 = 1.76666666666667

			if 1.76666666666667 < arg_194_1.time_ and arg_194_1.time_ <= var_197_8 + arg_197_0 then
				arg_194_1.mask_.enabled = true
				arg_194_1.mask_.raycastTarget = true

				arg_194_1:SetGaussion(false)
			end

			local var_197_9 = 2

			if var_197_8 <= arg_194_1.time_ and arg_194_1.time_ < var_197_8 + var_197_9 then
				local var_197_10 = Color.New(0, 0, 0)

				var_197_10.a = Mathf.Lerp(1, 0, (arg_194_1.time_ - var_197_8) / var_197_9)
				arg_194_1.mask_.color = var_197_10
			end

			if arg_194_1.time_ >= var_197_8 + var_197_9 and arg_194_1.time_ < var_197_8 + var_197_9 + arg_197_0 then
				local var_197_11 = Color.New(0, 0, 0)

				arg_194_1.mask_.enabled = false
				var_197_11.a = 0
				arg_194_1.mask_.color = var_197_11
			end

			local var_197_12 = arg_194_1.actors_["1070ui_story"].transform

			if 3.13333333333333 < arg_194_1.time_ and arg_194_1.time_ <= 3.13333333333333 + arg_197_0 then
				arg_194_1.var_.moveOldPos1070ui_story = var_197_12.localPosition
			end

			local var_197_13 = 0.001

			if 3.13333333333333 <= arg_194_1.time_ and arg_194_1.time_ < 3.13333333333333 + var_197_13 then
				var_197_12.localPosition = Vector3.Lerp(arg_194_1.var_.moveOldPos1070ui_story, Vector3.New(0, -0.95, -6.05), (arg_194_1.time_ - 3.13333333333333) / var_197_13)
				var_197_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_197_12.position).x, (manager.ui.mainCamera.transform.position - var_197_12.position).y, (manager.ui.mainCamera.transform.position - var_197_12.position).z)
				var_197_12.localEulerAngles.z = 0
				var_197_12.localEulerAngles.x = 0
				var_197_12.localEulerAngles = var_197_12.localEulerAngles
			end

			if arg_194_1.time_ >= 3.13333333333333 + var_197_13 and arg_194_1.time_ < 3.13333333333333 + var_197_13 + arg_197_0 then
				var_197_12.localPosition = Vector3.New(0, -0.95, -6.05)
				var_197_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_197_12.position).x, (manager.ui.mainCamera.transform.position - var_197_12.position).y, (manager.ui.mainCamera.transform.position - var_197_12.position).z)
				var_197_12.localEulerAngles.z = 0
				var_197_12.localEulerAngles.x = 0
				var_197_12.localEulerAngles = var_197_12.localEulerAngles
			end

			local var_197_14 = arg_194_1.actors_["1070ui_story"]

			if 3.13333333333333 < arg_194_1.time_ and arg_194_1.time_ <= 3.13333333333333 + arg_197_0 and not isNil(var_197_14) and arg_194_1.var_.characterEffect1070ui_story == nil then
				arg_194_1.var_.characterEffect1070ui_story = var_197_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_197_15 = 0.200000002980232

			if 3.13333333333333 <= arg_194_1.time_ and arg_194_1.time_ < 3.13333333333333 + var_197_15 and not isNil(var_197_14) then
				if arg_194_1.var_.characterEffect1070ui_story and not isNil(var_197_14) then
					arg_194_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_194_1.time_ >= 3.13333333333333 + var_197_15 and arg_194_1.time_ < 3.13333333333333 + var_197_15 + arg_197_0 and not isNil(var_197_14) and arg_194_1.var_.characterEffect1070ui_story then
				arg_194_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 3.13333333333333 < arg_194_1.time_ and arg_194_1.time_ <= 3.13333333333333 + arg_197_0 then
				arg_194_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action1_1")
			end

			if 3.13333333333333 < arg_194_1.time_ and arg_194_1.time_ <= 3.13333333333333 + arg_197_0 then
				arg_194_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_197_17 = 1.76666666666667

			arg_194_1.isInRecall_ = false

			if var_197_17 < arg_194_1.time_ and arg_194_1.time_ <= var_197_17 + arg_197_0 then
				arg_194_1.screenFilterGo_:SetActive(false)

				for iter_197_2, iter_197_3 in pairs(arg_194_1.actors_) do
					for iter_197_4, iter_197_5 in ipairs((iter_197_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_197_5.color = iter_197_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_197_18 = 0.0166666666666667

			if var_197_17 <= arg_194_1.time_ and arg_194_1.time_ < var_197_17 + var_197_18 then
				arg_194_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, (arg_194_1.time_ - var_197_17) / var_197_18)
			end

			if arg_194_1.time_ >= var_197_17 + var_197_18 and arg_194_1.time_ < var_197_17 + var_197_18 + arg_197_0 then
				arg_194_1.screenFilterEffect_.weight = 0
			end

			if 1.2 < arg_194_1.time_ and arg_194_1.time_ <= 1.2 + arg_197_0 then
				arg_194_1:AudioAction("play", "effect", "se_story_side_1049", "se_story_side_1049_amb_room", "")
			end

			if 0.1 < arg_194_1.time_ and arg_194_1.time_ <= 0.1 + arg_197_0 then
				arg_194_1:AudioAction("stop", "effect", "se_story_148", "se_story_148_amb_lost_city", "")
			end

			if arg_194_1.frameCnt_ <= 1 then
				arg_194_1.dialog_:SetActive(false)
			end

			local var_197_21 = 3.43333333333333
			local var_197_22 = 0.7

			if 3.43333333333333 < arg_194_1.time_ and arg_194_1.time_ <= var_197_21 + arg_197_0 then
				arg_194_1.talkMaxDuration = 0

				arg_194_1.dialog_:SetActive(true)

				arg_194_1.dialogCg_.alpha = 0

				local var_197_23 = LeanTween.value(arg_194_1.dialog_, 0, 1, 0.3)

				var_197_23:setOnUpdate(LuaHelper.FloatAction(function(arg_198_0)
					arg_194_1.dialogCg_.alpha = arg_198_0
				end))
				var_197_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_194_1.dialog_)
					var_197_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_194_1.duration_ = arg_194_1.duration_ + 0.3

				SetActive(arg_194_1.leftNameGo_, true)

				arg_194_1.leftNameTxt_.text = arg_194_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_194_1.leftNameTxt_.transform)

				arg_194_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_194_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_194_1:RecordName(arg_194_1.leftNameTxt_.text)
				SetActive(arg_194_1.iconTrs_.gameObject, false)
				arg_194_1.callingController_:SetSelectedState("normal")

				local var_197_24 = arg_194_1:GetWordFromCfg(324131048)
				local var_197_25 = arg_194_1:FormatText(var_197_24.content)

				arg_194_1.text_.text = var_197_25

				LuaForUtil.ClearLinePrefixSymbol(arg_194_1.text_)

				local var_197_27 = 28 <= 0 and var_197_22 or var_197_22 * (utf8.len(var_197_25) / 28)

				if (28 <= 0 and var_197_22 or var_197_22 * (utf8.len(var_197_25) / 28)) > 0 and var_197_22 < var_197_27 then
					arg_194_1.talkMaxDuration = var_197_27
					var_197_21 = var_197_21 + 0.3

					if var_197_27 + var_197_21 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_27 + var_197_21
					end
				end

				arg_194_1.text_.text = var_197_25
				arg_194_1.typewritter.percent = 0

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324131", "324131048", "story_v_out_324131.awb") ~= 0 then
					local var_197_28 = manager.audio:GetVoiceLength("story_v_out_324131", "324131048", "story_v_out_324131.awb") / 1000

					if var_197_28 + var_197_21 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_28 + var_197_21
					end

					if var_197_24.prefab_name ~= "" and arg_194_1.actors_[var_197_24.prefab_name] ~= nil then
						local var_197_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_194_1.actors_[var_197_24.prefab_name].transform, "story_v_out_324131", "324131048", "story_v_out_324131.awb")

						arg_194_1:RecordAudio("324131048", var_197_29)
						arg_194_1:RecordAudio("324131048", var_197_29)
					else
						arg_194_1:AudioAction("play", "voice", "story_v_out_324131", "324131048", "story_v_out_324131.awb")
					end

					arg_194_1:RecordHistoryTalkVoice("story_v_out_324131", "324131048", "story_v_out_324131.awb")
				end

				arg_194_1:RecordContent(arg_194_1.text_.text)
			end

			local var_197_30 = var_197_21 + 0.3
			local var_197_31 = math.max(var_197_22, arg_194_1.talkMaxDuration)

			if var_197_21 + 0.3 <= arg_194_1.time_ and arg_194_1.time_ < var_197_30 + var_197_31 then
				arg_194_1.typewritter.percent = (arg_194_1.time_ - var_197_30) / var_197_31

				arg_194_1.typewritter:SetDirty()
			end

			if arg_194_1.time_ >= var_197_30 + var_197_31 and arg_194_1.time_ < var_197_30 + var_197_31 + arg_197_0 then
				arg_194_1.typewritter.percent = 1

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(true)
			end
		end

		arg_194_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.13333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_194_1:InitPlayNodeList()
	end,
	Play324131049 = function(arg_200_0, arg_200_1)
		arg_200_1.time_ = 0
		arg_200_1.frameCnt_ = 0
		arg_200_1.state_ = "playing"
		arg_200_1.curTalkId_ = 324131049
		arg_200_1.duration_ = 3

		local var_200_0 = {
			zh = 2.566,
			ja = 3
		}
		local var_200_1 = manager.audio:GetLocalizationFlag()

		if var_200_0[var_200_1] ~= nil then
			arg_200_1.duration_ = var_200_0[var_200_1]
		end

		SetActive(arg_200_1.tipsGo_, false)

		function arg_200_1.onSingleLineFinish_()
			arg_200_1.onSingleLineUpdate_ = nil
			arg_200_1.onSingleLineFinish_ = nil
			arg_200_1.state_ = "waiting"
		end

		function arg_200_1.playNext_(arg_202_0)
			if arg_202_0 == 1 then
				arg_200_0:Play324131050(arg_200_1)
			end
		end

		function arg_200_1.onSingleLineUpdate_(arg_203_0)
			local var_203_0 = 0.2

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 then
				arg_200_1.talkMaxDuration = 0
				arg_200_1.dialogCg_.alpha = 1

				arg_200_1.dialog_:SetActive(true)
				SetActive(arg_200_1.leftNameGo_, true)

				arg_200_1.leftNameTxt_.text = arg_200_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_200_1.leftNameTxt_.transform)

				arg_200_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_200_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_200_1:RecordName(arg_200_1.leftNameTxt_.text)
				SetActive(arg_200_1.iconTrs_.gameObject, false)
				arg_200_1.callingController_:SetSelectedState("normal")

				local var_203_1 = arg_200_1:GetWordFromCfg(324131049)
				local var_203_2 = arg_200_1:FormatText(var_203_1.content)

				arg_200_1.text_.text = var_203_2

				LuaForUtil.ClearLinePrefixSymbol(arg_200_1.text_)

				local var_203_4 = 8 <= 0 and var_203_0 or var_203_0 * (utf8.len(var_203_2) / 8)

				if (8 <= 0 and var_203_0 or var_203_0 * (utf8.len(var_203_2) / 8)) > 0 and var_203_0 < var_203_4 then
					arg_200_1.talkMaxDuration = var_203_4

					if var_203_4 + 0 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_4 + 0
					end
				end

				arg_200_1.text_.text = var_203_2
				arg_200_1.typewritter.percent = 0

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324131", "324131049", "story_v_out_324131.awb") ~= 0 then
					local var_203_5 = manager.audio:GetVoiceLength("story_v_out_324131", "324131049", "story_v_out_324131.awb") / 1000

					if var_203_5 + 0 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_5 + 0
					end

					if var_203_1.prefab_name ~= "" and arg_200_1.actors_[var_203_1.prefab_name] ~= nil then
						local var_203_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_200_1.actors_[var_203_1.prefab_name].transform, "story_v_out_324131", "324131049", "story_v_out_324131.awb")

						arg_200_1:RecordAudio("324131049", var_203_6)
						arg_200_1:RecordAudio("324131049", var_203_6)
					else
						arg_200_1:AudioAction("play", "voice", "story_v_out_324131", "324131049", "story_v_out_324131.awb")
					end

					arg_200_1:RecordHistoryTalkVoice("story_v_out_324131", "324131049", "story_v_out_324131.awb")
				end

				arg_200_1:RecordContent(arg_200_1.text_.text)
			end

			local var_203_7 = math.max(var_203_0, arg_200_1.talkMaxDuration)

			if 0 <= arg_200_1.time_ and arg_200_1.time_ < 0 + var_203_7 then
				arg_200_1.typewritter.percent = (arg_200_1.time_ - 0) / var_203_7

				arg_200_1.typewritter:SetDirty()
			end

			if arg_200_1.time_ >= 0 + var_203_7 and arg_200_1.time_ < 0 + var_203_7 + arg_203_0 then
				arg_200_1.typewritter.percent = 1

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(true)
			end
		end

		arg_200_1.nodeConfigList_ = {}

		arg_200_1:InitPlayNodeList()
	end,
	Play324131050 = function(arg_204_0, arg_204_1)
		arg_204_1.time_ = 0
		arg_204_1.frameCnt_ = 0
		arg_204_1.state_ = "playing"
		arg_204_1.curTalkId_ = 324131050
		arg_204_1.duration_ = 5

		SetActive(arg_204_1.tipsGo_, false)

		function arg_204_1.onSingleLineFinish_()
			arg_204_1.onSingleLineUpdate_ = nil
			arg_204_1.onSingleLineFinish_ = nil
			arg_204_1.state_ = "waiting"
		end

		function arg_204_1.playNext_(arg_206_0)
			if arg_206_0 == 1 then
				arg_204_0:Play324131051(arg_204_1)
			end
		end

		function arg_204_1.onSingleLineUpdate_(arg_207_0)
			if 0 < arg_204_1.time_ and arg_204_1.time_ <= 0 + arg_207_0 then
				arg_204_1.var_.moveOldPos1070ui_story = arg_204_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_207_0 = 0.001

			if 0 <= arg_204_1.time_ and arg_204_1.time_ < 0 + var_207_0 then
				arg_204_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_204_1.var_.moveOldPos1070ui_story, Vector3.New(0, 100, 0), (arg_204_1.time_ - 0) / var_207_0)
				arg_204_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_204_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_204_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_204_1.actors_["1070ui_story"].transform.position).z)
				arg_204_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_204_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_204_1.actors_["1070ui_story"].transform.localEulerAngles = arg_204_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_204_1.time_ >= 0 + var_207_0 and arg_204_1.time_ < 0 + var_207_0 + arg_207_0 then
				arg_204_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_204_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_204_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_204_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_204_1.actors_["1070ui_story"].transform.position).z)
				arg_204_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_204_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_204_1.actors_["1070ui_story"].transform.localEulerAngles = arg_204_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_207_1 = arg_204_1.actors_["1070ui_story"]

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= 0 + arg_207_0 and not isNil(var_207_1) and arg_204_1.var_.characterEffect1070ui_story == nil then
				arg_204_1.var_.characterEffect1070ui_story = var_207_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_207_2 = 0.200000002980232

			if 0 <= arg_204_1.time_ and arg_204_1.time_ < 0 + var_207_2 and not isNil(var_207_1) then
				if arg_204_1.var_.characterEffect1070ui_story and not isNil(var_207_1) then
					arg_204_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_204_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_204_1.time_ - 0) / var_207_2)
				end
			end

			if arg_204_1.time_ >= 0 + var_207_2 and arg_204_1.time_ < 0 + var_207_2 + arg_207_0 and not isNil(var_207_1) and arg_204_1.var_.characterEffect1070ui_story then
				arg_204_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_204_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_207_3 = 0
			local var_207_4 = 1.175

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= var_207_3 + arg_207_0 then
				arg_204_1.talkMaxDuration = 0
				arg_204_1.dialogCg_.alpha = 1

				arg_204_1.dialog_:SetActive(true)
				SetActive(arg_204_1.leftNameGo_, false)

				arg_204_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_204_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_204_1:RecordName(arg_204_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_204_1.iconTrs_.gameObject, false)
				arg_204_1.callingController_:SetSelectedState("normal")

				local var_207_5 = arg_204_1:FormatText(arg_204_1:GetWordFromCfg(324131050).content)

				arg_204_1.text_.text = var_207_5

				LuaForUtil.ClearLinePrefixSymbol(arg_204_1.text_)

				local var_207_7 = 47 <= 0 and var_207_4 or var_207_4 * (utf8.len(var_207_5) / 47)

				if (47 <= 0 and var_207_4 or var_207_4 * (utf8.len(var_207_5) / 47)) > 0 and var_207_4 < var_207_7 then
					arg_204_1.talkMaxDuration = var_207_7

					if var_207_7 + var_207_3 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_7 + var_207_3
					end
				end

				arg_204_1.text_.text = var_207_5
				arg_204_1.typewritter.percent = 0

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(false)
				arg_204_1:RecordContent(arg_204_1.text_.text)
			end

			local var_207_8 = math.max(var_207_4, arg_204_1.talkMaxDuration)

			if var_207_3 <= arg_204_1.time_ and arg_204_1.time_ < var_207_3 + var_207_8 then
				arg_204_1.typewritter.percent = (arg_204_1.time_ - var_207_3) / var_207_8

				arg_204_1.typewritter:SetDirty()
			end

			if arg_204_1.time_ >= var_207_3 + var_207_8 and arg_204_1.time_ < var_207_3 + var_207_8 + arg_207_0 then
				arg_204_1.typewritter.percent = 1

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(true)
			end
		end

		arg_204_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_204_1:InitPlayNodeList()
	end,
	Play324131051 = function(arg_208_0, arg_208_1)
		arg_208_1.time_ = 0
		arg_208_1.frameCnt_ = 0
		arg_208_1.state_ = "playing"
		arg_208_1.curTalkId_ = 324131051
		arg_208_1.duration_ = 11.4

		local var_208_0 = {
			zh = 6.8,
			ja = 11.4
		}
		local var_208_1 = manager.audio:GetLocalizationFlag()

		if var_208_0[var_208_1] ~= nil then
			arg_208_1.duration_ = var_208_0[var_208_1]
		end

		SetActive(arg_208_1.tipsGo_, false)

		function arg_208_1.onSingleLineFinish_()
			arg_208_1.onSingleLineUpdate_ = nil
			arg_208_1.onSingleLineFinish_ = nil
			arg_208_1.state_ = "waiting"
		end

		function arg_208_1.playNext_(arg_210_0)
			if arg_210_0 == 1 then
				arg_208_0:Play324131052(arg_208_1)
			end
		end

		function arg_208_1.onSingleLineUpdate_(arg_211_0)
			if 0 < arg_208_1.time_ and arg_208_1.time_ <= 0 + arg_211_0 then
				arg_208_1.var_.moveOldPos1053ui_story = arg_208_1.actors_["1053ui_story"].transform.localPosition

				local var_211_0 = GameObjectTools.GetOrAddComponent(arg_208_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_211_0 then
					var_211_0:EnableDynamicBone(false)
				end
			end

			local var_211_1 = 0.001

			if 0 <= arg_208_1.time_ and arg_208_1.time_ < 0 + var_211_1 then
				arg_208_1.actors_["1053ui_story"].transform.localPosition = Vector3.Lerp(arg_208_1.var_.moveOldPos1053ui_story, Vector3.New(0, -1.08, -6), (arg_208_1.time_ - 0) / var_211_1)
				arg_208_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_208_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_208_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_208_1.actors_["1053ui_story"].transform.position).z)
				arg_208_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_208_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_208_1.actors_["1053ui_story"].transform.localEulerAngles = arg_208_1.actors_["1053ui_story"].transform.localEulerAngles
			end

			if arg_208_1.time_ >= 0 + var_211_1 and arg_208_1.time_ < 0 + var_211_1 + arg_211_0 then
				arg_208_1.actors_["1053ui_story"].transform.localPosition = Vector3.New(0, -1.08, -6)
				arg_208_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_208_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_208_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_208_1.actors_["1053ui_story"].transform.position).z)
				arg_208_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_208_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_208_1.actors_["1053ui_story"].transform.localEulerAngles = arg_208_1.actors_["1053ui_story"].transform.localEulerAngles

				local var_211_2 = GameObjectTools.GetOrAddComponent(arg_208_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_211_2 then
					var_211_2:EnableDynamicBone(true)
				end
			end

			local var_211_3 = arg_208_1.actors_["1053ui_story"]

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= 0 + arg_211_0 and not isNil(var_211_3) and arg_208_1.var_.characterEffect1053ui_story == nil then
				arg_208_1.var_.characterEffect1053ui_story = var_211_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_211_4 = 0.200000002980232

			if 0 <= arg_208_1.time_ and arg_208_1.time_ < 0 + var_211_4 and not isNil(var_211_3) then
				if arg_208_1.var_.characterEffect1053ui_story and not isNil(var_211_3) then
					arg_208_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_208_1.time_ >= 0 + var_211_4 and arg_208_1.time_ < 0 + var_211_4 + arg_211_0 and not isNil(var_211_3) and arg_208_1.var_.characterEffect1053ui_story then
				arg_208_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= 0 + arg_211_0 then
				arg_208_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053action/1053action2_1")
			end

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= 0 + arg_211_0 then
				arg_208_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_211_6 = 0
			local var_211_7 = 0.6

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= var_211_6 + arg_211_0 then
				arg_208_1.talkMaxDuration = 0
				arg_208_1.dialogCg_.alpha = 1

				arg_208_1.dialog_:SetActive(true)
				SetActive(arg_208_1.leftNameGo_, true)

				arg_208_1.leftNameTxt_.text = arg_208_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_208_1.leftNameTxt_.transform)

				arg_208_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_208_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_208_1:RecordName(arg_208_1.leftNameTxt_.text)
				SetActive(arg_208_1.iconTrs_.gameObject, false)
				arg_208_1.callingController_:SetSelectedState("normal")

				local var_211_8 = arg_208_1:GetWordFromCfg(324131051)
				local var_211_9 = arg_208_1:FormatText(var_211_8.content)

				arg_208_1.text_.text = var_211_9

				LuaForUtil.ClearLinePrefixSymbol(arg_208_1.text_)

				local var_211_11 = 24 <= 0 and var_211_7 or var_211_7 * (utf8.len(var_211_9) / 24)

				if (24 <= 0 and var_211_7 or var_211_7 * (utf8.len(var_211_9) / 24)) > 0 and var_211_7 < var_211_11 then
					arg_208_1.talkMaxDuration = var_211_11

					if var_211_11 + var_211_6 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_11 + var_211_6
					end
				end

				arg_208_1.text_.text = var_211_9
				arg_208_1.typewritter.percent = 0

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324131", "324131051", "story_v_out_324131.awb") ~= 0 then
					local var_211_12 = manager.audio:GetVoiceLength("story_v_out_324131", "324131051", "story_v_out_324131.awb") / 1000

					if var_211_12 + var_211_6 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_12 + var_211_6
					end

					if var_211_8.prefab_name ~= "" and arg_208_1.actors_[var_211_8.prefab_name] ~= nil then
						local var_211_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_208_1.actors_[var_211_8.prefab_name].transform, "story_v_out_324131", "324131051", "story_v_out_324131.awb")

						arg_208_1:RecordAudio("324131051", var_211_13)
						arg_208_1:RecordAudio("324131051", var_211_13)
					else
						arg_208_1:AudioAction("play", "voice", "story_v_out_324131", "324131051", "story_v_out_324131.awb")
					end

					arg_208_1:RecordHistoryTalkVoice("story_v_out_324131", "324131051", "story_v_out_324131.awb")
				end

				arg_208_1:RecordContent(arg_208_1.text_.text)
			end

			local var_211_14 = math.max(var_211_7, arg_208_1.talkMaxDuration)

			if var_211_6 <= arg_208_1.time_ and arg_208_1.time_ < var_211_6 + var_211_14 then
				arg_208_1.typewritter.percent = (arg_208_1.time_ - var_211_6) / var_211_14

				arg_208_1.typewritter:SetDirty()
			end

			if arg_208_1.time_ >= var_211_6 + var_211_14 and arg_208_1.time_ < var_211_6 + var_211_14 + arg_211_0 then
				arg_208_1.typewritter.percent = 1

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(true)
			end
		end

		arg_208_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_208_1:InitPlayNodeList()
	end,
	Play324131052 = function(arg_212_0, arg_212_1)
		arg_212_1.time_ = 0
		arg_212_1.frameCnt_ = 0
		arg_212_1.state_ = "playing"
		arg_212_1.curTalkId_ = 324131052
		arg_212_1.duration_ = 5.23

		local var_212_0 = {
			zh = 4.866,
			ja = 5.233
		}
		local var_212_1 = manager.audio:GetLocalizationFlag()

		if var_212_0[var_212_1] ~= nil then
			arg_212_1.duration_ = var_212_0[var_212_1]
		end

		SetActive(arg_212_1.tipsGo_, false)

		function arg_212_1.onSingleLineFinish_()
			arg_212_1.onSingleLineUpdate_ = nil
			arg_212_1.onSingleLineFinish_ = nil
			arg_212_1.state_ = "waiting"
		end

		function arg_212_1.playNext_(arg_214_0)
			if arg_214_0 == 1 then
				arg_212_0:Play324131053(arg_212_1)
			end
		end

		function arg_212_1.onSingleLineUpdate_(arg_215_0)
			local var_215_0 = 0.425

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= 0 + arg_215_0 then
				arg_212_1.talkMaxDuration = 0
				arg_212_1.dialogCg_.alpha = 1

				arg_212_1.dialog_:SetActive(true)
				SetActive(arg_212_1.leftNameGo_, true)

				arg_212_1.leftNameTxt_.text = arg_212_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_212_1.leftNameTxt_.transform)

				arg_212_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_212_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_212_1:RecordName(arg_212_1.leftNameTxt_.text)
				SetActive(arg_212_1.iconTrs_.gameObject, false)
				arg_212_1.callingController_:SetSelectedState("normal")

				local var_215_1 = arg_212_1:GetWordFromCfg(324131052)
				local var_215_2 = arg_212_1:FormatText(var_215_1.content)

				arg_212_1.text_.text = var_215_2

				LuaForUtil.ClearLinePrefixSymbol(arg_212_1.text_)

				local var_215_4 = 17 <= 0 and var_215_0 or var_215_0 * (utf8.len(var_215_2) / 17)

				if (17 <= 0 and var_215_0 or var_215_0 * (utf8.len(var_215_2) / 17)) > 0 and var_215_0 < var_215_4 then
					arg_212_1.talkMaxDuration = var_215_4

					if var_215_4 + 0 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_4 + 0
					end
				end

				arg_212_1.text_.text = var_215_2
				arg_212_1.typewritter.percent = 0

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324131", "324131052", "story_v_out_324131.awb") ~= 0 then
					local var_215_5 = manager.audio:GetVoiceLength("story_v_out_324131", "324131052", "story_v_out_324131.awb") / 1000

					if var_215_5 + 0 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_5 + 0
					end

					if var_215_1.prefab_name ~= "" and arg_212_1.actors_[var_215_1.prefab_name] ~= nil then
						local var_215_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_212_1.actors_[var_215_1.prefab_name].transform, "story_v_out_324131", "324131052", "story_v_out_324131.awb")

						arg_212_1:RecordAudio("324131052", var_215_6)
						arg_212_1:RecordAudio("324131052", var_215_6)
					else
						arg_212_1:AudioAction("play", "voice", "story_v_out_324131", "324131052", "story_v_out_324131.awb")
					end

					arg_212_1:RecordHistoryTalkVoice("story_v_out_324131", "324131052", "story_v_out_324131.awb")
				end

				arg_212_1:RecordContent(arg_212_1.text_.text)
			end

			local var_215_7 = math.max(var_215_0, arg_212_1.talkMaxDuration)

			if 0 <= arg_212_1.time_ and arg_212_1.time_ < 0 + var_215_7 then
				arg_212_1.typewritter.percent = (arg_212_1.time_ - 0) / var_215_7

				arg_212_1.typewritter:SetDirty()
			end

			if arg_212_1.time_ >= 0 + var_215_7 and arg_212_1.time_ < 0 + var_215_7 + arg_215_0 then
				arg_212_1.typewritter.percent = 1

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(true)
			end
		end

		arg_212_1.nodeConfigList_ = {}

		arg_212_1:InitPlayNodeList()
	end,
	Play324131053 = function(arg_216_0, arg_216_1)
		arg_216_1.time_ = 0
		arg_216_1.frameCnt_ = 0
		arg_216_1.state_ = "playing"
		arg_216_1.curTalkId_ = 324131053
		arg_216_1.duration_ = 5

		SetActive(arg_216_1.tipsGo_, false)

		function arg_216_1.onSingleLineFinish_()
			arg_216_1.onSingleLineUpdate_ = nil
			arg_216_1.onSingleLineFinish_ = nil
			arg_216_1.state_ = "waiting"
		end

		function arg_216_1.playNext_(arg_218_0)
			if arg_218_0 == 1 then
				arg_216_0:Play324131054(arg_216_1)
			end
		end

		function arg_216_1.onSingleLineUpdate_(arg_219_0)
			if 0 < arg_216_1.time_ and arg_216_1.time_ <= 0 + arg_219_0 then
				arg_216_1.var_.moveOldPos1053ui_story = arg_216_1.actors_["1053ui_story"].transform.localPosition

				local var_219_0 = GameObjectTools.GetOrAddComponent(arg_216_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_219_0 then
					var_219_0:EnableDynamicBone(false)
				end
			end

			local var_219_1 = 0.001

			if 0 <= arg_216_1.time_ and arg_216_1.time_ < 0 + var_219_1 then
				arg_216_1.actors_["1053ui_story"].transform.localPosition = Vector3.Lerp(arg_216_1.var_.moveOldPos1053ui_story, Vector3.New(0, 100, 0), (arg_216_1.time_ - 0) / var_219_1)
				arg_216_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_216_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_216_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_216_1.actors_["1053ui_story"].transform.position).z)
				arg_216_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_216_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_216_1.actors_["1053ui_story"].transform.localEulerAngles = arg_216_1.actors_["1053ui_story"].transform.localEulerAngles
			end

			if arg_216_1.time_ >= 0 + var_219_1 and arg_216_1.time_ < 0 + var_219_1 + arg_219_0 then
				arg_216_1.actors_["1053ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_216_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_216_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_216_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_216_1.actors_["1053ui_story"].transform.position).z)
				arg_216_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_216_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_216_1.actors_["1053ui_story"].transform.localEulerAngles = arg_216_1.actors_["1053ui_story"].transform.localEulerAngles

				local var_219_2 = GameObjectTools.GetOrAddComponent(arg_216_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_219_2 then
					var_219_2:EnableDynamicBone(true)
				end
			end

			local var_219_3 = arg_216_1.actors_["1053ui_story"]

			if 0 < arg_216_1.time_ and arg_216_1.time_ <= 0 + arg_219_0 and not isNil(var_219_3) and arg_216_1.var_.characterEffect1053ui_story == nil then
				arg_216_1.var_.characterEffect1053ui_story = var_219_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_219_4 = 0.200000002980232

			if 0 <= arg_216_1.time_ and arg_216_1.time_ < 0 + var_219_4 and not isNil(var_219_3) then
				if arg_216_1.var_.characterEffect1053ui_story and not isNil(var_219_3) then
					arg_216_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_216_1.var_.characterEffect1053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_216_1.time_ - 0) / var_219_4)
				end
			end

			if arg_216_1.time_ >= 0 + var_219_4 and arg_216_1.time_ < 0 + var_219_4 + arg_219_0 and not isNil(var_219_3) and arg_216_1.var_.characterEffect1053ui_story then
				arg_216_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_216_1.var_.characterEffect1053ui_story.fillRatio = 0.5
			end

			local var_219_5 = 0
			local var_219_6 = 1.45

			if 0 < arg_216_1.time_ and arg_216_1.time_ <= var_219_5 + arg_219_0 then
				arg_216_1.talkMaxDuration = 0
				arg_216_1.dialogCg_.alpha = 1

				arg_216_1.dialog_:SetActive(true)
				SetActive(arg_216_1.leftNameGo_, false)

				arg_216_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_216_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_216_1:RecordName(arg_216_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_216_1.iconTrs_.gameObject, false)
				arg_216_1.callingController_:SetSelectedState("normal")

				local var_219_7 = arg_216_1:FormatText(arg_216_1:GetWordFromCfg(324131053).content)

				arg_216_1.text_.text = var_219_7

				LuaForUtil.ClearLinePrefixSymbol(arg_216_1.text_)

				local var_219_9 = 58 <= 0 and var_219_6 or var_219_6 * (utf8.len(var_219_7) / 58)

				if (58 <= 0 and var_219_6 or var_219_6 * (utf8.len(var_219_7) / 58)) > 0 and var_219_6 < var_219_9 then
					arg_216_1.talkMaxDuration = var_219_9

					if var_219_9 + var_219_5 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_9 + var_219_5
					end
				end

				arg_216_1.text_.text = var_219_7
				arg_216_1.typewritter.percent = 0

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(false)
				arg_216_1:RecordContent(arg_216_1.text_.text)
			end

			local var_219_10 = math.max(var_219_6, arg_216_1.talkMaxDuration)

			if var_219_5 <= arg_216_1.time_ and arg_216_1.time_ < var_219_5 + var_219_10 then
				arg_216_1.typewritter.percent = (arg_216_1.time_ - var_219_5) / var_219_10

				arg_216_1.typewritter:SetDirty()
			end

			if arg_216_1.time_ >= var_219_5 + var_219_10 and arg_216_1.time_ < var_219_5 + var_219_10 + arg_219_0 then
				arg_216_1.typewritter.percent = 1

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(true)
			end
		end

		arg_216_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_216_1:InitPlayNodeList()
	end,
	Play324131054 = function(arg_220_0, arg_220_1)
		arg_220_1.time_ = 0
		arg_220_1.frameCnt_ = 0
		arg_220_1.state_ = "playing"
		arg_220_1.curTalkId_ = 324131054
		arg_220_1.duration_ = 4.17

		local var_220_0 = {
			zh = 4.166,
			ja = 3
		}
		local var_220_1 = manager.audio:GetLocalizationFlag()

		if var_220_0[var_220_1] ~= nil then
			arg_220_1.duration_ = var_220_0[var_220_1]
		end

		SetActive(arg_220_1.tipsGo_, false)

		function arg_220_1.onSingleLineFinish_()
			arg_220_1.onSingleLineUpdate_ = nil
			arg_220_1.onSingleLineFinish_ = nil
			arg_220_1.state_ = "waiting"
		end

		function arg_220_1.playNext_(arg_222_0)
			if arg_222_0 == 1 then
				arg_220_0:Play324131055(arg_220_1)
			end
		end

		function arg_220_1.onSingleLineUpdate_(arg_223_0)
			if 0 < arg_220_1.time_ and arg_220_1.time_ <= 0 + arg_223_0 then
				arg_220_1.var_.moveOldPos1070ui_story = arg_220_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_223_0 = 0.001

			if 0 <= arg_220_1.time_ and arg_220_1.time_ < 0 + var_223_0 then
				arg_220_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_220_1.var_.moveOldPos1070ui_story, Vector3.New(-0.7, -0.95, -6.05), (arg_220_1.time_ - 0) / var_223_0)
				arg_220_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_220_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_220_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_220_1.actors_["1070ui_story"].transform.position).z)
				arg_220_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_220_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_220_1.actors_["1070ui_story"].transform.localEulerAngles = arg_220_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_220_1.time_ >= 0 + var_223_0 and arg_220_1.time_ < 0 + var_223_0 + arg_223_0 then
				arg_220_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(-0.7, -0.95, -6.05)
				arg_220_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_220_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_220_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_220_1.actors_["1070ui_story"].transform.position).z)
				arg_220_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_220_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_220_1.actors_["1070ui_story"].transform.localEulerAngles = arg_220_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_223_1 = arg_220_1.actors_["1070ui_story"]

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= 0 + arg_223_0 and not isNil(var_223_1) and arg_220_1.var_.characterEffect1070ui_story == nil then
				arg_220_1.var_.characterEffect1070ui_story = var_223_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_223_2 = 0.200000002980232

			if 0 <= arg_220_1.time_ and arg_220_1.time_ < 0 + var_223_2 and not isNil(var_223_1) then
				if arg_220_1.var_.characterEffect1070ui_story and not isNil(var_223_1) then
					arg_220_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_220_1.time_ >= 0 + var_223_2 and arg_220_1.time_ < 0 + var_223_2 + arg_223_0 and not isNil(var_223_1) and arg_220_1.var_.characterEffect1070ui_story then
				arg_220_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= 0 + arg_223_0 then
				arg_220_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action5_1")
			end

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= 0 + arg_223_0 then
				arg_220_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_223_4 = 0
			local var_223_5 = 0.225

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= var_223_4 + arg_223_0 then
				arg_220_1.talkMaxDuration = 0
				arg_220_1.dialogCg_.alpha = 1

				arg_220_1.dialog_:SetActive(true)
				SetActive(arg_220_1.leftNameGo_, true)

				arg_220_1.leftNameTxt_.text = arg_220_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_220_1.leftNameTxt_.transform)

				arg_220_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_220_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_220_1:RecordName(arg_220_1.leftNameTxt_.text)
				SetActive(arg_220_1.iconTrs_.gameObject, false)
				arg_220_1.callingController_:SetSelectedState("normal")

				local var_223_6 = arg_220_1:GetWordFromCfg(324131054)
				local var_223_7 = arg_220_1:FormatText(var_223_6.content)

				arg_220_1.text_.text = var_223_7

				LuaForUtil.ClearLinePrefixSymbol(arg_220_1.text_)

				local var_223_9 = 9 <= 0 and var_223_5 or var_223_5 * (utf8.len(var_223_7) / 9)

				if (9 <= 0 and var_223_5 or var_223_5 * (utf8.len(var_223_7) / 9)) > 0 and var_223_5 < var_223_9 then
					arg_220_1.talkMaxDuration = var_223_9

					if var_223_9 + var_223_4 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_9 + var_223_4
					end
				end

				arg_220_1.text_.text = var_223_7
				arg_220_1.typewritter.percent = 0

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324131", "324131054", "story_v_out_324131.awb") ~= 0 then
					local var_223_10 = manager.audio:GetVoiceLength("story_v_out_324131", "324131054", "story_v_out_324131.awb") / 1000

					if var_223_10 + var_223_4 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_10 + var_223_4
					end

					if var_223_6.prefab_name ~= "" and arg_220_1.actors_[var_223_6.prefab_name] ~= nil then
						local var_223_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_220_1.actors_[var_223_6.prefab_name].transform, "story_v_out_324131", "324131054", "story_v_out_324131.awb")

						arg_220_1:RecordAudio("324131054", var_223_11)
						arg_220_1:RecordAudio("324131054", var_223_11)
					else
						arg_220_1:AudioAction("play", "voice", "story_v_out_324131", "324131054", "story_v_out_324131.awb")
					end

					arg_220_1:RecordHistoryTalkVoice("story_v_out_324131", "324131054", "story_v_out_324131.awb")
				end

				arg_220_1:RecordContent(arg_220_1.text_.text)
			end

			local var_223_12 = math.max(var_223_5, arg_220_1.talkMaxDuration)

			if var_223_4 <= arg_220_1.time_ and arg_220_1.time_ < var_223_4 + var_223_12 then
				arg_220_1.typewritter.percent = (arg_220_1.time_ - var_223_4) / var_223_12

				arg_220_1.typewritter:SetDirty()
			end

			if arg_220_1.time_ >= var_223_4 + var_223_12 and arg_220_1.time_ < var_223_4 + var_223_12 + arg_223_0 then
				arg_220_1.typewritter.percent = 1

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(true)
			end
		end

		arg_220_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_220_1:InitPlayNodeList()
	end,
	Play324131055 = function(arg_224_0, arg_224_1)
		arg_224_1.time_ = 0
		arg_224_1.frameCnt_ = 0
		arg_224_1.state_ = "playing"
		arg_224_1.curTalkId_ = 324131055
		arg_224_1.duration_ = 3.67

		local var_224_0 = {
			zh = 1.999999999999,
			ja = 3.666
		}
		local var_224_1 = manager.audio:GetLocalizationFlag()

		if var_224_0[var_224_1] ~= nil then
			arg_224_1.duration_ = var_224_0[var_224_1]
		end

		SetActive(arg_224_1.tipsGo_, false)

		function arg_224_1.onSingleLineFinish_()
			arg_224_1.onSingleLineUpdate_ = nil
			arg_224_1.onSingleLineFinish_ = nil
			arg_224_1.state_ = "waiting"
		end

		function arg_224_1.playNext_(arg_226_0)
			if arg_226_0 == 1 then
				arg_224_0:Play324131056(arg_224_1)
			end
		end

		function arg_224_1.onSingleLineUpdate_(arg_227_0)
			if 0 < arg_224_1.time_ and arg_224_1.time_ <= 0 + arg_227_0 then
				arg_224_1.var_.moveOldPos1053ui_story = arg_224_1.actors_["1053ui_story"].transform.localPosition

				local var_227_0 = GameObjectTools.GetOrAddComponent(arg_224_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_227_0 then
					var_227_0:EnableDynamicBone(false)
				end
			end

			local var_227_1 = 0.001

			if 0 <= arg_224_1.time_ and arg_224_1.time_ < 0 + var_227_1 then
				arg_224_1.actors_["1053ui_story"].transform.localPosition = Vector3.Lerp(arg_224_1.var_.moveOldPos1053ui_story, Vector3.New(0.7, -1.08, -6), (arg_224_1.time_ - 0) / var_227_1)
				arg_224_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_224_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_224_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_224_1.actors_["1053ui_story"].transform.position).z)
				arg_224_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_224_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_224_1.actors_["1053ui_story"].transform.localEulerAngles = arg_224_1.actors_["1053ui_story"].transform.localEulerAngles
			end

			if arg_224_1.time_ >= 0 + var_227_1 and arg_224_1.time_ < 0 + var_227_1 + arg_227_0 then
				arg_224_1.actors_["1053ui_story"].transform.localPosition = Vector3.New(0.7, -1.08, -6)
				arg_224_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_224_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_224_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_224_1.actors_["1053ui_story"].transform.position).z)
				arg_224_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_224_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_224_1.actors_["1053ui_story"].transform.localEulerAngles = arg_224_1.actors_["1053ui_story"].transform.localEulerAngles

				local var_227_2 = GameObjectTools.GetOrAddComponent(arg_224_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_227_2 then
					var_227_2:EnableDynamicBone(true)
				end
			end

			local var_227_3 = arg_224_1.actors_["1053ui_story"]

			if 0 < arg_224_1.time_ and arg_224_1.time_ <= 0 + arg_227_0 and not isNil(var_227_3) and arg_224_1.var_.characterEffect1053ui_story == nil then
				arg_224_1.var_.characterEffect1053ui_story = var_227_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_227_4 = 0.200000002980232

			if 0 <= arg_224_1.time_ and arg_224_1.time_ < 0 + var_227_4 and not isNil(var_227_3) then
				if arg_224_1.var_.characterEffect1053ui_story and not isNil(var_227_3) then
					arg_224_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_224_1.time_ >= 0 + var_227_4 and arg_224_1.time_ < 0 + var_227_4 + arg_227_0 and not isNil(var_227_3) and arg_224_1.var_.characterEffect1053ui_story then
				arg_224_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_227_6 = arg_224_1.actors_["1070ui_story"]

			if 0 < arg_224_1.time_ and arg_224_1.time_ <= 0 + arg_227_0 and not isNil(var_227_6) and arg_224_1.var_.characterEffect1070ui_story == nil then
				arg_224_1.var_.characterEffect1070ui_story = var_227_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_227_7 = 0.200000002980232

			if 0 <= arg_224_1.time_ and arg_224_1.time_ < 0 + var_227_7 and not isNil(var_227_6) then
				if arg_224_1.var_.characterEffect1070ui_story and not isNil(var_227_6) then
					arg_224_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_224_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_224_1.time_ - 0) / var_227_7)
				end
			end

			if arg_224_1.time_ >= 0 + var_227_7 and arg_224_1.time_ < 0 + var_227_7 + arg_227_0 and not isNil(var_227_6) and arg_224_1.var_.characterEffect1070ui_story then
				arg_224_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_224_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			if 0 < arg_224_1.time_ and arg_224_1.time_ <= 0 + arg_227_0 then
				arg_224_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053action/1053action2_2")
			end

			if 0 < arg_224_1.time_ and arg_224_1.time_ <= 0 + arg_227_0 then
				arg_224_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_227_8 = 0
			local var_227_9 = 0.175

			if 0 < arg_224_1.time_ and arg_224_1.time_ <= var_227_8 + arg_227_0 then
				arg_224_1.talkMaxDuration = 0
				arg_224_1.dialogCg_.alpha = 1

				arg_224_1.dialog_:SetActive(true)
				SetActive(arg_224_1.leftNameGo_, true)

				arg_224_1.leftNameTxt_.text = arg_224_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_224_1.leftNameTxt_.transform)

				arg_224_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_224_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_224_1:RecordName(arg_224_1.leftNameTxt_.text)
				SetActive(arg_224_1.iconTrs_.gameObject, false)
				arg_224_1.callingController_:SetSelectedState("normal")

				local var_227_10 = arg_224_1:GetWordFromCfg(324131055)
				local var_227_11 = arg_224_1:FormatText(var_227_10.content)

				arg_224_1.text_.text = var_227_11

				LuaForUtil.ClearLinePrefixSymbol(arg_224_1.text_)

				local var_227_13 = 7 <= 0 and var_227_9 or var_227_9 * (utf8.len(var_227_11) / 7)

				if (7 <= 0 and var_227_9 or var_227_9 * (utf8.len(var_227_11) / 7)) > 0 and var_227_9 < var_227_13 then
					arg_224_1.talkMaxDuration = var_227_13

					if var_227_13 + var_227_8 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_13 + var_227_8
					end
				end

				arg_224_1.text_.text = var_227_11
				arg_224_1.typewritter.percent = 0

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324131", "324131055", "story_v_out_324131.awb") ~= 0 then
					local var_227_14 = manager.audio:GetVoiceLength("story_v_out_324131", "324131055", "story_v_out_324131.awb") / 1000

					if var_227_14 + var_227_8 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_14 + var_227_8
					end

					if var_227_10.prefab_name ~= "" and arg_224_1.actors_[var_227_10.prefab_name] ~= nil then
						local var_227_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_224_1.actors_[var_227_10.prefab_name].transform, "story_v_out_324131", "324131055", "story_v_out_324131.awb")

						arg_224_1:RecordAudio("324131055", var_227_15)
						arg_224_1:RecordAudio("324131055", var_227_15)
					else
						arg_224_1:AudioAction("play", "voice", "story_v_out_324131", "324131055", "story_v_out_324131.awb")
					end

					arg_224_1:RecordHistoryTalkVoice("story_v_out_324131", "324131055", "story_v_out_324131.awb")
				end

				arg_224_1:RecordContent(arg_224_1.text_.text)
			end

			local var_227_16 = math.max(var_227_9, arg_224_1.talkMaxDuration)

			if var_227_8 <= arg_224_1.time_ and arg_224_1.time_ < var_227_8 + var_227_16 then
				arg_224_1.typewritter.percent = (arg_224_1.time_ - var_227_8) / var_227_16

				arg_224_1.typewritter:SetDirty()
			end

			if arg_224_1.time_ >= var_227_8 + var_227_16 and arg_224_1.time_ < var_227_8 + var_227_16 + arg_227_0 then
				arg_224_1.typewritter.percent = 1

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(true)
			end
		end

		arg_224_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_224_1:InitPlayNodeList()
	end,
	Play324131056 = function(arg_228_0, arg_228_1)
		arg_228_1.time_ = 0
		arg_228_1.frameCnt_ = 0
		arg_228_1.state_ = "playing"
		arg_228_1.curTalkId_ = 324131056
		arg_228_1.duration_ = 5.13

		local var_228_0 = {
			zh = 4.433,
			ja = 5.133
		}
		local var_228_1 = manager.audio:GetLocalizationFlag()

		if var_228_0[var_228_1] ~= nil then
			arg_228_1.duration_ = var_228_0[var_228_1]
		end

		SetActive(arg_228_1.tipsGo_, false)

		function arg_228_1.onSingleLineFinish_()
			arg_228_1.onSingleLineUpdate_ = nil
			arg_228_1.onSingleLineFinish_ = nil
			arg_228_1.state_ = "waiting"
		end

		function arg_228_1.playNext_(arg_230_0)
			if arg_230_0 == 1 then
				arg_228_0:Play324131057(arg_228_1)
			end
		end

		function arg_228_1.onSingleLineUpdate_(arg_231_0)
			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 and not isNil(arg_228_1.actors_["1070ui_story"]) and arg_228_1.var_.characterEffect1070ui_story == nil then
				arg_228_1.var_.characterEffect1070ui_story = arg_228_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_231_0 = 0.200000002980232

			if 0 <= arg_228_1.time_ and arg_228_1.time_ < 0 + var_231_0 and not isNil(arg_228_1.actors_["1070ui_story"]) then
				if arg_228_1.var_.characterEffect1070ui_story and not isNil(arg_228_1.actors_["1070ui_story"]) then
					arg_228_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_228_1.time_ >= 0 + var_231_0 and arg_228_1.time_ < 0 + var_231_0 + arg_231_0 and not isNil(arg_228_1.actors_["1070ui_story"]) and arg_228_1.var_.characterEffect1070ui_story then
				arg_228_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_231_2 = arg_228_1.actors_["1053ui_story"]

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 and not isNil(var_231_2) and arg_228_1.var_.characterEffect1053ui_story == nil then
				arg_228_1.var_.characterEffect1053ui_story = var_231_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_231_3 = 0.200000002980232

			if 0 <= arg_228_1.time_ and arg_228_1.time_ < 0 + var_231_3 and not isNil(var_231_2) then
				if arg_228_1.var_.characterEffect1053ui_story and not isNil(var_231_2) then
					arg_228_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_228_1.var_.characterEffect1053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_228_1.time_ - 0) / var_231_3)
				end
			end

			if arg_228_1.time_ >= 0 + var_231_3 and arg_228_1.time_ < 0 + var_231_3 + arg_231_0 and not isNil(var_231_2) and arg_228_1.var_.characterEffect1053ui_story then
				arg_228_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_228_1.var_.characterEffect1053ui_story.fillRatio = 0.5
			end

			local var_231_4 = 0
			local var_231_5 = 0.325

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= var_231_4 + arg_231_0 then
				arg_228_1.talkMaxDuration = 0
				arg_228_1.dialogCg_.alpha = 1

				arg_228_1.dialog_:SetActive(true)
				SetActive(arg_228_1.leftNameGo_, true)

				arg_228_1.leftNameTxt_.text = arg_228_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_228_1.leftNameTxt_.transform)

				arg_228_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_228_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_228_1:RecordName(arg_228_1.leftNameTxt_.text)
				SetActive(arg_228_1.iconTrs_.gameObject, false)
				arg_228_1.callingController_:SetSelectedState("normal")

				local var_231_6 = arg_228_1:GetWordFromCfg(324131056)
				local var_231_7 = arg_228_1:FormatText(var_231_6.content)

				arg_228_1.text_.text = var_231_7

				LuaForUtil.ClearLinePrefixSymbol(arg_228_1.text_)

				local var_231_9 = 13 <= 0 and var_231_5 or var_231_5 * (utf8.len(var_231_7) / 13)

				if (13 <= 0 and var_231_5 or var_231_5 * (utf8.len(var_231_7) / 13)) > 0 and var_231_5 < var_231_9 then
					arg_228_1.talkMaxDuration = var_231_9

					if var_231_9 + var_231_4 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_9 + var_231_4
					end
				end

				arg_228_1.text_.text = var_231_7
				arg_228_1.typewritter.percent = 0

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324131", "324131056", "story_v_out_324131.awb") ~= 0 then
					local var_231_10 = manager.audio:GetVoiceLength("story_v_out_324131", "324131056", "story_v_out_324131.awb") / 1000

					if var_231_10 + var_231_4 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_10 + var_231_4
					end

					if var_231_6.prefab_name ~= "" and arg_228_1.actors_[var_231_6.prefab_name] ~= nil then
						local var_231_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_228_1.actors_[var_231_6.prefab_name].transform, "story_v_out_324131", "324131056", "story_v_out_324131.awb")

						arg_228_1:RecordAudio("324131056", var_231_11)
						arg_228_1:RecordAudio("324131056", var_231_11)
					else
						arg_228_1:AudioAction("play", "voice", "story_v_out_324131", "324131056", "story_v_out_324131.awb")
					end

					arg_228_1:RecordHistoryTalkVoice("story_v_out_324131", "324131056", "story_v_out_324131.awb")
				end

				arg_228_1:RecordContent(arg_228_1.text_.text)
			end

			local var_231_12 = math.max(var_231_5, arg_228_1.talkMaxDuration)

			if var_231_4 <= arg_228_1.time_ and arg_228_1.time_ < var_231_4 + var_231_12 then
				arg_228_1.typewritter.percent = (arg_228_1.time_ - var_231_4) / var_231_12

				arg_228_1.typewritter:SetDirty()
			end

			if arg_228_1.time_ >= var_231_4 + var_231_12 and arg_228_1.time_ < var_231_4 + var_231_12 + arg_231_0 then
				arg_228_1.typewritter.percent = 1

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(true)
			end
		end

		arg_228_1.nodeConfigList_ = {}

		arg_228_1:InitPlayNodeList()
	end,
	Play324131057 = function(arg_232_0, arg_232_1)
		arg_232_1.time_ = 0
		arg_232_1.frameCnt_ = 0
		arg_232_1.state_ = "playing"
		arg_232_1.curTalkId_ = 324131057
		arg_232_1.duration_ = 5

		SetActive(arg_232_1.tipsGo_, false)

		function arg_232_1.onSingleLineFinish_()
			arg_232_1.onSingleLineUpdate_ = nil
			arg_232_1.onSingleLineFinish_ = nil
			arg_232_1.state_ = "waiting"
		end

		function arg_232_1.playNext_(arg_234_0)
			if arg_234_0 == 1 then
				arg_232_0:Play324131058(arg_232_1)
			end
		end

		function arg_232_1.onSingleLineUpdate_(arg_235_0)
			if 0 < arg_232_1.time_ and arg_232_1.time_ <= 0 + arg_235_0 then
				arg_232_1.var_.moveOldPos1070ui_story = arg_232_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_235_0 = 0.001

			if 0 <= arg_232_1.time_ and arg_232_1.time_ < 0 + var_235_0 then
				arg_232_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_232_1.var_.moveOldPos1070ui_story, Vector3.New(0, 100, 0), (arg_232_1.time_ - 0) / var_235_0)
				arg_232_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_232_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_232_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_232_1.actors_["1070ui_story"].transform.position).z)
				arg_232_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_232_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_232_1.actors_["1070ui_story"].transform.localEulerAngles = arg_232_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_232_1.time_ >= 0 + var_235_0 and arg_232_1.time_ < 0 + var_235_0 + arg_235_0 then
				arg_232_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_232_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_232_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_232_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_232_1.actors_["1070ui_story"].transform.position).z)
				arg_232_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_232_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_232_1.actors_["1070ui_story"].transform.localEulerAngles = arg_232_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_235_1 = arg_232_1.actors_["1053ui_story"].transform

			if 0 < arg_232_1.time_ and arg_232_1.time_ <= 0 + arg_235_0 then
				arg_232_1.var_.moveOldPos1053ui_story = var_235_1.localPosition

				local var_235_2 = GameObjectTools.GetOrAddComponent(var_235_1.gameObject, typeof(DynamicBoneHelper))

				if var_235_2 then
					var_235_2:EnableDynamicBone(false)
				end
			end

			local var_235_3 = 0.001

			if 0 <= arg_232_1.time_ and arg_232_1.time_ < 0 + var_235_3 then
				var_235_1.localPosition = Vector3.Lerp(arg_232_1.var_.moveOldPos1053ui_story, Vector3.New(0, 100, 0), (arg_232_1.time_ - 0) / var_235_3)
				var_235_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_235_1.position).x, (manager.ui.mainCamera.transform.position - var_235_1.position).y, (manager.ui.mainCamera.transform.position - var_235_1.position).z)
				var_235_1.localEulerAngles.z = 0
				var_235_1.localEulerAngles.x = 0
				var_235_1.localEulerAngles = var_235_1.localEulerAngles
			end

			if arg_232_1.time_ >= 0 + var_235_3 and arg_232_1.time_ < 0 + var_235_3 + arg_235_0 then
				var_235_1.localPosition = Vector3.New(0, 100, 0)
				var_235_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_235_1.position).x, (manager.ui.mainCamera.transform.position - var_235_1.position).y, (manager.ui.mainCamera.transform.position - var_235_1.position).z)
				var_235_1.localEulerAngles.z = 0
				var_235_1.localEulerAngles.x = 0
				var_235_1.localEulerAngles = var_235_1.localEulerAngles

				local var_235_4 = GameObjectTools.GetOrAddComponent(var_235_1.gameObject, typeof(DynamicBoneHelper))

				if var_235_4 then
					var_235_4:EnableDynamicBone(true)
				end
			end

			local var_235_5 = arg_232_1.actors_["1070ui_story"]

			if 0 < arg_232_1.time_ and arg_232_1.time_ <= 0 + arg_235_0 and not isNil(var_235_5) and arg_232_1.var_.characterEffect1070ui_story == nil then
				arg_232_1.var_.characterEffect1070ui_story = var_235_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_235_6 = 0.200000002980232

			if 0 <= arg_232_1.time_ and arg_232_1.time_ < 0 + var_235_6 and not isNil(var_235_5) then
				if arg_232_1.var_.characterEffect1070ui_story and not isNil(var_235_5) then
					arg_232_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_232_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_232_1.time_ - 0) / var_235_6)
				end
			end

			if arg_232_1.time_ >= 0 + var_235_6 and arg_232_1.time_ < 0 + var_235_6 + arg_235_0 and not isNil(var_235_5) and arg_232_1.var_.characterEffect1070ui_story then
				arg_232_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_232_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_235_7 = 0
			local var_235_8 = 0.825

			if 0 < arg_232_1.time_ and arg_232_1.time_ <= var_235_7 + arg_235_0 then
				arg_232_1.talkMaxDuration = 0
				arg_232_1.dialogCg_.alpha = 1

				arg_232_1.dialog_:SetActive(true)
				SetActive(arg_232_1.leftNameGo_, false)

				arg_232_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_232_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_232_1:RecordName(arg_232_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_232_1.iconTrs_.gameObject, false)
				arg_232_1.callingController_:SetSelectedState("normal")

				local var_235_9 = arg_232_1:FormatText(arg_232_1:GetWordFromCfg(324131057).content)

				arg_232_1.text_.text = var_235_9

				LuaForUtil.ClearLinePrefixSymbol(arg_232_1.text_)

				local var_235_11 = 33 <= 0 and var_235_8 or var_235_8 * (utf8.len(var_235_9) / 33)

				if (33 <= 0 and var_235_8 or var_235_8 * (utf8.len(var_235_9) / 33)) > 0 and var_235_8 < var_235_11 then
					arg_232_1.talkMaxDuration = var_235_11

					if var_235_11 + var_235_7 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_11 + var_235_7
					end
				end

				arg_232_1.text_.text = var_235_9
				arg_232_1.typewritter.percent = 0

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(false)
				arg_232_1:RecordContent(arg_232_1.text_.text)
			end

			local var_235_12 = math.max(var_235_8, arg_232_1.talkMaxDuration)

			if var_235_7 <= arg_232_1.time_ and arg_232_1.time_ < var_235_7 + var_235_12 then
				arg_232_1.typewritter.percent = (arg_232_1.time_ - var_235_7) / var_235_12

				arg_232_1.typewritter:SetDirty()
			end

			if arg_232_1.time_ >= var_235_7 + var_235_12 and arg_232_1.time_ < var_235_7 + var_235_12 + arg_235_0 then
				arg_232_1.typewritter.percent = 1

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(true)
			end
		end

		arg_232_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_232_1:InitPlayNodeList()
	end,
	Play324131058 = function(arg_236_0, arg_236_1)
		arg_236_1.time_ = 0
		arg_236_1.frameCnt_ = 0
		arg_236_1.state_ = "playing"
		arg_236_1.curTalkId_ = 324131058
		arg_236_1.duration_ = 8.37

		local var_236_0 = {
			zh = 7.333,
			ja = 8.366
		}
		local var_236_1 = manager.audio:GetLocalizationFlag()

		if var_236_0[var_236_1] ~= nil then
			arg_236_1.duration_ = var_236_0[var_236_1]
		end

		SetActive(arg_236_1.tipsGo_, false)

		function arg_236_1.onSingleLineFinish_()
			arg_236_1.onSingleLineUpdate_ = nil
			arg_236_1.onSingleLineFinish_ = nil
			arg_236_1.state_ = "waiting"
		end

		function arg_236_1.playNext_(arg_238_0)
			if arg_238_0 == 1 then
				arg_236_0:Play324131059(arg_236_1)
			end
		end

		function arg_236_1.onSingleLineUpdate_(arg_239_0)
			if 0 < arg_236_1.time_ and arg_236_1.time_ <= 0 + arg_239_0 then
				arg_236_1.var_.moveOldPos1053ui_story = arg_236_1.actors_["1053ui_story"].transform.localPosition

				local var_239_0 = GameObjectTools.GetOrAddComponent(arg_236_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_239_0 then
					var_239_0:EnableDynamicBone(false)
				end
			end

			local var_239_1 = 0.001

			if 0 <= arg_236_1.time_ and arg_236_1.time_ < 0 + var_239_1 then
				arg_236_1.actors_["1053ui_story"].transform.localPosition = Vector3.Lerp(arg_236_1.var_.moveOldPos1053ui_story, Vector3.New(0.7, -1.08, -6), (arg_236_1.time_ - 0) / var_239_1)
				arg_236_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_236_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_236_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_236_1.actors_["1053ui_story"].transform.position).z)
				arg_236_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_236_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_236_1.actors_["1053ui_story"].transform.localEulerAngles = arg_236_1.actors_["1053ui_story"].transform.localEulerAngles
			end

			if arg_236_1.time_ >= 0 + var_239_1 and arg_236_1.time_ < 0 + var_239_1 + arg_239_0 then
				arg_236_1.actors_["1053ui_story"].transform.localPosition = Vector3.New(0.7, -1.08, -6)
				arg_236_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_236_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_236_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_236_1.actors_["1053ui_story"].transform.position).z)
				arg_236_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_236_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_236_1.actors_["1053ui_story"].transform.localEulerAngles = arg_236_1.actors_["1053ui_story"].transform.localEulerAngles

				local var_239_2 = GameObjectTools.GetOrAddComponent(arg_236_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_239_2 then
					var_239_2:EnableDynamicBone(true)
				end
			end

			local var_239_3 = arg_236_1.actors_["1053ui_story"]

			if 0 < arg_236_1.time_ and arg_236_1.time_ <= 0 + arg_239_0 and not isNil(var_239_3) and arg_236_1.var_.characterEffect1053ui_story == nil then
				arg_236_1.var_.characterEffect1053ui_story = var_239_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_239_4 = 0.200000002980232

			if 0 <= arg_236_1.time_ and arg_236_1.time_ < 0 + var_239_4 and not isNil(var_239_3) then
				if arg_236_1.var_.characterEffect1053ui_story and not isNil(var_239_3) then
					arg_236_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_236_1.time_ >= 0 + var_239_4 and arg_236_1.time_ < 0 + var_239_4 + arg_239_0 and not isNil(var_239_3) and arg_236_1.var_.characterEffect1053ui_story then
				arg_236_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			if 0 < arg_236_1.time_ and arg_236_1.time_ <= 0 + arg_239_0 then
				arg_236_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053action/1053action5_1")
			end

			if 0 < arg_236_1.time_ and arg_236_1.time_ <= 0 + arg_239_0 then
				arg_236_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_239_6 = 0
			local var_239_7 = 0.725

			if 0 < arg_236_1.time_ and arg_236_1.time_ <= var_239_6 + arg_239_0 then
				arg_236_1.talkMaxDuration = 0
				arg_236_1.dialogCg_.alpha = 1

				arg_236_1.dialog_:SetActive(true)
				SetActive(arg_236_1.leftNameGo_, true)

				arg_236_1.leftNameTxt_.text = arg_236_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_236_1.leftNameTxt_.transform)

				arg_236_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_236_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_236_1:RecordName(arg_236_1.leftNameTxt_.text)
				SetActive(arg_236_1.iconTrs_.gameObject, false)
				arg_236_1.callingController_:SetSelectedState("normal")

				local var_239_8 = arg_236_1:GetWordFromCfg(324131058)
				local var_239_9 = arg_236_1:FormatText(var_239_8.content)

				arg_236_1.text_.text = var_239_9

				LuaForUtil.ClearLinePrefixSymbol(arg_236_1.text_)

				local var_239_11 = 29 <= 0 and var_239_7 or var_239_7 * (utf8.len(var_239_9) / 29)

				if (29 <= 0 and var_239_7 or var_239_7 * (utf8.len(var_239_9) / 29)) > 0 and var_239_7 < var_239_11 then
					arg_236_1.talkMaxDuration = var_239_11

					if var_239_11 + var_239_6 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_11 + var_239_6
					end
				end

				arg_236_1.text_.text = var_239_9
				arg_236_1.typewritter.percent = 0

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324131", "324131058", "story_v_out_324131.awb") ~= 0 then
					local var_239_12 = manager.audio:GetVoiceLength("story_v_out_324131", "324131058", "story_v_out_324131.awb") / 1000

					if var_239_12 + var_239_6 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_12 + var_239_6
					end

					if var_239_8.prefab_name ~= "" and arg_236_1.actors_[var_239_8.prefab_name] ~= nil then
						local var_239_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_236_1.actors_[var_239_8.prefab_name].transform, "story_v_out_324131", "324131058", "story_v_out_324131.awb")

						arg_236_1:RecordAudio("324131058", var_239_13)
						arg_236_1:RecordAudio("324131058", var_239_13)
					else
						arg_236_1:AudioAction("play", "voice", "story_v_out_324131", "324131058", "story_v_out_324131.awb")
					end

					arg_236_1:RecordHistoryTalkVoice("story_v_out_324131", "324131058", "story_v_out_324131.awb")
				end

				arg_236_1:RecordContent(arg_236_1.text_.text)
			end

			local var_239_14 = math.max(var_239_7, arg_236_1.talkMaxDuration)

			if var_239_6 <= arg_236_1.time_ and arg_236_1.time_ < var_239_6 + var_239_14 then
				arg_236_1.typewritter.percent = (arg_236_1.time_ - var_239_6) / var_239_14

				arg_236_1.typewritter:SetDirty()
			end

			if arg_236_1.time_ >= var_239_6 + var_239_14 and arg_236_1.time_ < var_239_6 + var_239_14 + arg_239_0 then
				arg_236_1.typewritter.percent = 1

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(true)
			end
		end

		arg_236_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_236_1:InitPlayNodeList()
	end,
	Play324131059 = function(arg_240_0, arg_240_1)
		arg_240_1.time_ = 0
		arg_240_1.frameCnt_ = 0
		arg_240_1.state_ = "playing"
		arg_240_1.curTalkId_ = 324131059
		arg_240_1.duration_ = 9.13

		local var_240_0 = {
			zh = 6.8,
			ja = 9.133
		}
		local var_240_1 = manager.audio:GetLocalizationFlag()

		if var_240_0[var_240_1] ~= nil then
			arg_240_1.duration_ = var_240_0[var_240_1]
		end

		SetActive(arg_240_1.tipsGo_, false)

		function arg_240_1.onSingleLineFinish_()
			arg_240_1.onSingleLineUpdate_ = nil
			arg_240_1.onSingleLineFinish_ = nil
			arg_240_1.state_ = "waiting"
		end

		function arg_240_1.playNext_(arg_242_0)
			if arg_242_0 == 1 then
				arg_240_0:Play324131060(arg_240_1)
			end
		end

		function arg_240_1.onSingleLineUpdate_(arg_243_0)
			if 0 < arg_240_1.time_ and arg_240_1.time_ <= 0 + arg_243_0 then
				arg_240_1.var_.moveOldPos1070ui_story = arg_240_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_243_0 = 0.001

			if 0 <= arg_240_1.time_ and arg_240_1.time_ < 0 + var_243_0 then
				arg_240_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_240_1.var_.moveOldPos1070ui_story, Vector3.New(-0.7, -0.95, -6.05), (arg_240_1.time_ - 0) / var_243_0)
				arg_240_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_240_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_240_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_240_1.actors_["1070ui_story"].transform.position).z)
				arg_240_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_240_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_240_1.actors_["1070ui_story"].transform.localEulerAngles = arg_240_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_240_1.time_ >= 0 + var_243_0 and arg_240_1.time_ < 0 + var_243_0 + arg_243_0 then
				arg_240_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(-0.7, -0.95, -6.05)
				arg_240_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_240_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_240_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_240_1.actors_["1070ui_story"].transform.position).z)
				arg_240_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_240_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_240_1.actors_["1070ui_story"].transform.localEulerAngles = arg_240_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_243_1 = arg_240_1.actors_["1070ui_story"]

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= 0 + arg_243_0 and not isNil(var_243_1) and arg_240_1.var_.characterEffect1070ui_story == nil then
				arg_240_1.var_.characterEffect1070ui_story = var_243_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_243_2 = 0.200000002980232

			if 0 <= arg_240_1.time_ and arg_240_1.time_ < 0 + var_243_2 and not isNil(var_243_1) then
				if arg_240_1.var_.characterEffect1070ui_story and not isNil(var_243_1) then
					arg_240_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_240_1.time_ >= 0 + var_243_2 and arg_240_1.time_ < 0 + var_243_2 + arg_243_0 and not isNil(var_243_1) and arg_240_1.var_.characterEffect1070ui_story then
				arg_240_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_243_4 = arg_240_1.actors_["1053ui_story"]

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= 0 + arg_243_0 and not isNil(var_243_4) and arg_240_1.var_.characterEffect1053ui_story == nil then
				arg_240_1.var_.characterEffect1053ui_story = var_243_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_243_5 = 0.200000002980232

			if 0 <= arg_240_1.time_ and arg_240_1.time_ < 0 + var_243_5 and not isNil(var_243_4) then
				if arg_240_1.var_.characterEffect1053ui_story and not isNil(var_243_4) then
					arg_240_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_240_1.var_.characterEffect1053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_240_1.time_ - 0) / var_243_5)
				end
			end

			if arg_240_1.time_ >= 0 + var_243_5 and arg_240_1.time_ < 0 + var_243_5 + arg_243_0 and not isNil(var_243_4) and arg_240_1.var_.characterEffect1053ui_story then
				arg_240_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_240_1.var_.characterEffect1053ui_story.fillRatio = 0.5
			end

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= 0 + arg_243_0 then
				arg_240_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action5_2")
			end

			local var_243_6 = 0
			local var_243_7 = 0.5

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= var_243_6 + arg_243_0 then
				arg_240_1.talkMaxDuration = 0
				arg_240_1.dialogCg_.alpha = 1

				arg_240_1.dialog_:SetActive(true)
				SetActive(arg_240_1.leftNameGo_, true)

				arg_240_1.leftNameTxt_.text = arg_240_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_240_1.leftNameTxt_.transform)

				arg_240_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_240_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_240_1:RecordName(arg_240_1.leftNameTxt_.text)
				SetActive(arg_240_1.iconTrs_.gameObject, false)
				arg_240_1.callingController_:SetSelectedState("normal")

				local var_243_8 = arg_240_1:GetWordFromCfg(324131059)
				local var_243_9 = arg_240_1:FormatText(var_243_8.content)

				arg_240_1.text_.text = var_243_9

				LuaForUtil.ClearLinePrefixSymbol(arg_240_1.text_)

				local var_243_11 = 20 <= 0 and var_243_7 or var_243_7 * (utf8.len(var_243_9) / 20)

				if (20 <= 0 and var_243_7 or var_243_7 * (utf8.len(var_243_9) / 20)) > 0 and var_243_7 < var_243_11 then
					arg_240_1.talkMaxDuration = var_243_11

					if var_243_11 + var_243_6 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_11 + var_243_6
					end
				end

				arg_240_1.text_.text = var_243_9
				arg_240_1.typewritter.percent = 0

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324131", "324131059", "story_v_out_324131.awb") ~= 0 then
					local var_243_12 = manager.audio:GetVoiceLength("story_v_out_324131", "324131059", "story_v_out_324131.awb") / 1000

					if var_243_12 + var_243_6 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_12 + var_243_6
					end

					if var_243_8.prefab_name ~= "" and arg_240_1.actors_[var_243_8.prefab_name] ~= nil then
						local var_243_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_240_1.actors_[var_243_8.prefab_name].transform, "story_v_out_324131", "324131059", "story_v_out_324131.awb")

						arg_240_1:RecordAudio("324131059", var_243_13)
						arg_240_1:RecordAudio("324131059", var_243_13)
					else
						arg_240_1:AudioAction("play", "voice", "story_v_out_324131", "324131059", "story_v_out_324131.awb")
					end

					arg_240_1:RecordHistoryTalkVoice("story_v_out_324131", "324131059", "story_v_out_324131.awb")
				end

				arg_240_1:RecordContent(arg_240_1.text_.text)
			end

			local var_243_14 = math.max(var_243_7, arg_240_1.talkMaxDuration)

			if var_243_6 <= arg_240_1.time_ and arg_240_1.time_ < var_243_6 + var_243_14 then
				arg_240_1.typewritter.percent = (arg_240_1.time_ - var_243_6) / var_243_14

				arg_240_1.typewritter:SetDirty()
			end

			if arg_240_1.time_ >= var_243_6 + var_243_14 and arg_240_1.time_ < var_243_6 + var_243_14 + arg_243_0 then
				arg_240_1.typewritter.percent = 1

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(true)
			end
		end

		arg_240_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_240_1:InitPlayNodeList()
	end,
	Play324131060 = function(arg_244_0, arg_244_1)
		arg_244_1.time_ = 0
		arg_244_1.frameCnt_ = 0
		arg_244_1.state_ = "playing"
		arg_244_1.curTalkId_ = 324131060
		arg_244_1.duration_ = 8.07

		local var_244_0 = {
			zh = 5.7,
			ja = 8.066
		}
		local var_244_1 = manager.audio:GetLocalizationFlag()

		if var_244_0[var_244_1] ~= nil then
			arg_244_1.duration_ = var_244_0[var_244_1]
		end

		SetActive(arg_244_1.tipsGo_, false)

		function arg_244_1.onSingleLineFinish_()
			arg_244_1.onSingleLineUpdate_ = nil
			arg_244_1.onSingleLineFinish_ = nil
			arg_244_1.state_ = "waiting"
		end

		function arg_244_1.playNext_(arg_246_0)
			if arg_246_0 == 1 then
				arg_244_0:Play324131061(arg_244_1)
			end
		end

		function arg_244_1.onSingleLineUpdate_(arg_247_0)
			if 0 < arg_244_1.time_ and arg_244_1.time_ <= 0 + arg_247_0 and not isNil(arg_244_1.actors_["1053ui_story"]) and arg_244_1.var_.characterEffect1053ui_story == nil then
				arg_244_1.var_.characterEffect1053ui_story = arg_244_1.actors_["1053ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_247_0 = 0.200000002980232

			if 0 <= arg_244_1.time_ and arg_244_1.time_ < 0 + var_247_0 and not isNil(arg_244_1.actors_["1053ui_story"]) then
				if arg_244_1.var_.characterEffect1053ui_story and not isNil(arg_244_1.actors_["1053ui_story"]) then
					arg_244_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_244_1.time_ >= 0 + var_247_0 and arg_244_1.time_ < 0 + var_247_0 + arg_247_0 and not isNil(arg_244_1.actors_["1053ui_story"]) and arg_244_1.var_.characterEffect1053ui_story then
				arg_244_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_247_2 = arg_244_1.actors_["1070ui_story"]

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= 0 + arg_247_0 and not isNil(var_247_2) and arg_244_1.var_.characterEffect1070ui_story == nil then
				arg_244_1.var_.characterEffect1070ui_story = var_247_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_247_3 = 0.200000002980232

			if 0 <= arg_244_1.time_ and arg_244_1.time_ < 0 + var_247_3 and not isNil(var_247_2) then
				if arg_244_1.var_.characterEffect1070ui_story and not isNil(var_247_2) then
					arg_244_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_244_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_244_1.time_ - 0) / var_247_3)
				end
			end

			if arg_244_1.time_ >= 0 + var_247_3 and arg_244_1.time_ < 0 + var_247_3 + arg_247_0 and not isNil(var_247_2) and arg_244_1.var_.characterEffect1070ui_story then
				arg_244_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_244_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_247_4 = 0
			local var_247_5 = 0.575

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= var_247_4 + arg_247_0 then
				arg_244_1.talkMaxDuration = 0
				arg_244_1.dialogCg_.alpha = 1

				arg_244_1.dialog_:SetActive(true)
				SetActive(arg_244_1.leftNameGo_, true)

				arg_244_1.leftNameTxt_.text = arg_244_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_244_1.leftNameTxt_.transform)

				arg_244_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_244_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_244_1:RecordName(arg_244_1.leftNameTxt_.text)
				SetActive(arg_244_1.iconTrs_.gameObject, false)
				arg_244_1.callingController_:SetSelectedState("normal")

				local var_247_6 = arg_244_1:GetWordFromCfg(324131060)
				local var_247_7 = arg_244_1:FormatText(var_247_6.content)

				arg_244_1.text_.text = var_247_7

				LuaForUtil.ClearLinePrefixSymbol(arg_244_1.text_)

				local var_247_9 = 23 <= 0 and var_247_5 or var_247_5 * (utf8.len(var_247_7) / 23)

				if (23 <= 0 and var_247_5 or var_247_5 * (utf8.len(var_247_7) / 23)) > 0 and var_247_5 < var_247_9 then
					arg_244_1.talkMaxDuration = var_247_9

					if var_247_9 + var_247_4 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_9 + var_247_4
					end
				end

				arg_244_1.text_.text = var_247_7
				arg_244_1.typewritter.percent = 0

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324131", "324131060", "story_v_out_324131.awb") ~= 0 then
					local var_247_10 = manager.audio:GetVoiceLength("story_v_out_324131", "324131060", "story_v_out_324131.awb") / 1000

					if var_247_10 + var_247_4 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_10 + var_247_4
					end

					if var_247_6.prefab_name ~= "" and arg_244_1.actors_[var_247_6.prefab_name] ~= nil then
						local var_247_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_244_1.actors_[var_247_6.prefab_name].transform, "story_v_out_324131", "324131060", "story_v_out_324131.awb")

						arg_244_1:RecordAudio("324131060", var_247_11)
						arg_244_1:RecordAudio("324131060", var_247_11)
					else
						arg_244_1:AudioAction("play", "voice", "story_v_out_324131", "324131060", "story_v_out_324131.awb")
					end

					arg_244_1:RecordHistoryTalkVoice("story_v_out_324131", "324131060", "story_v_out_324131.awb")
				end

				arg_244_1:RecordContent(arg_244_1.text_.text)
			end

			local var_247_12 = math.max(var_247_5, arg_244_1.talkMaxDuration)

			if var_247_4 <= arg_244_1.time_ and arg_244_1.time_ < var_247_4 + var_247_12 then
				arg_244_1.typewritter.percent = (arg_244_1.time_ - var_247_4) / var_247_12

				arg_244_1.typewritter:SetDirty()
			end

			if arg_244_1.time_ >= var_247_4 + var_247_12 and arg_244_1.time_ < var_247_4 + var_247_12 + arg_247_0 then
				arg_244_1.typewritter.percent = 1

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(true)
			end
		end

		arg_244_1.nodeConfigList_ = {}

		arg_244_1:InitPlayNodeList()
	end,
	Play324131061 = function(arg_248_0, arg_248_1)
		arg_248_1.time_ = 0
		arg_248_1.frameCnt_ = 0
		arg_248_1.state_ = "playing"
		arg_248_1.curTalkId_ = 324131061
		arg_248_1.duration_ = 5

		SetActive(arg_248_1.tipsGo_, false)

		function arg_248_1.onSingleLineFinish_()
			arg_248_1.onSingleLineUpdate_ = nil
			arg_248_1.onSingleLineFinish_ = nil
			arg_248_1.state_ = "waiting"
		end

		function arg_248_1.playNext_(arg_250_0)
			if arg_250_0 == 1 then
				arg_248_0:Play324131062(arg_248_1)
			end
		end

		function arg_248_1.onSingleLineUpdate_(arg_251_0)
			if 0 < arg_248_1.time_ and arg_248_1.time_ <= 0 + arg_251_0 then
				arg_248_1.var_.moveOldPos1070ui_story = arg_248_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_251_0 = 0.001

			if 0 <= arg_248_1.time_ and arg_248_1.time_ < 0 + var_251_0 then
				arg_248_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_248_1.var_.moveOldPos1070ui_story, Vector3.New(0, 100, 0), (arg_248_1.time_ - 0) / var_251_0)
				arg_248_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_248_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_248_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_248_1.actors_["1070ui_story"].transform.position).z)
				arg_248_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_248_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_248_1.actors_["1070ui_story"].transform.localEulerAngles = arg_248_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_248_1.time_ >= 0 + var_251_0 and arg_248_1.time_ < 0 + var_251_0 + arg_251_0 then
				arg_248_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_248_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_248_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_248_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_248_1.actors_["1070ui_story"].transform.position).z)
				arg_248_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_248_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_248_1.actors_["1070ui_story"].transform.localEulerAngles = arg_248_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_251_1 = arg_248_1.actors_["1053ui_story"].transform

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= 0 + arg_251_0 then
				arg_248_1.var_.moveOldPos1053ui_story = var_251_1.localPosition

				local var_251_2 = GameObjectTools.GetOrAddComponent(var_251_1.gameObject, typeof(DynamicBoneHelper))

				if var_251_2 then
					var_251_2:EnableDynamicBone(false)
				end
			end

			local var_251_3 = 0.001

			if 0 <= arg_248_1.time_ and arg_248_1.time_ < 0 + var_251_3 then
				var_251_1.localPosition = Vector3.Lerp(arg_248_1.var_.moveOldPos1053ui_story, Vector3.New(0, 100, 0), (arg_248_1.time_ - 0) / var_251_3)
				var_251_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_251_1.position).x, (manager.ui.mainCamera.transform.position - var_251_1.position).y, (manager.ui.mainCamera.transform.position - var_251_1.position).z)
				var_251_1.localEulerAngles.z = 0
				var_251_1.localEulerAngles.x = 0
				var_251_1.localEulerAngles = var_251_1.localEulerAngles
			end

			if arg_248_1.time_ >= 0 + var_251_3 and arg_248_1.time_ < 0 + var_251_3 + arg_251_0 then
				var_251_1.localPosition = Vector3.New(0, 100, 0)
				var_251_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_251_1.position).x, (manager.ui.mainCamera.transform.position - var_251_1.position).y, (manager.ui.mainCamera.transform.position - var_251_1.position).z)
				var_251_1.localEulerAngles.z = 0
				var_251_1.localEulerAngles.x = 0
				var_251_1.localEulerAngles = var_251_1.localEulerAngles

				local var_251_4 = GameObjectTools.GetOrAddComponent(var_251_1.gameObject, typeof(DynamicBoneHelper))

				if var_251_4 then
					var_251_4:EnableDynamicBone(true)
				end
			end

			local var_251_5 = arg_248_1.actors_["1053ui_story"]

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= 0 + arg_251_0 and not isNil(var_251_5) and arg_248_1.var_.characterEffect1053ui_story == nil then
				arg_248_1.var_.characterEffect1053ui_story = var_251_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_251_6 = 0.200000002980232

			if 0 <= arg_248_1.time_ and arg_248_1.time_ < 0 + var_251_6 and not isNil(var_251_5) then
				if arg_248_1.var_.characterEffect1053ui_story and not isNil(var_251_5) then
					arg_248_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_248_1.var_.characterEffect1053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_248_1.time_ - 0) / var_251_6)
				end
			end

			if arg_248_1.time_ >= 0 + var_251_6 and arg_248_1.time_ < 0 + var_251_6 + arg_251_0 and not isNil(var_251_5) and arg_248_1.var_.characterEffect1053ui_story then
				arg_248_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_248_1.var_.characterEffect1053ui_story.fillRatio = 0.5
			end

			if 0.4 < arg_248_1.time_ and arg_248_1.time_ <= 0.4 + arg_251_0 then
				arg_248_1:AudioAction("play", "effect", "se_story_150", "se_story_150_box01", "")
			end

			local var_251_8 = 0
			local var_251_9 = 1.1

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= var_251_8 + arg_251_0 then
				arg_248_1.talkMaxDuration = 0
				arg_248_1.dialogCg_.alpha = 1

				arg_248_1.dialog_:SetActive(true)
				SetActive(arg_248_1.leftNameGo_, false)

				arg_248_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_248_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_248_1:RecordName(arg_248_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_248_1.iconTrs_.gameObject, false)
				arg_248_1.callingController_:SetSelectedState("normal")

				local var_251_10 = arg_248_1:FormatText(arg_248_1:GetWordFromCfg(324131061).content)

				arg_248_1.text_.text = var_251_10

				LuaForUtil.ClearLinePrefixSymbol(arg_248_1.text_)

				local var_251_12 = 44 <= 0 and var_251_9 or var_251_9 * (utf8.len(var_251_10) / 44)

				if (44 <= 0 and var_251_9 or var_251_9 * (utf8.len(var_251_10) / 44)) > 0 and var_251_9 < var_251_12 then
					arg_248_1.talkMaxDuration = var_251_12

					if var_251_12 + var_251_8 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_12 + var_251_8
					end
				end

				arg_248_1.text_.text = var_251_10
				arg_248_1.typewritter.percent = 0

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(false)
				arg_248_1:RecordContent(arg_248_1.text_.text)
			end

			local var_251_13 = math.max(var_251_9, arg_248_1.talkMaxDuration)

			if var_251_8 <= arg_248_1.time_ and arg_248_1.time_ < var_251_8 + var_251_13 then
				arg_248_1.typewritter.percent = (arg_248_1.time_ - var_251_8) / var_251_13

				arg_248_1.typewritter:SetDirty()
			end

			if arg_248_1.time_ >= var_251_8 + var_251_13 and arg_248_1.time_ < var_251_8 + var_251_13 + arg_251_0 then
				arg_248_1.typewritter.percent = 1

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(true)
			end
		end

		arg_248_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_248_1:InitPlayNodeList()
	end,
	Play324131062 = function(arg_252_0, arg_252_1)
		arg_252_1.time_ = 0
		arg_252_1.frameCnt_ = 0
		arg_252_1.state_ = "playing"
		arg_252_1.curTalkId_ = 324131062
		arg_252_1.duration_ = 2

		SetActive(arg_252_1.tipsGo_, false)

		function arg_252_1.onSingleLineFinish_()
			arg_252_1.onSingleLineUpdate_ = nil
			arg_252_1.onSingleLineFinish_ = nil
			arg_252_1.state_ = "waiting"
		end

		function arg_252_1.playNext_(arg_254_0)
			if arg_254_0 == 1 then
				arg_252_0:Play324131063(arg_252_1)
			end
		end

		function arg_252_1.onSingleLineUpdate_(arg_255_0)
			if 0 < arg_252_1.time_ and arg_252_1.time_ <= 0 + arg_255_0 then
				arg_252_1.var_.moveOldPos1053ui_story = arg_252_1.actors_["1053ui_story"].transform.localPosition

				local var_255_0 = GameObjectTools.GetOrAddComponent(arg_252_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_255_0 then
					var_255_0:EnableDynamicBone(false)
				end
			end

			local var_255_1 = 0.001

			if 0 <= arg_252_1.time_ and arg_252_1.time_ < 0 + var_255_1 then
				arg_252_1.actors_["1053ui_story"].transform.localPosition = Vector3.Lerp(arg_252_1.var_.moveOldPos1053ui_story, Vector3.New(0, -1.08, -6), (arg_252_1.time_ - 0) / var_255_1)
				arg_252_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_252_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_252_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_252_1.actors_["1053ui_story"].transform.position).z)
				arg_252_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_252_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_252_1.actors_["1053ui_story"].transform.localEulerAngles = arg_252_1.actors_["1053ui_story"].transform.localEulerAngles
			end

			if arg_252_1.time_ >= 0 + var_255_1 and arg_252_1.time_ < 0 + var_255_1 + arg_255_0 then
				arg_252_1.actors_["1053ui_story"].transform.localPosition = Vector3.New(0, -1.08, -6)
				arg_252_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_252_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_252_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_252_1.actors_["1053ui_story"].transform.position).z)
				arg_252_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_252_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_252_1.actors_["1053ui_story"].transform.localEulerAngles = arg_252_1.actors_["1053ui_story"].transform.localEulerAngles

				local var_255_2 = GameObjectTools.GetOrAddComponent(arg_252_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_255_2 then
					var_255_2:EnableDynamicBone(true)
				end
			end

			local var_255_3 = arg_252_1.actors_["1053ui_story"]

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= 0 + arg_255_0 and not isNil(var_255_3) and arg_252_1.var_.characterEffect1053ui_story == nil then
				arg_252_1.var_.characterEffect1053ui_story = var_255_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_255_4 = 0.200000002980232

			if 0 <= arg_252_1.time_ and arg_252_1.time_ < 0 + var_255_4 and not isNil(var_255_3) then
				if arg_252_1.var_.characterEffect1053ui_story and not isNil(var_255_3) then
					arg_252_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_252_1.time_ >= 0 + var_255_4 and arg_252_1.time_ < 0 + var_255_4 + arg_255_0 and not isNil(var_255_3) and arg_252_1.var_.characterEffect1053ui_story then
				arg_252_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= 0 + arg_255_0 then
				arg_252_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053action/1053action5_2")
			end

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= 0 + arg_255_0 then
				arg_252_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_255_6 = 0
			local var_255_7 = 0.15

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= var_255_6 + arg_255_0 then
				arg_252_1.talkMaxDuration = 0
				arg_252_1.dialogCg_.alpha = 1

				arg_252_1.dialog_:SetActive(true)
				SetActive(arg_252_1.leftNameGo_, true)

				arg_252_1.leftNameTxt_.text = arg_252_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_252_1.leftNameTxt_.transform)

				arg_252_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_252_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_252_1:RecordName(arg_252_1.leftNameTxt_.text)
				SetActive(arg_252_1.iconTrs_.gameObject, false)
				arg_252_1.callingController_:SetSelectedState("normal")

				local var_255_8 = arg_252_1:GetWordFromCfg(324131062)
				local var_255_9 = arg_252_1:FormatText(var_255_8.content)

				arg_252_1.text_.text = var_255_9

				LuaForUtil.ClearLinePrefixSymbol(arg_252_1.text_)

				local var_255_11 = 6 <= 0 and var_255_7 or var_255_7 * (utf8.len(var_255_9) / 6)

				if (6 <= 0 and var_255_7 or var_255_7 * (utf8.len(var_255_9) / 6)) > 0 and var_255_7 < var_255_11 then
					arg_252_1.talkMaxDuration = var_255_11

					if var_255_11 + var_255_6 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_11 + var_255_6
					end
				end

				arg_252_1.text_.text = var_255_9
				arg_252_1.typewritter.percent = 0

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324131", "324131062", "story_v_out_324131.awb") ~= 0 then
					local var_255_12 = manager.audio:GetVoiceLength("story_v_out_324131", "324131062", "story_v_out_324131.awb") / 1000

					if var_255_12 + var_255_6 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_12 + var_255_6
					end

					if var_255_8.prefab_name ~= "" and arg_252_1.actors_[var_255_8.prefab_name] ~= nil then
						local var_255_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_252_1.actors_[var_255_8.prefab_name].transform, "story_v_out_324131", "324131062", "story_v_out_324131.awb")

						arg_252_1:RecordAudio("324131062", var_255_13)
						arg_252_1:RecordAudio("324131062", var_255_13)
					else
						arg_252_1:AudioAction("play", "voice", "story_v_out_324131", "324131062", "story_v_out_324131.awb")
					end

					arg_252_1:RecordHistoryTalkVoice("story_v_out_324131", "324131062", "story_v_out_324131.awb")
				end

				arg_252_1:RecordContent(arg_252_1.text_.text)
			end

			local var_255_14 = math.max(var_255_7, arg_252_1.talkMaxDuration)

			if var_255_6 <= arg_252_1.time_ and arg_252_1.time_ < var_255_6 + var_255_14 then
				arg_252_1.typewritter.percent = (arg_252_1.time_ - var_255_6) / var_255_14

				arg_252_1.typewritter:SetDirty()
			end

			if arg_252_1.time_ >= var_255_6 + var_255_14 and arg_252_1.time_ < var_255_6 + var_255_14 + arg_255_0 then
				arg_252_1.typewritter.percent = 1

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(true)
			end
		end

		arg_252_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_252_1:InitPlayNodeList()
	end,
	Play324131063 = function(arg_256_0, arg_256_1)
		arg_256_1.time_ = 0
		arg_256_1.frameCnt_ = 0
		arg_256_1.state_ = "playing"
		arg_256_1.curTalkId_ = 324131063
		arg_256_1.duration_ = 5

		SetActive(arg_256_1.tipsGo_, false)

		function arg_256_1.onSingleLineFinish_()
			arg_256_1.onSingleLineUpdate_ = nil
			arg_256_1.onSingleLineFinish_ = nil
			arg_256_1.state_ = "waiting"
		end

		function arg_256_1.playNext_(arg_258_0)
			if arg_258_0 == 1 then
				arg_256_0:Play324131064(arg_256_1)
			end
		end

		function arg_256_1.onSingleLineUpdate_(arg_259_0)
			if 0 < arg_256_1.time_ and arg_256_1.time_ <= 0 + arg_259_0 then
				arg_256_1.var_.moveOldPos1053ui_story = arg_256_1.actors_["1053ui_story"].transform.localPosition

				local var_259_0 = GameObjectTools.GetOrAddComponent(arg_256_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_259_0 then
					var_259_0:EnableDynamicBone(false)
				end
			end

			local var_259_1 = 0.001

			if 0 <= arg_256_1.time_ and arg_256_1.time_ < 0 + var_259_1 then
				arg_256_1.actors_["1053ui_story"].transform.localPosition = Vector3.Lerp(arg_256_1.var_.moveOldPos1053ui_story, Vector3.New(0, 100, 0), (arg_256_1.time_ - 0) / var_259_1)
				arg_256_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_256_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_256_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_256_1.actors_["1053ui_story"].transform.position).z)
				arg_256_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_256_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_256_1.actors_["1053ui_story"].transform.localEulerAngles = arg_256_1.actors_["1053ui_story"].transform.localEulerAngles
			end

			if arg_256_1.time_ >= 0 + var_259_1 and arg_256_1.time_ < 0 + var_259_1 + arg_259_0 then
				arg_256_1.actors_["1053ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_256_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_256_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_256_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_256_1.actors_["1053ui_story"].transform.position).z)
				arg_256_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_256_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_256_1.actors_["1053ui_story"].transform.localEulerAngles = arg_256_1.actors_["1053ui_story"].transform.localEulerAngles

				local var_259_2 = GameObjectTools.GetOrAddComponent(arg_256_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_259_2 then
					var_259_2:EnableDynamicBone(true)
				end
			end

			local var_259_3 = arg_256_1.actors_["1053ui_story"]

			if 0 < arg_256_1.time_ and arg_256_1.time_ <= 0 + arg_259_0 and not isNil(var_259_3) and arg_256_1.var_.characterEffect1053ui_story == nil then
				arg_256_1.var_.characterEffect1053ui_story = var_259_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_259_4 = 0.200000002980232

			if 0 <= arg_256_1.time_ and arg_256_1.time_ < 0 + var_259_4 and not isNil(var_259_3) then
				if arg_256_1.var_.characterEffect1053ui_story and not isNil(var_259_3) then
					arg_256_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_256_1.var_.characterEffect1053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_256_1.time_ - 0) / var_259_4)
				end
			end

			if arg_256_1.time_ >= 0 + var_259_4 and arg_256_1.time_ < 0 + var_259_4 + arg_259_0 and not isNil(var_259_3) and arg_256_1.var_.characterEffect1053ui_story then
				arg_256_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_256_1.var_.characterEffect1053ui_story.fillRatio = 0.5
			end

			if 0.4 < arg_256_1.time_ and arg_256_1.time_ <= 0.4 + arg_259_0 then
				arg_256_1:AudioAction("play", "effect", "se_story_150", "se_story_150_box02", "")
			end

			local var_259_6 = 0
			local var_259_7 = 0.975

			if 0 < arg_256_1.time_ and arg_256_1.time_ <= var_259_6 + arg_259_0 then
				arg_256_1.talkMaxDuration = 0
				arg_256_1.dialogCg_.alpha = 1

				arg_256_1.dialog_:SetActive(true)
				SetActive(arg_256_1.leftNameGo_, false)

				arg_256_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_256_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_256_1:RecordName(arg_256_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_256_1.iconTrs_.gameObject, false)
				arg_256_1.callingController_:SetSelectedState("normal")

				local var_259_8 = arg_256_1:FormatText(arg_256_1:GetWordFromCfg(324131063).content)

				arg_256_1.text_.text = var_259_8

				LuaForUtil.ClearLinePrefixSymbol(arg_256_1.text_)

				local var_259_10 = 39 <= 0 and var_259_7 or var_259_7 * (utf8.len(var_259_8) / 39)

				if (39 <= 0 and var_259_7 or var_259_7 * (utf8.len(var_259_8) / 39)) > 0 and var_259_7 < var_259_10 then
					arg_256_1.talkMaxDuration = var_259_10

					if var_259_10 + var_259_6 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_10 + var_259_6
					end
				end

				arg_256_1.text_.text = var_259_8
				arg_256_1.typewritter.percent = 0

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(false)
				arg_256_1:RecordContent(arg_256_1.text_.text)
			end

			local var_259_11 = math.max(var_259_7, arg_256_1.talkMaxDuration)

			if var_259_6 <= arg_256_1.time_ and arg_256_1.time_ < var_259_6 + var_259_11 then
				arg_256_1.typewritter.percent = (arg_256_1.time_ - var_259_6) / var_259_11

				arg_256_1.typewritter:SetDirty()
			end

			if arg_256_1.time_ >= var_259_6 + var_259_11 and arg_256_1.time_ < var_259_6 + var_259_11 + arg_259_0 then
				arg_256_1.typewritter.percent = 1

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(true)
			end
		end

		arg_256_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_256_1:InitPlayNodeList()
	end,
	Play324131064 = function(arg_260_0, arg_260_1)
		arg_260_1.time_ = 0
		arg_260_1.frameCnt_ = 0
		arg_260_1.state_ = "playing"
		arg_260_1.curTalkId_ = 324131064
		arg_260_1.duration_ = 4.77

		local var_260_0 = {
			zh = 4.766,
			ja = 2.733
		}
		local var_260_1 = manager.audio:GetLocalizationFlag()

		if var_260_0[var_260_1] ~= nil then
			arg_260_1.duration_ = var_260_0[var_260_1]
		end

		SetActive(arg_260_1.tipsGo_, false)

		function arg_260_1.onSingleLineFinish_()
			arg_260_1.onSingleLineUpdate_ = nil
			arg_260_1.onSingleLineFinish_ = nil
			arg_260_1.state_ = "waiting"
		end

		function arg_260_1.playNext_(arg_262_0)
			if arg_262_0 == 1 then
				arg_260_0:Play324131065(arg_260_1)
			end
		end

		function arg_260_1.onSingleLineUpdate_(arg_263_0)
			if 0 < arg_260_1.time_ and arg_260_1.time_ <= 0 + arg_263_0 then
				arg_260_1.var_.moveOldPos1070ui_story = arg_260_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_263_0 = 0.001

			if 0 <= arg_260_1.time_ and arg_260_1.time_ < 0 + var_263_0 then
				arg_260_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_260_1.var_.moveOldPos1070ui_story, Vector3.New(-0.7, -0.95, -6.05), (arg_260_1.time_ - 0) / var_263_0)
				arg_260_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_260_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_260_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_260_1.actors_["1070ui_story"].transform.position).z)
				arg_260_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_260_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_260_1.actors_["1070ui_story"].transform.localEulerAngles = arg_260_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_260_1.time_ >= 0 + var_263_0 and arg_260_1.time_ < 0 + var_263_0 + arg_263_0 then
				arg_260_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(-0.7, -0.95, -6.05)
				arg_260_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_260_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_260_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_260_1.actors_["1070ui_story"].transform.position).z)
				arg_260_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_260_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_260_1.actors_["1070ui_story"].transform.localEulerAngles = arg_260_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_263_1 = arg_260_1.actors_["1070ui_story"]

			if 0 < arg_260_1.time_ and arg_260_1.time_ <= 0 + arg_263_0 and not isNil(var_263_1) and arg_260_1.var_.characterEffect1070ui_story == nil then
				arg_260_1.var_.characterEffect1070ui_story = var_263_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_263_2 = 0.200000002980232

			if 0 <= arg_260_1.time_ and arg_260_1.time_ < 0 + var_263_2 and not isNil(var_263_1) then
				if arg_260_1.var_.characterEffect1070ui_story and not isNil(var_263_1) then
					arg_260_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_260_1.time_ >= 0 + var_263_2 and arg_260_1.time_ < 0 + var_263_2 + arg_263_0 and not isNil(var_263_1) and arg_260_1.var_.characterEffect1070ui_story then
				arg_260_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_260_1.time_ and arg_260_1.time_ <= 0 + arg_263_0 then
				arg_260_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action3_1")
			end

			if 0 < arg_260_1.time_ and arg_260_1.time_ <= 0 + arg_263_0 then
				arg_260_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva", "EmotionTimelineAnimator")
			end

			local var_263_4 = 0
			local var_263_5 = 0.175

			if 0 < arg_260_1.time_ and arg_260_1.time_ <= var_263_4 + arg_263_0 then
				arg_260_1.talkMaxDuration = 0
				arg_260_1.dialogCg_.alpha = 1

				arg_260_1.dialog_:SetActive(true)
				SetActive(arg_260_1.leftNameGo_, true)

				arg_260_1.leftNameTxt_.text = arg_260_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_260_1.leftNameTxt_.transform)

				arg_260_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_260_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_260_1:RecordName(arg_260_1.leftNameTxt_.text)
				SetActive(arg_260_1.iconTrs_.gameObject, false)
				arg_260_1.callingController_:SetSelectedState("normal")

				local var_263_6 = arg_260_1:GetWordFromCfg(324131064)
				local var_263_7 = arg_260_1:FormatText(var_263_6.content)

				arg_260_1.text_.text = var_263_7

				LuaForUtil.ClearLinePrefixSymbol(arg_260_1.text_)

				local var_263_9 = 7 <= 0 and var_263_5 or var_263_5 * (utf8.len(var_263_7) / 7)

				if (7 <= 0 and var_263_5 or var_263_5 * (utf8.len(var_263_7) / 7)) > 0 and var_263_5 < var_263_9 then
					arg_260_1.talkMaxDuration = var_263_9

					if var_263_9 + var_263_4 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_9 + var_263_4
					end
				end

				arg_260_1.text_.text = var_263_7
				arg_260_1.typewritter.percent = 0

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324131", "324131064", "story_v_out_324131.awb") ~= 0 then
					local var_263_10 = manager.audio:GetVoiceLength("story_v_out_324131", "324131064", "story_v_out_324131.awb") / 1000

					if var_263_10 + var_263_4 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_10 + var_263_4
					end

					if var_263_6.prefab_name ~= "" and arg_260_1.actors_[var_263_6.prefab_name] ~= nil then
						local var_263_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_260_1.actors_[var_263_6.prefab_name].transform, "story_v_out_324131", "324131064", "story_v_out_324131.awb")

						arg_260_1:RecordAudio("324131064", var_263_11)
						arg_260_1:RecordAudio("324131064", var_263_11)
					else
						arg_260_1:AudioAction("play", "voice", "story_v_out_324131", "324131064", "story_v_out_324131.awb")
					end

					arg_260_1:RecordHistoryTalkVoice("story_v_out_324131", "324131064", "story_v_out_324131.awb")
				end

				arg_260_1:RecordContent(arg_260_1.text_.text)
			end

			local var_263_12 = math.max(var_263_5, arg_260_1.talkMaxDuration)

			if var_263_4 <= arg_260_1.time_ and arg_260_1.time_ < var_263_4 + var_263_12 then
				arg_260_1.typewritter.percent = (arg_260_1.time_ - var_263_4) / var_263_12

				arg_260_1.typewritter:SetDirty()
			end

			if arg_260_1.time_ >= var_263_4 + var_263_12 and arg_260_1.time_ < var_263_4 + var_263_12 + arg_263_0 then
				arg_260_1.typewritter.percent = 1

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(true)
			end
		end

		arg_260_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_260_1:InitPlayNodeList()
	end,
	Play324131065 = function(arg_264_0, arg_264_1)
		arg_264_1.time_ = 0
		arg_264_1.frameCnt_ = 0
		arg_264_1.state_ = "playing"
		arg_264_1.curTalkId_ = 324131065
		arg_264_1.duration_ = 4.9

		local var_264_0 = {
			zh = 4.466,
			ja = 4.9
		}
		local var_264_1 = manager.audio:GetLocalizationFlag()

		if var_264_0[var_264_1] ~= nil then
			arg_264_1.duration_ = var_264_0[var_264_1]
		end

		SetActive(arg_264_1.tipsGo_, false)

		function arg_264_1.onSingleLineFinish_()
			arg_264_1.onSingleLineUpdate_ = nil
			arg_264_1.onSingleLineFinish_ = nil
			arg_264_1.state_ = "waiting"
		end

		function arg_264_1.playNext_(arg_266_0)
			if arg_266_0 == 1 then
				arg_264_0:Play324131066(arg_264_1)
			end
		end

		function arg_264_1.onSingleLineUpdate_(arg_267_0)
			if 0 < arg_264_1.time_ and arg_264_1.time_ <= 0 + arg_267_0 then
				arg_264_1.var_.moveOldPos1053ui_story = arg_264_1.actors_["1053ui_story"].transform.localPosition

				local var_267_0 = GameObjectTools.GetOrAddComponent(arg_264_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_267_0 then
					var_267_0:EnableDynamicBone(false)
				end
			end

			local var_267_1 = 0.001

			if 0 <= arg_264_1.time_ and arg_264_1.time_ < 0 + var_267_1 then
				arg_264_1.actors_["1053ui_story"].transform.localPosition = Vector3.Lerp(arg_264_1.var_.moveOldPos1053ui_story, Vector3.New(0.7, -1.08, -6), (arg_264_1.time_ - 0) / var_267_1)
				arg_264_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_264_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_264_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_264_1.actors_["1053ui_story"].transform.position).z)
				arg_264_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_264_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_264_1.actors_["1053ui_story"].transform.localEulerAngles = arg_264_1.actors_["1053ui_story"].transform.localEulerAngles
			end

			if arg_264_1.time_ >= 0 + var_267_1 and arg_264_1.time_ < 0 + var_267_1 + arg_267_0 then
				arg_264_1.actors_["1053ui_story"].transform.localPosition = Vector3.New(0.7, -1.08, -6)
				arg_264_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_264_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_264_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_264_1.actors_["1053ui_story"].transform.position).z)
				arg_264_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_264_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_264_1.actors_["1053ui_story"].transform.localEulerAngles = arg_264_1.actors_["1053ui_story"].transform.localEulerAngles

				local var_267_2 = GameObjectTools.GetOrAddComponent(arg_264_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_267_2 then
					var_267_2:EnableDynamicBone(true)
				end
			end

			local var_267_3 = arg_264_1.actors_["1053ui_story"]

			if 0 < arg_264_1.time_ and arg_264_1.time_ <= 0 + arg_267_0 and not isNil(var_267_3) and arg_264_1.var_.characterEffect1053ui_story == nil then
				arg_264_1.var_.characterEffect1053ui_story = var_267_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_267_4 = 0.200000002980232

			if 0 <= arg_264_1.time_ and arg_264_1.time_ < 0 + var_267_4 and not isNil(var_267_3) then
				if arg_264_1.var_.characterEffect1053ui_story and not isNil(var_267_3) then
					arg_264_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_264_1.time_ >= 0 + var_267_4 and arg_264_1.time_ < 0 + var_267_4 + arg_267_0 and not isNil(var_267_3) and arg_264_1.var_.characterEffect1053ui_story then
				arg_264_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_267_6 = arg_264_1.actors_["1070ui_story"]

			if 0 < arg_264_1.time_ and arg_264_1.time_ <= 0 + arg_267_0 and not isNil(var_267_6) and arg_264_1.var_.characterEffect1070ui_story == nil then
				arg_264_1.var_.characterEffect1070ui_story = var_267_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_267_7 = 0.200000002980232

			if 0 <= arg_264_1.time_ and arg_264_1.time_ < 0 + var_267_7 and not isNil(var_267_6) then
				if arg_264_1.var_.characterEffect1070ui_story and not isNil(var_267_6) then
					arg_264_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_264_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_264_1.time_ - 0) / var_267_7)
				end
			end

			if arg_264_1.time_ >= 0 + var_267_7 and arg_264_1.time_ < 0 + var_267_7 + arg_267_0 and not isNil(var_267_6) and arg_264_1.var_.characterEffect1070ui_story then
				arg_264_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_264_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_267_8 = 0
			local var_267_9 = 0.525

			if 0 < arg_264_1.time_ and arg_264_1.time_ <= var_267_8 + arg_267_0 then
				arg_264_1.talkMaxDuration = 0
				arg_264_1.dialogCg_.alpha = 1

				arg_264_1.dialog_:SetActive(true)
				SetActive(arg_264_1.leftNameGo_, true)

				arg_264_1.leftNameTxt_.text = arg_264_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_264_1.leftNameTxt_.transform)

				arg_264_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_264_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_264_1:RecordName(arg_264_1.leftNameTxt_.text)
				SetActive(arg_264_1.iconTrs_.gameObject, false)
				arg_264_1.callingController_:SetSelectedState("normal")

				local var_267_10 = arg_264_1:GetWordFromCfg(324131065)
				local var_267_11 = arg_264_1:FormatText(var_267_10.content)

				arg_264_1.text_.text = var_267_11

				LuaForUtil.ClearLinePrefixSymbol(arg_264_1.text_)

				local var_267_13 = 21 <= 0 and var_267_9 or var_267_9 * (utf8.len(var_267_11) / 21)

				if (21 <= 0 and var_267_9 or var_267_9 * (utf8.len(var_267_11) / 21)) > 0 and var_267_9 < var_267_13 then
					arg_264_1.talkMaxDuration = var_267_13

					if var_267_13 + var_267_8 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_13 + var_267_8
					end
				end

				arg_264_1.text_.text = var_267_11
				arg_264_1.typewritter.percent = 0

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324131", "324131065", "story_v_out_324131.awb") ~= 0 then
					local var_267_14 = manager.audio:GetVoiceLength("story_v_out_324131", "324131065", "story_v_out_324131.awb") / 1000

					if var_267_14 + var_267_8 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_14 + var_267_8
					end

					if var_267_10.prefab_name ~= "" and arg_264_1.actors_[var_267_10.prefab_name] ~= nil then
						local var_267_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_264_1.actors_[var_267_10.prefab_name].transform, "story_v_out_324131", "324131065", "story_v_out_324131.awb")

						arg_264_1:RecordAudio("324131065", var_267_15)
						arg_264_1:RecordAudio("324131065", var_267_15)
					else
						arg_264_1:AudioAction("play", "voice", "story_v_out_324131", "324131065", "story_v_out_324131.awb")
					end

					arg_264_1:RecordHistoryTalkVoice("story_v_out_324131", "324131065", "story_v_out_324131.awb")
				end

				arg_264_1:RecordContent(arg_264_1.text_.text)
			end

			local var_267_16 = math.max(var_267_9, arg_264_1.talkMaxDuration)

			if var_267_8 <= arg_264_1.time_ and arg_264_1.time_ < var_267_8 + var_267_16 then
				arg_264_1.typewritter.percent = (arg_264_1.time_ - var_267_8) / var_267_16

				arg_264_1.typewritter:SetDirty()
			end

			if arg_264_1.time_ >= var_267_8 + var_267_16 and arg_264_1.time_ < var_267_8 + var_267_16 + arg_267_0 then
				arg_264_1.typewritter.percent = 1

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(true)
			end
		end

		arg_264_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_264_1:InitPlayNodeList()
	end,
	Play324131066 = function(arg_268_0, arg_268_1)
		arg_268_1.time_ = 0
		arg_268_1.frameCnt_ = 0
		arg_268_1.state_ = "playing"
		arg_268_1.curTalkId_ = 324131066
		arg_268_1.duration_ = 5

		SetActive(arg_268_1.tipsGo_, false)

		function arg_268_1.onSingleLineFinish_()
			arg_268_1.onSingleLineUpdate_ = nil
			arg_268_1.onSingleLineFinish_ = nil
			arg_268_1.state_ = "waiting"
		end

		function arg_268_1.playNext_(arg_270_0)
			if arg_270_0 == 1 then
				arg_268_0:Play324131067(arg_268_1)
			end
		end

		function arg_268_1.onSingleLineUpdate_(arg_271_0)
			if 0 < arg_268_1.time_ and arg_268_1.time_ <= 0 + arg_271_0 then
				arg_268_1.var_.moveOldPos1070ui_story = arg_268_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_271_0 = 0.001

			if 0 <= arg_268_1.time_ and arg_268_1.time_ < 0 + var_271_0 then
				arg_268_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_268_1.var_.moveOldPos1070ui_story, Vector3.New(0, 100, 0), (arg_268_1.time_ - 0) / var_271_0)
				arg_268_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_268_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_268_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_268_1.actors_["1070ui_story"].transform.position).z)
				arg_268_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_268_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_268_1.actors_["1070ui_story"].transform.localEulerAngles = arg_268_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_268_1.time_ >= 0 + var_271_0 and arg_268_1.time_ < 0 + var_271_0 + arg_271_0 then
				arg_268_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_268_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_268_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_268_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_268_1.actors_["1070ui_story"].transform.position).z)
				arg_268_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_268_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_268_1.actors_["1070ui_story"].transform.localEulerAngles = arg_268_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_271_1 = arg_268_1.actors_["1053ui_story"].transform

			if 0 < arg_268_1.time_ and arg_268_1.time_ <= 0 + arg_271_0 then
				arg_268_1.var_.moveOldPos1053ui_story = var_271_1.localPosition

				local var_271_2 = GameObjectTools.GetOrAddComponent(var_271_1.gameObject, typeof(DynamicBoneHelper))

				if var_271_2 then
					var_271_2:EnableDynamicBone(false)
				end
			end

			local var_271_3 = 0.001

			if 0 <= arg_268_1.time_ and arg_268_1.time_ < 0 + var_271_3 then
				var_271_1.localPosition = Vector3.Lerp(arg_268_1.var_.moveOldPos1053ui_story, Vector3.New(0, 100, 0), (arg_268_1.time_ - 0) / var_271_3)
				var_271_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_271_1.position).x, (manager.ui.mainCamera.transform.position - var_271_1.position).y, (manager.ui.mainCamera.transform.position - var_271_1.position).z)
				var_271_1.localEulerAngles.z = 0
				var_271_1.localEulerAngles.x = 0
				var_271_1.localEulerAngles = var_271_1.localEulerAngles
			end

			if arg_268_1.time_ >= 0 + var_271_3 and arg_268_1.time_ < 0 + var_271_3 + arg_271_0 then
				var_271_1.localPosition = Vector3.New(0, 100, 0)
				var_271_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_271_1.position).x, (manager.ui.mainCamera.transform.position - var_271_1.position).y, (manager.ui.mainCamera.transform.position - var_271_1.position).z)
				var_271_1.localEulerAngles.z = 0
				var_271_1.localEulerAngles.x = 0
				var_271_1.localEulerAngles = var_271_1.localEulerAngles

				local var_271_4 = GameObjectTools.GetOrAddComponent(var_271_1.gameObject, typeof(DynamicBoneHelper))

				if var_271_4 then
					var_271_4:EnableDynamicBone(true)
				end
			end

			local var_271_5 = arg_268_1.actors_["1053ui_story"]

			if 0 < arg_268_1.time_ and arg_268_1.time_ <= 0 + arg_271_0 and not isNil(var_271_5) and arg_268_1.var_.characterEffect1053ui_story == nil then
				arg_268_1.var_.characterEffect1053ui_story = var_271_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_271_6 = 0.200000002980232

			if 0 <= arg_268_1.time_ and arg_268_1.time_ < 0 + var_271_6 and not isNil(var_271_5) then
				if arg_268_1.var_.characterEffect1053ui_story and not isNil(var_271_5) then
					arg_268_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_268_1.var_.characterEffect1053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_268_1.time_ - 0) / var_271_6)
				end
			end

			if arg_268_1.time_ >= 0 + var_271_6 and arg_268_1.time_ < 0 + var_271_6 + arg_271_0 and not isNil(var_271_5) and arg_268_1.var_.characterEffect1053ui_story then
				arg_268_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_268_1.var_.characterEffect1053ui_story.fillRatio = 0.5
			end

			local var_271_7 = 0
			local var_271_8 = 1.2

			if 0 < arg_268_1.time_ and arg_268_1.time_ <= var_271_7 + arg_271_0 then
				arg_268_1.talkMaxDuration = 0
				arg_268_1.dialogCg_.alpha = 1

				arg_268_1.dialog_:SetActive(true)
				SetActive(arg_268_1.leftNameGo_, false)

				arg_268_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_268_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_268_1:RecordName(arg_268_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_268_1.iconTrs_.gameObject, false)
				arg_268_1.callingController_:SetSelectedState("normal")

				local var_271_9 = arg_268_1:FormatText(arg_268_1:GetWordFromCfg(324131066).content)

				arg_268_1.text_.text = var_271_9

				LuaForUtil.ClearLinePrefixSymbol(arg_268_1.text_)

				local var_271_11 = 48 <= 0 and var_271_8 or var_271_8 * (utf8.len(var_271_9) / 48)

				if (48 <= 0 and var_271_8 or var_271_8 * (utf8.len(var_271_9) / 48)) > 0 and var_271_8 < var_271_11 then
					arg_268_1.talkMaxDuration = var_271_11

					if var_271_11 + var_271_7 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_11 + var_271_7
					end
				end

				arg_268_1.text_.text = var_271_9
				arg_268_1.typewritter.percent = 0

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(false)
				arg_268_1:RecordContent(arg_268_1.text_.text)
			end

			local var_271_12 = math.max(var_271_8, arg_268_1.talkMaxDuration)

			if var_271_7 <= arg_268_1.time_ and arg_268_1.time_ < var_271_7 + var_271_12 then
				arg_268_1.typewritter.percent = (arg_268_1.time_ - var_271_7) / var_271_12

				arg_268_1.typewritter:SetDirty()
			end

			if arg_268_1.time_ >= var_271_7 + var_271_12 and arg_268_1.time_ < var_271_7 + var_271_12 + arg_271_0 then
				arg_268_1.typewritter.percent = 1

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(true)
			end
		end

		arg_268_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_268_1:InitPlayNodeList()
	end,
	Play324131067 = function(arg_272_0, arg_272_1)
		arg_272_1.time_ = 0
		arg_272_1.frameCnt_ = 0
		arg_272_1.state_ = "playing"
		arg_272_1.curTalkId_ = 324131067
		arg_272_1.duration_ = 6.13

		local var_272_0 = {
			zh = 4.466,
			ja = 6.133
		}
		local var_272_1 = manager.audio:GetLocalizationFlag()

		if var_272_0[var_272_1] ~= nil then
			arg_272_1.duration_ = var_272_0[var_272_1]
		end

		SetActive(arg_272_1.tipsGo_, false)

		function arg_272_1.onSingleLineFinish_()
			arg_272_1.onSingleLineUpdate_ = nil
			arg_272_1.onSingleLineFinish_ = nil
			arg_272_1.state_ = "waiting"
		end

		function arg_272_1.playNext_(arg_274_0)
			if arg_274_0 == 1 then
				arg_272_0:Play324131068(arg_272_1)
			end
		end

		function arg_272_1.onSingleLineUpdate_(arg_275_0)
			if 0 < arg_272_1.time_ and arg_272_1.time_ <= 0 + arg_275_0 then
				arg_272_1.var_.moveOldPos1070ui_story = arg_272_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_275_0 = 0.001

			if 0 <= arg_272_1.time_ and arg_272_1.time_ < 0 + var_275_0 then
				arg_272_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_272_1.var_.moveOldPos1070ui_story, Vector3.New(-0.7, -0.95, -6.05), (arg_272_1.time_ - 0) / var_275_0)
				arg_272_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_272_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_272_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_272_1.actors_["1070ui_story"].transform.position).z)
				arg_272_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_272_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_272_1.actors_["1070ui_story"].transform.localEulerAngles = arg_272_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_272_1.time_ >= 0 + var_275_0 and arg_272_1.time_ < 0 + var_275_0 + arg_275_0 then
				arg_272_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(-0.7, -0.95, -6.05)
				arg_272_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_272_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_272_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_272_1.actors_["1070ui_story"].transform.position).z)
				arg_272_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_272_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_272_1.actors_["1070ui_story"].transform.localEulerAngles = arg_272_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_275_1 = arg_272_1.actors_["1070ui_story"]

			if 0 < arg_272_1.time_ and arg_272_1.time_ <= 0 + arg_275_0 and not isNil(var_275_1) and arg_272_1.var_.characterEffect1070ui_story == nil then
				arg_272_1.var_.characterEffect1070ui_story = var_275_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_275_2 = 0.200000002980232

			if 0 <= arg_272_1.time_ and arg_272_1.time_ < 0 + var_275_2 and not isNil(var_275_1) then
				if arg_272_1.var_.characterEffect1070ui_story and not isNil(var_275_1) then
					arg_272_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_272_1.time_ >= 0 + var_275_2 and arg_272_1.time_ < 0 + var_275_2 + arg_275_0 and not isNil(var_275_1) and arg_272_1.var_.characterEffect1070ui_story then
				arg_272_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_272_1.time_ and arg_272_1.time_ <= 0 + arg_275_0 then
				arg_272_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070actionlink/1070action437")
			end

			if 0 < arg_272_1.time_ and arg_272_1.time_ <= 0 + arg_275_0 then
				arg_272_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_275_4 = 0
			local var_275_5 = 0.525

			if 0 < arg_272_1.time_ and arg_272_1.time_ <= var_275_4 + arg_275_0 then
				arg_272_1.talkMaxDuration = 0
				arg_272_1.dialogCg_.alpha = 1

				arg_272_1.dialog_:SetActive(true)
				SetActive(arg_272_1.leftNameGo_, true)

				arg_272_1.leftNameTxt_.text = arg_272_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_272_1.leftNameTxt_.transform)

				arg_272_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_272_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_272_1:RecordName(arg_272_1.leftNameTxt_.text)
				SetActive(arg_272_1.iconTrs_.gameObject, false)
				arg_272_1.callingController_:SetSelectedState("normal")

				local var_275_6 = arg_272_1:GetWordFromCfg(324131067)
				local var_275_7 = arg_272_1:FormatText(var_275_6.content)

				arg_272_1.text_.text = var_275_7

				LuaForUtil.ClearLinePrefixSymbol(arg_272_1.text_)

				local var_275_9 = 21 <= 0 and var_275_5 or var_275_5 * (utf8.len(var_275_7) / 21)

				if (21 <= 0 and var_275_5 or var_275_5 * (utf8.len(var_275_7) / 21)) > 0 and var_275_5 < var_275_9 then
					arg_272_1.talkMaxDuration = var_275_9

					if var_275_9 + var_275_4 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_9 + var_275_4
					end
				end

				arg_272_1.text_.text = var_275_7
				arg_272_1.typewritter.percent = 0

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324131", "324131067", "story_v_out_324131.awb") ~= 0 then
					local var_275_10 = manager.audio:GetVoiceLength("story_v_out_324131", "324131067", "story_v_out_324131.awb") / 1000

					if var_275_10 + var_275_4 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_10 + var_275_4
					end

					if var_275_6.prefab_name ~= "" and arg_272_1.actors_[var_275_6.prefab_name] ~= nil then
						local var_275_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_272_1.actors_[var_275_6.prefab_name].transform, "story_v_out_324131", "324131067", "story_v_out_324131.awb")

						arg_272_1:RecordAudio("324131067", var_275_11)
						arg_272_1:RecordAudio("324131067", var_275_11)
					else
						arg_272_1:AudioAction("play", "voice", "story_v_out_324131", "324131067", "story_v_out_324131.awb")
					end

					arg_272_1:RecordHistoryTalkVoice("story_v_out_324131", "324131067", "story_v_out_324131.awb")
				end

				arg_272_1:RecordContent(arg_272_1.text_.text)
			end

			local var_275_12 = math.max(var_275_5, arg_272_1.talkMaxDuration)

			if var_275_4 <= arg_272_1.time_ and arg_272_1.time_ < var_275_4 + var_275_12 then
				arg_272_1.typewritter.percent = (arg_272_1.time_ - var_275_4) / var_275_12

				arg_272_1.typewritter:SetDirty()
			end

			if arg_272_1.time_ >= var_275_4 + var_275_12 and arg_272_1.time_ < var_275_4 + var_275_12 + arg_275_0 then
				arg_272_1.typewritter.percent = 1

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(true)
			end
		end

		arg_272_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_272_1:InitPlayNodeList()
	end,
	Play324131068 = function(arg_276_0, arg_276_1)
		arg_276_1.time_ = 0
		arg_276_1.frameCnt_ = 0
		arg_276_1.state_ = "playing"
		arg_276_1.curTalkId_ = 324131068
		arg_276_1.duration_ = 6.1

		local var_276_0 = {
			zh = 5.866,
			ja = 6.1
		}
		local var_276_1 = manager.audio:GetLocalizationFlag()

		if var_276_0[var_276_1] ~= nil then
			arg_276_1.duration_ = var_276_0[var_276_1]
		end

		SetActive(arg_276_1.tipsGo_, false)

		function arg_276_1.onSingleLineFinish_()
			arg_276_1.onSingleLineUpdate_ = nil
			arg_276_1.onSingleLineFinish_ = nil
			arg_276_1.state_ = "waiting"
		end

		function arg_276_1.playNext_(arg_278_0)
			if arg_278_0 == 1 then
				arg_276_0:Play324131069(arg_276_1)
			end
		end

		function arg_276_1.onSingleLineUpdate_(arg_279_0)
			if 0 < arg_276_1.time_ and arg_276_1.time_ <= 0 + arg_279_0 then
				arg_276_1.var_.moveOldPos1053ui_story = arg_276_1.actors_["1053ui_story"].transform.localPosition

				local var_279_0 = GameObjectTools.GetOrAddComponent(arg_276_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_279_0 then
					var_279_0:EnableDynamicBone(false)
				end
			end

			local var_279_1 = 0.001

			if 0 <= arg_276_1.time_ and arg_276_1.time_ < 0 + var_279_1 then
				arg_276_1.actors_["1053ui_story"].transform.localPosition = Vector3.Lerp(arg_276_1.var_.moveOldPos1053ui_story, Vector3.New(0.7, -1.08, -6), (arg_276_1.time_ - 0) / var_279_1)
				arg_276_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_276_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_276_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_276_1.actors_["1053ui_story"].transform.position).z)
				arg_276_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_276_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_276_1.actors_["1053ui_story"].transform.localEulerAngles = arg_276_1.actors_["1053ui_story"].transform.localEulerAngles
			end

			if arg_276_1.time_ >= 0 + var_279_1 and arg_276_1.time_ < 0 + var_279_1 + arg_279_0 then
				arg_276_1.actors_["1053ui_story"].transform.localPosition = Vector3.New(0.7, -1.08, -6)
				arg_276_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_276_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_276_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_276_1.actors_["1053ui_story"].transform.position).z)
				arg_276_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_276_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_276_1.actors_["1053ui_story"].transform.localEulerAngles = arg_276_1.actors_["1053ui_story"].transform.localEulerAngles

				local var_279_2 = GameObjectTools.GetOrAddComponent(arg_276_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_279_2 then
					var_279_2:EnableDynamicBone(true)
				end
			end

			local var_279_3 = arg_276_1.actors_["1053ui_story"]

			if 0 < arg_276_1.time_ and arg_276_1.time_ <= 0 + arg_279_0 and not isNil(var_279_3) and arg_276_1.var_.characterEffect1053ui_story == nil then
				arg_276_1.var_.characterEffect1053ui_story = var_279_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_279_4 = 0.200000002980232

			if 0 <= arg_276_1.time_ and arg_276_1.time_ < 0 + var_279_4 and not isNil(var_279_3) then
				if arg_276_1.var_.characterEffect1053ui_story and not isNil(var_279_3) then
					arg_276_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_276_1.time_ >= 0 + var_279_4 and arg_276_1.time_ < 0 + var_279_4 + arg_279_0 and not isNil(var_279_3) and arg_276_1.var_.characterEffect1053ui_story then
				arg_276_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_279_6 = arg_276_1.actors_["1070ui_story"]

			if 0 < arg_276_1.time_ and arg_276_1.time_ <= 0 + arg_279_0 and not isNil(var_279_6) and arg_276_1.var_.characterEffect1070ui_story == nil then
				arg_276_1.var_.characterEffect1070ui_story = var_279_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_279_7 = 0.200000002980232

			if 0 <= arg_276_1.time_ and arg_276_1.time_ < 0 + var_279_7 and not isNil(var_279_6) then
				if arg_276_1.var_.characterEffect1070ui_story and not isNil(var_279_6) then
					arg_276_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_276_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_276_1.time_ - 0) / var_279_7)
				end
			end

			if arg_276_1.time_ >= 0 + var_279_7 and arg_276_1.time_ < 0 + var_279_7 + arg_279_0 and not isNil(var_279_6) and arg_276_1.var_.characterEffect1070ui_story then
				arg_276_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_276_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			if 0 < arg_276_1.time_ and arg_276_1.time_ <= 0 + arg_279_0 then
				arg_276_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053action/1053action3_1")
			end

			if 0 < arg_276_1.time_ and arg_276_1.time_ <= 0 + arg_279_0 then
				arg_276_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_279_8 = 0
			local var_279_9 = 0.525

			if 0 < arg_276_1.time_ and arg_276_1.time_ <= var_279_8 + arg_279_0 then
				arg_276_1.talkMaxDuration = 0
				arg_276_1.dialogCg_.alpha = 1

				arg_276_1.dialog_:SetActive(true)
				SetActive(arg_276_1.leftNameGo_, true)

				arg_276_1.leftNameTxt_.text = arg_276_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_276_1.leftNameTxt_.transform)

				arg_276_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_276_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_276_1:RecordName(arg_276_1.leftNameTxt_.text)
				SetActive(arg_276_1.iconTrs_.gameObject, false)
				arg_276_1.callingController_:SetSelectedState("normal")

				local var_279_10 = arg_276_1:GetWordFromCfg(324131068)
				local var_279_11 = arg_276_1:FormatText(var_279_10.content)

				arg_276_1.text_.text = var_279_11

				LuaForUtil.ClearLinePrefixSymbol(arg_276_1.text_)

				local var_279_13 = 21 <= 0 and var_279_9 or var_279_9 * (utf8.len(var_279_11) / 21)

				if (21 <= 0 and var_279_9 or var_279_9 * (utf8.len(var_279_11) / 21)) > 0 and var_279_9 < var_279_13 then
					arg_276_1.talkMaxDuration = var_279_13

					if var_279_13 + var_279_8 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_13 + var_279_8
					end
				end

				arg_276_1.text_.text = var_279_11
				arg_276_1.typewritter.percent = 0

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324131", "324131068", "story_v_out_324131.awb") ~= 0 then
					local var_279_14 = manager.audio:GetVoiceLength("story_v_out_324131", "324131068", "story_v_out_324131.awb") / 1000

					if var_279_14 + var_279_8 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_14 + var_279_8
					end

					if var_279_10.prefab_name ~= "" and arg_276_1.actors_[var_279_10.prefab_name] ~= nil then
						local var_279_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_276_1.actors_[var_279_10.prefab_name].transform, "story_v_out_324131", "324131068", "story_v_out_324131.awb")

						arg_276_1:RecordAudio("324131068", var_279_15)
						arg_276_1:RecordAudio("324131068", var_279_15)
					else
						arg_276_1:AudioAction("play", "voice", "story_v_out_324131", "324131068", "story_v_out_324131.awb")
					end

					arg_276_1:RecordHistoryTalkVoice("story_v_out_324131", "324131068", "story_v_out_324131.awb")
				end

				arg_276_1:RecordContent(arg_276_1.text_.text)
			end

			local var_279_16 = math.max(var_279_9, arg_276_1.talkMaxDuration)

			if var_279_8 <= arg_276_1.time_ and arg_276_1.time_ < var_279_8 + var_279_16 then
				arg_276_1.typewritter.percent = (arg_276_1.time_ - var_279_8) / var_279_16

				arg_276_1.typewritter:SetDirty()
			end

			if arg_276_1.time_ >= var_279_8 + var_279_16 and arg_276_1.time_ < var_279_8 + var_279_16 + arg_279_0 then
				arg_276_1.typewritter.percent = 1

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(true)
			end
		end

		arg_276_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_276_1:InitPlayNodeList()
	end,
	Play324131069 = function(arg_280_0, arg_280_1)
		arg_280_1.time_ = 0
		arg_280_1.frameCnt_ = 0
		arg_280_1.state_ = "playing"
		arg_280_1.curTalkId_ = 324131069
		arg_280_1.duration_ = 8

		SetActive(arg_280_1.tipsGo_, false)

		function arg_280_1.onSingleLineFinish_()
			arg_280_1.onSingleLineUpdate_ = nil
			arg_280_1.onSingleLineFinish_ = nil
			arg_280_1.state_ = "waiting"
		end

		function arg_280_1.playNext_(arg_282_0)
			if arg_282_0 == 1 then
				arg_280_0:Play324131070(arg_280_1)
			end
		end

		function arg_280_1.onSingleLineUpdate_(arg_283_0)
			if arg_280_1.bgs_.STblack == nil then
				local var_283_0 = Object.Instantiate(arg_280_1.paintGo_)

				var_283_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack")
				var_283_0.name = "STblack"
				var_283_0.transform.parent = arg_280_1.stage_.transform
				var_283_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_280_1.bgs_.STblack = var_283_0
			end

			if 1.46666666666667 < arg_280_1.time_ and arg_280_1.time_ <= 1.46666666666667 + arg_283_0 then
				local var_283_1 = arg_280_1.bgs_.STblack

				arg_280_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_283_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_283_2 = var_283_1:GetComponent("SpriteRenderer")

				if var_283_2 and var_283_2.sprite then
					local var_283_3 = 2 * (var_283_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_283_1.transform.localScale = Vector3.New(var_283_3 / var_283_2.sprite.bounds.size.y < var_283_3 * manager.ui.mainCameraCom_.aspect / var_283_2.sprite.bounds.size.x and var_283_3 * manager.ui.mainCameraCom_.aspect / var_283_2.sprite.bounds.size.x or var_283_3 / var_283_2.sprite.bounds.size.y, var_283_3 / var_283_2.sprite.bounds.size.y < var_283_3 * manager.ui.mainCameraCom_.aspect / var_283_2.sprite.bounds.size.x and var_283_3 * manager.ui.mainCameraCom_.aspect / var_283_2.sprite.bounds.size.x or var_283_3 / var_283_2.sprite.bounds.size.y, 0)
				end

				for iter_283_0, iter_283_1 in pairs(arg_280_1.bgs_) do
					if iter_283_0 ~= "STblack" then
						iter_283_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_283_4 = 1.46666666666667

			if 1.46666666666667 < arg_280_1.time_ and arg_280_1.time_ <= var_283_4 + arg_283_0 then
				arg_280_1.allBtn_.enabled = false
			end

			if arg_280_1.time_ >= var_283_4 + 0.3 and arg_280_1.time_ < var_283_4 + 0.3 + arg_283_0 then
				arg_280_1.allBtn_.enabled = true
			end

			local var_283_5 = 0

			if 0 < arg_280_1.time_ and arg_280_1.time_ <= var_283_5 + arg_283_0 then
				arg_280_1.mask_.enabled = true
				arg_280_1.mask_.raycastTarget = true

				arg_280_1:SetGaussion(false)
			end

			local var_283_6 = 1.46666666666667

			if var_283_5 <= arg_280_1.time_ and arg_280_1.time_ < var_283_5 + var_283_6 then
				local var_283_7 = Color.New(0, 0, 0)

				var_283_7.a = Mathf.Lerp(0, 1, (arg_280_1.time_ - var_283_5) / var_283_6)
				arg_280_1.mask_.color = var_283_7
			end

			if arg_280_1.time_ >= var_283_5 + var_283_6 and arg_280_1.time_ < var_283_5 + var_283_6 + arg_283_0 then
				local var_283_8 = Color.New(0, 0, 0)

				var_283_8.a = 1
				arg_280_1.mask_.color = var_283_8
			end

			local var_283_9 = 1.46666666666667

			if 1.46666666666667 < arg_280_1.time_ and arg_280_1.time_ <= var_283_9 + arg_283_0 then
				arg_280_1.mask_.enabled = true
				arg_280_1.mask_.raycastTarget = true

				arg_280_1:SetGaussion(false)
			end

			local var_283_10 = 2

			if var_283_9 <= arg_280_1.time_ and arg_280_1.time_ < var_283_9 + var_283_10 then
				local var_283_11 = Color.New(0, 0, 0)

				var_283_11.a = Mathf.Lerp(1, 0, (arg_280_1.time_ - var_283_9) / var_283_10)
				arg_280_1.mask_.color = var_283_11
			end

			if arg_280_1.time_ >= var_283_9 + var_283_10 and arg_280_1.time_ < var_283_9 + var_283_10 + arg_283_0 then
				local var_283_12 = Color.New(0, 0, 0)

				arg_280_1.mask_.enabled = false
				var_283_12.a = 0
				arg_280_1.mask_.color = var_283_12
			end

			local var_283_13 = arg_280_1.actors_["1070ui_story"].transform

			if 1.46666666666667 < arg_280_1.time_ and arg_280_1.time_ <= 1.46666666666667 + arg_283_0 then
				arg_280_1.var_.moveOldPos1070ui_story = var_283_13.localPosition
			end

			local var_283_14 = 0.001

			if 1.46666666666667 <= arg_280_1.time_ and arg_280_1.time_ < 1.46666666666667 + var_283_14 then
				var_283_13.localPosition = Vector3.Lerp(arg_280_1.var_.moveOldPos1070ui_story, Vector3.New(0, 100, 0), (arg_280_1.time_ - 1.46666666666667) / var_283_14)
				var_283_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_283_13.position).x, (manager.ui.mainCamera.transform.position - var_283_13.position).y, (manager.ui.mainCamera.transform.position - var_283_13.position).z)
				var_283_13.localEulerAngles.z = 0
				var_283_13.localEulerAngles.x = 0
				var_283_13.localEulerAngles = var_283_13.localEulerAngles
			end

			if arg_280_1.time_ >= 1.46666666666667 + var_283_14 and arg_280_1.time_ < 1.46666666666667 + var_283_14 + arg_283_0 then
				var_283_13.localPosition = Vector3.New(0, 100, 0)
				var_283_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_283_13.position).x, (manager.ui.mainCamera.transform.position - var_283_13.position).y, (manager.ui.mainCamera.transform.position - var_283_13.position).z)
				var_283_13.localEulerAngles.z = 0
				var_283_13.localEulerAngles.x = 0
				var_283_13.localEulerAngles = var_283_13.localEulerAngles
			end

			local var_283_15 = arg_280_1.actors_["1053ui_story"].transform

			if 1.46666666666667 < arg_280_1.time_ and arg_280_1.time_ <= 1.46666666666667 + arg_283_0 then
				arg_280_1.var_.moveOldPos1053ui_story = var_283_15.localPosition

				local var_283_16 = GameObjectTools.GetOrAddComponent(var_283_15.gameObject, typeof(DynamicBoneHelper))

				if var_283_16 then
					var_283_16:EnableDynamicBone(false)
				end
			end

			local var_283_17 = 0.001

			if 1.46666666666667 <= arg_280_1.time_ and arg_280_1.time_ < 1.46666666666667 + var_283_17 then
				var_283_15.localPosition = Vector3.Lerp(arg_280_1.var_.moveOldPos1053ui_story, Vector3.New(0, 100, 0), (arg_280_1.time_ - 1.46666666666667) / var_283_17)
				var_283_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_283_15.position).x, (manager.ui.mainCamera.transform.position - var_283_15.position).y, (manager.ui.mainCamera.transform.position - var_283_15.position).z)
				var_283_15.localEulerAngles.z = 0
				var_283_15.localEulerAngles.x = 0
				var_283_15.localEulerAngles = var_283_15.localEulerAngles
			end

			if arg_280_1.time_ >= 1.46666666666667 + var_283_17 and arg_280_1.time_ < 1.46666666666667 + var_283_17 + arg_283_0 then
				var_283_15.localPosition = Vector3.New(0, 100, 0)
				var_283_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_283_15.position).x, (manager.ui.mainCamera.transform.position - var_283_15.position).y, (manager.ui.mainCamera.transform.position - var_283_15.position).z)
				var_283_15.localEulerAngles.z = 0
				var_283_15.localEulerAngles.x = 0
				var_283_15.localEulerAngles = var_283_15.localEulerAngles

				local var_283_18 = GameObjectTools.GetOrAddComponent(var_283_15.gameObject, typeof(DynamicBoneHelper))

				if var_283_18 then
					var_283_18:EnableDynamicBone(true)
				end
			end

			local var_283_19 = arg_280_1.actors_["1053ui_story"]

			if 1.46666666666667 < arg_280_1.time_ and arg_280_1.time_ <= 1.46666666666667 + arg_283_0 and not isNil(var_283_19) and arg_280_1.var_.characterEffect1053ui_story == nil then
				arg_280_1.var_.characterEffect1053ui_story = var_283_19:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_283_20 = 0.200000002980232

			if 1.46666666666667 <= arg_280_1.time_ and arg_280_1.time_ < 1.46666666666667 + var_283_20 and not isNil(var_283_19) then
				if arg_280_1.var_.characterEffect1053ui_story and not isNil(var_283_19) then
					arg_280_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_280_1.var_.characterEffect1053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_280_1.time_ - 1.46666666666667) / var_283_20)
				end
			end

			if arg_280_1.time_ >= 1.46666666666667 + var_283_20 and arg_280_1.time_ < 1.46666666666667 + var_283_20 + arg_283_0 and not isNil(var_283_19) and arg_280_1.var_.characterEffect1053ui_story then
				arg_280_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_280_1.var_.characterEffect1053ui_story.fillRatio = 0.5
			end

			if arg_280_1.frameCnt_ <= 1 then
				arg_280_1.dialog_:SetActive(false)
			end

			local var_283_21 = 3
			local var_283_22 = 0.125

			if 3 < arg_280_1.time_ and arg_280_1.time_ <= var_283_21 + arg_283_0 then
				arg_280_1.talkMaxDuration = 0

				arg_280_1.dialog_:SetActive(true)

				arg_280_1.dialogCg_.alpha = 0

				local var_283_23 = LeanTween.value(arg_280_1.dialog_, 0, 1, 0.3)

				var_283_23:setOnUpdate(LuaHelper.FloatAction(function(arg_284_0)
					arg_280_1.dialogCg_.alpha = arg_284_0
				end))
				var_283_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_280_1.dialog_)
					var_283_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_280_1.duration_ = arg_280_1.duration_ + 0.3

				SetActive(arg_280_1.leftNameGo_, false)

				arg_280_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_280_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_280_1:RecordName(arg_280_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_280_1.iconTrs_.gameObject, false)
				arg_280_1.callingController_:SetSelectedState("normal")

				local var_283_24 = arg_280_1:FormatText(arg_280_1:GetWordFromCfg(324131069).content)

				arg_280_1.text_.text = var_283_24

				LuaForUtil.ClearLinePrefixSymbol(arg_280_1.text_)

				local var_283_26 = 5 <= 0 and var_283_22 or var_283_22 * (utf8.len(var_283_24) / 5)

				if (5 <= 0 and var_283_22 or var_283_22 * (utf8.len(var_283_24) / 5)) > 0 and var_283_22 < var_283_26 then
					arg_280_1.talkMaxDuration = var_283_26
					var_283_21 = var_283_21 + 0.3

					if var_283_26 + var_283_21 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_26 + var_283_21
					end
				end

				arg_280_1.text_.text = var_283_24
				arg_280_1.typewritter.percent = 0

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(false)
				arg_280_1:RecordContent(arg_280_1.text_.text)
			end

			local var_283_27 = var_283_21 + 0.3
			local var_283_28 = math.max(var_283_22, arg_280_1.talkMaxDuration)

			if var_283_21 + 0.3 <= arg_280_1.time_ and arg_280_1.time_ < var_283_27 + var_283_28 then
				arg_280_1.typewritter.percent = (arg_280_1.time_ - var_283_27) / var_283_28

				arg_280_1.typewritter:SetDirty()
			end

			if arg_280_1.time_ >= var_283_27 + var_283_28 and arg_280_1.time_ < var_283_27 + var_283_28 + arg_283_0 then
				arg_280_1.typewritter.percent = 1

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(true)
			end
		end

		arg_280_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.46666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.46666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_280_1:InitPlayNodeList()
	end,
	Play324131070 = function(arg_286_0, arg_286_1)
		arg_286_1.time_ = 0
		arg_286_1.frameCnt_ = 0
		arg_286_1.state_ = "playing"
		arg_286_1.curTalkId_ = 324131070
		arg_286_1.duration_ = 7.5

		local var_286_0 = {
			zh = 5.93300000298023,
			ja = 7.50000000298023
		}
		local var_286_1 = manager.audio:GetLocalizationFlag()

		if var_286_0[var_286_1] ~= nil then
			arg_286_1.duration_ = var_286_0[var_286_1]
		end

		SetActive(arg_286_1.tipsGo_, false)

		function arg_286_1.onSingleLineFinish_()
			arg_286_1.onSingleLineUpdate_ = nil
			arg_286_1.onSingleLineFinish_ = nil
			arg_286_1.state_ = "waiting"
		end

		function arg_286_1.playNext_(arg_288_0)
			if arg_288_0 == 1 then
				arg_286_0:Play324131071(arg_286_1)
			end
		end

		function arg_286_1.onSingleLineUpdate_(arg_289_0)
			if 0 < arg_286_1.time_ and arg_286_1.time_ <= 0 + arg_289_0 then
				local var_289_0 = arg_286_1.bgs_.ST2003

				arg_286_1.bgs_.ST2003.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_289_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_289_1 = var_289_0:GetComponent("SpriteRenderer")

				if var_289_1 and var_289_1.sprite then
					local var_289_2 = 2 * (var_289_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_289_0.transform.localScale = Vector3.New(var_289_2 / var_289_1.sprite.bounds.size.y < var_289_2 * manager.ui.mainCameraCom_.aspect / var_289_1.sprite.bounds.size.x and var_289_2 * manager.ui.mainCameraCom_.aspect / var_289_1.sprite.bounds.size.x or var_289_2 / var_289_1.sprite.bounds.size.y, var_289_2 / var_289_1.sprite.bounds.size.y < var_289_2 * manager.ui.mainCameraCom_.aspect / var_289_1.sprite.bounds.size.x and var_289_2 * manager.ui.mainCameraCom_.aspect / var_289_1.sprite.bounds.size.x or var_289_2 / var_289_1.sprite.bounds.size.y, 0)
				end

				for iter_289_0, iter_289_1 in pairs(arg_286_1.bgs_) do
					if iter_289_0 ~= "ST2003" then
						iter_289_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_289_3 = 0

			if 0 < arg_286_1.time_ and arg_286_1.time_ <= var_289_3 + arg_289_0 then
				arg_286_1.allBtn_.enabled = false
			end

			if arg_286_1.time_ >= var_289_3 + 0.3 and arg_286_1.time_ < var_289_3 + 0.3 + arg_289_0 then
				arg_286_1.allBtn_.enabled = true
			end

			local var_289_4 = 0

			if 0 < arg_286_1.time_ and arg_286_1.time_ <= var_289_4 + arg_289_0 then
				arg_286_1.mask_.enabled = true
				arg_286_1.mask_.raycastTarget = true

				arg_286_1:SetGaussion(false)
			end

			local var_289_5 = 2

			if var_289_4 <= arg_286_1.time_ and arg_286_1.time_ < var_289_4 + var_289_5 then
				local var_289_6 = Color.New(0, 0, 0)

				var_289_6.a = Mathf.Lerp(1, 0, (arg_286_1.time_ - var_289_4) / var_289_5)
				arg_286_1.mask_.color = var_289_6
			end

			if arg_286_1.time_ >= var_289_4 + var_289_5 and arg_286_1.time_ < var_289_4 + var_289_5 + arg_289_0 then
				local var_289_7 = Color.New(0, 0, 0)

				arg_286_1.mask_.enabled = false
				var_289_7.a = 0
				arg_286_1.mask_.color = var_289_7
			end

			local var_289_8 = "1170ui_story"

			if arg_286_1.actors_["1170ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1170ui_story"))) then
				local var_289_9 = Object.Instantiate(Asset.Load("Char/" .. "1170ui_story"), arg_286_1.stage_.transform)

				var_289_9.name = var_289_8
				var_289_9.transform.localPosition = Vector3.New(0, 100, 0)
				arg_286_1.actors_[var_289_8] = var_289_9

				local var_289_10 = var_289_9:GetComponentInChildren(typeof(CharacterEffect))

				var_289_10.enabled = true

				local var_289_11 = GameObjectTools.GetOrAddComponent(var_289_9, typeof(DynamicBoneHelper))

				if var_289_11 then
					var_289_11:EnableDynamicBone(false)
				end

				arg_286_1:ShowWeapon(var_289_10.transform, false)

				arg_286_1.var_[var_289_8 .. "Animator"] = var_289_10.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_286_1.var_[var_289_8 .. "Animator"].applyRootMotion = true
				arg_286_1.var_[var_289_8 .. "LipSync"] = var_289_10.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_289_12 = arg_286_1.actors_["1170ui_story"].transform

			if 1.8 < arg_286_1.time_ and arg_286_1.time_ <= 1.8 + arg_289_0 then
				arg_286_1.var_.moveOldPos1170ui_story = var_289_12.localPosition

				local var_289_13 = GameObjectTools.GetOrAddComponent(var_289_12.gameObject, typeof(DynamicBoneHelper))

				if var_289_13 then
					var_289_13:EnableDynamicBone(false)
				end
			end

			local var_289_14 = 0.001

			if 1.8 <= arg_286_1.time_ and arg_286_1.time_ < 1.8 + var_289_14 then
				var_289_12.localPosition = Vector3.Lerp(arg_286_1.var_.moveOldPos1170ui_story, Vector3.New(0.03, -0.95, -6.08), (arg_286_1.time_ - 1.8) / var_289_14)
				var_289_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_289_12.position).x, (manager.ui.mainCamera.transform.position - var_289_12.position).y, (manager.ui.mainCamera.transform.position - var_289_12.position).z)
				var_289_12.localEulerAngles.z = 0
				var_289_12.localEulerAngles.x = 0
				var_289_12.localEulerAngles = var_289_12.localEulerAngles
			end

			if arg_286_1.time_ >= 1.8 + var_289_14 and arg_286_1.time_ < 1.8 + var_289_14 + arg_289_0 then
				var_289_12.localPosition = Vector3.New(0.03, -0.95, -6.08)
				var_289_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_289_12.position).x, (manager.ui.mainCamera.transform.position - var_289_12.position).y, (manager.ui.mainCamera.transform.position - var_289_12.position).z)
				var_289_12.localEulerAngles.z = 0
				var_289_12.localEulerAngles.x = 0
				var_289_12.localEulerAngles = var_289_12.localEulerAngles

				local var_289_15 = GameObjectTools.GetOrAddComponent(var_289_12.gameObject, typeof(DynamicBoneHelper))

				if var_289_15 then
					var_289_15:EnableDynamicBone(true)
				end
			end

			local var_289_16 = arg_286_1.actors_["1170ui_story"]

			if 1.8 < arg_286_1.time_ and arg_286_1.time_ <= 1.8 + arg_289_0 and not isNil(var_289_16) and arg_286_1.var_.characterEffect1170ui_story == nil then
				arg_286_1.var_.characterEffect1170ui_story = var_289_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_289_17 = 0.200000002980232

			if 1.8 <= arg_286_1.time_ and arg_286_1.time_ < 1.8 + var_289_17 and not isNil(var_289_16) then
				if arg_286_1.var_.characterEffect1170ui_story and not isNil(var_289_16) then
					arg_286_1.var_.characterEffect1170ui_story.fillFlat = false
				end
			end

			if arg_286_1.time_ >= 1.8 + var_289_17 and arg_286_1.time_ < 1.8 + var_289_17 + arg_289_0 and not isNil(var_289_16) and arg_286_1.var_.characterEffect1170ui_story then
				arg_286_1.var_.characterEffect1170ui_story.fillFlat = false
			end

			if 1.8 < arg_286_1.time_ and arg_286_1.time_ <= 1.8 + arg_289_0 then
				arg_286_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/story1170/story1170action/1170action3_1")
			end

			if 1.8 < arg_286_1.time_ and arg_286_1.time_ <= 1.8 + arg_289_0 then
				arg_286_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			if 1.2 < arg_286_1.time_ and arg_286_1.time_ <= 1.2 + arg_289_0 then
				arg_286_1:AudioAction("play", "effect", "se_story_side_1049", "se_story_side_1049_amb_room", "")
			end

			if 0.1 < arg_286_1.time_ and arg_286_1.time_ <= 0.1 + arg_289_0 then
				arg_286_1:AudioAction("stop", "effect", "se_story_side_1049", "se_story_side_1049_amb_room", "")
			end

			if arg_286_1.frameCnt_ <= 1 then
				arg_286_1.dialog_:SetActive(false)
			end

			local var_289_21 = 2.00000000298023
			local var_289_22 = 0.45

			if 2.00000000298023 < arg_286_1.time_ and arg_286_1.time_ <= var_289_21 + arg_289_0 then
				arg_286_1.talkMaxDuration = 0

				arg_286_1.dialog_:SetActive(true)

				arg_286_1.dialogCg_.alpha = 0

				local var_289_23 = LeanTween.value(arg_286_1.dialog_, 0, 1, 0.3)

				var_289_23:setOnUpdate(LuaHelper.FloatAction(function(arg_290_0)
					arg_286_1.dialogCg_.alpha = arg_290_0
				end))
				var_289_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_286_1.dialog_)
					var_289_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_286_1.duration_ = arg_286_1.duration_ + 0.3

				SetActive(arg_286_1.leftNameGo_, true)

				arg_286_1.leftNameTxt_.text = arg_286_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_286_1.leftNameTxt_.transform)

				arg_286_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_286_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_286_1:RecordName(arg_286_1.leftNameTxt_.text)
				SetActive(arg_286_1.iconTrs_.gameObject, false)
				arg_286_1.callingController_:SetSelectedState("normal")

				local var_289_24 = arg_286_1:GetWordFromCfg(324131070)
				local var_289_25 = arg_286_1:FormatText(var_289_24.content)

				arg_286_1.text_.text = var_289_25

				LuaForUtil.ClearLinePrefixSymbol(arg_286_1.text_)

				local var_289_27 = 18 <= 0 and var_289_22 or var_289_22 * (utf8.len(var_289_25) / 18)

				if (18 <= 0 and var_289_22 or var_289_22 * (utf8.len(var_289_25) / 18)) > 0 and var_289_22 < var_289_27 then
					arg_286_1.talkMaxDuration = var_289_27
					var_289_21 = var_289_21 + 0.3

					if var_289_27 + var_289_21 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_27 + var_289_21
					end
				end

				arg_286_1.text_.text = var_289_25
				arg_286_1.typewritter.percent = 0

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324131", "324131070", "story_v_out_324131.awb") ~= 0 then
					local var_289_28 = manager.audio:GetVoiceLength("story_v_out_324131", "324131070", "story_v_out_324131.awb") / 1000

					if var_289_28 + var_289_21 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_28 + var_289_21
					end

					if var_289_24.prefab_name ~= "" and arg_286_1.actors_[var_289_24.prefab_name] ~= nil then
						local var_289_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_286_1.actors_[var_289_24.prefab_name].transform, "story_v_out_324131", "324131070", "story_v_out_324131.awb")

						arg_286_1:RecordAudio("324131070", var_289_29)
						arg_286_1:RecordAudio("324131070", var_289_29)
					else
						arg_286_1:AudioAction("play", "voice", "story_v_out_324131", "324131070", "story_v_out_324131.awb")
					end

					arg_286_1:RecordHistoryTalkVoice("story_v_out_324131", "324131070", "story_v_out_324131.awb")
				end

				arg_286_1:RecordContent(arg_286_1.text_.text)
			end

			local var_289_30 = var_289_21 + 0.3
			local var_289_31 = math.max(var_289_22, arg_286_1.talkMaxDuration)

			if var_289_21 + 0.3 <= arg_286_1.time_ and arg_286_1.time_ < var_289_30 + var_289_31 then
				arg_286_1.typewritter.percent = (arg_286_1.time_ - var_289_30) / var_289_31

				arg_286_1.typewritter:SetDirty()
			end

			if arg_286_1.time_ >= var_289_30 + var_289_31 and arg_286_1.time_ < var_289_30 + var_289_31 + arg_289_0 then
				arg_286_1.typewritter.percent = 1

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(true)
			end
		end

		arg_286_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_286_1:InitPlayNodeList()
	end,
	Play324131071 = function(arg_292_0, arg_292_1)
		arg_292_1.time_ = 0
		arg_292_1.frameCnt_ = 0
		arg_292_1.state_ = "playing"
		arg_292_1.curTalkId_ = 324131071
		arg_292_1.duration_ = 5

		SetActive(arg_292_1.tipsGo_, false)

		function arg_292_1.onSingleLineFinish_()
			arg_292_1.onSingleLineUpdate_ = nil
			arg_292_1.onSingleLineFinish_ = nil
			arg_292_1.state_ = "waiting"
		end

		function arg_292_1.playNext_(arg_294_0)
			if arg_294_0 == 1 then
				arg_292_0:Play324131072(arg_292_1)
			end
		end

		function arg_292_1.onSingleLineUpdate_(arg_295_0)
			if 0 < arg_292_1.time_ and arg_292_1.time_ <= 0 + arg_295_0 then
				arg_292_1.var_.moveOldPos1170ui_story = arg_292_1.actors_["1170ui_story"].transform.localPosition

				local var_295_0 = GameObjectTools.GetOrAddComponent(arg_292_1.actors_["1170ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_295_0 then
					var_295_0:EnableDynamicBone(false)
				end
			end

			local var_295_1 = 0.001

			if 0 <= arg_292_1.time_ and arg_292_1.time_ < 0 + var_295_1 then
				arg_292_1.actors_["1170ui_story"].transform.localPosition = Vector3.Lerp(arg_292_1.var_.moveOldPos1170ui_story, Vector3.New(0, 100, 0), (arg_292_1.time_ - 0) / var_295_1)
				arg_292_1.actors_["1170ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_292_1.actors_["1170ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_292_1.actors_["1170ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_292_1.actors_["1170ui_story"].transform.position).z)
				arg_292_1.actors_["1170ui_story"].transform.localEulerAngles.z = 0
				arg_292_1.actors_["1170ui_story"].transform.localEulerAngles.x = 0
				arg_292_1.actors_["1170ui_story"].transform.localEulerAngles = arg_292_1.actors_["1170ui_story"].transform.localEulerAngles
			end

			if arg_292_1.time_ >= 0 + var_295_1 and arg_292_1.time_ < 0 + var_295_1 + arg_295_0 then
				arg_292_1.actors_["1170ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_292_1.actors_["1170ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_292_1.actors_["1170ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_292_1.actors_["1170ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_292_1.actors_["1170ui_story"].transform.position).z)
				arg_292_1.actors_["1170ui_story"].transform.localEulerAngles.z = 0
				arg_292_1.actors_["1170ui_story"].transform.localEulerAngles.x = 0
				arg_292_1.actors_["1170ui_story"].transform.localEulerAngles = arg_292_1.actors_["1170ui_story"].transform.localEulerAngles

				local var_295_2 = GameObjectTools.GetOrAddComponent(arg_292_1.actors_["1170ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_295_2 then
					var_295_2:EnableDynamicBone(true)
				end
			end

			local var_295_3 = "1056ui_story"

			if arg_292_1.actors_["1056ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1056ui_story"))) then
				local var_295_4 = Object.Instantiate(Asset.Load("Char/" .. "1056ui_story"), arg_292_1.stage_.transform)

				var_295_4.name = var_295_3
				var_295_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_292_1.actors_[var_295_3] = var_295_4

				local var_295_5 = var_295_4:GetComponentInChildren(typeof(CharacterEffect))

				var_295_5.enabled = true

				local var_295_6 = GameObjectTools.GetOrAddComponent(var_295_4, typeof(DynamicBoneHelper))

				if var_295_6 then
					var_295_6:EnableDynamicBone(false)
				end

				arg_292_1:ShowWeapon(var_295_5.transform, false)

				arg_292_1.var_[var_295_3 .. "Animator"] = var_295_5.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_292_1.var_[var_295_3 .. "Animator"].applyRootMotion = true
				arg_292_1.var_[var_295_3 .. "LipSync"] = var_295_5.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_295_7 = arg_292_1.actors_["1056ui_story"]

			if 0 < arg_292_1.time_ and arg_292_1.time_ <= 0 + arg_295_0 and not isNil(var_295_7) and arg_292_1.var_.characterEffect1056ui_story == nil then
				arg_292_1.var_.characterEffect1056ui_story = var_295_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_295_8 = 0.200000002980232

			if 0 <= arg_292_1.time_ and arg_292_1.time_ < 0 + var_295_8 and not isNil(var_295_7) then
				if arg_292_1.var_.characterEffect1056ui_story and not isNil(var_295_7) then
					arg_292_1.var_.characterEffect1056ui_story.fillFlat = true
					arg_292_1.var_.characterEffect1056ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_292_1.time_ - 0) / var_295_8)
				end
			end

			if arg_292_1.time_ >= 0 + var_295_8 and arg_292_1.time_ < 0 + var_295_8 + arg_295_0 and not isNil(var_295_7) and arg_292_1.var_.characterEffect1056ui_story then
				arg_292_1.var_.characterEffect1056ui_story.fillFlat = true
				arg_292_1.var_.characterEffect1056ui_story.fillRatio = 0.5
			end

			local var_295_9 = arg_292_1.actors_["1170ui_story"]

			if 0 < arg_292_1.time_ and arg_292_1.time_ <= 0 + arg_295_0 and not isNil(var_295_9) and arg_292_1.var_.characterEffect1170ui_story == nil then
				arg_292_1.var_.characterEffect1170ui_story = var_295_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_295_10 = 0.200000002980232

			if 0 <= arg_292_1.time_ and arg_292_1.time_ < 0 + var_295_10 and not isNil(var_295_9) then
				if arg_292_1.var_.characterEffect1170ui_story and not isNil(var_295_9) then
					arg_292_1.var_.characterEffect1170ui_story.fillFlat = false
				end
			end

			if arg_292_1.time_ >= 0 + var_295_10 and arg_292_1.time_ < 0 + var_295_10 + arg_295_0 and not isNil(var_295_9) and arg_292_1.var_.characterEffect1170ui_story then
				arg_292_1.var_.characterEffect1170ui_story.fillFlat = false
			end

			local var_295_12 = 0
			local var_295_13 = 1.2

			if 0 < arg_292_1.time_ and arg_292_1.time_ <= var_295_12 + arg_295_0 then
				arg_292_1.talkMaxDuration = 0
				arg_292_1.dialogCg_.alpha = 1

				arg_292_1.dialog_:SetActive(true)
				SetActive(arg_292_1.leftNameGo_, false)

				arg_292_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_292_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_292_1:RecordName(arg_292_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_292_1.iconTrs_.gameObject, false)
				arg_292_1.callingController_:SetSelectedState("normal")

				local var_295_14 = arg_292_1:FormatText(arg_292_1:GetWordFromCfg(324131071).content)

				arg_292_1.text_.text = var_295_14

				LuaForUtil.ClearLinePrefixSymbol(arg_292_1.text_)

				local var_295_16 = 48 <= 0 and var_295_13 or var_295_13 * (utf8.len(var_295_14) / 48)

				if (48 <= 0 and var_295_13 or var_295_13 * (utf8.len(var_295_14) / 48)) > 0 and var_295_13 < var_295_16 then
					arg_292_1.talkMaxDuration = var_295_16

					if var_295_16 + var_295_12 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_16 + var_295_12
					end
				end

				arg_292_1.text_.text = var_295_14
				arg_292_1.typewritter.percent = 0

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(false)
				arg_292_1:RecordContent(arg_292_1.text_.text)
			end

			local var_295_17 = math.max(var_295_13, arg_292_1.talkMaxDuration)

			if var_295_12 <= arg_292_1.time_ and arg_292_1.time_ < var_295_12 + var_295_17 then
				arg_292_1.typewritter.percent = (arg_292_1.time_ - var_295_12) / var_295_17

				arg_292_1.typewritter:SetDirty()
			end

			if arg_292_1.time_ >= var_295_12 + var_295_17 and arg_292_1.time_ < var_295_12 + var_295_17 + arg_295_0 then
				arg_292_1.typewritter.percent = 1

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(true)
			end
		end

		arg_292_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_292_1:InitPlayNodeList()
	end,
	Play324131072 = function(arg_296_0, arg_296_1)
		arg_296_1.time_ = 0
		arg_296_1.frameCnt_ = 0
		arg_296_1.state_ = "playing"
		arg_296_1.curTalkId_ = 324131072
		arg_296_1.duration_ = 6.3

		local var_296_0 = {
			zh = 4.733,
			ja = 6.3
		}
		local var_296_1 = manager.audio:GetLocalizationFlag()

		if var_296_0[var_296_1] ~= nil then
			arg_296_1.duration_ = var_296_0[var_296_1]
		end

		SetActive(arg_296_1.tipsGo_, false)

		function arg_296_1.onSingleLineFinish_()
			arg_296_1.onSingleLineUpdate_ = nil
			arg_296_1.onSingleLineFinish_ = nil
			arg_296_1.state_ = "waiting"
		end

		function arg_296_1.playNext_(arg_298_0)
			if arg_298_0 == 1 then
				arg_296_0:Play324131073(arg_296_1)
			end
		end

		function arg_296_1.onSingleLineUpdate_(arg_299_0)
			if 0 < arg_296_1.time_ and arg_296_1.time_ <= 0 + arg_299_0 then
				arg_296_1.var_.moveOldPos1053ui_story = arg_296_1.actors_["1053ui_story"].transform.localPosition

				local var_299_0 = GameObjectTools.GetOrAddComponent(arg_296_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_299_0 then
					var_299_0:EnableDynamicBone(false)
				end
			end

			local var_299_1 = 0.001

			if 0 <= arg_296_1.time_ and arg_296_1.time_ < 0 + var_299_1 then
				arg_296_1.actors_["1053ui_story"].transform.localPosition = Vector3.Lerp(arg_296_1.var_.moveOldPos1053ui_story, Vector3.New(0, -1.08, -6), (arg_296_1.time_ - 0) / var_299_1)
				arg_296_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_296_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_296_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_296_1.actors_["1053ui_story"].transform.position).z)
				arg_296_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_296_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_296_1.actors_["1053ui_story"].transform.localEulerAngles = arg_296_1.actors_["1053ui_story"].transform.localEulerAngles
			end

			if arg_296_1.time_ >= 0 + var_299_1 and arg_296_1.time_ < 0 + var_299_1 + arg_299_0 then
				arg_296_1.actors_["1053ui_story"].transform.localPosition = Vector3.New(0, -1.08, -6)
				arg_296_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_296_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_296_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_296_1.actors_["1053ui_story"].transform.position).z)
				arg_296_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_296_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_296_1.actors_["1053ui_story"].transform.localEulerAngles = arg_296_1.actors_["1053ui_story"].transform.localEulerAngles

				local var_299_2 = GameObjectTools.GetOrAddComponent(arg_296_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_299_2 then
					var_299_2:EnableDynamicBone(true)
				end
			end

			local var_299_3 = arg_296_1.actors_["1053ui_story"]

			if 0 < arg_296_1.time_ and arg_296_1.time_ <= 0 + arg_299_0 and not isNil(var_299_3) and arg_296_1.var_.characterEffect1053ui_story == nil then
				arg_296_1.var_.characterEffect1053ui_story = var_299_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_299_4 = 0.200000002980232

			if 0 <= arg_296_1.time_ and arg_296_1.time_ < 0 + var_299_4 and not isNil(var_299_3) then
				if arg_296_1.var_.characterEffect1053ui_story and not isNil(var_299_3) then
					arg_296_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_296_1.time_ >= 0 + var_299_4 and arg_296_1.time_ < 0 + var_299_4 + arg_299_0 and not isNil(var_299_3) and arg_296_1.var_.characterEffect1053ui_story then
				arg_296_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			if 0 < arg_296_1.time_ and arg_296_1.time_ <= 0 + arg_299_0 then
				arg_296_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053action/1053action3_2")
			end

			if 0 < arg_296_1.time_ and arg_296_1.time_ <= 0 + arg_299_0 then
				arg_296_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_299_6 = 0
			local var_299_7 = 0.525

			if 0 < arg_296_1.time_ and arg_296_1.time_ <= var_299_6 + arg_299_0 then
				arg_296_1.talkMaxDuration = 0
				arg_296_1.dialogCg_.alpha = 1

				arg_296_1.dialog_:SetActive(true)
				SetActive(arg_296_1.leftNameGo_, true)

				arg_296_1.leftNameTxt_.text = arg_296_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_296_1.leftNameTxt_.transform)

				arg_296_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_296_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_296_1:RecordName(arg_296_1.leftNameTxt_.text)
				SetActive(arg_296_1.iconTrs_.gameObject, false)
				arg_296_1.callingController_:SetSelectedState("normal")

				local var_299_8 = arg_296_1:GetWordFromCfg(324131072)
				local var_299_9 = arg_296_1:FormatText(var_299_8.content)

				arg_296_1.text_.text = var_299_9

				LuaForUtil.ClearLinePrefixSymbol(arg_296_1.text_)

				local var_299_11 = 21 <= 0 and var_299_7 or var_299_7 * (utf8.len(var_299_9) / 21)

				if (21 <= 0 and var_299_7 or var_299_7 * (utf8.len(var_299_9) / 21)) > 0 and var_299_7 < var_299_11 then
					arg_296_1.talkMaxDuration = var_299_11

					if var_299_11 + var_299_6 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_11 + var_299_6
					end
				end

				arg_296_1.text_.text = var_299_9
				arg_296_1.typewritter.percent = 0

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324131", "324131072", "story_v_out_324131.awb") ~= 0 then
					local var_299_12 = manager.audio:GetVoiceLength("story_v_out_324131", "324131072", "story_v_out_324131.awb") / 1000

					if var_299_12 + var_299_6 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_12 + var_299_6
					end

					if var_299_8.prefab_name ~= "" and arg_296_1.actors_[var_299_8.prefab_name] ~= nil then
						local var_299_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_296_1.actors_[var_299_8.prefab_name].transform, "story_v_out_324131", "324131072", "story_v_out_324131.awb")

						arg_296_1:RecordAudio("324131072", var_299_13)
						arg_296_1:RecordAudio("324131072", var_299_13)
					else
						arg_296_1:AudioAction("play", "voice", "story_v_out_324131", "324131072", "story_v_out_324131.awb")
					end

					arg_296_1:RecordHistoryTalkVoice("story_v_out_324131", "324131072", "story_v_out_324131.awb")
				end

				arg_296_1:RecordContent(arg_296_1.text_.text)
			end

			local var_299_14 = math.max(var_299_7, arg_296_1.talkMaxDuration)

			if var_299_6 <= arg_296_1.time_ and arg_296_1.time_ < var_299_6 + var_299_14 then
				arg_296_1.typewritter.percent = (arg_296_1.time_ - var_299_6) / var_299_14

				arg_296_1.typewritter:SetDirty()
			end

			if arg_296_1.time_ >= var_299_6 + var_299_14 and arg_296_1.time_ < var_299_6 + var_299_14 + arg_299_0 then
				arg_296_1.typewritter.percent = 1

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(true)
			end
		end

		arg_296_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_296_1:InitPlayNodeList()
	end,
	Play324131073 = function(arg_300_0, arg_300_1)
		arg_300_1.time_ = 0
		arg_300_1.frameCnt_ = 0
		arg_300_1.state_ = "playing"
		arg_300_1.curTalkId_ = 324131073
		arg_300_1.duration_ = 6.87

		local var_300_0 = {
			zh = 3.4,
			ja = 6.866
		}
		local var_300_1 = manager.audio:GetLocalizationFlag()

		if var_300_0[var_300_1] ~= nil then
			arg_300_1.duration_ = var_300_0[var_300_1]
		end

		SetActive(arg_300_1.tipsGo_, false)

		function arg_300_1.onSingleLineFinish_()
			arg_300_1.onSingleLineUpdate_ = nil
			arg_300_1.onSingleLineFinish_ = nil
			arg_300_1.state_ = "waiting"
		end

		function arg_300_1.playNext_(arg_302_0)
			if arg_302_0 == 1 then
				arg_300_0:Play324131074(arg_300_1)
			end
		end

		function arg_300_1.onSingleLineUpdate_(arg_303_0)
			local var_303_0 = 0.4

			if 0 < arg_300_1.time_ and arg_300_1.time_ <= 0 + arg_303_0 then
				arg_300_1.talkMaxDuration = 0
				arg_300_1.dialogCg_.alpha = 1

				arg_300_1.dialog_:SetActive(true)
				SetActive(arg_300_1.leftNameGo_, true)

				arg_300_1.leftNameTxt_.text = arg_300_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_300_1.leftNameTxt_.transform)

				arg_300_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_300_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_300_1:RecordName(arg_300_1.leftNameTxt_.text)
				SetActive(arg_300_1.iconTrs_.gameObject, false)
				arg_300_1.callingController_:SetSelectedState("normal")

				local var_303_1 = arg_300_1:GetWordFromCfg(324131073)
				local var_303_2 = arg_300_1:FormatText(var_303_1.content)

				arg_300_1.text_.text = var_303_2

				LuaForUtil.ClearLinePrefixSymbol(arg_300_1.text_)

				local var_303_4 = 16 <= 0 and var_303_0 or var_303_0 * (utf8.len(var_303_2) / 16)

				if (16 <= 0 and var_303_0 or var_303_0 * (utf8.len(var_303_2) / 16)) > 0 and var_303_0 < var_303_4 then
					arg_300_1.talkMaxDuration = var_303_4

					if var_303_4 + 0 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_4 + 0
					end
				end

				arg_300_1.text_.text = var_303_2
				arg_300_1.typewritter.percent = 0

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324131", "324131073", "story_v_out_324131.awb") ~= 0 then
					local var_303_5 = manager.audio:GetVoiceLength("story_v_out_324131", "324131073", "story_v_out_324131.awb") / 1000

					if var_303_5 + 0 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_5 + 0
					end

					if var_303_1.prefab_name ~= "" and arg_300_1.actors_[var_303_1.prefab_name] ~= nil then
						local var_303_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_300_1.actors_[var_303_1.prefab_name].transform, "story_v_out_324131", "324131073", "story_v_out_324131.awb")

						arg_300_1:RecordAudio("324131073", var_303_6)
						arg_300_1:RecordAudio("324131073", var_303_6)
					else
						arg_300_1:AudioAction("play", "voice", "story_v_out_324131", "324131073", "story_v_out_324131.awb")
					end

					arg_300_1:RecordHistoryTalkVoice("story_v_out_324131", "324131073", "story_v_out_324131.awb")
				end

				arg_300_1:RecordContent(arg_300_1.text_.text)
			end

			local var_303_7 = math.max(var_303_0, arg_300_1.talkMaxDuration)

			if 0 <= arg_300_1.time_ and arg_300_1.time_ < 0 + var_303_7 then
				arg_300_1.typewritter.percent = (arg_300_1.time_ - 0) / var_303_7

				arg_300_1.typewritter:SetDirty()
			end

			if arg_300_1.time_ >= 0 + var_303_7 and arg_300_1.time_ < 0 + var_303_7 + arg_303_0 then
				arg_300_1.typewritter.percent = 1

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(true)
			end
		end

		arg_300_1.nodeConfigList_ = {}

		arg_300_1:InitPlayNodeList()
	end,
	Play324131074 = function(arg_304_0, arg_304_1)
		arg_304_1.time_ = 0
		arg_304_1.frameCnt_ = 0
		arg_304_1.state_ = "playing"
		arg_304_1.curTalkId_ = 324131074
		arg_304_1.duration_ = 2.3

		local var_304_0 = {
			zh = 2.3,
			ja = 2.233
		}
		local var_304_1 = manager.audio:GetLocalizationFlag()

		if var_304_0[var_304_1] ~= nil then
			arg_304_1.duration_ = var_304_0[var_304_1]
		end

		SetActive(arg_304_1.tipsGo_, false)

		function arg_304_1.onSingleLineFinish_()
			arg_304_1.onSingleLineUpdate_ = nil
			arg_304_1.onSingleLineFinish_ = nil
			arg_304_1.state_ = "waiting"
		end

		function arg_304_1.playNext_(arg_306_0)
			if arg_306_0 == 1 then
				arg_304_0:Play324131075(arg_304_1)
			end
		end

		function arg_304_1.onSingleLineUpdate_(arg_307_0)
			if 0 < arg_304_1.time_ and arg_304_1.time_ <= 0 + arg_307_0 then
				arg_304_1.var_.moveOldPos1170ui_story = arg_304_1.actors_["1170ui_story"].transform.localPosition

				local var_307_0 = GameObjectTools.GetOrAddComponent(arg_304_1.actors_["1170ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_307_0 then
					var_307_0:EnableDynamicBone(false)
				end
			end

			local var_307_1 = 0.001

			if 0 <= arg_304_1.time_ and arg_304_1.time_ < 0 + var_307_1 then
				arg_304_1.actors_["1170ui_story"].transform.localPosition = Vector3.Lerp(arg_304_1.var_.moveOldPos1170ui_story, Vector3.New(0.74, -0.95, -6.08), (arg_304_1.time_ - 0) / var_307_1)
				arg_304_1.actors_["1170ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_304_1.actors_["1170ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_304_1.actors_["1170ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_304_1.actors_["1170ui_story"].transform.position).z)
				arg_304_1.actors_["1170ui_story"].transform.localEulerAngles.z = 0
				arg_304_1.actors_["1170ui_story"].transform.localEulerAngles.x = 0
				arg_304_1.actors_["1170ui_story"].transform.localEulerAngles = arg_304_1.actors_["1170ui_story"].transform.localEulerAngles
			end

			if arg_304_1.time_ >= 0 + var_307_1 and arg_304_1.time_ < 0 + var_307_1 + arg_307_0 then
				arg_304_1.actors_["1170ui_story"].transform.localPosition = Vector3.New(0.74, -0.95, -6.08)
				arg_304_1.actors_["1170ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_304_1.actors_["1170ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_304_1.actors_["1170ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_304_1.actors_["1170ui_story"].transform.position).z)
				arg_304_1.actors_["1170ui_story"].transform.localEulerAngles.z = 0
				arg_304_1.actors_["1170ui_story"].transform.localEulerAngles.x = 0
				arg_304_1.actors_["1170ui_story"].transform.localEulerAngles = arg_304_1.actors_["1170ui_story"].transform.localEulerAngles

				local var_307_2 = GameObjectTools.GetOrAddComponent(arg_304_1.actors_["1170ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_307_2 then
					var_307_2:EnableDynamicBone(true)
				end
			end

			local var_307_3 = arg_304_1.actors_["1053ui_story"].transform

			if 0 < arg_304_1.time_ and arg_304_1.time_ <= 0 + arg_307_0 then
				arg_304_1.var_.moveOldPos1053ui_story = var_307_3.localPosition

				local var_307_4 = GameObjectTools.GetOrAddComponent(var_307_3.gameObject, typeof(DynamicBoneHelper))

				if var_307_4 then
					var_307_4:EnableDynamicBone(false)
				end
			end

			local var_307_5 = 0.001

			if 0 <= arg_304_1.time_ and arg_304_1.time_ < 0 + var_307_5 then
				var_307_3.localPosition = Vector3.Lerp(arg_304_1.var_.moveOldPos1053ui_story, Vector3.New(-0.7, -1.08, -6), (arg_304_1.time_ - 0) / var_307_5)
				var_307_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_307_3.position).x, (manager.ui.mainCamera.transform.position - var_307_3.position).y, (manager.ui.mainCamera.transform.position - var_307_3.position).z)
				var_307_3.localEulerAngles.z = 0
				var_307_3.localEulerAngles.x = 0
				var_307_3.localEulerAngles = var_307_3.localEulerAngles
			end

			if arg_304_1.time_ >= 0 + var_307_5 and arg_304_1.time_ < 0 + var_307_5 + arg_307_0 then
				var_307_3.localPosition = Vector3.New(-0.7, -1.08, -6)
				var_307_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_307_3.position).x, (manager.ui.mainCamera.transform.position - var_307_3.position).y, (manager.ui.mainCamera.transform.position - var_307_3.position).z)
				var_307_3.localEulerAngles.z = 0
				var_307_3.localEulerAngles.x = 0
				var_307_3.localEulerAngles = var_307_3.localEulerAngles

				local var_307_6 = GameObjectTools.GetOrAddComponent(var_307_3.gameObject, typeof(DynamicBoneHelper))

				if var_307_6 then
					var_307_6:EnableDynamicBone(true)
				end
			end

			local var_307_7 = arg_304_1.actors_["1056ui_story"]

			if 0 < arg_304_1.time_ and arg_304_1.time_ <= 0 + arg_307_0 and not isNil(var_307_7) and arg_304_1.var_.characterEffect1056ui_story == nil then
				arg_304_1.var_.characterEffect1056ui_story = var_307_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_307_8 = 0.200000002980232

			if 0 <= arg_304_1.time_ and arg_304_1.time_ < 0 + var_307_8 and not isNil(var_307_7) then
				if arg_304_1.var_.characterEffect1056ui_story and not isNil(var_307_7) then
					arg_304_1.var_.characterEffect1056ui_story.fillFlat = false
				end
			end

			if arg_304_1.time_ >= 0 + var_307_8 and arg_304_1.time_ < 0 + var_307_8 + arg_307_0 and not isNil(var_307_7) and arg_304_1.var_.characterEffect1056ui_story then
				arg_304_1.var_.characterEffect1056ui_story.fillFlat = false
			end

			local var_307_10 = arg_304_1.actors_["1053ui_story"]

			if 0 < arg_304_1.time_ and arg_304_1.time_ <= 0 + arg_307_0 and not isNil(var_307_10) and arg_304_1.var_.characterEffect1053ui_story == nil then
				arg_304_1.var_.characterEffect1053ui_story = var_307_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_307_11 = 0.200000002980232

			if 0 <= arg_304_1.time_ and arg_304_1.time_ < 0 + var_307_11 and not isNil(var_307_10) then
				if arg_304_1.var_.characterEffect1053ui_story and not isNil(var_307_10) then
					arg_304_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_304_1.var_.characterEffect1053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_304_1.time_ - 0) / var_307_11)
				end
			end

			if arg_304_1.time_ >= 0 + var_307_11 and arg_304_1.time_ < 0 + var_307_11 + arg_307_0 and not isNil(var_307_10) and arg_304_1.var_.characterEffect1053ui_story then
				arg_304_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_304_1.var_.characterEffect1053ui_story.fillRatio = 0.5
			end

			if 0 < arg_304_1.time_ and arg_304_1.time_ <= 0 + arg_307_0 then
				arg_304_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/story1170/story1170actionlink/1170action437")
			end

			local var_307_12 = 0
			local var_307_13 = 0.1

			if 0 < arg_304_1.time_ and arg_304_1.time_ <= var_307_12 + arg_307_0 then
				arg_304_1.talkMaxDuration = 0
				arg_304_1.dialogCg_.alpha = 1

				arg_304_1.dialog_:SetActive(true)
				SetActive(arg_304_1.leftNameGo_, true)

				arg_304_1.leftNameTxt_.text = arg_304_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_304_1.leftNameTxt_.transform)

				arg_304_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_304_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_304_1:RecordName(arg_304_1.leftNameTxt_.text)
				SetActive(arg_304_1.iconTrs_.gameObject, false)
				arg_304_1.callingController_:SetSelectedState("normal")

				local var_307_14 = arg_304_1:GetWordFromCfg(324131074)
				local var_307_15 = arg_304_1:FormatText(var_307_14.content)

				arg_304_1.text_.text = var_307_15

				LuaForUtil.ClearLinePrefixSymbol(arg_304_1.text_)

				local var_307_17 = 4 <= 0 and var_307_13 or var_307_13 * (utf8.len(var_307_15) / 4)

				if (4 <= 0 and var_307_13 or var_307_13 * (utf8.len(var_307_15) / 4)) > 0 and var_307_13 < var_307_17 then
					arg_304_1.talkMaxDuration = var_307_17

					if var_307_17 + var_307_12 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_17 + var_307_12
					end
				end

				arg_304_1.text_.text = var_307_15
				arg_304_1.typewritter.percent = 0

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324131", "324131074", "story_v_out_324131.awb") ~= 0 then
					local var_307_18 = manager.audio:GetVoiceLength("story_v_out_324131", "324131074", "story_v_out_324131.awb") / 1000

					if var_307_18 + var_307_12 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_18 + var_307_12
					end

					if var_307_14.prefab_name ~= "" and arg_304_1.actors_[var_307_14.prefab_name] ~= nil then
						local var_307_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_304_1.actors_[var_307_14.prefab_name].transform, "story_v_out_324131", "324131074", "story_v_out_324131.awb")

						arg_304_1:RecordAudio("324131074", var_307_19)
						arg_304_1:RecordAudio("324131074", var_307_19)
					else
						arg_304_1:AudioAction("play", "voice", "story_v_out_324131", "324131074", "story_v_out_324131.awb")
					end

					arg_304_1:RecordHistoryTalkVoice("story_v_out_324131", "324131074", "story_v_out_324131.awb")
				end

				arg_304_1:RecordContent(arg_304_1.text_.text)
			end

			local var_307_20 = math.max(var_307_13, arg_304_1.talkMaxDuration)

			if var_307_12 <= arg_304_1.time_ and arg_304_1.time_ < var_307_12 + var_307_20 then
				arg_304_1.typewritter.percent = (arg_304_1.time_ - var_307_12) / var_307_20

				arg_304_1.typewritter:SetDirty()
			end

			if arg_304_1.time_ >= var_307_12 + var_307_20 and arg_304_1.time_ < var_307_12 + var_307_20 + arg_307_0 then
				arg_304_1.typewritter.percent = 1

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(true)
			end
		end

		arg_304_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_304_1:InitPlayNodeList()
	end,
	Play324131075 = function(arg_308_0, arg_308_1)
		arg_308_1.time_ = 0
		arg_308_1.frameCnt_ = 0
		arg_308_1.state_ = "playing"
		arg_308_1.curTalkId_ = 324131075
		arg_308_1.duration_ = 5

		SetActive(arg_308_1.tipsGo_, false)

		function arg_308_1.onSingleLineFinish_()
			arg_308_1.onSingleLineUpdate_ = nil
			arg_308_1.onSingleLineFinish_ = nil
			arg_308_1.state_ = "waiting"
		end

		function arg_308_1.playNext_(arg_310_0)
			if arg_310_0 == 1 then
				arg_308_0:Play324131076(arg_308_1)
			end
		end

		function arg_308_1.onSingleLineUpdate_(arg_311_0)
			if 0 < arg_308_1.time_ and arg_308_1.time_ <= 0 + arg_311_0 and not isNil(arg_308_1.actors_["1170ui_story"]) and arg_308_1.var_.characterEffect1170ui_story == nil then
				arg_308_1.var_.characterEffect1170ui_story = arg_308_1.actors_["1170ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_311_0 = 0.200000002980232

			if 0 <= arg_308_1.time_ and arg_308_1.time_ < 0 + var_311_0 and not isNil(arg_308_1.actors_["1170ui_story"]) then
				if arg_308_1.var_.characterEffect1170ui_story and not isNil(arg_308_1.actors_["1170ui_story"]) then
					arg_308_1.var_.characterEffect1170ui_story.fillFlat = true
					arg_308_1.var_.characterEffect1170ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_308_1.time_ - 0) / var_311_0)
				end
			end

			if arg_308_1.time_ >= 0 + var_311_0 and arg_308_1.time_ < 0 + var_311_0 + arg_311_0 and not isNil(arg_308_1.actors_["1170ui_story"]) and arg_308_1.var_.characterEffect1170ui_story then
				arg_308_1.var_.characterEffect1170ui_story.fillFlat = true
				arg_308_1.var_.characterEffect1170ui_story.fillRatio = 0.5
			end

			local var_311_1 = 0
			local var_311_2 = 0.7

			if 0 < arg_308_1.time_ and arg_308_1.time_ <= var_311_1 + arg_311_0 then
				arg_308_1.talkMaxDuration = 0
				arg_308_1.dialogCg_.alpha = 1

				arg_308_1.dialog_:SetActive(true)
				SetActive(arg_308_1.leftNameGo_, false)

				arg_308_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_308_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_308_1:RecordName(arg_308_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_308_1.iconTrs_.gameObject, false)
				arg_308_1.callingController_:SetSelectedState("normal")

				local var_311_3 = arg_308_1:FormatText(arg_308_1:GetWordFromCfg(324131075).content)

				arg_308_1.text_.text = var_311_3

				LuaForUtil.ClearLinePrefixSymbol(arg_308_1.text_)

				local var_311_5 = 28 <= 0 and var_311_2 or var_311_2 * (utf8.len(var_311_3) / 28)

				if (28 <= 0 and var_311_2 or var_311_2 * (utf8.len(var_311_3) / 28)) > 0 and var_311_2 < var_311_5 then
					arg_308_1.talkMaxDuration = var_311_5

					if var_311_5 + var_311_1 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_5 + var_311_1
					end
				end

				arg_308_1.text_.text = var_311_3
				arg_308_1.typewritter.percent = 0

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(false)
				arg_308_1:RecordContent(arg_308_1.text_.text)
			end

			local var_311_6 = math.max(var_311_2, arg_308_1.talkMaxDuration)

			if var_311_1 <= arg_308_1.time_ and arg_308_1.time_ < var_311_1 + var_311_6 then
				arg_308_1.typewritter.percent = (arg_308_1.time_ - var_311_1) / var_311_6

				arg_308_1.typewritter:SetDirty()
			end

			if arg_308_1.time_ >= var_311_1 + var_311_6 and arg_308_1.time_ < var_311_1 + var_311_6 + arg_311_0 then
				arg_308_1.typewritter.percent = 1

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(true)
			end
		end

		arg_308_1.nodeConfigList_ = {}

		arg_308_1:InitPlayNodeList()
	end,
	Play324131076 = function(arg_312_0, arg_312_1)
		arg_312_1.time_ = 0
		arg_312_1.frameCnt_ = 0
		arg_312_1.state_ = "playing"
		arg_312_1.curTalkId_ = 324131076
		arg_312_1.duration_ = 3.5

		local var_312_0 = {
			zh = 2.766,
			ja = 3.5
		}
		local var_312_1 = manager.audio:GetLocalizationFlag()

		if var_312_0[var_312_1] ~= nil then
			arg_312_1.duration_ = var_312_0[var_312_1]
		end

		SetActive(arg_312_1.tipsGo_, false)

		function arg_312_1.onSingleLineFinish_()
			arg_312_1.onSingleLineUpdate_ = nil
			arg_312_1.onSingleLineFinish_ = nil
			arg_312_1.state_ = "waiting"
		end

		function arg_312_1.playNext_(arg_314_0)
			if arg_314_0 == 1 then
				arg_312_0:Play324131077(arg_312_1)
			end
		end

		function arg_312_1.onSingleLineUpdate_(arg_315_0)
			if 0 < arg_312_1.time_ and arg_312_1.time_ <= 0 + arg_315_0 then
				arg_312_1.var_.moveOldPos1053ui_story = arg_312_1.actors_["1053ui_story"].transform.localPosition

				local var_315_0 = GameObjectTools.GetOrAddComponent(arg_312_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_315_0 then
					var_315_0:EnableDynamicBone(false)
				end
			end

			local var_315_1 = 0.001

			if 0 <= arg_312_1.time_ and arg_312_1.time_ < 0 + var_315_1 then
				arg_312_1.actors_["1053ui_story"].transform.localPosition = Vector3.Lerp(arg_312_1.var_.moveOldPos1053ui_story, Vector3.New(-0.7, -1.08, -6), (arg_312_1.time_ - 0) / var_315_1)
				arg_312_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_312_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_312_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_312_1.actors_["1053ui_story"].transform.position).z)
				arg_312_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_312_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_312_1.actors_["1053ui_story"].transform.localEulerAngles = arg_312_1.actors_["1053ui_story"].transform.localEulerAngles
			end

			if arg_312_1.time_ >= 0 + var_315_1 and arg_312_1.time_ < 0 + var_315_1 + arg_315_0 then
				arg_312_1.actors_["1053ui_story"].transform.localPosition = Vector3.New(-0.7, -1.08, -6)
				arg_312_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_312_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_312_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_312_1.actors_["1053ui_story"].transform.position).z)
				arg_312_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_312_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_312_1.actors_["1053ui_story"].transform.localEulerAngles = arg_312_1.actors_["1053ui_story"].transform.localEulerAngles

				local var_315_2 = GameObjectTools.GetOrAddComponent(arg_312_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_315_2 then
					var_315_2:EnableDynamicBone(true)
				end
			end

			local var_315_3 = arg_312_1.actors_["1053ui_story"]

			if 0 < arg_312_1.time_ and arg_312_1.time_ <= 0 + arg_315_0 and not isNil(var_315_3) and arg_312_1.var_.characterEffect1053ui_story == nil then
				arg_312_1.var_.characterEffect1053ui_story = var_315_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_315_4 = 0.200000002980232

			if 0 <= arg_312_1.time_ and arg_312_1.time_ < 0 + var_315_4 and not isNil(var_315_3) then
				if arg_312_1.var_.characterEffect1053ui_story and not isNil(var_315_3) then
					arg_312_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_312_1.time_ >= 0 + var_315_4 and arg_312_1.time_ < 0 + var_315_4 + arg_315_0 and not isNil(var_315_3) and arg_312_1.var_.characterEffect1053ui_story then
				arg_312_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_315_6 = 0
			local var_315_7 = 0.2

			if 0 < arg_312_1.time_ and arg_312_1.time_ <= var_315_6 + arg_315_0 then
				arg_312_1.talkMaxDuration = 0
				arg_312_1.dialogCg_.alpha = 1

				arg_312_1.dialog_:SetActive(true)
				SetActive(arg_312_1.leftNameGo_, true)

				arg_312_1.leftNameTxt_.text = arg_312_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_312_1.leftNameTxt_.transform)

				arg_312_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_312_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_312_1:RecordName(arg_312_1.leftNameTxt_.text)
				SetActive(arg_312_1.iconTrs_.gameObject, false)
				arg_312_1.callingController_:SetSelectedState("normal")

				local var_315_8 = arg_312_1:GetWordFromCfg(324131076)
				local var_315_9 = arg_312_1:FormatText(var_315_8.content)

				arg_312_1.text_.text = var_315_9

				LuaForUtil.ClearLinePrefixSymbol(arg_312_1.text_)

				local var_315_11 = 8 <= 0 and var_315_7 or var_315_7 * (utf8.len(var_315_9) / 8)

				if (8 <= 0 and var_315_7 or var_315_7 * (utf8.len(var_315_9) / 8)) > 0 and var_315_7 < var_315_11 then
					arg_312_1.talkMaxDuration = var_315_11

					if var_315_11 + var_315_6 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_11 + var_315_6
					end
				end

				arg_312_1.text_.text = var_315_9
				arg_312_1.typewritter.percent = 0

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324131", "324131076", "story_v_out_324131.awb") ~= 0 then
					local var_315_12 = manager.audio:GetVoiceLength("story_v_out_324131", "324131076", "story_v_out_324131.awb") / 1000

					if var_315_12 + var_315_6 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_12 + var_315_6
					end

					if var_315_8.prefab_name ~= "" and arg_312_1.actors_[var_315_8.prefab_name] ~= nil then
						local var_315_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_312_1.actors_[var_315_8.prefab_name].transform, "story_v_out_324131", "324131076", "story_v_out_324131.awb")

						arg_312_1:RecordAudio("324131076", var_315_13)
						arg_312_1:RecordAudio("324131076", var_315_13)
					else
						arg_312_1:AudioAction("play", "voice", "story_v_out_324131", "324131076", "story_v_out_324131.awb")
					end

					arg_312_1:RecordHistoryTalkVoice("story_v_out_324131", "324131076", "story_v_out_324131.awb")
				end

				arg_312_1:RecordContent(arg_312_1.text_.text)
			end

			local var_315_14 = math.max(var_315_7, arg_312_1.talkMaxDuration)

			if var_315_6 <= arg_312_1.time_ and arg_312_1.time_ < var_315_6 + var_315_14 then
				arg_312_1.typewritter.percent = (arg_312_1.time_ - var_315_6) / var_315_14

				arg_312_1.typewritter:SetDirty()
			end

			if arg_312_1.time_ >= var_315_6 + var_315_14 and arg_312_1.time_ < var_315_6 + var_315_14 + arg_315_0 then
				arg_312_1.typewritter.percent = 1

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(true)
			end
		end

		arg_312_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_312_1:InitPlayNodeList()
	end,
	Play324131077 = function(arg_316_0, arg_316_1)
		arg_316_1.time_ = 0
		arg_316_1.frameCnt_ = 0
		arg_316_1.state_ = "playing"
		arg_316_1.curTalkId_ = 324131077
		arg_316_1.duration_ = 5.53

		local var_316_0 = {
			zh = 3.4,
			ja = 5.533
		}
		local var_316_1 = manager.audio:GetLocalizationFlag()

		if var_316_0[var_316_1] ~= nil then
			arg_316_1.duration_ = var_316_0[var_316_1]
		end

		SetActive(arg_316_1.tipsGo_, false)

		function arg_316_1.onSingleLineFinish_()
			arg_316_1.onSingleLineUpdate_ = nil
			arg_316_1.onSingleLineFinish_ = nil
			arg_316_1.state_ = "waiting"
			arg_316_1.auto_ = false
		end

		function arg_316_1.playNext_(arg_318_0)
			arg_316_1.onStoryFinished_()
		end

		function arg_316_1.onSingleLineUpdate_(arg_319_0)
			if 0 < arg_316_1.time_ and arg_316_1.time_ <= 0 + arg_319_0 then
				arg_316_1.var_.moveOldPos1170ui_story = arg_316_1.actors_["1170ui_story"].transform.localPosition

				local var_319_0 = GameObjectTools.GetOrAddComponent(arg_316_1.actors_["1170ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_319_0 then
					var_319_0:EnableDynamicBone(false)
				end
			end

			local var_319_1 = 0.001

			if 0 <= arg_316_1.time_ and arg_316_1.time_ < 0 + var_319_1 then
				arg_316_1.actors_["1170ui_story"].transform.localPosition = Vector3.Lerp(arg_316_1.var_.moveOldPos1170ui_story, Vector3.New(0.74, -0.95, -6.08), (arg_316_1.time_ - 0) / var_319_1)
				arg_316_1.actors_["1170ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_316_1.actors_["1170ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_316_1.actors_["1170ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_316_1.actors_["1170ui_story"].transform.position).z)
				arg_316_1.actors_["1170ui_story"].transform.localEulerAngles.z = 0
				arg_316_1.actors_["1170ui_story"].transform.localEulerAngles.x = 0
				arg_316_1.actors_["1170ui_story"].transform.localEulerAngles = arg_316_1.actors_["1170ui_story"].transform.localEulerAngles
			end

			if arg_316_1.time_ >= 0 + var_319_1 and arg_316_1.time_ < 0 + var_319_1 + arg_319_0 then
				arg_316_1.actors_["1170ui_story"].transform.localPosition = Vector3.New(0.74, -0.95, -6.08)
				arg_316_1.actors_["1170ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_316_1.actors_["1170ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_316_1.actors_["1170ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_316_1.actors_["1170ui_story"].transform.position).z)
				arg_316_1.actors_["1170ui_story"].transform.localEulerAngles.z = 0
				arg_316_1.actors_["1170ui_story"].transform.localEulerAngles.x = 0
				arg_316_1.actors_["1170ui_story"].transform.localEulerAngles = arg_316_1.actors_["1170ui_story"].transform.localEulerAngles

				local var_319_2 = GameObjectTools.GetOrAddComponent(arg_316_1.actors_["1170ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_319_2 then
					var_319_2:EnableDynamicBone(true)
				end
			end

			local var_319_3 = arg_316_1.actors_["1170ui_story"]

			if 0 < arg_316_1.time_ and arg_316_1.time_ <= 0 + arg_319_0 and not isNil(var_319_3) and arg_316_1.var_.characterEffect1170ui_story == nil then
				arg_316_1.var_.characterEffect1170ui_story = var_319_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_319_4 = 0.200000002980232

			if 0 <= arg_316_1.time_ and arg_316_1.time_ < 0 + var_319_4 and not isNil(var_319_3) then
				if arg_316_1.var_.characterEffect1170ui_story and not isNil(var_319_3) then
					arg_316_1.var_.characterEffect1170ui_story.fillFlat = false
				end
			end

			if arg_316_1.time_ >= 0 + var_319_4 and arg_316_1.time_ < 0 + var_319_4 + arg_319_0 and not isNil(var_319_3) and arg_316_1.var_.characterEffect1170ui_story then
				arg_316_1.var_.characterEffect1170ui_story.fillFlat = false
			end

			local var_319_6 = arg_316_1.actors_["1053ui_story"]

			if 0 < arg_316_1.time_ and arg_316_1.time_ <= 0 + arg_319_0 and not isNil(var_319_6) and arg_316_1.var_.characterEffect1053ui_story == nil then
				arg_316_1.var_.characterEffect1053ui_story = var_319_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_319_7 = 0.200000002980232

			if 0 <= arg_316_1.time_ and arg_316_1.time_ < 0 + var_319_7 and not isNil(var_319_6) then
				if arg_316_1.var_.characterEffect1053ui_story and not isNil(var_319_6) then
					arg_316_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_316_1.var_.characterEffect1053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_316_1.time_ - 0) / var_319_7)
				end
			end

			if arg_316_1.time_ >= 0 + var_319_7 and arg_316_1.time_ < 0 + var_319_7 + arg_319_0 and not isNil(var_319_6) and arg_316_1.var_.characterEffect1053ui_story then
				arg_316_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_316_1.var_.characterEffect1053ui_story.fillRatio = 0.5
			end

			if 0 < arg_316_1.time_ and arg_316_1.time_ <= 0 + arg_319_0 then
				arg_316_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/story1170/story1170action/1170action7_2")
			end

			local var_319_8 = 0
			local var_319_9 = 0.425

			if 0 < arg_316_1.time_ and arg_316_1.time_ <= var_319_8 + arg_319_0 then
				arg_316_1.talkMaxDuration = 0
				arg_316_1.dialogCg_.alpha = 1

				arg_316_1.dialog_:SetActive(true)
				SetActive(arg_316_1.leftNameGo_, true)

				arg_316_1.leftNameTxt_.text = arg_316_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_316_1.leftNameTxt_.transform)

				arg_316_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_316_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_316_1:RecordName(arg_316_1.leftNameTxt_.text)
				SetActive(arg_316_1.iconTrs_.gameObject, false)
				arg_316_1.callingController_:SetSelectedState("normal")

				local var_319_10 = arg_316_1:GetWordFromCfg(324131077)
				local var_319_11 = arg_316_1:FormatText(var_319_10.content)

				arg_316_1.text_.text = var_319_11

				LuaForUtil.ClearLinePrefixSymbol(arg_316_1.text_)

				local var_319_13 = 17 <= 0 and var_319_9 or var_319_9 * (utf8.len(var_319_11) / 17)

				if (17 <= 0 and var_319_9 or var_319_9 * (utf8.len(var_319_11) / 17)) > 0 and var_319_9 < var_319_13 then
					arg_316_1.talkMaxDuration = var_319_13

					if var_319_13 + var_319_8 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_13 + var_319_8
					end
				end

				arg_316_1.text_.text = var_319_11
				arg_316_1.typewritter.percent = 0

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324131", "324131077", "story_v_out_324131.awb") ~= 0 then
					local var_319_14 = manager.audio:GetVoiceLength("story_v_out_324131", "324131077", "story_v_out_324131.awb") / 1000

					if var_319_14 + var_319_8 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_14 + var_319_8
					end

					if var_319_10.prefab_name ~= "" and arg_316_1.actors_[var_319_10.prefab_name] ~= nil then
						local var_319_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_316_1.actors_[var_319_10.prefab_name].transform, "story_v_out_324131", "324131077", "story_v_out_324131.awb")

						arg_316_1:RecordAudio("324131077", var_319_15)
						arg_316_1:RecordAudio("324131077", var_319_15)
					else
						arg_316_1:AudioAction("play", "voice", "story_v_out_324131", "324131077", "story_v_out_324131.awb")
					end

					arg_316_1:RecordHistoryTalkVoice("story_v_out_324131", "324131077", "story_v_out_324131.awb")
				end

				arg_316_1:RecordContent(arg_316_1.text_.text)
			end

			local var_319_16 = math.max(var_319_9, arg_316_1.talkMaxDuration)

			if var_319_8 <= arg_316_1.time_ and arg_316_1.time_ < var_319_8 + var_319_16 then
				arg_316_1.typewritter.percent = (arg_316_1.time_ - var_319_8) / var_319_16

				arg_316_1.typewritter:SetDirty()
			end

			if arg_316_1.time_ >= var_319_8 + var_319_16 and arg_316_1.time_ < var_319_8 + var_319_16 + arg_319_0 then
				arg_316_1.typewritter.percent = 1

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(true)
			end
		end

		arg_316_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_316_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST2003",
		"TextureConfig/Background/J22f",
		"TextureConfig/Background/STblack"
	},
	voices = {
		"story_v_out_324131.awb"
	}
}
