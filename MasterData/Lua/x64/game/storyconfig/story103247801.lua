return {
	Play324781001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 324781001
		arg_1_1.duration_ = 4.6

		local var_1_0 = {
			zh = 4.6,
			ja = 4.533
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
				arg_1_0:Play324781002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST2007 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST2007")
				var_4_0.name = "ST2007"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST2007 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST2007

				arg_1_1.bgs_.ST2007.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST2007" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 2.025

			if 2.025 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
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

			local var_4_9 = "6148ui_story"

			if arg_1_1.actors_["6148ui_story"] == nil and not isNil((Asset.Load("Char/" .. "6148ui_story"))) then
				local var_4_10 = Object.Instantiate(Asset.Load("Char/" .. "6148ui_story"), arg_1_1.stage_.transform)

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

			local var_4_13 = arg_1_1.actors_["6148ui_story"]

			if 2.025 < arg_1_1.time_ and arg_1_1.time_ <= 2.025 + arg_4_0 and not isNil(var_4_13) and arg_1_1.var_.characterEffect6148ui_story == nil then
				arg_1_1.var_.characterEffect6148ui_story = var_4_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_14 = 0.200000002980232

			if 2.025 <= arg_1_1.time_ and arg_1_1.time_ < 2.025 + var_4_14 and not isNil(var_4_13) then
				if arg_1_1.var_.characterEffect6148ui_story and not isNil(var_4_13) then
					arg_1_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 2.025 + var_4_14 and arg_1_1.time_ < 2.025 + var_4_14 + arg_4_0 and not isNil(var_4_13) and arg_1_1.var_.characterEffect6148ui_story then
				arg_1_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			if 0.1 < arg_1_1.time_ and arg_1_1.time_ <= 0.1 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_birthday4", "se_story_birthday4_amb_room_tone_2", "")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "ui_battle", "ui_battle_stopbgm", "")
			end

			if 1 < arg_1_1.time_ and arg_1_1.time_ <= 1 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_5_0_story_qiulingong", "bgm_activity_5_0_story_qiulingong", "bgm_activity_5_0_story_qiulingong.awb")

				local var_4_20 = manager.audio:GetAudioName("bgm_activity_5_0_story_qiulingong", "bgm_activity_5_0_story_qiulingong")

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

			local var_4_21 = 2
			local var_4_22 = 0.325

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_21 + arg_4_0 then
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

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6148")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_24 = arg_1_1:GetWordFromCfg(324781001)
				local var_4_25 = arg_1_1:FormatText(var_4_24.content)

				arg_1_1.text_.text = var_4_25

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_27 = 13 <= 0 and var_4_22 or var_4_22 * (utf8.len(var_4_25) / 13)

				if (13 <= 0 and var_4_22 or var_4_22 * (utf8.len(var_4_25) / 13)) > 0 and var_4_22 < var_4_27 then
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

				if manager.audio:GetVoiceLength("story_v_out_324781", "324781001", "story_v_out_324781.awb") ~= 0 then
					local var_4_28 = manager.audio:GetVoiceLength("story_v_out_324781", "324781001", "story_v_out_324781.awb") / 1000

					if var_4_28 + var_4_21 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_28 + var_4_21
					end

					if var_4_24.prefab_name ~= "" and arg_1_1.actors_[var_4_24.prefab_name] ~= nil then
						local var_4_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_24.prefab_name].transform, "story_v_out_324781", "324781001", "story_v_out_324781.awb")

						arg_1_1:RecordAudio("324781001", var_4_29)
						arg_1_1:RecordAudio("324781001", var_4_29)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_324781", "324781001", "story_v_out_324781.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_324781", "324781001", "story_v_out_324781.awb")
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
	Play324781002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 324781002
		arg_8_1.duration_ = 2.33

		local var_8_0 = {
			zh = 1.7,
			ja = 2.333
		}
		local var_8_1 = manager.audio:GetLocalizationFlag()

		if var_8_0[var_8_1] ~= nil then
			arg_8_1.duration_ = var_8_0[var_8_1]
		end

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play324781003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			if arg_8_1.actors_["1054ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1054ui_story"))) then
				local var_11_0 = Object.Instantiate(Asset.Load("Char/" .. "1054ui_story"), arg_8_1.stage_.transform)

				var_11_0.name = "1054ui_story"
				var_11_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_8_1.actors_["1054ui_story"] = var_11_0

				local var_11_1 = var_11_0:GetComponentInChildren(typeof(CharacterEffect))

				var_11_1.enabled = true

				local var_11_2 = GameObjectTools.GetOrAddComponent(var_11_0, typeof(DynamicBoneHelper))

				if var_11_2 then
					var_11_2:EnableDynamicBone(false)
				end

				arg_8_1:ShowWeapon(var_11_1.transform, false)

				arg_8_1.var_["1054ui_story" .. "Animator"] = var_11_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_8_1.var_["1054ui_story" .. "Animator"].applyRootMotion = true
				arg_8_1.var_["1054ui_story" .. "LipSync"] = var_11_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_11_3 = arg_8_1.actors_["1054ui_story"]

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 and not isNil(var_11_3) and arg_8_1.var_.characterEffect1054ui_story == nil then
				arg_8_1.var_.characterEffect1054ui_story = var_11_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_4 = 0.200000002980232

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_4 and not isNil(var_11_3) then
				if arg_8_1.var_.characterEffect1054ui_story and not isNil(var_11_3) then
					arg_8_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_8_1.time_ >= 0 + var_11_4 and arg_8_1.time_ < 0 + var_11_4 + arg_11_0 and not isNil(var_11_3) and arg_8_1.var_.characterEffect1054ui_story then
				arg_8_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_11_6 = arg_8_1.actors_["6148ui_story"]

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 and not isNil(var_11_6) and arg_8_1.var_.characterEffect6148ui_story == nil then
				arg_8_1.var_.characterEffect6148ui_story = var_11_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_7 = 0.200000002980232

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_7 and not isNil(var_11_6) then
				if arg_8_1.var_.characterEffect6148ui_story and not isNil(var_11_6) then
					arg_8_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_8_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_8_1.time_ - 0) / var_11_7)
				end
			end

			if arg_8_1.time_ >= 0 + var_11_7 and arg_8_1.time_ < 0 + var_11_7 + arg_11_0 and not isNil(var_11_6) and arg_8_1.var_.characterEffect6148ui_story then
				arg_8_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_8_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			local var_11_8 = 0
			local var_11_9 = 0.15

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_8 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				arg_8_1.leftNameTxt_.text = arg_8_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, true)
				arg_8_1.iconController_:SetSelectedState("hero")

				arg_8_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1054")

				arg_8_1.callingController_:SetSelectedState("normal")

				arg_8_1.keyicon_.color = Color.New(1, 1, 1)
				arg_8_1.icon_.color = Color.New(1, 1, 1)

				local var_11_10 = arg_8_1:GetWordFromCfg(324781002)
				local var_11_11 = arg_8_1:FormatText(var_11_10.content)

				arg_8_1.text_.text = var_11_11

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_13 = 6 <= 0 and var_11_9 or var_11_9 * (utf8.len(var_11_11) / 6)

				if (6 <= 0 and var_11_9 or var_11_9 * (utf8.len(var_11_11) / 6)) > 0 and var_11_9 < var_11_13 then
					arg_8_1.talkMaxDuration = var_11_13

					if var_11_13 + var_11_8 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_13 + var_11_8
					end
				end

				arg_8_1.text_.text = var_11_11
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324781", "324781002", "story_v_out_324781.awb") ~= 0 then
					local var_11_14 = manager.audio:GetVoiceLength("story_v_out_324781", "324781002", "story_v_out_324781.awb") / 1000

					if var_11_14 + var_11_8 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_14 + var_11_8
					end

					if var_11_10.prefab_name ~= "" and arg_8_1.actors_[var_11_10.prefab_name] ~= nil then
						local var_11_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_10.prefab_name].transform, "story_v_out_324781", "324781002", "story_v_out_324781.awb")

						arg_8_1:RecordAudio("324781002", var_11_15)
						arg_8_1:RecordAudio("324781002", var_11_15)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_324781", "324781002", "story_v_out_324781.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_324781", "324781002", "story_v_out_324781.awb")
				end

				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_16 = math.max(var_11_9, arg_8_1.talkMaxDuration)

			if var_11_8 <= arg_8_1.time_ and arg_8_1.time_ < var_11_8 + var_11_16 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_8) / var_11_16

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_8 + var_11_16 and arg_8_1.time_ < var_11_8 + var_11_16 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play324781003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 324781003
		arg_12_1.duration_ = 5.27

		local var_12_0 = {
			zh = 2.9,
			ja = 5.266
		}
		local var_12_1 = manager.audio:GetLocalizationFlag()

		if var_12_0[var_12_1] ~= nil then
			arg_12_1.duration_ = var_12_0[var_12_1]
		end

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play324781004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			if arg_12_1.actors_["1053ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1053ui_story"))) then
				local var_15_0 = Object.Instantiate(Asset.Load("Char/" .. "1053ui_story"), arg_12_1.stage_.transform)

				var_15_0.name = "1053ui_story"
				var_15_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_12_1.actors_["1053ui_story"] = var_15_0

				local var_15_1 = var_15_0:GetComponentInChildren(typeof(CharacterEffect))

				var_15_1.enabled = true

				local var_15_2 = GameObjectTools.GetOrAddComponent(var_15_0, typeof(DynamicBoneHelper))

				if var_15_2 then
					var_15_2:EnableDynamicBone(false)
				end

				arg_12_1:ShowWeapon(var_15_1.transform, false)

				arg_12_1.var_["1053ui_story" .. "Animator"] = var_15_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_12_1.var_["1053ui_story" .. "Animator"].applyRootMotion = true
				arg_12_1.var_["1053ui_story" .. "LipSync"] = var_15_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_15_3 = arg_12_1.actors_["1053ui_story"]

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 and not isNil(var_15_3) and arg_12_1.var_.characterEffect1053ui_story == nil then
				arg_12_1.var_.characterEffect1053ui_story = var_15_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_4 = 0.200000002980232

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_4 and not isNil(var_15_3) then
				if arg_12_1.var_.characterEffect1053ui_story and not isNil(var_15_3) then
					arg_12_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_12_1.time_ >= 0 + var_15_4 and arg_12_1.time_ < 0 + var_15_4 + arg_15_0 and not isNil(var_15_3) and arg_12_1.var_.characterEffect1053ui_story then
				arg_12_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_15_6 = arg_12_1.actors_["1054ui_story"]

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 and not isNil(var_15_6) and arg_12_1.var_.characterEffect1054ui_story == nil then
				arg_12_1.var_.characterEffect1054ui_story = var_15_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_7 = 0.200000002980232

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_7 and not isNil(var_15_6) then
				if arg_12_1.var_.characterEffect1054ui_story and not isNil(var_15_6) then
					arg_12_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_12_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_12_1.time_ - 0) / var_15_7)
				end
			end

			if arg_12_1.time_ >= 0 + var_15_7 and arg_12_1.time_ < 0 + var_15_7 + arg_15_0 and not isNil(var_15_6) and arg_12_1.var_.characterEffect1054ui_story then
				arg_12_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_12_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			local var_15_8 = 0
			local var_15_9 = 0.225

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_8 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				arg_12_1.leftNameTxt_.text = arg_12_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, true)
				arg_12_1.iconController_:SetSelectedState("hero")

				arg_12_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1053")

				arg_12_1.callingController_:SetSelectedState("normal")

				arg_12_1.keyicon_.color = Color.New(1, 1, 1)
				arg_12_1.icon_.color = Color.New(1, 1, 1)

				local var_15_10 = arg_12_1:GetWordFromCfg(324781003)
				local var_15_11 = arg_12_1:FormatText(var_15_10.content)

				arg_12_1.text_.text = var_15_11

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_13 = 9 <= 0 and var_15_9 or var_15_9 * (utf8.len(var_15_11) / 9)

				if (9 <= 0 and var_15_9 or var_15_9 * (utf8.len(var_15_11) / 9)) > 0 and var_15_9 < var_15_13 then
					arg_12_1.talkMaxDuration = var_15_13

					if var_15_13 + var_15_8 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_13 + var_15_8
					end
				end

				arg_12_1.text_.text = var_15_11
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324781", "324781003", "story_v_out_324781.awb") ~= 0 then
					local var_15_14 = manager.audio:GetVoiceLength("story_v_out_324781", "324781003", "story_v_out_324781.awb") / 1000

					if var_15_14 + var_15_8 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_14 + var_15_8
					end

					if var_15_10.prefab_name ~= "" and arg_12_1.actors_[var_15_10.prefab_name] ~= nil then
						local var_15_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_10.prefab_name].transform, "story_v_out_324781", "324781003", "story_v_out_324781.awb")

						arg_12_1:RecordAudio("324781003", var_15_15)
						arg_12_1:RecordAudio("324781003", var_15_15)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_324781", "324781003", "story_v_out_324781.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_324781", "324781003", "story_v_out_324781.awb")
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

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play324781004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 324781004
		arg_16_1.duration_ = 5

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play324781005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 and not isNil(arg_16_1.actors_["1053ui_story"]) and arg_16_1.var_.characterEffect1053ui_story == nil then
				arg_16_1.var_.characterEffect1053ui_story = arg_16_1.actors_["1053ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_0 = 0.200000002980232

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_0 and not isNil(arg_16_1.actors_["1053ui_story"]) then
				if arg_16_1.var_.characterEffect1053ui_story and not isNil(arg_16_1.actors_["1053ui_story"]) then
					arg_16_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_16_1.var_.characterEffect1053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_16_1.time_ - 0) / var_19_0)
				end
			end

			if arg_16_1.time_ >= 0 + var_19_0 and arg_16_1.time_ < 0 + var_19_0 + arg_19_0 and not isNil(arg_16_1.actors_["1053ui_story"]) and arg_16_1.var_.characterEffect1053ui_story then
				arg_16_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_16_1.var_.characterEffect1053ui_story.fillRatio = 0.5
			end

			local var_19_1 = 0
			local var_19_2 = 0.825

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_1 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, false)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_3 = arg_16_1:FormatText(arg_16_1:GetWordFromCfg(324781004).content)

				arg_16_1.text_.text = var_19_3

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_5 = 33 <= 0 and var_19_2 or var_19_2 * (utf8.len(var_19_3) / 33)

				if (33 <= 0 and var_19_2 or var_19_2 * (utf8.len(var_19_3) / 33)) > 0 and var_19_2 < var_19_5 then
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
	Play324781005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 324781005
		arg_20_1.duration_ = 6.4

		local var_20_0 = {
			zh = 5.066,
			ja = 6.4
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
				arg_20_0:Play324781006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1.var_.moveOldPos1053ui_story = arg_20_1.actors_["1053ui_story"].transform.localPosition

				local var_23_0 = GameObjectTools.GetOrAddComponent(arg_20_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_23_0 then
					var_23_0:EnableDynamicBone(false)
				end
			end

			local var_23_1 = 0.001

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_1 then
				arg_20_1.actors_["1053ui_story"].transform.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos1053ui_story, Vector3.New(0, -1.08, -6), (arg_20_1.time_ - 0) / var_23_1)
				arg_20_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_20_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_20_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_20_1.actors_["1053ui_story"].transform.position).z)
				arg_20_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_20_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_20_1.actors_["1053ui_story"].transform.localEulerAngles = arg_20_1.actors_["1053ui_story"].transform.localEulerAngles
			end

			if arg_20_1.time_ >= 0 + var_23_1 and arg_20_1.time_ < 0 + var_23_1 + arg_23_0 then
				arg_20_1.actors_["1053ui_story"].transform.localPosition = Vector3.New(0, -1.08, -6)
				arg_20_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_20_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_20_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_20_1.actors_["1053ui_story"].transform.position).z)
				arg_20_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_20_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_20_1.actors_["1053ui_story"].transform.localEulerAngles = arg_20_1.actors_["1053ui_story"].transform.localEulerAngles

				local var_23_2 = GameObjectTools.GetOrAddComponent(arg_20_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_23_2 then
					var_23_2:EnableDynamicBone(true)
				end
			end

			local var_23_3 = arg_20_1.actors_["1053ui_story"]

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 and not isNil(var_23_3) and arg_20_1.var_.characterEffect1053ui_story == nil then
				arg_20_1.var_.characterEffect1053ui_story = var_23_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_4 = 0.200000002980232

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_4 and not isNil(var_23_3) then
				if arg_20_1.var_.characterEffect1053ui_story and not isNil(var_23_3) then
					arg_20_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_20_1.time_ >= 0 + var_23_4 and arg_20_1.time_ < 0 + var_23_4 + arg_23_0 and not isNil(var_23_3) and arg_20_1.var_.characterEffect1053ui_story then
				arg_20_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053action/1053action1_1")
			end

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_23_6 = 0
			local var_23_7 = 0.55

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_6 + arg_23_0 then
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

				local var_23_8 = arg_20_1:GetWordFromCfg(324781005)
				local var_23_9 = arg_20_1:FormatText(var_23_8.content)

				arg_20_1.text_.text = var_23_9

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_11 = 22 <= 0 and var_23_7 or var_23_7 * (utf8.len(var_23_9) / 22)

				if (22 <= 0 and var_23_7 or var_23_7 * (utf8.len(var_23_9) / 22)) > 0 and var_23_7 < var_23_11 then
					arg_20_1.talkMaxDuration = var_23_11

					if var_23_11 + var_23_6 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_11 + var_23_6
					end
				end

				arg_20_1.text_.text = var_23_9
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324781", "324781005", "story_v_out_324781.awb") ~= 0 then
					local var_23_12 = manager.audio:GetVoiceLength("story_v_out_324781", "324781005", "story_v_out_324781.awb") / 1000

					if var_23_12 + var_23_6 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_12 + var_23_6
					end

					if var_23_8.prefab_name ~= "" and arg_20_1.actors_[var_23_8.prefab_name] ~= nil then
						local var_23_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_8.prefab_name].transform, "story_v_out_324781", "324781005", "story_v_out_324781.awb")

						arg_20_1:RecordAudio("324781005", var_23_13)
						arg_20_1:RecordAudio("324781005", var_23_13)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_324781", "324781005", "story_v_out_324781.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_324781", "324781005", "story_v_out_324781.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_14 = math.max(var_23_7, arg_20_1.talkMaxDuration)

			if var_23_6 <= arg_20_1.time_ and arg_20_1.time_ < var_23_6 + var_23_14 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_6) / var_23_14

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_6 + var_23_14 and arg_20_1.time_ < var_23_6 + var_23_14 + arg_23_0 then
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
	Play324781006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 324781006
		arg_24_1.duration_ = 2.8

		local var_24_0 = {
			zh = 2.8,
			ja = 2.633
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
				arg_24_0:Play324781007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1.var_.moveOldPos1053ui_story = arg_24_1.actors_["1053ui_story"].transform.localPosition

				local var_27_0 = GameObjectTools.GetOrAddComponent(arg_24_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_27_0 then
					var_27_0:EnableDynamicBone(false)
				end
			end

			local var_27_1 = 0.001

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_1 then
				arg_24_1.actors_["1053ui_story"].transform.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos1053ui_story, Vector3.New(0.7, -1.08, -6), (arg_24_1.time_ - 0) / var_27_1)
				arg_24_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_24_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_24_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_24_1.actors_["1053ui_story"].transform.position).z)
				arg_24_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_24_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_24_1.actors_["1053ui_story"].transform.localEulerAngles = arg_24_1.actors_["1053ui_story"].transform.localEulerAngles
			end

			if arg_24_1.time_ >= 0 + var_27_1 and arg_24_1.time_ < 0 + var_27_1 + arg_27_0 then
				arg_24_1.actors_["1053ui_story"].transform.localPosition = Vector3.New(0.7, -1.08, -6)
				arg_24_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_24_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_24_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_24_1.actors_["1053ui_story"].transform.position).z)
				arg_24_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_24_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_24_1.actors_["1053ui_story"].transform.localEulerAngles = arg_24_1.actors_["1053ui_story"].transform.localEulerAngles

				local var_27_2 = GameObjectTools.GetOrAddComponent(arg_24_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_27_2 then
					var_27_2:EnableDynamicBone(true)
				end
			end

			local var_27_3 = arg_24_1.actors_["1054ui_story"].transform

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1.var_.moveOldPos1054ui_story = var_27_3.localPosition

				local var_27_4 = GameObjectTools.GetOrAddComponent(var_27_3.gameObject, typeof(DynamicBoneHelper))

				if var_27_4 then
					var_27_4:EnableDynamicBone(false)
				end
			end

			local var_27_5 = 0.001

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_5 then
				var_27_3.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos1054ui_story, Vector3.New(-0.7, -0.985, -6), (arg_24_1.time_ - 0) / var_27_5)
				var_27_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_27_3.position).x, (manager.ui.mainCamera.transform.position - var_27_3.position).y, (manager.ui.mainCamera.transform.position - var_27_3.position).z)
				var_27_3.localEulerAngles.z = 0
				var_27_3.localEulerAngles.x = 0
				var_27_3.localEulerAngles = var_27_3.localEulerAngles
			end

			if arg_24_1.time_ >= 0 + var_27_5 and arg_24_1.time_ < 0 + var_27_5 + arg_27_0 then
				var_27_3.localPosition = Vector3.New(-0.7, -0.985, -6)
				var_27_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_27_3.position).x, (manager.ui.mainCamera.transform.position - var_27_3.position).y, (manager.ui.mainCamera.transform.position - var_27_3.position).z)
				var_27_3.localEulerAngles.z = 0
				var_27_3.localEulerAngles.x = 0
				var_27_3.localEulerAngles = var_27_3.localEulerAngles

				local var_27_6 = GameObjectTools.GetOrAddComponent(var_27_3.gameObject, typeof(DynamicBoneHelper))

				if var_27_6 then
					var_27_6:EnableDynamicBone(true)
				end
			end

			local var_27_7 = arg_24_1.actors_["1054ui_story"]

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 and not isNil(var_27_7) and arg_24_1.var_.characterEffect1054ui_story == nil then
				arg_24_1.var_.characterEffect1054ui_story = var_27_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_8 = 0.200000002980232

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_8 and not isNil(var_27_7) then
				if arg_24_1.var_.characterEffect1054ui_story and not isNil(var_27_7) then
					arg_24_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_24_1.time_ >= 0 + var_27_8 and arg_24_1.time_ < 0 + var_27_8 + arg_27_0 and not isNil(var_27_7) and arg_24_1.var_.characterEffect1054ui_story then
				arg_24_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_27_10 = arg_24_1.actors_["1053ui_story"]

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 and not isNil(var_27_10) and arg_24_1.var_.characterEffect1053ui_story == nil then
				arg_24_1.var_.characterEffect1053ui_story = var_27_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_11 = 0.200000002980232

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_11 and not isNil(var_27_10) then
				if arg_24_1.var_.characterEffect1053ui_story and not isNil(var_27_10) then
					arg_24_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_24_1.var_.characterEffect1053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_24_1.time_ - 0) / var_27_11)
				end
			end

			if arg_24_1.time_ >= 0 + var_27_11 and arg_24_1.time_ < 0 + var_27_11 + arg_27_0 and not isNil(var_27_10) and arg_24_1.var_.characterEffect1053ui_story then
				arg_24_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_24_1.var_.characterEffect1053ui_story.fillRatio = 0.5
			end

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action5_1")
			end

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_27_12 = 0
			local var_27_13 = 0.275

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_12 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				arg_24_1.leftNameTxt_.text = arg_24_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_14 = arg_24_1:GetWordFromCfg(324781006)
				local var_27_15 = arg_24_1:FormatText(var_27_14.content)

				arg_24_1.text_.text = var_27_15

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_17 = 11 <= 0 and var_27_13 or var_27_13 * (utf8.len(var_27_15) / 11)

				if (11 <= 0 and var_27_13 or var_27_13 * (utf8.len(var_27_15) / 11)) > 0 and var_27_13 < var_27_17 then
					arg_24_1.talkMaxDuration = var_27_17

					if var_27_17 + var_27_12 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_17 + var_27_12
					end
				end

				arg_24_1.text_.text = var_27_15
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324781", "324781006", "story_v_out_324781.awb") ~= 0 then
					local var_27_18 = manager.audio:GetVoiceLength("story_v_out_324781", "324781006", "story_v_out_324781.awb") / 1000

					if var_27_18 + var_27_12 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_18 + var_27_12
					end

					if var_27_14.prefab_name ~= "" and arg_24_1.actors_[var_27_14.prefab_name] ~= nil then
						local var_27_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_14.prefab_name].transform, "story_v_out_324781", "324781006", "story_v_out_324781.awb")

						arg_24_1:RecordAudio("324781006", var_27_19)
						arg_24_1:RecordAudio("324781006", var_27_19)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_324781", "324781006", "story_v_out_324781.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_324781", "324781006", "story_v_out_324781.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_20 = math.max(var_27_13, arg_24_1.talkMaxDuration)

			if var_27_12 <= arg_24_1.time_ and arg_24_1.time_ < var_27_12 + var_27_20 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_12) / var_27_20

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_12 + var_27_20 and arg_24_1.time_ < var_27_12 + var_27_20 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_24_1:InitPlayNodeList()
	end,
	Play324781007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 324781007
		arg_28_1.duration_ = 16.63

		local var_28_0 = {
			zh = 9.833,
			ja = 16.633
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
				arg_28_0:Play324781008(arg_28_1)
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

			local var_31_2 = arg_28_1.actors_["1054ui_story"]

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 and not isNil(var_31_2) and arg_28_1.var_.characterEffect1054ui_story == nil then
				arg_28_1.var_.characterEffect1054ui_story = var_31_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_3 = 0.200000002980232

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_3 and not isNil(var_31_2) then
				if arg_28_1.var_.characterEffect1054ui_story and not isNil(var_31_2) then
					arg_28_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_28_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_28_1.time_ - 0) / var_31_3)
				end
			end

			if arg_28_1.time_ >= 0 + var_31_3 and arg_28_1.time_ < 0 + var_31_3 + arg_31_0 and not isNil(var_31_2) and arg_28_1.var_.characterEffect1054ui_story then
				arg_28_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_28_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053action/1053action3_1")
			end

			local var_31_4 = 0
			local var_31_5 = 0.8

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

				local var_31_6 = arg_28_1:GetWordFromCfg(324781007)
				local var_31_7 = arg_28_1:FormatText(var_31_6.content)

				arg_28_1.text_.text = var_31_7

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_9 = 32 <= 0 and var_31_5 or var_31_5 * (utf8.len(var_31_7) / 32)

				if (32 <= 0 and var_31_5 or var_31_5 * (utf8.len(var_31_7) / 32)) > 0 and var_31_5 < var_31_9 then
					arg_28_1.talkMaxDuration = var_31_9

					if var_31_9 + var_31_4 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_9 + var_31_4
					end
				end

				arg_28_1.text_.text = var_31_7
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324781", "324781007", "story_v_out_324781.awb") ~= 0 then
					local var_31_10 = manager.audio:GetVoiceLength("story_v_out_324781", "324781007", "story_v_out_324781.awb") / 1000

					if var_31_10 + var_31_4 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_10 + var_31_4
					end

					if var_31_6.prefab_name ~= "" and arg_28_1.actors_[var_31_6.prefab_name] ~= nil then
						local var_31_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_6.prefab_name].transform, "story_v_out_324781", "324781007", "story_v_out_324781.awb")

						arg_28_1:RecordAudio("324781007", var_31_11)
						arg_28_1:RecordAudio("324781007", var_31_11)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_324781", "324781007", "story_v_out_324781.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_324781", "324781007", "story_v_out_324781.awb")
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
	Play324781008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 324781008
		arg_32_1.duration_ = 8.43

		local var_32_0 = {
			zh = 7.06633333333333,
			ja = 8.43333333333333
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
				arg_32_0:Play324781009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			if arg_32_1.bgs_.J27f == nil then
				local var_35_0 = Object.Instantiate(arg_32_1.paintGo_)

				var_35_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "J27f")
				var_35_0.name = "J27f"
				var_35_0.transform.parent = arg_32_1.stage_.transform
				var_35_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_32_1.bgs_.J27f = var_35_0
			end

			if 0.633333333333333 < arg_32_1.time_ and arg_32_1.time_ <= 0.633333333333333 + arg_35_0 then
				local var_35_1 = arg_32_1.bgs_.J27f

				arg_32_1.bgs_.J27f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_35_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_35_2 = var_35_1:GetComponent("SpriteRenderer")

				if var_35_2 and var_35_2.sprite then
					local var_35_3 = 2 * (var_35_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_35_1.transform.localScale = Vector3.New(var_35_3 / var_35_2.sprite.bounds.size.y < var_35_3 * manager.ui.mainCameraCom_.aspect / var_35_2.sprite.bounds.size.x and var_35_3 * manager.ui.mainCameraCom_.aspect / var_35_2.sprite.bounds.size.x or var_35_3 / var_35_2.sprite.bounds.size.y, var_35_3 / var_35_2.sprite.bounds.size.y < var_35_3 * manager.ui.mainCameraCom_.aspect / var_35_2.sprite.bounds.size.x and var_35_3 * manager.ui.mainCameraCom_.aspect / var_35_2.sprite.bounds.size.x or var_35_3 / var_35_2.sprite.bounds.size.y, 0)
				end

				for iter_35_0, iter_35_1 in pairs(arg_32_1.bgs_) do
					if iter_35_0 ~= "J27f" then
						iter_35_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_35_4 = 4

			if 4 < arg_32_1.time_ and arg_32_1.time_ <= var_35_4 + arg_35_0 then
				arg_32_1.allBtn_.enabled = false
			end

			if arg_32_1.time_ >= var_35_4 + 0.3 and arg_32_1.time_ < var_35_4 + 0.3 + arg_35_0 then
				arg_32_1.allBtn_.enabled = true
			end

			local var_35_5 = 0

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_5 + arg_35_0 then
				arg_32_1.mask_.enabled = true
				arg_32_1.mask_.raycastTarget = true

				arg_32_1:SetGaussion(false)
			end

			local var_35_6 = 0.633333333333333

			if var_35_5 <= arg_32_1.time_ and arg_32_1.time_ < var_35_5 + var_35_6 then
				local var_35_7 = Color.New(0, 0, 0)

				var_35_7.a = Mathf.Lerp(0, 1, (arg_32_1.time_ - var_35_5) / var_35_6)
				arg_32_1.mask_.color = var_35_7
			end

			if arg_32_1.time_ >= var_35_5 + var_35_6 and arg_32_1.time_ < var_35_5 + var_35_6 + arg_35_0 then
				local var_35_8 = Color.New(0, 0, 0)

				var_35_8.a = 1
				arg_32_1.mask_.color = var_35_8
			end

			local var_35_9 = 0.633333333333333

			if 0.633333333333333 < arg_32_1.time_ and arg_32_1.time_ <= var_35_9 + arg_35_0 then
				arg_32_1.mask_.enabled = true
				arg_32_1.mask_.raycastTarget = true

				arg_32_1:SetGaussion(false)
			end

			local var_35_10 = 0.633333333333333

			if var_35_9 <= arg_32_1.time_ and arg_32_1.time_ < var_35_9 + var_35_10 then
				local var_35_11 = Color.New(0, 0, 0)

				var_35_11.a = Mathf.Lerp(1, 0, (arg_32_1.time_ - var_35_9) / var_35_10)
				arg_32_1.mask_.color = var_35_11
			end

			if arg_32_1.time_ >= var_35_9 + var_35_10 and arg_32_1.time_ < var_35_9 + var_35_10 + arg_35_0 then
				local var_35_12 = Color.New(0, 0, 0)

				arg_32_1.mask_.enabled = false
				var_35_12.a = 0
				arg_32_1.mask_.color = var_35_12
			end

			local var_35_13 = 3

			if 3 < arg_32_1.time_ and arg_32_1.time_ <= var_35_13 + arg_35_0 then
				arg_32_1.mask_.enabled = true
				arg_32_1.mask_.raycastTarget = true

				arg_32_1:SetGaussion(false)
			end

			local var_35_14 = 1.2

			if var_35_13 <= arg_32_1.time_ and arg_32_1.time_ < var_35_13 + var_35_14 then
				local var_35_15 = Color.New(0, 0, 0)

				var_35_15.a = Mathf.Lerp(0, 1, (arg_32_1.time_ - var_35_13) / var_35_14)
				arg_32_1.mask_.color = var_35_15
			end

			if arg_32_1.time_ >= var_35_13 + var_35_14 and arg_32_1.time_ < var_35_13 + var_35_14 + arg_35_0 then
				local var_35_16 = Color.New(0, 0, 0)

				var_35_16.a = 1
				arg_32_1.mask_.color = var_35_16
			end

			local var_35_17 = 4.2

			if 4.2 < arg_32_1.time_ and arg_32_1.time_ <= var_35_17 + arg_35_0 then
				arg_32_1.mask_.enabled = true
				arg_32_1.mask_.raycastTarget = true

				arg_32_1:SetGaussion(false)
			end

			local var_35_18 = 1.43333333333333

			if var_35_17 <= arg_32_1.time_ and arg_32_1.time_ < var_35_17 + var_35_18 then
				local var_35_19 = Color.New(0, 0, 0)

				var_35_19.a = Mathf.Lerp(1, 0, (arg_32_1.time_ - var_35_17) / var_35_18)
				arg_32_1.mask_.color = var_35_19
			end

			if arg_32_1.time_ >= var_35_17 + var_35_18 and arg_32_1.time_ < var_35_17 + var_35_18 + arg_35_0 then
				local var_35_20 = Color.New(0, 0, 0)

				arg_32_1.mask_.enabled = false
				var_35_20.a = 0
				arg_32_1.mask_.color = var_35_20
			end

			if 5 < arg_32_1.time_ and arg_32_1.time_ <= 5 + arg_35_0 then
				arg_32_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053action/1053action1_1")
			end

			if 5 < arg_32_1.time_ and arg_32_1.time_ <= 5 + arg_35_0 then
				arg_32_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_35_21 = arg_32_1.actors_["1054ui_story"].transform

			if 0.633333333333333 < arg_32_1.time_ and arg_32_1.time_ <= 0.633333333333333 + arg_35_0 then
				arg_32_1.var_.moveOldPos1054ui_story = var_35_21.localPosition

				local var_35_22 = GameObjectTools.GetOrAddComponent(var_35_21.gameObject, typeof(DynamicBoneHelper))

				if var_35_22 then
					var_35_22:EnableDynamicBone(false)
				end
			end

			local var_35_23 = 0.001

			if 0.633333333333333 <= arg_32_1.time_ and arg_32_1.time_ < 0.633333333333333 + var_35_23 then
				var_35_21.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos1054ui_story, Vector3.New(0, 100, 0), (arg_32_1.time_ - 0.633333333333333) / var_35_23)
				var_35_21.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_35_21.position).x, (manager.ui.mainCamera.transform.position - var_35_21.position).y, (manager.ui.mainCamera.transform.position - var_35_21.position).z)
				var_35_21.localEulerAngles.z = 0
				var_35_21.localEulerAngles.x = 0
				var_35_21.localEulerAngles = var_35_21.localEulerAngles
			end

			if arg_32_1.time_ >= 0.633333333333333 + var_35_23 and arg_32_1.time_ < 0.633333333333333 + var_35_23 + arg_35_0 then
				var_35_21.localPosition = Vector3.New(0, 100, 0)
				var_35_21.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_35_21.position).x, (manager.ui.mainCamera.transform.position - var_35_21.position).y, (manager.ui.mainCamera.transform.position - var_35_21.position).z)
				var_35_21.localEulerAngles.z = 0
				var_35_21.localEulerAngles.x = 0
				var_35_21.localEulerAngles = var_35_21.localEulerAngles

				local var_35_24 = GameObjectTools.GetOrAddComponent(var_35_21.gameObject, typeof(DynamicBoneHelper))

				if var_35_24 then
					var_35_24:EnableDynamicBone(true)
				end
			end

			local var_35_25 = arg_32_1.actors_["1053ui_story"].transform

			if 0.633333333333333 < arg_32_1.time_ and arg_32_1.time_ <= 0.633333333333333 + arg_35_0 then
				arg_32_1.var_.moveOldPos1053ui_story = var_35_25.localPosition

				local var_35_26 = GameObjectTools.GetOrAddComponent(var_35_25.gameObject, typeof(DynamicBoneHelper))

				if var_35_26 then
					var_35_26:EnableDynamicBone(false)
				end
			end

			local var_35_27 = 0.001

			if 0.633333333333333 <= arg_32_1.time_ and arg_32_1.time_ < 0.633333333333333 + var_35_27 then
				var_35_25.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos1053ui_story, Vector3.New(0, 100, 0), (arg_32_1.time_ - 0.633333333333333) / var_35_27)
				var_35_25.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_35_25.position).x, (manager.ui.mainCamera.transform.position - var_35_25.position).y, (manager.ui.mainCamera.transform.position - var_35_25.position).z)
				var_35_25.localEulerAngles.z = 0
				var_35_25.localEulerAngles.x = 0
				var_35_25.localEulerAngles = var_35_25.localEulerAngles
			end

			if arg_32_1.time_ >= 0.633333333333333 + var_35_27 and arg_32_1.time_ < 0.633333333333333 + var_35_27 + arg_35_0 then
				var_35_25.localPosition = Vector3.New(0, 100, 0)
				var_35_25.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_35_25.position).x, (manager.ui.mainCamera.transform.position - var_35_25.position).y, (manager.ui.mainCamera.transform.position - var_35_25.position).z)
				var_35_25.localEulerAngles.z = 0
				var_35_25.localEulerAngles.x = 0
				var_35_25.localEulerAngles = var_35_25.localEulerAngles

				local var_35_28 = GameObjectTools.GetOrAddComponent(var_35_25.gameObject, typeof(DynamicBoneHelper))

				if var_35_28 then
					var_35_28:EnableDynamicBone(true)
				end
			end

			local var_35_29 = arg_32_1.actors_["1053ui_story"]

			if 5 < arg_32_1.time_ and arg_32_1.time_ <= 5 + arg_35_0 and not isNil(var_35_29) and arg_32_1.var_.characterEffect1053ui_story == nil then
				arg_32_1.var_.characterEffect1053ui_story = var_35_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_30 = 0.2

			if 5 <= arg_32_1.time_ and arg_32_1.time_ < 5 + var_35_30 and not isNil(var_35_29) then
				if arg_32_1.var_.characterEffect1053ui_story and not isNil(var_35_29) then
					arg_32_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_32_1.time_ >= 5 + var_35_30 and arg_32_1.time_ < 5 + var_35_30 + arg_35_0 and not isNil(var_35_29) and arg_32_1.var_.characterEffect1053ui_story then
				arg_32_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_35_32 = arg_32_1.actors_["1053ui_story"].transform

			if 5 < arg_32_1.time_ and arg_32_1.time_ <= 5 + arg_35_0 then
				arg_32_1.var_.moveOldPos1053ui_story = var_35_32.localPosition

				local var_35_33 = GameObjectTools.GetOrAddComponent(var_35_32.gameObject, typeof(DynamicBoneHelper))

				if var_35_33 then
					var_35_33:EnableDynamicBone(false)
				end
			end

			local var_35_34 = 0.001

			if 5 <= arg_32_1.time_ and arg_32_1.time_ < 5 + var_35_34 then
				var_35_32.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos1053ui_story, Vector3.New(0, -1.08, -6), (arg_32_1.time_ - 5) / var_35_34)
				var_35_32.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_35_32.position).x, (manager.ui.mainCamera.transform.position - var_35_32.position).y, (manager.ui.mainCamera.transform.position - var_35_32.position).z)
				var_35_32.localEulerAngles.z = 0
				var_35_32.localEulerAngles.x = 0
				var_35_32.localEulerAngles = var_35_32.localEulerAngles
			end

			if arg_32_1.time_ >= 5 + var_35_34 and arg_32_1.time_ < 5 + var_35_34 + arg_35_0 then
				var_35_32.localPosition = Vector3.New(0, -1.08, -6)
				var_35_32.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_35_32.position).x, (manager.ui.mainCamera.transform.position - var_35_32.position).y, (manager.ui.mainCamera.transform.position - var_35_32.position).z)
				var_35_32.localEulerAngles.z = 0
				var_35_32.localEulerAngles.x = 0
				var_35_32.localEulerAngles = var_35_32.localEulerAngles

				local var_35_35 = GameObjectTools.GetOrAddComponent(var_35_32.gameObject, typeof(DynamicBoneHelper))

				if var_35_35 then
					var_35_35:EnableDynamicBone(true)
				end
			end

			local var_35_36 = 0.633333333333333

			if 0.633333333333333 < arg_32_1.time_ and arg_32_1.time_ <= var_35_36 + arg_35_0 then
				arg_32_1.timestampController_:SetSelectedState("show")
				arg_32_1.timestampAni_:Play("in")

				arg_32_1.timeTicketbgImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "J27f")

				arg_32_1.timestampColorController_:SetSelectedState("cold")
				arg_32_1.timeColdImg_:SetAlpha(0.031)

				arg_32_1.text_timeText_.text = arg_32_1:FormatText(arg_32_1:GetWordFromCfg(102).content)
				arg_32_1.text_timeText_.font = Asset.Load("Assets/3rd/BitmapFontImporter/Examples/Font1/font1.fontsettings")

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_timeText_)

				arg_32_1.text_siteText_.text = arg_32_1:FormatText(arg_32_1:GetWordFromCfg(501130).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_siteText_)
			end

			if arg_32_1.time_ >= var_35_36 + 3 and arg_32_1.time_ < var_35_36 + 3 + arg_35_0 then
				AnimatorTools.PlayAnimationWithCallback(arg_32_1.timestampAni_, "out", function()
					arg_32_1.timestampController_:SetSelectedState("hide")
				end)
			end

			if 1.2 < arg_32_1.time_ and arg_32_1.time_ <= 1.2 + arg_35_0 then
				arg_32_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_amb_winter_loop", "")
			end

			if 0.1 < arg_32_1.time_ and arg_32_1.time_ <= 0.1 + arg_35_0 then
				arg_32_1:AudioAction("stop", "effect", "se_story_birthday4", "se_story_birthday4_amb_room_tone_2", "")
			end

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1:AudioAction("play", "effect", "ui_battle", "ui_battle_stopbgm", "")
			end

			if 1 < arg_32_1.time_ and arg_32_1.time_ <= 1 + arg_35_0 then
				arg_32_1:AudioAction("play", "music", "bgm_activity_5_0_story_qiuyunshan", "bgm_activity_5_0_story_qiuyunshan", "bgm_activity_5_0_story_qiuyunshan.awb")

				local var_35_42 = manager.audio:GetAudioName("bgm_activity_5_0_story_qiuyunshan", "bgm_activity_5_0_story_qiuyunshan")

				if "" ~= "" then
					if arg_32_1.bgmTxt_.text ~= var_35_42 and arg_32_1.bgmTxt_.text ~= "" then
						if arg_32_1.bgmTxt2_.text ~= "" then
							arg_32_1.bgmTxt_.text = arg_32_1.bgmTxt2_.text
						end

						arg_32_1.bgmTxt2_.text = var_35_42

						arg_32_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_32_1.bgmTxt_.text = var_35_42
						arg_32_1.bgmTxt2_.text = var_35_42
					end

					if arg_32_1.bgmTimer then
						arg_32_1.bgmTimer:Stop()

						arg_32_1.bgmTimer = nil
					end

					if arg_32_1.settingData.show_music_name == 1 then
						arg_32_1.musicController:SetSelectedState("show")
						arg_32_1.musicAnimator_:Play("open", 0, 0)

						if arg_32_1.settingData.music_time ~= 0 then
							arg_32_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_32_1.settingData.music_time), function()
								if arg_32_1 == nil or isNil(arg_32_1.bgmTxt_) then
									return
								end

								arg_32_1.musicController:SetSelectedState("hide")
								arg_32_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_35_43 = 0

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_43 + arg_35_0 then
				arg_32_1.allBtn_.enabled = false
			end

			if arg_32_1.time_ >= var_35_43 + 4.33333333333333 and arg_32_1.time_ < var_35_43 + 4.33333333333333 + arg_35_0 then
				arg_32_1.allBtn_.enabled = true
			end

			if arg_32_1.frameCnt_ <= 1 then
				arg_32_1.dialog_:SetActive(false)
			end

			local var_35_44 = 5.33333333333333
			local var_35_45 = 0.175

			if 5.33333333333333 < arg_32_1.time_ and arg_32_1.time_ <= var_35_44 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0

				arg_32_1.dialog_:SetActive(true)

				arg_32_1.dialogCg_.alpha = 0

				local var_35_46 = LeanTween.value(arg_32_1.dialog_, 0, 1, 0.3)

				var_35_46:setOnUpdate(LuaHelper.FloatAction(function(arg_38_0)
					arg_32_1.dialogCg_.alpha = arg_38_0
				end))
				var_35_46:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_32_1.dialog_)
					var_35_46:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_32_1.duration_ = arg_32_1.duration_ + 0.3

				SetActive(arg_32_1.leftNameGo_, true)

				arg_32_1.leftNameTxt_.text = arg_32_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_47 = arg_32_1:GetWordFromCfg(324781008)
				local var_35_48 = arg_32_1:FormatText(var_35_47.content)

				arg_32_1.text_.text = var_35_48

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_50 = 7 <= 0 and var_35_45 or var_35_45 * (utf8.len(var_35_48) / 7)

				if (7 <= 0 and var_35_45 or var_35_45 * (utf8.len(var_35_48) / 7)) > 0 and var_35_45 < var_35_50 then
					arg_32_1.talkMaxDuration = var_35_50
					var_35_44 = var_35_44 + 0.3

					if var_35_50 + var_35_44 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_50 + var_35_44
					end
				end

				arg_32_1.text_.text = var_35_48
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324781", "324781008", "story_v_out_324781.awb") ~= 0 then
					local var_35_51 = manager.audio:GetVoiceLength("story_v_out_324781", "324781008", "story_v_out_324781.awb") / 1000

					if var_35_51 + var_35_44 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_51 + var_35_44
					end

					if var_35_47.prefab_name ~= "" and arg_32_1.actors_[var_35_47.prefab_name] ~= nil then
						local var_35_52 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_47.prefab_name].transform, "story_v_out_324781", "324781008", "story_v_out_324781.awb")

						arg_32_1:RecordAudio("324781008", var_35_52)
						arg_32_1:RecordAudio("324781008", var_35_52)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_324781", "324781008", "story_v_out_324781.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_324781", "324781008", "story_v_out_324781.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_53 = var_35_44 + 0.3
			local var_35_54 = math.max(var_35_45, arg_32_1.talkMaxDuration)

			if var_35_44 + 0.3 <= arg_32_1.time_ and arg_32_1.time_ < var_35_53 + var_35_54 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_53) / var_35_54

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_53 + var_35_54 and arg_32_1.time_ < var_35_53 + var_35_54 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0.633333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0.633333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 5,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_32_1:InitPlayNodeList()
	end,
	Play324781009 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 324781009
		arg_40_1.duration_ = 10.4

		local var_40_0 = {
			zh = 9.6,
			ja = 10.4
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
				arg_40_0:Play324781010(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1.var_.moveOldPos1053ui_story = arg_40_1.actors_["1053ui_story"].transform.localPosition

				local var_43_0 = GameObjectTools.GetOrAddComponent(arg_40_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_43_0 then
					var_43_0:EnableDynamicBone(false)
				end
			end

			local var_43_1 = 0.001

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_1 then
				arg_40_1.actors_["1053ui_story"].transform.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos1053ui_story, Vector3.New(0, -1.08, -6), (arg_40_1.time_ - 0) / var_43_1)
				arg_40_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_40_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_40_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_40_1.actors_["1053ui_story"].transform.position).z)
				arg_40_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_40_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_40_1.actors_["1053ui_story"].transform.localEulerAngles = arg_40_1.actors_["1053ui_story"].transform.localEulerAngles
			end

			if arg_40_1.time_ >= 0 + var_43_1 and arg_40_1.time_ < 0 + var_43_1 + arg_43_0 then
				arg_40_1.actors_["1053ui_story"].transform.localPosition = Vector3.New(0, -1.08, -6)
				arg_40_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_40_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_40_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_40_1.actors_["1053ui_story"].transform.position).z)
				arg_40_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_40_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_40_1.actors_["1053ui_story"].transform.localEulerAngles = arg_40_1.actors_["1053ui_story"].transform.localEulerAngles

				local var_43_2 = GameObjectTools.GetOrAddComponent(arg_40_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_43_2 then
					var_43_2:EnableDynamicBone(true)
				end
			end

			local var_43_3 = "1132ui_story"

			if arg_40_1.actors_["1132ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1132ui_story"))) then
				local var_43_4 = Object.Instantiate(Asset.Load("Char/" .. "1132ui_story"), arg_40_1.stage_.transform)

				var_43_4.name = var_43_3
				var_43_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_40_1.actors_[var_43_3] = var_43_4

				local var_43_5 = var_43_4:GetComponentInChildren(typeof(CharacterEffect))

				var_43_5.enabled = true

				local var_43_6 = GameObjectTools.GetOrAddComponent(var_43_4, typeof(DynamicBoneHelper))

				if var_43_6 then
					var_43_6:EnableDynamicBone(false)
				end

				arg_40_1:ShowWeapon(var_43_5.transform, false)

				arg_40_1.var_[var_43_3 .. "Animator"] = var_43_5.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_40_1.var_[var_43_3 .. "Animator"].applyRootMotion = true
				arg_40_1.var_[var_43_3 .. "LipSync"] = var_43_5.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_43_7 = arg_40_1.actors_["1132ui_story"]

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 and not isNil(var_43_7) and arg_40_1.var_.characterEffect1132ui_story == nil then
				arg_40_1.var_.characterEffect1132ui_story = var_43_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_8 = 0.200000002980232

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_8 and not isNil(var_43_7) then
				if arg_40_1.var_.characterEffect1132ui_story and not isNil(var_43_7) then
					arg_40_1.var_.characterEffect1132ui_story.fillFlat = false
				end
			end

			if arg_40_1.time_ >= 0 + var_43_8 and arg_40_1.time_ < 0 + var_43_8 + arg_43_0 and not isNil(var_43_7) and arg_40_1.var_.characterEffect1132ui_story then
				arg_40_1.var_.characterEffect1132ui_story.fillFlat = false
			end

			local var_43_10 = arg_40_1.actors_["1053ui_story"]

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 and not isNil(var_43_10) and arg_40_1.var_.characterEffect1053ui_story == nil then
				arg_40_1.var_.characterEffect1053ui_story = var_43_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_11 = 0.200000002980232

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_11 and not isNil(var_43_10) then
				if arg_40_1.var_.characterEffect1053ui_story and not isNil(var_43_10) then
					arg_40_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_40_1.var_.characterEffect1053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_40_1.time_ - 0) / var_43_11)
				end
			end

			if arg_40_1.time_ >= 0 + var_43_11 and arg_40_1.time_ < 0 + var_43_11 + arg_43_0 and not isNil(var_43_10) and arg_40_1.var_.characterEffect1053ui_story then
				arg_40_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_40_1.var_.characterEffect1053ui_story.fillRatio = 0.5
			end

			local var_43_12 = 0
			local var_43_13 = 0.8

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_12 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				arg_40_1.leftNameTxt_.text = arg_40_1:FormatText(StoryNameCfg[1510].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, true)
				arg_40_1.iconController_:SetSelectedState("hero")

				arg_40_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10176")

				arg_40_1.callingController_:SetSelectedState("normal")

				arg_40_1.keyicon_.color = Color.New(1, 1, 1)
				arg_40_1.icon_.color = Color.New(1, 1, 1)

				local var_43_14 = arg_40_1:GetWordFromCfg(324781009)
				local var_43_15 = arg_40_1:FormatText(var_43_14.content)

				arg_40_1.text_.text = var_43_15

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_17 = 32 <= 0 and var_43_13 or var_43_13 * (utf8.len(var_43_15) / 32)

				if (32 <= 0 and var_43_13 or var_43_13 * (utf8.len(var_43_15) / 32)) > 0 and var_43_13 < var_43_17 then
					arg_40_1.talkMaxDuration = var_43_17

					if var_43_17 + var_43_12 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_17 + var_43_12
					end
				end

				arg_40_1.text_.text = var_43_15
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324781", "324781009", "story_v_out_324781.awb") ~= 0 then
					local var_43_18 = manager.audio:GetVoiceLength("story_v_out_324781", "324781009", "story_v_out_324781.awb") / 1000

					if var_43_18 + var_43_12 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_18 + var_43_12
					end

					if var_43_14.prefab_name ~= "" and arg_40_1.actors_[var_43_14.prefab_name] ~= nil then
						local var_43_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_14.prefab_name].transform, "story_v_out_324781", "324781009", "story_v_out_324781.awb")

						arg_40_1:RecordAudio("324781009", var_43_19)
						arg_40_1:RecordAudio("324781009", var_43_19)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_324781", "324781009", "story_v_out_324781.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_324781", "324781009", "story_v_out_324781.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_20 = math.max(var_43_13, arg_40_1.talkMaxDuration)

			if var_43_12 <= arg_40_1.time_ and arg_40_1.time_ < var_43_12 + var_43_20 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_12) / var_43_20

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_12 + var_43_20 and arg_40_1.time_ < var_43_12 + var_43_20 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {
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

		arg_40_1:InitPlayNodeList()
	end,
	Play324781010 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 324781010
		arg_44_1.duration_ = 8.93

		local var_44_0 = {
			zh = 7.566,
			ja = 8.933
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
				arg_44_0:Play324781011(arg_44_1)
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

			local var_47_2 = arg_44_1.actors_["1132ui_story"]

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 and not isNil(var_47_2) and arg_44_1.var_.characterEffect1132ui_story == nil then
				arg_44_1.var_.characterEffect1132ui_story = var_47_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_3 = 0.200000002980232

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_3 and not isNil(var_47_2) then
				if arg_44_1.var_.characterEffect1132ui_story and not isNil(var_47_2) then
					arg_44_1.var_.characterEffect1132ui_story.fillFlat = true
					arg_44_1.var_.characterEffect1132ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_44_1.time_ - 0) / var_47_3)
				end
			end

			if arg_44_1.time_ >= 0 + var_47_3 and arg_44_1.time_ < 0 + var_47_3 + arg_47_0 and not isNil(var_47_2) and arg_44_1.var_.characterEffect1132ui_story then
				arg_44_1.var_.characterEffect1132ui_story.fillFlat = true
				arg_44_1.var_.characterEffect1132ui_story.fillRatio = 0.5
			end

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053action/1053action6_1")
			end

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_47_4 = 0
			local var_47_5 = 0.75

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

				local var_47_6 = arg_44_1:GetWordFromCfg(324781010)
				local var_47_7 = arg_44_1:FormatText(var_47_6.content)

				arg_44_1.text_.text = var_47_7

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_9 = 30 <= 0 and var_47_5 or var_47_5 * (utf8.len(var_47_7) / 30)

				if (30 <= 0 and var_47_5 or var_47_5 * (utf8.len(var_47_7) / 30)) > 0 and var_47_5 < var_47_9 then
					arg_44_1.talkMaxDuration = var_47_9

					if var_47_9 + var_47_4 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_9 + var_47_4
					end
				end

				arg_44_1.text_.text = var_47_7
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324781", "324781010", "story_v_out_324781.awb") ~= 0 then
					local var_47_10 = manager.audio:GetVoiceLength("story_v_out_324781", "324781010", "story_v_out_324781.awb") / 1000

					if var_47_10 + var_47_4 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_10 + var_47_4
					end

					if var_47_6.prefab_name ~= "" and arg_44_1.actors_[var_47_6.prefab_name] ~= nil then
						local var_47_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_6.prefab_name].transform, "story_v_out_324781", "324781010", "story_v_out_324781.awb")

						arg_44_1:RecordAudio("324781010", var_47_11)
						arg_44_1:RecordAudio("324781010", var_47_11)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_324781", "324781010", "story_v_out_324781.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_324781", "324781010", "story_v_out_324781.awb")
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
	Play324781011 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 324781011
		arg_48_1.duration_ = 2.7

		local var_48_0 = {
			zh = 2.7,
			ja = 1.566
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
				arg_48_0:Play324781012(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 and not isNil(arg_48_1.actors_["1132ui_story"]) and arg_48_1.var_.characterEffect1132ui_story == nil then
				arg_48_1.var_.characterEffect1132ui_story = arg_48_1.actors_["1132ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_0 = 0.200000002980232

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_0 and not isNil(arg_48_1.actors_["1132ui_story"]) then
				if arg_48_1.var_.characterEffect1132ui_story and not isNil(arg_48_1.actors_["1132ui_story"]) then
					arg_48_1.var_.characterEffect1132ui_story.fillFlat = false
				end
			end

			if arg_48_1.time_ >= 0 + var_51_0 and arg_48_1.time_ < 0 + var_51_0 + arg_51_0 and not isNil(arg_48_1.actors_["1132ui_story"]) and arg_48_1.var_.characterEffect1132ui_story then
				arg_48_1.var_.characterEffect1132ui_story.fillFlat = false
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
			local var_51_5 = 0.3

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_4 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				arg_48_1.leftNameTxt_.text = arg_48_1:FormatText(StoryNameCfg[1510].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, true)
				arg_48_1.iconController_:SetSelectedState("hero")

				arg_48_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10176")

				arg_48_1.callingController_:SetSelectedState("normal")

				arg_48_1.keyicon_.color = Color.New(1, 1, 1)
				arg_48_1.icon_.color = Color.New(1, 1, 1)

				local var_51_6 = arg_48_1:GetWordFromCfg(324781011)
				local var_51_7 = arg_48_1:FormatText(var_51_6.content)

				arg_48_1.text_.text = var_51_7

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_9 = 12 <= 0 and var_51_5 or var_51_5 * (utf8.len(var_51_7) / 12)

				if (12 <= 0 and var_51_5 or var_51_5 * (utf8.len(var_51_7) / 12)) > 0 and var_51_5 < var_51_9 then
					arg_48_1.talkMaxDuration = var_51_9

					if var_51_9 + var_51_4 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_9 + var_51_4
					end
				end

				arg_48_1.text_.text = var_51_7
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324781", "324781011", "story_v_out_324781.awb") ~= 0 then
					local var_51_10 = manager.audio:GetVoiceLength("story_v_out_324781", "324781011", "story_v_out_324781.awb") / 1000

					if var_51_10 + var_51_4 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_10 + var_51_4
					end

					if var_51_6.prefab_name ~= "" and arg_48_1.actors_[var_51_6.prefab_name] ~= nil then
						local var_51_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_6.prefab_name].transform, "story_v_out_324781", "324781011", "story_v_out_324781.awb")

						arg_48_1:RecordAudio("324781011", var_51_11)
						arg_48_1:RecordAudio("324781011", var_51_11)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_324781", "324781011", "story_v_out_324781.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_324781", "324781011", "story_v_out_324781.awb")
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
	Play324781012 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 324781012
		arg_52_1.duration_ = 3.8

		local var_52_0 = {
			zh = 2.933,
			ja = 3.8
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
				arg_52_0:Play324781013(arg_52_1)
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

			local var_55_2 = arg_52_1.actors_["1132ui_story"]

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 and not isNil(var_55_2) and arg_52_1.var_.characterEffect1132ui_story == nil then
				arg_52_1.var_.characterEffect1132ui_story = var_55_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_3 = 0.200000002980232

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_3 and not isNil(var_55_2) then
				if arg_52_1.var_.characterEffect1132ui_story and not isNil(var_55_2) then
					arg_52_1.var_.characterEffect1132ui_story.fillFlat = true
					arg_52_1.var_.characterEffect1132ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_52_1.time_ - 0) / var_55_3)
				end
			end

			if arg_52_1.time_ >= 0 + var_55_3 and arg_52_1.time_ < 0 + var_55_3 + arg_55_0 and not isNil(var_55_2) and arg_52_1.var_.characterEffect1132ui_story then
				arg_52_1.var_.characterEffect1132ui_story.fillFlat = true
				arg_52_1.var_.characterEffect1132ui_story.fillRatio = 0.5
			end

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053action/1053action6_2")
			end

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_55_4 = 0
			local var_55_5 = 0.225

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

				local var_55_6 = arg_52_1:GetWordFromCfg(324781012)
				local var_55_7 = arg_52_1:FormatText(var_55_6.content)

				arg_52_1.text_.text = var_55_7

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_9 = 9 <= 0 and var_55_5 or var_55_5 * (utf8.len(var_55_7) / 9)

				if (9 <= 0 and var_55_5 or var_55_5 * (utf8.len(var_55_7) / 9)) > 0 and var_55_5 < var_55_9 then
					arg_52_1.talkMaxDuration = var_55_9

					if var_55_9 + var_55_4 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_9 + var_55_4
					end
				end

				arg_52_1.text_.text = var_55_7
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324781", "324781012", "story_v_out_324781.awb") ~= 0 then
					local var_55_10 = manager.audio:GetVoiceLength("story_v_out_324781", "324781012", "story_v_out_324781.awb") / 1000

					if var_55_10 + var_55_4 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_10 + var_55_4
					end

					if var_55_6.prefab_name ~= "" and arg_52_1.actors_[var_55_6.prefab_name] ~= nil then
						local var_55_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_6.prefab_name].transform, "story_v_out_324781", "324781012", "story_v_out_324781.awb")

						arg_52_1:RecordAudio("324781012", var_55_11)
						arg_52_1:RecordAudio("324781012", var_55_11)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_324781", "324781012", "story_v_out_324781.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_324781", "324781012", "story_v_out_324781.awb")
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
	Play324781013 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 324781013
		arg_56_1.duration_ = 8

		local var_56_0 = {
			zh = 5.133,
			ja = 8
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
				arg_56_0:Play324781014(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 and not isNil(arg_56_1.actors_["1132ui_story"]) and arg_56_1.var_.characterEffect1132ui_story == nil then
				arg_56_1.var_.characterEffect1132ui_story = arg_56_1.actors_["1132ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_0 = 0.200000002980232

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_0 and not isNil(arg_56_1.actors_["1132ui_story"]) then
				if arg_56_1.var_.characterEffect1132ui_story and not isNil(arg_56_1.actors_["1132ui_story"]) then
					arg_56_1.var_.characterEffect1132ui_story.fillFlat = false
				end
			end

			if arg_56_1.time_ >= 0 + var_59_0 and arg_56_1.time_ < 0 + var_59_0 + arg_59_0 and not isNil(arg_56_1.actors_["1132ui_story"]) and arg_56_1.var_.characterEffect1132ui_story then
				arg_56_1.var_.characterEffect1132ui_story.fillFlat = false
			end

			local var_59_2 = arg_56_1.actors_["1053ui_story"]

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 and not isNil(var_59_2) and arg_56_1.var_.characterEffect1053ui_story == nil then
				arg_56_1.var_.characterEffect1053ui_story = var_59_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_3 = 0.200000002980232

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_3 and not isNil(var_59_2) then
				if arg_56_1.var_.characterEffect1053ui_story and not isNil(var_59_2) then
					arg_56_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_56_1.var_.characterEffect1053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_56_1.time_ - 0) / var_59_3)
				end
			end

			if arg_56_1.time_ >= 0 + var_59_3 and arg_56_1.time_ < 0 + var_59_3 + arg_59_0 and not isNil(var_59_2) and arg_56_1.var_.characterEffect1053ui_story then
				arg_56_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_56_1.var_.characterEffect1053ui_story.fillRatio = 0.5
			end

			local var_59_4 = 0
			local var_59_5 = 0.525

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_4 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				arg_56_1.leftNameTxt_.text = arg_56_1:FormatText(StoryNameCfg[1510].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, true)
				arg_56_1.iconController_:SetSelectedState("hero")

				arg_56_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10176")

				arg_56_1.callingController_:SetSelectedState("normal")

				arg_56_1.keyicon_.color = Color.New(1, 1, 1)
				arg_56_1.icon_.color = Color.New(1, 1, 1)

				local var_59_6 = arg_56_1:GetWordFromCfg(324781013)
				local var_59_7 = arg_56_1:FormatText(var_59_6.content)

				arg_56_1.text_.text = var_59_7

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_9 = 21 <= 0 and var_59_5 or var_59_5 * (utf8.len(var_59_7) / 21)

				if (21 <= 0 and var_59_5 or var_59_5 * (utf8.len(var_59_7) / 21)) > 0 and var_59_5 < var_59_9 then
					arg_56_1.talkMaxDuration = var_59_9

					if var_59_9 + var_59_4 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_9 + var_59_4
					end
				end

				arg_56_1.text_.text = var_59_7
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324781", "324781013", "story_v_out_324781.awb") ~= 0 then
					local var_59_10 = manager.audio:GetVoiceLength("story_v_out_324781", "324781013", "story_v_out_324781.awb") / 1000

					if var_59_10 + var_59_4 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_10 + var_59_4
					end

					if var_59_6.prefab_name ~= "" and arg_56_1.actors_[var_59_6.prefab_name] ~= nil then
						local var_59_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_6.prefab_name].transform, "story_v_out_324781", "324781013", "story_v_out_324781.awb")

						arg_56_1:RecordAudio("324781013", var_59_11)
						arg_56_1:RecordAudio("324781013", var_59_11)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_324781", "324781013", "story_v_out_324781.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_324781", "324781013", "story_v_out_324781.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_12 = math.max(var_59_5, arg_56_1.talkMaxDuration)

			if var_59_4 <= arg_56_1.time_ and arg_56_1.time_ < var_59_4 + var_59_12 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_4) / var_59_12

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_4 + var_59_12 and arg_56_1.time_ < var_59_4 + var_59_12 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play324781014 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 324781014
		arg_60_1.duration_ = 8.33

		local var_60_0 = {
			zh = 8.333,
			ja = 8.033
		}
		local var_60_1 = manager.audio:GetLocalizationFlag()

		if var_60_0[var_60_1] ~= nil then
			arg_60_1.duration_ = var_60_0[var_60_1]
		end

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play324781015(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = 0.775

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				arg_60_1.leftNameTxt_.text = arg_60_1:FormatText(StoryNameCfg[1510].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, true)
				arg_60_1.iconController_:SetSelectedState("hero")

				arg_60_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10176")

				arg_60_1.callingController_:SetSelectedState("normal")

				arg_60_1.keyicon_.color = Color.New(1, 1, 1)
				arg_60_1.icon_.color = Color.New(1, 1, 1)

				local var_63_1 = arg_60_1:GetWordFromCfg(324781014)
				local var_63_2 = arg_60_1:FormatText(var_63_1.content)

				arg_60_1.text_.text = var_63_2

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_4 = 31 <= 0 and var_63_0 or var_63_0 * (utf8.len(var_63_2) / 31)

				if (31 <= 0 and var_63_0 or var_63_0 * (utf8.len(var_63_2) / 31)) > 0 and var_63_0 < var_63_4 then
					arg_60_1.talkMaxDuration = var_63_4

					if var_63_4 + 0 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_4 + 0
					end
				end

				arg_60_1.text_.text = var_63_2
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324781", "324781014", "story_v_out_324781.awb") ~= 0 then
					local var_63_5 = manager.audio:GetVoiceLength("story_v_out_324781", "324781014", "story_v_out_324781.awb") / 1000

					if var_63_5 + 0 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_5 + 0
					end

					if var_63_1.prefab_name ~= "" and arg_60_1.actors_[var_63_1.prefab_name] ~= nil then
						local var_63_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_1.prefab_name].transform, "story_v_out_324781", "324781014", "story_v_out_324781.awb")

						arg_60_1:RecordAudio("324781014", var_63_6)
						arg_60_1:RecordAudio("324781014", var_63_6)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_324781", "324781014", "story_v_out_324781.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_324781", "324781014", "story_v_out_324781.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_7 = math.max(var_63_0, arg_60_1.talkMaxDuration)

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_7 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - 0) / var_63_7

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= 0 + var_63_7 and arg_60_1.time_ < 0 + var_63_7 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play324781015 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 324781015
		arg_64_1.duration_ = 5.1

		local var_64_0 = {
			zh = 2.7,
			ja = 5.1
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
				arg_64_0:Play324781016(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 and not isNil(arg_64_1.actors_["1053ui_story"]) and arg_64_1.var_.characterEffect1053ui_story == nil then
				arg_64_1.var_.characterEffect1053ui_story = arg_64_1.actors_["1053ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_0 = 0.200000002980232

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_0 and not isNil(arg_64_1.actors_["1053ui_story"]) then
				if arg_64_1.var_.characterEffect1053ui_story and not isNil(arg_64_1.actors_["1053ui_story"]) then
					arg_64_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_64_1.time_ >= 0 + var_67_0 and arg_64_1.time_ < 0 + var_67_0 + arg_67_0 and not isNil(arg_64_1.actors_["1053ui_story"]) and arg_64_1.var_.characterEffect1053ui_story then
				arg_64_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_67_2 = arg_64_1.actors_["1132ui_story"]

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 and not isNil(var_67_2) and arg_64_1.var_.characterEffect1132ui_story == nil then
				arg_64_1.var_.characterEffect1132ui_story = var_67_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_3 = 0.200000002980232

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_3 and not isNil(var_67_2) then
				if arg_64_1.var_.characterEffect1132ui_story and not isNil(var_67_2) then
					arg_64_1.var_.characterEffect1132ui_story.fillFlat = true
					arg_64_1.var_.characterEffect1132ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_64_1.time_ - 0) / var_67_3)
				end
			end

			if arg_64_1.time_ >= 0 + var_67_3 and arg_64_1.time_ < 0 + var_67_3 + arg_67_0 and not isNil(var_67_2) and arg_64_1.var_.characterEffect1132ui_story then
				arg_64_1.var_.characterEffect1132ui_story.fillFlat = true
				arg_64_1.var_.characterEffect1132ui_story.fillRatio = 0.5
			end

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053action/1053action5_1")
			end

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_67_4 = 0
			local var_67_5 = 0.275

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= var_67_4 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				arg_64_1.leftNameTxt_.text = arg_64_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_6 = arg_64_1:GetWordFromCfg(324781015)
				local var_67_7 = arg_64_1:FormatText(var_67_6.content)

				arg_64_1.text_.text = var_67_7

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_9 = 11 <= 0 and var_67_5 or var_67_5 * (utf8.len(var_67_7) / 11)

				if (11 <= 0 and var_67_5 or var_67_5 * (utf8.len(var_67_7) / 11)) > 0 and var_67_5 < var_67_9 then
					arg_64_1.talkMaxDuration = var_67_9

					if var_67_9 + var_67_4 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_9 + var_67_4
					end
				end

				arg_64_1.text_.text = var_67_7
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324781", "324781015", "story_v_out_324781.awb") ~= 0 then
					local var_67_10 = manager.audio:GetVoiceLength("story_v_out_324781", "324781015", "story_v_out_324781.awb") / 1000

					if var_67_10 + var_67_4 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_10 + var_67_4
					end

					if var_67_6.prefab_name ~= "" and arg_64_1.actors_[var_67_6.prefab_name] ~= nil then
						local var_67_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_6.prefab_name].transform, "story_v_out_324781", "324781015", "story_v_out_324781.awb")

						arg_64_1:RecordAudio("324781015", var_67_11)
						arg_64_1:RecordAudio("324781015", var_67_11)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_324781", "324781015", "story_v_out_324781.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_324781", "324781015", "story_v_out_324781.awb")
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
	Play324781016 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 324781016
		arg_68_1.duration_ = 6.6

		local var_68_0 = {
			zh = 2.366,
			ja = 6.6
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
				arg_68_0:Play324781017(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 and not isNil(arg_68_1.actors_["1132ui_story"]) and arg_68_1.var_.characterEffect1132ui_story == nil then
				arg_68_1.var_.characterEffect1132ui_story = arg_68_1.actors_["1132ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_0 = 0.200000002980232

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_0 and not isNil(arg_68_1.actors_["1132ui_story"]) then
				if arg_68_1.var_.characterEffect1132ui_story and not isNil(arg_68_1.actors_["1132ui_story"]) then
					arg_68_1.var_.characterEffect1132ui_story.fillFlat = false
				end
			end

			if arg_68_1.time_ >= 0 + var_71_0 and arg_68_1.time_ < 0 + var_71_0 + arg_71_0 and not isNil(arg_68_1.actors_["1132ui_story"]) and arg_68_1.var_.characterEffect1132ui_story then
				arg_68_1.var_.characterEffect1132ui_story.fillFlat = false
			end

			local var_71_2 = arg_68_1.actors_["1053ui_story"]

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 and not isNil(var_71_2) and arg_68_1.var_.characterEffect1053ui_story == nil then
				arg_68_1.var_.characterEffect1053ui_story = var_71_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_3 = 0.200000002980232

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_3 and not isNil(var_71_2) then
				if arg_68_1.var_.characterEffect1053ui_story and not isNil(var_71_2) then
					arg_68_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_68_1.var_.characterEffect1053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_68_1.time_ - 0) / var_71_3)
				end
			end

			if arg_68_1.time_ >= 0 + var_71_3 and arg_68_1.time_ < 0 + var_71_3 + arg_71_0 and not isNil(var_71_2) and arg_68_1.var_.characterEffect1053ui_story then
				arg_68_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_68_1.var_.characterEffect1053ui_story.fillRatio = 0.5
			end

			local var_71_4 = 0
			local var_71_5 = 0.25

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= var_71_4 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				arg_68_1.leftNameTxt_.text = arg_68_1:FormatText(StoryNameCfg[1510].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, true)
				arg_68_1.iconController_:SetSelectedState("hero")

				arg_68_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10176")

				arg_68_1.callingController_:SetSelectedState("normal")

				arg_68_1.keyicon_.color = Color.New(1, 1, 1)
				arg_68_1.icon_.color = Color.New(1, 1, 1)

				local var_71_6 = arg_68_1:GetWordFromCfg(324781016)
				local var_71_7 = arg_68_1:FormatText(var_71_6.content)

				arg_68_1.text_.text = var_71_7

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_9 = 10 <= 0 and var_71_5 or var_71_5 * (utf8.len(var_71_7) / 10)

				if (10 <= 0 and var_71_5 or var_71_5 * (utf8.len(var_71_7) / 10)) > 0 and var_71_5 < var_71_9 then
					arg_68_1.talkMaxDuration = var_71_9

					if var_71_9 + var_71_4 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_9 + var_71_4
					end
				end

				arg_68_1.text_.text = var_71_7
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324781", "324781016", "story_v_out_324781.awb") ~= 0 then
					local var_71_10 = manager.audio:GetVoiceLength("story_v_out_324781", "324781016", "story_v_out_324781.awb") / 1000

					if var_71_10 + var_71_4 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_10 + var_71_4
					end

					if var_71_6.prefab_name ~= "" and arg_68_1.actors_[var_71_6.prefab_name] ~= nil then
						local var_71_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_6.prefab_name].transform, "story_v_out_324781", "324781016", "story_v_out_324781.awb")

						arg_68_1:RecordAudio("324781016", var_71_11)
						arg_68_1:RecordAudio("324781016", var_71_11)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_324781", "324781016", "story_v_out_324781.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_324781", "324781016", "story_v_out_324781.awb")
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
	Play324781017 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 324781017
		arg_72_1.duration_ = 9.77

		local var_72_0 = {
			zh = 6.833,
			ja = 9.766
		}
		local var_72_1 = manager.audio:GetLocalizationFlag()

		if var_72_0[var_72_1] ~= nil then
			arg_72_1.duration_ = var_72_0[var_72_1]
		end

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play324781018(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 and not isNil(arg_72_1.actors_["1053ui_story"]) and arg_72_1.var_.characterEffect1053ui_story == nil then
				arg_72_1.var_.characterEffect1053ui_story = arg_72_1.actors_["1053ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_0 = 0.200000002980232

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_0 and not isNil(arg_72_1.actors_["1053ui_story"]) then
				if arg_72_1.var_.characterEffect1053ui_story and not isNil(arg_72_1.actors_["1053ui_story"]) then
					arg_72_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_72_1.time_ >= 0 + var_75_0 and arg_72_1.time_ < 0 + var_75_0 + arg_75_0 and not isNil(arg_72_1.actors_["1053ui_story"]) and arg_72_1.var_.characterEffect1053ui_story then
				arg_72_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_75_2 = arg_72_1.actors_["1132ui_story"]

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 and not isNil(var_75_2) and arg_72_1.var_.characterEffect1132ui_story == nil then
				arg_72_1.var_.characterEffect1132ui_story = var_75_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_3 = 0.200000002980232

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_3 and not isNil(var_75_2) then
				if arg_72_1.var_.characterEffect1132ui_story and not isNil(var_75_2) then
					arg_72_1.var_.characterEffect1132ui_story.fillFlat = true
					arg_72_1.var_.characterEffect1132ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_72_1.time_ - 0) / var_75_3)
				end
			end

			if arg_72_1.time_ >= 0 + var_75_3 and arg_72_1.time_ < 0 + var_75_3 + arg_75_0 and not isNil(var_75_2) and arg_72_1.var_.characterEffect1132ui_story then
				arg_72_1.var_.characterEffect1132ui_story.fillFlat = true
				arg_72_1.var_.characterEffect1132ui_story.fillRatio = 0.5
			end

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053action/1053action5_2")
			end

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_75_4 = 0
			local var_75_5 = 0.625

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= var_75_4 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				arg_72_1.leftNameTxt_.text = arg_72_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_6 = arg_72_1:GetWordFromCfg(324781017)
				local var_75_7 = arg_72_1:FormatText(var_75_6.content)

				arg_72_1.text_.text = var_75_7

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_9 = 25 <= 0 and var_75_5 or var_75_5 * (utf8.len(var_75_7) / 25)

				if (25 <= 0 and var_75_5 or var_75_5 * (utf8.len(var_75_7) / 25)) > 0 and var_75_5 < var_75_9 then
					arg_72_1.talkMaxDuration = var_75_9

					if var_75_9 + var_75_4 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_9 + var_75_4
					end
				end

				arg_72_1.text_.text = var_75_7
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324781", "324781017", "story_v_out_324781.awb") ~= 0 then
					local var_75_10 = manager.audio:GetVoiceLength("story_v_out_324781", "324781017", "story_v_out_324781.awb") / 1000

					if var_75_10 + var_75_4 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_10 + var_75_4
					end

					if var_75_6.prefab_name ~= "" and arg_72_1.actors_[var_75_6.prefab_name] ~= nil then
						local var_75_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_6.prefab_name].transform, "story_v_out_324781", "324781017", "story_v_out_324781.awb")

						arg_72_1:RecordAudio("324781017", var_75_11)
						arg_72_1:RecordAudio("324781017", var_75_11)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_324781", "324781017", "story_v_out_324781.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_324781", "324781017", "story_v_out_324781.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_12 = math.max(var_75_5, arg_72_1.talkMaxDuration)

			if var_75_4 <= arg_72_1.time_ and arg_72_1.time_ < var_75_4 + var_75_12 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_4) / var_75_12

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_4 + var_75_12 and arg_72_1.time_ < var_75_4 + var_75_12 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {}

		arg_72_1:InitPlayNodeList()
	end,
	Play324781018 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 324781018
		arg_76_1.duration_ = 8.77

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play324781019(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			if 2 < arg_76_1.time_ and arg_76_1.time_ <= 2 + arg_79_0 then
				local var_79_0 = arg_76_1.bgs_.ST2007

				arg_76_1.bgs_.ST2007.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_79_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_79_1 = var_79_0:GetComponent("SpriteRenderer")

				if var_79_1 and var_79_1.sprite then
					local var_79_2 = 2 * (var_79_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_79_0.transform.localScale = Vector3.New(var_79_2 / var_79_1.sprite.bounds.size.y < var_79_2 * manager.ui.mainCameraCom_.aspect / var_79_1.sprite.bounds.size.x and var_79_2 * manager.ui.mainCameraCom_.aspect / var_79_1.sprite.bounds.size.x or var_79_2 / var_79_1.sprite.bounds.size.y, var_79_2 / var_79_1.sprite.bounds.size.y < var_79_2 * manager.ui.mainCameraCom_.aspect / var_79_1.sprite.bounds.size.x and var_79_2 * manager.ui.mainCameraCom_.aspect / var_79_1.sprite.bounds.size.x or var_79_2 / var_79_1.sprite.bounds.size.y, 0)
				end

				for iter_79_0, iter_79_1 in pairs(arg_76_1.bgs_) do
					if iter_79_0 ~= "ST2007" then
						iter_79_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_79_3 = 3.999999999999

			if 3.999999999999 < arg_76_1.time_ and arg_76_1.time_ <= var_79_3 + arg_79_0 then
				arg_76_1.allBtn_.enabled = false
			end

			if arg_76_1.time_ >= var_79_3 + 0.3 and arg_76_1.time_ < var_79_3 + 0.3 + arg_79_0 then
				arg_76_1.allBtn_.enabled = true
			end

			local var_79_4 = 0

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= var_79_4 + arg_79_0 then
				arg_76_1.mask_.enabled = true
				arg_76_1.mask_.raycastTarget = true

				arg_76_1:SetGaussion(false)
			end

			local var_79_5 = 2

			if var_79_4 <= arg_76_1.time_ and arg_76_1.time_ < var_79_4 + var_79_5 then
				local var_79_6 = Color.New(0, 0, 0)

				var_79_6.a = Mathf.Lerp(0, 1, (arg_76_1.time_ - var_79_4) / var_79_5)
				arg_76_1.mask_.color = var_79_6
			end

			if arg_76_1.time_ >= var_79_4 + var_79_5 and arg_76_1.time_ < var_79_4 + var_79_5 + arg_79_0 then
				local var_79_7 = Color.New(0, 0, 0)

				var_79_7.a = 1
				arg_76_1.mask_.color = var_79_7
			end

			local var_79_8 = 2

			if 2 < arg_76_1.time_ and arg_76_1.time_ <= var_79_8 + arg_79_0 then
				arg_76_1.mask_.enabled = true
				arg_76_1.mask_.raycastTarget = true

				arg_76_1:SetGaussion(false)
			end

			local var_79_9 = 2

			if var_79_8 <= arg_76_1.time_ and arg_76_1.time_ < var_79_8 + var_79_9 then
				local var_79_10 = Color.New(0, 0, 0)

				var_79_10.a = Mathf.Lerp(1, 0, (arg_76_1.time_ - var_79_8) / var_79_9)
				arg_76_1.mask_.color = var_79_10
			end

			if arg_76_1.time_ >= var_79_8 + var_79_9 and arg_76_1.time_ < var_79_8 + var_79_9 + arg_79_0 then
				local var_79_11 = Color.New(0, 0, 0)

				arg_76_1.mask_.enabled = false
				var_79_11.a = 0
				arg_76_1.mask_.color = var_79_11
			end

			local var_79_12 = arg_76_1.actors_["1053ui_story"].transform

			if 1.96599999815226 < arg_76_1.time_ and arg_76_1.time_ <= 1.96599999815226 + arg_79_0 then
				arg_76_1.var_.moveOldPos1053ui_story = var_79_12.localPosition

				local var_79_13 = GameObjectTools.GetOrAddComponent(var_79_12.gameObject, typeof(DynamicBoneHelper))

				if var_79_13 then
					var_79_13:EnableDynamicBone(false)
				end
			end

			local var_79_14 = 0.001

			if 1.96599999815226 <= arg_76_1.time_ and arg_76_1.time_ < 1.96599999815226 + var_79_14 then
				var_79_12.localPosition = Vector3.Lerp(arg_76_1.var_.moveOldPos1053ui_story, Vector3.New(0, 100, 0), (arg_76_1.time_ - 1.96599999815226) / var_79_14)
				var_79_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_79_12.position).x, (manager.ui.mainCamera.transform.position - var_79_12.position).y, (manager.ui.mainCamera.transform.position - var_79_12.position).z)
				var_79_12.localEulerAngles.z = 0
				var_79_12.localEulerAngles.x = 0
				var_79_12.localEulerAngles = var_79_12.localEulerAngles
			end

			if arg_76_1.time_ >= 1.96599999815226 + var_79_14 and arg_76_1.time_ < 1.96599999815226 + var_79_14 + arg_79_0 then
				var_79_12.localPosition = Vector3.New(0, 100, 0)
				var_79_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_79_12.position).x, (manager.ui.mainCamera.transform.position - var_79_12.position).y, (manager.ui.mainCamera.transform.position - var_79_12.position).z)
				var_79_12.localEulerAngles.z = 0
				var_79_12.localEulerAngles.x = 0
				var_79_12.localEulerAngles = var_79_12.localEulerAngles

				local var_79_15 = GameObjectTools.GetOrAddComponent(var_79_12.gameObject, typeof(DynamicBoneHelper))

				if var_79_15 then
					var_79_15:EnableDynamicBone(true)
				end
			end

			local var_79_16 = arg_76_1.actors_["1053ui_story"]

			if 1.79999999701977 < arg_76_1.time_ and arg_76_1.time_ <= 1.79999999701977 + arg_79_0 and not isNil(var_79_16) and arg_76_1.var_.characterEffect1053ui_story == nil then
				arg_76_1.var_.characterEffect1053ui_story = var_79_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_17 = 0.200000002980232

			if 1.79999999701977 <= arg_76_1.time_ and arg_76_1.time_ < 1.79999999701977 + var_79_17 and not isNil(var_79_16) then
				if arg_76_1.var_.characterEffect1053ui_story and not isNil(var_79_16) then
					arg_76_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_76_1.var_.characterEffect1053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_76_1.time_ - 1.79999999701977) / var_79_17)
				end
			end

			if arg_76_1.time_ >= 1.79999999701977 + var_79_17 and arg_76_1.time_ < 1.79999999701977 + var_79_17 + arg_79_0 and not isNil(var_79_16) and arg_76_1.var_.characterEffect1053ui_story then
				arg_76_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_76_1.var_.characterEffect1053ui_story.fillRatio = 0.5
			end

			if 1.2 < arg_76_1.time_ and arg_76_1.time_ <= 1.2 + arg_79_0 then
				arg_76_1:AudioAction("play", "effect", "se_story_birthday4", "se_story_birthday4_amb_room_tone_2", "")
			end

			if 0.1 < arg_76_1.time_ and arg_76_1.time_ <= 0.1 + arg_79_0 then
				arg_76_1:AudioAction("stop", "effect", "se_story_1310", "se_story_1310_amb_winter_loop", "")
			end

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1:AudioAction("play", "effect", "ui_battle", "ui_battle_stopbgm", "")
			end

			if 1 < arg_76_1.time_ and arg_76_1.time_ <= 1 + arg_79_0 then
				arg_76_1:AudioAction("play", "music", "bgm_activity_5_0_story_qiulingong", "bgm_activity_5_0_story_qiulingong", "bgm_activity_5_0_story_qiulingong.awb")

				local var_79_23 = manager.audio:GetAudioName("bgm_activity_5_0_story_qiulingong", "bgm_activity_5_0_story_qiulingong")

				if "" ~= "" then
					if arg_76_1.bgmTxt_.text ~= var_79_23 and arg_76_1.bgmTxt_.text ~= "" then
						if arg_76_1.bgmTxt2_.text ~= "" then
							arg_76_1.bgmTxt_.text = arg_76_1.bgmTxt2_.text
						end

						arg_76_1.bgmTxt2_.text = var_79_23

						arg_76_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_76_1.bgmTxt_.text = var_79_23
						arg_76_1.bgmTxt2_.text = var_79_23
					end

					if arg_76_1.bgmTimer then
						arg_76_1.bgmTimer:Stop()

						arg_76_1.bgmTimer = nil
					end

					if arg_76_1.settingData.show_music_name == 1 then
						arg_76_1.musicController:SetSelectedState("show")
						arg_76_1.musicAnimator_:Play("open", 0, 0)

						if arg_76_1.settingData.music_time ~= 0 then
							arg_76_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_76_1.settingData.music_time), function()
								if arg_76_1 == nil or isNil(arg_76_1.bgmTxt_) then
									return
								end

								arg_76_1.musicController:SetSelectedState("hide")
								arg_76_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_76_1.frameCnt_ <= 1 then
				arg_76_1.dialog_:SetActive(false)
			end

			local var_79_24 = 3.774999999999
			local var_79_25 = 0.525

			if 3.774999999999 < arg_76_1.time_ and arg_76_1.time_ <= var_79_24 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0

				arg_76_1.dialog_:SetActive(true)

				arg_76_1.dialogCg_.alpha = 0

				local var_79_26 = LeanTween.value(arg_76_1.dialog_, 0, 1, 0.3)

				var_79_26:setOnUpdate(LuaHelper.FloatAction(function(arg_81_0)
					arg_76_1.dialogCg_.alpha = arg_81_0
				end))
				var_79_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_76_1.dialog_)
					var_79_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_76_1.duration_ = arg_76_1.duration_ + 0.3

				SetActive(arg_76_1.leftNameGo_, true)

				arg_76_1.leftNameTxt_.text = arg_76_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, true)
				arg_76_1.iconController_:SetSelectedState("hero")

				arg_76_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_76_1.callingController_:SetSelectedState("normal")

				arg_76_1.keyicon_.color = Color.New(1, 1, 1)
				arg_76_1.icon_.color = Color.New(1, 1, 1)

				local var_79_27 = arg_76_1:FormatText(arg_76_1:GetWordFromCfg(324781018).content)

				arg_76_1.text_.text = var_79_27

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_29 = 21 <= 0 and var_79_25 or var_79_25 * (utf8.len(var_79_27) / 21)

				if (21 <= 0 and var_79_25 or var_79_25 * (utf8.len(var_79_27) / 21)) > 0 and var_79_25 < var_79_29 then
					arg_76_1.talkMaxDuration = var_79_29
					var_79_24 = var_79_24 + 0.3

					if var_79_29 + var_79_24 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_29 + var_79_24
					end
				end

				arg_76_1.text_.text = var_79_27
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)
				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_30 = var_79_24 + 0.3
			local var_79_31 = math.max(var_79_25, arg_76_1.talkMaxDuration)

			if var_79_24 + 0.3 <= arg_76_1.time_ and arg_76_1.time_ < var_79_30 + var_79_31 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_30) / var_79_31

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_30 + var_79_31 and arg_76_1.time_ < var_79_30 + var_79_31 + arg_79_0 then
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
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_76_1:InitPlayNodeList()
	end,
	Play324781019 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 324781019
		arg_83_1.duration_ = 2.6

		local var_83_0 = {
			zh = 2.133,
			ja = 2.6
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
				arg_83_0:Play324781020(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 and not isNil(arg_83_1.actors_["1054ui_story"]) and arg_83_1.var_.characterEffect1054ui_story == nil then
				arg_83_1.var_.characterEffect1054ui_story = arg_83_1.actors_["1054ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_86_0 = 0.200000002980232

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_0 and not isNil(arg_83_1.actors_["1054ui_story"]) then
				if arg_83_1.var_.characterEffect1054ui_story and not isNil(arg_83_1.actors_["1054ui_story"]) then
					arg_83_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_83_1.time_ >= 0 + var_86_0 and arg_83_1.time_ < 0 + var_86_0 + arg_86_0 and not isNil(arg_83_1.actors_["1054ui_story"]) and arg_83_1.var_.characterEffect1054ui_story then
				arg_83_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_86_2 = 0
			local var_86_3 = 0.2

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_2 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				arg_83_1.leftNameTxt_.text = arg_83_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, true)
				arg_83_1.iconController_:SetSelectedState("hero")

				arg_83_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1054")

				arg_83_1.callingController_:SetSelectedState("normal")

				arg_83_1.keyicon_.color = Color.New(1, 1, 1)
				arg_83_1.icon_.color = Color.New(1, 1, 1)

				local var_86_4 = arg_83_1:GetWordFromCfg(324781019)
				local var_86_5 = arg_83_1:FormatText(var_86_4.content)

				arg_83_1.text_.text = var_86_5

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_7 = 8 <= 0 and var_86_3 or var_86_3 * (utf8.len(var_86_5) / 8)

				if (8 <= 0 and var_86_3 or var_86_3 * (utf8.len(var_86_5) / 8)) > 0 and var_86_3 < var_86_7 then
					arg_83_1.talkMaxDuration = var_86_7

					if var_86_7 + var_86_2 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_7 + var_86_2
					end
				end

				arg_83_1.text_.text = var_86_5
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324781", "324781019", "story_v_out_324781.awb") ~= 0 then
					local var_86_8 = manager.audio:GetVoiceLength("story_v_out_324781", "324781019", "story_v_out_324781.awb") / 1000

					if var_86_8 + var_86_2 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_8 + var_86_2
					end

					if var_86_4.prefab_name ~= "" and arg_83_1.actors_[var_86_4.prefab_name] ~= nil then
						local var_86_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_4.prefab_name].transform, "story_v_out_324781", "324781019", "story_v_out_324781.awb")

						arg_83_1:RecordAudio("324781019", var_86_9)
						arg_83_1:RecordAudio("324781019", var_86_9)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_out_324781", "324781019", "story_v_out_324781.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_out_324781", "324781019", "story_v_out_324781.awb")
				end

				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_10 = math.max(var_86_3, arg_83_1.talkMaxDuration)

			if var_86_2 <= arg_83_1.time_ and arg_83_1.time_ < var_86_2 + var_86_10 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_2) / var_86_10

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_2 + var_86_10 and arg_83_1.time_ < var_86_2 + var_86_10 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play324781020 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 324781020
		arg_87_1.duration_ = 5

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play324781021(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 and not isNil(arg_87_1.actors_["1054ui_story"]) and arg_87_1.var_.characterEffect1054ui_story == nil then
				arg_87_1.var_.characterEffect1054ui_story = arg_87_1.actors_["1054ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_0 = 0.200000002980232

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_0 and not isNil(arg_87_1.actors_["1054ui_story"]) then
				if arg_87_1.var_.characterEffect1054ui_story and not isNil(arg_87_1.actors_["1054ui_story"]) then
					arg_87_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_87_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_87_1.time_ - 0) / var_90_0)
				end
			end

			if arg_87_1.time_ >= 0 + var_90_0 and arg_87_1.time_ < 0 + var_90_0 + arg_90_0 and not isNil(arg_87_1.actors_["1054ui_story"]) and arg_87_1.var_.characterEffect1054ui_story then
				arg_87_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_87_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			local var_90_1 = 0
			local var_90_2 = 1.025

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_1 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, false)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_3 = arg_87_1:FormatText(arg_87_1:GetWordFromCfg(324781020).content)

				arg_87_1.text_.text = var_90_3

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_5 = 41 <= 0 and var_90_2 or var_90_2 * (utf8.len(var_90_3) / 41)

				if (41 <= 0 and var_90_2 or var_90_2 * (utf8.len(var_90_3) / 41)) > 0 and var_90_2 < var_90_5 then
					arg_87_1.talkMaxDuration = var_90_5

					if var_90_5 + var_90_1 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_5 + var_90_1
					end
				end

				arg_87_1.text_.text = var_90_3
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)
				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_6 = math.max(var_90_2, arg_87_1.talkMaxDuration)

			if var_90_1 <= arg_87_1.time_ and arg_87_1.time_ < var_90_1 + var_90_6 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_1) / var_90_6

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_1 + var_90_6 and arg_87_1.time_ < var_90_1 + var_90_6 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {}

		arg_87_1:InitPlayNodeList()
	end,
	Play324781021 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 324781021
		arg_91_1.duration_ = 6.43

		local var_91_0 = {
			zh = 4.733,
			ja = 6.433
		}
		local var_91_1 = manager.audio:GetLocalizationFlag()

		if var_91_0[var_91_1] ~= nil then
			arg_91_1.duration_ = var_91_0[var_91_1]
		end

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play324781022(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1.var_.moveOldPos1053ui_story = arg_91_1.actors_["1053ui_story"].transform.localPosition

				local var_94_0 = GameObjectTools.GetOrAddComponent(arg_91_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_94_0 then
					var_94_0:EnableDynamicBone(false)
				end
			end

			local var_94_1 = 0.001

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_1 then
				arg_91_1.actors_["1053ui_story"].transform.localPosition = Vector3.Lerp(arg_91_1.var_.moveOldPos1053ui_story, Vector3.New(-0.7, -1.08, -6), (arg_91_1.time_ - 0) / var_94_1)
				arg_91_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_91_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_91_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_91_1.actors_["1053ui_story"].transform.position).z)
				arg_91_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_91_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_91_1.actors_["1053ui_story"].transform.localEulerAngles = arg_91_1.actors_["1053ui_story"].transform.localEulerAngles
			end

			if arg_91_1.time_ >= 0 + var_94_1 and arg_91_1.time_ < 0 + var_94_1 + arg_94_0 then
				arg_91_1.actors_["1053ui_story"].transform.localPosition = Vector3.New(-0.7, -1.08, -6)
				arg_91_1.actors_["1053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_91_1.actors_["1053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_91_1.actors_["1053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_91_1.actors_["1053ui_story"].transform.position).z)
				arg_91_1.actors_["1053ui_story"].transform.localEulerAngles.z = 0
				arg_91_1.actors_["1053ui_story"].transform.localEulerAngles.x = 0
				arg_91_1.actors_["1053ui_story"].transform.localEulerAngles = arg_91_1.actors_["1053ui_story"].transform.localEulerAngles

				local var_94_2 = GameObjectTools.GetOrAddComponent(arg_91_1.actors_["1053ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_94_2 then
					var_94_2:EnableDynamicBone(true)
				end
			end

			local var_94_3 = arg_91_1.actors_["1053ui_story"]

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 and not isNil(var_94_3) and arg_91_1.var_.characterEffect1053ui_story == nil then
				arg_91_1.var_.characterEffect1053ui_story = var_94_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_94_4 = 0.200000002980232

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_4 and not isNil(var_94_3) then
				if arg_91_1.var_.characterEffect1053ui_story and not isNil(var_94_3) then
					arg_91_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_91_1.time_ >= 0 + var_94_4 and arg_91_1.time_ < 0 + var_94_4 + arg_94_0 and not isNil(var_94_3) and arg_91_1.var_.characterEffect1053ui_story then
				arg_91_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053action/1053action7_1")
			end

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_94_6 = 0
			local var_94_7 = 0.4

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= var_94_6 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				arg_91_1.leftNameTxt_.text = arg_91_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_8 = arg_91_1:GetWordFromCfg(324781021)
				local var_94_9 = arg_91_1:FormatText(var_94_8.content)

				arg_91_1.text_.text = var_94_9

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_11 = 16 <= 0 and var_94_7 or var_94_7 * (utf8.len(var_94_9) / 16)

				if (16 <= 0 and var_94_7 or var_94_7 * (utf8.len(var_94_9) / 16)) > 0 and var_94_7 < var_94_11 then
					arg_91_1.talkMaxDuration = var_94_11

					if var_94_11 + var_94_6 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_11 + var_94_6
					end
				end

				arg_91_1.text_.text = var_94_9
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324781", "324781021", "story_v_out_324781.awb") ~= 0 then
					local var_94_12 = manager.audio:GetVoiceLength("story_v_out_324781", "324781021", "story_v_out_324781.awb") / 1000

					if var_94_12 + var_94_6 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_12 + var_94_6
					end

					if var_94_8.prefab_name ~= "" and arg_91_1.actors_[var_94_8.prefab_name] ~= nil then
						local var_94_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_8.prefab_name].transform, "story_v_out_324781", "324781021", "story_v_out_324781.awb")

						arg_91_1:RecordAudio("324781021", var_94_13)
						arg_91_1:RecordAudio("324781021", var_94_13)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_out_324781", "324781021", "story_v_out_324781.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_out_324781", "324781021", "story_v_out_324781.awb")
				end

				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_14 = math.max(var_94_7, arg_91_1.talkMaxDuration)

			if var_94_6 <= arg_91_1.time_ and arg_91_1.time_ < var_94_6 + var_94_14 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_6) / var_94_14

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_6 + var_94_14 and arg_91_1.time_ < var_94_6 + var_94_14 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {
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

		arg_91_1:InitPlayNodeList()
	end,
	Play324781022 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 324781022
		arg_95_1.duration_ = 5.8

		local var_95_0 = {
			zh = 4.966,
			ja = 5.8
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
				arg_95_0:Play324781023(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 and not isNil(arg_95_1.actors_["1053ui_story"]) and arg_95_1.var_.characterEffect1053ui_story == nil then
				arg_95_1.var_.characterEffect1053ui_story = arg_95_1.actors_["1053ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_98_0 = 0.200000002980232

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_0 and not isNil(arg_95_1.actors_["1053ui_story"]) then
				if arg_95_1.var_.characterEffect1053ui_story and not isNil(arg_95_1.actors_["1053ui_story"]) then
					arg_95_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_95_1.var_.characterEffect1053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_95_1.time_ - 0) / var_98_0)
				end
			end

			if arg_95_1.time_ >= 0 + var_98_0 and arg_95_1.time_ < 0 + var_98_0 + arg_98_0 and not isNil(arg_95_1.actors_["1053ui_story"]) and arg_95_1.var_.characterEffect1053ui_story then
				arg_95_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_95_1.var_.characterEffect1053ui_story.fillRatio = 0.5
			end

			local var_98_1 = arg_95_1.actors_["6148ui_story"].transform

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1.var_.moveOldPos6148ui_story = var_98_1.localPosition

				local var_98_2 = GameObjectTools.GetOrAddComponent(var_98_1.gameObject, typeof(DynamicBoneHelper))

				if var_98_2 then
					var_98_2:EnableDynamicBone(false)
				end
			end

			local var_98_3 = 0.001

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_3 then
				var_98_1.localPosition = Vector3.Lerp(arg_95_1.var_.moveOldPos6148ui_story, Vector3.New(0.7, -0.985, -6), (arg_95_1.time_ - 0) / var_98_3)
				var_98_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_98_1.position).x, (manager.ui.mainCamera.transform.position - var_98_1.position).y, (manager.ui.mainCamera.transform.position - var_98_1.position).z)
				var_98_1.localEulerAngles.z = 0
				var_98_1.localEulerAngles.x = 0
				var_98_1.localEulerAngles = var_98_1.localEulerAngles
			end

			if arg_95_1.time_ >= 0 + var_98_3 and arg_95_1.time_ < 0 + var_98_3 + arg_98_0 then
				var_98_1.localPosition = Vector3.New(0.7, -0.985, -6)
				var_98_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_98_1.position).x, (manager.ui.mainCamera.transform.position - var_98_1.position).y, (manager.ui.mainCamera.transform.position - var_98_1.position).z)
				var_98_1.localEulerAngles.z = 0
				var_98_1.localEulerAngles.x = 0
				var_98_1.localEulerAngles = var_98_1.localEulerAngles

				local var_98_4 = GameObjectTools.GetOrAddComponent(var_98_1.gameObject, typeof(DynamicBoneHelper))

				if var_98_4 then
					var_98_4:EnableDynamicBone(true)
				end
			end

			local var_98_5 = arg_95_1.actors_["6148ui_story"]

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 and not isNil(var_98_5) and arg_95_1.var_.characterEffect6148ui_story == nil then
				arg_95_1.var_.characterEffect6148ui_story = var_98_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_98_6 = 0.200000002980232

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_6 and not isNil(var_98_5) then
				if arg_95_1.var_.characterEffect6148ui_story and not isNil(var_98_5) then
					arg_95_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_95_1.time_ >= 0 + var_98_6 and arg_95_1.time_ < 0 + var_98_6 + arg_98_0 and not isNil(var_98_5) and arg_95_1.var_.characterEffect6148ui_story then
				arg_95_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action5_1")
			end

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_98_8 = 0
			local var_98_9 = 0.45

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= var_98_8 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				arg_95_1.leftNameTxt_.text = arg_95_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_10 = arg_95_1:GetWordFromCfg(324781022)
				local var_98_11 = arg_95_1:FormatText(var_98_10.content)

				arg_95_1.text_.text = var_98_11

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_13 = 18 <= 0 and var_98_9 or var_98_9 * (utf8.len(var_98_11) / 18)

				if (18 <= 0 and var_98_9 or var_98_9 * (utf8.len(var_98_11) / 18)) > 0 and var_98_9 < var_98_13 then
					arg_95_1.talkMaxDuration = var_98_13

					if var_98_13 + var_98_8 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_13 + var_98_8
					end
				end

				arg_95_1.text_.text = var_98_11
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324781", "324781022", "story_v_out_324781.awb") ~= 0 then
					local var_98_14 = manager.audio:GetVoiceLength("story_v_out_324781", "324781022", "story_v_out_324781.awb") / 1000

					if var_98_14 + var_98_8 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_14 + var_98_8
					end

					if var_98_10.prefab_name ~= "" and arg_95_1.actors_[var_98_10.prefab_name] ~= nil then
						local var_98_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_95_1.actors_[var_98_10.prefab_name].transform, "story_v_out_324781", "324781022", "story_v_out_324781.awb")

						arg_95_1:RecordAudio("324781022", var_98_15)
						arg_95_1:RecordAudio("324781022", var_98_15)
					else
						arg_95_1:AudioAction("play", "voice", "story_v_out_324781", "324781022", "story_v_out_324781.awb")
					end

					arg_95_1:RecordHistoryTalkVoice("story_v_out_324781", "324781022", "story_v_out_324781.awb")
				end

				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_16 = math.max(var_98_9, arg_95_1.talkMaxDuration)

			if var_98_8 <= arg_95_1.time_ and arg_95_1.time_ < var_98_8 + var_98_16 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_8) / var_98_16

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_8 + var_98_16 and arg_95_1.time_ < var_98_8 + var_98_16 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
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
	Play324781023 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 324781023
		arg_99_1.duration_ = 4.1

		local var_99_0 = {
			zh = 3.5,
			ja = 4.1
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
				arg_99_0:Play324781024(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 and not isNil(arg_99_1.actors_["1053ui_story"]) and arg_99_1.var_.characterEffect1053ui_story == nil then
				arg_99_1.var_.characterEffect1053ui_story = arg_99_1.actors_["1053ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_102_0 = 0.200000002980232

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_0 and not isNil(arg_99_1.actors_["1053ui_story"]) then
				if arg_99_1.var_.characterEffect1053ui_story and not isNil(arg_99_1.actors_["1053ui_story"]) then
					arg_99_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_99_1.time_ >= 0 + var_102_0 and arg_99_1.time_ < 0 + var_102_0 + arg_102_0 and not isNil(arg_99_1.actors_["1053ui_story"]) and arg_99_1.var_.characterEffect1053ui_story then
				arg_99_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053action/1053action7_2")
			end

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_102_2 = arg_99_1.actors_["6148ui_story"]

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 and not isNil(var_102_2) and arg_99_1.var_.characterEffect6148ui_story == nil then
				arg_99_1.var_.characterEffect6148ui_story = var_102_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_102_3 = 0.200000002980232

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_3 and not isNil(var_102_2) then
				if arg_99_1.var_.characterEffect6148ui_story and not isNil(var_102_2) then
					arg_99_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_99_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_99_1.time_ - 0) / var_102_3)
				end
			end

			if arg_99_1.time_ >= 0 + var_102_3 and arg_99_1.time_ < 0 + var_102_3 + arg_102_0 and not isNil(var_102_2) and arg_99_1.var_.characterEffect6148ui_story then
				arg_99_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_99_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			local var_102_4 = 0
			local var_102_5 = 0.3

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= var_102_4 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				arg_99_1.leftNameTxt_.text = arg_99_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_6 = arg_99_1:GetWordFromCfg(324781023)
				local var_102_7 = arg_99_1:FormatText(var_102_6.content)

				arg_99_1.text_.text = var_102_7

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_9 = 12 <= 0 and var_102_5 or var_102_5 * (utf8.len(var_102_7) / 12)

				if (12 <= 0 and var_102_5 or var_102_5 * (utf8.len(var_102_7) / 12)) > 0 and var_102_5 < var_102_9 then
					arg_99_1.talkMaxDuration = var_102_9

					if var_102_9 + var_102_4 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_9 + var_102_4
					end
				end

				arg_99_1.text_.text = var_102_7
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324781", "324781023", "story_v_out_324781.awb") ~= 0 then
					local var_102_10 = manager.audio:GetVoiceLength("story_v_out_324781", "324781023", "story_v_out_324781.awb") / 1000

					if var_102_10 + var_102_4 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_10 + var_102_4
					end

					if var_102_6.prefab_name ~= "" and arg_99_1.actors_[var_102_6.prefab_name] ~= nil then
						local var_102_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_6.prefab_name].transform, "story_v_out_324781", "324781023", "story_v_out_324781.awb")

						arg_99_1:RecordAudio("324781023", var_102_11)
						arg_99_1:RecordAudio("324781023", var_102_11)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_out_324781", "324781023", "story_v_out_324781.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_out_324781", "324781023", "story_v_out_324781.awb")
				end

				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_12 = math.max(var_102_5, arg_99_1.talkMaxDuration)

			if var_102_4 <= arg_99_1.time_ and arg_99_1.time_ < var_102_4 + var_102_12 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_4) / var_102_12

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_4 + var_102_12 and arg_99_1.time_ < var_102_4 + var_102_12 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {}

		arg_99_1:InitPlayNodeList()
	end,
	Play324781024 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 324781024
		arg_103_1.duration_ = 14.97

		local var_103_0 = {
			zh = 9.7,
			ja = 14.966
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
				arg_103_0:Play324781025(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action5_2")
			end

			local var_106_0 = arg_103_1.actors_["6148ui_story"]

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 and not isNil(var_106_0) and arg_103_1.var_.characterEffect6148ui_story == nil then
				arg_103_1.var_.characterEffect6148ui_story = var_106_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_106_1 = 0.200000002980232

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_1 and not isNil(var_106_0) then
				if arg_103_1.var_.characterEffect6148ui_story and not isNil(var_106_0) then
					arg_103_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_103_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_103_1.time_ - 0) / var_106_1)
				end
			end

			if arg_103_1.time_ >= 0 + var_106_1 and arg_103_1.time_ < 0 + var_106_1 + arg_106_0 and not isNil(var_106_0) and arg_103_1.var_.characterEffect6148ui_story then
				arg_103_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_103_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_106_2 = 0
			local var_106_3 = 0.875

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_2 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				arg_103_1.leftNameTxt_.text = arg_103_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_4 = arg_103_1:GetWordFromCfg(324781024)
				local var_106_5 = arg_103_1:FormatText(var_106_4.content)

				arg_103_1.text_.text = var_106_5

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_7 = 35 <= 0 and var_106_3 or var_106_3 * (utf8.len(var_106_5) / 35)

				if (35 <= 0 and var_106_3 or var_106_3 * (utf8.len(var_106_5) / 35)) > 0 and var_106_3 < var_106_7 then
					arg_103_1.talkMaxDuration = var_106_7

					if var_106_7 + var_106_2 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_7 + var_106_2
					end
				end

				arg_103_1.text_.text = var_106_5
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324781", "324781024", "story_v_out_324781.awb") ~= 0 then
					local var_106_8 = manager.audio:GetVoiceLength("story_v_out_324781", "324781024", "story_v_out_324781.awb") / 1000

					if var_106_8 + var_106_2 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_8 + var_106_2
					end

					if var_106_4.prefab_name ~= "" and arg_103_1.actors_[var_106_4.prefab_name] ~= nil then
						local var_106_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_4.prefab_name].transform, "story_v_out_324781", "324781024", "story_v_out_324781.awb")

						arg_103_1:RecordAudio("324781024", var_106_9)
						arg_103_1:RecordAudio("324781024", var_106_9)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_out_324781", "324781024", "story_v_out_324781.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_out_324781", "324781024", "story_v_out_324781.awb")
				end

				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_10 = math.max(var_106_3, arg_103_1.talkMaxDuration)

			if var_106_2 <= arg_103_1.time_ and arg_103_1.time_ < var_106_2 + var_106_10 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_2) / var_106_10

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_2 + var_106_10 and arg_103_1.time_ < var_106_2 + var_106_10 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {}

		arg_103_1:InitPlayNodeList()
	end,
	Play324781025 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 324781025
		arg_107_1.duration_ = 10.87

		local var_107_0 = {
			zh = 6.4,
			ja = 10.866
		}
		local var_107_1 = manager.audio:GetLocalizationFlag()

		if var_107_0[var_107_1] ~= nil then
			arg_107_1.duration_ = var_107_0[var_107_1]
		end

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play324781026(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = 0.975

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				arg_107_1.leftNameTxt_.text = arg_107_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_1 = arg_107_1:GetWordFromCfg(324781025)
				local var_110_2 = arg_107_1:FormatText(var_110_1.content)

				arg_107_1.text_.text = var_110_2

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_4 = 39 <= 0 and var_110_0 or var_110_0 * (utf8.len(var_110_2) / 39)

				if (39 <= 0 and var_110_0 or var_110_0 * (utf8.len(var_110_2) / 39)) > 0 and var_110_0 < var_110_4 then
					arg_107_1.talkMaxDuration = var_110_4

					if var_110_4 + 0 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_4 + 0
					end
				end

				arg_107_1.text_.text = var_110_2
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324781", "324781025", "story_v_out_324781.awb") ~= 0 then
					local var_110_5 = manager.audio:GetVoiceLength("story_v_out_324781", "324781025", "story_v_out_324781.awb") / 1000

					if var_110_5 + 0 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_5 + 0
					end

					if var_110_1.prefab_name ~= "" and arg_107_1.actors_[var_110_1.prefab_name] ~= nil then
						local var_110_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_1.prefab_name].transform, "story_v_out_324781", "324781025", "story_v_out_324781.awb")

						arg_107_1:RecordAudio("324781025", var_110_6)
						arg_107_1:RecordAudio("324781025", var_110_6)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_out_324781", "324781025", "story_v_out_324781.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_out_324781", "324781025", "story_v_out_324781.awb")
				end

				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_7 = math.max(var_110_0, arg_107_1.talkMaxDuration)

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_7 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - 0) / var_110_7

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= 0 + var_110_7 and arg_107_1.time_ < 0 + var_110_7 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {}

		arg_107_1:InitPlayNodeList()
	end,
	Play324781026 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 324781026
		arg_111_1.duration_ = 9.2

		local var_111_0 = {
			zh = 6.1,
			ja = 9.2
		}
		local var_111_1 = manager.audio:GetLocalizationFlag()

		if var_111_0[var_111_1] ~= nil then
			arg_111_1.duration_ = var_111_0[var_111_1]
		end

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play324781027(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = 0.65

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				arg_111_1.leftNameTxt_.text = arg_111_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_1 = arg_111_1:GetWordFromCfg(324781026)
				local var_114_2 = arg_111_1:FormatText(var_114_1.content)

				arg_111_1.text_.text = var_114_2

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_4 = 26 <= 0 and var_114_0 or var_114_0 * (utf8.len(var_114_2) / 26)

				if (26 <= 0 and var_114_0 or var_114_0 * (utf8.len(var_114_2) / 26)) > 0 and var_114_0 < var_114_4 then
					arg_111_1.talkMaxDuration = var_114_4

					if var_114_4 + 0 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_4 + 0
					end
				end

				arg_111_1.text_.text = var_114_2
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324781", "324781026", "story_v_out_324781.awb") ~= 0 then
					local var_114_5 = manager.audio:GetVoiceLength("story_v_out_324781", "324781026", "story_v_out_324781.awb") / 1000

					if var_114_5 + 0 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_5 + 0
					end

					if var_114_1.prefab_name ~= "" and arg_111_1.actors_[var_114_1.prefab_name] ~= nil then
						local var_114_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_1.prefab_name].transform, "story_v_out_324781", "324781026", "story_v_out_324781.awb")

						arg_111_1:RecordAudio("324781026", var_114_6)
						arg_111_1:RecordAudio("324781026", var_114_6)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_324781", "324781026", "story_v_out_324781.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_324781", "324781026", "story_v_out_324781.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_7 = math.max(var_114_0, arg_111_1.talkMaxDuration)

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_7 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - 0) / var_114_7

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= 0 + var_114_7 and arg_111_1.time_ < 0 + var_114_7 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play324781027 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 324781027
		arg_115_1.duration_ = 2.5

		local var_115_0 = {
			zh = 1.999999999999,
			ja = 2.5
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
				arg_115_0:Play324781028(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1.var_.moveOldPos1054ui_story = arg_115_1.actors_["1054ui_story"].transform.localPosition

				local var_118_0 = GameObjectTools.GetOrAddComponent(arg_115_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_118_0 then
					var_118_0:EnableDynamicBone(false)
				end
			end

			local var_118_1 = 0.001

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_1 then
				arg_115_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos1054ui_story, Vector3.New(0.7, -0.985, -6), (arg_115_1.time_ - 0) / var_118_1)
				arg_115_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_115_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_115_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_115_1.actors_["1054ui_story"].transform.position).z)
				arg_115_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_115_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_115_1.actors_["1054ui_story"].transform.localEulerAngles = arg_115_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_115_1.time_ >= 0 + var_118_1 and arg_115_1.time_ < 0 + var_118_1 + arg_118_0 then
				arg_115_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0.7, -0.985, -6)
				arg_115_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_115_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_115_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_115_1.actors_["1054ui_story"].transform.position).z)
				arg_115_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_115_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_115_1.actors_["1054ui_story"].transform.localEulerAngles = arg_115_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_118_2 = GameObjectTools.GetOrAddComponent(arg_115_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_118_2 then
					var_118_2:EnableDynamicBone(true)
				end
			end

			local var_118_3 = arg_115_1.actors_["6148ui_story"].transform

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1.var_.moveOldPos6148ui_story = var_118_3.localPosition

				local var_118_4 = GameObjectTools.GetOrAddComponent(var_118_3.gameObject, typeof(DynamicBoneHelper))

				if var_118_4 then
					var_118_4:EnableDynamicBone(false)
				end
			end

			local var_118_5 = 0.001

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_5 then
				var_118_3.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos6148ui_story, Vector3.New(0, 100, 0), (arg_115_1.time_ - 0) / var_118_5)
				var_118_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_118_3.position).x, (manager.ui.mainCamera.transform.position - var_118_3.position).y, (manager.ui.mainCamera.transform.position - var_118_3.position).z)
				var_118_3.localEulerAngles.z = 0
				var_118_3.localEulerAngles.x = 0
				var_118_3.localEulerAngles = var_118_3.localEulerAngles
			end

			if arg_115_1.time_ >= 0 + var_118_5 and arg_115_1.time_ < 0 + var_118_5 + arg_118_0 then
				var_118_3.localPosition = Vector3.New(0, 100, 0)
				var_118_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_118_3.position).x, (manager.ui.mainCamera.transform.position - var_118_3.position).y, (manager.ui.mainCamera.transform.position - var_118_3.position).z)
				var_118_3.localEulerAngles.z = 0
				var_118_3.localEulerAngles.x = 0
				var_118_3.localEulerAngles = var_118_3.localEulerAngles

				local var_118_6 = GameObjectTools.GetOrAddComponent(var_118_3.gameObject, typeof(DynamicBoneHelper))

				if var_118_6 then
					var_118_6:EnableDynamicBone(true)
				end
			end

			local var_118_7 = arg_115_1.actors_["1054ui_story"]

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 and not isNil(var_118_7) and arg_115_1.var_.characterEffect1054ui_story == nil then
				arg_115_1.var_.characterEffect1054ui_story = var_118_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_8 = 0.200000002980232

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_8 and not isNil(var_118_7) then
				if arg_115_1.var_.characterEffect1054ui_story and not isNil(var_118_7) then
					arg_115_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_115_1.time_ >= 0 + var_118_8 and arg_115_1.time_ < 0 + var_118_8 + arg_118_0 and not isNil(var_118_7) and arg_115_1.var_.characterEffect1054ui_story then
				arg_115_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_118_10 = arg_115_1.actors_["1053ui_story"]

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 and not isNil(var_118_10) and arg_115_1.var_.characterEffect1053ui_story == nil then
				arg_115_1.var_.characterEffect1053ui_story = var_118_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_11 = 0.200000002980232

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_11 and not isNil(var_118_10) then
				if arg_115_1.var_.characterEffect1053ui_story and not isNil(var_118_10) then
					arg_115_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_115_1.var_.characterEffect1053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_115_1.time_ - 0) / var_118_11)
				end
			end

			if arg_115_1.time_ >= 0 + var_118_11 and arg_115_1.time_ < 0 + var_118_11 + arg_118_0 and not isNil(var_118_10) and arg_115_1.var_.characterEffect1053ui_story then
				arg_115_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_115_1.var_.characterEffect1053ui_story.fillRatio = 0.5
			end

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action6_1")
			end

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_118_12 = 0
			local var_118_13 = 0.15

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_12 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				arg_115_1.leftNameTxt_.text = arg_115_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_14 = arg_115_1:GetWordFromCfg(324781027)
				local var_118_15 = arg_115_1:FormatText(var_118_14.content)

				arg_115_1.text_.text = var_118_15

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_17 = 6 <= 0 and var_118_13 or var_118_13 * (utf8.len(var_118_15) / 6)

				if (6 <= 0 and var_118_13 or var_118_13 * (utf8.len(var_118_15) / 6)) > 0 and var_118_13 < var_118_17 then
					arg_115_1.talkMaxDuration = var_118_17

					if var_118_17 + var_118_12 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_17 + var_118_12
					end
				end

				arg_115_1.text_.text = var_118_15
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324781", "324781027", "story_v_out_324781.awb") ~= 0 then
					local var_118_18 = manager.audio:GetVoiceLength("story_v_out_324781", "324781027", "story_v_out_324781.awb") / 1000

					if var_118_18 + var_118_12 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_18 + var_118_12
					end

					if var_118_14.prefab_name ~= "" and arg_115_1.actors_[var_118_14.prefab_name] ~= nil then
						local var_118_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_14.prefab_name].transform, "story_v_out_324781", "324781027", "story_v_out_324781.awb")

						arg_115_1:RecordAudio("324781027", var_118_19)
						arg_115_1:RecordAudio("324781027", var_118_19)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_324781", "324781027", "story_v_out_324781.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_324781", "324781027", "story_v_out_324781.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_20 = math.max(var_118_13, arg_115_1.talkMaxDuration)

			if var_118_12 <= arg_115_1.time_ and arg_115_1.time_ < var_118_12 + var_118_20 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_12) / var_118_20

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_12 + var_118_20 and arg_115_1.time_ < var_118_12 + var_118_20 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_115_1:InitPlayNodeList()
	end,
	Play324781028 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 324781028
		arg_119_1.duration_ = 11.2

		local var_119_0 = {
			zh = 6.566,
			ja = 11.2
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
				arg_119_0:Play324781029(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 and not isNil(arg_119_1.actors_["1053ui_story"]) and arg_119_1.var_.characterEffect1053ui_story == nil then
				arg_119_1.var_.characterEffect1053ui_story = arg_119_1.actors_["1053ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_0 = 0.200000002980232

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_0 and not isNil(arg_119_1.actors_["1053ui_story"]) then
				if arg_119_1.var_.characterEffect1053ui_story and not isNil(arg_119_1.actors_["1053ui_story"]) then
					arg_119_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_119_1.time_ >= 0 + var_122_0 and arg_119_1.time_ < 0 + var_122_0 + arg_122_0 and not isNil(arg_119_1.actors_["1053ui_story"]) and arg_119_1.var_.characterEffect1053ui_story then
				arg_119_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_122_2 = arg_119_1.actors_["1054ui_story"]

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 and not isNil(var_122_2) and arg_119_1.var_.characterEffect1054ui_story == nil then
				arg_119_1.var_.characterEffect1054ui_story = var_122_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_3 = 0.200000002980232

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_3 and not isNil(var_122_2) then
				if arg_119_1.var_.characterEffect1054ui_story and not isNil(var_122_2) then
					arg_119_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_119_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_119_1.time_ - 0) / var_122_3)
				end
			end

			if arg_119_1.time_ >= 0 + var_122_3 and arg_119_1.time_ < 0 + var_122_3 + arg_122_0 and not isNil(var_122_2) and arg_119_1.var_.characterEffect1054ui_story then
				arg_119_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_119_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			local var_122_4 = 0
			local var_122_5 = 0.625

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_4 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				arg_119_1.leftNameTxt_.text = arg_119_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_6 = arg_119_1:GetWordFromCfg(324781028)
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

				if manager.audio:GetVoiceLength("story_v_out_324781", "324781028", "story_v_out_324781.awb") ~= 0 then
					local var_122_10 = manager.audio:GetVoiceLength("story_v_out_324781", "324781028", "story_v_out_324781.awb") / 1000

					if var_122_10 + var_122_4 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_10 + var_122_4
					end

					if var_122_6.prefab_name ~= "" and arg_119_1.actors_[var_122_6.prefab_name] ~= nil then
						local var_122_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_6.prefab_name].transform, "story_v_out_324781", "324781028", "story_v_out_324781.awb")

						arg_119_1:RecordAudio("324781028", var_122_11)
						arg_119_1:RecordAudio("324781028", var_122_11)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_324781", "324781028", "story_v_out_324781.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_324781", "324781028", "story_v_out_324781.awb")
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
	Play324781029 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 324781029
		arg_123_1.duration_ = 2

		local var_123_0 = {
			zh = 1.999999999999,
			ja = 2
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
				arg_123_0:Play324781030(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 and not isNil(arg_123_1.actors_["1054ui_story"]) and arg_123_1.var_.characterEffect1054ui_story == nil then
				arg_123_1.var_.characterEffect1054ui_story = arg_123_1.actors_["1054ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_0 = 0.200000002980232

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_0 and not isNil(arg_123_1.actors_["1054ui_story"]) then
				if arg_123_1.var_.characterEffect1054ui_story and not isNil(arg_123_1.actors_["1054ui_story"]) then
					arg_123_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_123_1.time_ >= 0 + var_126_0 and arg_123_1.time_ < 0 + var_126_0 + arg_126_0 and not isNil(arg_123_1.actors_["1054ui_story"]) and arg_123_1.var_.characterEffect1054ui_story then
				arg_123_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_126_2 = arg_123_1.actors_["1053ui_story"]

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 and not isNil(var_126_2) and arg_123_1.var_.characterEffect1053ui_story == nil then
				arg_123_1.var_.characterEffect1053ui_story = var_126_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_3 = 0.200000002980232

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_3 and not isNil(var_126_2) then
				if arg_123_1.var_.characterEffect1053ui_story and not isNil(var_126_2) then
					arg_123_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_123_1.var_.characterEffect1053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_123_1.time_ - 0) / var_126_3)
				end
			end

			if arg_123_1.time_ >= 0 + var_126_3 and arg_123_1.time_ < 0 + var_126_3 + arg_126_0 and not isNil(var_126_2) and arg_123_1.var_.characterEffect1053ui_story then
				arg_123_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_123_1.var_.characterEffect1053ui_story.fillRatio = 0.5
			end

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action6_2")
			end

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_126_4 = 0
			local var_126_5 = 0.075

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_4 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				arg_123_1.leftNameTxt_.text = arg_123_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_6 = arg_123_1:GetWordFromCfg(324781029)
				local var_126_7 = arg_123_1:FormatText(var_126_6.content)

				arg_123_1.text_.text = var_126_7

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_9 = 3 <= 0 and var_126_5 or var_126_5 * (utf8.len(var_126_7) / 3)

				if (3 <= 0 and var_126_5 or var_126_5 * (utf8.len(var_126_7) / 3)) > 0 and var_126_5 < var_126_9 then
					arg_123_1.talkMaxDuration = var_126_9

					if var_126_9 + var_126_4 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_9 + var_126_4
					end
				end

				arg_123_1.text_.text = var_126_7
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324781", "324781029", "story_v_out_324781.awb") ~= 0 then
					local var_126_10 = manager.audio:GetVoiceLength("story_v_out_324781", "324781029", "story_v_out_324781.awb") / 1000

					if var_126_10 + var_126_4 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_10 + var_126_4
					end

					if var_126_6.prefab_name ~= "" and arg_123_1.actors_[var_126_6.prefab_name] ~= nil then
						local var_126_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_6.prefab_name].transform, "story_v_out_324781", "324781029", "story_v_out_324781.awb")

						arg_123_1:RecordAudio("324781029", var_126_11)
						arg_123_1:RecordAudio("324781029", var_126_11)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_324781", "324781029", "story_v_out_324781.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_324781", "324781029", "story_v_out_324781.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_12 = math.max(var_126_5, arg_123_1.talkMaxDuration)

			if var_126_4 <= arg_123_1.time_ and arg_123_1.time_ < var_126_4 + var_126_12 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_4) / var_126_12

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_4 + var_126_12 and arg_123_1.time_ < var_126_4 + var_126_12 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play324781030 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 324781030
		arg_127_1.duration_ = 3.03

		local var_127_0 = {
			zh = 2.566,
			ja = 3.033
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
				arg_127_0:Play324781031(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 and not isNil(arg_127_1.actors_["6148ui_story"]) and arg_127_1.var_.characterEffect6148ui_story == nil then
				arg_127_1.var_.characterEffect6148ui_story = arg_127_1.actors_["6148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_0 = 0.200000002980232

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_0 and not isNil(arg_127_1.actors_["6148ui_story"]) then
				if arg_127_1.var_.characterEffect6148ui_story and not isNil(arg_127_1.actors_["6148ui_story"]) then
					arg_127_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_127_1.time_ >= 0 + var_130_0 and arg_127_1.time_ < 0 + var_130_0 + arg_130_0 and not isNil(arg_127_1.actors_["6148ui_story"]) and arg_127_1.var_.characterEffect6148ui_story then
				arg_127_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_130_2 = arg_127_1.actors_["1054ui_story"]

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 and not isNil(var_130_2) and arg_127_1.var_.characterEffect1054ui_story == nil then
				arg_127_1.var_.characterEffect1054ui_story = var_130_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_3 = 0.200000002980232

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_3 and not isNil(var_130_2) then
				if arg_127_1.var_.characterEffect1054ui_story and not isNil(var_130_2) then
					arg_127_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_127_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_127_1.time_ - 0) / var_130_3)
				end
			end

			if arg_127_1.time_ >= 0 + var_130_3 and arg_127_1.time_ < 0 + var_130_3 + arg_130_0 and not isNil(var_130_2) and arg_127_1.var_.characterEffect1054ui_story then
				arg_127_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_127_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			local var_130_4 = 0
			local var_130_5 = 0.2

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_4 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				arg_127_1.leftNameTxt_.text = arg_127_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, true)
				arg_127_1.iconController_:SetSelectedState("hero")

				arg_127_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6148")

				arg_127_1.callingController_:SetSelectedState("normal")

				arg_127_1.keyicon_.color = Color.New(1, 1, 1)
				arg_127_1.icon_.color = Color.New(1, 1, 1)

				local var_130_6 = arg_127_1:GetWordFromCfg(324781030)
				local var_130_7 = arg_127_1:FormatText(var_130_6.content)

				arg_127_1.text_.text = var_130_7

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_9 = 8 <= 0 and var_130_5 or var_130_5 * (utf8.len(var_130_7) / 8)

				if (8 <= 0 and var_130_5 or var_130_5 * (utf8.len(var_130_7) / 8)) > 0 and var_130_5 < var_130_9 then
					arg_127_1.talkMaxDuration = var_130_9

					if var_130_9 + var_130_4 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_9 + var_130_4
					end
				end

				arg_127_1.text_.text = var_130_7
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324781", "324781030", "story_v_out_324781.awb") ~= 0 then
					local var_130_10 = manager.audio:GetVoiceLength("story_v_out_324781", "324781030", "story_v_out_324781.awb") / 1000

					if var_130_10 + var_130_4 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_10 + var_130_4
					end

					if var_130_6.prefab_name ~= "" and arg_127_1.actors_[var_130_6.prefab_name] ~= nil then
						local var_130_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_6.prefab_name].transform, "story_v_out_324781", "324781030", "story_v_out_324781.awb")

						arg_127_1:RecordAudio("324781030", var_130_11)
						arg_127_1:RecordAudio("324781030", var_130_11)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_324781", "324781030", "story_v_out_324781.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_324781", "324781030", "story_v_out_324781.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_12 = math.max(var_130_5, arg_127_1.talkMaxDuration)

			if var_130_4 <= arg_127_1.time_ and arg_127_1.time_ < var_130_4 + var_130_12 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_4) / var_130_12

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_4 + var_130_12 and arg_127_1.time_ < var_130_4 + var_130_12 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play324781031 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 324781031
		arg_131_1.duration_ = 3.3

		local var_131_0 = {
			zh = 2.433,
			ja = 3.3
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
				arg_131_0:Play324781032(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 and not isNil(arg_131_1.actors_["1053ui_story"]) and arg_131_1.var_.characterEffect1053ui_story == nil then
				arg_131_1.var_.characterEffect1053ui_story = arg_131_1.actors_["1053ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_0 = 0.200000002980232

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_0 and not isNil(arg_131_1.actors_["1053ui_story"]) then
				if arg_131_1.var_.characterEffect1053ui_story and not isNil(arg_131_1.actors_["1053ui_story"]) then
					arg_131_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_131_1.time_ >= 0 + var_134_0 and arg_131_1.time_ < 0 + var_134_0 + arg_134_0 and not isNil(arg_131_1.actors_["1053ui_story"]) and arg_131_1.var_.characterEffect1053ui_story then
				arg_131_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_134_2 = arg_131_1.actors_["6148ui_story"]

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 and not isNil(var_134_2) and arg_131_1.var_.characterEffect6148ui_story == nil then
				arg_131_1.var_.characterEffect6148ui_story = var_134_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_3 = 0.200000002980232

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_3 and not isNil(var_134_2) then
				if arg_131_1.var_.characterEffect6148ui_story and not isNil(var_134_2) then
					arg_131_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_131_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_131_1.time_ - 0) / var_134_3)
				end
			end

			if arg_131_1.time_ >= 0 + var_134_3 and arg_131_1.time_ < 0 + var_134_3 + arg_134_0 and not isNil(var_134_2) and arg_131_1.var_.characterEffect6148ui_story then
				arg_131_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_131_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053action/1053action4_1")
			end

			local var_134_4 = 0
			local var_134_5 = 0.275

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_4 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				arg_131_1.leftNameTxt_.text = arg_131_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_6 = arg_131_1:GetWordFromCfg(324781031)
				local var_134_7 = arg_131_1:FormatText(var_134_6.content)

				arg_131_1.text_.text = var_134_7

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_9 = 11 <= 0 and var_134_5 or var_134_5 * (utf8.len(var_134_7) / 11)

				if (11 <= 0 and var_134_5 or var_134_5 * (utf8.len(var_134_7) / 11)) > 0 and var_134_5 < var_134_9 then
					arg_131_1.talkMaxDuration = var_134_9

					if var_134_9 + var_134_4 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_9 + var_134_4
					end
				end

				arg_131_1.text_.text = var_134_7
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324781", "324781031", "story_v_out_324781.awb") ~= 0 then
					local var_134_10 = manager.audio:GetVoiceLength("story_v_out_324781", "324781031", "story_v_out_324781.awb") / 1000

					if var_134_10 + var_134_4 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_10 + var_134_4
					end

					if var_134_6.prefab_name ~= "" and arg_131_1.actors_[var_134_6.prefab_name] ~= nil then
						local var_134_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_6.prefab_name].transform, "story_v_out_324781", "324781031", "story_v_out_324781.awb")

						arg_131_1:RecordAudio("324781031", var_134_11)
						arg_131_1:RecordAudio("324781031", var_134_11)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_324781", "324781031", "story_v_out_324781.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_324781", "324781031", "story_v_out_324781.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_12 = math.max(var_134_5, arg_131_1.talkMaxDuration)

			if var_134_4 <= arg_131_1.time_ and arg_131_1.time_ < var_134_4 + var_134_12 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_4) / var_134_12

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_4 + var_134_12 and arg_131_1.time_ < var_134_4 + var_134_12 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play324781032 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 324781032
		arg_135_1.duration_ = 11.17

		local var_135_0 = {
			zh = 7.966,
			ja = 11.166
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
				arg_135_0:Play324781033(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053action/1053action4_2")
			end

			local var_138_0 = 0
			local var_138_1 = 0.85

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_0 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				arg_135_1.leftNameTxt_.text = arg_135_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_2 = arg_135_1:GetWordFromCfg(324781032)
				local var_138_3 = arg_135_1:FormatText(var_138_2.content)

				arg_135_1.text_.text = var_138_3

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_5 = 34 <= 0 and var_138_1 or var_138_1 * (utf8.len(var_138_3) / 34)

				if (34 <= 0 and var_138_1 or var_138_1 * (utf8.len(var_138_3) / 34)) > 0 and var_138_1 < var_138_5 then
					arg_135_1.talkMaxDuration = var_138_5

					if var_138_5 + var_138_0 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_5 + var_138_0
					end
				end

				arg_135_1.text_.text = var_138_3
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324781", "324781032", "story_v_out_324781.awb") ~= 0 then
					local var_138_6 = manager.audio:GetVoiceLength("story_v_out_324781", "324781032", "story_v_out_324781.awb") / 1000

					if var_138_6 + var_138_0 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_6 + var_138_0
					end

					if var_138_2.prefab_name ~= "" and arg_135_1.actors_[var_138_2.prefab_name] ~= nil then
						local var_138_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_2.prefab_name].transform, "story_v_out_324781", "324781032", "story_v_out_324781.awb")

						arg_135_1:RecordAudio("324781032", var_138_7)
						arg_135_1:RecordAudio("324781032", var_138_7)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_324781", "324781032", "story_v_out_324781.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_324781", "324781032", "story_v_out_324781.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_8 = math.max(var_138_1, arg_135_1.talkMaxDuration)

			if var_138_0 <= arg_135_1.time_ and arg_135_1.time_ < var_138_0 + var_138_8 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_0) / var_138_8

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_0 + var_138_8 and arg_135_1.time_ < var_138_0 + var_138_8 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play324781033 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 324781033
		arg_139_1.duration_ = 5

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play324781034(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1.var_.moveOldPos1054ui_story = arg_139_1.actors_["1054ui_story"].transform.localPosition

				local var_142_0 = GameObjectTools.GetOrAddComponent(arg_139_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_142_0 then
					var_142_0:EnableDynamicBone(false)
				end
			end

			local var_142_1 = 0.001

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_1 then
				arg_139_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos1054ui_story, Vector3.New(0, 100, 0), (arg_139_1.time_ - 0) / var_142_1)
				arg_139_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_139_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["1054ui_story"].transform.position).z)
				arg_139_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_139_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_139_1.actors_["1054ui_story"].transform.localEulerAngles = arg_139_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_139_1.time_ >= 0 + var_142_1 and arg_139_1.time_ < 0 + var_142_1 + arg_142_0 then
				arg_139_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_139_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_139_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["1054ui_story"].transform.position).z)
				arg_139_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_139_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_139_1.actors_["1054ui_story"].transform.localEulerAngles = arg_139_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_142_2 = GameObjectTools.GetOrAddComponent(arg_139_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_142_2 then
					var_142_2:EnableDynamicBone(true)
				end
			end

			local var_142_3 = arg_139_1.actors_["1053ui_story"].transform

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1.var_.moveOldPos1053ui_story = var_142_3.localPosition

				local var_142_4 = GameObjectTools.GetOrAddComponent(var_142_3.gameObject, typeof(DynamicBoneHelper))

				if var_142_4 then
					var_142_4:EnableDynamicBone(false)
				end
			end

			local var_142_5 = 0.001

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_5 then
				var_142_3.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos1053ui_story, Vector3.New(0, 100, 0), (arg_139_1.time_ - 0) / var_142_5)
				var_142_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_142_3.position).x, (manager.ui.mainCamera.transform.position - var_142_3.position).y, (manager.ui.mainCamera.transform.position - var_142_3.position).z)
				var_142_3.localEulerAngles.z = 0
				var_142_3.localEulerAngles.x = 0
				var_142_3.localEulerAngles = var_142_3.localEulerAngles
			end

			if arg_139_1.time_ >= 0 + var_142_5 and arg_139_1.time_ < 0 + var_142_5 + arg_142_0 then
				var_142_3.localPosition = Vector3.New(0, 100, 0)
				var_142_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_142_3.position).x, (manager.ui.mainCamera.transform.position - var_142_3.position).y, (manager.ui.mainCamera.transform.position - var_142_3.position).z)
				var_142_3.localEulerAngles.z = 0
				var_142_3.localEulerAngles.x = 0
				var_142_3.localEulerAngles = var_142_3.localEulerAngles

				local var_142_6 = GameObjectTools.GetOrAddComponent(var_142_3.gameObject, typeof(DynamicBoneHelper))

				if var_142_6 then
					var_142_6:EnableDynamicBone(true)
				end
			end

			local var_142_7 = arg_139_1.actors_["1053ui_story"]

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 and not isNil(var_142_7) and arg_139_1.var_.characterEffect1053ui_story == nil then
				arg_139_1.var_.characterEffect1053ui_story = var_142_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_8 = 0.200000002980232

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_8 and not isNil(var_142_7) then
				if arg_139_1.var_.characterEffect1053ui_story and not isNil(var_142_7) then
					arg_139_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_139_1.var_.characterEffect1053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_139_1.time_ - 0) / var_142_8)
				end
			end

			if arg_139_1.time_ >= 0 + var_142_8 and arg_139_1.time_ < 0 + var_142_8 + arg_142_0 and not isNil(var_142_7) and arg_139_1.var_.characterEffect1053ui_story then
				arg_139_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_139_1.var_.characterEffect1053ui_story.fillRatio = 0.5
			end

			local var_142_9 = 0
			local var_142_10 = 1

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_9 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, false)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_11 = arg_139_1:FormatText(arg_139_1:GetWordFromCfg(324781033).content)

				arg_139_1.text_.text = var_142_11

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_13 = 40 <= 0 and var_142_10 or var_142_10 * (utf8.len(var_142_11) / 40)

				if (40 <= 0 and var_142_10 or var_142_10 * (utf8.len(var_142_11) / 40)) > 0 and var_142_10 < var_142_13 then
					arg_139_1.talkMaxDuration = var_142_13

					if var_142_13 + var_142_9 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_13 + var_142_9
					end
				end

				arg_139_1.text_.text = var_142_11
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)
				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_14 = math.max(var_142_10, arg_139_1.talkMaxDuration)

			if var_142_9 <= arg_139_1.time_ and arg_139_1.time_ < var_142_9 + var_142_14 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_9) / var_142_14

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_9 + var_142_14 and arg_139_1.time_ < var_142_9 + var_142_14 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
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

		arg_139_1:InitPlayNodeList()
	end,
	Play324781034 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 324781034
		arg_143_1.duration_ = 5

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play324781035(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = 0.8

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, false)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_1 = arg_143_1:FormatText(arg_143_1:GetWordFromCfg(324781034).content)

				arg_143_1.text_.text = var_146_1

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_3 = 32 <= 0 and var_146_0 or var_146_0 * (utf8.len(var_146_1) / 32)

				if (32 <= 0 and var_146_0 or var_146_0 * (utf8.len(var_146_1) / 32)) > 0 and var_146_0 < var_146_3 then
					arg_143_1.talkMaxDuration = var_146_3

					if var_146_3 + 0 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_3 + 0
					end
				end

				arg_143_1.text_.text = var_146_1
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)
				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_4 = math.max(var_146_0, arg_143_1.talkMaxDuration)

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_4 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - 0) / var_146_4

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= 0 + var_146_4 and arg_143_1.time_ < 0 + var_146_4 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play324781035 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 324781035
		arg_147_1.duration_ = 4.1

		local var_147_0 = {
			zh = 2.933,
			ja = 4.1
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
				arg_147_0:Play324781036(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1.var_.moveOldPos6148ui_story = arg_147_1.actors_["6148ui_story"].transform.localPosition

				local var_150_0 = GameObjectTools.GetOrAddComponent(arg_147_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_150_0 then
					var_150_0:EnableDynamicBone(false)
				end
			end

			local var_150_1 = 0.001

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_1 then
				arg_147_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos6148ui_story, Vector3.New(0, -0.985, -6), (arg_147_1.time_ - 0) / var_150_1)
				arg_147_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_147_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_147_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_147_1.actors_["6148ui_story"].transform.position).z)
				arg_147_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_147_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_147_1.actors_["6148ui_story"].transform.localEulerAngles = arg_147_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_147_1.time_ >= 0 + var_150_1 and arg_147_1.time_ < 0 + var_150_1 + arg_150_0 then
				arg_147_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6)
				arg_147_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_147_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_147_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_147_1.actors_["6148ui_story"].transform.position).z)
				arg_147_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_147_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_147_1.actors_["6148ui_story"].transform.localEulerAngles = arg_147_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_150_2 = GameObjectTools.GetOrAddComponent(arg_147_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_150_2 then
					var_150_2:EnableDynamicBone(true)
				end
			end

			local var_150_3 = arg_147_1.actors_["6148ui_story"]

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 and not isNil(var_150_3) and arg_147_1.var_.characterEffect6148ui_story == nil then
				arg_147_1.var_.characterEffect6148ui_story = var_150_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_4 = 0.200000002980232

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_4 and not isNil(var_150_3) then
				if arg_147_1.var_.characterEffect6148ui_story and not isNil(var_150_3) then
					arg_147_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_147_1.time_ >= 0 + var_150_4 and arg_147_1.time_ < 0 + var_150_4 + arg_150_0 and not isNil(var_150_3) and arg_147_1.var_.characterEffect6148ui_story then
				arg_147_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action1_1")
			end

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_150_6 = 0
			local var_150_7 = 0.3

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_6 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				arg_147_1.leftNameTxt_.text = arg_147_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_8 = arg_147_1:GetWordFromCfg(324781035)
				local var_150_9 = arg_147_1:FormatText(var_150_8.content)

				arg_147_1.text_.text = var_150_9

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_11 = 12 <= 0 and var_150_7 or var_150_7 * (utf8.len(var_150_9) / 12)

				if (12 <= 0 and var_150_7 or var_150_7 * (utf8.len(var_150_9) / 12)) > 0 and var_150_7 < var_150_11 then
					arg_147_1.talkMaxDuration = var_150_11

					if var_150_11 + var_150_6 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_11 + var_150_6
					end
				end

				arg_147_1.text_.text = var_150_9
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324781", "324781035", "story_v_out_324781.awb") ~= 0 then
					local var_150_12 = manager.audio:GetVoiceLength("story_v_out_324781", "324781035", "story_v_out_324781.awb") / 1000

					if var_150_12 + var_150_6 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_12 + var_150_6
					end

					if var_150_8.prefab_name ~= "" and arg_147_1.actors_[var_150_8.prefab_name] ~= nil then
						local var_150_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_8.prefab_name].transform, "story_v_out_324781", "324781035", "story_v_out_324781.awb")

						arg_147_1:RecordAudio("324781035", var_150_13)
						arg_147_1:RecordAudio("324781035", var_150_13)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_324781", "324781035", "story_v_out_324781.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_324781", "324781035", "story_v_out_324781.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_14 = math.max(var_150_7, arg_147_1.talkMaxDuration)

			if var_150_6 <= arg_147_1.time_ and arg_147_1.time_ < var_150_6 + var_150_14 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_6) / var_150_14

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_6 + var_150_14 and arg_147_1.time_ < var_150_6 + var_150_14 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_147_1:InitPlayNodeList()
	end,
	Play324781036 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 324781036
		arg_151_1.duration_ = 5

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play324781037(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 and not isNil(arg_151_1.actors_["6148ui_story"]) and arg_151_1.var_.characterEffect6148ui_story == nil then
				arg_151_1.var_.characterEffect6148ui_story = arg_151_1.actors_["6148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_0 = 0.200000002980232

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_0 and not isNil(arg_151_1.actors_["6148ui_story"]) then
				if arg_151_1.var_.characterEffect6148ui_story and not isNil(arg_151_1.actors_["6148ui_story"]) then
					arg_151_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_151_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_151_1.time_ - 0) / var_154_0)
				end
			end

			if arg_151_1.time_ >= 0 + var_154_0 and arg_151_1.time_ < 0 + var_154_0 + arg_154_0 and not isNil(arg_151_1.actors_["6148ui_story"]) and arg_151_1.var_.characterEffect6148ui_story then
				arg_151_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_151_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			local var_154_1 = 0
			local var_154_2 = 0.35

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_1 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				arg_151_1.leftNameTxt_.text = arg_151_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, true)
				arg_151_1.iconController_:SetSelectedState("hero")

				arg_151_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_151_1.callingController_:SetSelectedState("normal")

				arg_151_1.keyicon_.color = Color.New(1, 1, 1)
				arg_151_1.icon_.color = Color.New(1, 1, 1)

				local var_154_3 = arg_151_1:FormatText(arg_151_1:GetWordFromCfg(324781036).content)

				arg_151_1.text_.text = var_154_3

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_5 = 14 <= 0 and var_154_2 or var_154_2 * (utf8.len(var_154_3) / 14)

				if (14 <= 0 and var_154_2 or var_154_2 * (utf8.len(var_154_3) / 14)) > 0 and var_154_2 < var_154_5 then
					arg_151_1.talkMaxDuration = var_154_5

					if var_154_5 + var_154_1 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_5 + var_154_1
					end
				end

				arg_151_1.text_.text = var_154_3
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)
				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_6 = math.max(var_154_2, arg_151_1.talkMaxDuration)

			if var_154_1 <= arg_151_1.time_ and arg_151_1.time_ < var_154_1 + var_154_6 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_1) / var_154_6

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_1 + var_154_6 and arg_151_1.time_ < var_154_1 + var_154_6 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play324781037 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 324781037
		arg_155_1.duration_ = 5

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play324781038(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = 0.525

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				arg_155_1.leftNameTxt_.text = arg_155_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, true)
				arg_155_1.iconController_:SetSelectedState("hero")

				arg_155_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_155_1.callingController_:SetSelectedState("normal")

				arg_155_1.keyicon_.color = Color.New(1, 1, 1)
				arg_155_1.icon_.color = Color.New(1, 1, 1)

				local var_158_1 = arg_155_1:FormatText(arg_155_1:GetWordFromCfg(324781037).content)

				arg_155_1.text_.text = var_158_1

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_3 = 21 <= 0 and var_158_0 or var_158_0 * (utf8.len(var_158_1) / 21)

				if (21 <= 0 and var_158_0 or var_158_0 * (utf8.len(var_158_1) / 21)) > 0 and var_158_0 < var_158_3 then
					arg_155_1.talkMaxDuration = var_158_3

					if var_158_3 + 0 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_3 + 0
					end
				end

				arg_155_1.text_.text = var_158_1
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)
				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_4 = math.max(var_158_0, arg_155_1.talkMaxDuration)

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_4 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - 0) / var_158_4

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= 0 + var_158_4 and arg_155_1.time_ < 0 + var_158_4 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {}

		arg_155_1:InitPlayNodeList()
	end,
	Play324781038 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 324781038
		arg_159_1.duration_ = 4.57

		local var_159_0 = {
			zh = 4.033,
			ja = 4.566
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
				arg_159_0:Play324781039(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1.var_.moveOldPos1054ui_story = arg_159_1.actors_["1054ui_story"].transform.localPosition

				local var_162_0 = GameObjectTools.GetOrAddComponent(arg_159_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_162_0 then
					var_162_0:EnableDynamicBone(false)
				end
			end

			local var_162_1 = 0.001

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_1 then
				arg_159_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_159_1.var_.moveOldPos1054ui_story, Vector3.New(-0.7, -0.985, -6), (arg_159_1.time_ - 0) / var_162_1)
				arg_159_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_159_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_159_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_159_1.actors_["1054ui_story"].transform.position).z)
				arg_159_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_159_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_159_1.actors_["1054ui_story"].transform.localEulerAngles = arg_159_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_159_1.time_ >= 0 + var_162_1 and arg_159_1.time_ < 0 + var_162_1 + arg_162_0 then
				arg_159_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(-0.7, -0.985, -6)
				arg_159_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_159_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_159_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_159_1.actors_["1054ui_story"].transform.position).z)
				arg_159_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_159_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_159_1.actors_["1054ui_story"].transform.localEulerAngles = arg_159_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_162_2 = GameObjectTools.GetOrAddComponent(arg_159_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_162_2 then
					var_162_2:EnableDynamicBone(true)
				end
			end

			local var_162_3 = arg_159_1.actors_["6148ui_story"].transform

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1.var_.moveOldPos6148ui_story = var_162_3.localPosition

				local var_162_4 = GameObjectTools.GetOrAddComponent(var_162_3.gameObject, typeof(DynamicBoneHelper))

				if var_162_4 then
					var_162_4:EnableDynamicBone(false)
				end
			end

			local var_162_5 = 0.001

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_5 then
				var_162_3.localPosition = Vector3.Lerp(arg_159_1.var_.moveOldPos6148ui_story, Vector3.New(0.7, -0.985, -6), (arg_159_1.time_ - 0) / var_162_5)
				var_162_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_162_3.position).x, (manager.ui.mainCamera.transform.position - var_162_3.position).y, (manager.ui.mainCamera.transform.position - var_162_3.position).z)
				var_162_3.localEulerAngles.z = 0
				var_162_3.localEulerAngles.x = 0
				var_162_3.localEulerAngles = var_162_3.localEulerAngles
			end

			if arg_159_1.time_ >= 0 + var_162_5 and arg_159_1.time_ < 0 + var_162_5 + arg_162_0 then
				var_162_3.localPosition = Vector3.New(0.7, -0.985, -6)
				var_162_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_162_3.position).x, (manager.ui.mainCamera.transform.position - var_162_3.position).y, (manager.ui.mainCamera.transform.position - var_162_3.position).z)
				var_162_3.localEulerAngles.z = 0
				var_162_3.localEulerAngles.x = 0
				var_162_3.localEulerAngles = var_162_3.localEulerAngles

				local var_162_6 = GameObjectTools.GetOrAddComponent(var_162_3.gameObject, typeof(DynamicBoneHelper))

				if var_162_6 then
					var_162_6:EnableDynamicBone(true)
				end
			end

			local var_162_7 = arg_159_1.actors_["1054ui_story"]

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 and not isNil(var_162_7) and arg_159_1.var_.characterEffect1054ui_story == nil then
				arg_159_1.var_.characterEffect1054ui_story = var_162_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_8 = 0.200000002980232

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_8 and not isNil(var_162_7) then
				if arg_159_1.var_.characterEffect1054ui_story and not isNil(var_162_7) then
					arg_159_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_159_1.time_ >= 0 + var_162_8 and arg_159_1.time_ < 0 + var_162_8 + arg_162_0 and not isNil(var_162_7) and arg_159_1.var_.characterEffect1054ui_story then
				arg_159_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action2_1")
			end

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_162_10 = 0
			local var_162_11 = 0.375

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_10 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				arg_159_1.leftNameTxt_.text = arg_159_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_12 = arg_159_1:GetWordFromCfg(324781038)
				local var_162_13 = arg_159_1:FormatText(var_162_12.content)

				arg_159_1.text_.text = var_162_13

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_15 = 15 <= 0 and var_162_11 or var_162_11 * (utf8.len(var_162_13) / 15)

				if (15 <= 0 and var_162_11 or var_162_11 * (utf8.len(var_162_13) / 15)) > 0 and var_162_11 < var_162_15 then
					arg_159_1.talkMaxDuration = var_162_15

					if var_162_15 + var_162_10 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_15 + var_162_10
					end
				end

				arg_159_1.text_.text = var_162_13
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324781", "324781038", "story_v_out_324781.awb") ~= 0 then
					local var_162_16 = manager.audio:GetVoiceLength("story_v_out_324781", "324781038", "story_v_out_324781.awb") / 1000

					if var_162_16 + var_162_10 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_16 + var_162_10
					end

					if var_162_12.prefab_name ~= "" and arg_159_1.actors_[var_162_12.prefab_name] ~= nil then
						local var_162_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_12.prefab_name].transform, "story_v_out_324781", "324781038", "story_v_out_324781.awb")

						arg_159_1:RecordAudio("324781038", var_162_17)
						arg_159_1:RecordAudio("324781038", var_162_17)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_324781", "324781038", "story_v_out_324781.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_324781", "324781038", "story_v_out_324781.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_18 = math.max(var_162_11, arg_159_1.talkMaxDuration)

			if var_162_10 <= arg_159_1.time_ and arg_159_1.time_ < var_162_10 + var_162_18 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_10) / var_162_18

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_10 + var_162_18 and arg_159_1.time_ < var_162_10 + var_162_18 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_159_1:InitPlayNodeList()
	end,
	Play324781039 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 324781039
		arg_163_1.duration_ = 11.77

		local var_163_0 = {
			zh = 8.033,
			ja = 11.766
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
				arg_163_0:Play324781040(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 and not isNil(arg_163_1.actors_["6148ui_story"]) and arg_163_1.var_.characterEffect6148ui_story == nil then
				arg_163_1.var_.characterEffect6148ui_story = arg_163_1.actors_["6148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_0 = 0.200000002980232

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_0 and not isNil(arg_163_1.actors_["6148ui_story"]) then
				if arg_163_1.var_.characterEffect6148ui_story and not isNil(arg_163_1.actors_["6148ui_story"]) then
					arg_163_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_163_1.time_ >= 0 + var_166_0 and arg_163_1.time_ < 0 + var_166_0 + arg_166_0 and not isNil(arg_163_1.actors_["6148ui_story"]) and arg_163_1.var_.characterEffect6148ui_story then
				arg_163_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_166_2 = arg_163_1.actors_["1054ui_story"]

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 and not isNil(var_166_2) and arg_163_1.var_.characterEffect1054ui_story == nil then
				arg_163_1.var_.characterEffect1054ui_story = var_166_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_3 = 0.200000002980232

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_3 and not isNil(var_166_2) then
				if arg_163_1.var_.characterEffect1054ui_story and not isNil(var_166_2) then
					arg_163_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_163_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_163_1.time_ - 0) / var_166_3)
				end
			end

			if arg_163_1.time_ >= 0 + var_166_3 and arg_163_1.time_ < 0 + var_166_3 + arg_166_0 and not isNil(var_166_2) and arg_163_1.var_.characterEffect1054ui_story then
				arg_163_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_163_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action6_1")
			end

			local var_166_4 = 0
			local var_166_5 = 0.95

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_4 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				arg_163_1.leftNameTxt_.text = arg_163_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_6 = arg_163_1:GetWordFromCfg(324781039)
				local var_166_7 = arg_163_1:FormatText(var_166_6.content)

				arg_163_1.text_.text = var_166_7

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_9 = 38 <= 0 and var_166_5 or var_166_5 * (utf8.len(var_166_7) / 38)

				if (38 <= 0 and var_166_5 or var_166_5 * (utf8.len(var_166_7) / 38)) > 0 and var_166_5 < var_166_9 then
					arg_163_1.talkMaxDuration = var_166_9

					if var_166_9 + var_166_4 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_9 + var_166_4
					end
				end

				arg_163_1.text_.text = var_166_7
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324781", "324781039", "story_v_out_324781.awb") ~= 0 then
					local var_166_10 = manager.audio:GetVoiceLength("story_v_out_324781", "324781039", "story_v_out_324781.awb") / 1000

					if var_166_10 + var_166_4 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_10 + var_166_4
					end

					if var_166_6.prefab_name ~= "" and arg_163_1.actors_[var_166_6.prefab_name] ~= nil then
						local var_166_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_6.prefab_name].transform, "story_v_out_324781", "324781039", "story_v_out_324781.awb")

						arg_163_1:RecordAudio("324781039", var_166_11)
						arg_163_1:RecordAudio("324781039", var_166_11)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_324781", "324781039", "story_v_out_324781.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_324781", "324781039", "story_v_out_324781.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_12 = math.max(var_166_5, arg_163_1.talkMaxDuration)

			if var_166_4 <= arg_163_1.time_ and arg_163_1.time_ < var_166_4 + var_166_12 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_4) / var_166_12

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_4 + var_166_12 and arg_163_1.time_ < var_166_4 + var_166_12 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {}

		arg_163_1:InitPlayNodeList()
	end,
	Play324781040 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 324781040
		arg_167_1.duration_ = 5

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play324781041(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 and not isNil(arg_167_1.actors_["6148ui_story"]) and arg_167_1.var_.characterEffect6148ui_story == nil then
				arg_167_1.var_.characterEffect6148ui_story = arg_167_1.actors_["6148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_170_0 = 0.200000002980232

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_0 and not isNil(arg_167_1.actors_["6148ui_story"]) then
				if arg_167_1.var_.characterEffect6148ui_story and not isNil(arg_167_1.actors_["6148ui_story"]) then
					arg_167_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_167_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_167_1.time_ - 0) / var_170_0)
				end
			end

			if arg_167_1.time_ >= 0 + var_170_0 and arg_167_1.time_ < 0 + var_170_0 + arg_170_0 and not isNil(arg_167_1.actors_["6148ui_story"]) and arg_167_1.var_.characterEffect6148ui_story then
				arg_167_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_167_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			local var_170_1 = 0
			local var_170_2 = 0.325

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_1 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				arg_167_1.leftNameTxt_.text = arg_167_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, true)
				arg_167_1.iconController_:SetSelectedState("hero")

				arg_167_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_167_1.callingController_:SetSelectedState("normal")

				arg_167_1.keyicon_.color = Color.New(1, 1, 1)
				arg_167_1.icon_.color = Color.New(1, 1, 1)

				local var_170_3 = arg_167_1:FormatText(arg_167_1:GetWordFromCfg(324781040).content)

				arg_167_1.text_.text = var_170_3

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_5 = 13 <= 0 and var_170_2 or var_170_2 * (utf8.len(var_170_3) / 13)

				if (13 <= 0 and var_170_2 or var_170_2 * (utf8.len(var_170_3) / 13)) > 0 and var_170_2 < var_170_5 then
					arg_167_1.talkMaxDuration = var_170_5

					if var_170_5 + var_170_1 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_5 + var_170_1
					end
				end

				arg_167_1.text_.text = var_170_3
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)
				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_6 = math.max(var_170_2, arg_167_1.talkMaxDuration)

			if var_170_1 <= arg_167_1.time_ and arg_167_1.time_ < var_170_1 + var_170_6 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_1) / var_170_6

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_1 + var_170_6 and arg_167_1.time_ < var_170_1 + var_170_6 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play324781041 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 324781041
		arg_171_1.duration_ = 5

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
			arg_171_1.auto_ = false
		end

		function arg_171_1.playNext_(arg_173_0)
			arg_171_1.onStoryFinished_()
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = 0.75

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				arg_171_1.leftNameTxt_.text = arg_171_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, true)
				arg_171_1.iconController_:SetSelectedState("hero")

				arg_171_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_171_1.callingController_:SetSelectedState("normal")

				arg_171_1.keyicon_.color = Color.New(1, 1, 1)
				arg_171_1.icon_.color = Color.New(1, 1, 1)

				local var_174_1 = arg_171_1:FormatText(arg_171_1:GetWordFromCfg(324781041).content)

				arg_171_1.text_.text = var_174_1

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_3 = 30 <= 0 and var_174_0 or var_174_0 * (utf8.len(var_174_1) / 30)

				if (30 <= 0 and var_174_0 or var_174_0 * (utf8.len(var_174_1) / 30)) > 0 and var_174_0 < var_174_3 then
					arg_171_1.talkMaxDuration = var_174_3

					if var_174_3 + 0 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_3 + 0
					end
				end

				arg_171_1.text_.text = var_174_1
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)
				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_4 = math.max(var_174_0, arg_171_1.talkMaxDuration)

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_4 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - 0) / var_174_4

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= 0 + var_174_4 and arg_171_1.time_ < 0 + var_174_4 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {}

		arg_171_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST2007",
		"TextureConfig/Background/J27f"
	},
	voices = {
		"story_v_out_324781.awb"
	}
}
