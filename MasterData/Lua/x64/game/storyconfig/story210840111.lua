return {
	Play1108411001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 1108411001
		arg_1_1.duration_ = 3.93

		local var_1_0 = {
			zh = 3.33333333333333,
			ja = 3.93333333333333
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
				arg_1_0:Play1108411002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.STblack == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack")
				var_4_0.name = "STblack"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.STblack = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.STblack

				arg_1_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "STblack" then
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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_12 = 1.13333333333333
			local var_4_13 = 0.5

			if 1.13333333333333 < arg_1_1.time_ and arg_1_1.time_ <= var_4_12 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_14 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_14:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_15 = arg_1_1:GetWordFromCfg(1108411001)
				local var_4_16 = arg_1_1:FormatText(var_4_15.content)

				arg_1_1.text_.text = var_4_16

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_18 = 20 <= 0 and var_4_13 or var_4_13 * (utf8.len(var_4_16) / 20)

				if (20 <= 0 and var_4_13 or var_4_13 * (utf8.len(var_4_16) / 20)) > 0 and var_4_13 < var_4_18 then
					arg_1_1.talkMaxDuration = var_4_18
					var_4_12 = var_4_12 + 0.3

					if var_4_18 + var_4_12 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_18 + var_4_12
					end
				end

				arg_1_1.text_.text = var_4_16
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411001", "story_v_side_new_1108411.awb") ~= 0 then
					local var_4_19 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411001", "story_v_side_new_1108411.awb") / 1000

					if var_4_19 + var_4_12 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_19 + var_4_12
					end

					if var_4_15.prefab_name ~= "" and arg_1_1.actors_[var_4_15.prefab_name] ~= nil then
						local var_4_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_15.prefab_name].transform, "story_v_side_new_1108411", "1108411001", "story_v_side_new_1108411.awb")

						arg_1_1:RecordAudio("1108411001", var_4_20)
						arg_1_1:RecordAudio("1108411001", var_4_20)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411001", "story_v_side_new_1108411.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411001", "story_v_side_new_1108411.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_21 = var_4_12 + 0.3
			local var_4_22 = math.max(var_4_13, arg_1_1.talkMaxDuration)

			if var_4_12 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_21 + var_4_22 then
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
	Play1108411002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 1108411002
		arg_8_1.duration_ = 5.83

		local var_8_0 = {
			zh = 4.9,
			ja = 5.833
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
				arg_8_0:Play1108411003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0.425

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				arg_8_1.leftNameTxt_.text = arg_8_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_1 = arg_8_1:GetWordFromCfg(1108411002)
				local var_11_2 = arg_8_1:FormatText(var_11_1.content)

				arg_8_1.text_.text = var_11_2

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_4 = 17 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_2) / 17)

				if (17 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_2) / 17)) > 0 and var_11_0 < var_11_4 then
					arg_8_1.talkMaxDuration = var_11_4

					if var_11_4 + 0 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_4 + 0
					end
				end

				arg_8_1.text_.text = var_11_2
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411002", "story_v_side_new_1108411.awb") ~= 0 then
					local var_11_5 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411002", "story_v_side_new_1108411.awb") / 1000

					if var_11_5 + 0 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_5 + 0
					end

					if var_11_1.prefab_name ~= "" and arg_8_1.actors_[var_11_1.prefab_name] ~= nil then
						local var_11_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_1.prefab_name].transform, "story_v_side_new_1108411", "1108411002", "story_v_side_new_1108411.awb")

						arg_8_1:RecordAudio("1108411002", var_11_6)
						arg_8_1:RecordAudio("1108411002", var_11_6)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411002", "story_v_side_new_1108411.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411002", "story_v_side_new_1108411.awb")
				end

				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_7 = math.max(var_11_0, arg_8_1.talkMaxDuration)

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_7 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - 0) / var_11_7

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= 0 + var_11_7 and arg_8_1.time_ < 0 + var_11_7 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play1108411003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 1108411003
		arg_12_1.duration_ = 3.77

		local var_12_0 = {
			zh = 3,
			ja = 3.766
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
				arg_12_0:Play1108411004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 0.35

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				arg_12_1.leftNameTxt_.text = arg_12_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_1 = arg_12_1:GetWordFromCfg(1108411003)
				local var_15_2 = arg_12_1:FormatText(var_15_1.content)

				arg_12_1.text_.text = var_15_2

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_4 = 14 <= 0 and var_15_0 or var_15_0 * (utf8.len(var_15_2) / 14)

				if (14 <= 0 and var_15_0 or var_15_0 * (utf8.len(var_15_2) / 14)) > 0 and var_15_0 < var_15_4 then
					arg_12_1.talkMaxDuration = var_15_4

					if var_15_4 + 0 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_4 + 0
					end
				end

				arg_12_1.text_.text = var_15_2
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411003", "story_v_side_new_1108411.awb") ~= 0 then
					local var_15_5 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411003", "story_v_side_new_1108411.awb") / 1000

					if var_15_5 + 0 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_5 + 0
					end

					if var_15_1.prefab_name ~= "" and arg_12_1.actors_[var_15_1.prefab_name] ~= nil then
						local var_15_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_1.prefab_name].transform, "story_v_side_new_1108411", "1108411003", "story_v_side_new_1108411.awb")

						arg_12_1:RecordAudio("1108411003", var_15_6)
						arg_12_1:RecordAudio("1108411003", var_15_6)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411003", "story_v_side_new_1108411.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411003", "story_v_side_new_1108411.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_7 = math.max(var_15_0, arg_12_1.talkMaxDuration)

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_7 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - 0) / var_15_7

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= 0 + var_15_7 and arg_12_1.time_ < 0 + var_15_7 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play1108411004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 1108411004
		arg_16_1.duration_ = 3.7

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play1108411005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			if arg_16_1.bgs_.ST01 == nil then
				local var_19_0 = Object.Instantiate(arg_16_1.paintGo_)

				var_19_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST01")
				var_19_0.name = "ST01"
				var_19_0.transform.parent = arg_16_1.stage_.transform
				var_19_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_16_1.bgs_.ST01 = var_19_0
			end

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				local var_19_1 = arg_16_1.bgs_.ST01

				arg_16_1.bgs_.ST01.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_19_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_19_2 = var_19_1:GetComponent("SpriteRenderer")

				if var_19_2 and var_19_2.sprite then
					local var_19_3 = 2 * (var_19_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_19_1.transform.localScale = Vector3.New(var_19_3 / var_19_2.sprite.bounds.size.y < var_19_3 * manager.ui.mainCameraCom_.aspect / var_19_2.sprite.bounds.size.x and var_19_3 * manager.ui.mainCameraCom_.aspect / var_19_2.sprite.bounds.size.x or var_19_3 / var_19_2.sprite.bounds.size.y, var_19_3 / var_19_2.sprite.bounds.size.y < var_19_3 * manager.ui.mainCameraCom_.aspect / var_19_2.sprite.bounds.size.x and var_19_3 * manager.ui.mainCameraCom_.aspect / var_19_2.sprite.bounds.size.x or var_19_3 / var_19_2.sprite.bounds.size.y, 0)
				end

				for iter_19_0, iter_19_1 in pairs(arg_16_1.bgs_) do
					if iter_19_0 ~= "ST01" then
						iter_19_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_19_4 = 0

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_4 + arg_19_0 then
				arg_16_1.allBtn_.enabled = false
			end

			if arg_16_1.time_ >= var_19_4 + 0.3 and arg_16_1.time_ < var_19_4 + 0.3 + arg_19_0 then
				arg_16_1.allBtn_.enabled = true
			end

			local var_19_5 = 0

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_5 + arg_19_0 then
				arg_16_1.mask_.enabled = true
				arg_16_1.mask_.raycastTarget = true

				arg_16_1:SetGaussion(false)
			end

			local var_19_6 = 1.999999999999

			if var_19_5 <= arg_16_1.time_ and arg_16_1.time_ < var_19_5 + var_19_6 then
				local var_19_7 = Color.New(0, 0, 0)

				var_19_7.a = Mathf.Lerp(1, 0, (arg_16_1.time_ - var_19_5) / var_19_6)
				arg_16_1.mask_.color = var_19_7
			end

			if arg_16_1.time_ >= var_19_5 + var_19_6 and arg_16_1.time_ < var_19_5 + var_19_6 + arg_19_0 then
				local var_19_8 = Color.New(0, 0, 0)

				arg_16_1.mask_.enabled = false
				var_19_8.a = 0
				arg_16_1.mask_.color = var_19_8
			end

			local var_19_9 = "10102ui_story"

			if arg_16_1.actors_["10102ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10102ui_story"))) then
				local var_19_10 = Object.Instantiate(Asset.Load("Char/" .. "10102ui_story"), arg_16_1.stage_.transform)

				var_19_10.name = var_19_9
				var_19_10.transform.localPosition = Vector3.New(0, 100, 0)
				arg_16_1.actors_[var_19_9] = var_19_10

				local var_19_11 = var_19_10:GetComponentInChildren(typeof(CharacterEffect))

				var_19_11.enabled = true

				local var_19_12 = GameObjectTools.GetOrAddComponent(var_19_10, typeof(DynamicBoneHelper))

				if var_19_12 then
					var_19_12:EnableDynamicBone(false)
				end

				arg_16_1:ShowWeapon(var_19_11.transform, false)

				arg_16_1.var_[var_19_9 .. "Animator"] = var_19_11.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_16_1.var_[var_19_9 .. "Animator"].applyRootMotion = true
				arg_16_1.var_[var_19_9 .. "LipSync"] = var_19_11.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_19_13 = arg_16_1.actors_["10102ui_story"].transform

			if 1.7 < arg_16_1.time_ and arg_16_1.time_ <= 1.7 + arg_19_0 then
				arg_16_1.var_.moveOldPos10102ui_story = var_19_13.localPosition
			end

			local var_19_14 = 0.001

			if 1.7 <= arg_16_1.time_ and arg_16_1.time_ < 1.7 + var_19_14 then
				var_19_13.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos10102ui_story, Vector3.New(0, -0.985, -6.275), (arg_16_1.time_ - 1.7) / var_19_14)
				var_19_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_19_13.position).x, (manager.ui.mainCamera.transform.position - var_19_13.position).y, (manager.ui.mainCamera.transform.position - var_19_13.position).z)
				var_19_13.localEulerAngles.z = 0
				var_19_13.localEulerAngles.x = 0
				var_19_13.localEulerAngles = var_19_13.localEulerAngles
			end

			if arg_16_1.time_ >= 1.7 + var_19_14 and arg_16_1.time_ < 1.7 + var_19_14 + arg_19_0 then
				var_19_13.localPosition = Vector3.New(0, -0.985, -6.275)
				var_19_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_19_13.position).x, (manager.ui.mainCamera.transform.position - var_19_13.position).y, (manager.ui.mainCamera.transform.position - var_19_13.position).z)
				var_19_13.localEulerAngles.z = 0
				var_19_13.localEulerAngles.x = 0
				var_19_13.localEulerAngles = var_19_13.localEulerAngles
			end

			local var_19_15 = arg_16_1.actors_["10102ui_story"]

			if 1.7 < arg_16_1.time_ and arg_16_1.time_ <= 1.7 + arg_19_0 and not isNil(var_19_15) and arg_16_1.var_.characterEffect10102ui_story == nil then
				arg_16_1.var_.characterEffect10102ui_story = var_19_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_16 = 0.200000002980232

			if 1.7 <= arg_16_1.time_ and arg_16_1.time_ < 1.7 + var_19_16 and not isNil(var_19_15) then
				if arg_16_1.var_.characterEffect10102ui_story and not isNil(var_19_15) then
					arg_16_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_16_1.time_ >= 1.7 + var_19_16 and arg_16_1.time_ < 1.7 + var_19_16 + arg_19_0 and not isNil(var_19_15) and arg_16_1.var_.characterEffect10102ui_story then
				arg_16_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 1.7 < arg_16_1.time_ and arg_16_1.time_ <= 1.7 + arg_19_0 then
				arg_16_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action1_1")
			end

			if 1.13333333333333 < arg_16_1.time_ and arg_16_1.time_ <= 1.13333333333333 + arg_19_0 then
				arg_16_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_19_20 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_16_1.bgmTxt_.text ~= var_19_20 and arg_16_1.bgmTxt_.text ~= "" then
						if arg_16_1.bgmTxt2_.text ~= "" then
							arg_16_1.bgmTxt_.text = arg_16_1.bgmTxt2_.text
						end

						arg_16_1.bgmTxt2_.text = var_19_20

						arg_16_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_16_1.bgmTxt_.text = var_19_20
						arg_16_1.bgmTxt2_.text = var_19_20
					end

					if arg_16_1.bgmTimer then
						arg_16_1.bgmTimer:Stop()

						arg_16_1.bgmTimer = nil
					end

					if arg_16_1.settingData.show_music_name == 1 then
						arg_16_1.musicController:SetSelectedState("show")
						arg_16_1.musicAnimator_:Play("open", 0, 0)

						if arg_16_1.settingData.music_time ~= 0 then
							arg_16_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_16_1.settingData.music_time), function()
								if arg_16_1 == nil or isNil(arg_16_1.bgmTxt_) then
									return
								end

								arg_16_1.musicController:SetSelectedState("hide")
								arg_16_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.466666666666667 < arg_16_1.time_ and arg_16_1.time_ <= 0.466666666666667 + arg_19_0 then
				arg_16_1:AudioAction("play", "music", "bgm_side_daily01", "bgm_side_daily01", "bgm_side_daily01.awb")

				local var_19_23 = manager.audio:GetAudioName("bgm_side_daily01", "bgm_side_daily01")

				if "" ~= "" then
					if arg_16_1.bgmTxt_.text ~= var_19_23 and arg_16_1.bgmTxt_.text ~= "" then
						if arg_16_1.bgmTxt2_.text ~= "" then
							arg_16_1.bgmTxt_.text = arg_16_1.bgmTxt2_.text
						end

						arg_16_1.bgmTxt2_.text = var_19_23

						arg_16_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_16_1.bgmTxt_.text = var_19_23
						arg_16_1.bgmTxt2_.text = var_19_23
					end

					if arg_16_1.bgmTimer then
						arg_16_1.bgmTimer:Stop()

						arg_16_1.bgmTimer = nil
					end

					if arg_16_1.settingData.show_music_name == 1 then
						arg_16_1.musicController:SetSelectedState("show")
						arg_16_1.musicAnimator_:Play("open", 0, 0)

						if arg_16_1.settingData.music_time ~= 0 then
							arg_16_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_16_1.settingData.music_time), function()
								if arg_16_1 == nil or isNil(arg_16_1.bgmTxt_) then
									return
								end

								arg_16_1.musicController:SetSelectedState("hide")
								arg_16_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.166666666666667 < arg_16_1.time_ and arg_16_1.time_ <= 0.166666666666667 + arg_19_0 then
				arg_16_1:AudioAction("play", "effect", "se_story_birthday4", "se_story_birthday4_amb_room_tone_1", "")
			end

			if 1.46666666666667 < arg_16_1.time_ and arg_16_1.time_ <= 1.46666666666667 + arg_19_0 then
				arg_16_1:AudioAction("play", "effect", "se_story_144", "se_story_144_door_open", "")
			end

			if arg_16_1.frameCnt_ <= 1 then
				arg_16_1.dialog_:SetActive(false)
			end

			local var_19_26 = 1.949999999999
			local var_19_27 = 0.05

			if 1.949999999999 < arg_16_1.time_ and arg_16_1.time_ <= var_19_26 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0

				arg_16_1.dialog_:SetActive(true)

				arg_16_1.dialogCg_.alpha = 0

				local var_19_28 = LeanTween.value(arg_16_1.dialog_, 0, 1, 0.3)

				var_19_28:setOnUpdate(LuaHelper.FloatAction(function(arg_22_0)
					arg_16_1.dialogCg_.alpha = arg_22_0
				end))
				var_19_28:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_16_1.dialog_)
					var_19_28:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_16_1.duration_ = arg_16_1.duration_ + 0.3

				SetActive(arg_16_1.leftNameGo_, true)

				arg_16_1.leftNameTxt_.text = arg_16_1:FormatText(StoryNameCfg[334].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_29 = arg_16_1:GetWordFromCfg(1108411004)
				local var_19_30 = arg_16_1:FormatText(var_19_29.content)

				arg_16_1.text_.text = var_19_30

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_32 = 2 <= 0 and var_19_27 or var_19_27 * (utf8.len(var_19_30) / 2)

				if (2 <= 0 and var_19_27 or var_19_27 * (utf8.len(var_19_30) / 2)) > 0 and var_19_27 < var_19_32 then
					arg_16_1.talkMaxDuration = var_19_32
					var_19_26 = var_19_26 + 0.3

					if var_19_32 + var_19_26 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_32 + var_19_26
					end
				end

				arg_16_1.text_.text = var_19_30
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411004", "story_v_side_new_1108411.awb") ~= 0 then
					local var_19_33 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411004", "story_v_side_new_1108411.awb") / 1000

					if var_19_33 + var_19_26 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_33 + var_19_26
					end

					if var_19_29.prefab_name ~= "" and arg_16_1.actors_[var_19_29.prefab_name] ~= nil then
						local var_19_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_29.prefab_name].transform, "story_v_side_new_1108411", "1108411004", "story_v_side_new_1108411.awb")

						arg_16_1:RecordAudio("1108411004", var_19_34)
						arg_16_1:RecordAudio("1108411004", var_19_34)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411004", "story_v_side_new_1108411.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411004", "story_v_side_new_1108411.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_35 = var_19_26 + 0.3
			local var_19_36 = math.max(var_19_27, arg_16_1.talkMaxDuration)

			if var_19_26 + 0.3 <= arg_16_1.time_ and arg_16_1.time_ < var_19_35 + var_19_36 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_35) / var_19_36

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_35 + var_19_36 and arg_16_1.time_ < var_19_35 + var_19_36 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.7,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_16_1:InitPlayNodeList()
	end,
	Play1108411005 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 1108411005
		arg_24_1.duration_ = 1

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"

			SetActive(arg_24_1.choicesGo_, true)

			for iter_25_0, iter_25_1 in ipairs(arg_24_1.choices_) do
				SetActive(iter_25_1.go, iter_25_0 <= 2)
			end

			arg_24_1.choices_[1].txt.text = arg_24_1:FormatText(StoryChoiceCfg[1541].name)
			arg_24_1.choices_[2].txt.text = arg_24_1:FormatText(StoryChoiceCfg[1542].name)
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play1108411006(arg_24_1)
			end

			if arg_26_0 == 2 then
				arg_24_0:Play1108411009(arg_24_1)
			end

			arg_24_1:RecordChoiceLog(1108411005, 1541, 1542)
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 and not isNil(arg_24_1.actors_["10102ui_story"]) and arg_24_1.var_.characterEffect10102ui_story == nil then
				arg_24_1.var_.characterEffect10102ui_story = arg_24_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_0 = 0.200000002980232

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_0 and not isNil(arg_24_1.actors_["10102ui_story"]) then
				if arg_24_1.var_.characterEffect10102ui_story and not isNil(arg_24_1.actors_["10102ui_story"]) then
					arg_24_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_24_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_24_1.time_ - 0) / var_27_0)
				end
			end

			if arg_24_1.time_ >= 0 + var_27_0 and arg_24_1.time_ < 0 + var_27_0 + arg_27_0 and not isNil(arg_24_1.actors_["10102ui_story"]) and arg_24_1.var_.characterEffect10102ui_story then
				arg_24_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_24_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play1108411006 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 1108411006
		arg_28_1.duration_ = 5.9

		local var_28_0 = {
			zh = 3.2,
			ja = 5.9
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
				arg_28_0:Play1108411007(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 and not isNil(arg_28_1.actors_["10102ui_story"]) and arg_28_1.var_.characterEffect10102ui_story == nil then
				arg_28_1.var_.characterEffect10102ui_story = arg_28_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_0 = 0.200000002980232

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_0 and not isNil(arg_28_1.actors_["10102ui_story"]) then
				if arg_28_1.var_.characterEffect10102ui_story and not isNil(arg_28_1.actors_["10102ui_story"]) then
					arg_28_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_28_1.time_ >= 0 + var_31_0 and arg_28_1.time_ < 0 + var_31_0 + arg_31_0 and not isNil(arg_28_1.actors_["10102ui_story"]) and arg_28_1.var_.characterEffect10102ui_story then
				arg_28_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action5_1")
			end

			local var_31_2 = 0
			local var_31_3 = 0.325

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_2 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				arg_28_1.leftNameTxt_.text = arg_28_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_4 = arg_28_1:GetWordFromCfg(1108411006)
				local var_31_5 = arg_28_1:FormatText(var_31_4.content)

				arg_28_1.text_.text = var_31_5

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_7 = 13 <= 0 and var_31_3 or var_31_3 * (utf8.len(var_31_5) / 13)

				if (13 <= 0 and var_31_3 or var_31_3 * (utf8.len(var_31_5) / 13)) > 0 and var_31_3 < var_31_7 then
					arg_28_1.talkMaxDuration = var_31_7

					if var_31_7 + var_31_2 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_7 + var_31_2
					end
				end

				arg_28_1.text_.text = var_31_5
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411006", "story_v_side_new_1108411.awb") ~= 0 then
					local var_31_8 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411006", "story_v_side_new_1108411.awb") / 1000

					if var_31_8 + var_31_2 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_8 + var_31_2
					end

					if var_31_4.prefab_name ~= "" and arg_28_1.actors_[var_31_4.prefab_name] ~= nil then
						local var_31_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_4.prefab_name].transform, "story_v_side_new_1108411", "1108411006", "story_v_side_new_1108411.awb")

						arg_28_1:RecordAudio("1108411006", var_31_9)
						arg_28_1:RecordAudio("1108411006", var_31_9)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411006", "story_v_side_new_1108411.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411006", "story_v_side_new_1108411.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_10 = math.max(var_31_3, arg_28_1.talkMaxDuration)

			if var_31_2 <= arg_28_1.time_ and arg_28_1.time_ < var_31_2 + var_31_10 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_2) / var_31_10

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_2 + var_31_10 and arg_28_1.time_ < var_31_2 + var_31_10 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play1108411007 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 1108411007
		arg_32_1.duration_ = 4.7

		local var_32_0 = {
			zh = 4,
			ja = 4.7
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
				arg_32_0:Play1108411008(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = 0.325

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
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

				local var_35_1 = arg_32_1:GetWordFromCfg(1108411007)
				local var_35_2 = arg_32_1:FormatText(var_35_1.content)

				arg_32_1.text_.text = var_35_2

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_4 = 13 <= 0 and var_35_0 or var_35_0 * (utf8.len(var_35_2) / 13)

				if (13 <= 0 and var_35_0 or var_35_0 * (utf8.len(var_35_2) / 13)) > 0 and var_35_0 < var_35_4 then
					arg_32_1.talkMaxDuration = var_35_4

					if var_35_4 + 0 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_4 + 0
					end
				end

				arg_32_1.text_.text = var_35_2
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411007", "story_v_side_new_1108411.awb") ~= 0 then
					local var_35_5 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411007", "story_v_side_new_1108411.awb") / 1000

					if var_35_5 + 0 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_5 + 0
					end

					if var_35_1.prefab_name ~= "" and arg_32_1.actors_[var_35_1.prefab_name] ~= nil then
						local var_35_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_1.prefab_name].transform, "story_v_side_new_1108411", "1108411007", "story_v_side_new_1108411.awb")

						arg_32_1:RecordAudio("1108411007", var_35_6)
						arg_32_1:RecordAudio("1108411007", var_35_6)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411007", "story_v_side_new_1108411.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411007", "story_v_side_new_1108411.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_7 = math.max(var_35_0, arg_32_1.talkMaxDuration)

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_7 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - 0) / var_35_7

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= 0 + var_35_7 and arg_32_1.time_ < 0 + var_35_7 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play1108411008 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 1108411008
		arg_36_1.duration_ = 3.5

		local var_36_0 = {
			zh = 3,
			ja = 3.5
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
				arg_36_0:Play1108411009(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action5_2")
			end

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_gandong", "EmotionTimelineAnimator")
			end

			local var_39_0 = 0
			local var_39_1 = 0.325

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_0 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				arg_36_1.leftNameTxt_.text = arg_36_1:FormatText(StoryNameCfg[334].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_2 = arg_36_1:GetWordFromCfg(1108411008)
				local var_39_3 = arg_36_1:FormatText(var_39_2.content)

				arg_36_1.text_.text = var_39_3

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_5 = 13 <= 0 and var_39_1 or var_39_1 * (utf8.len(var_39_3) / 13)

				if (13 <= 0 and var_39_1 or var_39_1 * (utf8.len(var_39_3) / 13)) > 0 and var_39_1 < var_39_5 then
					arg_36_1.talkMaxDuration = var_39_5

					if var_39_5 + var_39_0 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_5 + var_39_0
					end
				end

				arg_36_1.text_.text = var_39_3
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411008", "story_v_side_new_1108411.awb") ~= 0 then
					local var_39_6 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411008", "story_v_side_new_1108411.awb") / 1000

					if var_39_6 + var_39_0 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_6 + var_39_0
					end

					if var_39_2.prefab_name ~= "" and arg_36_1.actors_[var_39_2.prefab_name] ~= nil then
						local var_39_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_2.prefab_name].transform, "story_v_side_new_1108411", "1108411008", "story_v_side_new_1108411.awb")

						arg_36_1:RecordAudio("1108411008", var_39_7)
						arg_36_1:RecordAudio("1108411008", var_39_7)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411008", "story_v_side_new_1108411.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411008", "story_v_side_new_1108411.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_8 = math.max(var_39_1, arg_36_1.talkMaxDuration)

			if var_39_0 <= arg_36_1.time_ and arg_36_1.time_ < var_39_0 + var_39_8 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_0) / var_39_8

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_0 + var_39_8 and arg_36_1.time_ < var_39_0 + var_39_8 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play1108411009 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 1108411009
		arg_40_1.duration_ = 4.67

		local var_40_0 = {
			zh = 3.066,
			ja = 4.666
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
				arg_40_0:Play1108411010(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			if arg_40_1.actors_["10102ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10102ui_story"))) then
				local var_43_0 = Object.Instantiate(Asset.Load("Char/" .. "10102ui_story"), arg_40_1.stage_.transform)

				var_43_0.name = "10102ui_story"
				var_43_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_40_1.actors_["10102ui_story"] = var_43_0

				local var_43_1 = var_43_0:GetComponentInChildren(typeof(CharacterEffect))

				var_43_1.enabled = true

				local var_43_2 = GameObjectTools.GetOrAddComponent(var_43_0, typeof(DynamicBoneHelper))

				if var_43_2 then
					var_43_2:EnableDynamicBone(false)
				end

				arg_40_1:ShowWeapon(var_43_1.transform, false)

				arg_40_1.var_["10102ui_story" .. "Animator"] = var_43_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_40_1.var_["10102ui_story" .. "Animator"].applyRootMotion = true
				arg_40_1.var_["10102ui_story" .. "LipSync"] = var_43_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action5_1")
			end

			local var_43_3 = "10102ui_story"

			if arg_40_1.actors_["10102ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10102ui_story"))) then
				local var_43_4 = Object.Instantiate(Asset.Load("Char/" .. "10102ui_story"), arg_40_1.stage_.transform)

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

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_43_7 = arg_40_1.actors_["10102ui_story"]

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 and not isNil(var_43_7) and arg_40_1.var_.characterEffect10102ui_story == nil then
				arg_40_1.var_.characterEffect10102ui_story = var_43_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_8 = 0.200000002980232

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_8 and not isNil(var_43_7) then
				if arg_40_1.var_.characterEffect10102ui_story and not isNil(var_43_7) then
					arg_40_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_40_1.time_ >= 0 + var_43_8 and arg_40_1.time_ < 0 + var_43_8 + arg_43_0 and not isNil(var_43_7) and arg_40_1.var_.characterEffect10102ui_story then
				arg_40_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_43_10 = 0
			local var_43_11 = 0.35

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_10 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				arg_40_1.leftNameTxt_.text = arg_40_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_12 = arg_40_1:GetWordFromCfg(1108411009)
				local var_43_13 = arg_40_1:FormatText(var_43_12.content)

				arg_40_1.text_.text = var_43_13

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_15 = 14 <= 0 and var_43_11 or var_43_11 * (utf8.len(var_43_13) / 14)

				if (14 <= 0 and var_43_11 or var_43_11 * (utf8.len(var_43_13) / 14)) > 0 and var_43_11 < var_43_15 then
					arg_40_1.talkMaxDuration = var_43_15

					if var_43_15 + var_43_10 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_15 + var_43_10
					end
				end

				arg_40_1.text_.text = var_43_13
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411009", "story_v_side_new_1108411.awb") ~= 0 then
					local var_43_16 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411009", "story_v_side_new_1108411.awb") / 1000

					if var_43_16 + var_43_10 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_16 + var_43_10
					end

					if var_43_12.prefab_name ~= "" and arg_40_1.actors_[var_43_12.prefab_name] ~= nil then
						local var_43_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_12.prefab_name].transform, "story_v_side_new_1108411", "1108411009", "story_v_side_new_1108411.awb")

						arg_40_1:RecordAudio("1108411009", var_43_17)
						arg_40_1:RecordAudio("1108411009", var_43_17)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411009", "story_v_side_new_1108411.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411009", "story_v_side_new_1108411.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_18 = math.max(var_43_11, arg_40_1.talkMaxDuration)

			if var_43_10 <= arg_40_1.time_ and arg_40_1.time_ < var_43_10 + var_43_18 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_10) / var_43_18

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_10 + var_43_18 and arg_40_1.time_ < var_43_10 + var_43_18 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play1108411010 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 1108411010
		arg_44_1.duration_ = 10.63

		local var_44_0 = {
			zh = 6.5,
			ja = 10.633
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
				arg_44_0:Play1108411011(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action5_2")
			end

			local var_47_0 = 0
			local var_47_1 = 0.75

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_0 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				arg_44_1.leftNameTxt_.text = arg_44_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_2 = arg_44_1:GetWordFromCfg(1108411010)
				local var_47_3 = arg_44_1:FormatText(var_47_2.content)

				arg_44_1.text_.text = var_47_3

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_5 = 30 <= 0 and var_47_1 or var_47_1 * (utf8.len(var_47_3) / 30)

				if (30 <= 0 and var_47_1 or var_47_1 * (utf8.len(var_47_3) / 30)) > 0 and var_47_1 < var_47_5 then
					arg_44_1.talkMaxDuration = var_47_5

					if var_47_5 + var_47_0 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_5 + var_47_0
					end
				end

				arg_44_1.text_.text = var_47_3
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411010", "story_v_side_new_1108411.awb") ~= 0 then
					local var_47_6 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411010", "story_v_side_new_1108411.awb") / 1000

					if var_47_6 + var_47_0 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_6 + var_47_0
					end

					if var_47_2.prefab_name ~= "" and arg_44_1.actors_[var_47_2.prefab_name] ~= nil then
						local var_47_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_2.prefab_name].transform, "story_v_side_new_1108411", "1108411010", "story_v_side_new_1108411.awb")

						arg_44_1:RecordAudio("1108411010", var_47_7)
						arg_44_1:RecordAudio("1108411010", var_47_7)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411010", "story_v_side_new_1108411.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411010", "story_v_side_new_1108411.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_8 = math.max(var_47_1, arg_44_1.talkMaxDuration)

			if var_47_0 <= arg_44_1.time_ and arg_44_1.time_ < var_47_0 + var_47_8 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_0) / var_47_8

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_0 + var_47_8 and arg_44_1.time_ < var_47_0 + var_47_8 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play1108411011 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 1108411011
		arg_48_1.duration_ = 5

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play1108411012(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1.var_.moveOldPos10102ui_story = arg_48_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_51_0 = 0.001

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_0 then
				arg_48_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos10102ui_story, Vector3.New(0, 100, 0), (arg_48_1.time_ - 0) / var_51_0)
				arg_48_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_48_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_48_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_48_1.actors_["10102ui_story"].transform.position).z)
				arg_48_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_48_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_48_1.actors_["10102ui_story"].transform.localEulerAngles = arg_48_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_48_1.time_ >= 0 + var_51_0 and arg_48_1.time_ < 0 + var_51_0 + arg_51_0 then
				arg_48_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_48_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_48_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_48_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_48_1.actors_["10102ui_story"].transform.position).z)
				arg_48_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_48_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_48_1.actors_["10102ui_story"].transform.localEulerAngles = arg_48_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_51_1 = arg_48_1.actors_["10102ui_story"]

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 and not isNil(var_51_1) and arg_48_1.var_.characterEffect10102ui_story == nil then
				arg_48_1.var_.characterEffect10102ui_story = var_51_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_2 = 0.200000002980232

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_2 and not isNil(var_51_1) then
				if arg_48_1.var_.characterEffect10102ui_story and not isNil(var_51_1) then
					arg_48_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_48_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_48_1.time_ - 0) / var_51_2)
				end
			end

			if arg_48_1.time_ >= 0 + var_51_2 and arg_48_1.time_ < 0 + var_51_2 + arg_51_0 and not isNil(var_51_1) and arg_48_1.var_.characterEffect10102ui_story then
				arg_48_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_48_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_51_3 = 0
			local var_51_4 = 1.3

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_3 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, false)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_5 = arg_48_1:FormatText(arg_48_1:GetWordFromCfg(1108411011).content)

				arg_48_1.text_.text = var_51_5

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_7 = 52 <= 0 and var_51_4 or var_51_4 * (utf8.len(var_51_5) / 52)

				if (52 <= 0 and var_51_4 or var_51_4 * (utf8.len(var_51_5) / 52)) > 0 and var_51_4 < var_51_7 then
					arg_48_1.talkMaxDuration = var_51_7

					if var_51_7 + var_51_3 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_7 + var_51_3
					end
				end

				arg_48_1.text_.text = var_51_5
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)
				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_8 = math.max(var_51_4, arg_48_1.talkMaxDuration)

			if var_51_3 <= arg_48_1.time_ and arg_48_1.time_ < var_51_3 + var_51_8 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_3) / var_51_8

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_3 + var_51_8 and arg_48_1.time_ < var_51_3 + var_51_8 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_48_1:InitPlayNodeList()
	end,
	Play1108411012 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 1108411012
		arg_52_1.duration_ = 5

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play1108411013(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = 1.15

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, false)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_1 = arg_52_1:FormatText(arg_52_1:GetWordFromCfg(1108411012).content)

				arg_52_1.text_.text = var_55_1

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_3 = 46 <= 0 and var_55_0 or var_55_0 * (utf8.len(var_55_1) / 46)

				if (46 <= 0 and var_55_0 or var_55_0 * (utf8.len(var_55_1) / 46)) > 0 and var_55_0 < var_55_3 then
					arg_52_1.talkMaxDuration = var_55_3

					if var_55_3 + 0 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_3 + 0
					end
				end

				arg_52_1.text_.text = var_55_1
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)
				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_4 = math.max(var_55_0, arg_52_1.talkMaxDuration)

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_4 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - 0) / var_55_4

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= 0 + var_55_4 and arg_52_1.time_ < 0 + var_55_4 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play1108411013 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 1108411013
		arg_56_1.duration_ = 5

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play1108411014(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = 0.7

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				arg_56_1.leftNameTxt_.text = arg_56_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, true)
				arg_56_1.iconController_:SetSelectedState("hero")

				arg_56_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_56_1.callingController_:SetSelectedState("normal")

				arg_56_1.keyicon_.color = Color.New(1, 1, 1)
				arg_56_1.icon_.color = Color.New(1, 1, 1)

				local var_59_1 = arg_56_1:FormatText(arg_56_1:GetWordFromCfg(1108411013).content)

				arg_56_1.text_.text = var_59_1

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_3 = 28 <= 0 and var_59_0 or var_59_0 * (utf8.len(var_59_1) / 28)

				if (28 <= 0 and var_59_0 or var_59_0 * (utf8.len(var_59_1) / 28)) > 0 and var_59_0 < var_59_3 then
					arg_56_1.talkMaxDuration = var_59_3

					if var_59_3 + 0 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_3 + 0
					end
				end

				arg_56_1.text_.text = var_59_1
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)
				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_4 = math.max(var_59_0, arg_56_1.talkMaxDuration)

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_4 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - 0) / var_59_4

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= 0 + var_59_4 and arg_56_1.time_ < 0 + var_59_4 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play1108411014 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 1108411014
		arg_60_1.duration_ = 5.5

		local var_60_0 = {
			zh = 3.666,
			ja = 5.5
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
				arg_60_0:Play1108411015(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1.var_.moveOldPos10102ui_story = arg_60_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_63_0 = 0.001

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_0 then
				arg_60_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_60_1.var_.moveOldPos10102ui_story, Vector3.New(0, -0.985, -6.275), (arg_60_1.time_ - 0) / var_63_0)
				arg_60_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_60_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_60_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_60_1.actors_["10102ui_story"].transform.position).z)
				arg_60_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_60_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_60_1.actors_["10102ui_story"].transform.localEulerAngles = arg_60_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_60_1.time_ >= 0 + var_63_0 and arg_60_1.time_ < 0 + var_63_0 + arg_63_0 then
				arg_60_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6.275)
				arg_60_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_60_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_60_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_60_1.actors_["10102ui_story"].transform.position).z)
				arg_60_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_60_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_60_1.actors_["10102ui_story"].transform.localEulerAngles = arg_60_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_63_1 = arg_60_1.actors_["10102ui_story"]

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 and not isNil(var_63_1) and arg_60_1.var_.characterEffect10102ui_story == nil then
				arg_60_1.var_.characterEffect10102ui_story = var_63_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_2 = 0.200000002980232

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_2 and not isNil(var_63_1) then
				if arg_60_1.var_.characterEffect10102ui_story and not isNil(var_63_1) then
					arg_60_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_60_1.time_ >= 0 + var_63_2 and arg_60_1.time_ < 0 + var_63_2 + arg_63_0 and not isNil(var_63_1) and arg_60_1.var_.characterEffect10102ui_story then
				arg_60_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action7_1")
			end

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_63_4 = 0
			local var_63_5 = 0.475

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

				local var_63_6 = arg_60_1:GetWordFromCfg(1108411014)
				local var_63_7 = arg_60_1:FormatText(var_63_6.content)

				arg_60_1.text_.text = var_63_7

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_9 = 19 <= 0 and var_63_5 or var_63_5 * (utf8.len(var_63_7) / 19)

				if (19 <= 0 and var_63_5 or var_63_5 * (utf8.len(var_63_7) / 19)) > 0 and var_63_5 < var_63_9 then
					arg_60_1.talkMaxDuration = var_63_9

					if var_63_9 + var_63_4 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_9 + var_63_4
					end
				end

				arg_60_1.text_.text = var_63_7
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411014", "story_v_side_new_1108411.awb") ~= 0 then
					local var_63_10 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411014", "story_v_side_new_1108411.awb") / 1000

					if var_63_10 + var_63_4 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_10 + var_63_4
					end

					if var_63_6.prefab_name ~= "" and arg_60_1.actors_[var_63_6.prefab_name] ~= nil then
						local var_63_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_6.prefab_name].transform, "story_v_side_new_1108411", "1108411014", "story_v_side_new_1108411.awb")

						arg_60_1:RecordAudio("1108411014", var_63_11)
						arg_60_1:RecordAudio("1108411014", var_63_11)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411014", "story_v_side_new_1108411.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411014", "story_v_side_new_1108411.awb")
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

		arg_60_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
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
	Play1108411015 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 1108411015
		arg_64_1.duration_ = 1

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"

			SetActive(arg_64_1.choicesGo_, true)

			for iter_65_0, iter_65_1 in ipairs(arg_64_1.choices_) do
				SetActive(iter_65_1.go, iter_65_0 <= 2)
			end

			arg_64_1.choices_[1].txt.text = arg_64_1:FormatText(StoryChoiceCfg[1543].name)
			arg_64_1.choices_[2].txt.text = arg_64_1:FormatText(StoryChoiceCfg[1544].name)
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play1108411016(arg_64_1)
			end

			if arg_66_0 == 2 then
				arg_64_0:Play1108411016(arg_64_1)
			end

			arg_64_1:RecordChoiceLog(1108411015, 1543, 1544)
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 and not isNil(arg_64_1.actors_["10102ui_story"]) and arg_64_1.var_.characterEffect10102ui_story == nil then
				arg_64_1.var_.characterEffect10102ui_story = arg_64_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_0 = 0.200000002980232

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_0 and not isNil(arg_64_1.actors_["10102ui_story"]) then
				if arg_64_1.var_.characterEffect10102ui_story and not isNil(arg_64_1.actors_["10102ui_story"]) then
					arg_64_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_64_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_64_1.time_ - 0) / var_67_0)
				end
			end

			if arg_64_1.time_ >= 0 + var_67_0 and arg_64_1.time_ < 0 + var_67_0 + arg_67_0 and not isNil(arg_64_1.actors_["10102ui_story"]) and arg_64_1.var_.characterEffect10102ui_story then
				arg_64_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_64_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end
		end

		arg_64_1.nodeConfigList_ = {}

		arg_64_1:InitPlayNodeList()
	end,
	Play1108411016 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 1108411016
		arg_68_1.duration_ = 6.3

		local var_68_0 = {
			zh = 5.133,
			ja = 6.3
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
				arg_68_0:Play1108411017(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 and not isNil(arg_68_1.actors_["10102ui_story"]) and arg_68_1.var_.characterEffect10102ui_story == nil then
				arg_68_1.var_.characterEffect10102ui_story = arg_68_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_0 = 0.200000002980232

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_0 and not isNil(arg_68_1.actors_["10102ui_story"]) then
				if arg_68_1.var_.characterEffect10102ui_story and not isNil(arg_68_1.actors_["10102ui_story"]) then
					arg_68_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_68_1.time_ >= 0 + var_71_0 and arg_68_1.time_ < 0 + var_71_0 + arg_71_0 and not isNil(arg_68_1.actors_["10102ui_story"]) and arg_68_1.var_.characterEffect10102ui_story then
				arg_68_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_71_2 = "10102ui_story"

			if arg_68_1.actors_["10102ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10102ui_story"))) then
				local var_71_3 = Object.Instantiate(Asset.Load("Char/" .. "10102ui_story"), arg_68_1.stage_.transform)

				var_71_3.name = var_71_2
				var_71_3.transform.localPosition = Vector3.New(0, 100, 0)
				arg_68_1.actors_[var_71_2] = var_71_3

				local var_71_4 = var_71_3:GetComponentInChildren(typeof(CharacterEffect))

				var_71_4.enabled = true

				local var_71_5 = GameObjectTools.GetOrAddComponent(var_71_3, typeof(DynamicBoneHelper))

				if var_71_5 then
					var_71_5:EnableDynamicBone(false)
				end

				arg_68_1:ShowWeapon(var_71_4.transform, false)

				arg_68_1.var_[var_71_2 .. "Animator"] = var_71_4.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_68_1.var_[var_71_2 .. "Animator"].applyRootMotion = true
				arg_68_1.var_[var_71_2 .. "LipSync"] = var_71_4.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action7_2")
			end

			local var_71_6 = "10102ui_story"

			if arg_68_1.actors_["10102ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10102ui_story"))) then
				local var_71_7 = Object.Instantiate(Asset.Load("Char/" .. "10102ui_story"), arg_68_1.stage_.transform)

				var_71_7.name = var_71_6
				var_71_7.transform.localPosition = Vector3.New(0, 100, 0)
				arg_68_1.actors_[var_71_6] = var_71_7

				local var_71_8 = var_71_7:GetComponentInChildren(typeof(CharacterEffect))

				var_71_8.enabled = true

				local var_71_9 = GameObjectTools.GetOrAddComponent(var_71_7, typeof(DynamicBoneHelper))

				if var_71_9 then
					var_71_9:EnableDynamicBone(false)
				end

				arg_68_1:ShowWeapon(var_71_8.transform, false)

				arg_68_1.var_[var_71_6 .. "Animator"] = var_71_8.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_68_1.var_[var_71_6 .. "Animator"].applyRootMotion = true
				arg_68_1.var_[var_71_6 .. "LipSync"] = var_71_8.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_71_10 = 0
			local var_71_11 = 0.7

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= var_71_10 + arg_71_0 then
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

				local var_71_12 = arg_68_1:GetWordFromCfg(1108411016)
				local var_71_13 = arg_68_1:FormatText(var_71_12.content)

				arg_68_1.text_.text = var_71_13

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_15 = 28 <= 0 and var_71_11 or var_71_11 * (utf8.len(var_71_13) / 28)

				if (28 <= 0 and var_71_11 or var_71_11 * (utf8.len(var_71_13) / 28)) > 0 and var_71_11 < var_71_15 then
					arg_68_1.talkMaxDuration = var_71_15

					if var_71_15 + var_71_10 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_15 + var_71_10
					end
				end

				arg_68_1.text_.text = var_71_13
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411016", "story_v_side_new_1108411.awb") ~= 0 then
					local var_71_16 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411016", "story_v_side_new_1108411.awb") / 1000

					if var_71_16 + var_71_10 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_16 + var_71_10
					end

					if var_71_12.prefab_name ~= "" and arg_68_1.actors_[var_71_12.prefab_name] ~= nil then
						local var_71_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_12.prefab_name].transform, "story_v_side_new_1108411", "1108411016", "story_v_side_new_1108411.awb")

						arg_68_1:RecordAudio("1108411016", var_71_17)
						arg_68_1:RecordAudio("1108411016", var_71_17)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411016", "story_v_side_new_1108411.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411016", "story_v_side_new_1108411.awb")
				end

				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_18 = math.max(var_71_11, arg_68_1.talkMaxDuration)

			if var_71_10 <= arg_68_1.time_ and arg_68_1.time_ < var_71_10 + var_71_18 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_10) / var_71_18

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_10 + var_71_18 and arg_68_1.time_ < var_71_10 + var_71_18 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {}

		arg_68_1:InitPlayNodeList()
	end,
	Play1108411017 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 1108411017
		arg_72_1.duration_ = 4.73

		local var_72_0 = {
			zh = 3.066,
			ja = 4.733
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
				arg_72_0:Play1108411018(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = 0.4

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				arg_72_1.leftNameTxt_.text = arg_72_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_1 = arg_72_1:GetWordFromCfg(1108411017)
				local var_75_2 = arg_72_1:FormatText(var_75_1.content)

				arg_72_1.text_.text = var_75_2

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_4 = 16 <= 0 and var_75_0 or var_75_0 * (utf8.len(var_75_2) / 16)

				if (16 <= 0 and var_75_0 or var_75_0 * (utf8.len(var_75_2) / 16)) > 0 and var_75_0 < var_75_4 then
					arg_72_1.talkMaxDuration = var_75_4

					if var_75_4 + 0 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_4 + 0
					end
				end

				arg_72_1.text_.text = var_75_2
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411017", "story_v_side_new_1108411.awb") ~= 0 then
					local var_75_5 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411017", "story_v_side_new_1108411.awb") / 1000

					if var_75_5 + 0 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_5 + 0
					end

					if var_75_1.prefab_name ~= "" and arg_72_1.actors_[var_75_1.prefab_name] ~= nil then
						local var_75_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_1.prefab_name].transform, "story_v_side_new_1108411", "1108411017", "story_v_side_new_1108411.awb")

						arg_72_1:RecordAudio("1108411017", var_75_6)
						arg_72_1:RecordAudio("1108411017", var_75_6)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411017", "story_v_side_new_1108411.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411017", "story_v_side_new_1108411.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_7 = math.max(var_75_0, arg_72_1.talkMaxDuration)

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_7 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - 0) / var_75_7

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= 0 + var_75_7 and arg_72_1.time_ < 0 + var_75_7 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {}

		arg_72_1:InitPlayNodeList()
	end,
	Play1108411018 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 1108411018
		arg_76_1.duration_ = 5

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play1108411019(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 and not isNil(arg_76_1.actors_["10102ui_story"]) and arg_76_1.var_.characterEffect10102ui_story == nil then
				arg_76_1.var_.characterEffect10102ui_story = arg_76_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_0 = 0.200000002980232

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_0 and not isNil(arg_76_1.actors_["10102ui_story"]) then
				if arg_76_1.var_.characterEffect10102ui_story and not isNil(arg_76_1.actors_["10102ui_story"]) then
					arg_76_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_76_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_76_1.time_ - 0) / var_79_0)
				end
			end

			if arg_76_1.time_ >= 0 + var_79_0 and arg_76_1.time_ < 0 + var_79_0 + arg_79_0 and not isNil(arg_76_1.actors_["10102ui_story"]) and arg_76_1.var_.characterEffect10102ui_story then
				arg_76_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_76_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_79_1 = 0
			local var_79_2 = 0.3

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= var_79_1 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
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

				local var_79_3 = arg_76_1:FormatText(arg_76_1:GetWordFromCfg(1108411018).content)

				arg_76_1.text_.text = var_79_3

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_5 = 12 <= 0 and var_79_2 or var_79_2 * (utf8.len(var_79_3) / 12)

				if (12 <= 0 and var_79_2 or var_79_2 * (utf8.len(var_79_3) / 12)) > 0 and var_79_2 < var_79_5 then
					arg_76_1.talkMaxDuration = var_79_5

					if var_79_5 + var_79_1 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_5 + var_79_1
					end
				end

				arg_76_1.text_.text = var_79_3
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)
				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_6 = math.max(var_79_2, arg_76_1.talkMaxDuration)

			if var_79_1 <= arg_76_1.time_ and arg_76_1.time_ < var_79_1 + var_79_6 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_1) / var_79_6

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_1 + var_79_6 and arg_76_1.time_ < var_79_1 + var_79_6 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {}

		arg_76_1:InitPlayNodeList()
	end,
	Play1108411019 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 1108411019
		arg_80_1.duration_ = 9.93

		local var_80_0 = {
			zh = 5.666,
			ja = 9.933
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
				arg_80_0:Play1108411020(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 and not isNil(arg_80_1.actors_["10102ui_story"]) and arg_80_1.var_.characterEffect10102ui_story == nil then
				arg_80_1.var_.characterEffect10102ui_story = arg_80_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_0 = 0.200000002980232

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_0 and not isNil(arg_80_1.actors_["10102ui_story"]) then
				if arg_80_1.var_.characterEffect10102ui_story and not isNil(arg_80_1.actors_["10102ui_story"]) then
					arg_80_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_80_1.time_ >= 0 + var_83_0 and arg_80_1.time_ < 0 + var_83_0 + arg_83_0 and not isNil(arg_80_1.actors_["10102ui_story"]) and arg_80_1.var_.characterEffect10102ui_story then
				arg_80_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileC_biyan", "EmotionTimelineAnimator")
			end

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action6_1")
			end

			local var_83_2 = 0
			local var_83_3 = 0.725

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_2 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				arg_80_1.leftNameTxt_.text = arg_80_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_4 = arg_80_1:GetWordFromCfg(1108411019)
				local var_83_5 = arg_80_1:FormatText(var_83_4.content)

				arg_80_1.text_.text = var_83_5

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_7 = 29 <= 0 and var_83_3 or var_83_3 * (utf8.len(var_83_5) / 29)

				if (29 <= 0 and var_83_3 or var_83_3 * (utf8.len(var_83_5) / 29)) > 0 and var_83_3 < var_83_7 then
					arg_80_1.talkMaxDuration = var_83_7

					if var_83_7 + var_83_2 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_7 + var_83_2
					end
				end

				arg_80_1.text_.text = var_83_5
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411019", "story_v_side_new_1108411.awb") ~= 0 then
					local var_83_8 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411019", "story_v_side_new_1108411.awb") / 1000

					if var_83_8 + var_83_2 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_8 + var_83_2
					end

					if var_83_4.prefab_name ~= "" and arg_80_1.actors_[var_83_4.prefab_name] ~= nil then
						local var_83_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_4.prefab_name].transform, "story_v_side_new_1108411", "1108411019", "story_v_side_new_1108411.awb")

						arg_80_1:RecordAudio("1108411019", var_83_9)
						arg_80_1:RecordAudio("1108411019", var_83_9)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411019", "story_v_side_new_1108411.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411019", "story_v_side_new_1108411.awb")
				end

				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_10 = math.max(var_83_3, arg_80_1.talkMaxDuration)

			if var_83_2 <= arg_80_1.time_ and arg_80_1.time_ < var_83_2 + var_83_10 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_2) / var_83_10

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_2 + var_83_10 and arg_80_1.time_ < var_83_2 + var_83_10 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {}

		arg_80_1:InitPlayNodeList()
	end,
	Play1108411020 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 1108411020
		arg_84_1.duration_ = 6.47

		local var_84_0 = {
			zh = 3.5,
			ja = 6.466
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
				arg_84_0:Play1108411021(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = 0.525

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				arg_84_1.leftNameTxt_.text = arg_84_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_1 = arg_84_1:GetWordFromCfg(1108411020)
				local var_87_2 = arg_84_1:FormatText(var_87_1.content)

				arg_84_1.text_.text = var_87_2

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_4 = 21 <= 0 and var_87_0 or var_87_0 * (utf8.len(var_87_2) / 21)

				if (21 <= 0 and var_87_0 or var_87_0 * (utf8.len(var_87_2) / 21)) > 0 and var_87_0 < var_87_4 then
					arg_84_1.talkMaxDuration = var_87_4

					if var_87_4 + 0 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_4 + 0
					end
				end

				arg_84_1.text_.text = var_87_2
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411020", "story_v_side_new_1108411.awb") ~= 0 then
					local var_87_5 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411020", "story_v_side_new_1108411.awb") / 1000

					if var_87_5 + 0 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_5 + 0
					end

					if var_87_1.prefab_name ~= "" and arg_84_1.actors_[var_87_1.prefab_name] ~= nil then
						local var_87_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_1.prefab_name].transform, "story_v_side_new_1108411", "1108411020", "story_v_side_new_1108411.awb")

						arg_84_1:RecordAudio("1108411020", var_87_6)
						arg_84_1:RecordAudio("1108411020", var_87_6)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411020", "story_v_side_new_1108411.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411020", "story_v_side_new_1108411.awb")
				end

				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_7 = math.max(var_87_0, arg_84_1.talkMaxDuration)

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_7 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - 0) / var_87_7

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= 0 + var_87_7 and arg_84_1.time_ < 0 + var_87_7 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {}

		arg_84_1:InitPlayNodeList()
	end,
	Play1108411021 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 1108411021
		arg_88_1.duration_ = 5

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play1108411022(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 and not isNil(arg_88_1.actors_["10102ui_story"]) and arg_88_1.var_.characterEffect10102ui_story == nil then
				arg_88_1.var_.characterEffect10102ui_story = arg_88_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_0 = 0.200000002980232

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_0 and not isNil(arg_88_1.actors_["10102ui_story"]) then
				if arg_88_1.var_.characterEffect10102ui_story and not isNil(arg_88_1.actors_["10102ui_story"]) then
					arg_88_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_88_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_88_1.time_ - 0) / var_91_0)
				end
			end

			if arg_88_1.time_ >= 0 + var_91_0 and arg_88_1.time_ < 0 + var_91_0 + arg_91_0 and not isNil(arg_88_1.actors_["10102ui_story"]) and arg_88_1.var_.characterEffect10102ui_story then
				arg_88_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_88_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_91_1 = arg_88_1.actors_["10102ui_story"].transform

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1.var_.moveOldPos10102ui_story = var_91_1.localPosition
			end

			local var_91_2 = 0.001

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_2 then
				var_91_1.localPosition = Vector3.Lerp(arg_88_1.var_.moveOldPos10102ui_story, Vector3.New(0, 100, 0), (arg_88_1.time_ - 0) / var_91_2)
				var_91_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_91_1.position).x, (manager.ui.mainCamera.transform.position - var_91_1.position).y, (manager.ui.mainCamera.transform.position - var_91_1.position).z)
				var_91_1.localEulerAngles.z = 0
				var_91_1.localEulerAngles.x = 0
				var_91_1.localEulerAngles = var_91_1.localEulerAngles
			end

			if arg_88_1.time_ >= 0 + var_91_2 and arg_88_1.time_ < 0 + var_91_2 + arg_91_0 then
				var_91_1.localPosition = Vector3.New(0, 100, 0)
				var_91_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_91_1.position).x, (manager.ui.mainCamera.transform.position - var_91_1.position).y, (manager.ui.mainCamera.transform.position - var_91_1.position).z)
				var_91_1.localEulerAngles.z = 0
				var_91_1.localEulerAngles.x = 0
				var_91_1.localEulerAngles = var_91_1.localEulerAngles
			end

			local var_91_3 = 0
			local var_91_4 = 0.85

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= var_91_3 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, false)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_5 = arg_88_1:FormatText(arg_88_1:GetWordFromCfg(1108411021).content)

				arg_88_1.text_.text = var_91_5

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_7 = 34 <= 0 and var_91_4 or var_91_4 * (utf8.len(var_91_5) / 34)

				if (34 <= 0 and var_91_4 or var_91_4 * (utf8.len(var_91_5) / 34)) > 0 and var_91_4 < var_91_7 then
					arg_88_1.talkMaxDuration = var_91_7

					if var_91_7 + var_91_3 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_7 + var_91_3
					end
				end

				arg_88_1.text_.text = var_91_5
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)
				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_8 = math.max(var_91_4, arg_88_1.talkMaxDuration)

			if var_91_3 <= arg_88_1.time_ and arg_88_1.time_ < var_91_3 + var_91_8 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_3) / var_91_8

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_3 + var_91_8 and arg_88_1.time_ < var_91_3 + var_91_8 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_88_1:InitPlayNodeList()
	end,
	Play1108411022 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 1108411022
		arg_92_1.duration_ = 5

		SetActive(arg_92_1.tipsGo_, false)

		function arg_92_1.onSingleLineFinish_()
			arg_92_1.onSingleLineUpdate_ = nil
			arg_92_1.onSingleLineFinish_ = nil
			arg_92_1.state_ = "waiting"
		end

		function arg_92_1.playNext_(arg_94_0)
			if arg_94_0 == 1 then
				arg_92_0:Play1108411023(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			local var_95_0 = 0.225

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				arg_92_1.leftNameTxt_.text = arg_92_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, true)
				arg_92_1.iconController_:SetSelectedState("hero")

				arg_92_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_92_1.callingController_:SetSelectedState("normal")

				arg_92_1.keyicon_.color = Color.New(1, 1, 1)
				arg_92_1.icon_.color = Color.New(1, 1, 1)

				local var_95_1 = arg_92_1:FormatText(arg_92_1:GetWordFromCfg(1108411022).content)

				arg_92_1.text_.text = var_95_1

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_3 = 9 <= 0 and var_95_0 or var_95_0 * (utf8.len(var_95_1) / 9)

				if (9 <= 0 and var_95_0 or var_95_0 * (utf8.len(var_95_1) / 9)) > 0 and var_95_0 < var_95_3 then
					arg_92_1.talkMaxDuration = var_95_3

					if var_95_3 + 0 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_3 + 0
					end
				end

				arg_92_1.text_.text = var_95_1
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)
				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_4 = math.max(var_95_0, arg_92_1.talkMaxDuration)

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_4 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - 0) / var_95_4

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= 0 + var_95_4 and arg_92_1.time_ < 0 + var_95_4 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {}

		arg_92_1:InitPlayNodeList()
	end,
	Play1108411023 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 1108411023
		arg_96_1.duration_ = 5.37

		local var_96_0 = {
			zh = 3.3,
			ja = 5.366
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
				arg_96_0:Play1108411024(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 and not isNil(arg_96_1.actors_["10102ui_story"]) and arg_96_1.var_.characterEffect10102ui_story == nil then
				arg_96_1.var_.characterEffect10102ui_story = arg_96_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_0 = 0.200000002980232

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_0 and not isNil(arg_96_1.actors_["10102ui_story"]) then
				if arg_96_1.var_.characterEffect10102ui_story and not isNil(arg_96_1.actors_["10102ui_story"]) then
					arg_96_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_96_1.time_ >= 0 + var_99_0 and arg_96_1.time_ < 0 + var_99_0 + arg_99_0 and not isNil(arg_96_1.actors_["10102ui_story"]) and arg_96_1.var_.characterEffect10102ui_story then
				arg_96_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102actionlink/10102action462")
			end

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_99_2 = arg_96_1.actors_["10102ui_story"].transform

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1.var_.moveOldPos10102ui_story = var_99_2.localPosition
			end

			local var_99_3 = 0.001

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_3 then
				var_99_2.localPosition = Vector3.Lerp(arg_96_1.var_.moveOldPos10102ui_story, Vector3.New(0, -0.985, -6.275), (arg_96_1.time_ - 0) / var_99_3)
				var_99_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_99_2.position).x, (manager.ui.mainCamera.transform.position - var_99_2.position).y, (manager.ui.mainCamera.transform.position - var_99_2.position).z)
				var_99_2.localEulerAngles.z = 0
				var_99_2.localEulerAngles.x = 0
				var_99_2.localEulerAngles = var_99_2.localEulerAngles
			end

			if arg_96_1.time_ >= 0 + var_99_3 and arg_96_1.time_ < 0 + var_99_3 + arg_99_0 then
				var_99_2.localPosition = Vector3.New(0, -0.985, -6.275)
				var_99_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_99_2.position).x, (manager.ui.mainCamera.transform.position - var_99_2.position).y, (manager.ui.mainCamera.transform.position - var_99_2.position).z)
				var_99_2.localEulerAngles.z = 0
				var_99_2.localEulerAngles.x = 0
				var_99_2.localEulerAngles = var_99_2.localEulerAngles
			end

			local var_99_4 = 0
			local var_99_5 = 0.425

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

				local var_99_6 = arg_96_1:GetWordFromCfg(1108411023)
				local var_99_7 = arg_96_1:FormatText(var_99_6.content)

				arg_96_1.text_.text = var_99_7

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_9 = 17 <= 0 and var_99_5 or var_99_5 * (utf8.len(var_99_7) / 17)

				if (17 <= 0 and var_99_5 or var_99_5 * (utf8.len(var_99_7) / 17)) > 0 and var_99_5 < var_99_9 then
					arg_96_1.talkMaxDuration = var_99_9

					if var_99_9 + var_99_4 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_9 + var_99_4
					end
				end

				arg_96_1.text_.text = var_99_7
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411023", "story_v_side_new_1108411.awb") ~= 0 then
					local var_99_10 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411023", "story_v_side_new_1108411.awb") / 1000

					if var_99_10 + var_99_4 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_10 + var_99_4
					end

					if var_99_6.prefab_name ~= "" and arg_96_1.actors_[var_99_6.prefab_name] ~= nil then
						local var_99_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_6.prefab_name].transform, "story_v_side_new_1108411", "1108411023", "story_v_side_new_1108411.awb")

						arg_96_1:RecordAudio("1108411023", var_99_11)
						arg_96_1:RecordAudio("1108411023", var_99_11)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411023", "story_v_side_new_1108411.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411023", "story_v_side_new_1108411.awb")
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

		arg_96_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_96_1:InitPlayNodeList()
	end,
	Play1108411024 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 1108411024
		arg_100_1.duration_ = 7.72

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play1108411025(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				local var_103_0 = arg_100_1.bgs_.ST01

				arg_100_1.bgs_.ST01.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_103_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_103_1 = var_103_0:GetComponent("SpriteRenderer")

				if var_103_1 and var_103_1.sprite then
					local var_103_2 = 2 * (var_103_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_103_0.transform.localScale = Vector3.New(var_103_2 / var_103_1.sprite.bounds.size.y < var_103_2 * manager.ui.mainCameraCom_.aspect / var_103_1.sprite.bounds.size.x and var_103_2 * manager.ui.mainCameraCom_.aspect / var_103_1.sprite.bounds.size.x or var_103_2 / var_103_1.sprite.bounds.size.y, var_103_2 / var_103_1.sprite.bounds.size.y < var_103_2 * manager.ui.mainCameraCom_.aspect / var_103_1.sprite.bounds.size.x and var_103_2 * manager.ui.mainCameraCom_.aspect / var_103_1.sprite.bounds.size.x or var_103_2 / var_103_1.sprite.bounds.size.y, 0)
				end

				for iter_103_0, iter_103_1 in pairs(arg_100_1.bgs_) do
					if iter_103_0 ~= "ST01" then
						iter_103_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_103_3 = 0

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= var_103_3 + arg_103_0 then
				arg_100_1.allBtn_.enabled = false
			end

			if arg_100_1.time_ >= var_103_3 + 0.3 and arg_100_1.time_ < var_103_3 + 0.3 + arg_103_0 then
				arg_100_1.allBtn_.enabled = true
			end

			local var_103_4 = 0

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= var_103_4 + arg_103_0 then
				arg_100_1.mask_.enabled = true
				arg_100_1.mask_.raycastTarget = true

				arg_100_1:SetGaussion(false)
			end

			local var_103_5 = 1.46666666666667

			if var_103_4 <= arg_100_1.time_ and arg_100_1.time_ < var_103_4 + var_103_5 then
				local var_103_6 = Color.New(0, 0, 0)

				var_103_6.a = Mathf.Lerp(0, 1, (arg_100_1.time_ - var_103_4) / var_103_5)
				arg_100_1.mask_.color = var_103_6
			end

			if arg_100_1.time_ >= var_103_4 + var_103_5 and arg_100_1.time_ < var_103_4 + var_103_5 + arg_103_0 then
				local var_103_7 = Color.New(0, 0, 0)

				var_103_7.a = 1
				arg_100_1.mask_.color = var_103_7
			end

			local var_103_8 = 1.46666666666667

			if 1.46666666666667 < arg_100_1.time_ and arg_100_1.time_ <= var_103_8 + arg_103_0 then
				arg_100_1.mask_.enabled = true
				arg_100_1.mask_.raycastTarget = true

				arg_100_1:SetGaussion(false)
			end

			local var_103_9 = 1.33333333333333

			if var_103_8 <= arg_100_1.time_ and arg_100_1.time_ < var_103_8 + var_103_9 then
				local var_103_10 = Color.New(0, 0, 0)

				var_103_10.a = Mathf.Lerp(1, 0, (arg_100_1.time_ - var_103_8) / var_103_9)
				arg_100_1.mask_.color = var_103_10
			end

			if arg_100_1.time_ >= var_103_8 + var_103_9 and arg_100_1.time_ < var_103_8 + var_103_9 + arg_103_0 then
				local var_103_11 = Color.New(0, 0, 0)

				arg_100_1.mask_.enabled = false
				var_103_11.a = 0
				arg_100_1.mask_.color = var_103_11
			end

			local var_103_12 = arg_100_1.actors_["10102ui_story"].transform

			if 1.46666666666667 < arg_100_1.time_ and arg_100_1.time_ <= 1.46666666666667 + arg_103_0 then
				arg_100_1.var_.moveOldPos10102ui_story = var_103_12.localPosition
			end

			local var_103_13 = 0.001

			if 1.46666666666667 <= arg_100_1.time_ and arg_100_1.time_ < 1.46666666666667 + var_103_13 then
				var_103_12.localPosition = Vector3.Lerp(arg_100_1.var_.moveOldPos10102ui_story, Vector3.New(0, 100, 0), (arg_100_1.time_ - 1.46666666666667) / var_103_13)
				var_103_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_103_12.position).x, (manager.ui.mainCamera.transform.position - var_103_12.position).y, (manager.ui.mainCamera.transform.position - var_103_12.position).z)
				var_103_12.localEulerAngles.z = 0
				var_103_12.localEulerAngles.x = 0
				var_103_12.localEulerAngles = var_103_12.localEulerAngles
			end

			if arg_100_1.time_ >= 1.46666666666667 + var_103_13 and arg_100_1.time_ < 1.46666666666667 + var_103_13 + arg_103_0 then
				var_103_12.localPosition = Vector3.New(0, 100, 0)
				var_103_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_103_12.position).x, (manager.ui.mainCamera.transform.position - var_103_12.position).y, (manager.ui.mainCamera.transform.position - var_103_12.position).z)
				var_103_12.localEulerAngles.z = 0
				var_103_12.localEulerAngles.x = 0
				var_103_12.localEulerAngles = var_103_12.localEulerAngles
			end

			local var_103_14 = arg_100_1.actors_["10102ui_story"]

			if 1.46666666666667 < arg_100_1.time_ and arg_100_1.time_ <= 1.46666666666667 + arg_103_0 and not isNil(var_103_14) and arg_100_1.var_.characterEffect10102ui_story == nil then
				arg_100_1.var_.characterEffect10102ui_story = var_103_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_103_15 = 0.200000002980232

			if 1.46666666666667 <= arg_100_1.time_ and arg_100_1.time_ < 1.46666666666667 + var_103_15 and not isNil(var_103_14) then
				if arg_100_1.var_.characterEffect10102ui_story and not isNil(var_103_14) then
					arg_100_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_100_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_100_1.time_ - 1.46666666666667) / var_103_15)
				end
			end

			if arg_100_1.time_ >= 1.46666666666667 + var_103_15 and arg_100_1.time_ < 1.46666666666667 + var_103_15 + arg_103_0 and not isNil(var_103_14) and arg_100_1.var_.characterEffect10102ui_story then
				arg_100_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_100_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			if arg_100_1.frameCnt_ <= 1 then
				arg_100_1.dialog_:SetActive(false)
			end

			local var_103_16 = 2.724999999999
			local var_103_17 = 0.075

			if 2.724999999999 < arg_100_1.time_ and arg_100_1.time_ <= var_103_16 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0

				arg_100_1.dialog_:SetActive(true)

				arg_100_1.dialogCg_.alpha = 0

				local var_103_18 = LeanTween.value(arg_100_1.dialog_, 0, 1, 0.3)

				var_103_18:setOnUpdate(LuaHelper.FloatAction(function(arg_104_0)
					arg_100_1.dialogCg_.alpha = arg_104_0
				end))
				var_103_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_100_1.dialog_)
					var_103_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_100_1.duration_ = arg_100_1.duration_ + 0.3

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

				local var_103_19 = arg_100_1:FormatText(arg_100_1:GetWordFromCfg(1108411024).content)

				arg_100_1.text_.text = var_103_19

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_21 = 3 <= 0 and var_103_17 or var_103_17 * (utf8.len(var_103_19) / 3)

				if (3 <= 0 and var_103_17 or var_103_17 * (utf8.len(var_103_19) / 3)) > 0 and var_103_17 < var_103_21 then
					arg_100_1.talkMaxDuration = var_103_21
					var_103_16 = var_103_16 + 0.3

					if var_103_21 + var_103_16 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_21 + var_103_16
					end
				end

				arg_100_1.text_.text = var_103_19
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)
				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_22 = var_103_16 + 0.3
			local var_103_23 = math.max(var_103_17, arg_100_1.talkMaxDuration)

			if var_103_16 + 0.3 <= arg_100_1.time_ and arg_100_1.time_ < var_103_22 + var_103_23 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_22) / var_103_23

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_22 + var_103_23 and arg_100_1.time_ < var_103_22 + var_103_23 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.46666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_100_1:InitPlayNodeList()
	end,
	Play1108411025 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 1108411025
		arg_106_1.duration_ = 5

		SetActive(arg_106_1.tipsGo_, false)

		function arg_106_1.onSingleLineFinish_()
			arg_106_1.onSingleLineUpdate_ = nil
			arg_106_1.onSingleLineFinish_ = nil
			arg_106_1.state_ = "waiting"
		end

		function arg_106_1.playNext_(arg_108_0)
			if arg_108_0 == 1 then
				arg_106_0:Play1108411026(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			local var_109_0 = 1.075

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, false)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_1 = arg_106_1:FormatText(arg_106_1:GetWordFromCfg(1108411025).content)

				arg_106_1.text_.text = var_109_1

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_3 = 43 <= 0 and var_109_0 or var_109_0 * (utf8.len(var_109_1) / 43)

				if (43 <= 0 and var_109_0 or var_109_0 * (utf8.len(var_109_1) / 43)) > 0 and var_109_0 < var_109_3 then
					arg_106_1.talkMaxDuration = var_109_3

					if var_109_3 + 0 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_3 + 0
					end
				end

				arg_106_1.text_.text = var_109_1
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)
				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_4 = math.max(var_109_0, arg_106_1.talkMaxDuration)

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_4 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - 0) / var_109_4

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= 0 + var_109_4 and arg_106_1.time_ < 0 + var_109_4 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {}

		arg_106_1:InitPlayNodeList()
	end,
	Play1108411026 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 1108411026
		arg_110_1.duration_ = 5

		SetActive(arg_110_1.tipsGo_, false)

		function arg_110_1.onSingleLineFinish_()
			arg_110_1.onSingleLineUpdate_ = nil
			arg_110_1.onSingleLineFinish_ = nil
			arg_110_1.state_ = "waiting"
		end

		function arg_110_1.playNext_(arg_112_0)
			if arg_112_0 == 1 then
				arg_110_0:Play1108411027(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			local var_113_0 = 0.7

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				arg_110_1.leftNameTxt_.text = arg_110_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, true)
				arg_110_1.iconController_:SetSelectedState("hero")

				arg_110_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_110_1.callingController_:SetSelectedState("normal")

				arg_110_1.keyicon_.color = Color.New(1, 1, 1)
				arg_110_1.icon_.color = Color.New(1, 1, 1)

				local var_113_1 = arg_110_1:FormatText(arg_110_1:GetWordFromCfg(1108411026).content)

				arg_110_1.text_.text = var_113_1

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_3 = 28 <= 0 and var_113_0 or var_113_0 * (utf8.len(var_113_1) / 28)

				if (28 <= 0 and var_113_0 or var_113_0 * (utf8.len(var_113_1) / 28)) > 0 and var_113_0 < var_113_3 then
					arg_110_1.talkMaxDuration = var_113_3

					if var_113_3 + 0 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_3 + 0
					end
				end

				arg_110_1.text_.text = var_113_1
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)
				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_4 = math.max(var_113_0, arg_110_1.talkMaxDuration)

			if 0 <= arg_110_1.time_ and arg_110_1.time_ < 0 + var_113_4 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - 0) / var_113_4

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= 0 + var_113_4 and arg_110_1.time_ < 0 + var_113_4 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {}

		arg_110_1:InitPlayNodeList()
	end,
	Play1108411027 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 1108411027
		arg_114_1.duration_ = 5

		SetActive(arg_114_1.tipsGo_, false)

		function arg_114_1.onSingleLineFinish_()
			arg_114_1.onSingleLineUpdate_ = nil
			arg_114_1.onSingleLineFinish_ = nil
			arg_114_1.state_ = "waiting"
		end

		function arg_114_1.playNext_(arg_116_0)
			if arg_116_0 == 1 then
				arg_114_0:Play1108411028(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			local var_117_0 = 0.85

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, true)

				arg_114_1.leftNameTxt_.text = arg_114_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_114_1.leftNameTxt_.transform)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1.leftNameTxt_.text)
				SetActive(arg_114_1.iconTrs_.gameObject, true)
				arg_114_1.iconController_:SetSelectedState("hero")

				arg_114_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_114_1.callingController_:SetSelectedState("normal")

				arg_114_1.keyicon_.color = Color.New(1, 1, 1)
				arg_114_1.icon_.color = Color.New(1, 1, 1)

				local var_117_1 = arg_114_1:FormatText(arg_114_1:GetWordFromCfg(1108411027).content)

				arg_114_1.text_.text = var_117_1

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_3 = 34 <= 0 and var_117_0 or var_117_0 * (utf8.len(var_117_1) / 34)

				if (34 <= 0 and var_117_0 or var_117_0 * (utf8.len(var_117_1) / 34)) > 0 and var_117_0 < var_117_3 then
					arg_114_1.talkMaxDuration = var_117_3

					if var_117_3 + 0 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_3 + 0
					end
				end

				arg_114_1.text_.text = var_117_1
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)
				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_4 = math.max(var_117_0, arg_114_1.talkMaxDuration)

			if 0 <= arg_114_1.time_ and arg_114_1.time_ < 0 + var_117_4 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - 0) / var_117_4

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= 0 + var_117_4 and arg_114_1.time_ < 0 + var_117_4 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {}

		arg_114_1:InitPlayNodeList()
	end,
	Play1108411028 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 1108411028
		arg_118_1.duration_ = 5

		SetActive(arg_118_1.tipsGo_, false)

		function arg_118_1.onSingleLineFinish_()
			arg_118_1.onSingleLineUpdate_ = nil
			arg_118_1.onSingleLineFinish_ = nil
			arg_118_1.state_ = "waiting"
		end

		function arg_118_1.playNext_(arg_120_0)
			if arg_120_0 == 1 then
				arg_118_0:Play1108411029(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			local var_121_0 = 1.125

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, false)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_118_1.iconTrs_.gameObject, false)
				arg_118_1.callingController_:SetSelectedState("normal")

				local var_121_1 = arg_118_1:FormatText(arg_118_1:GetWordFromCfg(1108411028).content)

				arg_118_1.text_.text = var_121_1

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_3 = 45 <= 0 and var_121_0 or var_121_0 * (utf8.len(var_121_1) / 45)

				if (45 <= 0 and var_121_0 or var_121_0 * (utf8.len(var_121_1) / 45)) > 0 and var_121_0 < var_121_3 then
					arg_118_1.talkMaxDuration = var_121_3

					if var_121_3 + 0 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_3 + 0
					end
				end

				arg_118_1.text_.text = var_121_1
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)
				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_4 = math.max(var_121_0, arg_118_1.talkMaxDuration)

			if 0 <= arg_118_1.time_ and arg_118_1.time_ < 0 + var_121_4 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - 0) / var_121_4

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= 0 + var_121_4 and arg_118_1.time_ < 0 + var_121_4 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {}

		arg_118_1:InitPlayNodeList()
	end,
	Play1108411029 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 1108411029
		arg_122_1.duration_ = 5.6

		local var_122_0 = {
			zh = 5.6,
			ja = 4.133
		}
		local var_122_1 = manager.audio:GetLocalizationFlag()

		if var_122_0[var_122_1] ~= nil then
			arg_122_1.duration_ = var_122_0[var_122_1]
		end

		SetActive(arg_122_1.tipsGo_, false)

		function arg_122_1.onSingleLineFinish_()
			arg_122_1.onSingleLineUpdate_ = nil
			arg_122_1.onSingleLineFinish_ = nil
			arg_122_1.state_ = "waiting"
		end

		function arg_122_1.playNext_(arg_124_0)
			if arg_124_0 == 1 then
				arg_122_0:Play1108411030(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 then
				arg_122_1.var_.moveOldPos10102ui_story = arg_122_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_125_0 = 0.001

			if 0 <= arg_122_1.time_ and arg_122_1.time_ < 0 + var_125_0 then
				arg_122_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_122_1.var_.moveOldPos10102ui_story, Vector3.New(0, -0.985, -6.275), (arg_122_1.time_ - 0) / var_125_0)
				arg_122_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_122_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_122_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_122_1.actors_["10102ui_story"].transform.position).z)
				arg_122_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_122_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_122_1.actors_["10102ui_story"].transform.localEulerAngles = arg_122_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_122_1.time_ >= 0 + var_125_0 and arg_122_1.time_ < 0 + var_125_0 + arg_125_0 then
				arg_122_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6.275)
				arg_122_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_122_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_122_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_122_1.actors_["10102ui_story"].transform.position).z)
				arg_122_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_122_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_122_1.actors_["10102ui_story"].transform.localEulerAngles = arg_122_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_125_1 = arg_122_1.actors_["10102ui_story"]

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 and not isNil(var_125_1) and arg_122_1.var_.characterEffect10102ui_story == nil then
				arg_122_1.var_.characterEffect10102ui_story = var_125_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_125_2 = 0.200000002980232

			if 0 <= arg_122_1.time_ and arg_122_1.time_ < 0 + var_125_2 and not isNil(var_125_1) then
				if arg_122_1.var_.characterEffect10102ui_story and not isNil(var_125_1) then
					arg_122_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_122_1.time_ >= 0 + var_125_2 and arg_122_1.time_ < 0 + var_125_2 + arg_125_0 and not isNil(var_125_1) and arg_122_1.var_.characterEffect10102ui_story then
				arg_122_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 then
				arg_122_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action10_1")
			end

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 then
				arg_122_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_wuyuC", "EmotionTimelineAnimator")
			end

			local var_125_4 = 0
			local var_125_5 = 0.575

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= var_125_4 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, true)

				arg_122_1.leftNameTxt_.text = arg_122_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_122_1.leftNameTxt_.transform)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1.leftNameTxt_.text)
				SetActive(arg_122_1.iconTrs_.gameObject, false)
				arg_122_1.callingController_:SetSelectedState("normal")

				local var_125_6 = arg_122_1:GetWordFromCfg(1108411029)
				local var_125_7 = arg_122_1:FormatText(var_125_6.content)

				arg_122_1.text_.text = var_125_7

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_9 = 23 <= 0 and var_125_5 or var_125_5 * (utf8.len(var_125_7) / 23)

				if (23 <= 0 and var_125_5 or var_125_5 * (utf8.len(var_125_7) / 23)) > 0 and var_125_5 < var_125_9 then
					arg_122_1.talkMaxDuration = var_125_9

					if var_125_9 + var_125_4 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_9 + var_125_4
					end
				end

				arg_122_1.text_.text = var_125_7
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411029", "story_v_side_new_1108411.awb") ~= 0 then
					local var_125_10 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411029", "story_v_side_new_1108411.awb") / 1000

					if var_125_10 + var_125_4 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_10 + var_125_4
					end

					if var_125_6.prefab_name ~= "" and arg_122_1.actors_[var_125_6.prefab_name] ~= nil then
						local var_125_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_122_1.actors_[var_125_6.prefab_name].transform, "story_v_side_new_1108411", "1108411029", "story_v_side_new_1108411.awb")

						arg_122_1:RecordAudio("1108411029", var_125_11)
						arg_122_1:RecordAudio("1108411029", var_125_11)
					else
						arg_122_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411029", "story_v_side_new_1108411.awb")
					end

					arg_122_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411029", "story_v_side_new_1108411.awb")
				end

				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_12 = math.max(var_125_5, arg_122_1.talkMaxDuration)

			if var_125_4 <= arg_122_1.time_ and arg_122_1.time_ < var_125_4 + var_125_12 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_4) / var_125_12

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_4 + var_125_12 and arg_122_1.time_ < var_125_4 + var_125_12 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_122_1:InitPlayNodeList()
	end,
	Play1108411030 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 1108411030
		arg_126_1.duration_ = 5

		SetActive(arg_126_1.tipsGo_, false)

		function arg_126_1.onSingleLineFinish_()
			arg_126_1.onSingleLineUpdate_ = nil
			arg_126_1.onSingleLineFinish_ = nil
			arg_126_1.state_ = "waiting"
		end

		function arg_126_1.playNext_(arg_128_0)
			if arg_128_0 == 1 then
				arg_126_0:Play1108411031(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 and not isNil(arg_126_1.actors_["10102ui_story"]) and arg_126_1.var_.characterEffect10102ui_story == nil then
				arg_126_1.var_.characterEffect10102ui_story = arg_126_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_129_0 = 0.200000002980232

			if 0 <= arg_126_1.time_ and arg_126_1.time_ < 0 + var_129_0 and not isNil(arg_126_1.actors_["10102ui_story"]) then
				if arg_126_1.var_.characterEffect10102ui_story and not isNil(arg_126_1.actors_["10102ui_story"]) then
					arg_126_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_126_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_126_1.time_ - 0) / var_129_0)
				end
			end

			if arg_126_1.time_ >= 0 + var_129_0 and arg_126_1.time_ < 0 + var_129_0 + arg_129_0 and not isNil(arg_126_1.actors_["10102ui_story"]) and arg_126_1.var_.characterEffect10102ui_story then
				arg_126_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_126_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_129_1 = 0
			local var_129_2 = 0.5

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= var_129_1 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, true)

				arg_126_1.leftNameTxt_.text = arg_126_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_126_1.leftNameTxt_.transform)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1.leftNameTxt_.text)
				SetActive(arg_126_1.iconTrs_.gameObject, true)
				arg_126_1.iconController_:SetSelectedState("hero")

				arg_126_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_126_1.callingController_:SetSelectedState("normal")

				arg_126_1.keyicon_.color = Color.New(1, 1, 1)
				arg_126_1.icon_.color = Color.New(1, 1, 1)

				local var_129_3 = arg_126_1:FormatText(arg_126_1:GetWordFromCfg(1108411030).content)

				arg_126_1.text_.text = var_129_3

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_5 = 20 <= 0 and var_129_2 or var_129_2 * (utf8.len(var_129_3) / 20)

				if (20 <= 0 and var_129_2 or var_129_2 * (utf8.len(var_129_3) / 20)) > 0 and var_129_2 < var_129_5 then
					arg_126_1.talkMaxDuration = var_129_5

					if var_129_5 + var_129_1 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_5 + var_129_1
					end
				end

				arg_126_1.text_.text = var_129_3
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)
				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_6 = math.max(var_129_2, arg_126_1.talkMaxDuration)

			if var_129_1 <= arg_126_1.time_ and arg_126_1.time_ < var_129_1 + var_129_6 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - var_129_1) / var_129_6

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= var_129_1 + var_129_6 and arg_126_1.time_ < var_129_1 + var_129_6 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {}

		arg_126_1:InitPlayNodeList()
	end,
	Play1108411031 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 1108411031
		arg_130_1.duration_ = 6.33

		local var_130_0 = {
			zh = 4.4,
			ja = 6.333
		}
		local var_130_1 = manager.audio:GetLocalizationFlag()

		if var_130_0[var_130_1] ~= nil then
			arg_130_1.duration_ = var_130_0[var_130_1]
		end

		SetActive(arg_130_1.tipsGo_, false)

		function arg_130_1.onSingleLineFinish_()
			arg_130_1.onSingleLineUpdate_ = nil
			arg_130_1.onSingleLineFinish_ = nil
			arg_130_1.state_ = "waiting"
		end

		function arg_130_1.playNext_(arg_132_0)
			if arg_132_0 == 1 then
				arg_130_0:Play1108411032(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 and not isNil(arg_130_1.actors_["10102ui_story"]) and arg_130_1.var_.characterEffect10102ui_story == nil then
				arg_130_1.var_.characterEffect10102ui_story = arg_130_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_133_0 = 0.200000002980232

			if 0 <= arg_130_1.time_ and arg_130_1.time_ < 0 + var_133_0 and not isNil(arg_130_1.actors_["10102ui_story"]) then
				if arg_130_1.var_.characterEffect10102ui_story and not isNil(arg_130_1.actors_["10102ui_story"]) then
					arg_130_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_130_1.time_ >= 0 + var_133_0 and arg_130_1.time_ < 0 + var_133_0 + arg_133_0 and not isNil(arg_130_1.actors_["10102ui_story"]) and arg_130_1.var_.characterEffect10102ui_story then
				arg_130_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 then
				arg_130_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action10_2")
			end

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 then
				arg_130_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_133_2 = 0
			local var_133_3 = 0.55

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= var_133_2 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, true)

				arg_130_1.leftNameTxt_.text = arg_130_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_130_1.leftNameTxt_.transform)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1.leftNameTxt_.text)
				SetActive(arg_130_1.iconTrs_.gameObject, false)
				arg_130_1.callingController_:SetSelectedState("normal")

				local var_133_4 = arg_130_1:GetWordFromCfg(1108411031)
				local var_133_5 = arg_130_1:FormatText(var_133_4.content)

				arg_130_1.text_.text = var_133_5

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_7 = 22 <= 0 and var_133_3 or var_133_3 * (utf8.len(var_133_5) / 22)

				if (22 <= 0 and var_133_3 or var_133_3 * (utf8.len(var_133_5) / 22)) > 0 and var_133_3 < var_133_7 then
					arg_130_1.talkMaxDuration = var_133_7

					if var_133_7 + var_133_2 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_7 + var_133_2
					end
				end

				arg_130_1.text_.text = var_133_5
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411031", "story_v_side_new_1108411.awb") ~= 0 then
					local var_133_8 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411031", "story_v_side_new_1108411.awb") / 1000

					if var_133_8 + var_133_2 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_8 + var_133_2
					end

					if var_133_4.prefab_name ~= "" and arg_130_1.actors_[var_133_4.prefab_name] ~= nil then
						local var_133_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_130_1.actors_[var_133_4.prefab_name].transform, "story_v_side_new_1108411", "1108411031", "story_v_side_new_1108411.awb")

						arg_130_1:RecordAudio("1108411031", var_133_9)
						arg_130_1:RecordAudio("1108411031", var_133_9)
					else
						arg_130_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411031", "story_v_side_new_1108411.awb")
					end

					arg_130_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411031", "story_v_side_new_1108411.awb")
				end

				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_10 = math.max(var_133_3, arg_130_1.talkMaxDuration)

			if var_133_2 <= arg_130_1.time_ and arg_130_1.time_ < var_133_2 + var_133_10 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - var_133_2) / var_133_10

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= var_133_2 + var_133_10 and arg_130_1.time_ < var_133_2 + var_133_10 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {}

		arg_130_1:InitPlayNodeList()
	end,
	Play1108411032 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 1108411032
		arg_134_1.duration_ = 5

		SetActive(arg_134_1.tipsGo_, false)

		function arg_134_1.onSingleLineFinish_()
			arg_134_1.onSingleLineUpdate_ = nil
			arg_134_1.onSingleLineFinish_ = nil
			arg_134_1.state_ = "waiting"
		end

		function arg_134_1.playNext_(arg_136_0)
			if arg_136_0 == 1 then
				arg_134_0:Play1108411033(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 and not isNil(arg_134_1.actors_["10102ui_story"]) and arg_134_1.var_.characterEffect10102ui_story == nil then
				arg_134_1.var_.characterEffect10102ui_story = arg_134_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_137_0 = 0.200000002980232

			if 0 <= arg_134_1.time_ and arg_134_1.time_ < 0 + var_137_0 and not isNil(arg_134_1.actors_["10102ui_story"]) then
				if arg_134_1.var_.characterEffect10102ui_story and not isNil(arg_134_1.actors_["10102ui_story"]) then
					arg_134_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_134_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_134_1.time_ - 0) / var_137_0)
				end
			end

			if arg_134_1.time_ >= 0 + var_137_0 and arg_134_1.time_ < 0 + var_137_0 + arg_137_0 and not isNil(arg_134_1.actors_["10102ui_story"]) and arg_134_1.var_.characterEffect10102ui_story then
				arg_134_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_134_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_137_1 = 0
			local var_137_2 = 0.5

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= var_137_1 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, true)

				arg_134_1.leftNameTxt_.text = arg_134_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_134_1.leftNameTxt_.transform)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1.leftNameTxt_.text)
				SetActive(arg_134_1.iconTrs_.gameObject, true)
				arg_134_1.iconController_:SetSelectedState("hero")

				arg_134_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_134_1.callingController_:SetSelectedState("normal")

				arg_134_1.keyicon_.color = Color.New(1, 1, 1)
				arg_134_1.icon_.color = Color.New(1, 1, 1)

				local var_137_3 = arg_134_1:FormatText(arg_134_1:GetWordFromCfg(1108411032).content)

				arg_134_1.text_.text = var_137_3

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_5 = 20 <= 0 and var_137_2 or var_137_2 * (utf8.len(var_137_3) / 20)

				if (20 <= 0 and var_137_2 or var_137_2 * (utf8.len(var_137_3) / 20)) > 0 and var_137_2 < var_137_5 then
					arg_134_1.talkMaxDuration = var_137_5

					if var_137_5 + var_137_1 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_5 + var_137_1
					end
				end

				arg_134_1.text_.text = var_137_3
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)
				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_6 = math.max(var_137_2, arg_134_1.talkMaxDuration)

			if var_137_1 <= arg_134_1.time_ and arg_134_1.time_ < var_137_1 + var_137_6 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - var_137_1) / var_137_6

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= var_137_1 + var_137_6 and arg_134_1.time_ < var_137_1 + var_137_6 + arg_137_0 then
				arg_134_1.typewritter.percent = 1

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(true)
			end
		end

		arg_134_1.nodeConfigList_ = {}

		arg_134_1:InitPlayNodeList()
	end,
	Play1108411033 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 1108411033
		arg_138_1.duration_ = 5

		SetActive(arg_138_1.tipsGo_, false)

		function arg_138_1.onSingleLineFinish_()
			arg_138_1.onSingleLineUpdate_ = nil
			arg_138_1.onSingleLineFinish_ = nil
			arg_138_1.state_ = "waiting"
		end

		function arg_138_1.playNext_(arg_140_0)
			if arg_140_0 == 1 then
				arg_138_0:Play1108411034(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 then
				arg_138_1.var_.moveOldPos10102ui_story = arg_138_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_141_0 = 0.001

			if 0 <= arg_138_1.time_ and arg_138_1.time_ < 0 + var_141_0 then
				arg_138_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_138_1.var_.moveOldPos10102ui_story, Vector3.New(0, 100, 0), (arg_138_1.time_ - 0) / var_141_0)
				arg_138_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_138_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_138_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_138_1.actors_["10102ui_story"].transform.position).z)
				arg_138_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_138_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_138_1.actors_["10102ui_story"].transform.localEulerAngles = arg_138_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_138_1.time_ >= 0 + var_141_0 and arg_138_1.time_ < 0 + var_141_0 + arg_141_0 then
				arg_138_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_138_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_138_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_138_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_138_1.actors_["10102ui_story"].transform.position).z)
				arg_138_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_138_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_138_1.actors_["10102ui_story"].transform.localEulerAngles = arg_138_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_141_1 = 0
			local var_141_2 = 1.1

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= var_141_1 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, false)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_138_1.iconTrs_.gameObject, false)
				arg_138_1.callingController_:SetSelectedState("normal")

				local var_141_3 = arg_138_1:FormatText(arg_138_1:GetWordFromCfg(1108411033).content)

				arg_138_1.text_.text = var_141_3

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_5 = 44 <= 0 and var_141_2 or var_141_2 * (utf8.len(var_141_3) / 44)

				if (44 <= 0 and var_141_2 or var_141_2 * (utf8.len(var_141_3) / 44)) > 0 and var_141_2 < var_141_5 then
					arg_138_1.talkMaxDuration = var_141_5

					if var_141_5 + var_141_1 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_5 + var_141_1
					end
				end

				arg_138_1.text_.text = var_141_3
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)
				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_6 = math.max(var_141_2, arg_138_1.talkMaxDuration)

			if var_141_1 <= arg_138_1.time_ and arg_138_1.time_ < var_141_1 + var_141_6 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - var_141_1) / var_141_6

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= var_141_1 + var_141_6 and arg_138_1.time_ < var_141_1 + var_141_6 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_138_1:InitPlayNodeList()
	end,
	Play1108411034 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 1108411034
		arg_142_1.duration_ = 5

		SetActive(arg_142_1.tipsGo_, false)

		function arg_142_1.onSingleLineFinish_()
			arg_142_1.onSingleLineUpdate_ = nil
			arg_142_1.onSingleLineFinish_ = nil
			arg_142_1.state_ = "waiting"
		end

		function arg_142_1.playNext_(arg_144_0)
			if arg_144_0 == 1 then
				arg_142_0:Play1108411035(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			local var_145_0 = 1.175

			if 0 < arg_142_1.time_ and arg_142_1.time_ <= 0 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0
				arg_142_1.dialogCg_.alpha = 1

				arg_142_1.dialog_:SetActive(true)
				SetActive(arg_142_1.leftNameGo_, true)

				arg_142_1.leftNameTxt_.text = arg_142_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_142_1.leftNameTxt_.transform)

				arg_142_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_142_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_142_1:RecordName(arg_142_1.leftNameTxt_.text)
				SetActive(arg_142_1.iconTrs_.gameObject, true)
				arg_142_1.iconController_:SetSelectedState("hero")

				arg_142_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_142_1.callingController_:SetSelectedState("normal")

				arg_142_1.keyicon_.color = Color.New(1, 1, 1)
				arg_142_1.icon_.color = Color.New(1, 1, 1)

				local var_145_1 = arg_142_1:FormatText(arg_142_1:GetWordFromCfg(1108411034).content)

				arg_142_1.text_.text = var_145_1

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_3 = 47 <= 0 and var_145_0 or var_145_0 * (utf8.len(var_145_1) / 47)

				if (47 <= 0 and var_145_0 or var_145_0 * (utf8.len(var_145_1) / 47)) > 0 and var_145_0 < var_145_3 then
					arg_142_1.talkMaxDuration = var_145_3

					if var_145_3 + 0 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_3 + 0
					end
				end

				arg_142_1.text_.text = var_145_1
				arg_142_1.typewritter.percent = 0

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(false)
				arg_142_1:RecordContent(arg_142_1.text_.text)
			end

			local var_145_4 = math.max(var_145_0, arg_142_1.talkMaxDuration)

			if 0 <= arg_142_1.time_ and arg_142_1.time_ < 0 + var_145_4 then
				arg_142_1.typewritter.percent = (arg_142_1.time_ - 0) / var_145_4

				arg_142_1.typewritter:SetDirty()
			end

			if arg_142_1.time_ >= 0 + var_145_4 and arg_142_1.time_ < 0 + var_145_4 + arg_145_0 then
				arg_142_1.typewritter.percent = 1

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(true)
			end
		end

		arg_142_1.nodeConfigList_ = {}

		arg_142_1:InitPlayNodeList()
	end,
	Play1108411035 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 1108411035
		arg_146_1.duration_ = 5

		SetActive(arg_146_1.tipsGo_, false)

		function arg_146_1.onSingleLineFinish_()
			arg_146_1.onSingleLineUpdate_ = nil
			arg_146_1.onSingleLineFinish_ = nil
			arg_146_1.state_ = "waiting"
		end

		function arg_146_1.playNext_(arg_148_0)
			if arg_148_0 == 1 then
				arg_146_0:Play1108411036(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			local var_149_0 = 0.8

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0
				arg_146_1.dialogCg_.alpha = 1

				arg_146_1.dialog_:SetActive(true)
				SetActive(arg_146_1.leftNameGo_, true)

				arg_146_1.leftNameTxt_.text = arg_146_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_146_1.leftNameTxt_.transform)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1.leftNameTxt_.text)
				SetActive(arg_146_1.iconTrs_.gameObject, true)
				arg_146_1.iconController_:SetSelectedState("hero")

				arg_146_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_146_1.callingController_:SetSelectedState("normal")

				arg_146_1.keyicon_.color = Color.New(1, 1, 1)
				arg_146_1.icon_.color = Color.New(1, 1, 1)

				local var_149_1 = arg_146_1:FormatText(arg_146_1:GetWordFromCfg(1108411035).content)

				arg_146_1.text_.text = var_149_1

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_3 = 32 <= 0 and var_149_0 or var_149_0 * (utf8.len(var_149_1) / 32)

				if (32 <= 0 and var_149_0 or var_149_0 * (utf8.len(var_149_1) / 32)) > 0 and var_149_0 < var_149_3 then
					arg_146_1.talkMaxDuration = var_149_3

					if var_149_3 + 0 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_3 + 0
					end
				end

				arg_146_1.text_.text = var_149_1
				arg_146_1.typewritter.percent = 0

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(false)
				arg_146_1:RecordContent(arg_146_1.text_.text)
			end

			local var_149_4 = math.max(var_149_0, arg_146_1.talkMaxDuration)

			if 0 <= arg_146_1.time_ and arg_146_1.time_ < 0 + var_149_4 then
				arg_146_1.typewritter.percent = (arg_146_1.time_ - 0) / var_149_4

				arg_146_1.typewritter:SetDirty()
			end

			if arg_146_1.time_ >= 0 + var_149_4 and arg_146_1.time_ < 0 + var_149_4 + arg_149_0 then
				arg_146_1.typewritter.percent = 1

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(true)
			end
		end

		arg_146_1.nodeConfigList_ = {}

		arg_146_1:InitPlayNodeList()
	end,
	Play1108411036 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 1108411036
		arg_150_1.duration_ = 8.3

		local var_150_0 = {
			zh = 5.766,
			ja = 8.3
		}
		local var_150_1 = manager.audio:GetLocalizationFlag()

		if var_150_0[var_150_1] ~= nil then
			arg_150_1.duration_ = var_150_0[var_150_1]
		end

		SetActive(arg_150_1.tipsGo_, false)

		function arg_150_1.onSingleLineFinish_()
			arg_150_1.onSingleLineUpdate_ = nil
			arg_150_1.onSingleLineFinish_ = nil
			arg_150_1.state_ = "waiting"
		end

		function arg_150_1.playNext_(arg_152_0)
			if arg_152_0 == 1 then
				arg_150_0:Play1108411037(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 then
				arg_150_1.var_.moveOldPos10102ui_story = arg_150_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_153_0 = 0.001

			if 0 <= arg_150_1.time_ and arg_150_1.time_ < 0 + var_153_0 then
				arg_150_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_150_1.var_.moveOldPos10102ui_story, Vector3.New(0, -0.985, -6.275), (arg_150_1.time_ - 0) / var_153_0)
				arg_150_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_150_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_150_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_150_1.actors_["10102ui_story"].transform.position).z)
				arg_150_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_150_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_150_1.actors_["10102ui_story"].transform.localEulerAngles = arg_150_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_150_1.time_ >= 0 + var_153_0 and arg_150_1.time_ < 0 + var_153_0 + arg_153_0 then
				arg_150_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6.275)
				arg_150_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_150_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_150_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_150_1.actors_["10102ui_story"].transform.position).z)
				arg_150_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_150_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_150_1.actors_["10102ui_story"].transform.localEulerAngles = arg_150_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_153_1 = arg_150_1.actors_["10102ui_story"]

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 and not isNil(var_153_1) and arg_150_1.var_.characterEffect10102ui_story == nil then
				arg_150_1.var_.characterEffect10102ui_story = var_153_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_153_2 = 0.200000002980232

			if 0 <= arg_150_1.time_ and arg_150_1.time_ < 0 + var_153_2 and not isNil(var_153_1) then
				if arg_150_1.var_.characterEffect10102ui_story and not isNil(var_153_1) then
					arg_150_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_150_1.time_ >= 0 + var_153_2 and arg_150_1.time_ < 0 + var_153_2 + arg_153_0 and not isNil(var_153_1) and arg_150_1.var_.characterEffect10102ui_story then
				arg_150_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 then
				arg_150_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action4_1")
			end

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 then
				arg_150_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_153_4 = 0
			local var_153_5 = 0.65

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= var_153_4 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0
				arg_150_1.dialogCg_.alpha = 1

				arg_150_1.dialog_:SetActive(true)
				SetActive(arg_150_1.leftNameGo_, true)

				arg_150_1.leftNameTxt_.text = arg_150_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_150_1.leftNameTxt_.transform)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1.leftNameTxt_.text)
				SetActive(arg_150_1.iconTrs_.gameObject, false)
				arg_150_1.callingController_:SetSelectedState("normal")

				local var_153_6 = arg_150_1:GetWordFromCfg(1108411036)
				local var_153_7 = arg_150_1:FormatText(var_153_6.content)

				arg_150_1.text_.text = var_153_7

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_9 = 26 <= 0 and var_153_5 or var_153_5 * (utf8.len(var_153_7) / 26)

				if (26 <= 0 and var_153_5 or var_153_5 * (utf8.len(var_153_7) / 26)) > 0 and var_153_5 < var_153_9 then
					arg_150_1.talkMaxDuration = var_153_9

					if var_153_9 + var_153_4 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_9 + var_153_4
					end
				end

				arg_150_1.text_.text = var_153_7
				arg_150_1.typewritter.percent = 0

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411036", "story_v_side_new_1108411.awb") ~= 0 then
					local var_153_10 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411036", "story_v_side_new_1108411.awb") / 1000

					if var_153_10 + var_153_4 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_10 + var_153_4
					end

					if var_153_6.prefab_name ~= "" and arg_150_1.actors_[var_153_6.prefab_name] ~= nil then
						local var_153_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_150_1.actors_[var_153_6.prefab_name].transform, "story_v_side_new_1108411", "1108411036", "story_v_side_new_1108411.awb")

						arg_150_1:RecordAudio("1108411036", var_153_11)
						arg_150_1:RecordAudio("1108411036", var_153_11)
					else
						arg_150_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411036", "story_v_side_new_1108411.awb")
					end

					arg_150_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411036", "story_v_side_new_1108411.awb")
				end

				arg_150_1:RecordContent(arg_150_1.text_.text)
			end

			local var_153_12 = math.max(var_153_5, arg_150_1.talkMaxDuration)

			if var_153_4 <= arg_150_1.time_ and arg_150_1.time_ < var_153_4 + var_153_12 then
				arg_150_1.typewritter.percent = (arg_150_1.time_ - var_153_4) / var_153_12

				arg_150_1.typewritter:SetDirty()
			end

			if arg_150_1.time_ >= var_153_4 + var_153_12 and arg_150_1.time_ < var_153_4 + var_153_12 + arg_153_0 then
				arg_150_1.typewritter.percent = 1

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(true)
			end
		end

		arg_150_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_150_1:InitPlayNodeList()
	end,
	Play1108411037 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 1108411037
		arg_154_1.duration_ = 3.7

		local var_154_0 = {
			zh = 3.466,
			ja = 3.7
		}
		local var_154_1 = manager.audio:GetLocalizationFlag()

		if var_154_0[var_154_1] ~= nil then
			arg_154_1.duration_ = var_154_0[var_154_1]
		end

		SetActive(arg_154_1.tipsGo_, false)

		function arg_154_1.onSingleLineFinish_()
			arg_154_1.onSingleLineUpdate_ = nil
			arg_154_1.onSingleLineFinish_ = nil
			arg_154_1.state_ = "waiting"
		end

		function arg_154_1.playNext_(arg_156_0)
			if arg_156_0 == 1 then
				arg_154_0:Play1108411038(arg_154_1)
			end
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 then
				arg_154_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102actionlink/10102action446")
			end

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 then
				arg_154_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_157_0 = 0
			local var_157_1 = 0.475

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= var_157_0 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0
				arg_154_1.dialogCg_.alpha = 1

				arg_154_1.dialog_:SetActive(true)
				SetActive(arg_154_1.leftNameGo_, true)

				arg_154_1.leftNameTxt_.text = arg_154_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_154_1.leftNameTxt_.transform)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1.leftNameTxt_.text)
				SetActive(arg_154_1.iconTrs_.gameObject, false)
				arg_154_1.callingController_:SetSelectedState("normal")

				local var_157_2 = arg_154_1:GetWordFromCfg(1108411037)
				local var_157_3 = arg_154_1:FormatText(var_157_2.content)

				arg_154_1.text_.text = var_157_3

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_5 = 19 <= 0 and var_157_1 or var_157_1 * (utf8.len(var_157_3) / 19)

				if (19 <= 0 and var_157_1 or var_157_1 * (utf8.len(var_157_3) / 19)) > 0 and var_157_1 < var_157_5 then
					arg_154_1.talkMaxDuration = var_157_5

					if var_157_5 + var_157_0 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_5 + var_157_0
					end
				end

				arg_154_1.text_.text = var_157_3
				arg_154_1.typewritter.percent = 0

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411037", "story_v_side_new_1108411.awb") ~= 0 then
					local var_157_6 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411037", "story_v_side_new_1108411.awb") / 1000

					if var_157_6 + var_157_0 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_6 + var_157_0
					end

					if var_157_2.prefab_name ~= "" and arg_154_1.actors_[var_157_2.prefab_name] ~= nil then
						local var_157_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_154_1.actors_[var_157_2.prefab_name].transform, "story_v_side_new_1108411", "1108411037", "story_v_side_new_1108411.awb")

						arg_154_1:RecordAudio("1108411037", var_157_7)
						arg_154_1:RecordAudio("1108411037", var_157_7)
					else
						arg_154_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411037", "story_v_side_new_1108411.awb")
					end

					arg_154_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411037", "story_v_side_new_1108411.awb")
				end

				arg_154_1:RecordContent(arg_154_1.text_.text)
			end

			local var_157_8 = math.max(var_157_1, arg_154_1.talkMaxDuration)

			if var_157_0 <= arg_154_1.time_ and arg_154_1.time_ < var_157_0 + var_157_8 then
				arg_154_1.typewritter.percent = (arg_154_1.time_ - var_157_0) / var_157_8

				arg_154_1.typewritter:SetDirty()
			end

			if arg_154_1.time_ >= var_157_0 + var_157_8 and arg_154_1.time_ < var_157_0 + var_157_8 + arg_157_0 then
				arg_154_1.typewritter.percent = 1

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(true)
			end
		end

		arg_154_1.nodeConfigList_ = {}

		arg_154_1:InitPlayNodeList()
	end,
	Play1108411038 = function(arg_158_0, arg_158_1)
		arg_158_1.time_ = 0
		arg_158_1.frameCnt_ = 0
		arg_158_1.state_ = "playing"
		arg_158_1.curTalkId_ = 1108411038
		arg_158_1.duration_ = 5

		SetActive(arg_158_1.tipsGo_, false)

		function arg_158_1.onSingleLineFinish_()
			arg_158_1.onSingleLineUpdate_ = nil
			arg_158_1.onSingleLineFinish_ = nil
			arg_158_1.state_ = "waiting"
		end

		function arg_158_1.playNext_(arg_160_0)
			if arg_160_0 == 1 then
				arg_158_0:Play1108411039(arg_158_1)
			end
		end

		function arg_158_1.onSingleLineUpdate_(arg_161_0)
			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 and not isNil(arg_158_1.actors_["10102ui_story"]) and arg_158_1.var_.characterEffect10102ui_story == nil then
				arg_158_1.var_.characterEffect10102ui_story = arg_158_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_161_0 = 0.200000002980232

			if 0 <= arg_158_1.time_ and arg_158_1.time_ < 0 + var_161_0 and not isNil(arg_158_1.actors_["10102ui_story"]) then
				if arg_158_1.var_.characterEffect10102ui_story and not isNil(arg_158_1.actors_["10102ui_story"]) then
					arg_158_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_158_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_158_1.time_ - 0) / var_161_0)
				end
			end

			if arg_158_1.time_ >= 0 + var_161_0 and arg_158_1.time_ < 0 + var_161_0 + arg_161_0 and not isNil(arg_158_1.actors_["10102ui_story"]) and arg_158_1.var_.characterEffect10102ui_story then
				arg_158_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_158_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_161_1 = 0
			local var_161_2 = 1.625

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= var_161_1 + arg_161_0 then
				arg_158_1.talkMaxDuration = 0
				arg_158_1.dialogCg_.alpha = 1

				arg_158_1.dialog_:SetActive(true)
				SetActive(arg_158_1.leftNameGo_, false)

				arg_158_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_158_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_158_1:RecordName(arg_158_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_158_1.iconTrs_.gameObject, false)
				arg_158_1.callingController_:SetSelectedState("normal")

				local var_161_3 = arg_158_1:FormatText(arg_158_1:GetWordFromCfg(1108411038).content)

				arg_158_1.text_.text = var_161_3

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_5 = 65 <= 0 and var_161_2 or var_161_2 * (utf8.len(var_161_3) / 65)

				if (65 <= 0 and var_161_2 or var_161_2 * (utf8.len(var_161_3) / 65)) > 0 and var_161_2 < var_161_5 then
					arg_158_1.talkMaxDuration = var_161_5

					if var_161_5 + var_161_1 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_5 + var_161_1
					end
				end

				arg_158_1.text_.text = var_161_3
				arg_158_1.typewritter.percent = 0

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(false)
				arg_158_1:RecordContent(arg_158_1.text_.text)
			end

			local var_161_6 = math.max(var_161_2, arg_158_1.talkMaxDuration)

			if var_161_1 <= arg_158_1.time_ and arg_158_1.time_ < var_161_1 + var_161_6 then
				arg_158_1.typewritter.percent = (arg_158_1.time_ - var_161_1) / var_161_6

				arg_158_1.typewritter:SetDirty()
			end

			if arg_158_1.time_ >= var_161_1 + var_161_6 and arg_158_1.time_ < var_161_1 + var_161_6 + arg_161_0 then
				arg_158_1.typewritter.percent = 1

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(true)
			end
		end

		arg_158_1.nodeConfigList_ = {}

		arg_158_1:InitPlayNodeList()
	end,
	Play1108411039 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 1108411039
		arg_162_1.duration_ = 5

		SetActive(arg_162_1.tipsGo_, false)

		function arg_162_1.onSingleLineFinish_()
			arg_162_1.onSingleLineUpdate_ = nil
			arg_162_1.onSingleLineFinish_ = nil
			arg_162_1.state_ = "waiting"
		end

		function arg_162_1.playNext_(arg_164_0)
			if arg_164_0 == 1 then
				arg_162_0:Play1108411040(arg_162_1)
			end
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			local var_165_0 = 0.425

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= 0 + arg_165_0 then
				arg_162_1.talkMaxDuration = 0
				arg_162_1.dialogCg_.alpha = 1

				arg_162_1.dialog_:SetActive(true)
				SetActive(arg_162_1.leftNameGo_, true)

				arg_162_1.leftNameTxt_.text = arg_162_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_162_1.leftNameTxt_.transform)

				arg_162_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_162_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_162_1:RecordName(arg_162_1.leftNameTxt_.text)
				SetActive(arg_162_1.iconTrs_.gameObject, true)
				arg_162_1.iconController_:SetSelectedState("hero")

				arg_162_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_162_1.callingController_:SetSelectedState("normal")

				arg_162_1.keyicon_.color = Color.New(1, 1, 1)
				arg_162_1.icon_.color = Color.New(1, 1, 1)

				local var_165_1 = arg_162_1:FormatText(arg_162_1:GetWordFromCfg(1108411039).content)

				arg_162_1.text_.text = var_165_1

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_3 = 17 <= 0 and var_165_0 or var_165_0 * (utf8.len(var_165_1) / 17)

				if (17 <= 0 and var_165_0 or var_165_0 * (utf8.len(var_165_1) / 17)) > 0 and var_165_0 < var_165_3 then
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
	Play1108411040 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 1108411040
		arg_166_1.duration_ = 7.17

		local var_166_0 = {
			zh = 4.633,
			ja = 7.166
		}
		local var_166_1 = manager.audio:GetLocalizationFlag()

		if var_166_0[var_166_1] ~= nil then
			arg_166_1.duration_ = var_166_0[var_166_1]
		end

		SetActive(arg_166_1.tipsGo_, false)

		function arg_166_1.onSingleLineFinish_()
			arg_166_1.onSingleLineUpdate_ = nil
			arg_166_1.onSingleLineFinish_ = nil
			arg_166_1.state_ = "waiting"
		end

		function arg_166_1.playNext_(arg_168_0)
			if arg_168_0 == 1 then
				arg_166_0:Play1108411041(arg_166_1)
			end
		end

		function arg_166_1.onSingleLineUpdate_(arg_169_0)
			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 and not isNil(arg_166_1.actors_["10102ui_story"]) and arg_166_1.var_.characterEffect10102ui_story == nil then
				arg_166_1.var_.characterEffect10102ui_story = arg_166_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_169_0 = 0.200000002980232

			if 0 <= arg_166_1.time_ and arg_166_1.time_ < 0 + var_169_0 and not isNil(arg_166_1.actors_["10102ui_story"]) then
				if arg_166_1.var_.characterEffect10102ui_story and not isNil(arg_166_1.actors_["10102ui_story"]) then
					arg_166_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_166_1.time_ >= 0 + var_169_0 and arg_166_1.time_ < 0 + var_169_0 + arg_169_0 and not isNil(arg_166_1.actors_["10102ui_story"]) and arg_166_1.var_.characterEffect10102ui_story then
				arg_166_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 then
				arg_166_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action6_2")
			end

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 then
				arg_166_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_169_2 = 0
			local var_169_3 = 0.575

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= var_169_2 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0
				arg_166_1.dialogCg_.alpha = 1

				arg_166_1.dialog_:SetActive(true)
				SetActive(arg_166_1.leftNameGo_, true)

				arg_166_1.leftNameTxt_.text = arg_166_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_166_1.leftNameTxt_.transform)

				arg_166_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_166_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_166_1:RecordName(arg_166_1.leftNameTxt_.text)
				SetActive(arg_166_1.iconTrs_.gameObject, false)
				arg_166_1.callingController_:SetSelectedState("normal")

				local var_169_4 = arg_166_1:GetWordFromCfg(1108411040)
				local var_169_5 = arg_166_1:FormatText(var_169_4.content)

				arg_166_1.text_.text = var_169_5

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_7 = 23 <= 0 and var_169_3 or var_169_3 * (utf8.len(var_169_5) / 23)

				if (23 <= 0 and var_169_3 or var_169_3 * (utf8.len(var_169_5) / 23)) > 0 and var_169_3 < var_169_7 then
					arg_166_1.talkMaxDuration = var_169_7

					if var_169_7 + var_169_2 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_7 + var_169_2
					end
				end

				arg_166_1.text_.text = var_169_5
				arg_166_1.typewritter.percent = 0

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411040", "story_v_side_new_1108411.awb") ~= 0 then
					local var_169_8 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411040", "story_v_side_new_1108411.awb") / 1000

					if var_169_8 + var_169_2 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_8 + var_169_2
					end

					if var_169_4.prefab_name ~= "" and arg_166_1.actors_[var_169_4.prefab_name] ~= nil then
						local var_169_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_166_1.actors_[var_169_4.prefab_name].transform, "story_v_side_new_1108411", "1108411040", "story_v_side_new_1108411.awb")

						arg_166_1:RecordAudio("1108411040", var_169_9)
						arg_166_1:RecordAudio("1108411040", var_169_9)
					else
						arg_166_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411040", "story_v_side_new_1108411.awb")
					end

					arg_166_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411040", "story_v_side_new_1108411.awb")
				end

				arg_166_1:RecordContent(arg_166_1.text_.text)
			end

			local var_169_10 = math.max(var_169_3, arg_166_1.talkMaxDuration)

			if var_169_2 <= arg_166_1.time_ and arg_166_1.time_ < var_169_2 + var_169_10 then
				arg_166_1.typewritter.percent = (arg_166_1.time_ - var_169_2) / var_169_10

				arg_166_1.typewritter:SetDirty()
			end

			if arg_166_1.time_ >= var_169_2 + var_169_10 and arg_166_1.time_ < var_169_2 + var_169_10 + arg_169_0 then
				arg_166_1.typewritter.percent = 1

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(true)
			end
		end

		arg_166_1.nodeConfigList_ = {}

		arg_166_1:InitPlayNodeList()
	end,
	Play1108411041 = function(arg_170_0, arg_170_1)
		arg_170_1.time_ = 0
		arg_170_1.frameCnt_ = 0
		arg_170_1.state_ = "playing"
		arg_170_1.curTalkId_ = 1108411041
		arg_170_1.duration_ = 5

		SetActive(arg_170_1.tipsGo_, false)

		function arg_170_1.onSingleLineFinish_()
			arg_170_1.onSingleLineUpdate_ = nil
			arg_170_1.onSingleLineFinish_ = nil
			arg_170_1.state_ = "waiting"
		end

		function arg_170_1.playNext_(arg_172_0)
			if arg_172_0 == 1 then
				arg_170_0:Play1108411042(arg_170_1)
			end
		end

		function arg_170_1.onSingleLineUpdate_(arg_173_0)
			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 and not isNil(arg_170_1.actors_["10102ui_story"]) and arg_170_1.var_.characterEffect10102ui_story == nil then
				arg_170_1.var_.characterEffect10102ui_story = arg_170_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_173_0 = 0.200000002980232

			if 0 <= arg_170_1.time_ and arg_170_1.time_ < 0 + var_173_0 and not isNil(arg_170_1.actors_["10102ui_story"]) then
				if arg_170_1.var_.characterEffect10102ui_story and not isNil(arg_170_1.actors_["10102ui_story"]) then
					arg_170_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_170_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_170_1.time_ - 0) / var_173_0)
				end
			end

			if arg_170_1.time_ >= 0 + var_173_0 and arg_170_1.time_ < 0 + var_173_0 + arg_173_0 and not isNil(arg_170_1.actors_["10102ui_story"]) and arg_170_1.var_.characterEffect10102ui_story then
				arg_170_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_170_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_173_1 = 0
			local var_173_2 = 0.325

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= var_173_1 + arg_173_0 then
				arg_170_1.talkMaxDuration = 0
				arg_170_1.dialogCg_.alpha = 1

				arg_170_1.dialog_:SetActive(true)
				SetActive(arg_170_1.leftNameGo_, true)

				arg_170_1.leftNameTxt_.text = arg_170_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_170_1.leftNameTxt_.transform)

				arg_170_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_170_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_170_1:RecordName(arg_170_1.leftNameTxt_.text)
				SetActive(arg_170_1.iconTrs_.gameObject, true)
				arg_170_1.iconController_:SetSelectedState("hero")

				arg_170_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_170_1.callingController_:SetSelectedState("normal")

				arg_170_1.keyicon_.color = Color.New(1, 1, 1)
				arg_170_1.icon_.color = Color.New(1, 1, 1)

				local var_173_3 = arg_170_1:FormatText(arg_170_1:GetWordFromCfg(1108411041).content)

				arg_170_1.text_.text = var_173_3

				LuaForUtil.ClearLinePrefixSymbol(arg_170_1.text_)

				local var_173_5 = 13 <= 0 and var_173_2 or var_173_2 * (utf8.len(var_173_3) / 13)

				if (13 <= 0 and var_173_2 or var_173_2 * (utf8.len(var_173_3) / 13)) > 0 and var_173_2 < var_173_5 then
					arg_170_1.talkMaxDuration = var_173_5

					if var_173_5 + var_173_1 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_5 + var_173_1
					end
				end

				arg_170_1.text_.text = var_173_3
				arg_170_1.typewritter.percent = 0

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(false)
				arg_170_1:RecordContent(arg_170_1.text_.text)
			end

			local var_173_6 = math.max(var_173_2, arg_170_1.talkMaxDuration)

			if var_173_1 <= arg_170_1.time_ and arg_170_1.time_ < var_173_1 + var_173_6 then
				arg_170_1.typewritter.percent = (arg_170_1.time_ - var_173_1) / var_173_6

				arg_170_1.typewritter:SetDirty()
			end

			if arg_170_1.time_ >= var_173_1 + var_173_6 and arg_170_1.time_ < var_173_1 + var_173_6 + arg_173_0 then
				arg_170_1.typewritter.percent = 1

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(true)
			end
		end

		arg_170_1.nodeConfigList_ = {}

		arg_170_1:InitPlayNodeList()
	end,
	Play1108411042 = function(arg_174_0, arg_174_1)
		arg_174_1.time_ = 0
		arg_174_1.frameCnt_ = 0
		arg_174_1.state_ = "playing"
		arg_174_1.curTalkId_ = 1108411042
		arg_174_1.duration_ = 10.53

		local var_174_0 = {
			zh = 8.6,
			ja = 10.533
		}
		local var_174_1 = manager.audio:GetLocalizationFlag()

		if var_174_0[var_174_1] ~= nil then
			arg_174_1.duration_ = var_174_0[var_174_1]
		end

		SetActive(arg_174_1.tipsGo_, false)

		function arg_174_1.onSingleLineFinish_()
			arg_174_1.onSingleLineUpdate_ = nil
			arg_174_1.onSingleLineFinish_ = nil
			arg_174_1.state_ = "waiting"
		end

		function arg_174_1.playNext_(arg_176_0)
			if arg_176_0 == 1 then
				arg_174_0:Play1108411043(arg_174_1)
			end
		end

		function arg_174_1.onSingleLineUpdate_(arg_177_0)
			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 and not isNil(arg_174_1.actors_["10102ui_story"]) and arg_174_1.var_.characterEffect10102ui_story == nil then
				arg_174_1.var_.characterEffect10102ui_story = arg_174_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_177_0 = 0.200000002980232

			if 0 <= arg_174_1.time_ and arg_174_1.time_ < 0 + var_177_0 and not isNil(arg_174_1.actors_["10102ui_story"]) then
				if arg_174_1.var_.characterEffect10102ui_story and not isNil(arg_174_1.actors_["10102ui_story"]) then
					arg_174_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_174_1.time_ >= 0 + var_177_0 and arg_174_1.time_ < 0 + var_177_0 + arg_177_0 and not isNil(arg_174_1.actors_["10102ui_story"]) and arg_174_1.var_.characterEffect10102ui_story then
				arg_174_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_177_2 = 0
			local var_177_3 = 1.05

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= var_177_2 + arg_177_0 then
				arg_174_1.talkMaxDuration = 0
				arg_174_1.dialogCg_.alpha = 1

				arg_174_1.dialog_:SetActive(true)
				SetActive(arg_174_1.leftNameGo_, true)

				arg_174_1.leftNameTxt_.text = arg_174_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_174_1.leftNameTxt_.transform)

				arg_174_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_174_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_174_1:RecordName(arg_174_1.leftNameTxt_.text)
				SetActive(arg_174_1.iconTrs_.gameObject, false)
				arg_174_1.callingController_:SetSelectedState("normal")

				local var_177_4 = arg_174_1:GetWordFromCfg(1108411042)
				local var_177_5 = arg_174_1:FormatText(var_177_4.content)

				arg_174_1.text_.text = var_177_5

				LuaForUtil.ClearLinePrefixSymbol(arg_174_1.text_)

				local var_177_7 = 42 <= 0 and var_177_3 or var_177_3 * (utf8.len(var_177_5) / 42)

				if (42 <= 0 and var_177_3 or var_177_3 * (utf8.len(var_177_5) / 42)) > 0 and var_177_3 < var_177_7 then
					arg_174_1.talkMaxDuration = var_177_7

					if var_177_7 + var_177_2 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_7 + var_177_2
					end
				end

				arg_174_1.text_.text = var_177_5
				arg_174_1.typewritter.percent = 0

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411042", "story_v_side_new_1108411.awb") ~= 0 then
					local var_177_8 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411042", "story_v_side_new_1108411.awb") / 1000

					if var_177_8 + var_177_2 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_8 + var_177_2
					end

					if var_177_4.prefab_name ~= "" and arg_174_1.actors_[var_177_4.prefab_name] ~= nil then
						local var_177_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_174_1.actors_[var_177_4.prefab_name].transform, "story_v_side_new_1108411", "1108411042", "story_v_side_new_1108411.awb")

						arg_174_1:RecordAudio("1108411042", var_177_9)
						arg_174_1:RecordAudio("1108411042", var_177_9)
					else
						arg_174_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411042", "story_v_side_new_1108411.awb")
					end

					arg_174_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411042", "story_v_side_new_1108411.awb")
				end

				arg_174_1:RecordContent(arg_174_1.text_.text)
			end

			local var_177_10 = math.max(var_177_3, arg_174_1.talkMaxDuration)

			if var_177_2 <= arg_174_1.time_ and arg_174_1.time_ < var_177_2 + var_177_10 then
				arg_174_1.typewritter.percent = (arg_174_1.time_ - var_177_2) / var_177_10

				arg_174_1.typewritter:SetDirty()
			end

			if arg_174_1.time_ >= var_177_2 + var_177_10 and arg_174_1.time_ < var_177_2 + var_177_10 + arg_177_0 then
				arg_174_1.typewritter.percent = 1

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(true)
			end
		end

		arg_174_1.nodeConfigList_ = {}

		arg_174_1:InitPlayNodeList()
	end,
	Play1108411043 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 1108411043
		arg_178_1.duration_ = 6.47

		local var_178_0 = {
			zh = 4.5,
			ja = 6.466
		}
		local var_178_1 = manager.audio:GetLocalizationFlag()

		if var_178_0[var_178_1] ~= nil then
			arg_178_1.duration_ = var_178_0[var_178_1]
		end

		SetActive(arg_178_1.tipsGo_, false)

		function arg_178_1.onSingleLineFinish_()
			arg_178_1.onSingleLineUpdate_ = nil
			arg_178_1.onSingleLineFinish_ = nil
			arg_178_1.state_ = "waiting"
		end

		function arg_178_1.playNext_(arg_180_0)
			if arg_180_0 == 1 then
				arg_178_0:Play1108411044(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 then
				arg_178_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action5_1")
			end

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 then
				arg_178_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_deyiA", "EmotionTimelineAnimator")
			end

			local var_181_0 = 0
			local var_181_1 = 0.475

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= var_181_0 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0
				arg_178_1.dialogCg_.alpha = 1

				arg_178_1.dialog_:SetActive(true)
				SetActive(arg_178_1.leftNameGo_, true)

				arg_178_1.leftNameTxt_.text = arg_178_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_178_1.leftNameTxt_.transform)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1.leftNameTxt_.text)
				SetActive(arg_178_1.iconTrs_.gameObject, false)
				arg_178_1.callingController_:SetSelectedState("normal")

				local var_181_2 = arg_178_1:GetWordFromCfg(1108411043)
				local var_181_3 = arg_178_1:FormatText(var_181_2.content)

				arg_178_1.text_.text = var_181_3

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_5 = 19 <= 0 and var_181_1 or var_181_1 * (utf8.len(var_181_3) / 19)

				if (19 <= 0 and var_181_1 or var_181_1 * (utf8.len(var_181_3) / 19)) > 0 and var_181_1 < var_181_5 then
					arg_178_1.talkMaxDuration = var_181_5

					if var_181_5 + var_181_0 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_5 + var_181_0
					end
				end

				arg_178_1.text_.text = var_181_3
				arg_178_1.typewritter.percent = 0

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411043", "story_v_side_new_1108411.awb") ~= 0 then
					local var_181_6 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411043", "story_v_side_new_1108411.awb") / 1000

					if var_181_6 + var_181_0 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_6 + var_181_0
					end

					if var_181_2.prefab_name ~= "" and arg_178_1.actors_[var_181_2.prefab_name] ~= nil then
						local var_181_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_178_1.actors_[var_181_2.prefab_name].transform, "story_v_side_new_1108411", "1108411043", "story_v_side_new_1108411.awb")

						arg_178_1:RecordAudio("1108411043", var_181_7)
						arg_178_1:RecordAudio("1108411043", var_181_7)
					else
						arg_178_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411043", "story_v_side_new_1108411.awb")
					end

					arg_178_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411043", "story_v_side_new_1108411.awb")
				end

				arg_178_1:RecordContent(arg_178_1.text_.text)
			end

			local var_181_8 = math.max(var_181_1, arg_178_1.talkMaxDuration)

			if var_181_0 <= arg_178_1.time_ and arg_178_1.time_ < var_181_0 + var_181_8 then
				arg_178_1.typewritter.percent = (arg_178_1.time_ - var_181_0) / var_181_8

				arg_178_1.typewritter:SetDirty()
			end

			if arg_178_1.time_ >= var_181_0 + var_181_8 and arg_178_1.time_ < var_181_0 + var_181_8 + arg_181_0 then
				arg_178_1.typewritter.percent = 1

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(true)
			end
		end

		arg_178_1.nodeConfigList_ = {}

		arg_178_1:InitPlayNodeList()
	end,
	Play1108411044 = function(arg_182_0, arg_182_1)
		arg_182_1.time_ = 0
		arg_182_1.frameCnt_ = 0
		arg_182_1.state_ = "playing"
		arg_182_1.curTalkId_ = 1108411044
		arg_182_1.duration_ = 5

		SetActive(arg_182_1.tipsGo_, false)

		function arg_182_1.onSingleLineFinish_()
			arg_182_1.onSingleLineUpdate_ = nil
			arg_182_1.onSingleLineFinish_ = nil
			arg_182_1.state_ = "waiting"
		end

		function arg_182_1.playNext_(arg_184_0)
			if arg_184_0 == 1 then
				arg_182_0:Play1108411045(arg_182_1)
			end
		end

		function arg_182_1.onSingleLineUpdate_(arg_185_0)
			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 then
				arg_182_1.var_.moveOldPos10102ui_story = arg_182_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_185_0 = 0.001

			if 0 <= arg_182_1.time_ and arg_182_1.time_ < 0 + var_185_0 then
				arg_182_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_182_1.var_.moveOldPos10102ui_story, Vector3.New(0, 100, 0), (arg_182_1.time_ - 0) / var_185_0)
				arg_182_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_182_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_182_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_182_1.actors_["10102ui_story"].transform.position).z)
				arg_182_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_182_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_182_1.actors_["10102ui_story"].transform.localEulerAngles = arg_182_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_182_1.time_ >= 0 + var_185_0 and arg_182_1.time_ < 0 + var_185_0 + arg_185_0 then
				arg_182_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_182_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_182_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_182_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_182_1.actors_["10102ui_story"].transform.position).z)
				arg_182_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_182_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_182_1.actors_["10102ui_story"].transform.localEulerAngles = arg_182_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_185_1 = arg_182_1.actors_["10102ui_story"]

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 and not isNil(var_185_1) and arg_182_1.var_.characterEffect10102ui_story == nil then
				arg_182_1.var_.characterEffect10102ui_story = var_185_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_185_2 = 0.200000002980232

			if 0 <= arg_182_1.time_ and arg_182_1.time_ < 0 + var_185_2 and not isNil(var_185_1) then
				if arg_182_1.var_.characterEffect10102ui_story and not isNil(var_185_1) then
					arg_182_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_182_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_182_1.time_ - 0) / var_185_2)
				end
			end

			if arg_182_1.time_ >= 0 + var_185_2 and arg_182_1.time_ < 0 + var_185_2 + arg_185_0 and not isNil(var_185_1) and arg_182_1.var_.characterEffect10102ui_story then
				arg_182_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_182_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_185_3 = 0
			local var_185_4 = 1

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= var_185_3 + arg_185_0 then
				arg_182_1.talkMaxDuration = 0
				arg_182_1.dialogCg_.alpha = 1

				arg_182_1.dialog_:SetActive(true)
				SetActive(arg_182_1.leftNameGo_, false)

				arg_182_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_182_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_182_1:RecordName(arg_182_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_182_1.iconTrs_.gameObject, false)
				arg_182_1.callingController_:SetSelectedState("normal")

				local var_185_5 = arg_182_1:FormatText(arg_182_1:GetWordFromCfg(1108411044).content)

				arg_182_1.text_.text = var_185_5

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_7 = 40 <= 0 and var_185_4 or var_185_4 * (utf8.len(var_185_5) / 40)

				if (40 <= 0 and var_185_4 or var_185_4 * (utf8.len(var_185_5) / 40)) > 0 and var_185_4 < var_185_7 then
					arg_182_1.talkMaxDuration = var_185_7

					if var_185_7 + var_185_3 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_7 + var_185_3
					end
				end

				arg_182_1.text_.text = var_185_5
				arg_182_1.typewritter.percent = 0

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(false)
				arg_182_1:RecordContent(arg_182_1.text_.text)
			end

			local var_185_8 = math.max(var_185_4, arg_182_1.talkMaxDuration)

			if var_185_3 <= arg_182_1.time_ and arg_182_1.time_ < var_185_3 + var_185_8 then
				arg_182_1.typewritter.percent = (arg_182_1.time_ - var_185_3) / var_185_8

				arg_182_1.typewritter:SetDirty()
			end

			if arg_182_1.time_ >= var_185_3 + var_185_8 and arg_182_1.time_ < var_185_3 + var_185_8 + arg_185_0 then
				arg_182_1.typewritter.percent = 1

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(true)
			end
		end

		arg_182_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_182_1:InitPlayNodeList()
	end,
	Play1108411045 = function(arg_186_0, arg_186_1)
		arg_186_1.time_ = 0
		arg_186_1.frameCnt_ = 0
		arg_186_1.state_ = "playing"
		arg_186_1.curTalkId_ = 1108411045
		arg_186_1.duration_ = 5.67

		local var_186_0 = {
			zh = 5.633,
			ja = 5.666
		}
		local var_186_1 = manager.audio:GetLocalizationFlag()

		if var_186_0[var_186_1] ~= nil then
			arg_186_1.duration_ = var_186_0[var_186_1]
		end

		SetActive(arg_186_1.tipsGo_, false)

		function arg_186_1.onSingleLineFinish_()
			arg_186_1.onSingleLineUpdate_ = nil
			arg_186_1.onSingleLineFinish_ = nil
			arg_186_1.state_ = "waiting"
		end

		function arg_186_1.playNext_(arg_188_0)
			if arg_188_0 == 1 then
				arg_186_0:Play1108411046(arg_186_1)
			end
		end

		function arg_186_1.onSingleLineUpdate_(arg_189_0)
			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 then
				arg_186_1.var_.moveOldPos10102ui_story = arg_186_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_189_0 = 0.001

			if 0 <= arg_186_1.time_ and arg_186_1.time_ < 0 + var_189_0 then
				arg_186_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_186_1.var_.moveOldPos10102ui_story, Vector3.New(0, -0.985, -6.275), (arg_186_1.time_ - 0) / var_189_0)
				arg_186_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_186_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_186_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_186_1.actors_["10102ui_story"].transform.position).z)
				arg_186_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_186_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_186_1.actors_["10102ui_story"].transform.localEulerAngles = arg_186_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_186_1.time_ >= 0 + var_189_0 and arg_186_1.time_ < 0 + var_189_0 + arg_189_0 then
				arg_186_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6.275)
				arg_186_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_186_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_186_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_186_1.actors_["10102ui_story"].transform.position).z)
				arg_186_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_186_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_186_1.actors_["10102ui_story"].transform.localEulerAngles = arg_186_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_189_1 = arg_186_1.actors_["10102ui_story"]

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 and not isNil(var_189_1) and arg_186_1.var_.characterEffect10102ui_story == nil then
				arg_186_1.var_.characterEffect10102ui_story = var_189_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_189_2 = 0.200000002980232

			if 0 <= arg_186_1.time_ and arg_186_1.time_ < 0 + var_189_2 and not isNil(var_189_1) then
				if arg_186_1.var_.characterEffect10102ui_story and not isNil(var_189_1) then
					arg_186_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_186_1.time_ >= 0 + var_189_2 and arg_186_1.time_ < 0 + var_189_2 + arg_189_0 and not isNil(var_189_1) and arg_186_1.var_.characterEffect10102ui_story then
				arg_186_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 then
				arg_186_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action5_2")
			end

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 then
				arg_186_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_189_4 = 0
			local var_189_5 = 0.775

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= var_189_4 + arg_189_0 then
				arg_186_1.talkMaxDuration = 0
				arg_186_1.dialogCg_.alpha = 1

				arg_186_1.dialog_:SetActive(true)
				SetActive(arg_186_1.leftNameGo_, true)

				arg_186_1.leftNameTxt_.text = arg_186_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_186_1.leftNameTxt_.transform)

				arg_186_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_186_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_186_1:RecordName(arg_186_1.leftNameTxt_.text)
				SetActive(arg_186_1.iconTrs_.gameObject, false)
				arg_186_1.callingController_:SetSelectedState("normal")

				local var_189_6 = arg_186_1:GetWordFromCfg(1108411045)
				local var_189_7 = arg_186_1:FormatText(var_189_6.content)

				arg_186_1.text_.text = var_189_7

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_9 = 31 <= 0 and var_189_5 or var_189_5 * (utf8.len(var_189_7) / 31)

				if (31 <= 0 and var_189_5 or var_189_5 * (utf8.len(var_189_7) / 31)) > 0 and var_189_5 < var_189_9 then
					arg_186_1.talkMaxDuration = var_189_9

					if var_189_9 + var_189_4 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_9 + var_189_4
					end
				end

				arg_186_1.text_.text = var_189_7
				arg_186_1.typewritter.percent = 0

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411045", "story_v_side_new_1108411.awb") ~= 0 then
					local var_189_10 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411045", "story_v_side_new_1108411.awb") / 1000

					if var_189_10 + var_189_4 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_10 + var_189_4
					end

					if var_189_6.prefab_name ~= "" and arg_186_1.actors_[var_189_6.prefab_name] ~= nil then
						local var_189_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_186_1.actors_[var_189_6.prefab_name].transform, "story_v_side_new_1108411", "1108411045", "story_v_side_new_1108411.awb")

						arg_186_1:RecordAudio("1108411045", var_189_11)
						arg_186_1:RecordAudio("1108411045", var_189_11)
					else
						arg_186_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411045", "story_v_side_new_1108411.awb")
					end

					arg_186_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411045", "story_v_side_new_1108411.awb")
				end

				arg_186_1:RecordContent(arg_186_1.text_.text)
			end

			local var_189_12 = math.max(var_189_5, arg_186_1.talkMaxDuration)

			if var_189_4 <= arg_186_1.time_ and arg_186_1.time_ < var_189_4 + var_189_12 then
				arg_186_1.typewritter.percent = (arg_186_1.time_ - var_189_4) / var_189_12

				arg_186_1.typewritter:SetDirty()
			end

			if arg_186_1.time_ >= var_189_4 + var_189_12 and arg_186_1.time_ < var_189_4 + var_189_12 + arg_189_0 then
				arg_186_1.typewritter.percent = 1

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(true)
			end
		end

		arg_186_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_186_1:InitPlayNodeList()
	end,
	Play1108411046 = function(arg_190_0, arg_190_1)
		arg_190_1.time_ = 0
		arg_190_1.frameCnt_ = 0
		arg_190_1.state_ = "playing"
		arg_190_1.curTalkId_ = 1108411046
		arg_190_1.duration_ = 5

		SetActive(arg_190_1.tipsGo_, false)

		function arg_190_1.onSingleLineFinish_()
			arg_190_1.onSingleLineUpdate_ = nil
			arg_190_1.onSingleLineFinish_ = nil
			arg_190_1.state_ = "waiting"
		end

		function arg_190_1.playNext_(arg_192_0)
			if arg_192_0 == 1 then
				arg_190_0:Play1108411047(arg_190_1)
			end
		end

		function arg_190_1.onSingleLineUpdate_(arg_193_0)
			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 and not isNil(arg_190_1.actors_["10102ui_story"]) and arg_190_1.var_.characterEffect10102ui_story == nil then
				arg_190_1.var_.characterEffect10102ui_story = arg_190_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_193_0 = 0.200000002980232

			if 0 <= arg_190_1.time_ and arg_190_1.time_ < 0 + var_193_0 and not isNil(arg_190_1.actors_["10102ui_story"]) then
				if arg_190_1.var_.characterEffect10102ui_story and not isNil(arg_190_1.actors_["10102ui_story"]) then
					arg_190_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_190_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_190_1.time_ - 0) / var_193_0)
				end
			end

			if arg_190_1.time_ >= 0 + var_193_0 and arg_190_1.time_ < 0 + var_193_0 + arg_193_0 and not isNil(arg_190_1.actors_["10102ui_story"]) and arg_190_1.var_.characterEffect10102ui_story then
				arg_190_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_190_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_193_1 = 0
			local var_193_2 = 0.55

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= var_193_1 + arg_193_0 then
				arg_190_1.talkMaxDuration = 0
				arg_190_1.dialogCg_.alpha = 1

				arg_190_1.dialog_:SetActive(true)
				SetActive(arg_190_1.leftNameGo_, true)

				arg_190_1.leftNameTxt_.text = arg_190_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_190_1.leftNameTxt_.transform)

				arg_190_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_190_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_190_1:RecordName(arg_190_1.leftNameTxt_.text)
				SetActive(arg_190_1.iconTrs_.gameObject, true)
				arg_190_1.iconController_:SetSelectedState("hero")

				arg_190_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_190_1.callingController_:SetSelectedState("normal")

				arg_190_1.keyicon_.color = Color.New(1, 1, 1)
				arg_190_1.icon_.color = Color.New(1, 1, 1)

				local var_193_3 = arg_190_1:FormatText(arg_190_1:GetWordFromCfg(1108411046).content)

				arg_190_1.text_.text = var_193_3

				LuaForUtil.ClearLinePrefixSymbol(arg_190_1.text_)

				local var_193_5 = 22 <= 0 and var_193_2 or var_193_2 * (utf8.len(var_193_3) / 22)

				if (22 <= 0 and var_193_2 or var_193_2 * (utf8.len(var_193_3) / 22)) > 0 and var_193_2 < var_193_5 then
					arg_190_1.talkMaxDuration = var_193_5

					if var_193_5 + var_193_1 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_5 + var_193_1
					end
				end

				arg_190_1.text_.text = var_193_3
				arg_190_1.typewritter.percent = 0

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(false)
				arg_190_1:RecordContent(arg_190_1.text_.text)
			end

			local var_193_6 = math.max(var_193_2, arg_190_1.talkMaxDuration)

			if var_193_1 <= arg_190_1.time_ and arg_190_1.time_ < var_193_1 + var_193_6 then
				arg_190_1.typewritter.percent = (arg_190_1.time_ - var_193_1) / var_193_6

				arg_190_1.typewritter:SetDirty()
			end

			if arg_190_1.time_ >= var_193_1 + var_193_6 and arg_190_1.time_ < var_193_1 + var_193_6 + arg_193_0 then
				arg_190_1.typewritter.percent = 1

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(true)
			end
		end

		arg_190_1.nodeConfigList_ = {}

		arg_190_1:InitPlayNodeList()
	end,
	Play1108411047 = function(arg_194_0, arg_194_1)
		arg_194_1.time_ = 0
		arg_194_1.frameCnt_ = 0
		arg_194_1.state_ = "playing"
		arg_194_1.curTalkId_ = 1108411047
		arg_194_1.duration_ = 4.33

		local var_194_0 = {
			zh = 4.333,
			ja = 3.666
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
				arg_194_0:Play1108411048(arg_194_1)
			end
		end

		function arg_194_1.onSingleLineUpdate_(arg_197_0)
			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 and not isNil(arg_194_1.actors_["10102ui_story"]) and arg_194_1.var_.characterEffect10102ui_story == nil then
				arg_194_1.var_.characterEffect10102ui_story = arg_194_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_197_0 = 0.200000002980232

			if 0 <= arg_194_1.time_ and arg_194_1.time_ < 0 + var_197_0 and not isNil(arg_194_1.actors_["10102ui_story"]) then
				if arg_194_1.var_.characterEffect10102ui_story and not isNil(arg_194_1.actors_["10102ui_story"]) then
					arg_194_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_194_1.time_ >= 0 + var_197_0 and arg_194_1.time_ < 0 + var_197_0 + arg_197_0 and not isNil(arg_194_1.actors_["10102ui_story"]) and arg_194_1.var_.characterEffect10102ui_story then
				arg_194_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_197_2 = 0
			local var_197_3 = 0.4

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= var_197_2 + arg_197_0 then
				arg_194_1.talkMaxDuration = 0
				arg_194_1.dialogCg_.alpha = 1

				arg_194_1.dialog_:SetActive(true)
				SetActive(arg_194_1.leftNameGo_, true)

				arg_194_1.leftNameTxt_.text = arg_194_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_194_1.leftNameTxt_.transform)

				arg_194_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_194_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_194_1:RecordName(arg_194_1.leftNameTxt_.text)
				SetActive(arg_194_1.iconTrs_.gameObject, false)
				arg_194_1.callingController_:SetSelectedState("normal")

				local var_197_4 = arg_194_1:GetWordFromCfg(1108411047)
				local var_197_5 = arg_194_1:FormatText(var_197_4.content)

				arg_194_1.text_.text = var_197_5

				LuaForUtil.ClearLinePrefixSymbol(arg_194_1.text_)

				local var_197_7 = 16 <= 0 and var_197_3 or var_197_3 * (utf8.len(var_197_5) / 16)

				if (16 <= 0 and var_197_3 or var_197_3 * (utf8.len(var_197_5) / 16)) > 0 and var_197_3 < var_197_7 then
					arg_194_1.talkMaxDuration = var_197_7

					if var_197_7 + var_197_2 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_7 + var_197_2
					end
				end

				arg_194_1.text_.text = var_197_5
				arg_194_1.typewritter.percent = 0

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411047", "story_v_side_new_1108411.awb") ~= 0 then
					local var_197_8 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411047", "story_v_side_new_1108411.awb") / 1000

					if var_197_8 + var_197_2 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_8 + var_197_2
					end

					if var_197_4.prefab_name ~= "" and arg_194_1.actors_[var_197_4.prefab_name] ~= nil then
						local var_197_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_194_1.actors_[var_197_4.prefab_name].transform, "story_v_side_new_1108411", "1108411047", "story_v_side_new_1108411.awb")

						arg_194_1:RecordAudio("1108411047", var_197_9)
						arg_194_1:RecordAudio("1108411047", var_197_9)
					else
						arg_194_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411047", "story_v_side_new_1108411.awb")
					end

					arg_194_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411047", "story_v_side_new_1108411.awb")
				end

				arg_194_1:RecordContent(arg_194_1.text_.text)
			end

			local var_197_10 = math.max(var_197_3, arg_194_1.talkMaxDuration)

			if var_197_2 <= arg_194_1.time_ and arg_194_1.time_ < var_197_2 + var_197_10 then
				arg_194_1.typewritter.percent = (arg_194_1.time_ - var_197_2) / var_197_10

				arg_194_1.typewritter:SetDirty()
			end

			if arg_194_1.time_ >= var_197_2 + var_197_10 and arg_194_1.time_ < var_197_2 + var_197_10 + arg_197_0 then
				arg_194_1.typewritter.percent = 1

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(true)
			end
		end

		arg_194_1.nodeConfigList_ = {}

		arg_194_1:InitPlayNodeList()
	end,
	Play1108411048 = function(arg_198_0, arg_198_1)
		arg_198_1.time_ = 0
		arg_198_1.frameCnt_ = 0
		arg_198_1.state_ = "playing"
		arg_198_1.curTalkId_ = 1108411048
		arg_198_1.duration_ = 5

		SetActive(arg_198_1.tipsGo_, false)

		function arg_198_1.onSingleLineFinish_()
			arg_198_1.onSingleLineUpdate_ = nil
			arg_198_1.onSingleLineFinish_ = nil
			arg_198_1.state_ = "waiting"
		end

		function arg_198_1.playNext_(arg_200_0)
			if arg_200_0 == 1 then
				arg_198_0:Play1108411049(arg_198_1)
			end
		end

		function arg_198_1.onSingleLineUpdate_(arg_201_0)
			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 and not isNil(arg_198_1.actors_["10102ui_story"]) and arg_198_1.var_.characterEffect10102ui_story == nil then
				arg_198_1.var_.characterEffect10102ui_story = arg_198_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_201_0 = 0.200000002980232

			if 0 <= arg_198_1.time_ and arg_198_1.time_ < 0 + var_201_0 and not isNil(arg_198_1.actors_["10102ui_story"]) then
				if arg_198_1.var_.characterEffect10102ui_story and not isNil(arg_198_1.actors_["10102ui_story"]) then
					arg_198_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_198_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_198_1.time_ - 0) / var_201_0)
				end
			end

			if arg_198_1.time_ >= 0 + var_201_0 and arg_198_1.time_ < 0 + var_201_0 + arg_201_0 and not isNil(arg_198_1.actors_["10102ui_story"]) and arg_198_1.var_.characterEffect10102ui_story then
				arg_198_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_198_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_201_1 = 0
			local var_201_2 = 0.675

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= var_201_1 + arg_201_0 then
				arg_198_1.talkMaxDuration = 0
				arg_198_1.dialogCg_.alpha = 1

				arg_198_1.dialog_:SetActive(true)
				SetActive(arg_198_1.leftNameGo_, true)

				arg_198_1.leftNameTxt_.text = arg_198_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_198_1.leftNameTxt_.transform)

				arg_198_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_198_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_198_1:RecordName(arg_198_1.leftNameTxt_.text)
				SetActive(arg_198_1.iconTrs_.gameObject, true)
				arg_198_1.iconController_:SetSelectedState("hero")

				arg_198_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_198_1.callingController_:SetSelectedState("normal")

				arg_198_1.keyicon_.color = Color.New(1, 1, 1)
				arg_198_1.icon_.color = Color.New(1, 1, 1)

				local var_201_3 = arg_198_1:FormatText(arg_198_1:GetWordFromCfg(1108411048).content)

				arg_198_1.text_.text = var_201_3

				LuaForUtil.ClearLinePrefixSymbol(arg_198_1.text_)

				local var_201_5 = 27 <= 0 and var_201_2 or var_201_2 * (utf8.len(var_201_3) / 27)

				if (27 <= 0 and var_201_2 or var_201_2 * (utf8.len(var_201_3) / 27)) > 0 and var_201_2 < var_201_5 then
					arg_198_1.talkMaxDuration = var_201_5

					if var_201_5 + var_201_1 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_5 + var_201_1
					end
				end

				arg_198_1.text_.text = var_201_3
				arg_198_1.typewritter.percent = 0

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(false)
				arg_198_1:RecordContent(arg_198_1.text_.text)
			end

			local var_201_6 = math.max(var_201_2, arg_198_1.talkMaxDuration)

			if var_201_1 <= arg_198_1.time_ and arg_198_1.time_ < var_201_1 + var_201_6 then
				arg_198_1.typewritter.percent = (arg_198_1.time_ - var_201_1) / var_201_6

				arg_198_1.typewritter:SetDirty()
			end

			if arg_198_1.time_ >= var_201_1 + var_201_6 and arg_198_1.time_ < var_201_1 + var_201_6 + arg_201_0 then
				arg_198_1.typewritter.percent = 1

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(true)
			end
		end

		arg_198_1.nodeConfigList_ = {}

		arg_198_1:InitPlayNodeList()
	end,
	Play1108411049 = function(arg_202_0, arg_202_1)
		arg_202_1.time_ = 0
		arg_202_1.frameCnt_ = 0
		arg_202_1.state_ = "playing"
		arg_202_1.curTalkId_ = 1108411049
		arg_202_1.duration_ = 5

		SetActive(arg_202_1.tipsGo_, false)

		function arg_202_1.onSingleLineFinish_()
			arg_202_1.onSingleLineUpdate_ = nil
			arg_202_1.onSingleLineFinish_ = nil
			arg_202_1.state_ = "waiting"
		end

		function arg_202_1.playNext_(arg_204_0)
			if arg_204_0 == 1 then
				arg_202_0:Play1108411050(arg_202_1)
			end
		end

		function arg_202_1.onSingleLineUpdate_(arg_205_0)
			local var_205_0 = 0.2

			if 0 < arg_202_1.time_ and arg_202_1.time_ <= 0 + arg_205_0 then
				arg_202_1.talkMaxDuration = 0
				arg_202_1.dialogCg_.alpha = 1

				arg_202_1.dialog_:SetActive(true)
				SetActive(arg_202_1.leftNameGo_, true)

				arg_202_1.leftNameTxt_.text = arg_202_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_202_1.leftNameTxt_.transform)

				arg_202_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_202_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_202_1:RecordName(arg_202_1.leftNameTxt_.text)
				SetActive(arg_202_1.iconTrs_.gameObject, true)
				arg_202_1.iconController_:SetSelectedState("hero")

				arg_202_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_202_1.callingController_:SetSelectedState("normal")

				arg_202_1.keyicon_.color = Color.New(1, 1, 1)
				arg_202_1.icon_.color = Color.New(1, 1, 1)

				local var_205_1 = arg_202_1:FormatText(arg_202_1:GetWordFromCfg(1108411049).content)

				arg_202_1.text_.text = var_205_1

				LuaForUtil.ClearLinePrefixSymbol(arg_202_1.text_)

				local var_205_3 = 8 <= 0 and var_205_0 or var_205_0 * (utf8.len(var_205_1) / 8)

				if (8 <= 0 and var_205_0 or var_205_0 * (utf8.len(var_205_1) / 8)) > 0 and var_205_0 < var_205_3 then
					arg_202_1.talkMaxDuration = var_205_3

					if var_205_3 + 0 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_3 + 0
					end
				end

				arg_202_1.text_.text = var_205_1
				arg_202_1.typewritter.percent = 0

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(false)
				arg_202_1:RecordContent(arg_202_1.text_.text)
			end

			local var_205_4 = math.max(var_205_0, arg_202_1.talkMaxDuration)

			if 0 <= arg_202_1.time_ and arg_202_1.time_ < 0 + var_205_4 then
				arg_202_1.typewritter.percent = (arg_202_1.time_ - 0) / var_205_4

				arg_202_1.typewritter:SetDirty()
			end

			if arg_202_1.time_ >= 0 + var_205_4 and arg_202_1.time_ < 0 + var_205_4 + arg_205_0 then
				arg_202_1.typewritter.percent = 1

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(true)
			end
		end

		arg_202_1.nodeConfigList_ = {}

		arg_202_1:InitPlayNodeList()
	end,
	Play1108411050 = function(arg_206_0, arg_206_1)
		arg_206_1.time_ = 0
		arg_206_1.frameCnt_ = 0
		arg_206_1.state_ = "playing"
		arg_206_1.curTalkId_ = 1108411050
		arg_206_1.duration_ = 5.7

		local var_206_0 = {
			zh = 3.433,
			ja = 5.7
		}
		local var_206_1 = manager.audio:GetLocalizationFlag()

		if var_206_0[var_206_1] ~= nil then
			arg_206_1.duration_ = var_206_0[var_206_1]
		end

		SetActive(arg_206_1.tipsGo_, false)

		function arg_206_1.onSingleLineFinish_()
			arg_206_1.onSingleLineUpdate_ = nil
			arg_206_1.onSingleLineFinish_ = nil
			arg_206_1.state_ = "waiting"
		end

		function arg_206_1.playNext_(arg_208_0)
			if arg_208_0 == 1 then
				arg_206_0:Play1108411051(arg_206_1)
			end
		end

		function arg_206_1.onSingleLineUpdate_(arg_209_0)
			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 and not isNil(arg_206_1.actors_["10102ui_story"]) and arg_206_1.var_.characterEffect10102ui_story == nil then
				arg_206_1.var_.characterEffect10102ui_story = arg_206_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_209_0 = 0.200000002980232

			if 0 <= arg_206_1.time_ and arg_206_1.time_ < 0 + var_209_0 and not isNil(arg_206_1.actors_["10102ui_story"]) then
				if arg_206_1.var_.characterEffect10102ui_story and not isNil(arg_206_1.actors_["10102ui_story"]) then
					arg_206_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_206_1.time_ >= 0 + var_209_0 and arg_206_1.time_ < 0 + var_209_0 + arg_209_0 and not isNil(arg_206_1.actors_["10102ui_story"]) and arg_206_1.var_.characterEffect10102ui_story then
				arg_206_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 then
				arg_206_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action2_1")
			end

			local var_209_2 = 0
			local var_209_3 = 0.325

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= var_209_2 + arg_209_0 then
				arg_206_1.talkMaxDuration = 0
				arg_206_1.dialogCg_.alpha = 1

				arg_206_1.dialog_:SetActive(true)
				SetActive(arg_206_1.leftNameGo_, true)

				arg_206_1.leftNameTxt_.text = arg_206_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_206_1.leftNameTxt_.transform)

				arg_206_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_206_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_206_1:RecordName(arg_206_1.leftNameTxt_.text)
				SetActive(arg_206_1.iconTrs_.gameObject, false)
				arg_206_1.callingController_:SetSelectedState("normal")

				local var_209_4 = arg_206_1:GetWordFromCfg(1108411050)
				local var_209_5 = arg_206_1:FormatText(var_209_4.content)

				arg_206_1.text_.text = var_209_5

				LuaForUtil.ClearLinePrefixSymbol(arg_206_1.text_)

				local var_209_7 = 13 <= 0 and var_209_3 or var_209_3 * (utf8.len(var_209_5) / 13)

				if (13 <= 0 and var_209_3 or var_209_3 * (utf8.len(var_209_5) / 13)) > 0 and var_209_3 < var_209_7 then
					arg_206_1.talkMaxDuration = var_209_7

					if var_209_7 + var_209_2 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_7 + var_209_2
					end
				end

				arg_206_1.text_.text = var_209_5
				arg_206_1.typewritter.percent = 0

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411050", "story_v_side_new_1108411.awb") ~= 0 then
					local var_209_8 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411050", "story_v_side_new_1108411.awb") / 1000

					if var_209_8 + var_209_2 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_8 + var_209_2
					end

					if var_209_4.prefab_name ~= "" and arg_206_1.actors_[var_209_4.prefab_name] ~= nil then
						local var_209_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_206_1.actors_[var_209_4.prefab_name].transform, "story_v_side_new_1108411", "1108411050", "story_v_side_new_1108411.awb")

						arg_206_1:RecordAudio("1108411050", var_209_9)
						arg_206_1:RecordAudio("1108411050", var_209_9)
					else
						arg_206_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411050", "story_v_side_new_1108411.awb")
					end

					arg_206_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411050", "story_v_side_new_1108411.awb")
				end

				arg_206_1:RecordContent(arg_206_1.text_.text)
			end

			local var_209_10 = math.max(var_209_3, arg_206_1.talkMaxDuration)

			if var_209_2 <= arg_206_1.time_ and arg_206_1.time_ < var_209_2 + var_209_10 then
				arg_206_1.typewritter.percent = (arg_206_1.time_ - var_209_2) / var_209_10

				arg_206_1.typewritter:SetDirty()
			end

			if arg_206_1.time_ >= var_209_2 + var_209_10 and arg_206_1.time_ < var_209_2 + var_209_10 + arg_209_0 then
				arg_206_1.typewritter.percent = 1

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(true)
			end
		end

		arg_206_1.nodeConfigList_ = {}

		arg_206_1:InitPlayNodeList()
	end,
	Play1108411051 = function(arg_210_0, arg_210_1)
		arg_210_1.time_ = 0
		arg_210_1.frameCnt_ = 0
		arg_210_1.state_ = "playing"
		arg_210_1.curTalkId_ = 1108411051
		arg_210_1.duration_ = 5

		SetActive(arg_210_1.tipsGo_, false)

		function arg_210_1.onSingleLineFinish_()
			arg_210_1.onSingleLineUpdate_ = nil
			arg_210_1.onSingleLineFinish_ = nil
			arg_210_1.state_ = "waiting"
		end

		function arg_210_1.playNext_(arg_212_0)
			if arg_212_0 == 1 then
				arg_210_0:Play1108411052(arg_210_1)
			end
		end

		function arg_210_1.onSingleLineUpdate_(arg_213_0)
			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 and not isNil(arg_210_1.actors_["10102ui_story"]) and arg_210_1.var_.characterEffect10102ui_story == nil then
				arg_210_1.var_.characterEffect10102ui_story = arg_210_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_213_0 = 0.200000002980232

			if 0 <= arg_210_1.time_ and arg_210_1.time_ < 0 + var_213_0 and not isNil(arg_210_1.actors_["10102ui_story"]) then
				if arg_210_1.var_.characterEffect10102ui_story and not isNil(arg_210_1.actors_["10102ui_story"]) then
					arg_210_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_210_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_210_1.time_ - 0) / var_213_0)
				end
			end

			if arg_210_1.time_ >= 0 + var_213_0 and arg_210_1.time_ < 0 + var_213_0 + arg_213_0 and not isNil(arg_210_1.actors_["10102ui_story"]) and arg_210_1.var_.characterEffect10102ui_story then
				arg_210_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_210_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_213_1 = 0
			local var_213_2 = 0.45

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= var_213_1 + arg_213_0 then
				arg_210_1.talkMaxDuration = 0
				arg_210_1.dialogCg_.alpha = 1

				arg_210_1.dialog_:SetActive(true)
				SetActive(arg_210_1.leftNameGo_, true)

				arg_210_1.leftNameTxt_.text = arg_210_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_210_1.leftNameTxt_.transform)

				arg_210_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_210_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_210_1:RecordName(arg_210_1.leftNameTxt_.text)
				SetActive(arg_210_1.iconTrs_.gameObject, true)
				arg_210_1.iconController_:SetSelectedState("hero")

				arg_210_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_210_1.callingController_:SetSelectedState("normal")

				arg_210_1.keyicon_.color = Color.New(1, 1, 1)
				arg_210_1.icon_.color = Color.New(1, 1, 1)

				local var_213_3 = arg_210_1:FormatText(arg_210_1:GetWordFromCfg(1108411051).content)

				arg_210_1.text_.text = var_213_3

				LuaForUtil.ClearLinePrefixSymbol(arg_210_1.text_)

				local var_213_5 = 18 <= 0 and var_213_2 or var_213_2 * (utf8.len(var_213_3) / 18)

				if (18 <= 0 and var_213_2 or var_213_2 * (utf8.len(var_213_3) / 18)) > 0 and var_213_2 < var_213_5 then
					arg_210_1.talkMaxDuration = var_213_5

					if var_213_5 + var_213_1 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_5 + var_213_1
					end
				end

				arg_210_1.text_.text = var_213_3
				arg_210_1.typewritter.percent = 0

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(false)
				arg_210_1:RecordContent(arg_210_1.text_.text)
			end

			local var_213_6 = math.max(var_213_2, arg_210_1.talkMaxDuration)

			if var_213_1 <= arg_210_1.time_ and arg_210_1.time_ < var_213_1 + var_213_6 then
				arg_210_1.typewritter.percent = (arg_210_1.time_ - var_213_1) / var_213_6

				arg_210_1.typewritter:SetDirty()
			end

			if arg_210_1.time_ >= var_213_1 + var_213_6 and arg_210_1.time_ < var_213_1 + var_213_6 + arg_213_0 then
				arg_210_1.typewritter.percent = 1

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(true)
			end
		end

		arg_210_1.nodeConfigList_ = {}

		arg_210_1:InitPlayNodeList()
	end,
	Play1108411052 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 1108411052
		arg_214_1.duration_ = 3.77

		local var_214_0 = {
			zh = 2.966,
			ja = 3.766
		}
		local var_214_1 = manager.audio:GetLocalizationFlag()

		if var_214_0[var_214_1] ~= nil then
			arg_214_1.duration_ = var_214_0[var_214_1]
		end

		SetActive(arg_214_1.tipsGo_, false)

		function arg_214_1.onSingleLineFinish_()
			arg_214_1.onSingleLineUpdate_ = nil
			arg_214_1.onSingleLineFinish_ = nil
			arg_214_1.state_ = "waiting"
		end

		function arg_214_1.playNext_(arg_216_0)
			if arg_216_0 == 1 then
				arg_214_0:Play1108411053(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 and not isNil(arg_214_1.actors_["10102ui_story"]) and arg_214_1.var_.characterEffect10102ui_story == nil then
				arg_214_1.var_.characterEffect10102ui_story = arg_214_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_217_0 = 0.200000002980232

			if 0 <= arg_214_1.time_ and arg_214_1.time_ < 0 + var_217_0 and not isNil(arg_214_1.actors_["10102ui_story"]) then
				if arg_214_1.var_.characterEffect10102ui_story and not isNil(arg_214_1.actors_["10102ui_story"]) then
					arg_214_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_214_1.time_ >= 0 + var_217_0 and arg_214_1.time_ < 0 + var_217_0 + arg_217_0 and not isNil(arg_214_1.actors_["10102ui_story"]) and arg_214_1.var_.characterEffect10102ui_story then
				arg_214_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_217_2 = 0
			local var_217_3 = 0.25

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= var_217_2 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0
				arg_214_1.dialogCg_.alpha = 1

				arg_214_1.dialog_:SetActive(true)
				SetActive(arg_214_1.leftNameGo_, true)

				arg_214_1.leftNameTxt_.text = arg_214_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_214_1.leftNameTxt_.transform)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1.leftNameTxt_.text)
				SetActive(arg_214_1.iconTrs_.gameObject, false)
				arg_214_1.callingController_:SetSelectedState("normal")

				local var_217_4 = arg_214_1:GetWordFromCfg(1108411052)
				local var_217_5 = arg_214_1:FormatText(var_217_4.content)

				arg_214_1.text_.text = var_217_5

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_7 = 10 <= 0 and var_217_3 or var_217_3 * (utf8.len(var_217_5) / 10)

				if (10 <= 0 and var_217_3 or var_217_3 * (utf8.len(var_217_5) / 10)) > 0 and var_217_3 < var_217_7 then
					arg_214_1.talkMaxDuration = var_217_7

					if var_217_7 + var_217_2 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_7 + var_217_2
					end
				end

				arg_214_1.text_.text = var_217_5
				arg_214_1.typewritter.percent = 0

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411052", "story_v_side_new_1108411.awb") ~= 0 then
					local var_217_8 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411052", "story_v_side_new_1108411.awb") / 1000

					if var_217_8 + var_217_2 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_8 + var_217_2
					end

					if var_217_4.prefab_name ~= "" and arg_214_1.actors_[var_217_4.prefab_name] ~= nil then
						local var_217_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_214_1.actors_[var_217_4.prefab_name].transform, "story_v_side_new_1108411", "1108411052", "story_v_side_new_1108411.awb")

						arg_214_1:RecordAudio("1108411052", var_217_9)
						arg_214_1:RecordAudio("1108411052", var_217_9)
					else
						arg_214_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411052", "story_v_side_new_1108411.awb")
					end

					arg_214_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411052", "story_v_side_new_1108411.awb")
				end

				arg_214_1:RecordContent(arg_214_1.text_.text)
			end

			local var_217_10 = math.max(var_217_3, arg_214_1.talkMaxDuration)

			if var_217_2 <= arg_214_1.time_ and arg_214_1.time_ < var_217_2 + var_217_10 then
				arg_214_1.typewritter.percent = (arg_214_1.time_ - var_217_2) / var_217_10

				arg_214_1.typewritter:SetDirty()
			end

			if arg_214_1.time_ >= var_217_2 + var_217_10 and arg_214_1.time_ < var_217_2 + var_217_10 + arg_217_0 then
				arg_214_1.typewritter.percent = 1

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(true)
			end
		end

		arg_214_1.nodeConfigList_ = {}

		arg_214_1:InitPlayNodeList()
	end,
	Play1108411053 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 1108411053
		arg_218_1.duration_ = 5

		SetActive(arg_218_1.tipsGo_, false)

		function arg_218_1.onSingleLineFinish_()
			arg_218_1.onSingleLineUpdate_ = nil
			arg_218_1.onSingleLineFinish_ = nil
			arg_218_1.state_ = "waiting"
		end

		function arg_218_1.playNext_(arg_220_0)
			if arg_220_0 == 1 then
				arg_218_0:Play1108411054(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 and not isNil(arg_218_1.actors_["10102ui_story"]) and arg_218_1.var_.characterEffect10102ui_story == nil then
				arg_218_1.var_.characterEffect10102ui_story = arg_218_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_221_0 = 0.200000002980232

			if 0 <= arg_218_1.time_ and arg_218_1.time_ < 0 + var_221_0 and not isNil(arg_218_1.actors_["10102ui_story"]) then
				if arg_218_1.var_.characterEffect10102ui_story and not isNil(arg_218_1.actors_["10102ui_story"]) then
					arg_218_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_218_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_218_1.time_ - 0) / var_221_0)
				end
			end

			if arg_218_1.time_ >= 0 + var_221_0 and arg_218_1.time_ < 0 + var_221_0 + arg_221_0 and not isNil(arg_218_1.actors_["10102ui_story"]) and arg_218_1.var_.characterEffect10102ui_story then
				arg_218_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_218_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_221_1 = 0
			local var_221_2 = 0.275

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= var_221_1 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0
				arg_218_1.dialogCg_.alpha = 1

				arg_218_1.dialog_:SetActive(true)
				SetActive(arg_218_1.leftNameGo_, true)

				arg_218_1.leftNameTxt_.text = arg_218_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_218_1.leftNameTxt_.transform)

				arg_218_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_218_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_218_1:RecordName(arg_218_1.leftNameTxt_.text)
				SetActive(arg_218_1.iconTrs_.gameObject, true)
				arg_218_1.iconController_:SetSelectedState("hero")

				arg_218_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_218_1.callingController_:SetSelectedState("normal")

				arg_218_1.keyicon_.color = Color.New(1, 1, 1)
				arg_218_1.icon_.color = Color.New(1, 1, 1)

				local var_221_3 = arg_218_1:FormatText(arg_218_1:GetWordFromCfg(1108411053).content)

				arg_218_1.text_.text = var_221_3

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_5 = 11 <= 0 and var_221_2 or var_221_2 * (utf8.len(var_221_3) / 11)

				if (11 <= 0 and var_221_2 or var_221_2 * (utf8.len(var_221_3) / 11)) > 0 and var_221_2 < var_221_5 then
					arg_218_1.talkMaxDuration = var_221_5

					if var_221_5 + var_221_1 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_5 + var_221_1
					end
				end

				arg_218_1.text_.text = var_221_3
				arg_218_1.typewritter.percent = 0

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(false)
				arg_218_1:RecordContent(arg_218_1.text_.text)
			end

			local var_221_6 = math.max(var_221_2, arg_218_1.talkMaxDuration)

			if var_221_1 <= arg_218_1.time_ and arg_218_1.time_ < var_221_1 + var_221_6 then
				arg_218_1.typewritter.percent = (arg_218_1.time_ - var_221_1) / var_221_6

				arg_218_1.typewritter:SetDirty()
			end

			if arg_218_1.time_ >= var_221_1 + var_221_6 and arg_218_1.time_ < var_221_1 + var_221_6 + arg_221_0 then
				arg_218_1.typewritter.percent = 1

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(true)
			end
		end

		arg_218_1.nodeConfigList_ = {}

		arg_218_1:InitPlayNodeList()
	end,
	Play1108411054 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 1108411054
		arg_222_1.duration_ = 5.47

		local var_222_0 = {
			zh = 2.933,
			ja = 5.466
		}
		local var_222_1 = manager.audio:GetLocalizationFlag()

		if var_222_0[var_222_1] ~= nil then
			arg_222_1.duration_ = var_222_0[var_222_1]
		end

		SetActive(arg_222_1.tipsGo_, false)

		function arg_222_1.onSingleLineFinish_()
			arg_222_1.onSingleLineUpdate_ = nil
			arg_222_1.onSingleLineFinish_ = nil
			arg_222_1.state_ = "waiting"
		end

		function arg_222_1.playNext_(arg_224_0)
			if arg_224_0 == 1 then
				arg_222_0:Play1108411055(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 and not isNil(arg_222_1.actors_["10102ui_story"]) and arg_222_1.var_.characterEffect10102ui_story == nil then
				arg_222_1.var_.characterEffect10102ui_story = arg_222_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_225_0 = 0.200000002980232

			if 0 <= arg_222_1.time_ and arg_222_1.time_ < 0 + var_225_0 and not isNil(arg_222_1.actors_["10102ui_story"]) then
				if arg_222_1.var_.characterEffect10102ui_story and not isNil(arg_222_1.actors_["10102ui_story"]) then
					arg_222_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_222_1.time_ >= 0 + var_225_0 and arg_222_1.time_ < 0 + var_225_0 + arg_225_0 and not isNil(arg_222_1.actors_["10102ui_story"]) and arg_222_1.var_.characterEffect10102ui_story then
				arg_222_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 then
				arg_222_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action2_2")
			end

			local var_225_2 = 0
			local var_225_3 = 0.35

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= var_225_2 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0
				arg_222_1.dialogCg_.alpha = 1

				arg_222_1.dialog_:SetActive(true)
				SetActive(arg_222_1.leftNameGo_, true)

				arg_222_1.leftNameTxt_.text = arg_222_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_222_1.leftNameTxt_.transform)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1.leftNameTxt_.text)
				SetActive(arg_222_1.iconTrs_.gameObject, false)
				arg_222_1.callingController_:SetSelectedState("normal")

				local var_225_4 = arg_222_1:GetWordFromCfg(1108411054)
				local var_225_5 = arg_222_1:FormatText(var_225_4.content)

				arg_222_1.text_.text = var_225_5

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_7 = 14 <= 0 and var_225_3 or var_225_3 * (utf8.len(var_225_5) / 14)

				if (14 <= 0 and var_225_3 or var_225_3 * (utf8.len(var_225_5) / 14)) > 0 and var_225_3 < var_225_7 then
					arg_222_1.talkMaxDuration = var_225_7

					if var_225_7 + var_225_2 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_7 + var_225_2
					end
				end

				arg_222_1.text_.text = var_225_5
				arg_222_1.typewritter.percent = 0

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411054", "story_v_side_new_1108411.awb") ~= 0 then
					local var_225_8 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411054", "story_v_side_new_1108411.awb") / 1000

					if var_225_8 + var_225_2 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_8 + var_225_2
					end

					if var_225_4.prefab_name ~= "" and arg_222_1.actors_[var_225_4.prefab_name] ~= nil then
						local var_225_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_222_1.actors_[var_225_4.prefab_name].transform, "story_v_side_new_1108411", "1108411054", "story_v_side_new_1108411.awb")

						arg_222_1:RecordAudio("1108411054", var_225_9)
						arg_222_1:RecordAudio("1108411054", var_225_9)
					else
						arg_222_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411054", "story_v_side_new_1108411.awb")
					end

					arg_222_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411054", "story_v_side_new_1108411.awb")
				end

				arg_222_1:RecordContent(arg_222_1.text_.text)
			end

			local var_225_10 = math.max(var_225_3, arg_222_1.talkMaxDuration)

			if var_225_2 <= arg_222_1.time_ and arg_222_1.time_ < var_225_2 + var_225_10 then
				arg_222_1.typewritter.percent = (arg_222_1.time_ - var_225_2) / var_225_10

				arg_222_1.typewritter:SetDirty()
			end

			if arg_222_1.time_ >= var_225_2 + var_225_10 and arg_222_1.time_ < var_225_2 + var_225_10 + arg_225_0 then
				arg_222_1.typewritter.percent = 1

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(true)
			end
		end

		arg_222_1.nodeConfigList_ = {}

		arg_222_1:InitPlayNodeList()
	end,
	Play1108411055 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 1108411055
		arg_226_1.duration_ = 5

		SetActive(arg_226_1.tipsGo_, false)

		function arg_226_1.onSingleLineFinish_()
			arg_226_1.onSingleLineUpdate_ = nil
			arg_226_1.onSingleLineFinish_ = nil
			arg_226_1.state_ = "waiting"
		end

		function arg_226_1.playNext_(arg_228_0)
			if arg_228_0 == 1 then
				arg_226_0:Play1108411056(arg_226_1)
			end
		end

		function arg_226_1.onSingleLineUpdate_(arg_229_0)
			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 and not isNil(arg_226_1.actors_["10102ui_story"]) and arg_226_1.var_.characterEffect10102ui_story == nil then
				arg_226_1.var_.characterEffect10102ui_story = arg_226_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_229_0 = 0.200000002980232

			if 0 <= arg_226_1.time_ and arg_226_1.time_ < 0 + var_229_0 and not isNil(arg_226_1.actors_["10102ui_story"]) then
				if arg_226_1.var_.characterEffect10102ui_story and not isNil(arg_226_1.actors_["10102ui_story"]) then
					arg_226_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_226_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_226_1.time_ - 0) / var_229_0)
				end
			end

			if arg_226_1.time_ >= 0 + var_229_0 and arg_226_1.time_ < 0 + var_229_0 + arg_229_0 and not isNil(arg_226_1.actors_["10102ui_story"]) and arg_226_1.var_.characterEffect10102ui_story then
				arg_226_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_226_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_229_1 = 0
			local var_229_2 = 0.425

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= var_229_1 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0
				arg_226_1.dialogCg_.alpha = 1

				arg_226_1.dialog_:SetActive(true)
				SetActive(arg_226_1.leftNameGo_, true)

				arg_226_1.leftNameTxt_.text = arg_226_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_226_1.leftNameTxt_.transform)

				arg_226_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_226_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_226_1:RecordName(arg_226_1.leftNameTxt_.text)
				SetActive(arg_226_1.iconTrs_.gameObject, true)
				arg_226_1.iconController_:SetSelectedState("hero")

				arg_226_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_226_1.callingController_:SetSelectedState("normal")

				arg_226_1.keyicon_.color = Color.New(1, 1, 1)
				arg_226_1.icon_.color = Color.New(1, 1, 1)

				local var_229_3 = arg_226_1:FormatText(arg_226_1:GetWordFromCfg(1108411055).content)

				arg_226_1.text_.text = var_229_3

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_5 = 17 <= 0 and var_229_2 or var_229_2 * (utf8.len(var_229_3) / 17)

				if (17 <= 0 and var_229_2 or var_229_2 * (utf8.len(var_229_3) / 17)) > 0 and var_229_2 < var_229_5 then
					arg_226_1.talkMaxDuration = var_229_5

					if var_229_5 + var_229_1 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_5 + var_229_1
					end
				end

				arg_226_1.text_.text = var_229_3
				arg_226_1.typewritter.percent = 0

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(false)
				arg_226_1:RecordContent(arg_226_1.text_.text)
			end

			local var_229_6 = math.max(var_229_2, arg_226_1.talkMaxDuration)

			if var_229_1 <= arg_226_1.time_ and arg_226_1.time_ < var_229_1 + var_229_6 then
				arg_226_1.typewritter.percent = (arg_226_1.time_ - var_229_1) / var_229_6

				arg_226_1.typewritter:SetDirty()
			end

			if arg_226_1.time_ >= var_229_1 + var_229_6 and arg_226_1.time_ < var_229_1 + var_229_6 + arg_229_0 then
				arg_226_1.typewritter.percent = 1

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(true)
			end
		end

		arg_226_1.nodeConfigList_ = {}

		arg_226_1:InitPlayNodeList()
	end,
	Play1108411056 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 1108411056
		arg_230_1.duration_ = 5

		SetActive(arg_230_1.tipsGo_, false)

		function arg_230_1.onSingleLineFinish_()
			arg_230_1.onSingleLineUpdate_ = nil
			arg_230_1.onSingleLineFinish_ = nil
			arg_230_1.state_ = "waiting"
		end

		function arg_230_1.playNext_(arg_232_0)
			if arg_232_0 == 1 then
				arg_230_0:Play1108411057(arg_230_1)
			end
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			local var_233_0 = 0.3

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0
				arg_230_1.dialogCg_.alpha = 1

				arg_230_1.dialog_:SetActive(true)
				SetActive(arg_230_1.leftNameGo_, true)

				arg_230_1.leftNameTxt_.text = arg_230_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_230_1.leftNameTxt_.transform)

				arg_230_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_230_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_230_1:RecordName(arg_230_1.leftNameTxt_.text)
				SetActive(arg_230_1.iconTrs_.gameObject, true)
				arg_230_1.iconController_:SetSelectedState("hero")

				arg_230_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_230_1.callingController_:SetSelectedState("normal")

				arg_230_1.keyicon_.color = Color.New(1, 1, 1)
				arg_230_1.icon_.color = Color.New(1, 1, 1)

				local var_233_1 = arg_230_1:FormatText(arg_230_1:GetWordFromCfg(1108411056).content)

				arg_230_1.text_.text = var_233_1

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_3 = 12 <= 0 and var_233_0 or var_233_0 * (utf8.len(var_233_1) / 12)

				if (12 <= 0 and var_233_0 or var_233_0 * (utf8.len(var_233_1) / 12)) > 0 and var_233_0 < var_233_3 then
					arg_230_1.talkMaxDuration = var_233_3

					if var_233_3 + 0 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_3 + 0
					end
				end

				arg_230_1.text_.text = var_233_1
				arg_230_1.typewritter.percent = 0

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(false)
				arg_230_1:RecordContent(arg_230_1.text_.text)
			end

			local var_233_4 = math.max(var_233_0, arg_230_1.talkMaxDuration)

			if 0 <= arg_230_1.time_ and arg_230_1.time_ < 0 + var_233_4 then
				arg_230_1.typewritter.percent = (arg_230_1.time_ - 0) / var_233_4

				arg_230_1.typewritter:SetDirty()
			end

			if arg_230_1.time_ >= 0 + var_233_4 and arg_230_1.time_ < 0 + var_233_4 + arg_233_0 then
				arg_230_1.typewritter.percent = 1

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(true)
			end
		end

		arg_230_1.nodeConfigList_ = {}

		arg_230_1:InitPlayNodeList()
	end,
	Play1108411057 = function(arg_234_0, arg_234_1)
		arg_234_1.time_ = 0
		arg_234_1.frameCnt_ = 0
		arg_234_1.state_ = "playing"
		arg_234_1.curTalkId_ = 1108411057
		arg_234_1.duration_ = 5.1

		local var_234_0 = {
			zh = 4.233,
			ja = 5.1
		}
		local var_234_1 = manager.audio:GetLocalizationFlag()

		if var_234_0[var_234_1] ~= nil then
			arg_234_1.duration_ = var_234_0[var_234_1]
		end

		SetActive(arg_234_1.tipsGo_, false)

		function arg_234_1.onSingleLineFinish_()
			arg_234_1.onSingleLineUpdate_ = nil
			arg_234_1.onSingleLineFinish_ = nil
			arg_234_1.state_ = "waiting"
		end

		function arg_234_1.playNext_(arg_236_0)
			if arg_236_0 == 1 then
				arg_234_0:Play1108411058(arg_234_1)
			end
		end

		function arg_234_1.onSingleLineUpdate_(arg_237_0)
			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 and not isNil(arg_234_1.actors_["10102ui_story"]) and arg_234_1.var_.characterEffect10102ui_story == nil then
				arg_234_1.var_.characterEffect10102ui_story = arg_234_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_237_0 = 0.200000002980232

			if 0 <= arg_234_1.time_ and arg_234_1.time_ < 0 + var_237_0 and not isNil(arg_234_1.actors_["10102ui_story"]) then
				if arg_234_1.var_.characterEffect10102ui_story and not isNil(arg_234_1.actors_["10102ui_story"]) then
					arg_234_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_234_1.time_ >= 0 + var_237_0 and arg_234_1.time_ < 0 + var_237_0 + arg_237_0 and not isNil(arg_234_1.actors_["10102ui_story"]) and arg_234_1.var_.characterEffect10102ui_story then
				arg_234_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 then
				arg_234_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action6_1")
			end

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 then
				arg_234_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_237_2 = 0
			local var_237_3 = 0.45

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= var_237_2 + arg_237_0 then
				arg_234_1.talkMaxDuration = 0
				arg_234_1.dialogCg_.alpha = 1

				arg_234_1.dialog_:SetActive(true)
				SetActive(arg_234_1.leftNameGo_, true)

				arg_234_1.leftNameTxt_.text = arg_234_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_234_1.leftNameTxt_.transform)

				arg_234_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_234_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_234_1:RecordName(arg_234_1.leftNameTxt_.text)
				SetActive(arg_234_1.iconTrs_.gameObject, false)
				arg_234_1.callingController_:SetSelectedState("normal")

				local var_237_4 = arg_234_1:GetWordFromCfg(1108411057)
				local var_237_5 = arg_234_1:FormatText(var_237_4.content)

				arg_234_1.text_.text = var_237_5

				LuaForUtil.ClearLinePrefixSymbol(arg_234_1.text_)

				local var_237_7 = 18 <= 0 and var_237_3 or var_237_3 * (utf8.len(var_237_5) / 18)

				if (18 <= 0 and var_237_3 or var_237_3 * (utf8.len(var_237_5) / 18)) > 0 and var_237_3 < var_237_7 then
					arg_234_1.talkMaxDuration = var_237_7

					if var_237_7 + var_237_2 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_7 + var_237_2
					end
				end

				arg_234_1.text_.text = var_237_5
				arg_234_1.typewritter.percent = 0

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411057", "story_v_side_new_1108411.awb") ~= 0 then
					local var_237_8 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411057", "story_v_side_new_1108411.awb") / 1000

					if var_237_8 + var_237_2 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_8 + var_237_2
					end

					if var_237_4.prefab_name ~= "" and arg_234_1.actors_[var_237_4.prefab_name] ~= nil then
						local var_237_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_234_1.actors_[var_237_4.prefab_name].transform, "story_v_side_new_1108411", "1108411057", "story_v_side_new_1108411.awb")

						arg_234_1:RecordAudio("1108411057", var_237_9)
						arg_234_1:RecordAudio("1108411057", var_237_9)
					else
						arg_234_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411057", "story_v_side_new_1108411.awb")
					end

					arg_234_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411057", "story_v_side_new_1108411.awb")
				end

				arg_234_1:RecordContent(arg_234_1.text_.text)
			end

			local var_237_10 = math.max(var_237_3, arg_234_1.talkMaxDuration)

			if var_237_2 <= arg_234_1.time_ and arg_234_1.time_ < var_237_2 + var_237_10 then
				arg_234_1.typewritter.percent = (arg_234_1.time_ - var_237_2) / var_237_10

				arg_234_1.typewritter:SetDirty()
			end

			if arg_234_1.time_ >= var_237_2 + var_237_10 and arg_234_1.time_ < var_237_2 + var_237_10 + arg_237_0 then
				arg_234_1.typewritter.percent = 1

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(true)
			end
		end

		arg_234_1.nodeConfigList_ = {}

		arg_234_1:InitPlayNodeList()
	end,
	Play1108411058 = function(arg_238_0, arg_238_1)
		arg_238_1.time_ = 0
		arg_238_1.frameCnt_ = 0
		arg_238_1.state_ = "playing"
		arg_238_1.curTalkId_ = 1108411058
		arg_238_1.duration_ = 5

		SetActive(arg_238_1.tipsGo_, false)

		function arg_238_1.onSingleLineFinish_()
			arg_238_1.onSingleLineUpdate_ = nil
			arg_238_1.onSingleLineFinish_ = nil
			arg_238_1.state_ = "waiting"
		end

		function arg_238_1.playNext_(arg_240_0)
			if arg_240_0 == 1 then
				arg_238_0:Play1108411059(arg_238_1)
			end
		end

		function arg_238_1.onSingleLineUpdate_(arg_241_0)
			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 and not isNil(arg_238_1.actors_["10102ui_story"]) and arg_238_1.var_.characterEffect10102ui_story == nil then
				arg_238_1.var_.characterEffect10102ui_story = arg_238_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_241_0 = 0.200000002980232

			if 0 <= arg_238_1.time_ and arg_238_1.time_ < 0 + var_241_0 and not isNil(arg_238_1.actors_["10102ui_story"]) then
				if arg_238_1.var_.characterEffect10102ui_story and not isNil(arg_238_1.actors_["10102ui_story"]) then
					arg_238_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_238_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_238_1.time_ - 0) / var_241_0)
				end
			end

			if arg_238_1.time_ >= 0 + var_241_0 and arg_238_1.time_ < 0 + var_241_0 + arg_241_0 and not isNil(arg_238_1.actors_["10102ui_story"]) and arg_238_1.var_.characterEffect10102ui_story then
				arg_238_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_238_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_241_1 = 0
			local var_241_2 = 0.5

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= var_241_1 + arg_241_0 then
				arg_238_1.talkMaxDuration = 0
				arg_238_1.dialogCg_.alpha = 1

				arg_238_1.dialog_:SetActive(true)
				SetActive(arg_238_1.leftNameGo_, true)

				arg_238_1.leftNameTxt_.text = arg_238_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_238_1.leftNameTxt_.transform)

				arg_238_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_238_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_238_1:RecordName(arg_238_1.leftNameTxt_.text)
				SetActive(arg_238_1.iconTrs_.gameObject, true)
				arg_238_1.iconController_:SetSelectedState("hero")

				arg_238_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_238_1.callingController_:SetSelectedState("normal")

				arg_238_1.keyicon_.color = Color.New(1, 1, 1)
				arg_238_1.icon_.color = Color.New(1, 1, 1)

				local var_241_3 = arg_238_1:FormatText(arg_238_1:GetWordFromCfg(1108411058).content)

				arg_238_1.text_.text = var_241_3

				LuaForUtil.ClearLinePrefixSymbol(arg_238_1.text_)

				local var_241_5 = 20 <= 0 and var_241_2 or var_241_2 * (utf8.len(var_241_3) / 20)

				if (20 <= 0 and var_241_2 or var_241_2 * (utf8.len(var_241_3) / 20)) > 0 and var_241_2 < var_241_5 then
					arg_238_1.talkMaxDuration = var_241_5

					if var_241_5 + var_241_1 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_5 + var_241_1
					end
				end

				arg_238_1.text_.text = var_241_3
				arg_238_1.typewritter.percent = 0

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(false)
				arg_238_1:RecordContent(arg_238_1.text_.text)
			end

			local var_241_6 = math.max(var_241_2, arg_238_1.talkMaxDuration)

			if var_241_1 <= arg_238_1.time_ and arg_238_1.time_ < var_241_1 + var_241_6 then
				arg_238_1.typewritter.percent = (arg_238_1.time_ - var_241_1) / var_241_6

				arg_238_1.typewritter:SetDirty()
			end

			if arg_238_1.time_ >= var_241_1 + var_241_6 and arg_238_1.time_ < var_241_1 + var_241_6 + arg_241_0 then
				arg_238_1.typewritter.percent = 1

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(true)
			end
		end

		arg_238_1.nodeConfigList_ = {}

		arg_238_1:InitPlayNodeList()
	end,
	Play1108411059 = function(arg_242_0, arg_242_1)
		arg_242_1.time_ = 0
		arg_242_1.frameCnt_ = 0
		arg_242_1.state_ = "playing"
		arg_242_1.curTalkId_ = 1108411059
		arg_242_1.duration_ = 9.7

		local var_242_0 = {
			zh = 8.866,
			ja = 9.7
		}
		local var_242_1 = manager.audio:GetLocalizationFlag()

		if var_242_0[var_242_1] ~= nil then
			arg_242_1.duration_ = var_242_0[var_242_1]
		end

		SetActive(arg_242_1.tipsGo_, false)

		function arg_242_1.onSingleLineFinish_()
			arg_242_1.onSingleLineUpdate_ = nil
			arg_242_1.onSingleLineFinish_ = nil
			arg_242_1.state_ = "waiting"
		end

		function arg_242_1.playNext_(arg_244_0)
			if arg_244_0 == 1 then
				arg_242_0:Play1108411060(arg_242_1)
			end
		end

		function arg_242_1.onSingleLineUpdate_(arg_245_0)
			if arg_242_1.bgs_.ST02 == nil then
				local var_245_0 = Object.Instantiate(arg_242_1.paintGo_)

				var_245_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST02")
				var_245_0.name = "ST02"
				var_245_0.transform.parent = arg_242_1.stage_.transform
				var_245_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_242_1.bgs_.ST02 = var_245_0
			end

			if 2 < arg_242_1.time_ and arg_242_1.time_ <= 2 + arg_245_0 then
				local var_245_1 = arg_242_1.bgs_.ST02

				arg_242_1.bgs_.ST02.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_245_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_245_2 = var_245_1:GetComponent("SpriteRenderer")

				if var_245_2 and var_245_2.sprite then
					local var_245_3 = 2 * (var_245_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_245_1.transform.localScale = Vector3.New(var_245_3 / var_245_2.sprite.bounds.size.y < var_245_3 * manager.ui.mainCameraCom_.aspect / var_245_2.sprite.bounds.size.x and var_245_3 * manager.ui.mainCameraCom_.aspect / var_245_2.sprite.bounds.size.x or var_245_3 / var_245_2.sprite.bounds.size.y, var_245_3 / var_245_2.sprite.bounds.size.y < var_245_3 * manager.ui.mainCameraCom_.aspect / var_245_2.sprite.bounds.size.x and var_245_3 * manager.ui.mainCameraCom_.aspect / var_245_2.sprite.bounds.size.x or var_245_3 / var_245_2.sprite.bounds.size.y, 0)
				end

				for iter_245_0, iter_245_1 in pairs(arg_242_1.bgs_) do
					if iter_245_0 ~= "ST02" then
						iter_245_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_245_4 = 0

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= var_245_4 + arg_245_0 then
				arg_242_1.allBtn_.enabled = false
			end

			if arg_242_1.time_ >= var_245_4 + 0.3 and arg_242_1.time_ < var_245_4 + 0.3 + arg_245_0 then
				arg_242_1.allBtn_.enabled = true
			end

			local var_245_5 = 0

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= var_245_5 + arg_245_0 then
				arg_242_1.mask_.enabled = true
				arg_242_1.mask_.raycastTarget = true

				arg_242_1:SetGaussion(false)
			end

			local var_245_6 = 2

			if var_245_5 <= arg_242_1.time_ and arg_242_1.time_ < var_245_5 + var_245_6 then
				local var_245_7 = Color.New(0, 0, 0)

				var_245_7.a = Mathf.Lerp(0, 1, (arg_242_1.time_ - var_245_5) / var_245_6)
				arg_242_1.mask_.color = var_245_7
			end

			if arg_242_1.time_ >= var_245_5 + var_245_6 and arg_242_1.time_ < var_245_5 + var_245_6 + arg_245_0 then
				local var_245_8 = Color.New(0, 0, 0)

				var_245_8.a = 1
				arg_242_1.mask_.color = var_245_8
			end

			local var_245_9 = 2

			if 2 < arg_242_1.time_ and arg_242_1.time_ <= var_245_9 + arg_245_0 then
				arg_242_1.mask_.enabled = true
				arg_242_1.mask_.raycastTarget = true

				arg_242_1:SetGaussion(false)
			end

			local var_245_10 = 2

			if var_245_9 <= arg_242_1.time_ and arg_242_1.time_ < var_245_9 + var_245_10 then
				local var_245_11 = Color.New(0, 0, 0)

				var_245_11.a = Mathf.Lerp(1, 0, (arg_242_1.time_ - var_245_9) / var_245_10)
				arg_242_1.mask_.color = var_245_11
			end

			if arg_242_1.time_ >= var_245_9 + var_245_10 and arg_242_1.time_ < var_245_9 + var_245_10 + arg_245_0 then
				local var_245_12 = Color.New(0, 0, 0)

				arg_242_1.mask_.enabled = false
				var_245_12.a = 0
				arg_242_1.mask_.color = var_245_12
			end

			local var_245_13 = arg_242_1.actors_["10102ui_story"].transform

			if 1.98333333333333 < arg_242_1.time_ and arg_242_1.time_ <= 1.98333333333333 + arg_245_0 then
				arg_242_1.var_.moveOldPos10102ui_story = var_245_13.localPosition
			end

			local var_245_14 = 0.001

			if 1.98333333333333 <= arg_242_1.time_ and arg_242_1.time_ < 1.98333333333333 + var_245_14 then
				var_245_13.localPosition = Vector3.Lerp(arg_242_1.var_.moveOldPos10102ui_story, Vector3.New(0, 100, 0), (arg_242_1.time_ - 1.98333333333333) / var_245_14)
				var_245_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_245_13.position).x, (manager.ui.mainCamera.transform.position - var_245_13.position).y, (manager.ui.mainCamera.transform.position - var_245_13.position).z)
				var_245_13.localEulerAngles.z = 0
				var_245_13.localEulerAngles.x = 0
				var_245_13.localEulerAngles = var_245_13.localEulerAngles
			end

			if arg_242_1.time_ >= 1.98333333333333 + var_245_14 and arg_242_1.time_ < 1.98333333333333 + var_245_14 + arg_245_0 then
				var_245_13.localPosition = Vector3.New(0, 100, 0)
				var_245_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_245_13.position).x, (manager.ui.mainCamera.transform.position - var_245_13.position).y, (manager.ui.mainCamera.transform.position - var_245_13.position).z)
				var_245_13.localEulerAngles.z = 0
				var_245_13.localEulerAngles.x = 0
				var_245_13.localEulerAngles = var_245_13.localEulerAngles
			end

			if 0.166666666666667 < arg_242_1.time_ and arg_242_1.time_ <= 0.166666666666667 + arg_245_0 then
				arg_242_1:AudioAction("stop", "effect", "se_story_birthday4", "se_story_birthday4_amb_room_tone_1", "")
			end

			if 1.63333333333333 < arg_242_1.time_ and arg_242_1.time_ <= 1.63333333333333 + arg_245_0 then
				arg_242_1:AudioAction("play", "effect", "se_story_side_1068", "se_story_1068_restaurant", "")
			end

			if 0.166666666666667 < arg_242_1.time_ and arg_242_1.time_ <= 0.166666666666667 + arg_245_0 then
				arg_242_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_245_19 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_242_1.bgmTxt_.text ~= var_245_19 and arg_242_1.bgmTxt_.text ~= "" then
						if arg_242_1.bgmTxt2_.text ~= "" then
							arg_242_1.bgmTxt_.text = arg_242_1.bgmTxt2_.text
						end

						arg_242_1.bgmTxt2_.text = var_245_19

						arg_242_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_242_1.bgmTxt_.text = var_245_19
						arg_242_1.bgmTxt2_.text = var_245_19
					end

					if arg_242_1.bgmTimer then
						arg_242_1.bgmTimer:Stop()

						arg_242_1.bgmTimer = nil
					end

					if arg_242_1.settingData.show_music_name == 1 then
						arg_242_1.musicController:SetSelectedState("show")
						arg_242_1.musicAnimator_:Play("open", 0, 0)

						if arg_242_1.settingData.music_time ~= 0 then
							arg_242_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_242_1.settingData.music_time), function()
								if arg_242_1 == nil or isNil(arg_242_1.bgmTxt_) then
									return
								end

								arg_242_1.musicController:SetSelectedState("hide")
								arg_242_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 1.63333333333333 < arg_242_1.time_ and arg_242_1.time_ <= 1.63333333333333 + arg_245_0 then
				arg_242_1:AudioAction("play", "music", "bgm_side_daily02", "bgm_side_daily02", "bgm_side_daily02.awb")

				local var_245_22 = manager.audio:GetAudioName("bgm_side_daily02", "bgm_side_daily02")

				if "" ~= "" then
					if arg_242_1.bgmTxt_.text ~= var_245_22 and arg_242_1.bgmTxt_.text ~= "" then
						if arg_242_1.bgmTxt2_.text ~= "" then
							arg_242_1.bgmTxt_.text = arg_242_1.bgmTxt2_.text
						end

						arg_242_1.bgmTxt2_.text = var_245_22

						arg_242_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_242_1.bgmTxt_.text = var_245_22
						arg_242_1.bgmTxt2_.text = var_245_22
					end

					if arg_242_1.bgmTimer then
						arg_242_1.bgmTimer:Stop()

						arg_242_1.bgmTimer = nil
					end

					if arg_242_1.settingData.show_music_name == 1 then
						arg_242_1.musicController:SetSelectedState("show")
						arg_242_1.musicAnimator_:Play("open", 0, 0)

						if arg_242_1.settingData.music_time ~= 0 then
							arg_242_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_242_1.settingData.music_time), function()
								if arg_242_1 == nil or isNil(arg_242_1.bgmTxt_) then
									return
								end

								arg_242_1.musicController:SetSelectedState("hide")
								arg_242_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_242_1.frameCnt_ <= 1 then
				arg_242_1.dialog_:SetActive(false)
			end

			local var_245_23 = 4
			local var_245_24 = 0.375

			if 4 < arg_242_1.time_ and arg_242_1.time_ <= var_245_23 + arg_245_0 then
				arg_242_1.talkMaxDuration = 0

				arg_242_1.dialog_:SetActive(true)

				arg_242_1.dialogCg_.alpha = 0

				local var_245_25 = LeanTween.value(arg_242_1.dialog_, 0, 1, 0.3)

				var_245_25:setOnUpdate(LuaHelper.FloatAction(function(arg_248_0)
					arg_242_1.dialogCg_.alpha = arg_248_0
				end))
				var_245_25:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_242_1.dialog_)
					var_245_25:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_242_1.duration_ = arg_242_1.duration_ + 0.3

				SetActive(arg_242_1.leftNameGo_, true)

				arg_242_1.leftNameTxt_.text = arg_242_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_242_1.leftNameTxt_.transform)

				arg_242_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_242_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_242_1:RecordName(arg_242_1.leftNameTxt_.text)
				SetActive(arg_242_1.iconTrs_.gameObject, true)
				arg_242_1.iconController_:SetSelectedState("hero")

				arg_242_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10102_split_4")

				arg_242_1.callingController_:SetSelectedState("normal")

				arg_242_1.keyicon_.color = Color.New(1, 1, 1)
				arg_242_1.icon_.color = Color.New(1, 1, 1)

				local var_245_26 = arg_242_1:GetWordFromCfg(1108411059)
				local var_245_27 = arg_242_1:FormatText(var_245_26.content)

				arg_242_1.text_.text = var_245_27

				LuaForUtil.ClearLinePrefixSymbol(arg_242_1.text_)

				local var_245_29 = 15 <= 0 and var_245_24 or var_245_24 * (utf8.len(var_245_27) / 15)

				if (15 <= 0 and var_245_24 or var_245_24 * (utf8.len(var_245_27) / 15)) > 0 and var_245_24 < var_245_29 then
					arg_242_1.talkMaxDuration = var_245_29
					var_245_23 = var_245_23 + 0.3

					if var_245_29 + var_245_23 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_29 + var_245_23
					end
				end

				arg_242_1.text_.text = var_245_27
				arg_242_1.typewritter.percent = 0

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411059", "story_v_side_new_1108411.awb") ~= 0 then
					local var_245_30 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411059", "story_v_side_new_1108411.awb") / 1000

					if var_245_30 + var_245_23 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_30 + var_245_23
					end

					if var_245_26.prefab_name ~= "" and arg_242_1.actors_[var_245_26.prefab_name] ~= nil then
						local var_245_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_242_1.actors_[var_245_26.prefab_name].transform, "story_v_side_new_1108411", "1108411059", "story_v_side_new_1108411.awb")

						arg_242_1:RecordAudio("1108411059", var_245_31)
						arg_242_1:RecordAudio("1108411059", var_245_31)
					else
						arg_242_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411059", "story_v_side_new_1108411.awb")
					end

					arg_242_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411059", "story_v_side_new_1108411.awb")
				end

				arg_242_1:RecordContent(arg_242_1.text_.text)
			end

			local var_245_32 = var_245_23 + 0.3
			local var_245_33 = math.max(var_245_24, arg_242_1.talkMaxDuration)

			if var_245_23 + 0.3 <= arg_242_1.time_ and arg_242_1.time_ < var_245_32 + var_245_33 then
				arg_242_1.typewritter.percent = (arg_242_1.time_ - var_245_32) / var_245_33

				arg_242_1.typewritter:SetDirty()
			end

			if arg_242_1.time_ >= var_245_32 + var_245_33 and arg_242_1.time_ < var_245_32 + var_245_33 + arg_245_0 then
				arg_242_1.typewritter.percent = 1

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(true)
			end
		end

		arg_242_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666666,
				className = "StoryMoveNode",
				startTime = 1.98333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_242_1:InitPlayNodeList()
	end,
	Play1108411060 = function(arg_250_0, arg_250_1)
		arg_250_1.time_ = 0
		arg_250_1.frameCnt_ = 0
		arg_250_1.state_ = "playing"
		arg_250_1.curTalkId_ = 1108411060
		arg_250_1.duration_ = 5

		SetActive(arg_250_1.tipsGo_, false)

		function arg_250_1.onSingleLineFinish_()
			arg_250_1.onSingleLineUpdate_ = nil
			arg_250_1.onSingleLineFinish_ = nil
			arg_250_1.state_ = "waiting"
		end

		function arg_250_1.playNext_(arg_252_0)
			if arg_252_0 == 1 then
				arg_250_0:Play1108411061(arg_250_1)
			end
		end

		function arg_250_1.onSingleLineUpdate_(arg_253_0)
			if 0 < arg_250_1.time_ and arg_250_1.time_ <= 0 + arg_253_0 and not isNil(arg_250_1.actors_["10102ui_story"]) and arg_250_1.var_.characterEffect10102ui_story == nil then
				arg_250_1.var_.characterEffect10102ui_story = arg_250_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_253_0 = 0.200000002980232

			if 0 <= arg_250_1.time_ and arg_250_1.time_ < 0 + var_253_0 and not isNil(arg_250_1.actors_["10102ui_story"]) then
				if arg_250_1.var_.characterEffect10102ui_story and not isNil(arg_250_1.actors_["10102ui_story"]) then
					arg_250_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_250_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_250_1.time_ - 0) / var_253_0)
				end
			end

			if arg_250_1.time_ >= 0 + var_253_0 and arg_250_1.time_ < 0 + var_253_0 + arg_253_0 and not isNil(arg_250_1.actors_["10102ui_story"]) and arg_250_1.var_.characterEffect10102ui_story then
				arg_250_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_250_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_253_1 = 0
			local var_253_2 = 1.175

			if 0 < arg_250_1.time_ and arg_250_1.time_ <= var_253_1 + arg_253_0 then
				arg_250_1.talkMaxDuration = 0
				arg_250_1.dialogCg_.alpha = 1

				arg_250_1.dialog_:SetActive(true)
				SetActive(arg_250_1.leftNameGo_, false)

				arg_250_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_250_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_250_1:RecordName(arg_250_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_250_1.iconTrs_.gameObject, false)
				arg_250_1.callingController_:SetSelectedState("normal")

				local var_253_3 = arg_250_1:FormatText(arg_250_1:GetWordFromCfg(1108411060).content)

				arg_250_1.text_.text = var_253_3

				LuaForUtil.ClearLinePrefixSymbol(arg_250_1.text_)

				local var_253_5 = 47 <= 0 and var_253_2 or var_253_2 * (utf8.len(var_253_3) / 47)

				if (47 <= 0 and var_253_2 or var_253_2 * (utf8.len(var_253_3) / 47)) > 0 and var_253_2 < var_253_5 then
					arg_250_1.talkMaxDuration = var_253_5

					if var_253_5 + var_253_1 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_5 + var_253_1
					end
				end

				arg_250_1.text_.text = var_253_3
				arg_250_1.typewritter.percent = 0

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(false)
				arg_250_1:RecordContent(arg_250_1.text_.text)
			end

			local var_253_6 = math.max(var_253_2, arg_250_1.talkMaxDuration)

			if var_253_1 <= arg_250_1.time_ and arg_250_1.time_ < var_253_1 + var_253_6 then
				arg_250_1.typewritter.percent = (arg_250_1.time_ - var_253_1) / var_253_6

				arg_250_1.typewritter:SetDirty()
			end

			if arg_250_1.time_ >= var_253_1 + var_253_6 and arg_250_1.time_ < var_253_1 + var_253_6 + arg_253_0 then
				arg_250_1.typewritter.percent = 1

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(true)
			end
		end

		arg_250_1.nodeConfigList_ = {}

		arg_250_1:InitPlayNodeList()
	end,
	Play1108411061 = function(arg_254_0, arg_254_1)
		arg_254_1.time_ = 0
		arg_254_1.frameCnt_ = 0
		arg_254_1.state_ = "playing"
		arg_254_1.curTalkId_ = 1108411061
		arg_254_1.duration_ = 5

		SetActive(arg_254_1.tipsGo_, false)

		function arg_254_1.onSingleLineFinish_()
			arg_254_1.onSingleLineUpdate_ = nil
			arg_254_1.onSingleLineFinish_ = nil
			arg_254_1.state_ = "waiting"
		end

		function arg_254_1.playNext_(arg_256_0)
			if arg_256_0 == 1 then
				arg_254_0:Play1108411062(arg_254_1)
			end
		end

		function arg_254_1.onSingleLineUpdate_(arg_257_0)
			local var_257_0 = 0.4

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= 0 + arg_257_0 then
				arg_254_1.talkMaxDuration = 0
				arg_254_1.dialogCg_.alpha = 1

				arg_254_1.dialog_:SetActive(true)
				SetActive(arg_254_1.leftNameGo_, true)

				arg_254_1.leftNameTxt_.text = arg_254_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_254_1.leftNameTxt_.transform)

				arg_254_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_254_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_254_1:RecordName(arg_254_1.leftNameTxt_.text)
				SetActive(arg_254_1.iconTrs_.gameObject, true)
				arg_254_1.iconController_:SetSelectedState("hero")

				arg_254_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_254_1.callingController_:SetSelectedState("normal")

				arg_254_1.keyicon_.color = Color.New(1, 1, 1)
				arg_254_1.icon_.color = Color.New(1, 1, 1)

				local var_257_1 = arg_254_1:FormatText(arg_254_1:GetWordFromCfg(1108411061).content)

				arg_254_1.text_.text = var_257_1

				LuaForUtil.ClearLinePrefixSymbol(arg_254_1.text_)

				local var_257_3 = 16 <= 0 and var_257_0 or var_257_0 * (utf8.len(var_257_1) / 16)

				if (16 <= 0 and var_257_0 or var_257_0 * (utf8.len(var_257_1) / 16)) > 0 and var_257_0 < var_257_3 then
					arg_254_1.talkMaxDuration = var_257_3

					if var_257_3 + 0 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_3 + 0
					end
				end

				arg_254_1.text_.text = var_257_1
				arg_254_1.typewritter.percent = 0

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(false)
				arg_254_1:RecordContent(arg_254_1.text_.text)
			end

			local var_257_4 = math.max(var_257_0, arg_254_1.talkMaxDuration)

			if 0 <= arg_254_1.time_ and arg_254_1.time_ < 0 + var_257_4 then
				arg_254_1.typewritter.percent = (arg_254_1.time_ - 0) / var_257_4

				arg_254_1.typewritter:SetDirty()
			end

			if arg_254_1.time_ >= 0 + var_257_4 and arg_254_1.time_ < 0 + var_257_4 + arg_257_0 then
				arg_254_1.typewritter.percent = 1

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(true)
			end
		end

		arg_254_1.nodeConfigList_ = {}

		arg_254_1:InitPlayNodeList()
	end,
	Play1108411062 = function(arg_258_0, arg_258_1)
		arg_258_1.time_ = 0
		arg_258_1.frameCnt_ = 0
		arg_258_1.state_ = "playing"
		arg_258_1.curTalkId_ = 1108411062
		arg_258_1.duration_ = 5.6

		local var_258_0 = {
			zh = 4.5,
			ja = 5.6
		}
		local var_258_1 = manager.audio:GetLocalizationFlag()

		if var_258_0[var_258_1] ~= nil then
			arg_258_1.duration_ = var_258_0[var_258_1]
		end

		SetActive(arg_258_1.tipsGo_, false)

		function arg_258_1.onSingleLineFinish_()
			arg_258_1.onSingleLineUpdate_ = nil
			arg_258_1.onSingleLineFinish_ = nil
			arg_258_1.state_ = "waiting"
		end

		function arg_258_1.playNext_(arg_260_0)
			if arg_260_0 == 1 then
				arg_258_0:Play1108411063(arg_258_1)
			end
		end

		function arg_258_1.onSingleLineUpdate_(arg_261_0)
			if 0 < arg_258_1.time_ and arg_258_1.time_ <= 0 + arg_261_0 and not isNil(arg_258_1.actors_["10102ui_story"]) and arg_258_1.var_.characterEffect10102ui_story == nil then
				arg_258_1.var_.characterEffect10102ui_story = arg_258_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_261_0 = 0.200000002980232

			if 0 <= arg_258_1.time_ and arg_258_1.time_ < 0 + var_261_0 and not isNil(arg_258_1.actors_["10102ui_story"]) then
				if arg_258_1.var_.characterEffect10102ui_story and not isNil(arg_258_1.actors_["10102ui_story"]) then
					arg_258_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_258_1.time_ >= 0 + var_261_0 and arg_258_1.time_ < 0 + var_261_0 + arg_261_0 and not isNil(arg_258_1.actors_["10102ui_story"]) and arg_258_1.var_.characterEffect10102ui_story then
				arg_258_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_258_1.time_ and arg_258_1.time_ <= 0 + arg_261_0 then
				arg_258_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action7_1")
			end

			local var_261_2 = arg_258_1.actors_["10102ui_story"].transform

			if 0 < arg_258_1.time_ and arg_258_1.time_ <= 0 + arg_261_0 then
				arg_258_1.var_.moveOldPos10102ui_story = var_261_2.localPosition
			end

			local var_261_3 = 0.001

			if 0 <= arg_258_1.time_ and arg_258_1.time_ < 0 + var_261_3 then
				var_261_2.localPosition = Vector3.Lerp(arg_258_1.var_.moveOldPos10102ui_story, Vector3.New(0, -0.985, -6.275), (arg_258_1.time_ - 0) / var_261_3)
				var_261_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_261_2.position).x, (manager.ui.mainCamera.transform.position - var_261_2.position).y, (manager.ui.mainCamera.transform.position - var_261_2.position).z)
				var_261_2.localEulerAngles.z = 0
				var_261_2.localEulerAngles.x = 0
				var_261_2.localEulerAngles = var_261_2.localEulerAngles
			end

			if arg_258_1.time_ >= 0 + var_261_3 and arg_258_1.time_ < 0 + var_261_3 + arg_261_0 then
				var_261_2.localPosition = Vector3.New(0, -0.985, -6.275)
				var_261_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_261_2.position).x, (manager.ui.mainCamera.transform.position - var_261_2.position).y, (manager.ui.mainCamera.transform.position - var_261_2.position).z)
				var_261_2.localEulerAngles.z = 0
				var_261_2.localEulerAngles.x = 0
				var_261_2.localEulerAngles = var_261_2.localEulerAngles
			end

			if 0 < arg_258_1.time_ and arg_258_1.time_ <= 0 + arg_261_0 then
				arg_258_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_261_4 = 0
			local var_261_5 = 0.5

			if 0 < arg_258_1.time_ and arg_258_1.time_ <= var_261_4 + arg_261_0 then
				arg_258_1.talkMaxDuration = 0
				arg_258_1.dialogCg_.alpha = 1

				arg_258_1.dialog_:SetActive(true)
				SetActive(arg_258_1.leftNameGo_, true)

				arg_258_1.leftNameTxt_.text = arg_258_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_258_1.leftNameTxt_.transform)

				arg_258_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_258_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_258_1:RecordName(arg_258_1.leftNameTxt_.text)
				SetActive(arg_258_1.iconTrs_.gameObject, false)
				arg_258_1.callingController_:SetSelectedState("normal")

				local var_261_6 = arg_258_1:GetWordFromCfg(1108411062)
				local var_261_7 = arg_258_1:FormatText(var_261_6.content)

				arg_258_1.text_.text = var_261_7

				LuaForUtil.ClearLinePrefixSymbol(arg_258_1.text_)

				local var_261_9 = 20 <= 0 and var_261_5 or var_261_5 * (utf8.len(var_261_7) / 20)

				if (20 <= 0 and var_261_5 or var_261_5 * (utf8.len(var_261_7) / 20)) > 0 and var_261_5 < var_261_9 then
					arg_258_1.talkMaxDuration = var_261_9

					if var_261_9 + var_261_4 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_9 + var_261_4
					end
				end

				arg_258_1.text_.text = var_261_7
				arg_258_1.typewritter.percent = 0

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411062", "story_v_side_new_1108411.awb") ~= 0 then
					local var_261_10 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411062", "story_v_side_new_1108411.awb") / 1000

					if var_261_10 + var_261_4 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_10 + var_261_4
					end

					if var_261_6.prefab_name ~= "" and arg_258_1.actors_[var_261_6.prefab_name] ~= nil then
						local var_261_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_258_1.actors_[var_261_6.prefab_name].transform, "story_v_side_new_1108411", "1108411062", "story_v_side_new_1108411.awb")

						arg_258_1:RecordAudio("1108411062", var_261_11)
						arg_258_1:RecordAudio("1108411062", var_261_11)
					else
						arg_258_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411062", "story_v_side_new_1108411.awb")
					end

					arg_258_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411062", "story_v_side_new_1108411.awb")
				end

				arg_258_1:RecordContent(arg_258_1.text_.text)
			end

			local var_261_12 = math.max(var_261_5, arg_258_1.talkMaxDuration)

			if var_261_4 <= arg_258_1.time_ and arg_258_1.time_ < var_261_4 + var_261_12 then
				arg_258_1.typewritter.percent = (arg_258_1.time_ - var_261_4) / var_261_12

				arg_258_1.typewritter:SetDirty()
			end

			if arg_258_1.time_ >= var_261_4 + var_261_12 and arg_258_1.time_ < var_261_4 + var_261_12 + arg_261_0 then
				arg_258_1.typewritter.percent = 1

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(true)
			end
		end

		arg_258_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_258_1:InitPlayNodeList()
	end,
	Play1108411063 = function(arg_262_0, arg_262_1)
		arg_262_1.time_ = 0
		arg_262_1.frameCnt_ = 0
		arg_262_1.state_ = "playing"
		arg_262_1.curTalkId_ = 1108411063
		arg_262_1.duration_ = 9.2

		local var_262_0 = {
			zh = 7.666,
			ja = 9.2
		}
		local var_262_1 = manager.audio:GetLocalizationFlag()

		if var_262_0[var_262_1] ~= nil then
			arg_262_1.duration_ = var_262_0[var_262_1]
		end

		SetActive(arg_262_1.tipsGo_, false)

		function arg_262_1.onSingleLineFinish_()
			arg_262_1.onSingleLineUpdate_ = nil
			arg_262_1.onSingleLineFinish_ = nil
			arg_262_1.state_ = "waiting"
		end

		function arg_262_1.playNext_(arg_264_0)
			if arg_264_0 == 1 then
				arg_262_0:Play1108411064(arg_262_1)
			end
		end

		function arg_262_1.onSingleLineUpdate_(arg_265_0)
			local var_265_0 = 0.75

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 then
				arg_262_1.talkMaxDuration = 0
				arg_262_1.dialogCg_.alpha = 1

				arg_262_1.dialog_:SetActive(true)
				SetActive(arg_262_1.leftNameGo_, true)

				arg_262_1.leftNameTxt_.text = arg_262_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_262_1.leftNameTxt_.transform)

				arg_262_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_262_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_262_1:RecordName(arg_262_1.leftNameTxt_.text)
				SetActive(arg_262_1.iconTrs_.gameObject, false)
				arg_262_1.callingController_:SetSelectedState("normal")

				local var_265_1 = arg_262_1:GetWordFromCfg(1108411063)
				local var_265_2 = arg_262_1:FormatText(var_265_1.content)

				arg_262_1.text_.text = var_265_2

				LuaForUtil.ClearLinePrefixSymbol(arg_262_1.text_)

				local var_265_4 = 30 <= 0 and var_265_0 or var_265_0 * (utf8.len(var_265_2) / 30)

				if (30 <= 0 and var_265_0 or var_265_0 * (utf8.len(var_265_2) / 30)) > 0 and var_265_0 < var_265_4 then
					arg_262_1.talkMaxDuration = var_265_4

					if var_265_4 + 0 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_4 + 0
					end
				end

				arg_262_1.text_.text = var_265_2
				arg_262_1.typewritter.percent = 0

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411063", "story_v_side_new_1108411.awb") ~= 0 then
					local var_265_5 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411063", "story_v_side_new_1108411.awb") / 1000

					if var_265_5 + 0 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_5 + 0
					end

					if var_265_1.prefab_name ~= "" and arg_262_1.actors_[var_265_1.prefab_name] ~= nil then
						local var_265_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_262_1.actors_[var_265_1.prefab_name].transform, "story_v_side_new_1108411", "1108411063", "story_v_side_new_1108411.awb")

						arg_262_1:RecordAudio("1108411063", var_265_6)
						arg_262_1:RecordAudio("1108411063", var_265_6)
					else
						arg_262_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411063", "story_v_side_new_1108411.awb")
					end

					arg_262_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411063", "story_v_side_new_1108411.awb")
				end

				arg_262_1:RecordContent(arg_262_1.text_.text)
			end

			local var_265_7 = math.max(var_265_0, arg_262_1.talkMaxDuration)

			if 0 <= arg_262_1.time_ and arg_262_1.time_ < 0 + var_265_7 then
				arg_262_1.typewritter.percent = (arg_262_1.time_ - 0) / var_265_7

				arg_262_1.typewritter:SetDirty()
			end

			if arg_262_1.time_ >= 0 + var_265_7 and arg_262_1.time_ < 0 + var_265_7 + arg_265_0 then
				arg_262_1.typewritter.percent = 1

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(true)
			end
		end

		arg_262_1.nodeConfigList_ = {}

		arg_262_1:InitPlayNodeList()
	end,
	Play1108411064 = function(arg_266_0, arg_266_1)
		arg_266_1.time_ = 0
		arg_266_1.frameCnt_ = 0
		arg_266_1.state_ = "playing"
		arg_266_1.curTalkId_ = 1108411064
		arg_266_1.duration_ = 5

		SetActive(arg_266_1.tipsGo_, false)

		function arg_266_1.onSingleLineFinish_()
			arg_266_1.onSingleLineUpdate_ = nil
			arg_266_1.onSingleLineFinish_ = nil
			arg_266_1.state_ = "waiting"
		end

		function arg_266_1.playNext_(arg_268_0)
			if arg_268_0 == 1 then
				arg_266_0:Play1108411065(arg_266_1)
			end
		end

		function arg_266_1.onSingleLineUpdate_(arg_269_0)
			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 and not isNil(arg_266_1.actors_["10102ui_story"]) and arg_266_1.var_.characterEffect10102ui_story == nil then
				arg_266_1.var_.characterEffect10102ui_story = arg_266_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_269_0 = 0.200000002980232

			if 0 <= arg_266_1.time_ and arg_266_1.time_ < 0 + var_269_0 and not isNil(arg_266_1.actors_["10102ui_story"]) then
				if arg_266_1.var_.characterEffect10102ui_story and not isNil(arg_266_1.actors_["10102ui_story"]) then
					arg_266_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_266_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_266_1.time_ - 0) / var_269_0)
				end
			end

			if arg_266_1.time_ >= 0 + var_269_0 and arg_266_1.time_ < 0 + var_269_0 + arg_269_0 and not isNil(arg_266_1.actors_["10102ui_story"]) and arg_266_1.var_.characterEffect10102ui_story then
				arg_266_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_266_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_269_1 = 0
			local var_269_2 = 0.175

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= var_269_1 + arg_269_0 then
				arg_266_1.talkMaxDuration = 0
				arg_266_1.dialogCg_.alpha = 1

				arg_266_1.dialog_:SetActive(true)
				SetActive(arg_266_1.leftNameGo_, true)

				arg_266_1.leftNameTxt_.text = arg_266_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_266_1.leftNameTxt_.transform)

				arg_266_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_266_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_266_1:RecordName(arg_266_1.leftNameTxt_.text)
				SetActive(arg_266_1.iconTrs_.gameObject, true)
				arg_266_1.iconController_:SetSelectedState("hero")

				arg_266_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_266_1.callingController_:SetSelectedState("normal")

				arg_266_1.keyicon_.color = Color.New(1, 1, 1)
				arg_266_1.icon_.color = Color.New(1, 1, 1)

				local var_269_3 = arg_266_1:FormatText(arg_266_1:GetWordFromCfg(1108411064).content)

				arg_266_1.text_.text = var_269_3

				LuaForUtil.ClearLinePrefixSymbol(arg_266_1.text_)

				local var_269_5 = 7 <= 0 and var_269_2 or var_269_2 * (utf8.len(var_269_3) / 7)

				if (7 <= 0 and var_269_2 or var_269_2 * (utf8.len(var_269_3) / 7)) > 0 and var_269_2 < var_269_5 then
					arg_266_1.talkMaxDuration = var_269_5

					if var_269_5 + var_269_1 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_5 + var_269_1
					end
				end

				arg_266_1.text_.text = var_269_3
				arg_266_1.typewritter.percent = 0

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(false)
				arg_266_1:RecordContent(arg_266_1.text_.text)
			end

			local var_269_6 = math.max(var_269_2, arg_266_1.talkMaxDuration)

			if var_269_1 <= arg_266_1.time_ and arg_266_1.time_ < var_269_1 + var_269_6 then
				arg_266_1.typewritter.percent = (arg_266_1.time_ - var_269_1) / var_269_6

				arg_266_1.typewritter:SetDirty()
			end

			if arg_266_1.time_ >= var_269_1 + var_269_6 and arg_266_1.time_ < var_269_1 + var_269_6 + arg_269_0 then
				arg_266_1.typewritter.percent = 1

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(true)
			end
		end

		arg_266_1.nodeConfigList_ = {}

		arg_266_1:InitPlayNodeList()
	end,
	Play1108411065 = function(arg_270_0, arg_270_1)
		arg_270_1.time_ = 0
		arg_270_1.frameCnt_ = 0
		arg_270_1.state_ = "playing"
		arg_270_1.curTalkId_ = 1108411065
		arg_270_1.duration_ = 6.1

		local var_270_0 = {
			zh = 6.1,
			ja = 5.9
		}
		local var_270_1 = manager.audio:GetLocalizationFlag()

		if var_270_0[var_270_1] ~= nil then
			arg_270_1.duration_ = var_270_0[var_270_1]
		end

		SetActive(arg_270_1.tipsGo_, false)

		function arg_270_1.onSingleLineFinish_()
			arg_270_1.onSingleLineUpdate_ = nil
			arg_270_1.onSingleLineFinish_ = nil
			arg_270_1.state_ = "waiting"
		end

		function arg_270_1.playNext_(arg_272_0)
			if arg_272_0 == 1 then
				arg_270_0:Play1108411066(arg_270_1)
			end
		end

		function arg_270_1.onSingleLineUpdate_(arg_273_0)
			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 and not isNil(arg_270_1.actors_["10102ui_story"]) and arg_270_1.var_.characterEffect10102ui_story == nil then
				arg_270_1.var_.characterEffect10102ui_story = arg_270_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_273_0 = 0.200000002980232

			if 0 <= arg_270_1.time_ and arg_270_1.time_ < 0 + var_273_0 and not isNil(arg_270_1.actors_["10102ui_story"]) then
				if arg_270_1.var_.characterEffect10102ui_story and not isNil(arg_270_1.actors_["10102ui_story"]) then
					arg_270_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_270_1.time_ >= 0 + var_273_0 and arg_270_1.time_ < 0 + var_273_0 + arg_273_0 and not isNil(arg_270_1.actors_["10102ui_story"]) and arg_270_1.var_.characterEffect10102ui_story then
				arg_270_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 then
				arg_270_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action7_2")
			end

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 then
				arg_270_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_273_2 = 0
			local var_273_3 = 0.475

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= var_273_2 + arg_273_0 then
				arg_270_1.talkMaxDuration = 0
				arg_270_1.dialogCg_.alpha = 1

				arg_270_1.dialog_:SetActive(true)
				SetActive(arg_270_1.leftNameGo_, true)

				arg_270_1.leftNameTxt_.text = arg_270_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_270_1.leftNameTxt_.transform)

				arg_270_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_270_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_270_1:RecordName(arg_270_1.leftNameTxt_.text)
				SetActive(arg_270_1.iconTrs_.gameObject, false)
				arg_270_1.callingController_:SetSelectedState("normal")

				local var_273_4 = arg_270_1:GetWordFromCfg(1108411065)
				local var_273_5 = arg_270_1:FormatText(var_273_4.content)

				arg_270_1.text_.text = var_273_5

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.text_)

				local var_273_7 = 19 <= 0 and var_273_3 or var_273_3 * (utf8.len(var_273_5) / 19)

				if (19 <= 0 and var_273_3 or var_273_3 * (utf8.len(var_273_5) / 19)) > 0 and var_273_3 < var_273_7 then
					arg_270_1.talkMaxDuration = var_273_7

					if var_273_7 + var_273_2 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_7 + var_273_2
					end
				end

				arg_270_1.text_.text = var_273_5
				arg_270_1.typewritter.percent = 0

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411065", "story_v_side_new_1108411.awb") ~= 0 then
					local var_273_8 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411065", "story_v_side_new_1108411.awb") / 1000

					if var_273_8 + var_273_2 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_8 + var_273_2
					end

					if var_273_4.prefab_name ~= "" and arg_270_1.actors_[var_273_4.prefab_name] ~= nil then
						local var_273_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_270_1.actors_[var_273_4.prefab_name].transform, "story_v_side_new_1108411", "1108411065", "story_v_side_new_1108411.awb")

						arg_270_1:RecordAudio("1108411065", var_273_9)
						arg_270_1:RecordAudio("1108411065", var_273_9)
					else
						arg_270_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411065", "story_v_side_new_1108411.awb")
					end

					arg_270_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411065", "story_v_side_new_1108411.awb")
				end

				arg_270_1:RecordContent(arg_270_1.text_.text)
			end

			local var_273_10 = math.max(var_273_3, arg_270_1.talkMaxDuration)

			if var_273_2 <= arg_270_1.time_ and arg_270_1.time_ < var_273_2 + var_273_10 then
				arg_270_1.typewritter.percent = (arg_270_1.time_ - var_273_2) / var_273_10

				arg_270_1.typewritter:SetDirty()
			end

			if arg_270_1.time_ >= var_273_2 + var_273_10 and arg_270_1.time_ < var_273_2 + var_273_10 + arg_273_0 then
				arg_270_1.typewritter.percent = 1

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(true)
			end
		end

		arg_270_1.nodeConfigList_ = {}

		arg_270_1:InitPlayNodeList()
	end,
	Play1108411066 = function(arg_274_0, arg_274_1)
		arg_274_1.time_ = 0
		arg_274_1.frameCnt_ = 0
		arg_274_1.state_ = "playing"
		arg_274_1.curTalkId_ = 1108411066
		arg_274_1.duration_ = 5

		SetActive(arg_274_1.tipsGo_, false)

		function arg_274_1.onSingleLineFinish_()
			arg_274_1.onSingleLineUpdate_ = nil
			arg_274_1.onSingleLineFinish_ = nil
			arg_274_1.state_ = "waiting"
		end

		function arg_274_1.playNext_(arg_276_0)
			if arg_276_0 == 1 then
				arg_274_0:Play1108411067(arg_274_1)
			end
		end

		function arg_274_1.onSingleLineUpdate_(arg_277_0)
			if 0 < arg_274_1.time_ and arg_274_1.time_ <= 0 + arg_277_0 and not isNil(arg_274_1.actors_["10102ui_story"]) and arg_274_1.var_.characterEffect10102ui_story == nil then
				arg_274_1.var_.characterEffect10102ui_story = arg_274_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_277_0 = 0.200000002980232

			if 0 <= arg_274_1.time_ and arg_274_1.time_ < 0 + var_277_0 and not isNil(arg_274_1.actors_["10102ui_story"]) then
				if arg_274_1.var_.characterEffect10102ui_story and not isNil(arg_274_1.actors_["10102ui_story"]) then
					arg_274_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_274_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_274_1.time_ - 0) / var_277_0)
				end
			end

			if arg_274_1.time_ >= 0 + var_277_0 and arg_274_1.time_ < 0 + var_277_0 + arg_277_0 and not isNil(arg_274_1.actors_["10102ui_story"]) and arg_274_1.var_.characterEffect10102ui_story then
				arg_274_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_274_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_277_1 = 0
			local var_277_2 = 0.65

			if 0 < arg_274_1.time_ and arg_274_1.time_ <= var_277_1 + arg_277_0 then
				arg_274_1.talkMaxDuration = 0
				arg_274_1.dialogCg_.alpha = 1

				arg_274_1.dialog_:SetActive(true)
				SetActive(arg_274_1.leftNameGo_, true)

				arg_274_1.leftNameTxt_.text = arg_274_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_274_1.leftNameTxt_.transform)

				arg_274_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_274_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_274_1:RecordName(arg_274_1.leftNameTxt_.text)
				SetActive(arg_274_1.iconTrs_.gameObject, true)
				arg_274_1.iconController_:SetSelectedState("hero")

				arg_274_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_274_1.callingController_:SetSelectedState("normal")

				arg_274_1.keyicon_.color = Color.New(1, 1, 1)
				arg_274_1.icon_.color = Color.New(1, 1, 1)

				local var_277_3 = arg_274_1:FormatText(arg_274_1:GetWordFromCfg(1108411066).content)

				arg_274_1.text_.text = var_277_3

				LuaForUtil.ClearLinePrefixSymbol(arg_274_1.text_)

				local var_277_5 = 26 <= 0 and var_277_2 or var_277_2 * (utf8.len(var_277_3) / 26)

				if (26 <= 0 and var_277_2 or var_277_2 * (utf8.len(var_277_3) / 26)) > 0 and var_277_2 < var_277_5 then
					arg_274_1.talkMaxDuration = var_277_5

					if var_277_5 + var_277_1 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_5 + var_277_1
					end
				end

				arg_274_1.text_.text = var_277_3
				arg_274_1.typewritter.percent = 0

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(false)
				arg_274_1:RecordContent(arg_274_1.text_.text)
			end

			local var_277_6 = math.max(var_277_2, arg_274_1.talkMaxDuration)

			if var_277_1 <= arg_274_1.time_ and arg_274_1.time_ < var_277_1 + var_277_6 then
				arg_274_1.typewritter.percent = (arg_274_1.time_ - var_277_1) / var_277_6

				arg_274_1.typewritter:SetDirty()
			end

			if arg_274_1.time_ >= var_277_1 + var_277_6 and arg_274_1.time_ < var_277_1 + var_277_6 + arg_277_0 then
				arg_274_1.typewritter.percent = 1

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(true)
			end
		end

		arg_274_1.nodeConfigList_ = {}

		arg_274_1:InitPlayNodeList()
	end,
	Play1108411067 = function(arg_278_0, arg_278_1)
		arg_278_1.time_ = 0
		arg_278_1.frameCnt_ = 0
		arg_278_1.state_ = "playing"
		arg_278_1.curTalkId_ = 1108411067
		arg_278_1.duration_ = 5

		SetActive(arg_278_1.tipsGo_, false)

		function arg_278_1.onSingleLineFinish_()
			arg_278_1.onSingleLineUpdate_ = nil
			arg_278_1.onSingleLineFinish_ = nil
			arg_278_1.state_ = "waiting"
		end

		function arg_278_1.playNext_(arg_280_0)
			if arg_280_0 == 1 then
				arg_278_0:Play1108411068(arg_278_1)
			end
		end

		function arg_278_1.onSingleLineUpdate_(arg_281_0)
			local var_281_0 = 0.675

			if 0 < arg_278_1.time_ and arg_278_1.time_ <= 0 + arg_281_0 then
				arg_278_1.talkMaxDuration = 0
				arg_278_1.dialogCg_.alpha = 1

				arg_278_1.dialog_:SetActive(true)
				SetActive(arg_278_1.leftNameGo_, true)

				arg_278_1.leftNameTxt_.text = arg_278_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_278_1.leftNameTxt_.transform)

				arg_278_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_278_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_278_1:RecordName(arg_278_1.leftNameTxt_.text)
				SetActive(arg_278_1.iconTrs_.gameObject, true)
				arg_278_1.iconController_:SetSelectedState("hero")

				arg_278_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_278_1.callingController_:SetSelectedState("normal")

				arg_278_1.keyicon_.color = Color.New(1, 1, 1)
				arg_278_1.icon_.color = Color.New(1, 1, 1)

				local var_281_1 = arg_278_1:FormatText(arg_278_1:GetWordFromCfg(1108411067).content)

				arg_278_1.text_.text = var_281_1

				LuaForUtil.ClearLinePrefixSymbol(arg_278_1.text_)

				local var_281_3 = 27 <= 0 and var_281_0 or var_281_0 * (utf8.len(var_281_1) / 27)

				if (27 <= 0 and var_281_0 or var_281_0 * (utf8.len(var_281_1) / 27)) > 0 and var_281_0 < var_281_3 then
					arg_278_1.talkMaxDuration = var_281_3

					if var_281_3 + 0 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_3 + 0
					end
				end

				arg_278_1.text_.text = var_281_1
				arg_278_1.typewritter.percent = 0

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(false)
				arg_278_1:RecordContent(arg_278_1.text_.text)
			end

			local var_281_4 = math.max(var_281_0, arg_278_1.talkMaxDuration)

			if 0 <= arg_278_1.time_ and arg_278_1.time_ < 0 + var_281_4 then
				arg_278_1.typewritter.percent = (arg_278_1.time_ - 0) / var_281_4

				arg_278_1.typewritter:SetDirty()
			end

			if arg_278_1.time_ >= 0 + var_281_4 and arg_278_1.time_ < 0 + var_281_4 + arg_281_0 then
				arg_278_1.typewritter.percent = 1

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(true)
			end
		end

		arg_278_1.nodeConfigList_ = {}

		arg_278_1:InitPlayNodeList()
	end,
	Play1108411068 = function(arg_282_0, arg_282_1)
		arg_282_1.time_ = 0
		arg_282_1.frameCnt_ = 0
		arg_282_1.state_ = "playing"
		arg_282_1.curTalkId_ = 1108411068
		arg_282_1.duration_ = 2.13

		local var_282_0 = {
			zh = 2.1,
			ja = 2.133
		}
		local var_282_1 = manager.audio:GetLocalizationFlag()

		if var_282_0[var_282_1] ~= nil then
			arg_282_1.duration_ = var_282_0[var_282_1]
		end

		SetActive(arg_282_1.tipsGo_, false)

		function arg_282_1.onSingleLineFinish_()
			arg_282_1.onSingleLineUpdate_ = nil
			arg_282_1.onSingleLineFinish_ = nil
			arg_282_1.state_ = "waiting"
		end

		function arg_282_1.playNext_(arg_284_0)
			if arg_284_0 == 1 then
				arg_282_0:Play1108411069(arg_282_1)
			end
		end

		function arg_282_1.onSingleLineUpdate_(arg_285_0)
			if 0 < arg_282_1.time_ and arg_282_1.time_ <= 0 + arg_285_0 and not isNil(arg_282_1.actors_["10102ui_story"]) and arg_282_1.var_.characterEffect10102ui_story == nil then
				arg_282_1.var_.characterEffect10102ui_story = arg_282_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_285_0 = 0.200000002980232

			if 0 <= arg_282_1.time_ and arg_282_1.time_ < 0 + var_285_0 and not isNil(arg_282_1.actors_["10102ui_story"]) then
				if arg_282_1.var_.characterEffect10102ui_story and not isNil(arg_282_1.actors_["10102ui_story"]) then
					arg_282_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_282_1.time_ >= 0 + var_285_0 and arg_282_1.time_ < 0 + var_285_0 + arg_285_0 and not isNil(arg_282_1.actors_["10102ui_story"]) and arg_282_1.var_.characterEffect10102ui_story then
				arg_282_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= 0 + arg_285_0 then
				arg_282_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action6_1")
			end

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= 0 + arg_285_0 then
				arg_282_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_285_2 = 0
			local var_285_3 = 0.2

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= var_285_2 + arg_285_0 then
				arg_282_1.talkMaxDuration = 0
				arg_282_1.dialogCg_.alpha = 1

				arg_282_1.dialog_:SetActive(true)
				SetActive(arg_282_1.leftNameGo_, true)

				arg_282_1.leftNameTxt_.text = arg_282_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_282_1.leftNameTxt_.transform)

				arg_282_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_282_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_282_1:RecordName(arg_282_1.leftNameTxt_.text)
				SetActive(arg_282_1.iconTrs_.gameObject, false)
				arg_282_1.callingController_:SetSelectedState("normal")

				local var_285_4 = arg_282_1:GetWordFromCfg(1108411068)
				local var_285_5 = arg_282_1:FormatText(var_285_4.content)

				arg_282_1.text_.text = var_285_5

				LuaForUtil.ClearLinePrefixSymbol(arg_282_1.text_)

				local var_285_7 = 8 <= 0 and var_285_3 or var_285_3 * (utf8.len(var_285_5) / 8)

				if (8 <= 0 and var_285_3 or var_285_3 * (utf8.len(var_285_5) / 8)) > 0 and var_285_3 < var_285_7 then
					arg_282_1.talkMaxDuration = var_285_7

					if var_285_7 + var_285_2 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_7 + var_285_2
					end
				end

				arg_282_1.text_.text = var_285_5
				arg_282_1.typewritter.percent = 0

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411068", "story_v_side_new_1108411.awb") ~= 0 then
					local var_285_8 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411068", "story_v_side_new_1108411.awb") / 1000

					if var_285_8 + var_285_2 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_8 + var_285_2
					end

					if var_285_4.prefab_name ~= "" and arg_282_1.actors_[var_285_4.prefab_name] ~= nil then
						local var_285_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_282_1.actors_[var_285_4.prefab_name].transform, "story_v_side_new_1108411", "1108411068", "story_v_side_new_1108411.awb")

						arg_282_1:RecordAudio("1108411068", var_285_9)
						arg_282_1:RecordAudio("1108411068", var_285_9)
					else
						arg_282_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411068", "story_v_side_new_1108411.awb")
					end

					arg_282_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411068", "story_v_side_new_1108411.awb")
				end

				arg_282_1:RecordContent(arg_282_1.text_.text)
			end

			local var_285_10 = math.max(var_285_3, arg_282_1.talkMaxDuration)

			if var_285_2 <= arg_282_1.time_ and arg_282_1.time_ < var_285_2 + var_285_10 then
				arg_282_1.typewritter.percent = (arg_282_1.time_ - var_285_2) / var_285_10

				arg_282_1.typewritter:SetDirty()
			end

			if arg_282_1.time_ >= var_285_2 + var_285_10 and arg_282_1.time_ < var_285_2 + var_285_10 + arg_285_0 then
				arg_282_1.typewritter.percent = 1

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(true)
			end
		end

		arg_282_1.nodeConfigList_ = {}

		arg_282_1:InitPlayNodeList()
	end,
	Play1108411069 = function(arg_286_0, arg_286_1)
		arg_286_1.time_ = 0
		arg_286_1.frameCnt_ = 0
		arg_286_1.state_ = "playing"
		arg_286_1.curTalkId_ = 1108411069
		arg_286_1.duration_ = 5

		SetActive(arg_286_1.tipsGo_, false)

		function arg_286_1.onSingleLineFinish_()
			arg_286_1.onSingleLineUpdate_ = nil
			arg_286_1.onSingleLineFinish_ = nil
			arg_286_1.state_ = "waiting"
		end

		function arg_286_1.playNext_(arg_288_0)
			if arg_288_0 == 1 then
				arg_286_0:Play1108411070(arg_286_1)
			end
		end

		function arg_286_1.onSingleLineUpdate_(arg_289_0)
			if 0 < arg_286_1.time_ and arg_286_1.time_ <= 0 + arg_289_0 and not isNil(arg_286_1.actors_["10102ui_story"]) and arg_286_1.var_.characterEffect10102ui_story == nil then
				arg_286_1.var_.characterEffect10102ui_story = arg_286_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_289_0 = 0.200000002980232

			if 0 <= arg_286_1.time_ and arg_286_1.time_ < 0 + var_289_0 and not isNil(arg_286_1.actors_["10102ui_story"]) then
				if arg_286_1.var_.characterEffect10102ui_story and not isNil(arg_286_1.actors_["10102ui_story"]) then
					arg_286_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_286_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_286_1.time_ - 0) / var_289_0)
				end
			end

			if arg_286_1.time_ >= 0 + var_289_0 and arg_286_1.time_ < 0 + var_289_0 + arg_289_0 and not isNil(arg_286_1.actors_["10102ui_story"]) and arg_286_1.var_.characterEffect10102ui_story then
				arg_286_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_286_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_289_1 = 0
			local var_289_2 = 0.2

			if 0 < arg_286_1.time_ and arg_286_1.time_ <= var_289_1 + arg_289_0 then
				arg_286_1.talkMaxDuration = 0
				arg_286_1.dialogCg_.alpha = 1

				arg_286_1.dialog_:SetActive(true)
				SetActive(arg_286_1.leftNameGo_, true)

				arg_286_1.leftNameTxt_.text = arg_286_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_286_1.leftNameTxt_.transform)

				arg_286_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_286_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_286_1:RecordName(arg_286_1.leftNameTxt_.text)
				SetActive(arg_286_1.iconTrs_.gameObject, true)
				arg_286_1.iconController_:SetSelectedState("hero")

				arg_286_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_286_1.callingController_:SetSelectedState("normal")

				arg_286_1.keyicon_.color = Color.New(1, 1, 1)
				arg_286_1.icon_.color = Color.New(1, 1, 1)

				local var_289_3 = arg_286_1:FormatText(arg_286_1:GetWordFromCfg(1108411069).content)

				arg_286_1.text_.text = var_289_3

				LuaForUtil.ClearLinePrefixSymbol(arg_286_1.text_)

				local var_289_5 = 8 <= 0 and var_289_2 or var_289_2 * (utf8.len(var_289_3) / 8)

				if (8 <= 0 and var_289_2 or var_289_2 * (utf8.len(var_289_3) / 8)) > 0 and var_289_2 < var_289_5 then
					arg_286_1.talkMaxDuration = var_289_5

					if var_289_5 + var_289_1 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_5 + var_289_1
					end
				end

				arg_286_1.text_.text = var_289_3
				arg_286_1.typewritter.percent = 0

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(false)
				arg_286_1:RecordContent(arg_286_1.text_.text)
			end

			local var_289_6 = math.max(var_289_2, arg_286_1.talkMaxDuration)

			if var_289_1 <= arg_286_1.time_ and arg_286_1.time_ < var_289_1 + var_289_6 then
				arg_286_1.typewritter.percent = (arg_286_1.time_ - var_289_1) / var_289_6

				arg_286_1.typewritter:SetDirty()
			end

			if arg_286_1.time_ >= var_289_1 + var_289_6 and arg_286_1.time_ < var_289_1 + var_289_6 + arg_289_0 then
				arg_286_1.typewritter.percent = 1

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(true)
			end
		end

		arg_286_1.nodeConfigList_ = {}

		arg_286_1:InitPlayNodeList()
	end,
	Play1108411070 = function(arg_290_0, arg_290_1)
		arg_290_1.time_ = 0
		arg_290_1.frameCnt_ = 0
		arg_290_1.state_ = "playing"
		arg_290_1.curTalkId_ = 1108411070
		arg_290_1.duration_ = 2.97

		local var_290_0 = {
			zh = 2.3,
			ja = 2.966
		}
		local var_290_1 = manager.audio:GetLocalizationFlag()

		if var_290_0[var_290_1] ~= nil then
			arg_290_1.duration_ = var_290_0[var_290_1]
		end

		SetActive(arg_290_1.tipsGo_, false)

		function arg_290_1.onSingleLineFinish_()
			arg_290_1.onSingleLineUpdate_ = nil
			arg_290_1.onSingleLineFinish_ = nil
			arg_290_1.state_ = "waiting"
		end

		function arg_290_1.playNext_(arg_292_0)
			if arg_292_0 == 1 then
				arg_290_0:Play1108411071(arg_290_1)
			end
		end

		function arg_290_1.onSingleLineUpdate_(arg_293_0)
			if 0 < arg_290_1.time_ and arg_290_1.time_ <= 0 + arg_293_0 and not isNil(arg_290_1.actors_["10102ui_story"]) and arg_290_1.var_.characterEffect10102ui_story == nil then
				arg_290_1.var_.characterEffect10102ui_story = arg_290_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_293_0 = 0.200000002980232

			if 0 <= arg_290_1.time_ and arg_290_1.time_ < 0 + var_293_0 and not isNil(arg_290_1.actors_["10102ui_story"]) then
				if arg_290_1.var_.characterEffect10102ui_story and not isNil(arg_290_1.actors_["10102ui_story"]) then
					arg_290_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_290_1.time_ >= 0 + var_293_0 and arg_290_1.time_ < 0 + var_293_0 + arg_293_0 and not isNil(arg_290_1.actors_["10102ui_story"]) and arg_290_1.var_.characterEffect10102ui_story then
				arg_290_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_290_1.time_ and arg_290_1.time_ <= 0 + arg_293_0 then
				arg_290_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action6_2")
			end

			if 0 < arg_290_1.time_ and arg_290_1.time_ <= 0 + arg_293_0 then
				arg_290_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_293_2 = 0
			local var_293_3 = 0.125

			if 0 < arg_290_1.time_ and arg_290_1.time_ <= var_293_2 + arg_293_0 then
				arg_290_1.talkMaxDuration = 0
				arg_290_1.dialogCg_.alpha = 1

				arg_290_1.dialog_:SetActive(true)
				SetActive(arg_290_1.leftNameGo_, true)

				arg_290_1.leftNameTxt_.text = arg_290_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_290_1.leftNameTxt_.transform)

				arg_290_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_290_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_290_1:RecordName(arg_290_1.leftNameTxt_.text)
				SetActive(arg_290_1.iconTrs_.gameObject, false)
				arg_290_1.callingController_:SetSelectedState("normal")

				local var_293_4 = arg_290_1:GetWordFromCfg(1108411070)
				local var_293_5 = arg_290_1:FormatText(var_293_4.content)

				arg_290_1.text_.text = var_293_5

				LuaForUtil.ClearLinePrefixSymbol(arg_290_1.text_)

				local var_293_7 = 5 <= 0 and var_293_3 or var_293_3 * (utf8.len(var_293_5) / 5)

				if (5 <= 0 and var_293_3 or var_293_3 * (utf8.len(var_293_5) / 5)) > 0 and var_293_3 < var_293_7 then
					arg_290_1.talkMaxDuration = var_293_7

					if var_293_7 + var_293_2 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_7 + var_293_2
					end
				end

				arg_290_1.text_.text = var_293_5
				arg_290_1.typewritter.percent = 0

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411070", "story_v_side_new_1108411.awb") ~= 0 then
					local var_293_8 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411070", "story_v_side_new_1108411.awb") / 1000

					if var_293_8 + var_293_2 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_8 + var_293_2
					end

					if var_293_4.prefab_name ~= "" and arg_290_1.actors_[var_293_4.prefab_name] ~= nil then
						local var_293_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_290_1.actors_[var_293_4.prefab_name].transform, "story_v_side_new_1108411", "1108411070", "story_v_side_new_1108411.awb")

						arg_290_1:RecordAudio("1108411070", var_293_9)
						arg_290_1:RecordAudio("1108411070", var_293_9)
					else
						arg_290_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411070", "story_v_side_new_1108411.awb")
					end

					arg_290_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411070", "story_v_side_new_1108411.awb")
				end

				arg_290_1:RecordContent(arg_290_1.text_.text)
			end

			local var_293_10 = math.max(var_293_3, arg_290_1.talkMaxDuration)

			if var_293_2 <= arg_290_1.time_ and arg_290_1.time_ < var_293_2 + var_293_10 then
				arg_290_1.typewritter.percent = (arg_290_1.time_ - var_293_2) / var_293_10

				arg_290_1.typewritter:SetDirty()
			end

			if arg_290_1.time_ >= var_293_2 + var_293_10 and arg_290_1.time_ < var_293_2 + var_293_10 + arg_293_0 then
				arg_290_1.typewritter.percent = 1

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(true)
			end
		end

		arg_290_1.nodeConfigList_ = {}

		arg_290_1:InitPlayNodeList()
	end,
	Play1108411071 = function(arg_294_0, arg_294_1)
		arg_294_1.time_ = 0
		arg_294_1.frameCnt_ = 0
		arg_294_1.state_ = "playing"
		arg_294_1.curTalkId_ = 1108411071
		arg_294_1.duration_ = 5

		SetActive(arg_294_1.tipsGo_, false)

		function arg_294_1.onSingleLineFinish_()
			arg_294_1.onSingleLineUpdate_ = nil
			arg_294_1.onSingleLineFinish_ = nil
			arg_294_1.state_ = "waiting"
		end

		function arg_294_1.playNext_(arg_296_0)
			if arg_296_0 == 1 then
				arg_294_0:Play1108411072(arg_294_1)
			end
		end

		function arg_294_1.onSingleLineUpdate_(arg_297_0)
			if 0 < arg_294_1.time_ and arg_294_1.time_ <= 0 + arg_297_0 and not isNil(arg_294_1.actors_["10102ui_story"]) and arg_294_1.var_.characterEffect10102ui_story == nil then
				arg_294_1.var_.characterEffect10102ui_story = arg_294_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_297_0 = 0.200000002980232

			if 0 <= arg_294_1.time_ and arg_294_1.time_ < 0 + var_297_0 and not isNil(arg_294_1.actors_["10102ui_story"]) then
				if arg_294_1.var_.characterEffect10102ui_story and not isNil(arg_294_1.actors_["10102ui_story"]) then
					arg_294_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_294_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_294_1.time_ - 0) / var_297_0)
				end
			end

			if arg_294_1.time_ >= 0 + var_297_0 and arg_294_1.time_ < 0 + var_297_0 + arg_297_0 and not isNil(arg_294_1.actors_["10102ui_story"]) and arg_294_1.var_.characterEffect10102ui_story then
				arg_294_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_294_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_297_1 = 0
			local var_297_2 = 0.55

			if 0 < arg_294_1.time_ and arg_294_1.time_ <= var_297_1 + arg_297_0 then
				arg_294_1.talkMaxDuration = 0
				arg_294_1.dialogCg_.alpha = 1

				arg_294_1.dialog_:SetActive(true)
				SetActive(arg_294_1.leftNameGo_, true)

				arg_294_1.leftNameTxt_.text = arg_294_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_294_1.leftNameTxt_.transform)

				arg_294_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_294_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_294_1:RecordName(arg_294_1.leftNameTxt_.text)
				SetActive(arg_294_1.iconTrs_.gameObject, true)
				arg_294_1.iconController_:SetSelectedState("hero")

				arg_294_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_294_1.callingController_:SetSelectedState("normal")

				arg_294_1.keyicon_.color = Color.New(1, 1, 1)
				arg_294_1.icon_.color = Color.New(1, 1, 1)

				local var_297_3 = arg_294_1:FormatText(arg_294_1:GetWordFromCfg(1108411071).content)

				arg_294_1.text_.text = var_297_3

				LuaForUtil.ClearLinePrefixSymbol(arg_294_1.text_)

				local var_297_5 = 22 <= 0 and var_297_2 or var_297_2 * (utf8.len(var_297_3) / 22)

				if (22 <= 0 and var_297_2 or var_297_2 * (utf8.len(var_297_3) / 22)) > 0 and var_297_2 < var_297_5 then
					arg_294_1.talkMaxDuration = var_297_5

					if var_297_5 + var_297_1 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_5 + var_297_1
					end
				end

				arg_294_1.text_.text = var_297_3
				arg_294_1.typewritter.percent = 0

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(false)
				arg_294_1:RecordContent(arg_294_1.text_.text)
			end

			local var_297_6 = math.max(var_297_2, arg_294_1.talkMaxDuration)

			if var_297_1 <= arg_294_1.time_ and arg_294_1.time_ < var_297_1 + var_297_6 then
				arg_294_1.typewritter.percent = (arg_294_1.time_ - var_297_1) / var_297_6

				arg_294_1.typewritter:SetDirty()
			end

			if arg_294_1.time_ >= var_297_1 + var_297_6 and arg_294_1.time_ < var_297_1 + var_297_6 + arg_297_0 then
				arg_294_1.typewritter.percent = 1

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(true)
			end
		end

		arg_294_1.nodeConfigList_ = {}

		arg_294_1:InitPlayNodeList()
	end,
	Play1108411072 = function(arg_298_0, arg_298_1)
		arg_298_1.time_ = 0
		arg_298_1.frameCnt_ = 0
		arg_298_1.state_ = "playing"
		arg_298_1.curTalkId_ = 1108411072
		arg_298_1.duration_ = 5

		SetActive(arg_298_1.tipsGo_, false)

		function arg_298_1.onSingleLineFinish_()
			arg_298_1.onSingleLineUpdate_ = nil
			arg_298_1.onSingleLineFinish_ = nil
			arg_298_1.state_ = "waiting"
		end

		function arg_298_1.playNext_(arg_300_0)
			if arg_300_0 == 1 then
				arg_298_0:Play1108411073(arg_298_1)
			end
		end

		function arg_298_1.onSingleLineUpdate_(arg_301_0)
			local var_301_0 = 0.75

			if 0 < arg_298_1.time_ and arg_298_1.time_ <= 0 + arg_301_0 then
				arg_298_1.talkMaxDuration = 0
				arg_298_1.dialogCg_.alpha = 1

				arg_298_1.dialog_:SetActive(true)
				SetActive(arg_298_1.leftNameGo_, true)

				arg_298_1.leftNameTxt_.text = arg_298_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_298_1.leftNameTxt_.transform)

				arg_298_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_298_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_298_1:RecordName(arg_298_1.leftNameTxt_.text)
				SetActive(arg_298_1.iconTrs_.gameObject, true)
				arg_298_1.iconController_:SetSelectedState("hero")

				arg_298_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_298_1.callingController_:SetSelectedState("normal")

				arg_298_1.keyicon_.color = Color.New(1, 1, 1)
				arg_298_1.icon_.color = Color.New(1, 1, 1)

				local var_301_1 = arg_298_1:FormatText(arg_298_1:GetWordFromCfg(1108411072).content)

				arg_298_1.text_.text = var_301_1

				LuaForUtil.ClearLinePrefixSymbol(arg_298_1.text_)

				local var_301_3 = 30 <= 0 and var_301_0 or var_301_0 * (utf8.len(var_301_1) / 30)

				if (30 <= 0 and var_301_0 or var_301_0 * (utf8.len(var_301_1) / 30)) > 0 and var_301_0 < var_301_3 then
					arg_298_1.talkMaxDuration = var_301_3

					if var_301_3 + 0 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_3 + 0
					end
				end

				arg_298_1.text_.text = var_301_1
				arg_298_1.typewritter.percent = 0

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(false)
				arg_298_1:RecordContent(arg_298_1.text_.text)
			end

			local var_301_4 = math.max(var_301_0, arg_298_1.talkMaxDuration)

			if 0 <= arg_298_1.time_ and arg_298_1.time_ < 0 + var_301_4 then
				arg_298_1.typewritter.percent = (arg_298_1.time_ - 0) / var_301_4

				arg_298_1.typewritter:SetDirty()
			end

			if arg_298_1.time_ >= 0 + var_301_4 and arg_298_1.time_ < 0 + var_301_4 + arg_301_0 then
				arg_298_1.typewritter.percent = 1

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(true)
			end
		end

		arg_298_1.nodeConfigList_ = {}

		arg_298_1:InitPlayNodeList()
	end,
	Play1108411073 = function(arg_302_0, arg_302_1)
		arg_302_1.time_ = 0
		arg_302_1.frameCnt_ = 0
		arg_302_1.state_ = "playing"
		arg_302_1.curTalkId_ = 1108411073
		arg_302_1.duration_ = 5

		SetActive(arg_302_1.tipsGo_, false)

		function arg_302_1.onSingleLineFinish_()
			arg_302_1.onSingleLineUpdate_ = nil
			arg_302_1.onSingleLineFinish_ = nil
			arg_302_1.state_ = "waiting"
		end

		function arg_302_1.playNext_(arg_304_0)
			if arg_304_0 == 1 then
				arg_302_0:Play1108411074(arg_302_1)
			end
		end

		function arg_302_1.onSingleLineUpdate_(arg_305_0)
			local var_305_0 = 1.1

			if 0 < arg_302_1.time_ and arg_302_1.time_ <= 0 + arg_305_0 then
				arg_302_1.talkMaxDuration = 0
				arg_302_1.dialogCg_.alpha = 1

				arg_302_1.dialog_:SetActive(true)
				SetActive(arg_302_1.leftNameGo_, false)

				arg_302_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_302_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_302_1:RecordName(arg_302_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_302_1.iconTrs_.gameObject, false)
				arg_302_1.callingController_:SetSelectedState("normal")

				local var_305_1 = arg_302_1:FormatText(arg_302_1:GetWordFromCfg(1108411073).content)

				arg_302_1.text_.text = var_305_1

				LuaForUtil.ClearLinePrefixSymbol(arg_302_1.text_)

				local var_305_3 = 44 <= 0 and var_305_0 or var_305_0 * (utf8.len(var_305_1) / 44)

				if (44 <= 0 and var_305_0 or var_305_0 * (utf8.len(var_305_1) / 44)) > 0 and var_305_0 < var_305_3 then
					arg_302_1.talkMaxDuration = var_305_3

					if var_305_3 + 0 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_3 + 0
					end
				end

				arg_302_1.text_.text = var_305_1
				arg_302_1.typewritter.percent = 0

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(false)
				arg_302_1:RecordContent(arg_302_1.text_.text)
			end

			local var_305_4 = math.max(var_305_0, arg_302_1.talkMaxDuration)

			if 0 <= arg_302_1.time_ and arg_302_1.time_ < 0 + var_305_4 then
				arg_302_1.typewritter.percent = (arg_302_1.time_ - 0) / var_305_4

				arg_302_1.typewritter:SetDirty()
			end

			if arg_302_1.time_ >= 0 + var_305_4 and arg_302_1.time_ < 0 + var_305_4 + arg_305_0 then
				arg_302_1.typewritter.percent = 1

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(true)
			end
		end

		arg_302_1.nodeConfigList_ = {}

		arg_302_1:InitPlayNodeList()
	end,
	Play1108411074 = function(arg_306_0, arg_306_1)
		arg_306_1.time_ = 0
		arg_306_1.frameCnt_ = 0
		arg_306_1.state_ = "playing"
		arg_306_1.curTalkId_ = 1108411074
		arg_306_1.duration_ = 7.2

		local var_306_0 = {
			zh = 6.166,
			ja = 7.2
		}
		local var_306_1 = manager.audio:GetLocalizationFlag()

		if var_306_0[var_306_1] ~= nil then
			arg_306_1.duration_ = var_306_0[var_306_1]
		end

		SetActive(arg_306_1.tipsGo_, false)

		function arg_306_1.onSingleLineFinish_()
			arg_306_1.onSingleLineUpdate_ = nil
			arg_306_1.onSingleLineFinish_ = nil
			arg_306_1.state_ = "waiting"
		end

		function arg_306_1.playNext_(arg_308_0)
			if arg_308_0 == 1 then
				arg_306_0:Play1108411075(arg_306_1)
			end
		end

		function arg_306_1.onSingleLineUpdate_(arg_309_0)
			if 0 < arg_306_1.time_ and arg_306_1.time_ <= 0 + arg_309_0 and not isNil(arg_306_1.actors_["10102ui_story"]) and arg_306_1.var_.characterEffect10102ui_story == nil then
				arg_306_1.var_.characterEffect10102ui_story = arg_306_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_309_0 = 0.200000002980232

			if 0 <= arg_306_1.time_ and arg_306_1.time_ < 0 + var_309_0 and not isNil(arg_306_1.actors_["10102ui_story"]) then
				if arg_306_1.var_.characterEffect10102ui_story and not isNil(arg_306_1.actors_["10102ui_story"]) then
					arg_306_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_306_1.time_ >= 0 + var_309_0 and arg_306_1.time_ < 0 + var_309_0 + arg_309_0 and not isNil(arg_306_1.actors_["10102ui_story"]) and arg_306_1.var_.characterEffect10102ui_story then
				arg_306_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_306_1.time_ and arg_306_1.time_ <= 0 + arg_309_0 then
				arg_306_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action4_1")
			end

			if 0 < arg_306_1.time_ and arg_306_1.time_ <= 0 + arg_309_0 then
				arg_306_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_deyiA", "EmotionTimelineAnimator")
			end

			local var_309_2 = 0
			local var_309_3 = 0.65

			if 0 < arg_306_1.time_ and arg_306_1.time_ <= var_309_2 + arg_309_0 then
				arg_306_1.talkMaxDuration = 0
				arg_306_1.dialogCg_.alpha = 1

				arg_306_1.dialog_:SetActive(true)
				SetActive(arg_306_1.leftNameGo_, true)

				arg_306_1.leftNameTxt_.text = arg_306_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_306_1.leftNameTxt_.transform)

				arg_306_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_306_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_306_1:RecordName(arg_306_1.leftNameTxt_.text)
				SetActive(arg_306_1.iconTrs_.gameObject, false)
				arg_306_1.callingController_:SetSelectedState("normal")

				local var_309_4 = arg_306_1:GetWordFromCfg(1108411074)
				local var_309_5 = arg_306_1:FormatText(var_309_4.content)

				arg_306_1.text_.text = var_309_5

				LuaForUtil.ClearLinePrefixSymbol(arg_306_1.text_)

				local var_309_7 = 26 <= 0 and var_309_3 or var_309_3 * (utf8.len(var_309_5) / 26)

				if (26 <= 0 and var_309_3 or var_309_3 * (utf8.len(var_309_5) / 26)) > 0 and var_309_3 < var_309_7 then
					arg_306_1.talkMaxDuration = var_309_7

					if var_309_7 + var_309_2 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_7 + var_309_2
					end
				end

				arg_306_1.text_.text = var_309_5
				arg_306_1.typewritter.percent = 0

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411074", "story_v_side_new_1108411.awb") ~= 0 then
					local var_309_8 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411074", "story_v_side_new_1108411.awb") / 1000

					if var_309_8 + var_309_2 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_8 + var_309_2
					end

					if var_309_4.prefab_name ~= "" and arg_306_1.actors_[var_309_4.prefab_name] ~= nil then
						local var_309_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_306_1.actors_[var_309_4.prefab_name].transform, "story_v_side_new_1108411", "1108411074", "story_v_side_new_1108411.awb")

						arg_306_1:RecordAudio("1108411074", var_309_9)
						arg_306_1:RecordAudio("1108411074", var_309_9)
					else
						arg_306_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411074", "story_v_side_new_1108411.awb")
					end

					arg_306_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411074", "story_v_side_new_1108411.awb")
				end

				arg_306_1:RecordContent(arg_306_1.text_.text)
			end

			local var_309_10 = math.max(var_309_3, arg_306_1.talkMaxDuration)

			if var_309_2 <= arg_306_1.time_ and arg_306_1.time_ < var_309_2 + var_309_10 then
				arg_306_1.typewritter.percent = (arg_306_1.time_ - var_309_2) / var_309_10

				arg_306_1.typewritter:SetDirty()
			end

			if arg_306_1.time_ >= var_309_2 + var_309_10 and arg_306_1.time_ < var_309_2 + var_309_10 + arg_309_0 then
				arg_306_1.typewritter.percent = 1

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(true)
			end
		end

		arg_306_1.nodeConfigList_ = {}

		arg_306_1:InitPlayNodeList()
	end,
	Play1108411075 = function(arg_310_0, arg_310_1)
		arg_310_1.time_ = 0
		arg_310_1.frameCnt_ = 0
		arg_310_1.state_ = "playing"
		arg_310_1.curTalkId_ = 1108411075
		arg_310_1.duration_ = 5

		SetActive(arg_310_1.tipsGo_, false)

		function arg_310_1.onSingleLineFinish_()
			arg_310_1.onSingleLineUpdate_ = nil
			arg_310_1.onSingleLineFinish_ = nil
			arg_310_1.state_ = "waiting"
		end

		function arg_310_1.playNext_(arg_312_0)
			if arg_312_0 == 1 then
				arg_310_0:Play1108411076(arg_310_1)
			end
		end

		function arg_310_1.onSingleLineUpdate_(arg_313_0)
			if 0 < arg_310_1.time_ and arg_310_1.time_ <= 0 + arg_313_0 and not isNil(arg_310_1.actors_["10102ui_story"]) and arg_310_1.var_.characterEffect10102ui_story == nil then
				arg_310_1.var_.characterEffect10102ui_story = arg_310_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_313_0 = 0.200000002980232

			if 0 <= arg_310_1.time_ and arg_310_1.time_ < 0 + var_313_0 and not isNil(arg_310_1.actors_["10102ui_story"]) then
				if arg_310_1.var_.characterEffect10102ui_story and not isNil(arg_310_1.actors_["10102ui_story"]) then
					arg_310_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_310_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_310_1.time_ - 0) / var_313_0)
				end
			end

			if arg_310_1.time_ >= 0 + var_313_0 and arg_310_1.time_ < 0 + var_313_0 + arg_313_0 and not isNil(arg_310_1.actors_["10102ui_story"]) and arg_310_1.var_.characterEffect10102ui_story then
				arg_310_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_310_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_313_1 = 0
			local var_313_2 = 0.35

			if 0 < arg_310_1.time_ and arg_310_1.time_ <= var_313_1 + arg_313_0 then
				arg_310_1.talkMaxDuration = 0
				arg_310_1.dialogCg_.alpha = 1

				arg_310_1.dialog_:SetActive(true)
				SetActive(arg_310_1.leftNameGo_, true)

				arg_310_1.leftNameTxt_.text = arg_310_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_310_1.leftNameTxt_.transform)

				arg_310_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_310_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_310_1:RecordName(arg_310_1.leftNameTxt_.text)
				SetActive(arg_310_1.iconTrs_.gameObject, true)
				arg_310_1.iconController_:SetSelectedState("hero")

				arg_310_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_310_1.callingController_:SetSelectedState("normal")

				arg_310_1.keyicon_.color = Color.New(1, 1, 1)
				arg_310_1.icon_.color = Color.New(1, 1, 1)

				local var_313_3 = arg_310_1:FormatText(arg_310_1:GetWordFromCfg(1108411075).content)

				arg_310_1.text_.text = var_313_3

				LuaForUtil.ClearLinePrefixSymbol(arg_310_1.text_)

				local var_313_5 = 14 <= 0 and var_313_2 or var_313_2 * (utf8.len(var_313_3) / 14)

				if (14 <= 0 and var_313_2 or var_313_2 * (utf8.len(var_313_3) / 14)) > 0 and var_313_2 < var_313_5 then
					arg_310_1.talkMaxDuration = var_313_5

					if var_313_5 + var_313_1 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_5 + var_313_1
					end
				end

				arg_310_1.text_.text = var_313_3
				arg_310_1.typewritter.percent = 0

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(false)
				arg_310_1:RecordContent(arg_310_1.text_.text)
			end

			local var_313_6 = math.max(var_313_2, arg_310_1.talkMaxDuration)

			if var_313_1 <= arg_310_1.time_ and arg_310_1.time_ < var_313_1 + var_313_6 then
				arg_310_1.typewritter.percent = (arg_310_1.time_ - var_313_1) / var_313_6

				arg_310_1.typewritter:SetDirty()
			end

			if arg_310_1.time_ >= var_313_1 + var_313_6 and arg_310_1.time_ < var_313_1 + var_313_6 + arg_313_0 then
				arg_310_1.typewritter.percent = 1

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(true)
			end
		end

		arg_310_1.nodeConfigList_ = {}

		arg_310_1:InitPlayNodeList()
	end,
	Play1108411076 = function(arg_314_0, arg_314_1)
		arg_314_1.time_ = 0
		arg_314_1.frameCnt_ = 0
		arg_314_1.state_ = "playing"
		arg_314_1.curTalkId_ = 1108411076
		arg_314_1.duration_ = 9.33

		local var_314_0 = {
			zh = 6.1,
			ja = 9.333
		}
		local var_314_1 = manager.audio:GetLocalizationFlag()

		if var_314_0[var_314_1] ~= nil then
			arg_314_1.duration_ = var_314_0[var_314_1]
		end

		SetActive(arg_314_1.tipsGo_, false)

		function arg_314_1.onSingleLineFinish_()
			arg_314_1.onSingleLineUpdate_ = nil
			arg_314_1.onSingleLineFinish_ = nil
			arg_314_1.state_ = "waiting"
		end

		function arg_314_1.playNext_(arg_316_0)
			if arg_316_0 == 1 then
				arg_314_0:Play1108411077(arg_314_1)
			end
		end

		function arg_314_1.onSingleLineUpdate_(arg_317_0)
			if 0 < arg_314_1.time_ and arg_314_1.time_ <= 0 + arg_317_0 and not isNil(arg_314_1.actors_["10102ui_story"]) and arg_314_1.var_.characterEffect10102ui_story == nil then
				arg_314_1.var_.characterEffect10102ui_story = arg_314_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_317_0 = 0.200000002980232

			if 0 <= arg_314_1.time_ and arg_314_1.time_ < 0 + var_317_0 and not isNil(arg_314_1.actors_["10102ui_story"]) then
				if arg_314_1.var_.characterEffect10102ui_story and not isNil(arg_314_1.actors_["10102ui_story"]) then
					arg_314_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_314_1.time_ >= 0 + var_317_0 and arg_314_1.time_ < 0 + var_317_0 + arg_317_0 and not isNil(arg_314_1.actors_["10102ui_story"]) and arg_314_1.var_.characterEffect10102ui_story then
				arg_314_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_314_1.time_ and arg_314_1.time_ <= 0 + arg_317_0 then
				arg_314_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			if 0 < arg_314_1.time_ and arg_314_1.time_ <= 0 + arg_317_0 then
				arg_314_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action4_2")
			end

			local var_317_2 = 0
			local var_317_3 = 0.85

			if 0 < arg_314_1.time_ and arg_314_1.time_ <= var_317_2 + arg_317_0 then
				arg_314_1.talkMaxDuration = 0
				arg_314_1.dialogCg_.alpha = 1

				arg_314_1.dialog_:SetActive(true)
				SetActive(arg_314_1.leftNameGo_, true)

				arg_314_1.leftNameTxt_.text = arg_314_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_314_1.leftNameTxt_.transform)

				arg_314_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_314_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_314_1:RecordName(arg_314_1.leftNameTxt_.text)
				SetActive(arg_314_1.iconTrs_.gameObject, false)
				arg_314_1.callingController_:SetSelectedState("normal")

				local var_317_4 = arg_314_1:GetWordFromCfg(1108411076)
				local var_317_5 = arg_314_1:FormatText(var_317_4.content)

				arg_314_1.text_.text = var_317_5

				LuaForUtil.ClearLinePrefixSymbol(arg_314_1.text_)

				local var_317_7 = 34 <= 0 and var_317_3 or var_317_3 * (utf8.len(var_317_5) / 34)

				if (34 <= 0 and var_317_3 or var_317_3 * (utf8.len(var_317_5) / 34)) > 0 and var_317_3 < var_317_7 then
					arg_314_1.talkMaxDuration = var_317_7

					if var_317_7 + var_317_2 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_7 + var_317_2
					end
				end

				arg_314_1.text_.text = var_317_5
				arg_314_1.typewritter.percent = 0

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411076", "story_v_side_new_1108411.awb") ~= 0 then
					local var_317_8 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411076", "story_v_side_new_1108411.awb") / 1000

					if var_317_8 + var_317_2 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_8 + var_317_2
					end

					if var_317_4.prefab_name ~= "" and arg_314_1.actors_[var_317_4.prefab_name] ~= nil then
						local var_317_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_314_1.actors_[var_317_4.prefab_name].transform, "story_v_side_new_1108411", "1108411076", "story_v_side_new_1108411.awb")

						arg_314_1:RecordAudio("1108411076", var_317_9)
						arg_314_1:RecordAudio("1108411076", var_317_9)
					else
						arg_314_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411076", "story_v_side_new_1108411.awb")
					end

					arg_314_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411076", "story_v_side_new_1108411.awb")
				end

				arg_314_1:RecordContent(arg_314_1.text_.text)
			end

			local var_317_10 = math.max(var_317_3, arg_314_1.talkMaxDuration)

			if var_317_2 <= arg_314_1.time_ and arg_314_1.time_ < var_317_2 + var_317_10 then
				arg_314_1.typewritter.percent = (arg_314_1.time_ - var_317_2) / var_317_10

				arg_314_1.typewritter:SetDirty()
			end

			if arg_314_1.time_ >= var_317_2 + var_317_10 and arg_314_1.time_ < var_317_2 + var_317_10 + arg_317_0 then
				arg_314_1.typewritter.percent = 1

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(true)
			end
		end

		arg_314_1.nodeConfigList_ = {}

		arg_314_1:InitPlayNodeList()
	end,
	Play1108411077 = function(arg_318_0, arg_318_1)
		arg_318_1.time_ = 0
		arg_318_1.frameCnt_ = 0
		arg_318_1.state_ = "playing"
		arg_318_1.curTalkId_ = 1108411077
		arg_318_1.duration_ = 4.4

		local var_318_0 = {
			zh = 3.333,
			ja = 4.4
		}
		local var_318_1 = manager.audio:GetLocalizationFlag()

		if var_318_0[var_318_1] ~= nil then
			arg_318_1.duration_ = var_318_0[var_318_1]
		end

		SetActive(arg_318_1.tipsGo_, false)

		function arg_318_1.onSingleLineFinish_()
			arg_318_1.onSingleLineUpdate_ = nil
			arg_318_1.onSingleLineFinish_ = nil
			arg_318_1.state_ = "waiting"
		end

		function arg_318_1.playNext_(arg_320_0)
			if arg_320_0 == 1 then
				arg_318_0:Play1108411078(arg_318_1)
			end
		end

		function arg_318_1.onSingleLineUpdate_(arg_321_0)
			local var_321_0 = 0.375

			if 0 < arg_318_1.time_ and arg_318_1.time_ <= 0 + arg_321_0 then
				arg_318_1.talkMaxDuration = 0
				arg_318_1.dialogCg_.alpha = 1

				arg_318_1.dialog_:SetActive(true)
				SetActive(arg_318_1.leftNameGo_, true)

				arg_318_1.leftNameTxt_.text = arg_318_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_318_1.leftNameTxt_.transform)

				arg_318_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_318_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_318_1:RecordName(arg_318_1.leftNameTxt_.text)
				SetActive(arg_318_1.iconTrs_.gameObject, false)
				arg_318_1.callingController_:SetSelectedState("normal")

				local var_321_1 = arg_318_1:GetWordFromCfg(1108411077)
				local var_321_2 = arg_318_1:FormatText(var_321_1.content)

				arg_318_1.text_.text = var_321_2

				LuaForUtil.ClearLinePrefixSymbol(arg_318_1.text_)

				local var_321_4 = 15 <= 0 and var_321_0 or var_321_0 * (utf8.len(var_321_2) / 15)

				if (15 <= 0 and var_321_0 or var_321_0 * (utf8.len(var_321_2) / 15)) > 0 and var_321_0 < var_321_4 then
					arg_318_1.talkMaxDuration = var_321_4

					if var_321_4 + 0 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_4 + 0
					end
				end

				arg_318_1.text_.text = var_321_2
				arg_318_1.typewritter.percent = 0

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411077", "story_v_side_new_1108411.awb") ~= 0 then
					local var_321_5 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411077", "story_v_side_new_1108411.awb") / 1000

					if var_321_5 + 0 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_5 + 0
					end

					if var_321_1.prefab_name ~= "" and arg_318_1.actors_[var_321_1.prefab_name] ~= nil then
						local var_321_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_318_1.actors_[var_321_1.prefab_name].transform, "story_v_side_new_1108411", "1108411077", "story_v_side_new_1108411.awb")

						arg_318_1:RecordAudio("1108411077", var_321_6)
						arg_318_1:RecordAudio("1108411077", var_321_6)
					else
						arg_318_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411077", "story_v_side_new_1108411.awb")
					end

					arg_318_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411077", "story_v_side_new_1108411.awb")
				end

				arg_318_1:RecordContent(arg_318_1.text_.text)
			end

			local var_321_7 = math.max(var_321_0, arg_318_1.talkMaxDuration)

			if 0 <= arg_318_1.time_ and arg_318_1.time_ < 0 + var_321_7 then
				arg_318_1.typewritter.percent = (arg_318_1.time_ - 0) / var_321_7

				arg_318_1.typewritter:SetDirty()
			end

			if arg_318_1.time_ >= 0 + var_321_7 and arg_318_1.time_ < 0 + var_321_7 + arg_321_0 then
				arg_318_1.typewritter.percent = 1

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(true)
			end
		end

		arg_318_1.nodeConfigList_ = {}

		arg_318_1:InitPlayNodeList()
	end,
	Play1108411078 = function(arg_322_0, arg_322_1)
		arg_322_1.time_ = 0
		arg_322_1.frameCnt_ = 0
		arg_322_1.state_ = "playing"
		arg_322_1.curTalkId_ = 1108411078
		arg_322_1.duration_ = 5

		SetActive(arg_322_1.tipsGo_, false)

		function arg_322_1.onSingleLineFinish_()
			arg_322_1.onSingleLineUpdate_ = nil
			arg_322_1.onSingleLineFinish_ = nil
			arg_322_1.state_ = "waiting"
		end

		function arg_322_1.playNext_(arg_324_0)
			if arg_324_0 == 1 then
				arg_322_0:Play1108411079(arg_322_1)
			end
		end

		function arg_322_1.onSingleLineUpdate_(arg_325_0)
			if 0 < arg_322_1.time_ and arg_322_1.time_ <= 0 + arg_325_0 and not isNil(arg_322_1.actors_["10102ui_story"]) and arg_322_1.var_.characterEffect10102ui_story == nil then
				arg_322_1.var_.characterEffect10102ui_story = arg_322_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_325_0 = 0.200000002980232

			if 0 <= arg_322_1.time_ and arg_322_1.time_ < 0 + var_325_0 and not isNil(arg_322_1.actors_["10102ui_story"]) then
				if arg_322_1.var_.characterEffect10102ui_story and not isNil(arg_322_1.actors_["10102ui_story"]) then
					arg_322_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_322_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_322_1.time_ - 0) / var_325_0)
				end
			end

			if arg_322_1.time_ >= 0 + var_325_0 and arg_322_1.time_ < 0 + var_325_0 + arg_325_0 and not isNil(arg_322_1.actors_["10102ui_story"]) and arg_322_1.var_.characterEffect10102ui_story then
				arg_322_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_322_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_325_1 = 0
			local var_325_2 = 0.2

			if 0 < arg_322_1.time_ and arg_322_1.time_ <= var_325_1 + arg_325_0 then
				arg_322_1.talkMaxDuration = 0
				arg_322_1.dialogCg_.alpha = 1

				arg_322_1.dialog_:SetActive(true)
				SetActive(arg_322_1.leftNameGo_, true)

				arg_322_1.leftNameTxt_.text = arg_322_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_322_1.leftNameTxt_.transform)

				arg_322_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_322_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_322_1:RecordName(arg_322_1.leftNameTxt_.text)
				SetActive(arg_322_1.iconTrs_.gameObject, true)
				arg_322_1.iconController_:SetSelectedState("hero")

				arg_322_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_322_1.callingController_:SetSelectedState("normal")

				arg_322_1.keyicon_.color = Color.New(1, 1, 1)
				arg_322_1.icon_.color = Color.New(1, 1, 1)

				local var_325_3 = arg_322_1:FormatText(arg_322_1:GetWordFromCfg(1108411078).content)

				arg_322_1.text_.text = var_325_3

				LuaForUtil.ClearLinePrefixSymbol(arg_322_1.text_)

				local var_325_5 = 8 <= 0 and var_325_2 or var_325_2 * (utf8.len(var_325_3) / 8)

				if (8 <= 0 and var_325_2 or var_325_2 * (utf8.len(var_325_3) / 8)) > 0 and var_325_2 < var_325_5 then
					arg_322_1.talkMaxDuration = var_325_5

					if var_325_5 + var_325_1 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_5 + var_325_1
					end
				end

				arg_322_1.text_.text = var_325_3
				arg_322_1.typewritter.percent = 0

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(false)
				arg_322_1:RecordContent(arg_322_1.text_.text)
			end

			local var_325_6 = math.max(var_325_2, arg_322_1.talkMaxDuration)

			if var_325_1 <= arg_322_1.time_ and arg_322_1.time_ < var_325_1 + var_325_6 then
				arg_322_1.typewritter.percent = (arg_322_1.time_ - var_325_1) / var_325_6

				arg_322_1.typewritter:SetDirty()
			end

			if arg_322_1.time_ >= var_325_1 + var_325_6 and arg_322_1.time_ < var_325_1 + var_325_6 + arg_325_0 then
				arg_322_1.typewritter.percent = 1

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(true)
			end
		end

		arg_322_1.nodeConfigList_ = {}

		arg_322_1:InitPlayNodeList()
	end,
	Play1108411079 = function(arg_326_0, arg_326_1)
		arg_326_1.time_ = 0
		arg_326_1.frameCnt_ = 0
		arg_326_1.state_ = "playing"
		arg_326_1.curTalkId_ = 1108411079
		arg_326_1.duration_ = 8.17

		local var_326_0 = {
			zh = 8.066,
			ja = 8.166
		}
		local var_326_1 = manager.audio:GetLocalizationFlag()

		if var_326_0[var_326_1] ~= nil then
			arg_326_1.duration_ = var_326_0[var_326_1]
		end

		SetActive(arg_326_1.tipsGo_, false)

		function arg_326_1.onSingleLineFinish_()
			arg_326_1.onSingleLineUpdate_ = nil
			arg_326_1.onSingleLineFinish_ = nil
			arg_326_1.state_ = "waiting"
		end

		function arg_326_1.playNext_(arg_328_0)
			if arg_328_0 == 1 then
				arg_326_0:Play1108411080(arg_326_1)
			end
		end

		function arg_326_1.onSingleLineUpdate_(arg_329_0)
			if 0 < arg_326_1.time_ and arg_326_1.time_ <= 0 + arg_329_0 and not isNil(arg_326_1.actors_["10102ui_story"]) and arg_326_1.var_.characterEffect10102ui_story == nil then
				arg_326_1.var_.characterEffect10102ui_story = arg_326_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_329_0 = 0.200000002980232

			if 0 <= arg_326_1.time_ and arg_326_1.time_ < 0 + var_329_0 and not isNil(arg_326_1.actors_["10102ui_story"]) then
				if arg_326_1.var_.characterEffect10102ui_story and not isNil(arg_326_1.actors_["10102ui_story"]) then
					arg_326_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_326_1.time_ >= 0 + var_329_0 and arg_326_1.time_ < 0 + var_329_0 + arg_329_0 and not isNil(arg_326_1.actors_["10102ui_story"]) and arg_326_1.var_.characterEffect10102ui_story then
				arg_326_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_326_1.time_ and arg_326_1.time_ <= 0 + arg_329_0 then
				arg_326_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action7_1")
			end

			if 0 < arg_326_1.time_ and arg_326_1.time_ <= 0 + arg_329_0 then
				arg_326_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_329_2 = 0
			local var_329_3 = 0.675

			if 0 < arg_326_1.time_ and arg_326_1.time_ <= var_329_2 + arg_329_0 then
				arg_326_1.talkMaxDuration = 0
				arg_326_1.dialogCg_.alpha = 1

				arg_326_1.dialog_:SetActive(true)
				SetActive(arg_326_1.leftNameGo_, true)

				arg_326_1.leftNameTxt_.text = arg_326_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_326_1.leftNameTxt_.transform)

				arg_326_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_326_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_326_1:RecordName(arg_326_1.leftNameTxt_.text)
				SetActive(arg_326_1.iconTrs_.gameObject, false)
				arg_326_1.callingController_:SetSelectedState("normal")

				local var_329_4 = arg_326_1:GetWordFromCfg(1108411079)
				local var_329_5 = arg_326_1:FormatText(var_329_4.content)

				arg_326_1.text_.text = var_329_5

				LuaForUtil.ClearLinePrefixSymbol(arg_326_1.text_)

				local var_329_7 = 27 <= 0 and var_329_3 or var_329_3 * (utf8.len(var_329_5) / 27)

				if (27 <= 0 and var_329_3 or var_329_3 * (utf8.len(var_329_5) / 27)) > 0 and var_329_3 < var_329_7 then
					arg_326_1.talkMaxDuration = var_329_7

					if var_329_7 + var_329_2 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_7 + var_329_2
					end
				end

				arg_326_1.text_.text = var_329_5
				arg_326_1.typewritter.percent = 0

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411079", "story_v_side_new_1108411.awb") ~= 0 then
					local var_329_8 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411079", "story_v_side_new_1108411.awb") / 1000

					if var_329_8 + var_329_2 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_8 + var_329_2
					end

					if var_329_4.prefab_name ~= "" and arg_326_1.actors_[var_329_4.prefab_name] ~= nil then
						local var_329_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_326_1.actors_[var_329_4.prefab_name].transform, "story_v_side_new_1108411", "1108411079", "story_v_side_new_1108411.awb")

						arg_326_1:RecordAudio("1108411079", var_329_9)
						arg_326_1:RecordAudio("1108411079", var_329_9)
					else
						arg_326_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411079", "story_v_side_new_1108411.awb")
					end

					arg_326_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411079", "story_v_side_new_1108411.awb")
				end

				arg_326_1:RecordContent(arg_326_1.text_.text)
			end

			local var_329_10 = math.max(var_329_3, arg_326_1.talkMaxDuration)

			if var_329_2 <= arg_326_1.time_ and arg_326_1.time_ < var_329_2 + var_329_10 then
				arg_326_1.typewritter.percent = (arg_326_1.time_ - var_329_2) / var_329_10

				arg_326_1.typewritter:SetDirty()
			end

			if arg_326_1.time_ >= var_329_2 + var_329_10 and arg_326_1.time_ < var_329_2 + var_329_10 + arg_329_0 then
				arg_326_1.typewritter.percent = 1

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(true)
			end
		end

		arg_326_1.nodeConfigList_ = {}

		arg_326_1:InitPlayNodeList()
	end,
	Play1108411080 = function(arg_330_0, arg_330_1)
		arg_330_1.time_ = 0
		arg_330_1.frameCnt_ = 0
		arg_330_1.state_ = "playing"
		arg_330_1.curTalkId_ = 1108411080
		arg_330_1.duration_ = 5

		SetActive(arg_330_1.tipsGo_, false)

		function arg_330_1.onSingleLineFinish_()
			arg_330_1.onSingleLineUpdate_ = nil
			arg_330_1.onSingleLineFinish_ = nil
			arg_330_1.state_ = "waiting"
		end

		function arg_330_1.playNext_(arg_332_0)
			if arg_332_0 == 1 then
				arg_330_0:Play1108411081(arg_330_1)
			end
		end

		function arg_330_1.onSingleLineUpdate_(arg_333_0)
			if 0 < arg_330_1.time_ and arg_330_1.time_ <= 0 + arg_333_0 and not isNil(arg_330_1.actors_["10102ui_story"]) and arg_330_1.var_.characterEffect10102ui_story == nil then
				arg_330_1.var_.characterEffect10102ui_story = arg_330_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_333_0 = 0.200000002980232

			if 0 <= arg_330_1.time_ and arg_330_1.time_ < 0 + var_333_0 and not isNil(arg_330_1.actors_["10102ui_story"]) then
				if arg_330_1.var_.characterEffect10102ui_story and not isNil(arg_330_1.actors_["10102ui_story"]) then
					arg_330_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_330_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_330_1.time_ - 0) / var_333_0)
				end
			end

			if arg_330_1.time_ >= 0 + var_333_0 and arg_330_1.time_ < 0 + var_333_0 + arg_333_0 and not isNil(arg_330_1.actors_["10102ui_story"]) and arg_330_1.var_.characterEffect10102ui_story then
				arg_330_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_330_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_333_1 = 0
			local var_333_2 = 0.925

			if 0 < arg_330_1.time_ and arg_330_1.time_ <= var_333_1 + arg_333_0 then
				arg_330_1.talkMaxDuration = 0
				arg_330_1.dialogCg_.alpha = 1

				arg_330_1.dialog_:SetActive(true)
				SetActive(arg_330_1.leftNameGo_, false)

				arg_330_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_330_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_330_1:RecordName(arg_330_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_330_1.iconTrs_.gameObject, false)
				arg_330_1.callingController_:SetSelectedState("normal")

				local var_333_3 = arg_330_1:FormatText(arg_330_1:GetWordFromCfg(1108411080).content)

				arg_330_1.text_.text = var_333_3

				LuaForUtil.ClearLinePrefixSymbol(arg_330_1.text_)

				local var_333_5 = 37 <= 0 and var_333_2 or var_333_2 * (utf8.len(var_333_3) / 37)

				if (37 <= 0 and var_333_2 or var_333_2 * (utf8.len(var_333_3) / 37)) > 0 and var_333_2 < var_333_5 then
					arg_330_1.talkMaxDuration = var_333_5

					if var_333_5 + var_333_1 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_5 + var_333_1
					end
				end

				arg_330_1.text_.text = var_333_3
				arg_330_1.typewritter.percent = 0

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(false)
				arg_330_1:RecordContent(arg_330_1.text_.text)
			end

			local var_333_6 = math.max(var_333_2, arg_330_1.talkMaxDuration)

			if var_333_1 <= arg_330_1.time_ and arg_330_1.time_ < var_333_1 + var_333_6 then
				arg_330_1.typewritter.percent = (arg_330_1.time_ - var_333_1) / var_333_6

				arg_330_1.typewritter:SetDirty()
			end

			if arg_330_1.time_ >= var_333_1 + var_333_6 and arg_330_1.time_ < var_333_1 + var_333_6 + arg_333_0 then
				arg_330_1.typewritter.percent = 1

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(true)
			end
		end

		arg_330_1.nodeConfigList_ = {}

		arg_330_1:InitPlayNodeList()
	end,
	Play1108411081 = function(arg_334_0, arg_334_1)
		arg_334_1.time_ = 0
		arg_334_1.frameCnt_ = 0
		arg_334_1.state_ = "playing"
		arg_334_1.curTalkId_ = 1108411081
		arg_334_1.duration_ = 2.33

		local var_334_0 = {
			zh = 2.3,
			ja = 2.333
		}
		local var_334_1 = manager.audio:GetLocalizationFlag()

		if var_334_0[var_334_1] ~= nil then
			arg_334_1.duration_ = var_334_0[var_334_1]
		end

		SetActive(arg_334_1.tipsGo_, false)

		function arg_334_1.onSingleLineFinish_()
			arg_334_1.onSingleLineUpdate_ = nil
			arg_334_1.onSingleLineFinish_ = nil
			arg_334_1.state_ = "waiting"
		end

		function arg_334_1.playNext_(arg_336_0)
			if arg_336_0 == 1 then
				arg_334_0:Play1108411082(arg_334_1)
			end
		end

		function arg_334_1.onSingleLineUpdate_(arg_337_0)
			if 0 < arg_334_1.time_ and arg_334_1.time_ <= 0 + arg_337_0 and not isNil(arg_334_1.actors_["10102ui_story"]) and arg_334_1.var_.characterEffect10102ui_story == nil then
				arg_334_1.var_.characterEffect10102ui_story = arg_334_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_337_0 = 0.200000002980232

			if 0 <= arg_334_1.time_ and arg_334_1.time_ < 0 + var_337_0 and not isNil(arg_334_1.actors_["10102ui_story"]) then
				if arg_334_1.var_.characterEffect10102ui_story and not isNil(arg_334_1.actors_["10102ui_story"]) then
					arg_334_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_334_1.time_ >= 0 + var_337_0 and arg_334_1.time_ < 0 + var_337_0 + arg_337_0 and not isNil(arg_334_1.actors_["10102ui_story"]) and arg_334_1.var_.characterEffect10102ui_story then
				arg_334_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_334_1.time_ and arg_334_1.time_ <= 0 + arg_337_0 then
				arg_334_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileC_biyan", "EmotionTimelineAnimator")
			end

			local var_337_2 = 0
			local var_337_3 = 0.175

			if 0 < arg_334_1.time_ and arg_334_1.time_ <= var_337_2 + arg_337_0 then
				arg_334_1.talkMaxDuration = 0
				arg_334_1.dialogCg_.alpha = 1

				arg_334_1.dialog_:SetActive(true)
				SetActive(arg_334_1.leftNameGo_, true)

				arg_334_1.leftNameTxt_.text = arg_334_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_334_1.leftNameTxt_.transform)

				arg_334_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_334_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_334_1:RecordName(arg_334_1.leftNameTxt_.text)
				SetActive(arg_334_1.iconTrs_.gameObject, false)
				arg_334_1.callingController_:SetSelectedState("normal")

				local var_337_4 = arg_334_1:GetWordFromCfg(1108411081)
				local var_337_5 = arg_334_1:FormatText(var_337_4.content)

				arg_334_1.text_.text = var_337_5

				LuaForUtil.ClearLinePrefixSymbol(arg_334_1.text_)

				local var_337_7 = 7 <= 0 and var_337_3 or var_337_3 * (utf8.len(var_337_5) / 7)

				if (7 <= 0 and var_337_3 or var_337_3 * (utf8.len(var_337_5) / 7)) > 0 and var_337_3 < var_337_7 then
					arg_334_1.talkMaxDuration = var_337_7

					if var_337_7 + var_337_2 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_7 + var_337_2
					end
				end

				arg_334_1.text_.text = var_337_5
				arg_334_1.typewritter.percent = 0

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411081", "story_v_side_new_1108411.awb") ~= 0 then
					local var_337_8 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411081", "story_v_side_new_1108411.awb") / 1000

					if var_337_8 + var_337_2 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_8 + var_337_2
					end

					if var_337_4.prefab_name ~= "" and arg_334_1.actors_[var_337_4.prefab_name] ~= nil then
						local var_337_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_334_1.actors_[var_337_4.prefab_name].transform, "story_v_side_new_1108411", "1108411081", "story_v_side_new_1108411.awb")

						arg_334_1:RecordAudio("1108411081", var_337_9)
						arg_334_1:RecordAudio("1108411081", var_337_9)
					else
						arg_334_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411081", "story_v_side_new_1108411.awb")
					end

					arg_334_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411081", "story_v_side_new_1108411.awb")
				end

				arg_334_1:RecordContent(arg_334_1.text_.text)
			end

			local var_337_10 = math.max(var_337_3, arg_334_1.talkMaxDuration)

			if var_337_2 <= arg_334_1.time_ and arg_334_1.time_ < var_337_2 + var_337_10 then
				arg_334_1.typewritter.percent = (arg_334_1.time_ - var_337_2) / var_337_10

				arg_334_1.typewritter:SetDirty()
			end

			if arg_334_1.time_ >= var_337_2 + var_337_10 and arg_334_1.time_ < var_337_2 + var_337_10 + arg_337_0 then
				arg_334_1.typewritter.percent = 1

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(true)
			end
		end

		arg_334_1.nodeConfigList_ = {}

		arg_334_1:InitPlayNodeList()
	end,
	Play1108411082 = function(arg_338_0, arg_338_1)
		arg_338_1.time_ = 0
		arg_338_1.frameCnt_ = 0
		arg_338_1.state_ = "playing"
		arg_338_1.curTalkId_ = 1108411082
		arg_338_1.duration_ = 8.77

		SetActive(arg_338_1.tipsGo_, false)

		function arg_338_1.onSingleLineFinish_()
			arg_338_1.onSingleLineUpdate_ = nil
			arg_338_1.onSingleLineFinish_ = nil
			arg_338_1.state_ = "waiting"
		end

		function arg_338_1.playNext_(arg_340_0)
			if arg_340_0 == 1 then
				arg_338_0:Play1108411083(arg_338_1)
			end
		end

		function arg_338_1.onSingleLineUpdate_(arg_341_0)
			if arg_338_1.bgs_.I18f == nil then
				local var_341_0 = Object.Instantiate(arg_338_1.paintGo_)

				var_341_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I18f")
				var_341_0.name = "I18f"
				var_341_0.transform.parent = arg_338_1.stage_.transform
				var_341_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_338_1.bgs_.I18f = var_341_0
			end

			if 1.999999999999 < arg_338_1.time_ and arg_338_1.time_ <= 1.999999999999 + arg_341_0 then
				local var_341_1 = arg_338_1.bgs_.I18f

				arg_338_1.bgs_.I18f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_341_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_341_2 = var_341_1:GetComponent("SpriteRenderer")

				if var_341_2 and var_341_2.sprite then
					local var_341_3 = 2 * (var_341_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_341_1.transform.localScale = Vector3.New(var_341_3 / var_341_2.sprite.bounds.size.y < var_341_3 * manager.ui.mainCameraCom_.aspect / var_341_2.sprite.bounds.size.x and var_341_3 * manager.ui.mainCameraCom_.aspect / var_341_2.sprite.bounds.size.x or var_341_3 / var_341_2.sprite.bounds.size.y, var_341_3 / var_341_2.sprite.bounds.size.y < var_341_3 * manager.ui.mainCameraCom_.aspect / var_341_2.sprite.bounds.size.x and var_341_3 * manager.ui.mainCameraCom_.aspect / var_341_2.sprite.bounds.size.x or var_341_3 / var_341_2.sprite.bounds.size.y, 0)
				end

				for iter_341_0, iter_341_1 in pairs(arg_338_1.bgs_) do
					if iter_341_0 ~= "I18f" then
						iter_341_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_341_4 = 0

			if 0 < arg_338_1.time_ and arg_338_1.time_ <= var_341_4 + arg_341_0 then
				arg_338_1.allBtn_.enabled = false
			end

			if arg_338_1.time_ >= var_341_4 + 0.3 and arg_338_1.time_ < var_341_4 + 0.3 + arg_341_0 then
				arg_338_1.allBtn_.enabled = true
			end

			local var_341_5 = 0

			if 0 < arg_338_1.time_ and arg_338_1.time_ <= var_341_5 + arg_341_0 then
				arg_338_1.mask_.enabled = true
				arg_338_1.mask_.raycastTarget = true

				arg_338_1:SetGaussion(false)
			end

			local var_341_6 = 2

			if var_341_5 <= arg_338_1.time_ and arg_338_1.time_ < var_341_5 + var_341_6 then
				local var_341_7 = Color.New(0, 0, 0)

				var_341_7.a = Mathf.Lerp(0, 1, (arg_338_1.time_ - var_341_5) / var_341_6)
				arg_338_1.mask_.color = var_341_7
			end

			if arg_338_1.time_ >= var_341_5 + var_341_6 and arg_338_1.time_ < var_341_5 + var_341_6 + arg_341_0 then
				local var_341_8 = Color.New(0, 0, 0)

				var_341_8.a = 1
				arg_338_1.mask_.color = var_341_8
			end

			local var_341_9 = 2

			if 2 < arg_338_1.time_ and arg_338_1.time_ <= var_341_9 + arg_341_0 then
				arg_338_1.mask_.enabled = true
				arg_338_1.mask_.raycastTarget = true

				arg_338_1:SetGaussion(false)
			end

			local var_341_10 = 2

			if var_341_9 <= arg_338_1.time_ and arg_338_1.time_ < var_341_9 + var_341_10 then
				local var_341_11 = Color.New(0, 0, 0)

				var_341_11.a = Mathf.Lerp(1, 0, (arg_338_1.time_ - var_341_9) / var_341_10)
				arg_338_1.mask_.color = var_341_11
			end

			if arg_338_1.time_ >= var_341_9 + var_341_10 and arg_338_1.time_ < var_341_9 + var_341_10 + arg_341_0 then
				local var_341_12 = Color.New(0, 0, 0)

				arg_338_1.mask_.enabled = false
				var_341_12.a = 0
				arg_338_1.mask_.color = var_341_12
			end

			local var_341_13 = arg_338_1.actors_["10102ui_story"].transform

			if 1.96599999815126 < arg_338_1.time_ and arg_338_1.time_ <= 1.96599999815126 + arg_341_0 then
				arg_338_1.var_.moveOldPos10102ui_story = var_341_13.localPosition
			end

			local var_341_14 = 0.001

			if 1.96599999815126 <= arg_338_1.time_ and arg_338_1.time_ < 1.96599999815126 + var_341_14 then
				var_341_13.localPosition = Vector3.Lerp(arg_338_1.var_.moveOldPos10102ui_story, Vector3.New(0, 100, 0), (arg_338_1.time_ - 1.96599999815126) / var_341_14)
				var_341_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_341_13.position).x, (manager.ui.mainCamera.transform.position - var_341_13.position).y, (manager.ui.mainCamera.transform.position - var_341_13.position).z)
				var_341_13.localEulerAngles.z = 0
				var_341_13.localEulerAngles.x = 0
				var_341_13.localEulerAngles = var_341_13.localEulerAngles
			end

			if arg_338_1.time_ >= 1.96599999815126 + var_341_14 and arg_338_1.time_ < 1.96599999815126 + var_341_14 + arg_341_0 then
				var_341_13.localPosition = Vector3.New(0, 100, 0)
				var_341_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_341_13.position).x, (manager.ui.mainCamera.transform.position - var_341_13.position).y, (manager.ui.mainCamera.transform.position - var_341_13.position).z)
				var_341_13.localEulerAngles.z = 0
				var_341_13.localEulerAngles.x = 0
				var_341_13.localEulerAngles = var_341_13.localEulerAngles
			end

			if 0.166666666666667 < arg_338_1.time_ and arg_338_1.time_ <= 0.166666666666667 + arg_341_0 then
				arg_338_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_341_17 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_338_1.bgmTxt_.text ~= var_341_17 and arg_338_1.bgmTxt_.text ~= "" then
						if arg_338_1.bgmTxt2_.text ~= "" then
							arg_338_1.bgmTxt_.text = arg_338_1.bgmTxt2_.text
						end

						arg_338_1.bgmTxt2_.text = var_341_17

						arg_338_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_338_1.bgmTxt_.text = var_341_17
						arg_338_1.bgmTxt2_.text = var_341_17
					end

					if arg_338_1.bgmTimer then
						arg_338_1.bgmTimer:Stop()

						arg_338_1.bgmTimer = nil
					end

					if arg_338_1.settingData.show_music_name == 1 then
						arg_338_1.musicController:SetSelectedState("show")
						arg_338_1.musicAnimator_:Play("open", 0, 0)

						if arg_338_1.settingData.music_time ~= 0 then
							arg_338_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_338_1.settingData.music_time), function()
								if arg_338_1 == nil or isNil(arg_338_1.bgmTxt_) then
									return
								end

								arg_338_1.musicController:SetSelectedState("hide")
								arg_338_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 1.63333333333333 < arg_338_1.time_ and arg_338_1.time_ <= 1.63333333333333 + arg_341_0 then
				arg_338_1:AudioAction("play", "music", "bgm_activity_3_0_story_daily_quiet", "bgm_activity_3_0_story_daily_quiet", "bgm_activity_3_0_story_daily_quiet.awb")

				local var_341_20 = manager.audio:GetAudioName("bgm_activity_3_0_story_daily_quiet", "bgm_activity_3_0_story_daily_quiet")

				if "" ~= "" then
					if arg_338_1.bgmTxt_.text ~= var_341_20 and arg_338_1.bgmTxt_.text ~= "" then
						if arg_338_1.bgmTxt2_.text ~= "" then
							arg_338_1.bgmTxt_.text = arg_338_1.bgmTxt2_.text
						end

						arg_338_1.bgmTxt2_.text = var_341_20

						arg_338_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_338_1.bgmTxt_.text = var_341_20
						arg_338_1.bgmTxt2_.text = var_341_20
					end

					if arg_338_1.bgmTimer then
						arg_338_1.bgmTimer:Stop()

						arg_338_1.bgmTimer = nil
					end

					if arg_338_1.settingData.show_music_name == 1 then
						arg_338_1.musicController:SetSelectedState("show")
						arg_338_1.musicAnimator_:Play("open", 0, 0)

						if arg_338_1.settingData.music_time ~= 0 then
							arg_338_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_338_1.settingData.music_time), function()
								if arg_338_1 == nil or isNil(arg_338_1.bgmTxt_) then
									return
								end

								arg_338_1.musicController:SetSelectedState("hide")
								arg_338_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 1.63333333333333 < arg_338_1.time_ and arg_338_1.time_ <= 1.63333333333333 + arg_341_0 then
				arg_338_1:AudioAction("play", "effect", "se_story_1210", "se_story_1210_morning_loop", "")
			end

			if 0.166666666666667 < arg_338_1.time_ and arg_338_1.time_ <= 0.166666666666667 + arg_341_0 then
				arg_338_1:AudioAction("stop", "effect", "se_story_side_1068", "se_story_1068_restaurant", "")
			end

			if arg_338_1.frameCnt_ <= 1 then
				arg_338_1.dialog_:SetActive(false)
			end

			local var_341_23 = 3.774999999999
			local var_341_24 = 0.225

			if 3.774999999999 < arg_338_1.time_ and arg_338_1.time_ <= var_341_23 + arg_341_0 then
				arg_338_1.talkMaxDuration = 0

				arg_338_1.dialog_:SetActive(true)

				arg_338_1.dialogCg_.alpha = 0

				local var_341_25 = LeanTween.value(arg_338_1.dialog_, 0, 1, 0.3)

				var_341_25:setOnUpdate(LuaHelper.FloatAction(function(arg_344_0)
					arg_338_1.dialogCg_.alpha = arg_344_0
				end))
				var_341_25:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_338_1.dialog_)
					var_341_25:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_338_1.duration_ = arg_338_1.duration_ + 0.3

				SetActive(arg_338_1.leftNameGo_, true)

				arg_338_1.leftNameTxt_.text = arg_338_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_338_1.leftNameTxt_.transform)

				arg_338_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_338_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_338_1:RecordName(arg_338_1.leftNameTxt_.text)
				SetActive(arg_338_1.iconTrs_.gameObject, true)
				arg_338_1.iconController_:SetSelectedState("hero")

				arg_338_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_338_1.callingController_:SetSelectedState("normal")

				arg_338_1.keyicon_.color = Color.New(1, 1, 1)
				arg_338_1.icon_.color = Color.New(1, 1, 1)

				local var_341_26 = arg_338_1:FormatText(arg_338_1:GetWordFromCfg(1108411082).content)

				arg_338_1.text_.text = var_341_26

				LuaForUtil.ClearLinePrefixSymbol(arg_338_1.text_)

				local var_341_28 = 9 <= 0 and var_341_24 or var_341_24 * (utf8.len(var_341_26) / 9)

				if (9 <= 0 and var_341_24 or var_341_24 * (utf8.len(var_341_26) / 9)) > 0 and var_341_24 < var_341_28 then
					arg_338_1.talkMaxDuration = var_341_28
					var_341_23 = var_341_23 + 0.3

					if var_341_28 + var_341_23 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_28 + var_341_23
					end
				end

				arg_338_1.text_.text = var_341_26
				arg_338_1.typewritter.percent = 0

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(false)
				arg_338_1:RecordContent(arg_338_1.text_.text)
			end

			local var_341_29 = var_341_23 + 0.3
			local var_341_30 = math.max(var_341_24, arg_338_1.talkMaxDuration)

			if var_341_23 + 0.3 <= arg_338_1.time_ and arg_338_1.time_ < var_341_29 + var_341_30 then
				arg_338_1.typewritter.percent = (arg_338_1.time_ - var_341_29) / var_341_30

				arg_338_1.typewritter:SetDirty()
			end

			if arg_338_1.time_ >= var_341_29 + var_341_30 and arg_338_1.time_ < var_341_29 + var_341_30 + arg_341_0 then
				arg_338_1.typewritter.percent = 1

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(true)
			end
		end

		arg_338_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815126,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_338_1:InitPlayNodeList()
	end,
	Play1108411083 = function(arg_346_0, arg_346_1)
		arg_346_1.time_ = 0
		arg_346_1.frameCnt_ = 0
		arg_346_1.state_ = "playing"
		arg_346_1.curTalkId_ = 1108411083
		arg_346_1.duration_ = 5

		SetActive(arg_346_1.tipsGo_, false)

		function arg_346_1.onSingleLineFinish_()
			arg_346_1.onSingleLineUpdate_ = nil
			arg_346_1.onSingleLineFinish_ = nil
			arg_346_1.state_ = "waiting"
		end

		function arg_346_1.playNext_(arg_348_0)
			if arg_348_0 == 1 then
				arg_346_0:Play1108411084(arg_346_1)
			end
		end

		function arg_346_1.onSingleLineUpdate_(arg_349_0)
			if 0.0946596038993449 < arg_346_1.time_ and arg_346_1.time_ <= 0.0946596038993449 + arg_349_0 then
				arg_346_1:AudioAction("play", "effect", "se_story_side_128402", "se_story_side_128402_wind", "")
			end

			local var_349_1 = 0
			local var_349_2 = 1.525

			if 0 < arg_346_1.time_ and arg_346_1.time_ <= var_349_1 + arg_349_0 then
				arg_346_1.talkMaxDuration = 0
				arg_346_1.dialogCg_.alpha = 1

				arg_346_1.dialog_:SetActive(true)
				SetActive(arg_346_1.leftNameGo_, false)

				arg_346_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_346_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_346_1:RecordName(arg_346_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_346_1.iconTrs_.gameObject, false)
				arg_346_1.callingController_:SetSelectedState("normal")

				local var_349_3 = arg_346_1:FormatText(arg_346_1:GetWordFromCfg(1108411083).content)

				arg_346_1.text_.text = var_349_3

				LuaForUtil.ClearLinePrefixSymbol(arg_346_1.text_)

				local var_349_5 = 61 <= 0 and var_349_2 or var_349_2 * (utf8.len(var_349_3) / 61)

				if (61 <= 0 and var_349_2 or var_349_2 * (utf8.len(var_349_3) / 61)) > 0 and var_349_2 < var_349_5 then
					arg_346_1.talkMaxDuration = var_349_5

					if var_349_5 + var_349_1 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_5 + var_349_1
					end
				end

				arg_346_1.text_.text = var_349_3
				arg_346_1.typewritter.percent = 0

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(false)
				arg_346_1:RecordContent(arg_346_1.text_.text)
			end

			local var_349_6 = math.max(var_349_2, arg_346_1.talkMaxDuration)

			if var_349_1 <= arg_346_1.time_ and arg_346_1.time_ < var_349_1 + var_349_6 then
				arg_346_1.typewritter.percent = (arg_346_1.time_ - var_349_1) / var_349_6

				arg_346_1.typewritter:SetDirty()
			end

			if arg_346_1.time_ >= var_349_1 + var_349_6 and arg_346_1.time_ < var_349_1 + var_349_6 + arg_349_0 then
				arg_346_1.typewritter.percent = 1

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(true)
			end
		end

		arg_346_1.nodeConfigList_ = {}

		arg_346_1:InitPlayNodeList()
	end,
	Play1108411084 = function(arg_350_0, arg_350_1)
		arg_350_1.time_ = 0
		arg_350_1.frameCnt_ = 0
		arg_350_1.state_ = "playing"
		arg_350_1.curTalkId_ = 1108411084
		arg_350_1.duration_ = 5

		SetActive(arg_350_1.tipsGo_, false)

		function arg_350_1.onSingleLineFinish_()
			arg_350_1.onSingleLineUpdate_ = nil
			arg_350_1.onSingleLineFinish_ = nil
			arg_350_1.state_ = "waiting"
		end

		function arg_350_1.playNext_(arg_352_0)
			if arg_352_0 == 1 then
				arg_350_0:Play1108411085(arg_350_1)
			end
		end

		function arg_350_1.onSingleLineUpdate_(arg_353_0)
			local var_353_0 = 1.5

			if 0 < arg_350_1.time_ and arg_350_1.time_ <= 0 + arg_353_0 then
				arg_350_1.talkMaxDuration = 0
				arg_350_1.dialogCg_.alpha = 1

				arg_350_1.dialog_:SetActive(true)
				SetActive(arg_350_1.leftNameGo_, false)

				arg_350_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_350_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_350_1:RecordName(arg_350_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_350_1.iconTrs_.gameObject, false)
				arg_350_1.callingController_:SetSelectedState("normal")

				local var_353_1 = arg_350_1:FormatText(arg_350_1:GetWordFromCfg(1108411084).content)

				arg_350_1.text_.text = var_353_1

				LuaForUtil.ClearLinePrefixSymbol(arg_350_1.text_)

				local var_353_3 = 60 <= 0 and var_353_0 or var_353_0 * (utf8.len(var_353_1) / 60)

				if (60 <= 0 and var_353_0 or var_353_0 * (utf8.len(var_353_1) / 60)) > 0 and var_353_0 < var_353_3 then
					arg_350_1.talkMaxDuration = var_353_3

					if var_353_3 + 0 > arg_350_1.duration_ then
						arg_350_1.duration_ = var_353_3 + 0
					end
				end

				arg_350_1.text_.text = var_353_1
				arg_350_1.typewritter.percent = 0

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(false)
				arg_350_1:RecordContent(arg_350_1.text_.text)
			end

			local var_353_4 = math.max(var_353_0, arg_350_1.talkMaxDuration)

			if 0 <= arg_350_1.time_ and arg_350_1.time_ < 0 + var_353_4 then
				arg_350_1.typewritter.percent = (arg_350_1.time_ - 0) / var_353_4

				arg_350_1.typewritter:SetDirty()
			end

			if arg_350_1.time_ >= 0 + var_353_4 and arg_350_1.time_ < 0 + var_353_4 + arg_353_0 then
				arg_350_1.typewritter.percent = 1

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(true)
			end
		end

		arg_350_1.nodeConfigList_ = {}

		arg_350_1:InitPlayNodeList()
	end,
	Play1108411085 = function(arg_354_0, arg_354_1)
		arg_354_1.time_ = 0
		arg_354_1.frameCnt_ = 0
		arg_354_1.state_ = "playing"
		arg_354_1.curTalkId_ = 1108411085
		arg_354_1.duration_ = 9.7

		local var_354_0 = {
			zh = 8.333,
			ja = 9.7
		}
		local var_354_1 = manager.audio:GetLocalizationFlag()

		if var_354_0[var_354_1] ~= nil then
			arg_354_1.duration_ = var_354_0[var_354_1]
		end

		SetActive(arg_354_1.tipsGo_, false)

		function arg_354_1.onSingleLineFinish_()
			arg_354_1.onSingleLineUpdate_ = nil
			arg_354_1.onSingleLineFinish_ = nil
			arg_354_1.state_ = "waiting"
		end

		function arg_354_1.playNext_(arg_356_0)
			if arg_356_0 == 1 then
				arg_354_0:Play1108411086(arg_354_1)
			end
		end

		function arg_354_1.onSingleLineUpdate_(arg_357_0)
			if 0 < arg_354_1.time_ and arg_354_1.time_ <= 0 + arg_357_0 and not isNil(arg_354_1.actors_["10102ui_story"]) and arg_354_1.var_.characterEffect10102ui_story == nil then
				arg_354_1.var_.characterEffect10102ui_story = arg_354_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_357_0 = 0.200000002980232

			if 0 <= arg_354_1.time_ and arg_354_1.time_ < 0 + var_357_0 and not isNil(arg_354_1.actors_["10102ui_story"]) then
				if arg_354_1.var_.characterEffect10102ui_story and not isNil(arg_354_1.actors_["10102ui_story"]) then
					arg_354_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_354_1.time_ >= 0 + var_357_0 and arg_354_1.time_ < 0 + var_357_0 + arg_357_0 and not isNil(arg_354_1.actors_["10102ui_story"]) and arg_354_1.var_.characterEffect10102ui_story then
				arg_354_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_354_1.time_ and arg_354_1.time_ <= 0 + arg_357_0 then
				arg_354_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action1_1")
			end

			if 0 < arg_354_1.time_ and arg_354_1.time_ <= 0 + arg_357_0 then
				arg_354_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_357_2 = arg_354_1.actors_["10102ui_story"].transform

			if 0 < arg_354_1.time_ and arg_354_1.time_ <= 0 + arg_357_0 then
				arg_354_1.var_.moveOldPos10102ui_story = var_357_2.localPosition
			end

			local var_357_3 = 0.001

			if 0 <= arg_354_1.time_ and arg_354_1.time_ < 0 + var_357_3 then
				var_357_2.localPosition = Vector3.Lerp(arg_354_1.var_.moveOldPos10102ui_story, Vector3.New(0, -0.985, -6.275), (arg_354_1.time_ - 0) / var_357_3)
				var_357_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_357_2.position).x, (manager.ui.mainCamera.transform.position - var_357_2.position).y, (manager.ui.mainCamera.transform.position - var_357_2.position).z)
				var_357_2.localEulerAngles.z = 0
				var_357_2.localEulerAngles.x = 0
				var_357_2.localEulerAngles = var_357_2.localEulerAngles
			end

			if arg_354_1.time_ >= 0 + var_357_3 and arg_354_1.time_ < 0 + var_357_3 + arg_357_0 then
				var_357_2.localPosition = Vector3.New(0, -0.985, -6.275)
				var_357_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_357_2.position).x, (manager.ui.mainCamera.transform.position - var_357_2.position).y, (manager.ui.mainCamera.transform.position - var_357_2.position).z)
				var_357_2.localEulerAngles.z = 0
				var_357_2.localEulerAngles.x = 0
				var_357_2.localEulerAngles = var_357_2.localEulerAngles
			end

			local var_357_4 = 0
			local var_357_5 = 1.05

			if 0 < arg_354_1.time_ and arg_354_1.time_ <= var_357_4 + arg_357_0 then
				arg_354_1.talkMaxDuration = 0
				arg_354_1.dialogCg_.alpha = 1

				arg_354_1.dialog_:SetActive(true)
				SetActive(arg_354_1.leftNameGo_, true)

				arg_354_1.leftNameTxt_.text = arg_354_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_354_1.leftNameTxt_.transform)

				arg_354_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_354_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_354_1:RecordName(arg_354_1.leftNameTxt_.text)
				SetActive(arg_354_1.iconTrs_.gameObject, false)
				arg_354_1.callingController_:SetSelectedState("normal")

				local var_357_6 = arg_354_1:GetWordFromCfg(1108411085)
				local var_357_7 = arg_354_1:FormatText(var_357_6.content)

				arg_354_1.text_.text = var_357_7

				LuaForUtil.ClearLinePrefixSymbol(arg_354_1.text_)

				local var_357_9 = 42 <= 0 and var_357_5 or var_357_5 * (utf8.len(var_357_7) / 42)

				if (42 <= 0 and var_357_5 or var_357_5 * (utf8.len(var_357_7) / 42)) > 0 and var_357_5 < var_357_9 then
					arg_354_1.talkMaxDuration = var_357_9

					if var_357_9 + var_357_4 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_9 + var_357_4
					end
				end

				arg_354_1.text_.text = var_357_7
				arg_354_1.typewritter.percent = 0

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411085", "story_v_side_new_1108411.awb") ~= 0 then
					local var_357_10 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411085", "story_v_side_new_1108411.awb") / 1000

					if var_357_10 + var_357_4 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_10 + var_357_4
					end

					if var_357_6.prefab_name ~= "" and arg_354_1.actors_[var_357_6.prefab_name] ~= nil then
						local var_357_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_354_1.actors_[var_357_6.prefab_name].transform, "story_v_side_new_1108411", "1108411085", "story_v_side_new_1108411.awb")

						arg_354_1:RecordAudio("1108411085", var_357_11)
						arg_354_1:RecordAudio("1108411085", var_357_11)
					else
						arg_354_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411085", "story_v_side_new_1108411.awb")
					end

					arg_354_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411085", "story_v_side_new_1108411.awb")
				end

				arg_354_1:RecordContent(arg_354_1.text_.text)
			end

			local var_357_12 = math.max(var_357_5, arg_354_1.talkMaxDuration)

			if var_357_4 <= arg_354_1.time_ and arg_354_1.time_ < var_357_4 + var_357_12 then
				arg_354_1.typewritter.percent = (arg_354_1.time_ - var_357_4) / var_357_12

				arg_354_1.typewritter:SetDirty()
			end

			if arg_354_1.time_ >= var_357_4 + var_357_12 and arg_354_1.time_ < var_357_4 + var_357_12 + arg_357_0 then
				arg_354_1.typewritter.percent = 1

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(true)
			end
		end

		arg_354_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_354_1:InitPlayNodeList()
	end,
	Play1108411086 = function(arg_358_0, arg_358_1)
		arg_358_1.time_ = 0
		arg_358_1.frameCnt_ = 0
		arg_358_1.state_ = "playing"
		arg_358_1.curTalkId_ = 1108411086
		arg_358_1.duration_ = 6

		local var_358_0 = {
			zh = 3.333,
			ja = 6
		}
		local var_358_1 = manager.audio:GetLocalizationFlag()

		if var_358_0[var_358_1] ~= nil then
			arg_358_1.duration_ = var_358_0[var_358_1]
		end

		SetActive(arg_358_1.tipsGo_, false)

		function arg_358_1.onSingleLineFinish_()
			arg_358_1.onSingleLineUpdate_ = nil
			arg_358_1.onSingleLineFinish_ = nil
			arg_358_1.state_ = "waiting"
		end

		function arg_358_1.playNext_(arg_360_0)
			if arg_360_0 == 1 then
				arg_358_0:Play1108411087(arg_358_1)
			end
		end

		function arg_358_1.onSingleLineUpdate_(arg_361_0)
			local var_361_0 = 0.425

			if 0 < arg_358_1.time_ and arg_358_1.time_ <= 0 + arg_361_0 then
				arg_358_1.talkMaxDuration = 0
				arg_358_1.dialogCg_.alpha = 1

				arg_358_1.dialog_:SetActive(true)
				SetActive(arg_358_1.leftNameGo_, true)

				arg_358_1.leftNameTxt_.text = arg_358_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_358_1.leftNameTxt_.transform)

				arg_358_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_358_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_358_1:RecordName(arg_358_1.leftNameTxt_.text)
				SetActive(arg_358_1.iconTrs_.gameObject, false)
				arg_358_1.callingController_:SetSelectedState("normal")

				local var_361_1 = arg_358_1:GetWordFromCfg(1108411086)
				local var_361_2 = arg_358_1:FormatText(var_361_1.content)

				arg_358_1.text_.text = var_361_2

				LuaForUtil.ClearLinePrefixSymbol(arg_358_1.text_)

				local var_361_4 = 17 <= 0 and var_361_0 or var_361_0 * (utf8.len(var_361_2) / 17)

				if (17 <= 0 and var_361_0 or var_361_0 * (utf8.len(var_361_2) / 17)) > 0 and var_361_0 < var_361_4 then
					arg_358_1.talkMaxDuration = var_361_4

					if var_361_4 + 0 > arg_358_1.duration_ then
						arg_358_1.duration_ = var_361_4 + 0
					end
				end

				arg_358_1.text_.text = var_361_2
				arg_358_1.typewritter.percent = 0

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411086", "story_v_side_new_1108411.awb") ~= 0 then
					local var_361_5 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411086", "story_v_side_new_1108411.awb") / 1000

					if var_361_5 + 0 > arg_358_1.duration_ then
						arg_358_1.duration_ = var_361_5 + 0
					end

					if var_361_1.prefab_name ~= "" and arg_358_1.actors_[var_361_1.prefab_name] ~= nil then
						local var_361_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_358_1.actors_[var_361_1.prefab_name].transform, "story_v_side_new_1108411", "1108411086", "story_v_side_new_1108411.awb")

						arg_358_1:RecordAudio("1108411086", var_361_6)
						arg_358_1:RecordAudio("1108411086", var_361_6)
					else
						arg_358_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411086", "story_v_side_new_1108411.awb")
					end

					arg_358_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411086", "story_v_side_new_1108411.awb")
				end

				arg_358_1:RecordContent(arg_358_1.text_.text)
			end

			local var_361_7 = math.max(var_361_0, arg_358_1.talkMaxDuration)

			if 0 <= arg_358_1.time_ and arg_358_1.time_ < 0 + var_361_7 then
				arg_358_1.typewritter.percent = (arg_358_1.time_ - 0) / var_361_7

				arg_358_1.typewritter:SetDirty()
			end

			if arg_358_1.time_ >= 0 + var_361_7 and arg_358_1.time_ < 0 + var_361_7 + arg_361_0 then
				arg_358_1.typewritter.percent = 1

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(true)
			end
		end

		arg_358_1.nodeConfigList_ = {}

		arg_358_1:InitPlayNodeList()
	end,
	Play1108411087 = function(arg_362_0, arg_362_1)
		arg_362_1.time_ = 0
		arg_362_1.frameCnt_ = 0
		arg_362_1.state_ = "playing"
		arg_362_1.curTalkId_ = 1108411087
		arg_362_1.duration_ = 5

		SetActive(arg_362_1.tipsGo_, false)

		function arg_362_1.onSingleLineFinish_()
			arg_362_1.onSingleLineUpdate_ = nil
			arg_362_1.onSingleLineFinish_ = nil
			arg_362_1.state_ = "waiting"
		end

		function arg_362_1.playNext_(arg_364_0)
			if arg_364_0 == 1 then
				arg_362_0:Play1108411088(arg_362_1)
			end
		end

		function arg_362_1.onSingleLineUpdate_(arg_365_0)
			if 0 < arg_362_1.time_ and arg_362_1.time_ <= 0 + arg_365_0 and not isNil(arg_362_1.actors_["10102ui_story"]) and arg_362_1.var_.characterEffect10102ui_story == nil then
				arg_362_1.var_.characterEffect10102ui_story = arg_362_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_365_0 = 0.200000002980232

			if 0 <= arg_362_1.time_ and arg_362_1.time_ < 0 + var_365_0 and not isNil(arg_362_1.actors_["10102ui_story"]) then
				if arg_362_1.var_.characterEffect10102ui_story and not isNil(arg_362_1.actors_["10102ui_story"]) then
					arg_362_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_362_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_362_1.time_ - 0) / var_365_0)
				end
			end

			if arg_362_1.time_ >= 0 + var_365_0 and arg_362_1.time_ < 0 + var_365_0 + arg_365_0 and not isNil(arg_362_1.actors_["10102ui_story"]) and arg_362_1.var_.characterEffect10102ui_story then
				arg_362_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_362_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_365_1 = 0
			local var_365_2 = 0.575

			if 0 < arg_362_1.time_ and arg_362_1.time_ <= var_365_1 + arg_365_0 then
				arg_362_1.talkMaxDuration = 0
				arg_362_1.dialogCg_.alpha = 1

				arg_362_1.dialog_:SetActive(true)
				SetActive(arg_362_1.leftNameGo_, true)

				arg_362_1.leftNameTxt_.text = arg_362_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_362_1.leftNameTxt_.transform)

				arg_362_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_362_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_362_1:RecordName(arg_362_1.leftNameTxt_.text)
				SetActive(arg_362_1.iconTrs_.gameObject, true)
				arg_362_1.iconController_:SetSelectedState("hero")

				arg_362_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_362_1.callingController_:SetSelectedState("normal")

				arg_362_1.keyicon_.color = Color.New(1, 1, 1)
				arg_362_1.icon_.color = Color.New(1, 1, 1)

				local var_365_3 = arg_362_1:FormatText(arg_362_1:GetWordFromCfg(1108411087).content)

				arg_362_1.text_.text = var_365_3

				LuaForUtil.ClearLinePrefixSymbol(arg_362_1.text_)

				local var_365_5 = 23 <= 0 and var_365_2 or var_365_2 * (utf8.len(var_365_3) / 23)

				if (23 <= 0 and var_365_2 or var_365_2 * (utf8.len(var_365_3) / 23)) > 0 and var_365_2 < var_365_5 then
					arg_362_1.talkMaxDuration = var_365_5

					if var_365_5 + var_365_1 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_5 + var_365_1
					end
				end

				arg_362_1.text_.text = var_365_3
				arg_362_1.typewritter.percent = 0

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(false)
				arg_362_1:RecordContent(arg_362_1.text_.text)
			end

			local var_365_6 = math.max(var_365_2, arg_362_1.talkMaxDuration)

			if var_365_1 <= arg_362_1.time_ and arg_362_1.time_ < var_365_1 + var_365_6 then
				arg_362_1.typewritter.percent = (arg_362_1.time_ - var_365_1) / var_365_6

				arg_362_1.typewritter:SetDirty()
			end

			if arg_362_1.time_ >= var_365_1 + var_365_6 and arg_362_1.time_ < var_365_1 + var_365_6 + arg_365_0 then
				arg_362_1.typewritter.percent = 1

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(true)
			end
		end

		arg_362_1.nodeConfigList_ = {}

		arg_362_1:InitPlayNodeList()
	end,
	Play1108411088 = function(arg_366_0, arg_366_1)
		arg_366_1.time_ = 0
		arg_366_1.frameCnt_ = 0
		arg_366_1.state_ = "playing"
		arg_366_1.curTalkId_ = 1108411088
		arg_366_1.duration_ = 5.93

		local var_366_0 = {
			zh = 3.133,
			ja = 5.933
		}
		local var_366_1 = manager.audio:GetLocalizationFlag()

		if var_366_0[var_366_1] ~= nil then
			arg_366_1.duration_ = var_366_0[var_366_1]
		end

		SetActive(arg_366_1.tipsGo_, false)

		function arg_366_1.onSingleLineFinish_()
			arg_366_1.onSingleLineUpdate_ = nil
			arg_366_1.onSingleLineFinish_ = nil
			arg_366_1.state_ = "waiting"
		end

		function arg_366_1.playNext_(arg_368_0)
			if arg_368_0 == 1 then
				arg_366_0:Play1108411089(arg_366_1)
			end
		end

		function arg_366_1.onSingleLineUpdate_(arg_369_0)
			if 0 < arg_366_1.time_ and arg_366_1.time_ <= 0 + arg_369_0 and not isNil(arg_366_1.actors_["10102ui_story"]) and arg_366_1.var_.characterEffect10102ui_story == nil then
				arg_366_1.var_.characterEffect10102ui_story = arg_366_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_369_0 = 0.200000002980232

			if 0 <= arg_366_1.time_ and arg_366_1.time_ < 0 + var_369_0 and not isNil(arg_366_1.actors_["10102ui_story"]) then
				if arg_366_1.var_.characterEffect10102ui_story and not isNil(arg_366_1.actors_["10102ui_story"]) then
					arg_366_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_366_1.time_ >= 0 + var_369_0 and arg_366_1.time_ < 0 + var_369_0 + arg_369_0 and not isNil(arg_366_1.actors_["10102ui_story"]) and arg_366_1.var_.characterEffect10102ui_story then
				arg_366_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_366_1.time_ and arg_366_1.time_ <= 0 + arg_369_0 then
				arg_366_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action2_1")
			end

			if 0 < arg_366_1.time_ and arg_366_1.time_ <= 0 + arg_369_0 then
				arg_366_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_369_2 = 0
			local var_369_3 = 0.375

			if 0 < arg_366_1.time_ and arg_366_1.time_ <= var_369_2 + arg_369_0 then
				arg_366_1.talkMaxDuration = 0
				arg_366_1.dialogCg_.alpha = 1

				arg_366_1.dialog_:SetActive(true)
				SetActive(arg_366_1.leftNameGo_, true)

				arg_366_1.leftNameTxt_.text = arg_366_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_366_1.leftNameTxt_.transform)

				arg_366_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_366_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_366_1:RecordName(arg_366_1.leftNameTxt_.text)
				SetActive(arg_366_1.iconTrs_.gameObject, false)
				arg_366_1.callingController_:SetSelectedState("normal")

				local var_369_4 = arg_366_1:GetWordFromCfg(1108411088)
				local var_369_5 = arg_366_1:FormatText(var_369_4.content)

				arg_366_1.text_.text = var_369_5

				LuaForUtil.ClearLinePrefixSymbol(arg_366_1.text_)

				local var_369_7 = 15 <= 0 and var_369_3 or var_369_3 * (utf8.len(var_369_5) / 15)

				if (15 <= 0 and var_369_3 or var_369_3 * (utf8.len(var_369_5) / 15)) > 0 and var_369_3 < var_369_7 then
					arg_366_1.talkMaxDuration = var_369_7

					if var_369_7 + var_369_2 > arg_366_1.duration_ then
						arg_366_1.duration_ = var_369_7 + var_369_2
					end
				end

				arg_366_1.text_.text = var_369_5
				arg_366_1.typewritter.percent = 0

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411088", "story_v_side_new_1108411.awb") ~= 0 then
					local var_369_8 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411088", "story_v_side_new_1108411.awb") / 1000

					if var_369_8 + var_369_2 > arg_366_1.duration_ then
						arg_366_1.duration_ = var_369_8 + var_369_2
					end

					if var_369_4.prefab_name ~= "" and arg_366_1.actors_[var_369_4.prefab_name] ~= nil then
						local var_369_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_366_1.actors_[var_369_4.prefab_name].transform, "story_v_side_new_1108411", "1108411088", "story_v_side_new_1108411.awb")

						arg_366_1:RecordAudio("1108411088", var_369_9)
						arg_366_1:RecordAudio("1108411088", var_369_9)
					else
						arg_366_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411088", "story_v_side_new_1108411.awb")
					end

					arg_366_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411088", "story_v_side_new_1108411.awb")
				end

				arg_366_1:RecordContent(arg_366_1.text_.text)
			end

			local var_369_10 = math.max(var_369_3, arg_366_1.talkMaxDuration)

			if var_369_2 <= arg_366_1.time_ and arg_366_1.time_ < var_369_2 + var_369_10 then
				arg_366_1.typewritter.percent = (arg_366_1.time_ - var_369_2) / var_369_10

				arg_366_1.typewritter:SetDirty()
			end

			if arg_366_1.time_ >= var_369_2 + var_369_10 and arg_366_1.time_ < var_369_2 + var_369_10 + arg_369_0 then
				arg_366_1.typewritter.percent = 1

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(true)
			end
		end

		arg_366_1.nodeConfigList_ = {}

		arg_366_1:InitPlayNodeList()
	end,
	Play1108411089 = function(arg_370_0, arg_370_1)
		arg_370_1.time_ = 0
		arg_370_1.frameCnt_ = 0
		arg_370_1.state_ = "playing"
		arg_370_1.curTalkId_ = 1108411089
		arg_370_1.duration_ = 5

		SetActive(arg_370_1.tipsGo_, false)

		function arg_370_1.onSingleLineFinish_()
			arg_370_1.onSingleLineUpdate_ = nil
			arg_370_1.onSingleLineFinish_ = nil
			arg_370_1.state_ = "waiting"
		end

		function arg_370_1.playNext_(arg_372_0)
			if arg_372_0 == 1 then
				arg_370_0:Play1108411090(arg_370_1)
			end
		end

		function arg_370_1.onSingleLineUpdate_(arg_373_0)
			if 0 < arg_370_1.time_ and arg_370_1.time_ <= 0 + arg_373_0 and not isNil(arg_370_1.actors_["10102ui_story"]) and arg_370_1.var_.characterEffect10102ui_story == nil then
				arg_370_1.var_.characterEffect10102ui_story = arg_370_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_373_0 = 0.200000002980232

			if 0 <= arg_370_1.time_ and arg_370_1.time_ < 0 + var_373_0 and not isNil(arg_370_1.actors_["10102ui_story"]) then
				if arg_370_1.var_.characterEffect10102ui_story and not isNil(arg_370_1.actors_["10102ui_story"]) then
					arg_370_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_370_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_370_1.time_ - 0) / var_373_0)
				end
			end

			if arg_370_1.time_ >= 0 + var_373_0 and arg_370_1.time_ < 0 + var_373_0 + arg_373_0 and not isNil(arg_370_1.actors_["10102ui_story"]) and arg_370_1.var_.characterEffect10102ui_story then
				arg_370_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_370_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_373_1 = 0
			local var_373_2 = 0.525

			if 0 < arg_370_1.time_ and arg_370_1.time_ <= var_373_1 + arg_373_0 then
				arg_370_1.talkMaxDuration = 0
				arg_370_1.dialogCg_.alpha = 1

				arg_370_1.dialog_:SetActive(true)
				SetActive(arg_370_1.leftNameGo_, true)

				arg_370_1.leftNameTxt_.text = arg_370_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_370_1.leftNameTxt_.transform)

				arg_370_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_370_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_370_1:RecordName(arg_370_1.leftNameTxt_.text)
				SetActive(arg_370_1.iconTrs_.gameObject, true)
				arg_370_1.iconController_:SetSelectedState("hero")

				arg_370_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_370_1.callingController_:SetSelectedState("normal")

				arg_370_1.keyicon_.color = Color.New(1, 1, 1)
				arg_370_1.icon_.color = Color.New(1, 1, 1)

				local var_373_3 = arg_370_1:FormatText(arg_370_1:GetWordFromCfg(1108411089).content)

				arg_370_1.text_.text = var_373_3

				LuaForUtil.ClearLinePrefixSymbol(arg_370_1.text_)

				local var_373_5 = 21 <= 0 and var_373_2 or var_373_2 * (utf8.len(var_373_3) / 21)

				if (21 <= 0 and var_373_2 or var_373_2 * (utf8.len(var_373_3) / 21)) > 0 and var_373_2 < var_373_5 then
					arg_370_1.talkMaxDuration = var_373_5

					if var_373_5 + var_373_1 > arg_370_1.duration_ then
						arg_370_1.duration_ = var_373_5 + var_373_1
					end
				end

				arg_370_1.text_.text = var_373_3
				arg_370_1.typewritter.percent = 0

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(false)
				arg_370_1:RecordContent(arg_370_1.text_.text)
			end

			local var_373_6 = math.max(var_373_2, arg_370_1.talkMaxDuration)

			if var_373_1 <= arg_370_1.time_ and arg_370_1.time_ < var_373_1 + var_373_6 then
				arg_370_1.typewritter.percent = (arg_370_1.time_ - var_373_1) / var_373_6

				arg_370_1.typewritter:SetDirty()
			end

			if arg_370_1.time_ >= var_373_1 + var_373_6 and arg_370_1.time_ < var_373_1 + var_373_6 + arg_373_0 then
				arg_370_1.typewritter.percent = 1

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(true)
			end
		end

		arg_370_1.nodeConfigList_ = {}

		arg_370_1:InitPlayNodeList()
	end,
	Play1108411090 = function(arg_374_0, arg_374_1)
		arg_374_1.time_ = 0
		arg_374_1.frameCnt_ = 0
		arg_374_1.state_ = "playing"
		arg_374_1.curTalkId_ = 1108411090
		arg_374_1.duration_ = 5

		SetActive(arg_374_1.tipsGo_, false)

		function arg_374_1.onSingleLineFinish_()
			arg_374_1.onSingleLineUpdate_ = nil
			arg_374_1.onSingleLineFinish_ = nil
			arg_374_1.state_ = "waiting"
		end

		function arg_374_1.playNext_(arg_376_0)
			if arg_376_0 == 1 then
				arg_374_0:Play1108411091(arg_374_1)
			end
		end

		function arg_374_1.onSingleLineUpdate_(arg_377_0)
			local var_377_0 = 0.875

			if 0 < arg_374_1.time_ and arg_374_1.time_ <= 0 + arg_377_0 then
				arg_374_1.talkMaxDuration = 0
				arg_374_1.dialogCg_.alpha = 1

				arg_374_1.dialog_:SetActive(true)
				SetActive(arg_374_1.leftNameGo_, false)

				arg_374_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_374_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_374_1:RecordName(arg_374_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_374_1.iconTrs_.gameObject, false)
				arg_374_1.callingController_:SetSelectedState("normal")

				local var_377_1 = arg_374_1:FormatText(arg_374_1:GetWordFromCfg(1108411090).content)

				arg_374_1.text_.text = var_377_1

				LuaForUtil.ClearLinePrefixSymbol(arg_374_1.text_)

				local var_377_3 = 35 <= 0 and var_377_0 or var_377_0 * (utf8.len(var_377_1) / 35)

				if (35 <= 0 and var_377_0 or var_377_0 * (utf8.len(var_377_1) / 35)) > 0 and var_377_0 < var_377_3 then
					arg_374_1.talkMaxDuration = var_377_3

					if var_377_3 + 0 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_3 + 0
					end
				end

				arg_374_1.text_.text = var_377_1
				arg_374_1.typewritter.percent = 0

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(false)
				arg_374_1:RecordContent(arg_374_1.text_.text)
			end

			local var_377_4 = math.max(var_377_0, arg_374_1.talkMaxDuration)

			if 0 <= arg_374_1.time_ and arg_374_1.time_ < 0 + var_377_4 then
				arg_374_1.typewritter.percent = (arg_374_1.time_ - 0) / var_377_4

				arg_374_1.typewritter:SetDirty()
			end

			if arg_374_1.time_ >= 0 + var_377_4 and arg_374_1.time_ < 0 + var_377_4 + arg_377_0 then
				arg_374_1.typewritter.percent = 1

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(true)
			end
		end

		arg_374_1.nodeConfigList_ = {}

		arg_374_1:InitPlayNodeList()
	end,
	Play1108411091 = function(arg_378_0, arg_378_1)
		arg_378_1.time_ = 0
		arg_378_1.frameCnt_ = 0
		arg_378_1.state_ = "playing"
		arg_378_1.curTalkId_ = 1108411091
		arg_378_1.duration_ = 8.03

		local var_378_0 = {
			zh = 7.033,
			ja = 8.033
		}
		local var_378_1 = manager.audio:GetLocalizationFlag()

		if var_378_0[var_378_1] ~= nil then
			arg_378_1.duration_ = var_378_0[var_378_1]
		end

		SetActive(arg_378_1.tipsGo_, false)

		function arg_378_1.onSingleLineFinish_()
			arg_378_1.onSingleLineUpdate_ = nil
			arg_378_1.onSingleLineFinish_ = nil
			arg_378_1.state_ = "waiting"
		end

		function arg_378_1.playNext_(arg_380_0)
			if arg_380_0 == 1 then
				arg_378_0:Play1108411092(arg_378_1)
			end
		end

		function arg_378_1.onSingleLineUpdate_(arg_381_0)
			if 0 < arg_378_1.time_ and arg_378_1.time_ <= 0 + arg_381_0 and not isNil(arg_378_1.actors_["10102ui_story"]) and arg_378_1.var_.characterEffect10102ui_story == nil then
				arg_378_1.var_.characterEffect10102ui_story = arg_378_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_381_0 = 0.200000002980232

			if 0 <= arg_378_1.time_ and arg_378_1.time_ < 0 + var_381_0 and not isNil(arg_378_1.actors_["10102ui_story"]) then
				if arg_378_1.var_.characterEffect10102ui_story and not isNil(arg_378_1.actors_["10102ui_story"]) then
					arg_378_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_378_1.time_ >= 0 + var_381_0 and arg_378_1.time_ < 0 + var_381_0 + arg_381_0 and not isNil(arg_378_1.actors_["10102ui_story"]) and arg_378_1.var_.characterEffect10102ui_story then
				arg_378_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_378_1.time_ and arg_378_1.time_ <= 0 + arg_381_0 then
				arg_378_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102actionlink/10102action426")
			end

			local var_381_2 = 0
			local var_381_3 = 0.7

			if 0 < arg_378_1.time_ and arg_378_1.time_ <= var_381_2 + arg_381_0 then
				arg_378_1.talkMaxDuration = 0
				arg_378_1.dialogCg_.alpha = 1

				arg_378_1.dialog_:SetActive(true)
				SetActive(arg_378_1.leftNameGo_, true)

				arg_378_1.leftNameTxt_.text = arg_378_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_378_1.leftNameTxt_.transform)

				arg_378_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_378_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_378_1:RecordName(arg_378_1.leftNameTxt_.text)
				SetActive(arg_378_1.iconTrs_.gameObject, false)
				arg_378_1.callingController_:SetSelectedState("normal")

				local var_381_4 = arg_378_1:GetWordFromCfg(1108411091)
				local var_381_5 = arg_378_1:FormatText(var_381_4.content)

				arg_378_1.text_.text = var_381_5

				LuaForUtil.ClearLinePrefixSymbol(arg_378_1.text_)

				local var_381_7 = 28 <= 0 and var_381_3 or var_381_3 * (utf8.len(var_381_5) / 28)

				if (28 <= 0 and var_381_3 or var_381_3 * (utf8.len(var_381_5) / 28)) > 0 and var_381_3 < var_381_7 then
					arg_378_1.talkMaxDuration = var_381_7

					if var_381_7 + var_381_2 > arg_378_1.duration_ then
						arg_378_1.duration_ = var_381_7 + var_381_2
					end
				end

				arg_378_1.text_.text = var_381_5
				arg_378_1.typewritter.percent = 0

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411091", "story_v_side_new_1108411.awb") ~= 0 then
					local var_381_8 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411091", "story_v_side_new_1108411.awb") / 1000

					if var_381_8 + var_381_2 > arg_378_1.duration_ then
						arg_378_1.duration_ = var_381_8 + var_381_2
					end

					if var_381_4.prefab_name ~= "" and arg_378_1.actors_[var_381_4.prefab_name] ~= nil then
						local var_381_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_378_1.actors_[var_381_4.prefab_name].transform, "story_v_side_new_1108411", "1108411091", "story_v_side_new_1108411.awb")

						arg_378_1:RecordAudio("1108411091", var_381_9)
						arg_378_1:RecordAudio("1108411091", var_381_9)
					else
						arg_378_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411091", "story_v_side_new_1108411.awb")
					end

					arg_378_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411091", "story_v_side_new_1108411.awb")
				end

				arg_378_1:RecordContent(arg_378_1.text_.text)
			end

			local var_381_10 = math.max(var_381_3, arg_378_1.talkMaxDuration)

			if var_381_2 <= arg_378_1.time_ and arg_378_1.time_ < var_381_2 + var_381_10 then
				arg_378_1.typewritter.percent = (arg_378_1.time_ - var_381_2) / var_381_10

				arg_378_1.typewritter:SetDirty()
			end

			if arg_378_1.time_ >= var_381_2 + var_381_10 and arg_378_1.time_ < var_381_2 + var_381_10 + arg_381_0 then
				arg_378_1.typewritter.percent = 1

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(true)
			end
		end

		arg_378_1.nodeConfigList_ = {}

		arg_378_1:InitPlayNodeList()
	end,
	Play1108411092 = function(arg_382_0, arg_382_1)
		arg_382_1.time_ = 0
		arg_382_1.frameCnt_ = 0
		arg_382_1.state_ = "playing"
		arg_382_1.curTalkId_ = 1108411092
		arg_382_1.duration_ = 5

		SetActive(arg_382_1.tipsGo_, false)

		function arg_382_1.onSingleLineFinish_()
			arg_382_1.onSingleLineUpdate_ = nil
			arg_382_1.onSingleLineFinish_ = nil
			arg_382_1.state_ = "waiting"
		end

		function arg_382_1.playNext_(arg_384_0)
			if arg_384_0 == 1 then
				arg_382_0:Play1108411093(arg_382_1)
			end
		end

		function arg_382_1.onSingleLineUpdate_(arg_385_0)
			if 0 < arg_382_1.time_ and arg_382_1.time_ <= 0 + arg_385_0 and not isNil(arg_382_1.actors_["10102ui_story"]) and arg_382_1.var_.characterEffect10102ui_story == nil then
				arg_382_1.var_.characterEffect10102ui_story = arg_382_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_385_0 = 0.200000002980232

			if 0 <= arg_382_1.time_ and arg_382_1.time_ < 0 + var_385_0 and not isNil(arg_382_1.actors_["10102ui_story"]) then
				if arg_382_1.var_.characterEffect10102ui_story and not isNil(arg_382_1.actors_["10102ui_story"]) then
					arg_382_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_382_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_382_1.time_ - 0) / var_385_0)
				end
			end

			if arg_382_1.time_ >= 0 + var_385_0 and arg_382_1.time_ < 0 + var_385_0 + arg_385_0 and not isNil(arg_382_1.actors_["10102ui_story"]) and arg_382_1.var_.characterEffect10102ui_story then
				arg_382_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_382_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_385_1 = 0
			local var_385_2 = 0.35

			if 0 < arg_382_1.time_ and arg_382_1.time_ <= var_385_1 + arg_385_0 then
				arg_382_1.talkMaxDuration = 0
				arg_382_1.dialogCg_.alpha = 1

				arg_382_1.dialog_:SetActive(true)
				SetActive(arg_382_1.leftNameGo_, true)

				arg_382_1.leftNameTxt_.text = arg_382_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_382_1.leftNameTxt_.transform)

				arg_382_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_382_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_382_1:RecordName(arg_382_1.leftNameTxt_.text)
				SetActive(arg_382_1.iconTrs_.gameObject, true)
				arg_382_1.iconController_:SetSelectedState("hero")

				arg_382_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_382_1.callingController_:SetSelectedState("normal")

				arg_382_1.keyicon_.color = Color.New(1, 1, 1)
				arg_382_1.icon_.color = Color.New(1, 1, 1)

				local var_385_3 = arg_382_1:FormatText(arg_382_1:GetWordFromCfg(1108411092).content)

				arg_382_1.text_.text = var_385_3

				LuaForUtil.ClearLinePrefixSymbol(arg_382_1.text_)

				local var_385_5 = 14 <= 0 and var_385_2 or var_385_2 * (utf8.len(var_385_3) / 14)

				if (14 <= 0 and var_385_2 or var_385_2 * (utf8.len(var_385_3) / 14)) > 0 and var_385_2 < var_385_5 then
					arg_382_1.talkMaxDuration = var_385_5

					if var_385_5 + var_385_1 > arg_382_1.duration_ then
						arg_382_1.duration_ = var_385_5 + var_385_1
					end
				end

				arg_382_1.text_.text = var_385_3
				arg_382_1.typewritter.percent = 0

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(false)
				arg_382_1:RecordContent(arg_382_1.text_.text)
			end

			local var_385_6 = math.max(var_385_2, arg_382_1.talkMaxDuration)

			if var_385_1 <= arg_382_1.time_ and arg_382_1.time_ < var_385_1 + var_385_6 then
				arg_382_1.typewritter.percent = (arg_382_1.time_ - var_385_1) / var_385_6

				arg_382_1.typewritter:SetDirty()
			end

			if arg_382_1.time_ >= var_385_1 + var_385_6 and arg_382_1.time_ < var_385_1 + var_385_6 + arg_385_0 then
				arg_382_1.typewritter.percent = 1

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(true)
			end
		end

		arg_382_1.nodeConfigList_ = {}

		arg_382_1:InitPlayNodeList()
	end,
	Play1108411093 = function(arg_386_0, arg_386_1)
		arg_386_1.time_ = 0
		arg_386_1.frameCnt_ = 0
		arg_386_1.state_ = "playing"
		arg_386_1.curTalkId_ = 1108411093
		arg_386_1.duration_ = 4.9

		local var_386_0 = {
			zh = 3.433,
			ja = 4.9
		}
		local var_386_1 = manager.audio:GetLocalizationFlag()

		if var_386_0[var_386_1] ~= nil then
			arg_386_1.duration_ = var_386_0[var_386_1]
		end

		SetActive(arg_386_1.tipsGo_, false)

		function arg_386_1.onSingleLineFinish_()
			arg_386_1.onSingleLineUpdate_ = nil
			arg_386_1.onSingleLineFinish_ = nil
			arg_386_1.state_ = "waiting"
		end

		function arg_386_1.playNext_(arg_388_0)
			if arg_388_0 == 1 then
				arg_386_0:Play1108411094(arg_386_1)
			end
		end

		function arg_386_1.onSingleLineUpdate_(arg_389_0)
			if 0 < arg_386_1.time_ and arg_386_1.time_ <= 0 + arg_389_0 and not isNil(arg_386_1.actors_["10102ui_story"]) and arg_386_1.var_.characterEffect10102ui_story == nil then
				arg_386_1.var_.characterEffect10102ui_story = arg_386_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_389_0 = 0.200000002980232

			if 0 <= arg_386_1.time_ and arg_386_1.time_ < 0 + var_389_0 and not isNil(arg_386_1.actors_["10102ui_story"]) then
				if arg_386_1.var_.characterEffect10102ui_story and not isNil(arg_386_1.actors_["10102ui_story"]) then
					arg_386_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_386_1.time_ >= 0 + var_389_0 and arg_386_1.time_ < 0 + var_389_0 + arg_389_0 and not isNil(arg_386_1.actors_["10102ui_story"]) and arg_386_1.var_.characterEffect10102ui_story then
				arg_386_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_389_2 = 0
			local var_389_3 = 0.45

			if 0 < arg_386_1.time_ and arg_386_1.time_ <= var_389_2 + arg_389_0 then
				arg_386_1.talkMaxDuration = 0
				arg_386_1.dialogCg_.alpha = 1

				arg_386_1.dialog_:SetActive(true)
				SetActive(arg_386_1.leftNameGo_, true)

				arg_386_1.leftNameTxt_.text = arg_386_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_386_1.leftNameTxt_.transform)

				arg_386_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_386_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_386_1:RecordName(arg_386_1.leftNameTxt_.text)
				SetActive(arg_386_1.iconTrs_.gameObject, false)
				arg_386_1.callingController_:SetSelectedState("normal")

				local var_389_4 = arg_386_1:GetWordFromCfg(1108411093)
				local var_389_5 = arg_386_1:FormatText(var_389_4.content)

				arg_386_1.text_.text = var_389_5

				LuaForUtil.ClearLinePrefixSymbol(arg_386_1.text_)

				local var_389_7 = 18 <= 0 and var_389_3 or var_389_3 * (utf8.len(var_389_5) / 18)

				if (18 <= 0 and var_389_3 or var_389_3 * (utf8.len(var_389_5) / 18)) > 0 and var_389_3 < var_389_7 then
					arg_386_1.talkMaxDuration = var_389_7

					if var_389_7 + var_389_2 > arg_386_1.duration_ then
						arg_386_1.duration_ = var_389_7 + var_389_2
					end
				end

				arg_386_1.text_.text = var_389_5
				arg_386_1.typewritter.percent = 0

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411093", "story_v_side_new_1108411.awb") ~= 0 then
					local var_389_8 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411093", "story_v_side_new_1108411.awb") / 1000

					if var_389_8 + var_389_2 > arg_386_1.duration_ then
						arg_386_1.duration_ = var_389_8 + var_389_2
					end

					if var_389_4.prefab_name ~= "" and arg_386_1.actors_[var_389_4.prefab_name] ~= nil then
						local var_389_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_386_1.actors_[var_389_4.prefab_name].transform, "story_v_side_new_1108411", "1108411093", "story_v_side_new_1108411.awb")

						arg_386_1:RecordAudio("1108411093", var_389_9)
						arg_386_1:RecordAudio("1108411093", var_389_9)
					else
						arg_386_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411093", "story_v_side_new_1108411.awb")
					end

					arg_386_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411093", "story_v_side_new_1108411.awb")
				end

				arg_386_1:RecordContent(arg_386_1.text_.text)
			end

			local var_389_10 = math.max(var_389_3, arg_386_1.talkMaxDuration)

			if var_389_2 <= arg_386_1.time_ and arg_386_1.time_ < var_389_2 + var_389_10 then
				arg_386_1.typewritter.percent = (arg_386_1.time_ - var_389_2) / var_389_10

				arg_386_1.typewritter:SetDirty()
			end

			if arg_386_1.time_ >= var_389_2 + var_389_10 and arg_386_1.time_ < var_389_2 + var_389_10 + arg_389_0 then
				arg_386_1.typewritter.percent = 1

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(true)
			end
		end

		arg_386_1.nodeConfigList_ = {}

		arg_386_1:InitPlayNodeList()
	end,
	Play1108411094 = function(arg_390_0, arg_390_1)
		arg_390_1.time_ = 0
		arg_390_1.frameCnt_ = 0
		arg_390_1.state_ = "playing"
		arg_390_1.curTalkId_ = 1108411094
		arg_390_1.duration_ = 5

		SetActive(arg_390_1.tipsGo_, false)

		function arg_390_1.onSingleLineFinish_()
			arg_390_1.onSingleLineUpdate_ = nil
			arg_390_1.onSingleLineFinish_ = nil
			arg_390_1.state_ = "waiting"
		end

		function arg_390_1.playNext_(arg_392_0)
			if arg_392_0 == 1 then
				arg_390_0:Play1108411095(arg_390_1)
			end
		end

		function arg_390_1.onSingleLineUpdate_(arg_393_0)
			if 0 < arg_390_1.time_ and arg_390_1.time_ <= 0 + arg_393_0 and not isNil(arg_390_1.actors_["10102ui_story"]) and arg_390_1.var_.characterEffect10102ui_story == nil then
				arg_390_1.var_.characterEffect10102ui_story = arg_390_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_393_0 = 0.200000002980232

			if 0 <= arg_390_1.time_ and arg_390_1.time_ < 0 + var_393_0 and not isNil(arg_390_1.actors_["10102ui_story"]) then
				if arg_390_1.var_.characterEffect10102ui_story and not isNil(arg_390_1.actors_["10102ui_story"]) then
					arg_390_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_390_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_390_1.time_ - 0) / var_393_0)
				end
			end

			if arg_390_1.time_ >= 0 + var_393_0 and arg_390_1.time_ < 0 + var_393_0 + arg_393_0 and not isNil(arg_390_1.actors_["10102ui_story"]) and arg_390_1.var_.characterEffect10102ui_story then
				arg_390_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_390_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_393_1 = 0
			local var_393_2 = 0.425

			if 0 < arg_390_1.time_ and arg_390_1.time_ <= var_393_1 + arg_393_0 then
				arg_390_1.talkMaxDuration = 0
				arg_390_1.dialogCg_.alpha = 1

				arg_390_1.dialog_:SetActive(true)
				SetActive(arg_390_1.leftNameGo_, true)

				arg_390_1.leftNameTxt_.text = arg_390_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_390_1.leftNameTxt_.transform)

				arg_390_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_390_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_390_1:RecordName(arg_390_1.leftNameTxt_.text)
				SetActive(arg_390_1.iconTrs_.gameObject, true)
				arg_390_1.iconController_:SetSelectedState("hero")

				arg_390_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_390_1.callingController_:SetSelectedState("normal")

				arg_390_1.keyicon_.color = Color.New(1, 1, 1)
				arg_390_1.icon_.color = Color.New(1, 1, 1)

				local var_393_3 = arg_390_1:FormatText(arg_390_1:GetWordFromCfg(1108411094).content)

				arg_390_1.text_.text = var_393_3

				LuaForUtil.ClearLinePrefixSymbol(arg_390_1.text_)

				local var_393_5 = 17 <= 0 and var_393_2 or var_393_2 * (utf8.len(var_393_3) / 17)

				if (17 <= 0 and var_393_2 or var_393_2 * (utf8.len(var_393_3) / 17)) > 0 and var_393_2 < var_393_5 then
					arg_390_1.talkMaxDuration = var_393_5

					if var_393_5 + var_393_1 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_5 + var_393_1
					end
				end

				arg_390_1.text_.text = var_393_3
				arg_390_1.typewritter.percent = 0

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(false)
				arg_390_1:RecordContent(arg_390_1.text_.text)
			end

			local var_393_6 = math.max(var_393_2, arg_390_1.talkMaxDuration)

			if var_393_1 <= arg_390_1.time_ and arg_390_1.time_ < var_393_1 + var_393_6 then
				arg_390_1.typewritter.percent = (arg_390_1.time_ - var_393_1) / var_393_6

				arg_390_1.typewritter:SetDirty()
			end

			if arg_390_1.time_ >= var_393_1 + var_393_6 and arg_390_1.time_ < var_393_1 + var_393_6 + arg_393_0 then
				arg_390_1.typewritter.percent = 1

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(true)
			end
		end

		arg_390_1.nodeConfigList_ = {}

		arg_390_1:InitPlayNodeList()
	end,
	Play1108411095 = function(arg_394_0, arg_394_1)
		arg_394_1.time_ = 0
		arg_394_1.frameCnt_ = 0
		arg_394_1.state_ = "playing"
		arg_394_1.curTalkId_ = 1108411095
		arg_394_1.duration_ = 3.97

		local var_394_0 = {
			zh = 3.133,
			ja = 3.966
		}
		local var_394_1 = manager.audio:GetLocalizationFlag()

		if var_394_0[var_394_1] ~= nil then
			arg_394_1.duration_ = var_394_0[var_394_1]
		end

		SetActive(arg_394_1.tipsGo_, false)

		function arg_394_1.onSingleLineFinish_()
			arg_394_1.onSingleLineUpdate_ = nil
			arg_394_1.onSingleLineFinish_ = nil
			arg_394_1.state_ = "waiting"
		end

		function arg_394_1.playNext_(arg_396_0)
			if arg_396_0 == 1 then
				arg_394_0:Play1108411096(arg_394_1)
			end
		end

		function arg_394_1.onSingleLineUpdate_(arg_397_0)
			if 0 < arg_394_1.time_ and arg_394_1.time_ <= 0 + arg_397_0 and not isNil(arg_394_1.actors_["10102ui_story"]) and arg_394_1.var_.characterEffect10102ui_story == nil then
				arg_394_1.var_.characterEffect10102ui_story = arg_394_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_397_0 = 0.200000002980232

			if 0 <= arg_394_1.time_ and arg_394_1.time_ < 0 + var_397_0 and not isNil(arg_394_1.actors_["10102ui_story"]) then
				if arg_394_1.var_.characterEffect10102ui_story and not isNil(arg_394_1.actors_["10102ui_story"]) then
					arg_394_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_394_1.time_ >= 0 + var_397_0 and arg_394_1.time_ < 0 + var_397_0 + arg_397_0 and not isNil(arg_394_1.actors_["10102ui_story"]) and arg_394_1.var_.characterEffect10102ui_story then
				arg_394_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_394_1.time_ and arg_394_1.time_ <= 0 + arg_397_0 then
				arg_394_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action6_2")
			end

			local var_397_2 = 0
			local var_397_3 = 0.525

			if 0 < arg_394_1.time_ and arg_394_1.time_ <= var_397_2 + arg_397_0 then
				arg_394_1.talkMaxDuration = 0
				arg_394_1.dialogCg_.alpha = 1

				arg_394_1.dialog_:SetActive(true)
				SetActive(arg_394_1.leftNameGo_, true)

				arg_394_1.leftNameTxt_.text = arg_394_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_394_1.leftNameTxt_.transform)

				arg_394_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_394_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_394_1:RecordName(arg_394_1.leftNameTxt_.text)
				SetActive(arg_394_1.iconTrs_.gameObject, false)
				arg_394_1.callingController_:SetSelectedState("normal")

				local var_397_4 = arg_394_1:GetWordFromCfg(1108411095)
				local var_397_5 = arg_394_1:FormatText(var_397_4.content)

				arg_394_1.text_.text = var_397_5

				LuaForUtil.ClearLinePrefixSymbol(arg_394_1.text_)

				local var_397_7 = 21 <= 0 and var_397_3 or var_397_3 * (utf8.len(var_397_5) / 21)

				if (21 <= 0 and var_397_3 or var_397_3 * (utf8.len(var_397_5) / 21)) > 0 and var_397_3 < var_397_7 then
					arg_394_1.talkMaxDuration = var_397_7

					if var_397_7 + var_397_2 > arg_394_1.duration_ then
						arg_394_1.duration_ = var_397_7 + var_397_2
					end
				end

				arg_394_1.text_.text = var_397_5
				arg_394_1.typewritter.percent = 0

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411095", "story_v_side_new_1108411.awb") ~= 0 then
					local var_397_8 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411095", "story_v_side_new_1108411.awb") / 1000

					if var_397_8 + var_397_2 > arg_394_1.duration_ then
						arg_394_1.duration_ = var_397_8 + var_397_2
					end

					if var_397_4.prefab_name ~= "" and arg_394_1.actors_[var_397_4.prefab_name] ~= nil then
						local var_397_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_394_1.actors_[var_397_4.prefab_name].transform, "story_v_side_new_1108411", "1108411095", "story_v_side_new_1108411.awb")

						arg_394_1:RecordAudio("1108411095", var_397_9)
						arg_394_1:RecordAudio("1108411095", var_397_9)
					else
						arg_394_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411095", "story_v_side_new_1108411.awb")
					end

					arg_394_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411095", "story_v_side_new_1108411.awb")
				end

				arg_394_1:RecordContent(arg_394_1.text_.text)
			end

			local var_397_10 = math.max(var_397_3, arg_394_1.talkMaxDuration)

			if var_397_2 <= arg_394_1.time_ and arg_394_1.time_ < var_397_2 + var_397_10 then
				arg_394_1.typewritter.percent = (arg_394_1.time_ - var_397_2) / var_397_10

				arg_394_1.typewritter:SetDirty()
			end

			if arg_394_1.time_ >= var_397_2 + var_397_10 and arg_394_1.time_ < var_397_2 + var_397_10 + arg_397_0 then
				arg_394_1.typewritter.percent = 1

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(true)
			end
		end

		arg_394_1.nodeConfigList_ = {}

		arg_394_1:InitPlayNodeList()
	end,
	Play1108411096 = function(arg_398_0, arg_398_1)
		arg_398_1.time_ = 0
		arg_398_1.frameCnt_ = 0
		arg_398_1.state_ = "playing"
		arg_398_1.curTalkId_ = 1108411096
		arg_398_1.duration_ = 5

		SetActive(arg_398_1.tipsGo_, false)

		function arg_398_1.onSingleLineFinish_()
			arg_398_1.onSingleLineUpdate_ = nil
			arg_398_1.onSingleLineFinish_ = nil
			arg_398_1.state_ = "waiting"
		end

		function arg_398_1.playNext_(arg_400_0)
			if arg_400_0 == 1 then
				arg_398_0:Play1108411097(arg_398_1)
			end
		end

		function arg_398_1.onSingleLineUpdate_(arg_401_0)
			if 0 < arg_398_1.time_ and arg_398_1.time_ <= 0 + arg_401_0 and not isNil(arg_398_1.actors_["10102ui_story"]) and arg_398_1.var_.characterEffect10102ui_story == nil then
				arg_398_1.var_.characterEffect10102ui_story = arg_398_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_401_0 = 0.200000002980232

			if 0 <= arg_398_1.time_ and arg_398_1.time_ < 0 + var_401_0 and not isNil(arg_398_1.actors_["10102ui_story"]) then
				if arg_398_1.var_.characterEffect10102ui_story and not isNil(arg_398_1.actors_["10102ui_story"]) then
					arg_398_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_398_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_398_1.time_ - 0) / var_401_0)
				end
			end

			if arg_398_1.time_ >= 0 + var_401_0 and arg_398_1.time_ < 0 + var_401_0 + arg_401_0 and not isNil(arg_398_1.actors_["10102ui_story"]) and arg_398_1.var_.characterEffect10102ui_story then
				arg_398_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_398_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_401_1 = 0
			local var_401_2 = 0.5

			if 0 < arg_398_1.time_ and arg_398_1.time_ <= var_401_1 + arg_401_0 then
				arg_398_1.talkMaxDuration = 0
				arg_398_1.dialogCg_.alpha = 1

				arg_398_1.dialog_:SetActive(true)
				SetActive(arg_398_1.leftNameGo_, true)

				arg_398_1.leftNameTxt_.text = arg_398_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_398_1.leftNameTxt_.transform)

				arg_398_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_398_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_398_1:RecordName(arg_398_1.leftNameTxt_.text)
				SetActive(arg_398_1.iconTrs_.gameObject, true)
				arg_398_1.iconController_:SetSelectedState("hero")

				arg_398_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_398_1.callingController_:SetSelectedState("normal")

				arg_398_1.keyicon_.color = Color.New(1, 1, 1)
				arg_398_1.icon_.color = Color.New(1, 1, 1)

				local var_401_3 = arg_398_1:FormatText(arg_398_1:GetWordFromCfg(1108411096).content)

				arg_398_1.text_.text = var_401_3

				LuaForUtil.ClearLinePrefixSymbol(arg_398_1.text_)

				local var_401_5 = 20 <= 0 and var_401_2 or var_401_2 * (utf8.len(var_401_3) / 20)

				if (20 <= 0 and var_401_2 or var_401_2 * (utf8.len(var_401_3) / 20)) > 0 and var_401_2 < var_401_5 then
					arg_398_1.talkMaxDuration = var_401_5

					if var_401_5 + var_401_1 > arg_398_1.duration_ then
						arg_398_1.duration_ = var_401_5 + var_401_1
					end
				end

				arg_398_1.text_.text = var_401_3
				arg_398_1.typewritter.percent = 0

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(false)
				arg_398_1:RecordContent(arg_398_1.text_.text)
			end

			local var_401_6 = math.max(var_401_2, arg_398_1.talkMaxDuration)

			if var_401_1 <= arg_398_1.time_ and arg_398_1.time_ < var_401_1 + var_401_6 then
				arg_398_1.typewritter.percent = (arg_398_1.time_ - var_401_1) / var_401_6

				arg_398_1.typewritter:SetDirty()
			end

			if arg_398_1.time_ >= var_401_1 + var_401_6 and arg_398_1.time_ < var_401_1 + var_401_6 + arg_401_0 then
				arg_398_1.typewritter.percent = 1

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(true)
			end
		end

		arg_398_1.nodeConfigList_ = {}

		arg_398_1:InitPlayNodeList()
	end,
	Play1108411097 = function(arg_402_0, arg_402_1)
		arg_402_1.time_ = 0
		arg_402_1.frameCnt_ = 0
		arg_402_1.state_ = "playing"
		arg_402_1.curTalkId_ = 1108411097
		arg_402_1.duration_ = 7.33

		local var_402_0 = {
			zh = 5.2,
			ja = 7.333
		}
		local var_402_1 = manager.audio:GetLocalizationFlag()

		if var_402_0[var_402_1] ~= nil then
			arg_402_1.duration_ = var_402_0[var_402_1]
		end

		SetActive(arg_402_1.tipsGo_, false)

		function arg_402_1.onSingleLineFinish_()
			arg_402_1.onSingleLineUpdate_ = nil
			arg_402_1.onSingleLineFinish_ = nil
			arg_402_1.state_ = "waiting"
		end

		function arg_402_1.playNext_(arg_404_0)
			if arg_404_0 == 1 then
				arg_402_0:Play1108411098(arg_402_1)
			end
		end

		function arg_402_1.onSingleLineUpdate_(arg_405_0)
			if 0 < arg_402_1.time_ and arg_402_1.time_ <= 0 + arg_405_0 and not isNil(arg_402_1.actors_["10102ui_story"]) and arg_402_1.var_.characterEffect10102ui_story == nil then
				arg_402_1.var_.characterEffect10102ui_story = arg_402_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_405_0 = 0.200000002980232

			if 0 <= arg_402_1.time_ and arg_402_1.time_ < 0 + var_405_0 and not isNil(arg_402_1.actors_["10102ui_story"]) then
				if arg_402_1.var_.characterEffect10102ui_story and not isNil(arg_402_1.actors_["10102ui_story"]) then
					arg_402_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_402_1.time_ >= 0 + var_405_0 and arg_402_1.time_ < 0 + var_405_0 + arg_405_0 and not isNil(arg_402_1.actors_["10102ui_story"]) and arg_402_1.var_.characterEffect10102ui_story then
				arg_402_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_405_2 = 0
			local var_405_3 = 0.65

			if 0 < arg_402_1.time_ and arg_402_1.time_ <= var_405_2 + arg_405_0 then
				arg_402_1.talkMaxDuration = 0
				arg_402_1.dialogCg_.alpha = 1

				arg_402_1.dialog_:SetActive(true)
				SetActive(arg_402_1.leftNameGo_, true)

				arg_402_1.leftNameTxt_.text = arg_402_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_402_1.leftNameTxt_.transform)

				arg_402_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_402_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_402_1:RecordName(arg_402_1.leftNameTxt_.text)
				SetActive(arg_402_1.iconTrs_.gameObject, false)
				arg_402_1.callingController_:SetSelectedState("normal")

				local var_405_4 = arg_402_1:GetWordFromCfg(1108411097)
				local var_405_5 = arg_402_1:FormatText(var_405_4.content)

				arg_402_1.text_.text = var_405_5

				LuaForUtil.ClearLinePrefixSymbol(arg_402_1.text_)

				local var_405_7 = 26 <= 0 and var_405_3 or var_405_3 * (utf8.len(var_405_5) / 26)

				if (26 <= 0 and var_405_3 or var_405_3 * (utf8.len(var_405_5) / 26)) > 0 and var_405_3 < var_405_7 then
					arg_402_1.talkMaxDuration = var_405_7

					if var_405_7 + var_405_2 > arg_402_1.duration_ then
						arg_402_1.duration_ = var_405_7 + var_405_2
					end
				end

				arg_402_1.text_.text = var_405_5
				arg_402_1.typewritter.percent = 0

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411097", "story_v_side_new_1108411.awb") ~= 0 then
					local var_405_8 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411097", "story_v_side_new_1108411.awb") / 1000

					if var_405_8 + var_405_2 > arg_402_1.duration_ then
						arg_402_1.duration_ = var_405_8 + var_405_2
					end

					if var_405_4.prefab_name ~= "" and arg_402_1.actors_[var_405_4.prefab_name] ~= nil then
						local var_405_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_402_1.actors_[var_405_4.prefab_name].transform, "story_v_side_new_1108411", "1108411097", "story_v_side_new_1108411.awb")

						arg_402_1:RecordAudio("1108411097", var_405_9)
						arg_402_1:RecordAudio("1108411097", var_405_9)
					else
						arg_402_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411097", "story_v_side_new_1108411.awb")
					end

					arg_402_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411097", "story_v_side_new_1108411.awb")
				end

				arg_402_1:RecordContent(arg_402_1.text_.text)
			end

			local var_405_10 = math.max(var_405_3, arg_402_1.talkMaxDuration)

			if var_405_2 <= arg_402_1.time_ and arg_402_1.time_ < var_405_2 + var_405_10 then
				arg_402_1.typewritter.percent = (arg_402_1.time_ - var_405_2) / var_405_10

				arg_402_1.typewritter:SetDirty()
			end

			if arg_402_1.time_ >= var_405_2 + var_405_10 and arg_402_1.time_ < var_405_2 + var_405_10 + arg_405_0 then
				arg_402_1.typewritter.percent = 1

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(true)
			end
		end

		arg_402_1.nodeConfigList_ = {}

		arg_402_1:InitPlayNodeList()
	end,
	Play1108411098 = function(arg_406_0, arg_406_1)
		arg_406_1.time_ = 0
		arg_406_1.frameCnt_ = 0
		arg_406_1.state_ = "playing"
		arg_406_1.curTalkId_ = 1108411098
		arg_406_1.duration_ = 6.07

		local var_406_0 = {
			zh = 4.966,
			ja = 6.066
		}
		local var_406_1 = manager.audio:GetLocalizationFlag()

		if var_406_0[var_406_1] ~= nil then
			arg_406_1.duration_ = var_406_0[var_406_1]
		end

		SetActive(arg_406_1.tipsGo_, false)

		function arg_406_1.onSingleLineFinish_()
			arg_406_1.onSingleLineUpdate_ = nil
			arg_406_1.onSingleLineFinish_ = nil
			arg_406_1.state_ = "waiting"
		end

		function arg_406_1.playNext_(arg_408_0)
			if arg_408_0 == 1 then
				arg_406_0:Play1108411099(arg_406_1)
			end
		end

		function arg_406_1.onSingleLineUpdate_(arg_409_0)
			local var_409_0 = 0.55

			if 0 < arg_406_1.time_ and arg_406_1.time_ <= 0 + arg_409_0 then
				arg_406_1.talkMaxDuration = 0
				arg_406_1.dialogCg_.alpha = 1

				arg_406_1.dialog_:SetActive(true)
				SetActive(arg_406_1.leftNameGo_, true)

				arg_406_1.leftNameTxt_.text = arg_406_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_406_1.leftNameTxt_.transform)

				arg_406_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_406_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_406_1:RecordName(arg_406_1.leftNameTxt_.text)
				SetActive(arg_406_1.iconTrs_.gameObject, false)
				arg_406_1.callingController_:SetSelectedState("normal")

				local var_409_1 = arg_406_1:GetWordFromCfg(1108411098)
				local var_409_2 = arg_406_1:FormatText(var_409_1.content)

				arg_406_1.text_.text = var_409_2

				LuaForUtil.ClearLinePrefixSymbol(arg_406_1.text_)

				local var_409_4 = 22 <= 0 and var_409_0 or var_409_0 * (utf8.len(var_409_2) / 22)

				if (22 <= 0 and var_409_0 or var_409_0 * (utf8.len(var_409_2) / 22)) > 0 and var_409_0 < var_409_4 then
					arg_406_1.talkMaxDuration = var_409_4

					if var_409_4 + 0 > arg_406_1.duration_ then
						arg_406_1.duration_ = var_409_4 + 0
					end
				end

				arg_406_1.text_.text = var_409_2
				arg_406_1.typewritter.percent = 0

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411098", "story_v_side_new_1108411.awb") ~= 0 then
					local var_409_5 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411098", "story_v_side_new_1108411.awb") / 1000

					if var_409_5 + 0 > arg_406_1.duration_ then
						arg_406_1.duration_ = var_409_5 + 0
					end

					if var_409_1.prefab_name ~= "" and arg_406_1.actors_[var_409_1.prefab_name] ~= nil then
						local var_409_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_406_1.actors_[var_409_1.prefab_name].transform, "story_v_side_new_1108411", "1108411098", "story_v_side_new_1108411.awb")

						arg_406_1:RecordAudio("1108411098", var_409_6)
						arg_406_1:RecordAudio("1108411098", var_409_6)
					else
						arg_406_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411098", "story_v_side_new_1108411.awb")
					end

					arg_406_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411098", "story_v_side_new_1108411.awb")
				end

				arg_406_1:RecordContent(arg_406_1.text_.text)
			end

			local var_409_7 = math.max(var_409_0, arg_406_1.talkMaxDuration)

			if 0 <= arg_406_1.time_ and arg_406_1.time_ < 0 + var_409_7 then
				arg_406_1.typewritter.percent = (arg_406_1.time_ - 0) / var_409_7

				arg_406_1.typewritter:SetDirty()
			end

			if arg_406_1.time_ >= 0 + var_409_7 and arg_406_1.time_ < 0 + var_409_7 + arg_409_0 then
				arg_406_1.typewritter.percent = 1

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(true)
			end
		end

		arg_406_1.nodeConfigList_ = {}

		arg_406_1:InitPlayNodeList()
	end,
	Play1108411099 = function(arg_410_0, arg_410_1)
		arg_410_1.time_ = 0
		arg_410_1.frameCnt_ = 0
		arg_410_1.state_ = "playing"
		arg_410_1.curTalkId_ = 1108411099
		arg_410_1.duration_ = 5

		SetActive(arg_410_1.tipsGo_, false)

		function arg_410_1.onSingleLineFinish_()
			arg_410_1.onSingleLineUpdate_ = nil
			arg_410_1.onSingleLineFinish_ = nil
			arg_410_1.state_ = "waiting"
		end

		function arg_410_1.playNext_(arg_412_0)
			if arg_412_0 == 1 then
				arg_410_0:Play1108411100(arg_410_1)
			end
		end

		function arg_410_1.onSingleLineUpdate_(arg_413_0)
			if 0 < arg_410_1.time_ and arg_410_1.time_ <= 0 + arg_413_0 and not isNil(arg_410_1.actors_["10102ui_story"]) and arg_410_1.var_.characterEffect10102ui_story == nil then
				arg_410_1.var_.characterEffect10102ui_story = arg_410_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_413_0 = 0.200000002980232

			if 0 <= arg_410_1.time_ and arg_410_1.time_ < 0 + var_413_0 and not isNil(arg_410_1.actors_["10102ui_story"]) then
				if arg_410_1.var_.characterEffect10102ui_story and not isNil(arg_410_1.actors_["10102ui_story"]) then
					arg_410_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_410_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_410_1.time_ - 0) / var_413_0)
				end
			end

			if arg_410_1.time_ >= 0 + var_413_0 and arg_410_1.time_ < 0 + var_413_0 + arg_413_0 and not isNil(arg_410_1.actors_["10102ui_story"]) and arg_410_1.var_.characterEffect10102ui_story then
				arg_410_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_410_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_413_1 = 0
			local var_413_2 = 0.25

			if 0 < arg_410_1.time_ and arg_410_1.time_ <= var_413_1 + arg_413_0 then
				arg_410_1.talkMaxDuration = 0
				arg_410_1.dialogCg_.alpha = 1

				arg_410_1.dialog_:SetActive(true)
				SetActive(arg_410_1.leftNameGo_, true)

				arg_410_1.leftNameTxt_.text = arg_410_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_410_1.leftNameTxt_.transform)

				arg_410_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_410_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_410_1:RecordName(arg_410_1.leftNameTxt_.text)
				SetActive(arg_410_1.iconTrs_.gameObject, true)
				arg_410_1.iconController_:SetSelectedState("hero")

				arg_410_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_410_1.callingController_:SetSelectedState("normal")

				arg_410_1.keyicon_.color = Color.New(1, 1, 1)
				arg_410_1.icon_.color = Color.New(1, 1, 1)

				local var_413_3 = arg_410_1:FormatText(arg_410_1:GetWordFromCfg(1108411099).content)

				arg_410_1.text_.text = var_413_3

				LuaForUtil.ClearLinePrefixSymbol(arg_410_1.text_)

				local var_413_5 = 10 <= 0 and var_413_2 or var_413_2 * (utf8.len(var_413_3) / 10)

				if (10 <= 0 and var_413_2 or var_413_2 * (utf8.len(var_413_3) / 10)) > 0 and var_413_2 < var_413_5 then
					arg_410_1.talkMaxDuration = var_413_5

					if var_413_5 + var_413_1 > arg_410_1.duration_ then
						arg_410_1.duration_ = var_413_5 + var_413_1
					end
				end

				arg_410_1.text_.text = var_413_3
				arg_410_1.typewritter.percent = 0

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(false)
				arg_410_1:RecordContent(arg_410_1.text_.text)
			end

			local var_413_6 = math.max(var_413_2, arg_410_1.talkMaxDuration)

			if var_413_1 <= arg_410_1.time_ and arg_410_1.time_ < var_413_1 + var_413_6 then
				arg_410_1.typewritter.percent = (arg_410_1.time_ - var_413_1) / var_413_6

				arg_410_1.typewritter:SetDirty()
			end

			if arg_410_1.time_ >= var_413_1 + var_413_6 and arg_410_1.time_ < var_413_1 + var_413_6 + arg_413_0 then
				arg_410_1.typewritter.percent = 1

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(true)
			end
		end

		arg_410_1.nodeConfigList_ = {}

		arg_410_1:InitPlayNodeList()
	end,
	Play1108411100 = function(arg_414_0, arg_414_1)
		arg_414_1.time_ = 0
		arg_414_1.frameCnt_ = 0
		arg_414_1.state_ = "playing"
		arg_414_1.curTalkId_ = 1108411100
		arg_414_1.duration_ = 5.1

		local var_414_0 = {
			zh = 5.1,
			ja = 4.6
		}
		local var_414_1 = manager.audio:GetLocalizationFlag()

		if var_414_0[var_414_1] ~= nil then
			arg_414_1.duration_ = var_414_0[var_414_1]
		end

		SetActive(arg_414_1.tipsGo_, false)

		function arg_414_1.onSingleLineFinish_()
			arg_414_1.onSingleLineUpdate_ = nil
			arg_414_1.onSingleLineFinish_ = nil
			arg_414_1.state_ = "waiting"
		end

		function arg_414_1.playNext_(arg_416_0)
			if arg_416_0 == 1 then
				arg_414_0:Play1108411101(arg_414_1)
			end
		end

		function arg_414_1.onSingleLineUpdate_(arg_417_0)
			if 0 < arg_414_1.time_ and arg_414_1.time_ <= 0 + arg_417_0 and not isNil(arg_414_1.actors_["10102ui_story"]) and arg_414_1.var_.characterEffect10102ui_story == nil then
				arg_414_1.var_.characterEffect10102ui_story = arg_414_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_417_0 = 0.200000002980232

			if 0 <= arg_414_1.time_ and arg_414_1.time_ < 0 + var_417_0 and not isNil(arg_414_1.actors_["10102ui_story"]) then
				if arg_414_1.var_.characterEffect10102ui_story and not isNil(arg_414_1.actors_["10102ui_story"]) then
					arg_414_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_414_1.time_ >= 0 + var_417_0 and arg_414_1.time_ < 0 + var_417_0 + arg_417_0 and not isNil(arg_414_1.actors_["10102ui_story"]) and arg_414_1.var_.characterEffect10102ui_story then
				arg_414_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_414_1.time_ and arg_414_1.time_ <= 0 + arg_417_0 then
				arg_414_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			if 0 < arg_414_1.time_ and arg_414_1.time_ <= 0 + arg_417_0 then
				arg_414_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action5_1")
			end

			local var_417_2 = 0
			local var_417_3 = 0.65

			if 0 < arg_414_1.time_ and arg_414_1.time_ <= var_417_2 + arg_417_0 then
				arg_414_1.talkMaxDuration = 0
				arg_414_1.dialogCg_.alpha = 1

				arg_414_1.dialog_:SetActive(true)
				SetActive(arg_414_1.leftNameGo_, true)

				arg_414_1.leftNameTxt_.text = arg_414_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_414_1.leftNameTxt_.transform)

				arg_414_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_414_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_414_1:RecordName(arg_414_1.leftNameTxt_.text)
				SetActive(arg_414_1.iconTrs_.gameObject, false)
				arg_414_1.callingController_:SetSelectedState("normal")

				local var_417_4 = arg_414_1:GetWordFromCfg(1108411100)
				local var_417_5 = arg_414_1:FormatText(var_417_4.content)

				arg_414_1.text_.text = var_417_5

				LuaForUtil.ClearLinePrefixSymbol(arg_414_1.text_)

				local var_417_7 = 26 <= 0 and var_417_3 or var_417_3 * (utf8.len(var_417_5) / 26)

				if (26 <= 0 and var_417_3 or var_417_3 * (utf8.len(var_417_5) / 26)) > 0 and var_417_3 < var_417_7 then
					arg_414_1.talkMaxDuration = var_417_7

					if var_417_7 + var_417_2 > arg_414_1.duration_ then
						arg_414_1.duration_ = var_417_7 + var_417_2
					end
				end

				arg_414_1.text_.text = var_417_5
				arg_414_1.typewritter.percent = 0

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411100", "story_v_side_new_1108411.awb") ~= 0 then
					local var_417_8 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411100", "story_v_side_new_1108411.awb") / 1000

					if var_417_8 + var_417_2 > arg_414_1.duration_ then
						arg_414_1.duration_ = var_417_8 + var_417_2
					end

					if var_417_4.prefab_name ~= "" and arg_414_1.actors_[var_417_4.prefab_name] ~= nil then
						local var_417_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_414_1.actors_[var_417_4.prefab_name].transform, "story_v_side_new_1108411", "1108411100", "story_v_side_new_1108411.awb")

						arg_414_1:RecordAudio("1108411100", var_417_9)
						arg_414_1:RecordAudio("1108411100", var_417_9)
					else
						arg_414_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411100", "story_v_side_new_1108411.awb")
					end

					arg_414_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411100", "story_v_side_new_1108411.awb")
				end

				arg_414_1:RecordContent(arg_414_1.text_.text)
			end

			local var_417_10 = math.max(var_417_3, arg_414_1.talkMaxDuration)

			if var_417_2 <= arg_414_1.time_ and arg_414_1.time_ < var_417_2 + var_417_10 then
				arg_414_1.typewritter.percent = (arg_414_1.time_ - var_417_2) / var_417_10

				arg_414_1.typewritter:SetDirty()
			end

			if arg_414_1.time_ >= var_417_2 + var_417_10 and arg_414_1.time_ < var_417_2 + var_417_10 + arg_417_0 then
				arg_414_1.typewritter.percent = 1

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(true)
			end
		end

		arg_414_1.nodeConfigList_ = {}

		arg_414_1:InitPlayNodeList()
	end,
	Play1108411101 = function(arg_418_0, arg_418_1)
		arg_418_1.time_ = 0
		arg_418_1.frameCnt_ = 0
		arg_418_1.state_ = "playing"
		arg_418_1.curTalkId_ = 1108411101
		arg_418_1.duration_ = 7.27

		local var_418_0 = {
			zh = 4.733,
			ja = 7.266
		}
		local var_418_1 = manager.audio:GetLocalizationFlag()

		if var_418_0[var_418_1] ~= nil then
			arg_418_1.duration_ = var_418_0[var_418_1]
		end

		SetActive(arg_418_1.tipsGo_, false)

		function arg_418_1.onSingleLineFinish_()
			arg_418_1.onSingleLineUpdate_ = nil
			arg_418_1.onSingleLineFinish_ = nil
			arg_418_1.state_ = "waiting"
		end

		function arg_418_1.playNext_(arg_420_0)
			if arg_420_0 == 1 then
				arg_418_0:Play1108411102(arg_418_1)
			end
		end

		function arg_418_1.onSingleLineUpdate_(arg_421_0)
			if 0 < arg_418_1.time_ and arg_418_1.time_ <= 0 + arg_421_0 then
				arg_418_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action5_2")
			end

			local var_421_0 = 0
			local var_421_1 = 0.575

			if 0 < arg_418_1.time_ and arg_418_1.time_ <= var_421_0 + arg_421_0 then
				arg_418_1.talkMaxDuration = 0
				arg_418_1.dialogCg_.alpha = 1

				arg_418_1.dialog_:SetActive(true)
				SetActive(arg_418_1.leftNameGo_, true)

				arg_418_1.leftNameTxt_.text = arg_418_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_418_1.leftNameTxt_.transform)

				arg_418_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_418_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_418_1:RecordName(arg_418_1.leftNameTxt_.text)
				SetActive(arg_418_1.iconTrs_.gameObject, false)
				arg_418_1.callingController_:SetSelectedState("normal")

				local var_421_2 = arg_418_1:GetWordFromCfg(1108411101)
				local var_421_3 = arg_418_1:FormatText(var_421_2.content)

				arg_418_1.text_.text = var_421_3

				LuaForUtil.ClearLinePrefixSymbol(arg_418_1.text_)

				local var_421_5 = 23 <= 0 and var_421_1 or var_421_1 * (utf8.len(var_421_3) / 23)

				if (23 <= 0 and var_421_1 or var_421_1 * (utf8.len(var_421_3) / 23)) > 0 and var_421_1 < var_421_5 then
					arg_418_1.talkMaxDuration = var_421_5

					if var_421_5 + var_421_0 > arg_418_1.duration_ then
						arg_418_1.duration_ = var_421_5 + var_421_0
					end
				end

				arg_418_1.text_.text = var_421_3
				arg_418_1.typewritter.percent = 0

				arg_418_1.typewritter:SetDirty()
				arg_418_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411101", "story_v_side_new_1108411.awb") ~= 0 then
					local var_421_6 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411101", "story_v_side_new_1108411.awb") / 1000

					if var_421_6 + var_421_0 > arg_418_1.duration_ then
						arg_418_1.duration_ = var_421_6 + var_421_0
					end

					if var_421_2.prefab_name ~= "" and arg_418_1.actors_[var_421_2.prefab_name] ~= nil then
						local var_421_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_418_1.actors_[var_421_2.prefab_name].transform, "story_v_side_new_1108411", "1108411101", "story_v_side_new_1108411.awb")

						arg_418_1:RecordAudio("1108411101", var_421_7)
						arg_418_1:RecordAudio("1108411101", var_421_7)
					else
						arg_418_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411101", "story_v_side_new_1108411.awb")
					end

					arg_418_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411101", "story_v_side_new_1108411.awb")
				end

				arg_418_1:RecordContent(arg_418_1.text_.text)
			end

			local var_421_8 = math.max(var_421_1, arg_418_1.talkMaxDuration)

			if var_421_0 <= arg_418_1.time_ and arg_418_1.time_ < var_421_0 + var_421_8 then
				arg_418_1.typewritter.percent = (arg_418_1.time_ - var_421_0) / var_421_8

				arg_418_1.typewritter:SetDirty()
			end

			if arg_418_1.time_ >= var_421_0 + var_421_8 and arg_418_1.time_ < var_421_0 + var_421_8 + arg_421_0 then
				arg_418_1.typewritter.percent = 1

				arg_418_1.typewritter:SetDirty()
				arg_418_1:ShowNextGo(true)
			end
		end

		arg_418_1.nodeConfigList_ = {}

		arg_418_1:InitPlayNodeList()
	end,
	Play1108411102 = function(arg_422_0, arg_422_1)
		arg_422_1.time_ = 0
		arg_422_1.frameCnt_ = 0
		arg_422_1.state_ = "playing"
		arg_422_1.curTalkId_ = 1108411102
		arg_422_1.duration_ = 5

		SetActive(arg_422_1.tipsGo_, false)

		function arg_422_1.onSingleLineFinish_()
			arg_422_1.onSingleLineUpdate_ = nil
			arg_422_1.onSingleLineFinish_ = nil
			arg_422_1.state_ = "waiting"
		end

		function arg_422_1.playNext_(arg_424_0)
			if arg_424_0 == 1 then
				arg_422_0:Play1108411103(arg_422_1)
			end
		end

		function arg_422_1.onSingleLineUpdate_(arg_425_0)
			if 0 < arg_422_1.time_ and arg_422_1.time_ <= 0 + arg_425_0 and not isNil(arg_422_1.actors_["10102ui_story"]) and arg_422_1.var_.characterEffect10102ui_story == nil then
				arg_422_1.var_.characterEffect10102ui_story = arg_422_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_425_0 = 0.200000002980232

			if 0 <= arg_422_1.time_ and arg_422_1.time_ < 0 + var_425_0 and not isNil(arg_422_1.actors_["10102ui_story"]) then
				if arg_422_1.var_.characterEffect10102ui_story and not isNil(arg_422_1.actors_["10102ui_story"]) then
					arg_422_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_422_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_422_1.time_ - 0) / var_425_0)
				end
			end

			if arg_422_1.time_ >= 0 + var_425_0 and arg_422_1.time_ < 0 + var_425_0 + arg_425_0 and not isNil(arg_422_1.actors_["10102ui_story"]) and arg_422_1.var_.characterEffect10102ui_story then
				arg_422_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_422_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_425_1 = 0
			local var_425_2 = 0.325

			if 0 < arg_422_1.time_ and arg_422_1.time_ <= var_425_1 + arg_425_0 then
				arg_422_1.talkMaxDuration = 0
				arg_422_1.dialogCg_.alpha = 1

				arg_422_1.dialog_:SetActive(true)
				SetActive(arg_422_1.leftNameGo_, true)

				arg_422_1.leftNameTxt_.text = arg_422_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_422_1.leftNameTxt_.transform)

				arg_422_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_422_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_422_1:RecordName(arg_422_1.leftNameTxt_.text)
				SetActive(arg_422_1.iconTrs_.gameObject, true)
				arg_422_1.iconController_:SetSelectedState("hero")

				arg_422_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_422_1.callingController_:SetSelectedState("normal")

				arg_422_1.keyicon_.color = Color.New(1, 1, 1)
				arg_422_1.icon_.color = Color.New(1, 1, 1)

				local var_425_3 = arg_422_1:FormatText(arg_422_1:GetWordFromCfg(1108411102).content)

				arg_422_1.text_.text = var_425_3

				LuaForUtil.ClearLinePrefixSymbol(arg_422_1.text_)

				local var_425_5 = 13 <= 0 and var_425_2 or var_425_2 * (utf8.len(var_425_3) / 13)

				if (13 <= 0 and var_425_2 or var_425_2 * (utf8.len(var_425_3) / 13)) > 0 and var_425_2 < var_425_5 then
					arg_422_1.talkMaxDuration = var_425_5

					if var_425_5 + var_425_1 > arg_422_1.duration_ then
						arg_422_1.duration_ = var_425_5 + var_425_1
					end
				end

				arg_422_1.text_.text = var_425_3
				arg_422_1.typewritter.percent = 0

				arg_422_1.typewritter:SetDirty()
				arg_422_1:ShowNextGo(false)
				arg_422_1:RecordContent(arg_422_1.text_.text)
			end

			local var_425_6 = math.max(var_425_2, arg_422_1.talkMaxDuration)

			if var_425_1 <= arg_422_1.time_ and arg_422_1.time_ < var_425_1 + var_425_6 then
				arg_422_1.typewritter.percent = (arg_422_1.time_ - var_425_1) / var_425_6

				arg_422_1.typewritter:SetDirty()
			end

			if arg_422_1.time_ >= var_425_1 + var_425_6 and arg_422_1.time_ < var_425_1 + var_425_6 + arg_425_0 then
				arg_422_1.typewritter.percent = 1

				arg_422_1.typewritter:SetDirty()
				arg_422_1:ShowNextGo(true)
			end
		end

		arg_422_1.nodeConfigList_ = {}

		arg_422_1:InitPlayNodeList()
	end,
	Play1108411103 = function(arg_426_0, arg_426_1)
		arg_426_1.time_ = 0
		arg_426_1.frameCnt_ = 0
		arg_426_1.state_ = "playing"
		arg_426_1.curTalkId_ = 1108411103
		arg_426_1.duration_ = 5

		SetActive(arg_426_1.tipsGo_, false)

		function arg_426_1.onSingleLineFinish_()
			arg_426_1.onSingleLineUpdate_ = nil
			arg_426_1.onSingleLineFinish_ = nil
			arg_426_1.state_ = "waiting"
		end

		function arg_426_1.playNext_(arg_428_0)
			if arg_428_0 == 1 then
				arg_426_0:Play1108411104(arg_426_1)
			end
		end

		function arg_426_1.onSingleLineUpdate_(arg_429_0)
			local var_429_0 = 0.425

			if 0 < arg_426_1.time_ and arg_426_1.time_ <= 0 + arg_429_0 then
				arg_426_1.talkMaxDuration = 0
				arg_426_1.dialogCg_.alpha = 1

				arg_426_1.dialog_:SetActive(true)
				SetActive(arg_426_1.leftNameGo_, true)

				arg_426_1.leftNameTxt_.text = arg_426_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_426_1.leftNameTxt_.transform)

				arg_426_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_426_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_426_1:RecordName(arg_426_1.leftNameTxt_.text)
				SetActive(arg_426_1.iconTrs_.gameObject, true)
				arg_426_1.iconController_:SetSelectedState("hero")

				arg_426_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_426_1.callingController_:SetSelectedState("normal")

				arg_426_1.keyicon_.color = Color.New(1, 1, 1)
				arg_426_1.icon_.color = Color.New(1, 1, 1)

				local var_429_1 = arg_426_1:FormatText(arg_426_1:GetWordFromCfg(1108411103).content)

				arg_426_1.text_.text = var_429_1

				LuaForUtil.ClearLinePrefixSymbol(arg_426_1.text_)

				local var_429_3 = 17 <= 0 and var_429_0 or var_429_0 * (utf8.len(var_429_1) / 17)

				if (17 <= 0 and var_429_0 or var_429_0 * (utf8.len(var_429_1) / 17)) > 0 and var_429_0 < var_429_3 then
					arg_426_1.talkMaxDuration = var_429_3

					if var_429_3 + 0 > arg_426_1.duration_ then
						arg_426_1.duration_ = var_429_3 + 0
					end
				end

				arg_426_1.text_.text = var_429_1
				arg_426_1.typewritter.percent = 0

				arg_426_1.typewritter:SetDirty()
				arg_426_1:ShowNextGo(false)
				arg_426_1:RecordContent(arg_426_1.text_.text)
			end

			local var_429_4 = math.max(var_429_0, arg_426_1.talkMaxDuration)

			if 0 <= arg_426_1.time_ and arg_426_1.time_ < 0 + var_429_4 then
				arg_426_1.typewritter.percent = (arg_426_1.time_ - 0) / var_429_4

				arg_426_1.typewritter:SetDirty()
			end

			if arg_426_1.time_ >= 0 + var_429_4 and arg_426_1.time_ < 0 + var_429_4 + arg_429_0 then
				arg_426_1.typewritter.percent = 1

				arg_426_1.typewritter:SetDirty()
				arg_426_1:ShowNextGo(true)
			end
		end

		arg_426_1.nodeConfigList_ = {}

		arg_426_1:InitPlayNodeList()
	end,
	Play1108411104 = function(arg_430_0, arg_430_1)
		arg_430_1.time_ = 0
		arg_430_1.frameCnt_ = 0
		arg_430_1.state_ = "playing"
		arg_430_1.curTalkId_ = 1108411104
		arg_430_1.duration_ = 5

		SetActive(arg_430_1.tipsGo_, false)

		function arg_430_1.onSingleLineFinish_()
			arg_430_1.onSingleLineUpdate_ = nil
			arg_430_1.onSingleLineFinish_ = nil
			arg_430_1.state_ = "waiting"
		end

		function arg_430_1.playNext_(arg_432_0)
			if arg_432_0 == 1 then
				arg_430_0:Play1108411105(arg_430_1)
			end
		end

		function arg_430_1.onSingleLineUpdate_(arg_433_0)
			if 0 < arg_430_1.time_ and arg_430_1.time_ <= 0 + arg_433_0 then
				arg_430_1.var_.moveOldPos10102ui_story = arg_430_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_433_0 = 0.001

			if 0 <= arg_430_1.time_ and arg_430_1.time_ < 0 + var_433_0 then
				arg_430_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_430_1.var_.moveOldPos10102ui_story, Vector3.New(0, 100, 0), (arg_430_1.time_ - 0) / var_433_0)
				arg_430_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_430_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_430_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_430_1.actors_["10102ui_story"].transform.position).z)
				arg_430_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_430_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_430_1.actors_["10102ui_story"].transform.localEulerAngles = arg_430_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_430_1.time_ >= 0 + var_433_0 and arg_430_1.time_ < 0 + var_433_0 + arg_433_0 then
				arg_430_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_430_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_430_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_430_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_430_1.actors_["10102ui_story"].transform.position).z)
				arg_430_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_430_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_430_1.actors_["10102ui_story"].transform.localEulerAngles = arg_430_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_433_1 = 0
			local var_433_2 = 1.575

			if 0 < arg_430_1.time_ and arg_430_1.time_ <= var_433_1 + arg_433_0 then
				arg_430_1.talkMaxDuration = 0
				arg_430_1.dialogCg_.alpha = 1

				arg_430_1.dialog_:SetActive(true)
				SetActive(arg_430_1.leftNameGo_, false)

				arg_430_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_430_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_430_1:RecordName(arg_430_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_430_1.iconTrs_.gameObject, false)
				arg_430_1.callingController_:SetSelectedState("normal")

				local var_433_3 = arg_430_1:FormatText(arg_430_1:GetWordFromCfg(1108411104).content)

				arg_430_1.text_.text = var_433_3

				LuaForUtil.ClearLinePrefixSymbol(arg_430_1.text_)

				local var_433_5 = 63 <= 0 and var_433_2 or var_433_2 * (utf8.len(var_433_3) / 63)

				if (63 <= 0 and var_433_2 or var_433_2 * (utf8.len(var_433_3) / 63)) > 0 and var_433_2 < var_433_5 then
					arg_430_1.talkMaxDuration = var_433_5

					if var_433_5 + var_433_1 > arg_430_1.duration_ then
						arg_430_1.duration_ = var_433_5 + var_433_1
					end
				end

				arg_430_1.text_.text = var_433_3
				arg_430_1.typewritter.percent = 0

				arg_430_1.typewritter:SetDirty()
				arg_430_1:ShowNextGo(false)
				arg_430_1:RecordContent(arg_430_1.text_.text)
			end

			local var_433_6 = math.max(var_433_2, arg_430_1.talkMaxDuration)

			if var_433_1 <= arg_430_1.time_ and arg_430_1.time_ < var_433_1 + var_433_6 then
				arg_430_1.typewritter.percent = (arg_430_1.time_ - var_433_1) / var_433_6

				arg_430_1.typewritter:SetDirty()
			end

			if arg_430_1.time_ >= var_433_1 + var_433_6 and arg_430_1.time_ < var_433_1 + var_433_6 + arg_433_0 then
				arg_430_1.typewritter.percent = 1

				arg_430_1.typewritter:SetDirty()
				arg_430_1:ShowNextGo(true)
			end
		end

		arg_430_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_430_1:InitPlayNodeList()
	end,
	Play1108411105 = function(arg_434_0, arg_434_1)
		arg_434_1.time_ = 0
		arg_434_1.frameCnt_ = 0
		arg_434_1.state_ = "playing"
		arg_434_1.curTalkId_ = 1108411105
		arg_434_1.duration_ = 1.6

		local var_434_0 = {
			zh = 1.6,
			ja = 1.266
		}
		local var_434_1 = manager.audio:GetLocalizationFlag()

		if var_434_0[var_434_1] ~= nil then
			arg_434_1.duration_ = var_434_0[var_434_1]
		end

		SetActive(arg_434_1.tipsGo_, false)

		function arg_434_1.onSingleLineFinish_()
			arg_434_1.onSingleLineUpdate_ = nil
			arg_434_1.onSingleLineFinish_ = nil
			arg_434_1.state_ = "waiting"
		end

		function arg_434_1.playNext_(arg_436_0)
			if arg_436_0 == 1 then
				arg_434_0:Play1108411106(arg_434_1)
			end
		end

		function arg_434_1.onSingleLineUpdate_(arg_437_0)
			if 0 < arg_434_1.time_ and arg_434_1.time_ <= 0 + arg_437_0 and not isNil(arg_434_1.actors_["10102ui_story"]) and arg_434_1.var_.characterEffect10102ui_story == nil then
				arg_434_1.var_.characterEffect10102ui_story = arg_434_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_437_0 = 0.200000002980232

			if 0 <= arg_434_1.time_ and arg_434_1.time_ < 0 + var_437_0 and not isNil(arg_434_1.actors_["10102ui_story"]) then
				if arg_434_1.var_.characterEffect10102ui_story and not isNil(arg_434_1.actors_["10102ui_story"]) then
					arg_434_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_434_1.time_ >= 0 + var_437_0 and arg_434_1.time_ < 0 + var_437_0 + arg_437_0 and not isNil(arg_434_1.actors_["10102ui_story"]) and arg_434_1.var_.characterEffect10102ui_story then
				arg_434_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_437_2 = 0
			local var_437_3 = 0.05

			if 0 < arg_434_1.time_ and arg_434_1.time_ <= var_437_2 + arg_437_0 then
				arg_434_1.talkMaxDuration = 0
				arg_434_1.dialogCg_.alpha = 1

				arg_434_1.dialog_:SetActive(true)
				SetActive(arg_434_1.leftNameGo_, true)

				arg_434_1.leftNameTxt_.text = arg_434_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_434_1.leftNameTxt_.transform)

				arg_434_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_434_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_434_1:RecordName(arg_434_1.leftNameTxt_.text)
				SetActive(arg_434_1.iconTrs_.gameObject, true)
				arg_434_1.iconController_:SetSelectedState("hero")

				arg_434_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10102_split_4")

				arg_434_1.callingController_:SetSelectedState("normal")

				arg_434_1.keyicon_.color = Color.New(1, 1, 1)
				arg_434_1.icon_.color = Color.New(1, 1, 1)

				local var_437_4 = arg_434_1:GetWordFromCfg(1108411105)
				local var_437_5 = arg_434_1:FormatText(var_437_4.content)

				arg_434_1.text_.text = var_437_5

				LuaForUtil.ClearLinePrefixSymbol(arg_434_1.text_)

				local var_437_7 = 2 <= 0 and var_437_3 or var_437_3 * (utf8.len(var_437_5) / 2)

				if (2 <= 0 and var_437_3 or var_437_3 * (utf8.len(var_437_5) / 2)) > 0 and var_437_3 < var_437_7 then
					arg_434_1.talkMaxDuration = var_437_7

					if var_437_7 + var_437_2 > arg_434_1.duration_ then
						arg_434_1.duration_ = var_437_7 + var_437_2
					end
				end

				arg_434_1.text_.text = var_437_5
				arg_434_1.typewritter.percent = 0

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411105", "story_v_side_new_1108411.awb") ~= 0 then
					local var_437_8 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411105", "story_v_side_new_1108411.awb") / 1000

					if var_437_8 + var_437_2 > arg_434_1.duration_ then
						arg_434_1.duration_ = var_437_8 + var_437_2
					end

					if var_437_4.prefab_name ~= "" and arg_434_1.actors_[var_437_4.prefab_name] ~= nil then
						local var_437_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_434_1.actors_[var_437_4.prefab_name].transform, "story_v_side_new_1108411", "1108411105", "story_v_side_new_1108411.awb")

						arg_434_1:RecordAudio("1108411105", var_437_9)
						arg_434_1:RecordAudio("1108411105", var_437_9)
					else
						arg_434_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411105", "story_v_side_new_1108411.awb")
					end

					arg_434_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411105", "story_v_side_new_1108411.awb")
				end

				arg_434_1:RecordContent(arg_434_1.text_.text)
			end

			local var_437_10 = math.max(var_437_3, arg_434_1.talkMaxDuration)

			if var_437_2 <= arg_434_1.time_ and arg_434_1.time_ < var_437_2 + var_437_10 then
				arg_434_1.typewritter.percent = (arg_434_1.time_ - var_437_2) / var_437_10

				arg_434_1.typewritter:SetDirty()
			end

			if arg_434_1.time_ >= var_437_2 + var_437_10 and arg_434_1.time_ < var_437_2 + var_437_10 + arg_437_0 then
				arg_434_1.typewritter.percent = 1

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(true)
			end
		end

		arg_434_1.nodeConfigList_ = {}

		arg_434_1:InitPlayNodeList()
	end,
	Play1108411106 = function(arg_438_0, arg_438_1)
		arg_438_1.time_ = 0
		arg_438_1.frameCnt_ = 0
		arg_438_1.state_ = "playing"
		arg_438_1.curTalkId_ = 1108411106
		arg_438_1.duration_ = 5

		SetActive(arg_438_1.tipsGo_, false)

		function arg_438_1.onSingleLineFinish_()
			arg_438_1.onSingleLineUpdate_ = nil
			arg_438_1.onSingleLineFinish_ = nil
			arg_438_1.state_ = "waiting"
		end

		function arg_438_1.playNext_(arg_440_0)
			if arg_440_0 == 1 then
				arg_438_0:Play1108411107(arg_438_1)
			end
		end

		function arg_438_1.onSingleLineUpdate_(arg_441_0)
			if 0 < arg_438_1.time_ and arg_438_1.time_ <= 0 + arg_441_0 and not isNil(arg_438_1.actors_["10102ui_story"]) and arg_438_1.var_.characterEffect10102ui_story == nil then
				arg_438_1.var_.characterEffect10102ui_story = arg_438_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_441_0 = 0.200000002980232

			if 0 <= arg_438_1.time_ and arg_438_1.time_ < 0 + var_441_0 and not isNil(arg_438_1.actors_["10102ui_story"]) then
				if arg_438_1.var_.characterEffect10102ui_story and not isNil(arg_438_1.actors_["10102ui_story"]) then
					arg_438_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_438_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_438_1.time_ - 0) / var_441_0)
				end
			end

			if arg_438_1.time_ >= 0 + var_441_0 and arg_438_1.time_ < 0 + var_441_0 + arg_441_0 and not isNil(arg_438_1.actors_["10102ui_story"]) and arg_438_1.var_.characterEffect10102ui_story then
				arg_438_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_438_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_441_1 = 0
			local var_441_2 = 0.25

			if 0 < arg_438_1.time_ and arg_438_1.time_ <= var_441_1 + arg_441_0 then
				arg_438_1.talkMaxDuration = 0
				arg_438_1.dialogCg_.alpha = 1

				arg_438_1.dialog_:SetActive(true)
				SetActive(arg_438_1.leftNameGo_, true)

				arg_438_1.leftNameTxt_.text = arg_438_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_438_1.leftNameTxt_.transform)

				arg_438_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_438_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_438_1:RecordName(arg_438_1.leftNameTxt_.text)
				SetActive(arg_438_1.iconTrs_.gameObject, true)
				arg_438_1.iconController_:SetSelectedState("hero")

				arg_438_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_438_1.callingController_:SetSelectedState("normal")

				arg_438_1.keyicon_.color = Color.New(1, 1, 1)
				arg_438_1.icon_.color = Color.New(1, 1, 1)

				local var_441_3 = arg_438_1:FormatText(arg_438_1:GetWordFromCfg(1108411106).content)

				arg_438_1.text_.text = var_441_3

				LuaForUtil.ClearLinePrefixSymbol(arg_438_1.text_)

				local var_441_5 = 10 <= 0 and var_441_2 or var_441_2 * (utf8.len(var_441_3) / 10)

				if (10 <= 0 and var_441_2 or var_441_2 * (utf8.len(var_441_3) / 10)) > 0 and var_441_2 < var_441_5 then
					arg_438_1.talkMaxDuration = var_441_5

					if var_441_5 + var_441_1 > arg_438_1.duration_ then
						arg_438_1.duration_ = var_441_5 + var_441_1
					end
				end

				arg_438_1.text_.text = var_441_3
				arg_438_1.typewritter.percent = 0

				arg_438_1.typewritter:SetDirty()
				arg_438_1:ShowNextGo(false)
				arg_438_1:RecordContent(arg_438_1.text_.text)
			end

			local var_441_6 = math.max(var_441_2, arg_438_1.talkMaxDuration)

			if var_441_1 <= arg_438_1.time_ and arg_438_1.time_ < var_441_1 + var_441_6 then
				arg_438_1.typewritter.percent = (arg_438_1.time_ - var_441_1) / var_441_6

				arg_438_1.typewritter:SetDirty()
			end

			if arg_438_1.time_ >= var_441_1 + var_441_6 and arg_438_1.time_ < var_441_1 + var_441_6 + arg_441_0 then
				arg_438_1.typewritter.percent = 1

				arg_438_1.typewritter:SetDirty()
				arg_438_1:ShowNextGo(true)
			end
		end

		arg_438_1.nodeConfigList_ = {}

		arg_438_1:InitPlayNodeList()
	end,
	Play1108411107 = function(arg_442_0, arg_442_1)
		arg_442_1.time_ = 0
		arg_442_1.frameCnt_ = 0
		arg_442_1.state_ = "playing"
		arg_442_1.curTalkId_ = 1108411107
		arg_442_1.duration_ = 8.97

		local var_442_0 = {
			zh = 7.133,
			ja = 8.966
		}
		local var_442_1 = manager.audio:GetLocalizationFlag()

		if var_442_0[var_442_1] ~= nil then
			arg_442_1.duration_ = var_442_0[var_442_1]
		end

		SetActive(arg_442_1.tipsGo_, false)

		function arg_442_1.onSingleLineFinish_()
			arg_442_1.onSingleLineUpdate_ = nil
			arg_442_1.onSingleLineFinish_ = nil
			arg_442_1.state_ = "waiting"
		end

		function arg_442_1.playNext_(arg_444_0)
			if arg_444_0 == 1 then
				arg_442_0:Play1108411108(arg_442_1)
			end
		end

		function arg_442_1.onSingleLineUpdate_(arg_445_0)
			if 0 < arg_442_1.time_ and arg_442_1.time_ <= 0 + arg_445_0 then
				arg_442_1.var_.moveOldPos10102ui_story = arg_442_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_445_0 = 0.001

			if 0 <= arg_442_1.time_ and arg_442_1.time_ < 0 + var_445_0 then
				arg_442_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_442_1.var_.moveOldPos10102ui_story, Vector3.New(0, -0.985, -6.275), (arg_442_1.time_ - 0) / var_445_0)
				arg_442_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_442_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_442_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_442_1.actors_["10102ui_story"].transform.position).z)
				arg_442_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_442_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_442_1.actors_["10102ui_story"].transform.localEulerAngles = arg_442_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_442_1.time_ >= 0 + var_445_0 and arg_442_1.time_ < 0 + var_445_0 + arg_445_0 then
				arg_442_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6.275)
				arg_442_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_442_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_442_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_442_1.actors_["10102ui_story"].transform.position).z)
				arg_442_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_442_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_442_1.actors_["10102ui_story"].transform.localEulerAngles = arg_442_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_445_1 = arg_442_1.actors_["10102ui_story"]

			if 0 < arg_442_1.time_ and arg_442_1.time_ <= 0 + arg_445_0 and not isNil(var_445_1) and arg_442_1.var_.characterEffect10102ui_story == nil then
				arg_442_1.var_.characterEffect10102ui_story = var_445_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_445_2 = 0.200000002980232

			if 0 <= arg_442_1.time_ and arg_442_1.time_ < 0 + var_445_2 and not isNil(var_445_1) then
				if arg_442_1.var_.characterEffect10102ui_story and not isNil(var_445_1) then
					arg_442_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_442_1.time_ >= 0 + var_445_2 and arg_442_1.time_ < 0 + var_445_2 + arg_445_0 and not isNil(var_445_1) and arg_442_1.var_.characterEffect10102ui_story then
				arg_442_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_442_1.time_ and arg_442_1.time_ <= 0 + arg_445_0 then
				arg_442_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action4_1")
			end

			if 0 < arg_442_1.time_ and arg_442_1.time_ <= 0 + arg_445_0 then
				arg_442_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_445_4 = 0
			local var_445_5 = 0.875

			if 0 < arg_442_1.time_ and arg_442_1.time_ <= var_445_4 + arg_445_0 then
				arg_442_1.talkMaxDuration = 0
				arg_442_1.dialogCg_.alpha = 1

				arg_442_1.dialog_:SetActive(true)
				SetActive(arg_442_1.leftNameGo_, true)

				arg_442_1.leftNameTxt_.text = arg_442_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_442_1.leftNameTxt_.transform)

				arg_442_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_442_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_442_1:RecordName(arg_442_1.leftNameTxt_.text)
				SetActive(arg_442_1.iconTrs_.gameObject, false)
				arg_442_1.callingController_:SetSelectedState("normal")

				local var_445_6 = arg_442_1:GetWordFromCfg(1108411107)
				local var_445_7 = arg_442_1:FormatText(var_445_6.content)

				arg_442_1.text_.text = var_445_7

				LuaForUtil.ClearLinePrefixSymbol(arg_442_1.text_)

				local var_445_9 = 35 <= 0 and var_445_5 or var_445_5 * (utf8.len(var_445_7) / 35)

				if (35 <= 0 and var_445_5 or var_445_5 * (utf8.len(var_445_7) / 35)) > 0 and var_445_5 < var_445_9 then
					arg_442_1.talkMaxDuration = var_445_9

					if var_445_9 + var_445_4 > arg_442_1.duration_ then
						arg_442_1.duration_ = var_445_9 + var_445_4
					end
				end

				arg_442_1.text_.text = var_445_7
				arg_442_1.typewritter.percent = 0

				arg_442_1.typewritter:SetDirty()
				arg_442_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411107", "story_v_side_new_1108411.awb") ~= 0 then
					local var_445_10 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411107", "story_v_side_new_1108411.awb") / 1000

					if var_445_10 + var_445_4 > arg_442_1.duration_ then
						arg_442_1.duration_ = var_445_10 + var_445_4
					end

					if var_445_6.prefab_name ~= "" and arg_442_1.actors_[var_445_6.prefab_name] ~= nil then
						local var_445_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_442_1.actors_[var_445_6.prefab_name].transform, "story_v_side_new_1108411", "1108411107", "story_v_side_new_1108411.awb")

						arg_442_1:RecordAudio("1108411107", var_445_11)
						arg_442_1:RecordAudio("1108411107", var_445_11)
					else
						arg_442_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411107", "story_v_side_new_1108411.awb")
					end

					arg_442_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411107", "story_v_side_new_1108411.awb")
				end

				arg_442_1:RecordContent(arg_442_1.text_.text)
			end

			local var_445_12 = math.max(var_445_5, arg_442_1.talkMaxDuration)

			if var_445_4 <= arg_442_1.time_ and arg_442_1.time_ < var_445_4 + var_445_12 then
				arg_442_1.typewritter.percent = (arg_442_1.time_ - var_445_4) / var_445_12

				arg_442_1.typewritter:SetDirty()
			end

			if arg_442_1.time_ >= var_445_4 + var_445_12 and arg_442_1.time_ < var_445_4 + var_445_12 + arg_445_0 then
				arg_442_1.typewritter.percent = 1

				arg_442_1.typewritter:SetDirty()
				arg_442_1:ShowNextGo(true)
			end
		end

		arg_442_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_442_1:InitPlayNodeList()
	end,
	Play1108411108 = function(arg_446_0, arg_446_1)
		arg_446_1.time_ = 0
		arg_446_1.frameCnt_ = 0
		arg_446_1.state_ = "playing"
		arg_446_1.curTalkId_ = 1108411108
		arg_446_1.duration_ = 6.63

		local var_446_0 = {
			zh = 5,
			ja = 6.633
		}
		local var_446_1 = manager.audio:GetLocalizationFlag()

		if var_446_0[var_446_1] ~= nil then
			arg_446_1.duration_ = var_446_0[var_446_1]
		end

		SetActive(arg_446_1.tipsGo_, false)

		function arg_446_1.onSingleLineFinish_()
			arg_446_1.onSingleLineUpdate_ = nil
			arg_446_1.onSingleLineFinish_ = nil
			arg_446_1.state_ = "waiting"
		end

		function arg_446_1.playNext_(arg_448_0)
			if arg_448_0 == 1 then
				arg_446_0:Play1108411109(arg_446_1)
			end
		end

		function arg_446_1.onSingleLineUpdate_(arg_449_0)
			local var_449_0 = 0.6

			if 0 < arg_446_1.time_ and arg_446_1.time_ <= 0 + arg_449_0 then
				arg_446_1.talkMaxDuration = 0
				arg_446_1.dialogCg_.alpha = 1

				arg_446_1.dialog_:SetActive(true)
				SetActive(arg_446_1.leftNameGo_, true)

				arg_446_1.leftNameTxt_.text = arg_446_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_446_1.leftNameTxt_.transform)

				arg_446_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_446_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_446_1:RecordName(arg_446_1.leftNameTxt_.text)
				SetActive(arg_446_1.iconTrs_.gameObject, false)
				arg_446_1.callingController_:SetSelectedState("normal")

				local var_449_1 = arg_446_1:GetWordFromCfg(1108411108)
				local var_449_2 = arg_446_1:FormatText(var_449_1.content)

				arg_446_1.text_.text = var_449_2

				LuaForUtil.ClearLinePrefixSymbol(arg_446_1.text_)

				local var_449_4 = 24 <= 0 and var_449_0 or var_449_0 * (utf8.len(var_449_2) / 24)

				if (24 <= 0 and var_449_0 or var_449_0 * (utf8.len(var_449_2) / 24)) > 0 and var_449_0 < var_449_4 then
					arg_446_1.talkMaxDuration = var_449_4

					if var_449_4 + 0 > arg_446_1.duration_ then
						arg_446_1.duration_ = var_449_4 + 0
					end
				end

				arg_446_1.text_.text = var_449_2
				arg_446_1.typewritter.percent = 0

				arg_446_1.typewritter:SetDirty()
				arg_446_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411108", "story_v_side_new_1108411.awb") ~= 0 then
					local var_449_5 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411108", "story_v_side_new_1108411.awb") / 1000

					if var_449_5 + 0 > arg_446_1.duration_ then
						arg_446_1.duration_ = var_449_5 + 0
					end

					if var_449_1.prefab_name ~= "" and arg_446_1.actors_[var_449_1.prefab_name] ~= nil then
						local var_449_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_446_1.actors_[var_449_1.prefab_name].transform, "story_v_side_new_1108411", "1108411108", "story_v_side_new_1108411.awb")

						arg_446_1:RecordAudio("1108411108", var_449_6)
						arg_446_1:RecordAudio("1108411108", var_449_6)
					else
						arg_446_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411108", "story_v_side_new_1108411.awb")
					end

					arg_446_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411108", "story_v_side_new_1108411.awb")
				end

				arg_446_1:RecordContent(arg_446_1.text_.text)
			end

			local var_449_7 = math.max(var_449_0, arg_446_1.talkMaxDuration)

			if 0 <= arg_446_1.time_ and arg_446_1.time_ < 0 + var_449_7 then
				arg_446_1.typewritter.percent = (arg_446_1.time_ - 0) / var_449_7

				arg_446_1.typewritter:SetDirty()
			end

			if arg_446_1.time_ >= 0 + var_449_7 and arg_446_1.time_ < 0 + var_449_7 + arg_449_0 then
				arg_446_1.typewritter.percent = 1

				arg_446_1.typewritter:SetDirty()
				arg_446_1:ShowNextGo(true)
			end
		end

		arg_446_1.nodeConfigList_ = {}

		arg_446_1:InitPlayNodeList()
	end,
	Play1108411109 = function(arg_450_0, arg_450_1)
		arg_450_1.time_ = 0
		arg_450_1.frameCnt_ = 0
		arg_450_1.state_ = "playing"
		arg_450_1.curTalkId_ = 1108411109
		arg_450_1.duration_ = 5

		SetActive(arg_450_1.tipsGo_, false)

		function arg_450_1.onSingleLineFinish_()
			arg_450_1.onSingleLineUpdate_ = nil
			arg_450_1.onSingleLineFinish_ = nil
			arg_450_1.state_ = "waiting"
		end

		function arg_450_1.playNext_(arg_452_0)
			if arg_452_0 == 1 then
				arg_450_0:Play1108411110(arg_450_1)
			end
		end

		function arg_450_1.onSingleLineUpdate_(arg_453_0)
			if 0 < arg_450_1.time_ and arg_450_1.time_ <= 0 + arg_453_0 and not isNil(arg_450_1.actors_["10102ui_story"]) and arg_450_1.var_.characterEffect10102ui_story == nil then
				arg_450_1.var_.characterEffect10102ui_story = arg_450_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_453_0 = 0.200000002980232

			if 0 <= arg_450_1.time_ and arg_450_1.time_ < 0 + var_453_0 and not isNil(arg_450_1.actors_["10102ui_story"]) then
				if arg_450_1.var_.characterEffect10102ui_story and not isNil(arg_450_1.actors_["10102ui_story"]) then
					arg_450_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_450_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_450_1.time_ - 0) / var_453_0)
				end
			end

			if arg_450_1.time_ >= 0 + var_453_0 and arg_450_1.time_ < 0 + var_453_0 + arg_453_0 and not isNil(arg_450_1.actors_["10102ui_story"]) and arg_450_1.var_.characterEffect10102ui_story then
				arg_450_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_450_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_453_1 = 0
			local var_453_2 = 0.525

			if 0 < arg_450_1.time_ and arg_450_1.time_ <= var_453_1 + arg_453_0 then
				arg_450_1.talkMaxDuration = 0
				arg_450_1.dialogCg_.alpha = 1

				arg_450_1.dialog_:SetActive(true)
				SetActive(arg_450_1.leftNameGo_, true)

				arg_450_1.leftNameTxt_.text = arg_450_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_450_1.leftNameTxt_.transform)

				arg_450_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_450_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_450_1:RecordName(arg_450_1.leftNameTxt_.text)
				SetActive(arg_450_1.iconTrs_.gameObject, true)
				arg_450_1.iconController_:SetSelectedState("hero")

				arg_450_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_450_1.callingController_:SetSelectedState("normal")

				arg_450_1.keyicon_.color = Color.New(1, 1, 1)
				arg_450_1.icon_.color = Color.New(1, 1, 1)

				local var_453_3 = arg_450_1:FormatText(arg_450_1:GetWordFromCfg(1108411109).content)

				arg_450_1.text_.text = var_453_3

				LuaForUtil.ClearLinePrefixSymbol(arg_450_1.text_)

				local var_453_5 = 21 <= 0 and var_453_2 or var_453_2 * (utf8.len(var_453_3) / 21)

				if (21 <= 0 and var_453_2 or var_453_2 * (utf8.len(var_453_3) / 21)) > 0 and var_453_2 < var_453_5 then
					arg_450_1.talkMaxDuration = var_453_5

					if var_453_5 + var_453_1 > arg_450_1.duration_ then
						arg_450_1.duration_ = var_453_5 + var_453_1
					end
				end

				arg_450_1.text_.text = var_453_3
				arg_450_1.typewritter.percent = 0

				arg_450_1.typewritter:SetDirty()
				arg_450_1:ShowNextGo(false)
				arg_450_1:RecordContent(arg_450_1.text_.text)
			end

			local var_453_6 = math.max(var_453_2, arg_450_1.talkMaxDuration)

			if var_453_1 <= arg_450_1.time_ and arg_450_1.time_ < var_453_1 + var_453_6 then
				arg_450_1.typewritter.percent = (arg_450_1.time_ - var_453_1) / var_453_6

				arg_450_1.typewritter:SetDirty()
			end

			if arg_450_1.time_ >= var_453_1 + var_453_6 and arg_450_1.time_ < var_453_1 + var_453_6 + arg_453_0 then
				arg_450_1.typewritter.percent = 1

				arg_450_1.typewritter:SetDirty()
				arg_450_1:ShowNextGo(true)
			end
		end

		arg_450_1.nodeConfigList_ = {}

		arg_450_1:InitPlayNodeList()
	end,
	Play1108411110 = function(arg_454_0, arg_454_1)
		arg_454_1.time_ = 0
		arg_454_1.frameCnt_ = 0
		arg_454_1.state_ = "playing"
		arg_454_1.curTalkId_ = 1108411110
		arg_454_1.duration_ = 7.27

		local var_454_0 = {
			zh = 5.9326666696469,
			ja = 7.2666666696469
		}
		local var_454_1 = manager.audio:GetLocalizationFlag()

		if var_454_0[var_454_1] ~= nil then
			arg_454_1.duration_ = var_454_0[var_454_1]
		end

		SetActive(arg_454_1.tipsGo_, false)

		function arg_454_1.onSingleLineFinish_()
			arg_454_1.onSingleLineUpdate_ = nil
			arg_454_1.onSingleLineFinish_ = nil
			arg_454_1.state_ = "waiting"
		end

		function arg_454_1.playNext_(arg_456_0)
			if arg_456_0 == 1 then
				arg_454_0:Play1108411111(arg_454_1)
			end
		end

		function arg_454_1.onSingleLineUpdate_(arg_457_0)
			if arg_454_1.bgs_.ST0115a == nil then
				local var_457_0 = Object.Instantiate(arg_454_1.paintGo_)

				var_457_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST0115a")
				var_457_0.name = "ST0115a"
				var_457_0.transform.parent = arg_454_1.stage_.transform
				var_457_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_454_1.bgs_.ST0115a = var_457_0
			end

			if 1.33333333333333 < arg_454_1.time_ and arg_454_1.time_ <= 1.33333333333333 + arg_457_0 then
				local var_457_1 = arg_454_1.bgs_.ST0115a

				arg_454_1.bgs_.ST0115a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_457_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_457_2 = var_457_1:GetComponent("SpriteRenderer")

				if var_457_2 and var_457_2.sprite then
					local var_457_3 = 2 * (var_457_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_457_1.transform.localScale = Vector3.New(var_457_3 / var_457_2.sprite.bounds.size.y < var_457_3 * manager.ui.mainCameraCom_.aspect / var_457_2.sprite.bounds.size.x and var_457_3 * manager.ui.mainCameraCom_.aspect / var_457_2.sprite.bounds.size.x or var_457_3 / var_457_2.sprite.bounds.size.y, var_457_3 / var_457_2.sprite.bounds.size.y < var_457_3 * manager.ui.mainCameraCom_.aspect / var_457_2.sprite.bounds.size.x and var_457_3 * manager.ui.mainCameraCom_.aspect / var_457_2.sprite.bounds.size.x or var_457_3 / var_457_2.sprite.bounds.size.y, 0)
				end

				for iter_457_0, iter_457_1 in pairs(arg_454_1.bgs_) do
					if iter_457_0 ~= "ST0115a" then
						iter_457_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_457_4 = 0

			if 0 < arg_454_1.time_ and arg_454_1.time_ <= var_457_4 + arg_457_0 then
				arg_454_1.allBtn_.enabled = false
			end

			if arg_454_1.time_ >= var_457_4 + 0.3 and arg_454_1.time_ < var_457_4 + 0.3 + arg_457_0 then
				arg_454_1.allBtn_.enabled = true
			end

			local var_457_5 = 0

			if 0 < arg_454_1.time_ and arg_454_1.time_ <= var_457_5 + arg_457_0 then
				arg_454_1.mask_.enabled = true
				arg_454_1.mask_.raycastTarget = true

				arg_454_1:SetGaussion(false)
			end

			local var_457_6 = 1.33333333333333

			if var_457_5 <= arg_454_1.time_ and arg_454_1.time_ < var_457_5 + var_457_6 then
				local var_457_7 = Color.New(0, 0, 0)

				var_457_7.a = Mathf.Lerp(0, 1, (arg_454_1.time_ - var_457_5) / var_457_6)
				arg_454_1.mask_.color = var_457_7
			end

			if arg_454_1.time_ >= var_457_5 + var_457_6 and arg_454_1.time_ < var_457_5 + var_457_6 + arg_457_0 then
				local var_457_8 = Color.New(0, 0, 0)

				var_457_8.a = 1
				arg_454_1.mask_.color = var_457_8
			end

			local var_457_9 = 1.33333333333333

			if 1.33333333333333 < arg_454_1.time_ and arg_454_1.time_ <= var_457_9 + arg_457_0 then
				arg_454_1.mask_.enabled = true
				arg_454_1.mask_.raycastTarget = true

				arg_454_1:SetGaussion(false)
			end

			local var_457_10 = 2.1

			if var_457_9 <= arg_454_1.time_ and arg_454_1.time_ < var_457_9 + var_457_10 then
				local var_457_11 = Color.New(0, 0, 0)

				var_457_11.a = Mathf.Lerp(1, 0, (arg_454_1.time_ - var_457_9) / var_457_10)
				arg_454_1.mask_.color = var_457_11
			end

			if arg_454_1.time_ >= var_457_9 + var_457_10 and arg_454_1.time_ < var_457_9 + var_457_10 + arg_457_0 then
				local var_457_12 = Color.New(0, 0, 0)

				arg_454_1.mask_.enabled = false
				var_457_12.a = 0
				arg_454_1.mask_.color = var_457_12
			end

			local var_457_13 = arg_454_1.actors_["10102ui_story"].transform

			if 1.33333333333333 < arg_454_1.time_ and arg_454_1.time_ <= 1.33333333333333 + arg_457_0 then
				arg_454_1.var_.moveOldPos10102ui_story = var_457_13.localPosition
			end

			local var_457_14 = 0.001

			if 1.33333333333333 <= arg_454_1.time_ and arg_454_1.time_ < 1.33333333333333 + var_457_14 then
				var_457_13.localPosition = Vector3.Lerp(arg_454_1.var_.moveOldPos10102ui_story, Vector3.New(0, 100, 0), (arg_454_1.time_ - 1.33333333333333) / var_457_14)
				var_457_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_457_13.position).x, (manager.ui.mainCamera.transform.position - var_457_13.position).y, (manager.ui.mainCamera.transform.position - var_457_13.position).z)
				var_457_13.localEulerAngles.z = 0
				var_457_13.localEulerAngles.x = 0
				var_457_13.localEulerAngles = var_457_13.localEulerAngles
			end

			if arg_454_1.time_ >= 1.33333333333333 + var_457_14 and arg_454_1.time_ < 1.33333333333333 + var_457_14 + arg_457_0 then
				var_457_13.localPosition = Vector3.New(0, 100, 0)
				var_457_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_457_13.position).x, (manager.ui.mainCamera.transform.position - var_457_13.position).y, (manager.ui.mainCamera.transform.position - var_457_13.position).z)
				var_457_13.localEulerAngles.z = 0
				var_457_13.localEulerAngles.x = 0
				var_457_13.localEulerAngles = var_457_13.localEulerAngles
			end

			if 0.133333333333333 < arg_454_1.time_ and arg_454_1.time_ <= 0.133333333333333 + arg_457_0 then
				arg_454_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_457_17 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_454_1.bgmTxt_.text ~= var_457_17 and arg_454_1.bgmTxt_.text ~= "" then
						if arg_454_1.bgmTxt2_.text ~= "" then
							arg_454_1.bgmTxt_.text = arg_454_1.bgmTxt2_.text
						end

						arg_454_1.bgmTxt2_.text = var_457_17

						arg_454_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_454_1.bgmTxt_.text = var_457_17
						arg_454_1.bgmTxt2_.text = var_457_17
					end

					if arg_454_1.bgmTimer then
						arg_454_1.bgmTimer:Stop()

						arg_454_1.bgmTimer = nil
					end

					if arg_454_1.settingData.show_music_name == 1 then
						arg_454_1.musicController:SetSelectedState("show")
						arg_454_1.musicAnimator_:Play("open", 0, 0)

						if arg_454_1.settingData.music_time ~= 0 then
							arg_454_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_454_1.settingData.music_time), function()
								if arg_454_1 == nil or isNil(arg_454_1.bgmTxt_) then
									return
								end

								arg_454_1.musicController:SetSelectedState("hide")
								arg_454_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.166666666666667 < arg_454_1.time_ and arg_454_1.time_ <= 0.166666666666667 + arg_457_0 then
				arg_454_1:AudioAction("stop", "effect", "se_story_1210", "se_story_1210_morning_loop", "")
			end

			if 1 < arg_454_1.time_ and arg_454_1.time_ <= 1 + arg_457_0 then
				arg_454_1:AudioAction("play", "effect", "se_story_birthday4", "se_story_birthday4_amb_room_tone_2", "")
			end

			if 3.2666666696469 < arg_454_1.time_ and arg_454_1.time_ <= 3.2666666696469 + arg_457_0 then
				arg_454_1:AudioAction("play", "effect", "se_story_side_128402", "se_story_side_128402_bed", "")
			end

			if arg_454_1.frameCnt_ <= 1 then
				arg_454_1.dialog_:SetActive(false)
			end

			local var_457_21 = 3.2666666696469
			local var_457_22 = 0.2

			if 3.2666666696469 < arg_454_1.time_ and arg_454_1.time_ <= var_457_21 + arg_457_0 then
				arg_454_1.talkMaxDuration = 0

				arg_454_1.dialog_:SetActive(true)

				arg_454_1.dialogCg_.alpha = 0

				local var_457_23 = LeanTween.value(arg_454_1.dialog_, 0, 1, 0.3)

				var_457_23:setOnUpdate(LuaHelper.FloatAction(function(arg_459_0)
					arg_454_1.dialogCg_.alpha = arg_459_0
				end))
				var_457_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_454_1.dialog_)
					var_457_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_454_1.duration_ = arg_454_1.duration_ + 0.3

				SetActive(arg_454_1.leftNameGo_, true)

				arg_454_1.leftNameTxt_.text = arg_454_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_454_1.leftNameTxt_.transform)

				arg_454_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_454_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_454_1:RecordName(arg_454_1.leftNameTxt_.text)
				SetActive(arg_454_1.iconTrs_.gameObject, true)
				arg_454_1.iconController_:SetSelectedState("hero")

				arg_454_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10102_split_2")

				arg_454_1.callingController_:SetSelectedState("normal")

				arg_454_1.keyicon_.color = Color.New(1, 1, 1)
				arg_454_1.icon_.color = Color.New(1, 1, 1)

				local var_457_24 = arg_454_1:GetWordFromCfg(1108411110)
				local var_457_25 = arg_454_1:FormatText(var_457_24.content)

				arg_454_1.text_.text = var_457_25

				LuaForUtil.ClearLinePrefixSymbol(arg_454_1.text_)

				local var_457_27 = 8 <= 0 and var_457_22 or var_457_22 * (utf8.len(var_457_25) / 8)

				if (8 <= 0 and var_457_22 or var_457_22 * (utf8.len(var_457_25) / 8)) > 0 and var_457_22 < var_457_27 then
					arg_454_1.talkMaxDuration = var_457_27
					var_457_21 = var_457_21 + 0.3

					if var_457_27 + var_457_21 > arg_454_1.duration_ then
						arg_454_1.duration_ = var_457_27 + var_457_21
					end
				end

				arg_454_1.text_.text = var_457_25
				arg_454_1.typewritter.percent = 0

				arg_454_1.typewritter:SetDirty()
				arg_454_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411110", "story_v_side_new_1108411.awb") ~= 0 then
					local var_457_28 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411110", "story_v_side_new_1108411.awb") / 1000

					if var_457_28 + var_457_21 > arg_454_1.duration_ then
						arg_454_1.duration_ = var_457_28 + var_457_21
					end

					if var_457_24.prefab_name ~= "" and arg_454_1.actors_[var_457_24.prefab_name] ~= nil then
						local var_457_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_454_1.actors_[var_457_24.prefab_name].transform, "story_v_side_new_1108411", "1108411110", "story_v_side_new_1108411.awb")

						arg_454_1:RecordAudio("1108411110", var_457_29)
						arg_454_1:RecordAudio("1108411110", var_457_29)
					else
						arg_454_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411110", "story_v_side_new_1108411.awb")
					end

					arg_454_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411110", "story_v_side_new_1108411.awb")
				end

				arg_454_1:RecordContent(arg_454_1.text_.text)
			end

			local var_457_30 = var_457_21 + 0.3
			local var_457_31 = math.max(var_457_22, arg_454_1.talkMaxDuration)

			if var_457_21 + 0.3 <= arg_454_1.time_ and arg_454_1.time_ < var_457_30 + var_457_31 then
				arg_454_1.typewritter.percent = (arg_454_1.time_ - var_457_30) / var_457_31

				arg_454_1.typewritter:SetDirty()
			end

			if arg_454_1.time_ >= var_457_30 + var_457_31 and arg_454_1.time_ < var_457_30 + var_457_31 + arg_457_0 then
				arg_454_1.typewritter.percent = 1

				arg_454_1.typewritter:SetDirty()
				arg_454_1:ShowNextGo(true)
			end
		end

		arg_454_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 1.33333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_454_1:InitPlayNodeList()
	end,
	Play1108411111 = function(arg_461_0, arg_461_1)
		arg_461_1.time_ = 0
		arg_461_1.frameCnt_ = 0
		arg_461_1.state_ = "playing"
		arg_461_1.curTalkId_ = 1108411111
		arg_461_1.duration_ = 5

		SetActive(arg_461_1.tipsGo_, false)

		function arg_461_1.onSingleLineFinish_()
			arg_461_1.onSingleLineUpdate_ = nil
			arg_461_1.onSingleLineFinish_ = nil
			arg_461_1.state_ = "waiting"
		end

		function arg_461_1.playNext_(arg_463_0)
			if arg_463_0 == 1 then
				arg_461_0:Play1108411112(arg_461_1)
			end
		end

		function arg_461_1.onSingleLineUpdate_(arg_464_0)
			if 0 < arg_461_1.time_ and arg_461_1.time_ <= 0 + arg_464_0 then
				arg_461_1.var_.moveOldPos10102ui_story = arg_461_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_464_0 = 0.001

			if 0 <= arg_461_1.time_ and arg_461_1.time_ < 0 + var_464_0 then
				arg_461_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_461_1.var_.moveOldPos10102ui_story, Vector3.New(0, 100, 0), (arg_461_1.time_ - 0) / var_464_0)
				arg_461_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_461_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_461_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_461_1.actors_["10102ui_story"].transform.position).z)
				arg_461_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_461_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_461_1.actors_["10102ui_story"].transform.localEulerAngles = arg_461_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_461_1.time_ >= 0 + var_464_0 and arg_461_1.time_ < 0 + var_464_0 + arg_464_0 then
				arg_461_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_461_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_461_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_461_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_461_1.actors_["10102ui_story"].transform.position).z)
				arg_461_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_461_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_461_1.actors_["10102ui_story"].transform.localEulerAngles = arg_461_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_464_1 = arg_461_1.actors_["10102ui_story"]

			if 0 < arg_461_1.time_ and arg_461_1.time_ <= 0 + arg_464_0 and not isNil(var_464_1) and arg_461_1.var_.characterEffect10102ui_story == nil then
				arg_461_1.var_.characterEffect10102ui_story = var_464_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_464_2 = 0.200000002980232

			if 0 <= arg_461_1.time_ and arg_461_1.time_ < 0 + var_464_2 and not isNil(var_464_1) then
				if arg_461_1.var_.characterEffect10102ui_story and not isNil(var_464_1) then
					arg_461_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_461_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_461_1.time_ - 0) / var_464_2)
				end
			end

			if arg_461_1.time_ >= 0 + var_464_2 and arg_461_1.time_ < 0 + var_464_2 + arg_464_0 and not isNil(var_464_1) and arg_461_1.var_.characterEffect10102ui_story then
				arg_461_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_461_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			if 0 < arg_461_1.time_ and arg_461_1.time_ <= 0 + arg_464_0 then
				arg_461_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_464_5 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_461_1.bgmTxt_.text ~= var_464_5 and arg_461_1.bgmTxt_.text ~= "" then
						if arg_461_1.bgmTxt2_.text ~= "" then
							arg_461_1.bgmTxt_.text = arg_461_1.bgmTxt2_.text
						end

						arg_461_1.bgmTxt2_.text = var_464_5

						arg_461_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_461_1.bgmTxt_.text = var_464_5
						arg_461_1.bgmTxt2_.text = var_464_5
					end

					if arg_461_1.bgmTimer then
						arg_461_1.bgmTimer:Stop()

						arg_461_1.bgmTimer = nil
					end

					if arg_461_1.settingData.show_music_name == 1 then
						arg_461_1.musicController:SetSelectedState("show")
						arg_461_1.musicAnimator_:Play("open", 0, 0)

						if arg_461_1.settingData.music_time ~= 0 then
							arg_461_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_461_1.settingData.music_time), function()
								if arg_461_1 == nil or isNil(arg_461_1.bgmTxt_) then
									return
								end

								arg_461_1.musicController:SetSelectedState("hide")
								arg_461_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.3 < arg_461_1.time_ and arg_461_1.time_ <= 0.3 + arg_464_0 then
				arg_461_1:AudioAction("play", "music", "bgm_story_quiet_1", "bgm_story_quiet_1", "bgm_story_quiet_1.awb")

				local var_464_8 = manager.audio:GetAudioName("bgm_story_quiet_1", "bgm_story_quiet_1")

				if "" ~= "" then
					if arg_461_1.bgmTxt_.text ~= var_464_8 and arg_461_1.bgmTxt_.text ~= "" then
						if arg_461_1.bgmTxt2_.text ~= "" then
							arg_461_1.bgmTxt_.text = arg_461_1.bgmTxt2_.text
						end

						arg_461_1.bgmTxt2_.text = var_464_8

						arg_461_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_461_1.bgmTxt_.text = var_464_8
						arg_461_1.bgmTxt2_.text = var_464_8
					end

					if arg_461_1.bgmTimer then
						arg_461_1.bgmTimer:Stop()

						arg_461_1.bgmTimer = nil
					end

					if arg_461_1.settingData.show_music_name == 1 then
						arg_461_1.musicController:SetSelectedState("show")
						arg_461_1.musicAnimator_:Play("open", 0, 0)

						if arg_461_1.settingData.music_time ~= 0 then
							arg_461_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_461_1.settingData.music_time), function()
								if arg_461_1 == nil or isNil(arg_461_1.bgmTxt_) then
									return
								end

								arg_461_1.musicController:SetSelectedState("hide")
								arg_461_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_464_9 = 0
			local var_464_10 = 1.175

			if 0 < arg_461_1.time_ and arg_461_1.time_ <= var_464_9 + arg_464_0 then
				arg_461_1.talkMaxDuration = 0
				arg_461_1.dialogCg_.alpha = 1

				arg_461_1.dialog_:SetActive(true)
				SetActive(arg_461_1.leftNameGo_, false)

				arg_461_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_461_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_461_1:RecordName(arg_461_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_461_1.iconTrs_.gameObject, false)
				arg_461_1.callingController_:SetSelectedState("normal")

				local var_464_11 = arg_461_1:FormatText(arg_461_1:GetWordFromCfg(1108411111).content)

				arg_461_1.text_.text = var_464_11

				LuaForUtil.ClearLinePrefixSymbol(arg_461_1.text_)

				local var_464_13 = 47 <= 0 and var_464_10 or var_464_10 * (utf8.len(var_464_11) / 47)

				if (47 <= 0 and var_464_10 or var_464_10 * (utf8.len(var_464_11) / 47)) > 0 and var_464_10 < var_464_13 then
					arg_461_1.talkMaxDuration = var_464_13

					if var_464_13 + var_464_9 > arg_461_1.duration_ then
						arg_461_1.duration_ = var_464_13 + var_464_9
					end
				end

				arg_461_1.text_.text = var_464_11
				arg_461_1.typewritter.percent = 0

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(false)
				arg_461_1:RecordContent(arg_461_1.text_.text)
			end

			local var_464_14 = math.max(var_464_10, arg_461_1.talkMaxDuration)

			if var_464_9 <= arg_461_1.time_ and arg_461_1.time_ < var_464_9 + var_464_14 then
				arg_461_1.typewritter.percent = (arg_461_1.time_ - var_464_9) / var_464_14

				arg_461_1.typewritter:SetDirty()
			end

			if arg_461_1.time_ >= var_464_9 + var_464_14 and arg_461_1.time_ < var_464_9 + var_464_14 + arg_464_0 then
				arg_461_1.typewritter.percent = 1

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(true)
			end
		end

		arg_461_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_461_1:InitPlayNodeList()
	end,
	Play1108411112 = function(arg_467_0, arg_467_1)
		arg_467_1.time_ = 0
		arg_467_1.frameCnt_ = 0
		arg_467_1.state_ = "playing"
		arg_467_1.curTalkId_ = 1108411112
		arg_467_1.duration_ = 3.3

		local var_467_0 = {
			zh = 2.6,
			ja = 3.3
		}
		local var_467_1 = manager.audio:GetLocalizationFlag()

		if var_467_0[var_467_1] ~= nil then
			arg_467_1.duration_ = var_467_0[var_467_1]
		end

		SetActive(arg_467_1.tipsGo_, false)

		function arg_467_1.onSingleLineFinish_()
			arg_467_1.onSingleLineUpdate_ = nil
			arg_467_1.onSingleLineFinish_ = nil
			arg_467_1.state_ = "waiting"
		end

		function arg_467_1.playNext_(arg_469_0)
			if arg_469_0 == 1 then
				arg_467_0:Play1108411113(arg_467_1)
			end
		end

		function arg_467_1.onSingleLineUpdate_(arg_470_0)
			if 0 < arg_467_1.time_ and arg_467_1.time_ <= 0 + arg_470_0 and not isNil(arg_467_1.actors_["10102ui_story"]) and arg_467_1.var_.characterEffect10102ui_story == nil then
				arg_467_1.var_.characterEffect10102ui_story = arg_467_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_470_0 = 0.200000002980232

			if 0 <= arg_467_1.time_ and arg_467_1.time_ < 0 + var_470_0 and not isNil(arg_467_1.actors_["10102ui_story"]) then
				if arg_467_1.var_.characterEffect10102ui_story and not isNil(arg_467_1.actors_["10102ui_story"]) then
					arg_467_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_467_1.time_ >= 0 + var_470_0 and arg_467_1.time_ < 0 + var_470_0 + arg_470_0 and not isNil(arg_467_1.actors_["10102ui_story"]) and arg_467_1.var_.characterEffect10102ui_story then
				arg_467_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_470_2 = 0
			local var_470_3 = 0.525

			if 0 < arg_467_1.time_ and arg_467_1.time_ <= var_470_2 + arg_470_0 then
				arg_467_1.talkMaxDuration = 0
				arg_467_1.dialogCg_.alpha = 1

				arg_467_1.dialog_:SetActive(true)
				SetActive(arg_467_1.leftNameGo_, true)

				arg_467_1.leftNameTxt_.text = arg_467_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_467_1.leftNameTxt_.transform)

				arg_467_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_467_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_467_1:RecordName(arg_467_1.leftNameTxt_.text)
				SetActive(arg_467_1.iconTrs_.gameObject, true)
				arg_467_1.iconController_:SetSelectedState("hero")

				arg_467_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10102")

				arg_467_1.callingController_:SetSelectedState("normal")

				arg_467_1.keyicon_.color = Color.New(1, 1, 1)
				arg_467_1.icon_.color = Color.New(1, 1, 1)

				local var_470_4 = arg_467_1:GetWordFromCfg(1108411112)
				local var_470_5 = arg_467_1:FormatText(var_470_4.content)

				arg_467_1.text_.text = var_470_5

				LuaForUtil.ClearLinePrefixSymbol(arg_467_1.text_)

				local var_470_7 = 21 <= 0 and var_470_3 or var_470_3 * (utf8.len(var_470_5) / 21)

				if (21 <= 0 and var_470_3 or var_470_3 * (utf8.len(var_470_5) / 21)) > 0 and var_470_3 < var_470_7 then
					arg_467_1.talkMaxDuration = var_470_7

					if var_470_7 + var_470_2 > arg_467_1.duration_ then
						arg_467_1.duration_ = var_470_7 + var_470_2
					end
				end

				arg_467_1.text_.text = var_470_5
				arg_467_1.typewritter.percent = 0

				arg_467_1.typewritter:SetDirty()
				arg_467_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411112", "story_v_side_new_1108411.awb") ~= 0 then
					local var_470_8 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411112", "story_v_side_new_1108411.awb") / 1000

					if var_470_8 + var_470_2 > arg_467_1.duration_ then
						arg_467_1.duration_ = var_470_8 + var_470_2
					end

					if var_470_4.prefab_name ~= "" and arg_467_1.actors_[var_470_4.prefab_name] ~= nil then
						local var_470_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_467_1.actors_[var_470_4.prefab_name].transform, "story_v_side_new_1108411", "1108411112", "story_v_side_new_1108411.awb")

						arg_467_1:RecordAudio("1108411112", var_470_9)
						arg_467_1:RecordAudio("1108411112", var_470_9)
					else
						arg_467_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411112", "story_v_side_new_1108411.awb")
					end

					arg_467_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411112", "story_v_side_new_1108411.awb")
				end

				arg_467_1:RecordContent(arg_467_1.text_.text)
			end

			local var_470_10 = math.max(var_470_3, arg_467_1.talkMaxDuration)

			if var_470_2 <= arg_467_1.time_ and arg_467_1.time_ < var_470_2 + var_470_10 then
				arg_467_1.typewritter.percent = (arg_467_1.time_ - var_470_2) / var_470_10

				arg_467_1.typewritter:SetDirty()
			end

			if arg_467_1.time_ >= var_470_2 + var_470_10 and arg_467_1.time_ < var_470_2 + var_470_10 + arg_470_0 then
				arg_467_1.typewritter.percent = 1

				arg_467_1.typewritter:SetDirty()
				arg_467_1:ShowNextGo(true)
			end
		end

		arg_467_1.nodeConfigList_ = {}

		arg_467_1:InitPlayNodeList()
	end,
	Play1108411113 = function(arg_471_0, arg_471_1)
		arg_471_1.time_ = 0
		arg_471_1.frameCnt_ = 0
		arg_471_1.state_ = "playing"
		arg_471_1.curTalkId_ = 1108411113
		arg_471_1.duration_ = 5

		SetActive(arg_471_1.tipsGo_, false)

		function arg_471_1.onSingleLineFinish_()
			arg_471_1.onSingleLineUpdate_ = nil
			arg_471_1.onSingleLineFinish_ = nil
			arg_471_1.state_ = "waiting"
		end

		function arg_471_1.playNext_(arg_473_0)
			if arg_473_0 == 1 then
				arg_471_0:Play1108411114(arg_471_1)
			end
		end

		function arg_471_1.onSingleLineUpdate_(arg_474_0)
			if 0 < arg_471_1.time_ and arg_471_1.time_ <= 0 + arg_474_0 and not isNil(arg_471_1.actors_["10102ui_story"]) and arg_471_1.var_.characterEffect10102ui_story == nil then
				arg_471_1.var_.characterEffect10102ui_story = arg_471_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_474_0 = 0.200000002980232

			if 0 <= arg_471_1.time_ and arg_471_1.time_ < 0 + var_474_0 and not isNil(arg_471_1.actors_["10102ui_story"]) then
				if arg_471_1.var_.characterEffect10102ui_story and not isNil(arg_471_1.actors_["10102ui_story"]) then
					arg_471_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_471_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_471_1.time_ - 0) / var_474_0)
				end
			end

			if arg_471_1.time_ >= 0 + var_474_0 and arg_471_1.time_ < 0 + var_474_0 + arg_474_0 and not isNil(arg_471_1.actors_["10102ui_story"]) and arg_471_1.var_.characterEffect10102ui_story then
				arg_471_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_471_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_474_1 = 0
			local var_474_2 = 0.375

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

				local var_474_3 = arg_471_1:FormatText(arg_471_1:GetWordFromCfg(1108411113).content)

				arg_471_1.text_.text = var_474_3

				LuaForUtil.ClearLinePrefixSymbol(arg_471_1.text_)

				local var_474_5 = 15 <= 0 and var_474_2 or var_474_2 * (utf8.len(var_474_3) / 15)

				if (15 <= 0 and var_474_2 or var_474_2 * (utf8.len(var_474_3) / 15)) > 0 and var_474_2 < var_474_5 then
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
	Play1108411114 = function(arg_475_0, arg_475_1)
		arg_475_1.time_ = 0
		arg_475_1.frameCnt_ = 0
		arg_475_1.state_ = "playing"
		arg_475_1.curTalkId_ = 1108411114
		arg_475_1.duration_ = 4.5

		local var_475_0 = {
			zh = 3.033,
			ja = 4.5
		}
		local var_475_1 = manager.audio:GetLocalizationFlag()

		if var_475_0[var_475_1] ~= nil then
			arg_475_1.duration_ = var_475_0[var_475_1]
		end

		SetActive(arg_475_1.tipsGo_, false)

		function arg_475_1.onSingleLineFinish_()
			arg_475_1.onSingleLineUpdate_ = nil
			arg_475_1.onSingleLineFinish_ = nil
			arg_475_1.state_ = "waiting"
		end

		function arg_475_1.playNext_(arg_477_0)
			if arg_477_0 == 1 then
				arg_475_0:Play1108411115(arg_475_1)
			end
		end

		function arg_475_1.onSingleLineUpdate_(arg_478_0)
			if 0 < arg_475_1.time_ and arg_475_1.time_ <= 0 + arg_478_0 and not isNil(arg_475_1.actors_["10102ui_story"]) and arg_475_1.var_.characterEffect10102ui_story == nil then
				arg_475_1.var_.characterEffect10102ui_story = arg_475_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_478_0 = 0.200000002980232

			if 0 <= arg_475_1.time_ and arg_475_1.time_ < 0 + var_478_0 and not isNil(arg_475_1.actors_["10102ui_story"]) then
				if arg_475_1.var_.characterEffect10102ui_story and not isNil(arg_475_1.actors_["10102ui_story"]) then
					arg_475_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_475_1.time_ >= 0 + var_478_0 and arg_475_1.time_ < 0 + var_478_0 + arg_478_0 and not isNil(arg_475_1.actors_["10102ui_story"]) and arg_475_1.var_.characterEffect10102ui_story then
				arg_475_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_478_2 = 0
			local var_478_3 = 0.375

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
				SetActive(arg_475_1.iconTrs_.gameObject, true)
				arg_475_1.iconController_:SetSelectedState("hero")

				arg_475_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10102")

				arg_475_1.callingController_:SetSelectedState("normal")

				arg_475_1.keyicon_.color = Color.New(1, 1, 1)
				arg_475_1.icon_.color = Color.New(1, 1, 1)

				local var_478_4 = arg_475_1:GetWordFromCfg(1108411114)
				local var_478_5 = arg_475_1:FormatText(var_478_4.content)

				arg_475_1.text_.text = var_478_5

				LuaForUtil.ClearLinePrefixSymbol(arg_475_1.text_)

				local var_478_7 = 15 <= 0 and var_478_3 or var_478_3 * (utf8.len(var_478_5) / 15)

				if (15 <= 0 and var_478_3 or var_478_3 * (utf8.len(var_478_5) / 15)) > 0 and var_478_3 < var_478_7 then
					arg_475_1.talkMaxDuration = var_478_7

					if var_478_7 + var_478_2 > arg_475_1.duration_ then
						arg_475_1.duration_ = var_478_7 + var_478_2
					end
				end

				arg_475_1.text_.text = var_478_5
				arg_475_1.typewritter.percent = 0

				arg_475_1.typewritter:SetDirty()
				arg_475_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411114", "story_v_side_new_1108411.awb") ~= 0 then
					local var_478_8 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411114", "story_v_side_new_1108411.awb") / 1000

					if var_478_8 + var_478_2 > arg_475_1.duration_ then
						arg_475_1.duration_ = var_478_8 + var_478_2
					end

					if var_478_4.prefab_name ~= "" and arg_475_1.actors_[var_478_4.prefab_name] ~= nil then
						local var_478_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_475_1.actors_[var_478_4.prefab_name].transform, "story_v_side_new_1108411", "1108411114", "story_v_side_new_1108411.awb")

						arg_475_1:RecordAudio("1108411114", var_478_9)
						arg_475_1:RecordAudio("1108411114", var_478_9)
					else
						arg_475_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411114", "story_v_side_new_1108411.awb")
					end

					arg_475_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411114", "story_v_side_new_1108411.awb")
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
	Play1108411115 = function(arg_479_0, arg_479_1)
		arg_479_1.time_ = 0
		arg_479_1.frameCnt_ = 0
		arg_479_1.state_ = "playing"
		arg_479_1.curTalkId_ = 1108411115
		arg_479_1.duration_ = 5

		SetActive(arg_479_1.tipsGo_, false)

		function arg_479_1.onSingleLineFinish_()
			arg_479_1.onSingleLineUpdate_ = nil
			arg_479_1.onSingleLineFinish_ = nil
			arg_479_1.state_ = "waiting"
		end

		function arg_479_1.playNext_(arg_481_0)
			if arg_481_0 == 1 then
				arg_479_0:Play1108411116(arg_479_1)
			end
		end

		function arg_479_1.onSingleLineUpdate_(arg_482_0)
			if 0 < arg_479_1.time_ and arg_479_1.time_ <= 0 + arg_482_0 and not isNil(arg_479_1.actors_["10102ui_story"]) and arg_479_1.var_.characterEffect10102ui_story == nil then
				arg_479_1.var_.characterEffect10102ui_story = arg_479_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_482_0 = 0.200000002980232

			if 0 <= arg_479_1.time_ and arg_479_1.time_ < 0 + var_482_0 and not isNil(arg_479_1.actors_["10102ui_story"]) then
				if arg_479_1.var_.characterEffect10102ui_story and not isNil(arg_479_1.actors_["10102ui_story"]) then
					arg_479_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_479_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_479_1.time_ - 0) / var_482_0)
				end
			end

			if arg_479_1.time_ >= 0 + var_482_0 and arg_479_1.time_ < 0 + var_482_0 + arg_482_0 and not isNil(arg_479_1.actors_["10102ui_story"]) and arg_479_1.var_.characterEffect10102ui_story then
				arg_479_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_479_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_482_1 = 0
			local var_482_2 = 0.7

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

				local var_482_3 = arg_479_1:FormatText(arg_479_1:GetWordFromCfg(1108411115).content)

				arg_479_1.text_.text = var_482_3

				LuaForUtil.ClearLinePrefixSymbol(arg_479_1.text_)

				local var_482_5 = 28 <= 0 and var_482_2 or var_482_2 * (utf8.len(var_482_3) / 28)

				if (28 <= 0 and var_482_2 or var_482_2 * (utf8.len(var_482_3) / 28)) > 0 and var_482_2 < var_482_5 then
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
	Play1108411116 = function(arg_483_0, arg_483_1)
		arg_483_1.time_ = 0
		arg_483_1.frameCnt_ = 0
		arg_483_1.state_ = "playing"
		arg_483_1.curTalkId_ = 1108411116
		arg_483_1.duration_ = 5

		SetActive(arg_483_1.tipsGo_, false)

		function arg_483_1.onSingleLineFinish_()
			arg_483_1.onSingleLineUpdate_ = nil
			arg_483_1.onSingleLineFinish_ = nil
			arg_483_1.state_ = "waiting"
		end

		function arg_483_1.playNext_(arg_485_0)
			if arg_485_0 == 1 then
				arg_483_0:Play1108411117(arg_483_1)
			end
		end

		function arg_483_1.onSingleLineUpdate_(arg_486_0)
			local var_486_0 = 0.35

			if 0 < arg_483_1.time_ and arg_483_1.time_ <= 0 + arg_486_0 then
				arg_483_1.talkMaxDuration = 0
				arg_483_1.dialogCg_.alpha = 1

				arg_483_1.dialog_:SetActive(true)
				SetActive(arg_483_1.leftNameGo_, true)

				arg_483_1.leftNameTxt_.text = arg_483_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_483_1.leftNameTxt_.transform)

				arg_483_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_483_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_483_1:RecordName(arg_483_1.leftNameTxt_.text)
				SetActive(arg_483_1.iconTrs_.gameObject, true)
				arg_483_1.iconController_:SetSelectedState("hero")

				arg_483_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_483_1.callingController_:SetSelectedState("normal")

				arg_483_1.keyicon_.color = Color.New(1, 1, 1)
				arg_483_1.icon_.color = Color.New(1, 1, 1)

				local var_486_1 = arg_483_1:FormatText(arg_483_1:GetWordFromCfg(1108411116).content)

				arg_483_1.text_.text = var_486_1

				LuaForUtil.ClearLinePrefixSymbol(arg_483_1.text_)

				local var_486_3 = 14 <= 0 and var_486_0 or var_486_0 * (utf8.len(var_486_1) / 14)

				if (14 <= 0 and var_486_0 or var_486_0 * (utf8.len(var_486_1) / 14)) > 0 and var_486_0 < var_486_3 then
					arg_483_1.talkMaxDuration = var_486_3

					if var_486_3 + 0 > arg_483_1.duration_ then
						arg_483_1.duration_ = var_486_3 + 0
					end
				end

				arg_483_1.text_.text = var_486_1
				arg_483_1.typewritter.percent = 0

				arg_483_1.typewritter:SetDirty()
				arg_483_1:ShowNextGo(false)
				arg_483_1:RecordContent(arg_483_1.text_.text)
			end

			local var_486_4 = math.max(var_486_0, arg_483_1.talkMaxDuration)

			if 0 <= arg_483_1.time_ and arg_483_1.time_ < 0 + var_486_4 then
				arg_483_1.typewritter.percent = (arg_483_1.time_ - 0) / var_486_4

				arg_483_1.typewritter:SetDirty()
			end

			if arg_483_1.time_ >= 0 + var_486_4 and arg_483_1.time_ < 0 + var_486_4 + arg_486_0 then
				arg_483_1.typewritter.percent = 1

				arg_483_1.typewritter:SetDirty()
				arg_483_1:ShowNextGo(true)
			end
		end

		arg_483_1.nodeConfigList_ = {}

		arg_483_1:InitPlayNodeList()
	end,
	Play1108411117 = function(arg_487_0, arg_487_1)
		arg_487_1.time_ = 0
		arg_487_1.frameCnt_ = 0
		arg_487_1.state_ = "playing"
		arg_487_1.curTalkId_ = 1108411117
		arg_487_1.duration_ = 5

		SetActive(arg_487_1.tipsGo_, false)

		function arg_487_1.onSingleLineFinish_()
			arg_487_1.onSingleLineUpdate_ = nil
			arg_487_1.onSingleLineFinish_ = nil
			arg_487_1.state_ = "waiting"
		end

		function arg_487_1.playNext_(arg_489_0)
			if arg_489_0 == 1 then
				arg_487_0:Play1108411118(arg_487_1)
			end
		end

		function arg_487_1.onSingleLineUpdate_(arg_490_0)
			local var_490_0 = 0.875

			if 0 < arg_487_1.time_ and arg_487_1.time_ <= 0 + arg_490_0 then
				arg_487_1.talkMaxDuration = 0
				arg_487_1.dialogCg_.alpha = 1

				arg_487_1.dialog_:SetActive(true)
				SetActive(arg_487_1.leftNameGo_, false)

				arg_487_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_487_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_487_1:RecordName(arg_487_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_487_1.iconTrs_.gameObject, false)
				arg_487_1.callingController_:SetSelectedState("normal")

				local var_490_1 = arg_487_1:FormatText(arg_487_1:GetWordFromCfg(1108411117).content)

				arg_487_1.text_.text = var_490_1

				LuaForUtil.ClearLinePrefixSymbol(arg_487_1.text_)

				local var_490_3 = 35 <= 0 and var_490_0 or var_490_0 * (utf8.len(var_490_1) / 35)

				if (35 <= 0 and var_490_0 or var_490_0 * (utf8.len(var_490_1) / 35)) > 0 and var_490_0 < var_490_3 then
					arg_487_1.talkMaxDuration = var_490_3

					if var_490_3 + 0 > arg_487_1.duration_ then
						arg_487_1.duration_ = var_490_3 + 0
					end
				end

				arg_487_1.text_.text = var_490_1
				arg_487_1.typewritter.percent = 0

				arg_487_1.typewritter:SetDirty()
				arg_487_1:ShowNextGo(false)
				arg_487_1:RecordContent(arg_487_1.text_.text)
			end

			local var_490_4 = math.max(var_490_0, arg_487_1.talkMaxDuration)

			if 0 <= arg_487_1.time_ and arg_487_1.time_ < 0 + var_490_4 then
				arg_487_1.typewritter.percent = (arg_487_1.time_ - 0) / var_490_4

				arg_487_1.typewritter:SetDirty()
			end

			if arg_487_1.time_ >= 0 + var_490_4 and arg_487_1.time_ < 0 + var_490_4 + arg_490_0 then
				arg_487_1.typewritter.percent = 1

				arg_487_1.typewritter:SetDirty()
				arg_487_1:ShowNextGo(true)
			end
		end

		arg_487_1.nodeConfigList_ = {}

		arg_487_1:InitPlayNodeList()
	end,
	Play1108411118 = function(arg_491_0, arg_491_1)
		arg_491_1.time_ = 0
		arg_491_1.frameCnt_ = 0
		arg_491_1.state_ = "playing"
		arg_491_1.curTalkId_ = 1108411118
		arg_491_1.duration_ = 8.97

		local var_491_0 = {
			zh = 8.966,
			ja = 8.7
		}
		local var_491_1 = manager.audio:GetLocalizationFlag()

		if var_491_0[var_491_1] ~= nil then
			arg_491_1.duration_ = var_491_0[var_491_1]
		end

		SetActive(arg_491_1.tipsGo_, false)

		function arg_491_1.onSingleLineFinish_()
			arg_491_1.onSingleLineUpdate_ = nil
			arg_491_1.onSingleLineFinish_ = nil
			arg_491_1.state_ = "waiting"
		end

		function arg_491_1.playNext_(arg_493_0)
			if arg_493_0 == 1 then
				arg_491_0:Play1108411119(arg_491_1)
			end
		end

		function arg_491_1.onSingleLineUpdate_(arg_494_0)
			local var_494_0 = 0.95

			if 0 < arg_491_1.time_ and arg_491_1.time_ <= 0 + arg_494_0 then
				arg_491_1.talkMaxDuration = 0
				arg_491_1.dialogCg_.alpha = 1

				arg_491_1.dialog_:SetActive(true)
				SetActive(arg_491_1.leftNameGo_, true)

				arg_491_1.leftNameTxt_.text = arg_491_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_491_1.leftNameTxt_.transform)

				arg_491_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_491_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_491_1:RecordName(arg_491_1.leftNameTxt_.text)
				SetActive(arg_491_1.iconTrs_.gameObject, true)
				arg_491_1.iconController_:SetSelectedState("hero")

				arg_491_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10102_split_2")

				arg_491_1.callingController_:SetSelectedState("normal")

				arg_491_1.keyicon_.color = Color.New(1, 1, 1)
				arg_491_1.icon_.color = Color.New(1, 1, 1)

				local var_494_1 = arg_491_1:GetWordFromCfg(1108411118)
				local var_494_2 = arg_491_1:FormatText(var_494_1.content)

				arg_491_1.text_.text = var_494_2

				LuaForUtil.ClearLinePrefixSymbol(arg_491_1.text_)

				local var_494_4 = 38 <= 0 and var_494_0 or var_494_0 * (utf8.len(var_494_2) / 38)

				if (38 <= 0 and var_494_0 or var_494_0 * (utf8.len(var_494_2) / 38)) > 0 and var_494_0 < var_494_4 then
					arg_491_1.talkMaxDuration = var_494_4

					if var_494_4 + 0 > arg_491_1.duration_ then
						arg_491_1.duration_ = var_494_4 + 0
					end
				end

				arg_491_1.text_.text = var_494_2
				arg_491_1.typewritter.percent = 0

				arg_491_1.typewritter:SetDirty()
				arg_491_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411118", "story_v_side_new_1108411.awb") ~= 0 then
					local var_494_5 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411118", "story_v_side_new_1108411.awb") / 1000

					if var_494_5 + 0 > arg_491_1.duration_ then
						arg_491_1.duration_ = var_494_5 + 0
					end

					if var_494_1.prefab_name ~= "" and arg_491_1.actors_[var_494_1.prefab_name] ~= nil then
						local var_494_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_491_1.actors_[var_494_1.prefab_name].transform, "story_v_side_new_1108411", "1108411118", "story_v_side_new_1108411.awb")

						arg_491_1:RecordAudio("1108411118", var_494_6)
						arg_491_1:RecordAudio("1108411118", var_494_6)
					else
						arg_491_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411118", "story_v_side_new_1108411.awb")
					end

					arg_491_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411118", "story_v_side_new_1108411.awb")
				end

				arg_491_1:RecordContent(arg_491_1.text_.text)
			end

			local var_494_7 = math.max(var_494_0, arg_491_1.talkMaxDuration)

			if 0 <= arg_491_1.time_ and arg_491_1.time_ < 0 + var_494_7 then
				arg_491_1.typewritter.percent = (arg_491_1.time_ - 0) / var_494_7

				arg_491_1.typewritter:SetDirty()
			end

			if arg_491_1.time_ >= 0 + var_494_7 and arg_491_1.time_ < 0 + var_494_7 + arg_494_0 then
				arg_491_1.typewritter.percent = 1

				arg_491_1.typewritter:SetDirty()
				arg_491_1:ShowNextGo(true)
			end
		end

		arg_491_1.nodeConfigList_ = {}

		arg_491_1:InitPlayNodeList()
	end,
	Play1108411119 = function(arg_495_0, arg_495_1)
		arg_495_1.time_ = 0
		arg_495_1.frameCnt_ = 0
		arg_495_1.state_ = "playing"
		arg_495_1.curTalkId_ = 1108411119
		arg_495_1.duration_ = 6

		SetActive(arg_495_1.tipsGo_, false)

		function arg_495_1.onSingleLineFinish_()
			arg_495_1.onSingleLineUpdate_ = nil
			arg_495_1.onSingleLineFinish_ = nil
			arg_495_1.state_ = "waiting"
		end

		function arg_495_1.playNext_(arg_497_0)
			if arg_497_0 == 1 then
				arg_495_0:Play1108411120(arg_495_1)
			end
		end

		function arg_495_1.onSingleLineUpdate_(arg_498_0)
			local var_498_9000

			if 0 < arg_495_1.time_ and arg_495_1.time_ <= 0 + arg_498_0 and not isNil(arg_495_1.actors_["10102ui_story"]) and arg_495_1.var_.characterEffect10102ui_story == nil then
				arg_495_1.var_.characterEffect10102ui_story = arg_495_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_498_0 = 0.200000002980232

			if 0 <= arg_495_1.time_ and arg_495_1.time_ < 0 + var_498_0 and not isNil(arg_495_1.actors_["10102ui_story"]) then
				if arg_495_1.var_.characterEffect10102ui_story and not isNil(arg_495_1.actors_["10102ui_story"]) then
					arg_495_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_495_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_495_1.time_ - 0) / var_498_0)
				end
			end

			if arg_495_1.time_ >= 0 + var_498_0 and arg_495_1.time_ < 0 + var_498_0 + arg_498_0 and not isNil(arg_495_1.actors_["10102ui_story"]) and arg_495_1.var_.characterEffect10102ui_story then
				arg_495_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_495_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			if 0 < arg_495_1.time_ and arg_495_1.time_ <= 0 + arg_498_0 then
				local var_498_1 = arg_495_1.var_.effect1232

				if not arg_495_1.var_.effect1232 then
					var_498_1 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_juguangdeng01_out"), manager.ui.mainCamera.transform)
					var_498_1.name = "1232"
					arg_495_1.var_.effect1232 = var_498_1
				else
					var_498_1.transform:SetParent(var_498_9000)
				end

				var_498_1.transform.localPosition = Vector3.New(0.09, -0.41, 3.42)
				var_498_1.transform.localRotation = Quaternion.Euler(0, 0, 0)
				var_498_1.transform.localScale = Vector3.New(var_498_1.transform.localScale.x * (Screen.width / Screen.height / 1.7777777777777777), var_498_1.transform.localScale.y * Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1), var_498_1.transform.localScale.z)
			end

			if 1.76666666666667 < arg_495_1.time_ and arg_495_1.time_ <= 1.76666666666667 + arg_498_0 then
				if arg_495_1.var_.effect1232 then
					Object.Destroy(arg_495_1.var_.effect1232)

					arg_495_1.var_.effect1232 = nil
				end
			end

			local var_498_4 = 0

			if 0 < arg_495_1.time_ and arg_495_1.time_ <= var_498_4 + arg_498_0 then
				arg_495_1.allBtn_.enabled = false
			end

			if arg_495_1.time_ >= var_498_4 + 1.6 and arg_495_1.time_ < var_498_4 + 1.6 + arg_498_0 then
				arg_495_1.allBtn_.enabled = true
			end

			if arg_495_1.frameCnt_ <= 1 then
				arg_495_1.dialog_:SetActive(false)
			end

			local var_498_5 = 1
			local var_498_6 = 1.25

			if 1 < arg_495_1.time_ and arg_495_1.time_ <= var_498_5 + arg_498_0 then
				arg_495_1.talkMaxDuration = 0

				arg_495_1.dialog_:SetActive(true)

				arg_495_1.dialogCg_.alpha = 0

				local var_498_7 = LeanTween.value(arg_495_1.dialog_, 0, 1, 0.3)

				var_498_7:setOnUpdate(LuaHelper.FloatAction(function(arg_499_0)
					arg_495_1.dialogCg_.alpha = arg_499_0
				end))
				var_498_7:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_495_1.dialog_)
					var_498_7:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_495_1.duration_ = arg_495_1.duration_ + 0.3

				SetActive(arg_495_1.leftNameGo_, false)

				arg_495_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_495_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_495_1:RecordName(arg_495_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_495_1.iconTrs_.gameObject, false)
				arg_495_1.callingController_:SetSelectedState("normal")

				local var_498_8 = arg_495_1:FormatText(arg_495_1:GetWordFromCfg(1108411119).content)

				arg_495_1.text_.text = var_498_8

				LuaForUtil.ClearLinePrefixSymbol(arg_495_1.text_)

				local var_498_10 = 50 <= 0 and var_498_6 or var_498_6 * (utf8.len(var_498_8) / 50)

				if (50 <= 0 and var_498_6 or var_498_6 * (utf8.len(var_498_8) / 50)) > 0 and var_498_6 < var_498_10 then
					arg_495_1.talkMaxDuration = var_498_10
					var_498_5 = var_498_5 + 0.3

					if var_498_10 + var_498_5 > arg_495_1.duration_ then
						arg_495_1.duration_ = var_498_10 + var_498_5
					end
				end

				arg_495_1.text_.text = var_498_8
				arg_495_1.typewritter.percent = 0

				arg_495_1.typewritter:SetDirty()
				arg_495_1:ShowNextGo(false)
				arg_495_1:RecordContent(arg_495_1.text_.text)
			end

			local var_498_11 = var_498_5 + 0.3
			local var_498_12 = math.max(var_498_6, arg_495_1.talkMaxDuration)

			if var_498_5 + 0.3 <= arg_495_1.time_ and arg_495_1.time_ < var_498_11 + var_498_12 then
				arg_495_1.typewritter.percent = (arg_495_1.time_ - var_498_11) / var_498_12

				arg_495_1.typewritter:SetDirty()
			end

			if arg_495_1.time_ >= var_498_11 + var_498_12 and arg_495_1.time_ < var_498_11 + var_498_12 + arg_498_0 then
				arg_495_1.typewritter.percent = 1

				arg_495_1.typewritter:SetDirty()
				arg_495_1:ShowNextGo(true)
			end
		end

		arg_495_1.nodeConfigList_ = {}

		arg_495_1:InitPlayNodeList()
	end,
	Play1108411120 = function(arg_501_0, arg_501_1)
		arg_501_1.time_ = 0
		arg_501_1.frameCnt_ = 0
		arg_501_1.state_ = "playing"
		arg_501_1.curTalkId_ = 1108411120
		arg_501_1.duration_ = 5

		SetActive(arg_501_1.tipsGo_, false)

		function arg_501_1.onSingleLineFinish_()
			arg_501_1.onSingleLineUpdate_ = nil
			arg_501_1.onSingleLineFinish_ = nil
			arg_501_1.state_ = "waiting"
		end

		function arg_501_1.playNext_(arg_503_0)
			if arg_503_0 == 1 then
				arg_501_0:Play1108411121(arg_501_1)
			end
		end

		function arg_501_1.onSingleLineUpdate_(arg_504_0)
			local var_504_0 = 0.1

			if 0 < arg_501_1.time_ and arg_501_1.time_ <= 0 + arg_504_0 then
				arg_501_1.talkMaxDuration = 0
				arg_501_1.dialogCg_.alpha = 1

				arg_501_1.dialog_:SetActive(true)
				SetActive(arg_501_1.leftNameGo_, true)

				arg_501_1.leftNameTxt_.text = arg_501_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_501_1.leftNameTxt_.transform)

				arg_501_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_501_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_501_1:RecordName(arg_501_1.leftNameTxt_.text)
				SetActive(arg_501_1.iconTrs_.gameObject, true)
				arg_501_1.iconController_:SetSelectedState("hero")

				arg_501_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_501_1.callingController_:SetSelectedState("normal")

				arg_501_1.keyicon_.color = Color.New(1, 1, 1)
				arg_501_1.icon_.color = Color.New(1, 1, 1)

				local var_504_1 = arg_501_1:FormatText(arg_501_1:GetWordFromCfg(1108411120).content)

				arg_501_1.text_.text = var_504_1

				LuaForUtil.ClearLinePrefixSymbol(arg_501_1.text_)

				local var_504_3 = 4 <= 0 and var_504_0 or var_504_0 * (utf8.len(var_504_1) / 4)

				if (4 <= 0 and var_504_0 or var_504_0 * (utf8.len(var_504_1) / 4)) > 0 and var_504_0 < var_504_3 then
					arg_501_1.talkMaxDuration = var_504_3

					if var_504_3 + 0 > arg_501_1.duration_ then
						arg_501_1.duration_ = var_504_3 + 0
					end
				end

				arg_501_1.text_.text = var_504_1
				arg_501_1.typewritter.percent = 0

				arg_501_1.typewritter:SetDirty()
				arg_501_1:ShowNextGo(false)
				arg_501_1:RecordContent(arg_501_1.text_.text)
			end

			local var_504_4 = math.max(var_504_0, arg_501_1.talkMaxDuration)

			if 0 <= arg_501_1.time_ and arg_501_1.time_ < 0 + var_504_4 then
				arg_501_1.typewritter.percent = (arg_501_1.time_ - 0) / var_504_4

				arg_501_1.typewritter:SetDirty()
			end

			if arg_501_1.time_ >= 0 + var_504_4 and arg_501_1.time_ < 0 + var_504_4 + arg_504_0 then
				arg_501_1.typewritter.percent = 1

				arg_501_1.typewritter:SetDirty()
				arg_501_1:ShowNextGo(true)
			end
		end

		arg_501_1.nodeConfigList_ = {}

		arg_501_1:InitPlayNodeList()
	end,
	Play1108411121 = function(arg_505_0, arg_505_1)
		arg_505_1.time_ = 0
		arg_505_1.frameCnt_ = 0
		arg_505_1.state_ = "playing"
		arg_505_1.curTalkId_ = 1108411121
		arg_505_1.duration_ = 8.1

		local var_505_0 = {
			zh = 5.733,
			ja = 8.1
		}
		local var_505_1 = manager.audio:GetLocalizationFlag()

		if var_505_0[var_505_1] ~= nil then
			arg_505_1.duration_ = var_505_0[var_505_1]
		end

		SetActive(arg_505_1.tipsGo_, false)

		function arg_505_1.onSingleLineFinish_()
			arg_505_1.onSingleLineUpdate_ = nil
			arg_505_1.onSingleLineFinish_ = nil
			arg_505_1.state_ = "waiting"
		end

		function arg_505_1.playNext_(arg_507_0)
			if arg_507_0 == 1 then
				arg_505_0:Play1108411122(arg_505_1)
			end
		end

		function arg_505_1.onSingleLineUpdate_(arg_508_0)
			local var_508_0 = 0.65

			if 0 < arg_505_1.time_ and arg_505_1.time_ <= 0 + arg_508_0 then
				arg_505_1.talkMaxDuration = 0
				arg_505_1.dialogCg_.alpha = 1

				arg_505_1.dialog_:SetActive(true)
				SetActive(arg_505_1.leftNameGo_, true)

				arg_505_1.leftNameTxt_.text = arg_505_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_505_1.leftNameTxt_.transform)

				arg_505_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_505_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_505_1:RecordName(arg_505_1.leftNameTxt_.text)
				SetActive(arg_505_1.iconTrs_.gameObject, true)
				arg_505_1.iconController_:SetSelectedState("hero")

				arg_505_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10102_split_1")

				arg_505_1.callingController_:SetSelectedState("normal")

				arg_505_1.keyicon_.color = Color.New(1, 1, 1)
				arg_505_1.icon_.color = Color.New(1, 1, 1)

				local var_508_1 = arg_505_1:GetWordFromCfg(1108411121)
				local var_508_2 = arg_505_1:FormatText(var_508_1.content)

				arg_505_1.text_.text = var_508_2

				LuaForUtil.ClearLinePrefixSymbol(arg_505_1.text_)

				local var_508_4 = 26 <= 0 and var_508_0 or var_508_0 * (utf8.len(var_508_2) / 26)

				if (26 <= 0 and var_508_0 or var_508_0 * (utf8.len(var_508_2) / 26)) > 0 and var_508_0 < var_508_4 then
					arg_505_1.talkMaxDuration = var_508_4

					if var_508_4 + 0 > arg_505_1.duration_ then
						arg_505_1.duration_ = var_508_4 + 0
					end
				end

				arg_505_1.text_.text = var_508_2
				arg_505_1.typewritter.percent = 0

				arg_505_1.typewritter:SetDirty()
				arg_505_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411121", "story_v_side_new_1108411.awb") ~= 0 then
					local var_508_5 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411121", "story_v_side_new_1108411.awb") / 1000

					if var_508_5 + 0 > arg_505_1.duration_ then
						arg_505_1.duration_ = var_508_5 + 0
					end

					if var_508_1.prefab_name ~= "" and arg_505_1.actors_[var_508_1.prefab_name] ~= nil then
						local var_508_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_505_1.actors_[var_508_1.prefab_name].transform, "story_v_side_new_1108411", "1108411121", "story_v_side_new_1108411.awb")

						arg_505_1:RecordAudio("1108411121", var_508_6)
						arg_505_1:RecordAudio("1108411121", var_508_6)
					else
						arg_505_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411121", "story_v_side_new_1108411.awb")
					end

					arg_505_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411121", "story_v_side_new_1108411.awb")
				end

				arg_505_1:RecordContent(arg_505_1.text_.text)
			end

			local var_508_7 = math.max(var_508_0, arg_505_1.talkMaxDuration)

			if 0 <= arg_505_1.time_ and arg_505_1.time_ < 0 + var_508_7 then
				arg_505_1.typewritter.percent = (arg_505_1.time_ - 0) / var_508_7

				arg_505_1.typewritter:SetDirty()
			end

			if arg_505_1.time_ >= 0 + var_508_7 and arg_505_1.time_ < 0 + var_508_7 + arg_508_0 then
				arg_505_1.typewritter.percent = 1

				arg_505_1.typewritter:SetDirty()
				arg_505_1:ShowNextGo(true)
			end
		end

		arg_505_1.nodeConfigList_ = {}

		arg_505_1:InitPlayNodeList()
	end,
	Play1108411122 = function(arg_509_0, arg_509_1)
		arg_509_1.time_ = 0
		arg_509_1.frameCnt_ = 0
		arg_509_1.state_ = "playing"
		arg_509_1.curTalkId_ = 1108411122
		arg_509_1.duration_ = 5

		SetActive(arg_509_1.tipsGo_, false)

		function arg_509_1.onSingleLineFinish_()
			arg_509_1.onSingleLineUpdate_ = nil
			arg_509_1.onSingleLineFinish_ = nil
			arg_509_1.state_ = "waiting"
		end

		function arg_509_1.playNext_(arg_511_0)
			if arg_511_0 == 1 then
				arg_509_0:Play1108411123(arg_509_1)
			end
		end

		function arg_509_1.onSingleLineUpdate_(arg_512_0)
			if 0 < arg_509_1.time_ and arg_509_1.time_ <= 0 + arg_512_0 and not isNil(arg_509_1.actors_["10102ui_story"]) and arg_509_1.var_.characterEffect10102ui_story == nil then
				arg_509_1.var_.characterEffect10102ui_story = arg_509_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_512_0 = 0.200000002980232

			if 0 <= arg_509_1.time_ and arg_509_1.time_ < 0 + var_512_0 and not isNil(arg_509_1.actors_["10102ui_story"]) then
				if arg_509_1.var_.characterEffect10102ui_story and not isNil(arg_509_1.actors_["10102ui_story"]) then
					arg_509_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_509_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_509_1.time_ - 0) / var_512_0)
				end
			end

			if arg_509_1.time_ >= 0 + var_512_0 and arg_509_1.time_ < 0 + var_512_0 + arg_512_0 and not isNil(arg_509_1.actors_["10102ui_story"]) and arg_509_1.var_.characterEffect10102ui_story then
				arg_509_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_509_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_512_1 = 0
			local var_512_2 = 0.525

			if 0 < arg_509_1.time_ and arg_509_1.time_ <= var_512_1 + arg_512_0 then
				arg_509_1.talkMaxDuration = 0
				arg_509_1.dialogCg_.alpha = 1

				arg_509_1.dialog_:SetActive(true)
				SetActive(arg_509_1.leftNameGo_, true)

				arg_509_1.leftNameTxt_.text = arg_509_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_509_1.leftNameTxt_.transform)

				arg_509_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_509_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_509_1:RecordName(arg_509_1.leftNameTxt_.text)
				SetActive(arg_509_1.iconTrs_.gameObject, true)
				arg_509_1.iconController_:SetSelectedState("hero")

				arg_509_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_509_1.callingController_:SetSelectedState("normal")

				arg_509_1.keyicon_.color = Color.New(1, 1, 1)
				arg_509_1.icon_.color = Color.New(1, 1, 1)

				local var_512_3 = arg_509_1:FormatText(arg_509_1:GetWordFromCfg(1108411122).content)

				arg_509_1.text_.text = var_512_3

				LuaForUtil.ClearLinePrefixSymbol(arg_509_1.text_)

				local var_512_5 = 21 <= 0 and var_512_2 or var_512_2 * (utf8.len(var_512_3) / 21)

				if (21 <= 0 and var_512_2 or var_512_2 * (utf8.len(var_512_3) / 21)) > 0 and var_512_2 < var_512_5 then
					arg_509_1.talkMaxDuration = var_512_5

					if var_512_5 + var_512_1 > arg_509_1.duration_ then
						arg_509_1.duration_ = var_512_5 + var_512_1
					end
				end

				arg_509_1.text_.text = var_512_3
				arg_509_1.typewritter.percent = 0

				arg_509_1.typewritter:SetDirty()
				arg_509_1:ShowNextGo(false)
				arg_509_1:RecordContent(arg_509_1.text_.text)
			end

			local var_512_6 = math.max(var_512_2, arg_509_1.talkMaxDuration)

			if var_512_1 <= arg_509_1.time_ and arg_509_1.time_ < var_512_1 + var_512_6 then
				arg_509_1.typewritter.percent = (arg_509_1.time_ - var_512_1) / var_512_6

				arg_509_1.typewritter:SetDirty()
			end

			if arg_509_1.time_ >= var_512_1 + var_512_6 and arg_509_1.time_ < var_512_1 + var_512_6 + arg_512_0 then
				arg_509_1.typewritter.percent = 1

				arg_509_1.typewritter:SetDirty()
				arg_509_1:ShowNextGo(true)
			end
		end

		arg_509_1.nodeConfigList_ = {}

		arg_509_1:InitPlayNodeList()
	end,
	Play1108411123 = function(arg_513_0, arg_513_1)
		arg_513_1.time_ = 0
		arg_513_1.frameCnt_ = 0
		arg_513_1.state_ = "playing"
		arg_513_1.curTalkId_ = 1108411123
		arg_513_1.duration_ = 5.57

		local var_513_0 = {
			zh = 3.4,
			ja = 5.566
		}
		local var_513_1 = manager.audio:GetLocalizationFlag()

		if var_513_0[var_513_1] ~= nil then
			arg_513_1.duration_ = var_513_0[var_513_1]
		end

		SetActive(arg_513_1.tipsGo_, false)

		function arg_513_1.onSingleLineFinish_()
			arg_513_1.onSingleLineUpdate_ = nil
			arg_513_1.onSingleLineFinish_ = nil
			arg_513_1.state_ = "waiting"
		end

		function arg_513_1.playNext_(arg_515_0)
			if arg_515_0 == 1 then
				arg_513_0:Play1108411124(arg_513_1)
			end
		end

		function arg_513_1.onSingleLineUpdate_(arg_516_0)
			if 0 < arg_513_1.time_ and arg_513_1.time_ <= 0 + arg_516_0 and not isNil(arg_513_1.actors_["10102ui_story"]) and arg_513_1.var_.characterEffect10102ui_story == nil then
				arg_513_1.var_.characterEffect10102ui_story = arg_513_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_516_0 = 0.200000002980232

			if 0 <= arg_513_1.time_ and arg_513_1.time_ < 0 + var_516_0 and not isNil(arg_513_1.actors_["10102ui_story"]) then
				if arg_513_1.var_.characterEffect10102ui_story and not isNil(arg_513_1.actors_["10102ui_story"]) then
					arg_513_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_513_1.time_ >= 0 + var_516_0 and arg_513_1.time_ < 0 + var_516_0 + arg_516_0 and not isNil(arg_513_1.actors_["10102ui_story"]) and arg_513_1.var_.characterEffect10102ui_story then
				arg_513_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_516_2 = 0
			local var_516_3 = 0.35

			if 0 < arg_513_1.time_ and arg_513_1.time_ <= var_516_2 + arg_516_0 then
				arg_513_1.talkMaxDuration = 0
				arg_513_1.dialogCg_.alpha = 1

				arg_513_1.dialog_:SetActive(true)
				SetActive(arg_513_1.leftNameGo_, true)

				arg_513_1.leftNameTxt_.text = arg_513_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_513_1.leftNameTxt_.transform)

				arg_513_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_513_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_513_1:RecordName(arg_513_1.leftNameTxt_.text)
				SetActive(arg_513_1.iconTrs_.gameObject, true)
				arg_513_1.iconController_:SetSelectedState("hero")

				arg_513_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10102_split_1")

				arg_513_1.callingController_:SetSelectedState("normal")

				arg_513_1.keyicon_.color = Color.New(1, 1, 1)
				arg_513_1.icon_.color = Color.New(1, 1, 1)

				local var_516_4 = arg_513_1:GetWordFromCfg(1108411123)
				local var_516_5 = arg_513_1:FormatText(var_516_4.content)

				arg_513_1.text_.text = var_516_5

				LuaForUtil.ClearLinePrefixSymbol(arg_513_1.text_)

				local var_516_7 = 14 <= 0 and var_516_3 or var_516_3 * (utf8.len(var_516_5) / 14)

				if (14 <= 0 and var_516_3 or var_516_3 * (utf8.len(var_516_5) / 14)) > 0 and var_516_3 < var_516_7 then
					arg_513_1.talkMaxDuration = var_516_7

					if var_516_7 + var_516_2 > arg_513_1.duration_ then
						arg_513_1.duration_ = var_516_7 + var_516_2
					end
				end

				arg_513_1.text_.text = var_516_5
				arg_513_1.typewritter.percent = 0

				arg_513_1.typewritter:SetDirty()
				arg_513_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411123", "story_v_side_new_1108411.awb") ~= 0 then
					local var_516_8 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411123", "story_v_side_new_1108411.awb") / 1000

					if var_516_8 + var_516_2 > arg_513_1.duration_ then
						arg_513_1.duration_ = var_516_8 + var_516_2
					end

					if var_516_4.prefab_name ~= "" and arg_513_1.actors_[var_516_4.prefab_name] ~= nil then
						local var_516_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_513_1.actors_[var_516_4.prefab_name].transform, "story_v_side_new_1108411", "1108411123", "story_v_side_new_1108411.awb")

						arg_513_1:RecordAudio("1108411123", var_516_9)
						arg_513_1:RecordAudio("1108411123", var_516_9)
					else
						arg_513_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411123", "story_v_side_new_1108411.awb")
					end

					arg_513_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411123", "story_v_side_new_1108411.awb")
				end

				arg_513_1:RecordContent(arg_513_1.text_.text)
			end

			local var_516_10 = math.max(var_516_3, arg_513_1.talkMaxDuration)

			if var_516_2 <= arg_513_1.time_ and arg_513_1.time_ < var_516_2 + var_516_10 then
				arg_513_1.typewritter.percent = (arg_513_1.time_ - var_516_2) / var_516_10

				arg_513_1.typewritter:SetDirty()
			end

			if arg_513_1.time_ >= var_516_2 + var_516_10 and arg_513_1.time_ < var_516_2 + var_516_10 + arg_516_0 then
				arg_513_1.typewritter.percent = 1

				arg_513_1.typewritter:SetDirty()
				arg_513_1:ShowNextGo(true)
			end
		end

		arg_513_1.nodeConfigList_ = {}

		arg_513_1:InitPlayNodeList()
	end,
	Play1108411124 = function(arg_517_0, arg_517_1)
		arg_517_1.time_ = 0
		arg_517_1.frameCnt_ = 0
		arg_517_1.state_ = "playing"
		arg_517_1.curTalkId_ = 1108411124
		arg_517_1.duration_ = 3.63

		local var_517_0 = {
			zh = 2.166,
			ja = 3.633
		}
		local var_517_1 = manager.audio:GetLocalizationFlag()

		if var_517_0[var_517_1] ~= nil then
			arg_517_1.duration_ = var_517_0[var_517_1]
		end

		SetActive(arg_517_1.tipsGo_, false)

		function arg_517_1.onSingleLineFinish_()
			arg_517_1.onSingleLineUpdate_ = nil
			arg_517_1.onSingleLineFinish_ = nil
			arg_517_1.state_ = "waiting"
		end

		function arg_517_1.playNext_(arg_519_0)
			if arg_519_0 == 1 then
				arg_517_0:Play1108411125(arg_517_1)
			end
		end

		function arg_517_1.onSingleLineUpdate_(arg_520_0)
			local var_520_0 = 0.275

			if 0 < arg_517_1.time_ and arg_517_1.time_ <= 0 + arg_520_0 then
				arg_517_1.talkMaxDuration = 0
				arg_517_1.dialogCg_.alpha = 1

				arg_517_1.dialog_:SetActive(true)
				SetActive(arg_517_1.leftNameGo_, true)

				arg_517_1.leftNameTxt_.text = arg_517_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_517_1.leftNameTxt_.transform)

				arg_517_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_517_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_517_1:RecordName(arg_517_1.leftNameTxt_.text)
				SetActive(arg_517_1.iconTrs_.gameObject, true)
				arg_517_1.iconController_:SetSelectedState("hero")

				arg_517_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10102_split_1")

				arg_517_1.callingController_:SetSelectedState("normal")

				arg_517_1.keyicon_.color = Color.New(1, 1, 1)
				arg_517_1.icon_.color = Color.New(1, 1, 1)

				local var_520_1 = arg_517_1:GetWordFromCfg(1108411124)
				local var_520_2 = arg_517_1:FormatText(var_520_1.content)

				arg_517_1.text_.text = var_520_2

				LuaForUtil.ClearLinePrefixSymbol(arg_517_1.text_)

				local var_520_4 = 11 <= 0 and var_520_0 or var_520_0 * (utf8.len(var_520_2) / 11)

				if (11 <= 0 and var_520_0 or var_520_0 * (utf8.len(var_520_2) / 11)) > 0 and var_520_0 < var_520_4 then
					arg_517_1.talkMaxDuration = var_520_4

					if var_520_4 + 0 > arg_517_1.duration_ then
						arg_517_1.duration_ = var_520_4 + 0
					end
				end

				arg_517_1.text_.text = var_520_2
				arg_517_1.typewritter.percent = 0

				arg_517_1.typewritter:SetDirty()
				arg_517_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411124", "story_v_side_new_1108411.awb") ~= 0 then
					local var_520_5 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411124", "story_v_side_new_1108411.awb") / 1000

					if var_520_5 + 0 > arg_517_1.duration_ then
						arg_517_1.duration_ = var_520_5 + 0
					end

					if var_520_1.prefab_name ~= "" and arg_517_1.actors_[var_520_1.prefab_name] ~= nil then
						local var_520_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_517_1.actors_[var_520_1.prefab_name].transform, "story_v_side_new_1108411", "1108411124", "story_v_side_new_1108411.awb")

						arg_517_1:RecordAudio("1108411124", var_520_6)
						arg_517_1:RecordAudio("1108411124", var_520_6)
					else
						arg_517_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411124", "story_v_side_new_1108411.awb")
					end

					arg_517_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411124", "story_v_side_new_1108411.awb")
				end

				arg_517_1:RecordContent(arg_517_1.text_.text)
			end

			local var_520_7 = math.max(var_520_0, arg_517_1.talkMaxDuration)

			if 0 <= arg_517_1.time_ and arg_517_1.time_ < 0 + var_520_7 then
				arg_517_1.typewritter.percent = (arg_517_1.time_ - 0) / var_520_7

				arg_517_1.typewritter:SetDirty()
			end

			if arg_517_1.time_ >= 0 + var_520_7 and arg_517_1.time_ < 0 + var_520_7 + arg_520_0 then
				arg_517_1.typewritter.percent = 1

				arg_517_1.typewritter:SetDirty()
				arg_517_1:ShowNextGo(true)
			end
		end

		arg_517_1.nodeConfigList_ = {}

		arg_517_1:InitPlayNodeList()
	end,
	Play1108411125 = function(arg_521_0, arg_521_1)
		arg_521_1.time_ = 0
		arg_521_1.frameCnt_ = 0
		arg_521_1.state_ = "playing"
		arg_521_1.curTalkId_ = 1108411125
		arg_521_1.duration_ = 6.03

		local var_521_0 = {
			zh = 4.366,
			ja = 6.033
		}
		local var_521_1 = manager.audio:GetLocalizationFlag()

		if var_521_0[var_521_1] ~= nil then
			arg_521_1.duration_ = var_521_0[var_521_1]
		end

		SetActive(arg_521_1.tipsGo_, false)

		function arg_521_1.onSingleLineFinish_()
			arg_521_1.onSingleLineUpdate_ = nil
			arg_521_1.onSingleLineFinish_ = nil
			arg_521_1.state_ = "waiting"
		end

		function arg_521_1.playNext_(arg_523_0)
			if arg_523_0 == 1 then
				arg_521_0:Play1108411126(arg_521_1)
			end
		end

		function arg_521_1.onSingleLineUpdate_(arg_524_0)
			local var_524_0 = 0.575

			if 0 < arg_521_1.time_ and arg_521_1.time_ <= 0 + arg_524_0 then
				arg_521_1.talkMaxDuration = 0
				arg_521_1.dialogCg_.alpha = 1

				arg_521_1.dialog_:SetActive(true)
				SetActive(arg_521_1.leftNameGo_, true)

				arg_521_1.leftNameTxt_.text = arg_521_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_521_1.leftNameTxt_.transform)

				arg_521_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_521_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_521_1:RecordName(arg_521_1.leftNameTxt_.text)
				SetActive(arg_521_1.iconTrs_.gameObject, true)
				arg_521_1.iconController_:SetSelectedState("hero")

				arg_521_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10102")

				arg_521_1.callingController_:SetSelectedState("normal")

				arg_521_1.keyicon_.color = Color.New(1, 1, 1)
				arg_521_1.icon_.color = Color.New(1, 1, 1)

				local var_524_1 = arg_521_1:GetWordFromCfg(1108411125)
				local var_524_2 = arg_521_1:FormatText(var_524_1.content)

				arg_521_1.text_.text = var_524_2

				LuaForUtil.ClearLinePrefixSymbol(arg_521_1.text_)

				local var_524_4 = 23 <= 0 and var_524_0 or var_524_0 * (utf8.len(var_524_2) / 23)

				if (23 <= 0 and var_524_0 or var_524_0 * (utf8.len(var_524_2) / 23)) > 0 and var_524_0 < var_524_4 then
					arg_521_1.talkMaxDuration = var_524_4

					if var_524_4 + 0 > arg_521_1.duration_ then
						arg_521_1.duration_ = var_524_4 + 0
					end
				end

				arg_521_1.text_.text = var_524_2
				arg_521_1.typewritter.percent = 0

				arg_521_1.typewritter:SetDirty()
				arg_521_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411125", "story_v_side_new_1108411.awb") ~= 0 then
					local var_524_5 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411125", "story_v_side_new_1108411.awb") / 1000

					if var_524_5 + 0 > arg_521_1.duration_ then
						arg_521_1.duration_ = var_524_5 + 0
					end

					if var_524_1.prefab_name ~= "" and arg_521_1.actors_[var_524_1.prefab_name] ~= nil then
						local var_524_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_521_1.actors_[var_524_1.prefab_name].transform, "story_v_side_new_1108411", "1108411125", "story_v_side_new_1108411.awb")

						arg_521_1:RecordAudio("1108411125", var_524_6)
						arg_521_1:RecordAudio("1108411125", var_524_6)
					else
						arg_521_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411125", "story_v_side_new_1108411.awb")
					end

					arg_521_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411125", "story_v_side_new_1108411.awb")
				end

				arg_521_1:RecordContent(arg_521_1.text_.text)
			end

			local var_524_7 = math.max(var_524_0, arg_521_1.talkMaxDuration)

			if 0 <= arg_521_1.time_ and arg_521_1.time_ < 0 + var_524_7 then
				arg_521_1.typewritter.percent = (arg_521_1.time_ - 0) / var_524_7

				arg_521_1.typewritter:SetDirty()
			end

			if arg_521_1.time_ >= 0 + var_524_7 and arg_521_1.time_ < 0 + var_524_7 + arg_524_0 then
				arg_521_1.typewritter.percent = 1

				arg_521_1.typewritter:SetDirty()
				arg_521_1:ShowNextGo(true)
			end
		end

		arg_521_1.nodeConfigList_ = {}

		arg_521_1:InitPlayNodeList()
	end,
	Play1108411126 = function(arg_525_0, arg_525_1)
		arg_525_1.time_ = 0
		arg_525_1.frameCnt_ = 0
		arg_525_1.state_ = "playing"
		arg_525_1.curTalkId_ = 1108411126
		arg_525_1.duration_ = 5

		SetActive(arg_525_1.tipsGo_, false)

		function arg_525_1.onSingleLineFinish_()
			arg_525_1.onSingleLineUpdate_ = nil
			arg_525_1.onSingleLineFinish_ = nil
			arg_525_1.state_ = "waiting"
		end

		function arg_525_1.playNext_(arg_527_0)
			if arg_527_0 == 1 then
				arg_525_0:Play1108411127(arg_525_1)
			end
		end

		function arg_525_1.onSingleLineUpdate_(arg_528_0)
			if 0 < arg_525_1.time_ and arg_525_1.time_ <= 0 + arg_528_0 and not isNil(arg_525_1.actors_["10102ui_story"]) and arg_525_1.var_.characterEffect10102ui_story == nil then
				arg_525_1.var_.characterEffect10102ui_story = arg_525_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_528_0 = 0.200000002980232

			if 0 <= arg_525_1.time_ and arg_525_1.time_ < 0 + var_528_0 and not isNil(arg_525_1.actors_["10102ui_story"]) then
				if arg_525_1.var_.characterEffect10102ui_story and not isNil(arg_525_1.actors_["10102ui_story"]) then
					arg_525_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_525_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_525_1.time_ - 0) / var_528_0)
				end
			end

			if arg_525_1.time_ >= 0 + var_528_0 and arg_525_1.time_ < 0 + var_528_0 + arg_528_0 and not isNil(arg_525_1.actors_["10102ui_story"]) and arg_525_1.var_.characterEffect10102ui_story then
				arg_525_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_525_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_528_1 = 0
			local var_528_2 = 0.425

			if 0 < arg_525_1.time_ and arg_525_1.time_ <= var_528_1 + arg_528_0 then
				arg_525_1.talkMaxDuration = 0
				arg_525_1.dialogCg_.alpha = 1

				arg_525_1.dialog_:SetActive(true)
				SetActive(arg_525_1.leftNameGo_, true)

				arg_525_1.leftNameTxt_.text = arg_525_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_525_1.leftNameTxt_.transform)

				arg_525_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_525_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_525_1:RecordName(arg_525_1.leftNameTxt_.text)
				SetActive(arg_525_1.iconTrs_.gameObject, true)
				arg_525_1.iconController_:SetSelectedState("hero")

				arg_525_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_525_1.callingController_:SetSelectedState("normal")

				arg_525_1.keyicon_.color = Color.New(1, 1, 1)
				arg_525_1.icon_.color = Color.New(1, 1, 1)

				local var_528_3 = arg_525_1:FormatText(arg_525_1:GetWordFromCfg(1108411126).content)

				arg_525_1.text_.text = var_528_3

				LuaForUtil.ClearLinePrefixSymbol(arg_525_1.text_)

				local var_528_5 = 17 <= 0 and var_528_2 or var_528_2 * (utf8.len(var_528_3) / 17)

				if (17 <= 0 and var_528_2 or var_528_2 * (utf8.len(var_528_3) / 17)) > 0 and var_528_2 < var_528_5 then
					arg_525_1.talkMaxDuration = var_528_5

					if var_528_5 + var_528_1 > arg_525_1.duration_ then
						arg_525_1.duration_ = var_528_5 + var_528_1
					end
				end

				arg_525_1.text_.text = var_528_3
				arg_525_1.typewritter.percent = 0

				arg_525_1.typewritter:SetDirty()
				arg_525_1:ShowNextGo(false)
				arg_525_1:RecordContent(arg_525_1.text_.text)
			end

			local var_528_6 = math.max(var_528_2, arg_525_1.talkMaxDuration)

			if var_528_1 <= arg_525_1.time_ and arg_525_1.time_ < var_528_1 + var_528_6 then
				arg_525_1.typewritter.percent = (arg_525_1.time_ - var_528_1) / var_528_6

				arg_525_1.typewritter:SetDirty()
			end

			if arg_525_1.time_ >= var_528_1 + var_528_6 and arg_525_1.time_ < var_528_1 + var_528_6 + arg_528_0 then
				arg_525_1.typewritter.percent = 1

				arg_525_1.typewritter:SetDirty()
				arg_525_1:ShowNextGo(true)
			end
		end

		arg_525_1.nodeConfigList_ = {}

		arg_525_1:InitPlayNodeList()
	end,
	Play1108411127 = function(arg_529_0, arg_529_1)
		arg_529_1.time_ = 0
		arg_529_1.frameCnt_ = 0
		arg_529_1.state_ = "playing"
		arg_529_1.curTalkId_ = 1108411127
		arg_529_1.duration_ = 5

		SetActive(arg_529_1.tipsGo_, false)

		function arg_529_1.onSingleLineFinish_()
			arg_529_1.onSingleLineUpdate_ = nil
			arg_529_1.onSingleLineFinish_ = nil
			arg_529_1.state_ = "waiting"
		end

		function arg_529_1.playNext_(arg_531_0)
			if arg_531_0 == 1 then
				arg_529_0:Play1108411128(arg_529_1)
			end
		end

		function arg_529_1.onSingleLineUpdate_(arg_532_0)
			local var_532_0 = 0.3

			if 0 < arg_529_1.time_ and arg_529_1.time_ <= 0 + arg_532_0 then
				arg_529_1.talkMaxDuration = 0
				arg_529_1.dialogCg_.alpha = 1

				arg_529_1.dialog_:SetActive(true)
				SetActive(arg_529_1.leftNameGo_, true)

				arg_529_1.leftNameTxt_.text = arg_529_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_529_1.leftNameTxt_.transform)

				arg_529_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_529_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_529_1:RecordName(arg_529_1.leftNameTxt_.text)
				SetActive(arg_529_1.iconTrs_.gameObject, true)
				arg_529_1.iconController_:SetSelectedState("hero")

				arg_529_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_529_1.callingController_:SetSelectedState("normal")

				arg_529_1.keyicon_.color = Color.New(1, 1, 1)
				arg_529_1.icon_.color = Color.New(1, 1, 1)

				local var_532_1 = arg_529_1:FormatText(arg_529_1:GetWordFromCfg(1108411127).content)

				arg_529_1.text_.text = var_532_1

				LuaForUtil.ClearLinePrefixSymbol(arg_529_1.text_)

				local var_532_3 = 12 <= 0 and var_532_0 or var_532_0 * (utf8.len(var_532_1) / 12)

				if (12 <= 0 and var_532_0 or var_532_0 * (utf8.len(var_532_1) / 12)) > 0 and var_532_0 < var_532_3 then
					arg_529_1.talkMaxDuration = var_532_3

					if var_532_3 + 0 > arg_529_1.duration_ then
						arg_529_1.duration_ = var_532_3 + 0
					end
				end

				arg_529_1.text_.text = var_532_1
				arg_529_1.typewritter.percent = 0

				arg_529_1.typewritter:SetDirty()
				arg_529_1:ShowNextGo(false)
				arg_529_1:RecordContent(arg_529_1.text_.text)
			end

			local var_532_4 = math.max(var_532_0, arg_529_1.talkMaxDuration)

			if 0 <= arg_529_1.time_ and arg_529_1.time_ < 0 + var_532_4 then
				arg_529_1.typewritter.percent = (arg_529_1.time_ - 0) / var_532_4

				arg_529_1.typewritter:SetDirty()
			end

			if arg_529_1.time_ >= 0 + var_532_4 and arg_529_1.time_ < 0 + var_532_4 + arg_532_0 then
				arg_529_1.typewritter.percent = 1

				arg_529_1.typewritter:SetDirty()
				arg_529_1:ShowNextGo(true)
			end
		end

		arg_529_1.nodeConfigList_ = {}

		arg_529_1:InitPlayNodeList()
	end,
	Play1108411128 = function(arg_533_0, arg_533_1)
		arg_533_1.time_ = 0
		arg_533_1.frameCnt_ = 0
		arg_533_1.state_ = "playing"
		arg_533_1.curTalkId_ = 1108411128
		arg_533_1.duration_ = 1.7

		local var_533_0 = {
			zh = 1.333,
			ja = 1.7
		}
		local var_533_1 = manager.audio:GetLocalizationFlag()

		if var_533_0[var_533_1] ~= nil then
			arg_533_1.duration_ = var_533_0[var_533_1]
		end

		SetActive(arg_533_1.tipsGo_, false)

		function arg_533_1.onSingleLineFinish_()
			arg_533_1.onSingleLineUpdate_ = nil
			arg_533_1.onSingleLineFinish_ = nil
			arg_533_1.state_ = "waiting"
		end

		function arg_533_1.playNext_(arg_535_0)
			if arg_535_0 == 1 then
				arg_533_0:Play1108411129(arg_533_1)
			end
		end

		function arg_533_1.onSingleLineUpdate_(arg_536_0)
			local var_536_0 = 0.075

			if 0 < arg_533_1.time_ and arg_533_1.time_ <= 0 + arg_536_0 then
				arg_533_1.talkMaxDuration = 0
				arg_533_1.dialogCg_.alpha = 1

				arg_533_1.dialog_:SetActive(true)
				SetActive(arg_533_1.leftNameGo_, true)

				arg_533_1.leftNameTxt_.text = arg_533_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_533_1.leftNameTxt_.transform)

				arg_533_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_533_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_533_1:RecordName(arg_533_1.leftNameTxt_.text)
				SetActive(arg_533_1.iconTrs_.gameObject, true)
				arg_533_1.iconController_:SetSelectedState("hero")

				arg_533_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10102_split_2")

				arg_533_1.callingController_:SetSelectedState("normal")

				arg_533_1.keyicon_.color = Color.New(1, 1, 1)
				arg_533_1.icon_.color = Color.New(1, 1, 1)

				local var_536_1 = arg_533_1:GetWordFromCfg(1108411128)
				local var_536_2 = arg_533_1:FormatText(var_536_1.content)

				arg_533_1.text_.text = var_536_2

				LuaForUtil.ClearLinePrefixSymbol(arg_533_1.text_)

				local var_536_4 = 3 <= 0 and var_536_0 or var_536_0 * (utf8.len(var_536_2) / 3)

				if (3 <= 0 and var_536_0 or var_536_0 * (utf8.len(var_536_2) / 3)) > 0 and var_536_0 < var_536_4 then
					arg_533_1.talkMaxDuration = var_536_4

					if var_536_4 + 0 > arg_533_1.duration_ then
						arg_533_1.duration_ = var_536_4 + 0
					end
				end

				arg_533_1.text_.text = var_536_2
				arg_533_1.typewritter.percent = 0

				arg_533_1.typewritter:SetDirty()
				arg_533_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411128", "story_v_side_new_1108411.awb") ~= 0 then
					local var_536_5 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411128", "story_v_side_new_1108411.awb") / 1000

					if var_536_5 + 0 > arg_533_1.duration_ then
						arg_533_1.duration_ = var_536_5 + 0
					end

					if var_536_1.prefab_name ~= "" and arg_533_1.actors_[var_536_1.prefab_name] ~= nil then
						local var_536_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_533_1.actors_[var_536_1.prefab_name].transform, "story_v_side_new_1108411", "1108411128", "story_v_side_new_1108411.awb")

						arg_533_1:RecordAudio("1108411128", var_536_6)
						arg_533_1:RecordAudio("1108411128", var_536_6)
					else
						arg_533_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411128", "story_v_side_new_1108411.awb")
					end

					arg_533_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411128", "story_v_side_new_1108411.awb")
				end

				arg_533_1:RecordContent(arg_533_1.text_.text)
			end

			local var_536_7 = math.max(var_536_0, arg_533_1.talkMaxDuration)

			if 0 <= arg_533_1.time_ and arg_533_1.time_ < 0 + var_536_7 then
				arg_533_1.typewritter.percent = (arg_533_1.time_ - 0) / var_536_7

				arg_533_1.typewritter:SetDirty()
			end

			if arg_533_1.time_ >= 0 + var_536_7 and arg_533_1.time_ < 0 + var_536_7 + arg_536_0 then
				arg_533_1.typewritter.percent = 1

				arg_533_1.typewritter:SetDirty()
				arg_533_1:ShowNextGo(true)
			end
		end

		arg_533_1.nodeConfigList_ = {}

		arg_533_1:InitPlayNodeList()
	end,
	Play1108411129 = function(arg_537_0, arg_537_1)
		arg_537_1.time_ = 0
		arg_537_1.frameCnt_ = 0
		arg_537_1.state_ = "playing"
		arg_537_1.curTalkId_ = 1108411129
		arg_537_1.duration_ = 7.97

		SetActive(arg_537_1.tipsGo_, false)

		function arg_537_1.onSingleLineFinish_()
			arg_537_1.onSingleLineUpdate_ = nil
			arg_537_1.onSingleLineFinish_ = nil
			arg_537_1.state_ = "waiting"
		end

		function arg_537_1.playNext_(arg_539_0)
			if arg_539_0 == 1 then
				arg_537_0:Play1108411130(arg_537_1)
			end
		end

		function arg_537_1.onSingleLineUpdate_(arg_540_0)
			if arg_537_1.bgs_.ST0116a == nil then
				local var_540_0 = Object.Instantiate(arg_537_1.paintGo_)

				var_540_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST0116a")
				var_540_0.name = "ST0116a"
				var_540_0.transform.parent = arg_537_1.stage_.transform
				var_540_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_537_1.bgs_.ST0116a = var_540_0
			end

			if 1.43333333333333 < arg_537_1.time_ and arg_537_1.time_ <= 1.43333333333333 + arg_540_0 then
				local var_540_1 = arg_537_1.bgs_.ST0116a

				arg_537_1.bgs_.ST0116a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_540_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_540_2 = var_540_1:GetComponent("SpriteRenderer")

				if var_540_2 and var_540_2.sprite then
					local var_540_3 = 2 * (var_540_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_540_1.transform.localScale = Vector3.New(var_540_3 / var_540_2.sprite.bounds.size.y < var_540_3 * manager.ui.mainCameraCom_.aspect / var_540_2.sprite.bounds.size.x and var_540_3 * manager.ui.mainCameraCom_.aspect / var_540_2.sprite.bounds.size.x or var_540_3 / var_540_2.sprite.bounds.size.y, var_540_3 / var_540_2.sprite.bounds.size.y < var_540_3 * manager.ui.mainCameraCom_.aspect / var_540_2.sprite.bounds.size.x and var_540_3 * manager.ui.mainCameraCom_.aspect / var_540_2.sprite.bounds.size.x or var_540_3 / var_540_2.sprite.bounds.size.y, 0)
				end

				for iter_540_0, iter_540_1 in pairs(arg_537_1.bgs_) do
					if iter_540_0 ~= "ST0116a" then
						iter_540_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_540_4 = 0

			if 0 < arg_537_1.time_ and arg_537_1.time_ <= var_540_4 + arg_540_0 then
				arg_537_1.allBtn_.enabled = false
			end

			if arg_537_1.time_ >= var_540_4 + 0.3 and arg_537_1.time_ < var_540_4 + 0.3 + arg_540_0 then
				arg_537_1.allBtn_.enabled = true
			end

			local var_540_5 = 0

			if 0 < arg_537_1.time_ and arg_537_1.time_ <= var_540_5 + arg_540_0 then
				arg_537_1.mask_.enabled = true
				arg_537_1.mask_.raycastTarget = true

				arg_537_1:SetGaussion(false)
			end

			local var_540_6 = 1.43333333333333

			if var_540_5 <= arg_537_1.time_ and arg_537_1.time_ < var_540_5 + var_540_6 then
				local var_540_7 = Color.New(0, 0, 0)

				var_540_7.a = Mathf.Lerp(0, 1, (arg_537_1.time_ - var_540_5) / var_540_6)
				arg_537_1.mask_.color = var_540_7
			end

			if arg_537_1.time_ >= var_540_5 + var_540_6 and arg_537_1.time_ < var_540_5 + var_540_6 + arg_540_0 then
				local var_540_8 = Color.New(0, 0, 0)

				var_540_8.a = 1
				arg_537_1.mask_.color = var_540_8
			end

			local var_540_9 = 1.43333333333333

			if 1.43333333333333 < arg_537_1.time_ and arg_537_1.time_ <= var_540_9 + arg_540_0 then
				arg_537_1.mask_.enabled = true
				arg_537_1.mask_.raycastTarget = true

				arg_537_1:SetGaussion(false)
			end

			local var_540_10 = 2

			if var_540_9 <= arg_537_1.time_ and arg_537_1.time_ < var_540_9 + var_540_10 then
				local var_540_11 = Color.New(0, 0, 0)

				var_540_11.a = Mathf.Lerp(1, 0, (arg_537_1.time_ - var_540_9) / var_540_10)
				arg_537_1.mask_.color = var_540_11
			end

			if arg_537_1.time_ >= var_540_9 + var_540_10 and arg_537_1.time_ < var_540_9 + var_540_10 + arg_540_0 then
				local var_540_12 = Color.New(0, 0, 0)

				arg_537_1.mask_.enabled = false
				var_540_12.a = 0
				arg_537_1.mask_.color = var_540_12
			end

			if 0.166666666666667 < arg_537_1.time_ and arg_537_1.time_ <= 0.166666666666667 + arg_540_0 then
				arg_537_1:AudioAction("stop", "effect", "se_story_birthday4", "se_story_birthday4_amb_room_tone_2", "")
			end

			if 1 < arg_537_1.time_ and arg_537_1.time_ <= 1 + arg_540_0 then
				arg_537_1:AudioAction("play", "effect", "se_story_side_1095", "se_story_side_1095_amb_forest_night_nowater", "")
			end

			if arg_537_1.frameCnt_ <= 1 then
				arg_537_1.dialog_:SetActive(false)
			end

			local var_540_15 = 2.96666666666667
			local var_540_16 = 1.35

			if 2.96666666666667 < arg_537_1.time_ and arg_537_1.time_ <= var_540_15 + arg_540_0 then
				arg_537_1.talkMaxDuration = 0

				arg_537_1.dialog_:SetActive(true)

				arg_537_1.dialogCg_.alpha = 0

				local var_540_17 = LeanTween.value(arg_537_1.dialog_, 0, 1, 0.3)

				var_540_17:setOnUpdate(LuaHelper.FloatAction(function(arg_541_0)
					arg_537_1.dialogCg_.alpha = arg_541_0
				end))
				var_540_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_537_1.dialog_)
					var_540_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_537_1.duration_ = arg_537_1.duration_ + 0.3

				SetActive(arg_537_1.leftNameGo_, false)

				arg_537_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_537_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_537_1:RecordName(arg_537_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_537_1.iconTrs_.gameObject, false)
				arg_537_1.callingController_:SetSelectedState("normal")

				local var_540_18 = arg_537_1:FormatText(arg_537_1:GetWordFromCfg(1108411129).content)

				arg_537_1.text_.text = var_540_18

				LuaForUtil.ClearLinePrefixSymbol(arg_537_1.text_)

				local var_540_20 = 54 <= 0 and var_540_16 or var_540_16 * (utf8.len(var_540_18) / 54)

				if (54 <= 0 and var_540_16 or var_540_16 * (utf8.len(var_540_18) / 54)) > 0 and var_540_16 < var_540_20 then
					arg_537_1.talkMaxDuration = var_540_20
					var_540_15 = var_540_15 + 0.3

					if var_540_20 + var_540_15 > arg_537_1.duration_ then
						arg_537_1.duration_ = var_540_20 + var_540_15
					end
				end

				arg_537_1.text_.text = var_540_18
				arg_537_1.typewritter.percent = 0

				arg_537_1.typewritter:SetDirty()
				arg_537_1:ShowNextGo(false)
				arg_537_1:RecordContent(arg_537_1.text_.text)
			end

			local var_540_21 = var_540_15 + 0.3
			local var_540_22 = math.max(var_540_16, arg_537_1.talkMaxDuration)

			if var_540_15 + 0.3 <= arg_537_1.time_ and arg_537_1.time_ < var_540_21 + var_540_22 then
				arg_537_1.typewritter.percent = (arg_537_1.time_ - var_540_21) / var_540_22

				arg_537_1.typewritter:SetDirty()
			end

			if arg_537_1.time_ >= var_540_21 + var_540_22 and arg_537_1.time_ < var_540_21 + var_540_22 + arg_540_0 then
				arg_537_1.typewritter.percent = 1

				arg_537_1.typewritter:SetDirty()
				arg_537_1:ShowNextGo(true)
			end
		end

		arg_537_1.nodeConfigList_ = {}

		arg_537_1:InitPlayNodeList()
	end,
	Play1108411130 = function(arg_543_0, arg_543_1)
		arg_543_1.time_ = 0
		arg_543_1.frameCnt_ = 0
		arg_543_1.state_ = "playing"
		arg_543_1.curTalkId_ = 1108411130
		arg_543_1.duration_ = 5

		SetActive(arg_543_1.tipsGo_, false)

		function arg_543_1.onSingleLineFinish_()
			arg_543_1.onSingleLineUpdate_ = nil
			arg_543_1.onSingleLineFinish_ = nil
			arg_543_1.state_ = "waiting"
		end

		function arg_543_1.playNext_(arg_545_0)
			if arg_545_0 == 1 then
				arg_543_0:Play1108411131(arg_543_1)
			end
		end

		function arg_543_1.onSingleLineUpdate_(arg_546_0)
			local var_546_0 = 0.675

			if 0 < arg_543_1.time_ and arg_543_1.time_ <= 0 + arg_546_0 then
				arg_543_1.talkMaxDuration = 0
				arg_543_1.dialogCg_.alpha = 1

				arg_543_1.dialog_:SetActive(true)
				SetActive(arg_543_1.leftNameGo_, false)

				arg_543_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_543_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_543_1:RecordName(arg_543_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_543_1.iconTrs_.gameObject, false)
				arg_543_1.callingController_:SetSelectedState("normal")

				local var_546_1 = arg_543_1:FormatText(arg_543_1:GetWordFromCfg(1108411130).content)

				arg_543_1.text_.text = var_546_1

				LuaForUtil.ClearLinePrefixSymbol(arg_543_1.text_)

				local var_546_3 = 27 <= 0 and var_546_0 or var_546_0 * (utf8.len(var_546_1) / 27)

				if (27 <= 0 and var_546_0 or var_546_0 * (utf8.len(var_546_1) / 27)) > 0 and var_546_0 < var_546_3 then
					arg_543_1.talkMaxDuration = var_546_3

					if var_546_3 + 0 > arg_543_1.duration_ then
						arg_543_1.duration_ = var_546_3 + 0
					end
				end

				arg_543_1.text_.text = var_546_1
				arg_543_1.typewritter.percent = 0

				arg_543_1.typewritter:SetDirty()
				arg_543_1:ShowNextGo(false)
				arg_543_1:RecordContent(arg_543_1.text_.text)
			end

			local var_546_4 = math.max(var_546_0, arg_543_1.talkMaxDuration)

			if 0 <= arg_543_1.time_ and arg_543_1.time_ < 0 + var_546_4 then
				arg_543_1.typewritter.percent = (arg_543_1.time_ - 0) / var_546_4

				arg_543_1.typewritter:SetDirty()
			end

			if arg_543_1.time_ >= 0 + var_546_4 and arg_543_1.time_ < 0 + var_546_4 + arg_546_0 then
				arg_543_1.typewritter.percent = 1

				arg_543_1.typewritter:SetDirty()
				arg_543_1:ShowNextGo(true)
			end
		end

		arg_543_1.nodeConfigList_ = {}

		arg_543_1:InitPlayNodeList()
	end,
	Play1108411131 = function(arg_547_0, arg_547_1)
		arg_547_1.time_ = 0
		arg_547_1.frameCnt_ = 0
		arg_547_1.state_ = "playing"
		arg_547_1.curTalkId_ = 1108411131
		arg_547_1.duration_ = 8.67

		local var_547_0 = {
			zh = 5.366,
			ja = 8.666
		}
		local var_547_1 = manager.audio:GetLocalizationFlag()

		if var_547_0[var_547_1] ~= nil then
			arg_547_1.duration_ = var_547_0[var_547_1]
		end

		SetActive(arg_547_1.tipsGo_, false)

		function arg_547_1.onSingleLineFinish_()
			arg_547_1.onSingleLineUpdate_ = nil
			arg_547_1.onSingleLineFinish_ = nil
			arg_547_1.state_ = "waiting"
		end

		function arg_547_1.playNext_(arg_549_0)
			if arg_549_0 == 1 then
				arg_547_0:Play1108411132(arg_547_1)
			end
		end

		function arg_547_1.onSingleLineUpdate_(arg_550_0)
			if 0 < arg_547_1.time_ and arg_547_1.time_ <= 0 + arg_550_0 then
				arg_547_1.var_.moveOldPos10102ui_story = arg_547_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_550_0 = 0.001

			if 0 <= arg_547_1.time_ and arg_547_1.time_ < 0 + var_550_0 then
				arg_547_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_547_1.var_.moveOldPos10102ui_story, Vector3.New(0, -0.985, -6.275), (arg_547_1.time_ - 0) / var_550_0)
				arg_547_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_547_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_547_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_547_1.actors_["10102ui_story"].transform.position).z)
				arg_547_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_547_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_547_1.actors_["10102ui_story"].transform.localEulerAngles = arg_547_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_547_1.time_ >= 0 + var_550_0 and arg_547_1.time_ < 0 + var_550_0 + arg_550_0 then
				arg_547_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6.275)
				arg_547_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_547_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_547_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_547_1.actors_["10102ui_story"].transform.position).z)
				arg_547_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_547_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_547_1.actors_["10102ui_story"].transform.localEulerAngles = arg_547_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_550_1 = arg_547_1.actors_["10102ui_story"]

			if 0 < arg_547_1.time_ and arg_547_1.time_ <= 0 + arg_550_0 and not isNil(var_550_1) and arg_547_1.var_.characterEffect10102ui_story == nil then
				arg_547_1.var_.characterEffect10102ui_story = var_550_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_550_2 = 0.200000002980232

			if 0 <= arg_547_1.time_ and arg_547_1.time_ < 0 + var_550_2 and not isNil(var_550_1) then
				if arg_547_1.var_.characterEffect10102ui_story and not isNil(var_550_1) then
					arg_547_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_547_1.time_ >= 0 + var_550_2 and arg_547_1.time_ < 0 + var_550_2 + arg_550_0 and not isNil(var_550_1) and arg_547_1.var_.characterEffect10102ui_story then
				arg_547_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_547_1.time_ and arg_547_1.time_ <= 0 + arg_550_0 then
				arg_547_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action1_1")
			end

			if 0 < arg_547_1.time_ and arg_547_1.time_ <= 0 + arg_550_0 then
				arg_547_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_550_4 = 0
			local var_550_5 = 0.525

			if 0 < arg_547_1.time_ and arg_547_1.time_ <= var_550_4 + arg_550_0 then
				arg_547_1.talkMaxDuration = 0
				arg_547_1.dialogCg_.alpha = 1

				arg_547_1.dialog_:SetActive(true)
				SetActive(arg_547_1.leftNameGo_, true)

				arg_547_1.leftNameTxt_.text = arg_547_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_547_1.leftNameTxt_.transform)

				arg_547_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_547_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_547_1:RecordName(arg_547_1.leftNameTxt_.text)
				SetActive(arg_547_1.iconTrs_.gameObject, false)
				arg_547_1.callingController_:SetSelectedState("normal")

				local var_550_6 = arg_547_1:GetWordFromCfg(1108411131)
				local var_550_7 = arg_547_1:FormatText(var_550_6.content)

				arg_547_1.text_.text = var_550_7

				LuaForUtil.ClearLinePrefixSymbol(arg_547_1.text_)

				local var_550_9 = 21 <= 0 and var_550_5 or var_550_5 * (utf8.len(var_550_7) / 21)

				if (21 <= 0 and var_550_5 or var_550_5 * (utf8.len(var_550_7) / 21)) > 0 and var_550_5 < var_550_9 then
					arg_547_1.talkMaxDuration = var_550_9

					if var_550_9 + var_550_4 > arg_547_1.duration_ then
						arg_547_1.duration_ = var_550_9 + var_550_4
					end
				end

				arg_547_1.text_.text = var_550_7
				arg_547_1.typewritter.percent = 0

				arg_547_1.typewritter:SetDirty()
				arg_547_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411131", "story_v_side_new_1108411.awb") ~= 0 then
					local var_550_10 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411131", "story_v_side_new_1108411.awb") / 1000

					if var_550_10 + var_550_4 > arg_547_1.duration_ then
						arg_547_1.duration_ = var_550_10 + var_550_4
					end

					if var_550_6.prefab_name ~= "" and arg_547_1.actors_[var_550_6.prefab_name] ~= nil then
						local var_550_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_547_1.actors_[var_550_6.prefab_name].transform, "story_v_side_new_1108411", "1108411131", "story_v_side_new_1108411.awb")

						arg_547_1:RecordAudio("1108411131", var_550_11)
						arg_547_1:RecordAudio("1108411131", var_550_11)
					else
						arg_547_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411131", "story_v_side_new_1108411.awb")
					end

					arg_547_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411131", "story_v_side_new_1108411.awb")
				end

				arg_547_1:RecordContent(arg_547_1.text_.text)
			end

			local var_550_12 = math.max(var_550_5, arg_547_1.talkMaxDuration)

			if var_550_4 <= arg_547_1.time_ and arg_547_1.time_ < var_550_4 + var_550_12 then
				arg_547_1.typewritter.percent = (arg_547_1.time_ - var_550_4) / var_550_12

				arg_547_1.typewritter:SetDirty()
			end

			if arg_547_1.time_ >= var_550_4 + var_550_12 and arg_547_1.time_ < var_550_4 + var_550_12 + arg_550_0 then
				arg_547_1.typewritter.percent = 1

				arg_547_1.typewritter:SetDirty()
				arg_547_1:ShowNextGo(true)
			end
		end

		arg_547_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_547_1:InitPlayNodeList()
	end,
	Play1108411132 = function(arg_551_0, arg_551_1)
		arg_551_1.time_ = 0
		arg_551_1.frameCnt_ = 0
		arg_551_1.state_ = "playing"
		arg_551_1.curTalkId_ = 1108411132
		arg_551_1.duration_ = 5

		SetActive(arg_551_1.tipsGo_, false)

		function arg_551_1.onSingleLineFinish_()
			arg_551_1.onSingleLineUpdate_ = nil
			arg_551_1.onSingleLineFinish_ = nil
			arg_551_1.state_ = "waiting"
		end

		function arg_551_1.playNext_(arg_553_0)
			if arg_553_0 == 1 then
				arg_551_0:Play1108411133(arg_551_1)
			end
		end

		function arg_551_1.onSingleLineUpdate_(arg_554_0)
			if 0 < arg_551_1.time_ and arg_551_1.time_ <= 0 + arg_554_0 and not isNil(arg_551_1.actors_["10102ui_story"]) and arg_551_1.var_.characterEffect10102ui_story == nil then
				arg_551_1.var_.characterEffect10102ui_story = arg_551_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_554_0 = 0.200000002980232

			if 0 <= arg_551_1.time_ and arg_551_1.time_ < 0 + var_554_0 and not isNil(arg_551_1.actors_["10102ui_story"]) then
				if arg_551_1.var_.characterEffect10102ui_story and not isNil(arg_551_1.actors_["10102ui_story"]) then
					arg_551_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_551_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_551_1.time_ - 0) / var_554_0)
				end
			end

			if arg_551_1.time_ >= 0 + var_554_0 and arg_551_1.time_ < 0 + var_554_0 + arg_554_0 and not isNil(arg_551_1.actors_["10102ui_story"]) and arg_551_1.var_.characterEffect10102ui_story then
				arg_551_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_551_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_554_1 = 0
			local var_554_2 = 0.575

			if 0 < arg_551_1.time_ and arg_551_1.time_ <= var_554_1 + arg_554_0 then
				arg_551_1.talkMaxDuration = 0
				arg_551_1.dialogCg_.alpha = 1

				arg_551_1.dialog_:SetActive(true)
				SetActive(arg_551_1.leftNameGo_, true)

				arg_551_1.leftNameTxt_.text = arg_551_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_551_1.leftNameTxt_.transform)

				arg_551_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_551_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_551_1:RecordName(arg_551_1.leftNameTxt_.text)
				SetActive(arg_551_1.iconTrs_.gameObject, true)
				arg_551_1.iconController_:SetSelectedState("hero")

				arg_551_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_551_1.callingController_:SetSelectedState("normal")

				arg_551_1.keyicon_.color = Color.New(1, 1, 1)
				arg_551_1.icon_.color = Color.New(1, 1, 1)

				local var_554_3 = arg_551_1:FormatText(arg_551_1:GetWordFromCfg(1108411132).content)

				arg_551_1.text_.text = var_554_3

				LuaForUtil.ClearLinePrefixSymbol(arg_551_1.text_)

				local var_554_5 = 23 <= 0 and var_554_2 or var_554_2 * (utf8.len(var_554_3) / 23)

				if (23 <= 0 and var_554_2 or var_554_2 * (utf8.len(var_554_3) / 23)) > 0 and var_554_2 < var_554_5 then
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

		arg_551_1.nodeConfigList_ = {}

		arg_551_1:InitPlayNodeList()
	end,
	Play1108411133 = function(arg_555_0, arg_555_1)
		arg_555_1.time_ = 0
		arg_555_1.frameCnt_ = 0
		arg_555_1.state_ = "playing"
		arg_555_1.curTalkId_ = 1108411133
		arg_555_1.duration_ = 6.2

		local var_555_0 = {
			zh = 5.366,
			ja = 6.2
		}
		local var_555_1 = manager.audio:GetLocalizationFlag()

		if var_555_0[var_555_1] ~= nil then
			arg_555_1.duration_ = var_555_0[var_555_1]
		end

		SetActive(arg_555_1.tipsGo_, false)

		function arg_555_1.onSingleLineFinish_()
			arg_555_1.onSingleLineUpdate_ = nil
			arg_555_1.onSingleLineFinish_ = nil
			arg_555_1.state_ = "waiting"
		end

		function arg_555_1.playNext_(arg_557_0)
			if arg_557_0 == 1 then
				arg_555_0:Play1108411134(arg_555_1)
			end
		end

		function arg_555_1.onSingleLineUpdate_(arg_558_0)
			if 0 < arg_555_1.time_ and arg_555_1.time_ <= 0 + arg_558_0 and not isNil(arg_555_1.actors_["10102ui_story"]) and arg_555_1.var_.characterEffect10102ui_story == nil then
				arg_555_1.var_.characterEffect10102ui_story = arg_555_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_558_0 = 0.200000002980232

			if 0 <= arg_555_1.time_ and arg_555_1.time_ < 0 + var_558_0 and not isNil(arg_555_1.actors_["10102ui_story"]) then
				if arg_555_1.var_.characterEffect10102ui_story and not isNil(arg_555_1.actors_["10102ui_story"]) then
					arg_555_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_555_1.time_ >= 0 + var_558_0 and arg_555_1.time_ < 0 + var_558_0 + arg_558_0 and not isNil(arg_555_1.actors_["10102ui_story"]) and arg_555_1.var_.characterEffect10102ui_story then
				arg_555_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_555_1.time_ and arg_555_1.time_ <= 0 + arg_558_0 then
				arg_555_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action6_1")
			end

			local var_558_2 = 0
			local var_558_3 = 0.7

			if 0 < arg_555_1.time_ and arg_555_1.time_ <= var_558_2 + arg_558_0 then
				arg_555_1.talkMaxDuration = 0
				arg_555_1.dialogCg_.alpha = 1

				arg_555_1.dialog_:SetActive(true)
				SetActive(arg_555_1.leftNameGo_, true)

				arg_555_1.leftNameTxt_.text = arg_555_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_555_1.leftNameTxt_.transform)

				arg_555_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_555_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_555_1:RecordName(arg_555_1.leftNameTxt_.text)
				SetActive(arg_555_1.iconTrs_.gameObject, false)
				arg_555_1.callingController_:SetSelectedState("normal")

				local var_558_4 = arg_555_1:GetWordFromCfg(1108411133)
				local var_558_5 = arg_555_1:FormatText(var_558_4.content)

				arg_555_1.text_.text = var_558_5

				LuaForUtil.ClearLinePrefixSymbol(arg_555_1.text_)

				local var_558_7 = 28 <= 0 and var_558_3 or var_558_3 * (utf8.len(var_558_5) / 28)

				if (28 <= 0 and var_558_3 or var_558_3 * (utf8.len(var_558_5) / 28)) > 0 and var_558_3 < var_558_7 then
					arg_555_1.talkMaxDuration = var_558_7

					if var_558_7 + var_558_2 > arg_555_1.duration_ then
						arg_555_1.duration_ = var_558_7 + var_558_2
					end
				end

				arg_555_1.text_.text = var_558_5
				arg_555_1.typewritter.percent = 0

				arg_555_1.typewritter:SetDirty()
				arg_555_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411133", "story_v_side_new_1108411.awb") ~= 0 then
					local var_558_8 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411133", "story_v_side_new_1108411.awb") / 1000

					if var_558_8 + var_558_2 > arg_555_1.duration_ then
						arg_555_1.duration_ = var_558_8 + var_558_2
					end

					if var_558_4.prefab_name ~= "" and arg_555_1.actors_[var_558_4.prefab_name] ~= nil then
						local var_558_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_555_1.actors_[var_558_4.prefab_name].transform, "story_v_side_new_1108411", "1108411133", "story_v_side_new_1108411.awb")

						arg_555_1:RecordAudio("1108411133", var_558_9)
						arg_555_1:RecordAudio("1108411133", var_558_9)
					else
						arg_555_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411133", "story_v_side_new_1108411.awb")
					end

					arg_555_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411133", "story_v_side_new_1108411.awb")
				end

				arg_555_1:RecordContent(arg_555_1.text_.text)
			end

			local var_558_10 = math.max(var_558_3, arg_555_1.talkMaxDuration)

			if var_558_2 <= arg_555_1.time_ and arg_555_1.time_ < var_558_2 + var_558_10 then
				arg_555_1.typewritter.percent = (arg_555_1.time_ - var_558_2) / var_558_10

				arg_555_1.typewritter:SetDirty()
			end

			if arg_555_1.time_ >= var_558_2 + var_558_10 and arg_555_1.time_ < var_558_2 + var_558_10 + arg_558_0 then
				arg_555_1.typewritter.percent = 1

				arg_555_1.typewritter:SetDirty()
				arg_555_1:ShowNextGo(true)
			end
		end

		arg_555_1.nodeConfigList_ = {}

		arg_555_1:InitPlayNodeList()
	end,
	Play1108411134 = function(arg_559_0, arg_559_1)
		arg_559_1.time_ = 0
		arg_559_1.frameCnt_ = 0
		arg_559_1.state_ = "playing"
		arg_559_1.curTalkId_ = 1108411134
		arg_559_1.duration_ = 5

		SetActive(arg_559_1.tipsGo_, false)

		function arg_559_1.onSingleLineFinish_()
			arg_559_1.onSingleLineUpdate_ = nil
			arg_559_1.onSingleLineFinish_ = nil
			arg_559_1.state_ = "waiting"
		end

		function arg_559_1.playNext_(arg_561_0)
			if arg_561_0 == 1 then
				arg_559_0:Play1108411135(arg_559_1)
			end
		end

		function arg_559_1.onSingleLineUpdate_(arg_562_0)
			if 0 < arg_559_1.time_ and arg_559_1.time_ <= 0 + arg_562_0 and not isNil(arg_559_1.actors_["10102ui_story"]) and arg_559_1.var_.characterEffect10102ui_story == nil then
				arg_559_1.var_.characterEffect10102ui_story = arg_559_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_562_0 = 0.200000002980232

			if 0 <= arg_559_1.time_ and arg_559_1.time_ < 0 + var_562_0 and not isNil(arg_559_1.actors_["10102ui_story"]) then
				if arg_559_1.var_.characterEffect10102ui_story and not isNil(arg_559_1.actors_["10102ui_story"]) then
					arg_559_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_559_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_559_1.time_ - 0) / var_562_0)
				end
			end

			if arg_559_1.time_ >= 0 + var_562_0 and arg_559_1.time_ < 0 + var_562_0 + arg_562_0 and not isNil(arg_559_1.actors_["10102ui_story"]) and arg_559_1.var_.characterEffect10102ui_story then
				arg_559_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_559_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_562_1 = 0
			local var_562_2 = 0.075

			if 0 < arg_559_1.time_ and arg_559_1.time_ <= var_562_1 + arg_562_0 then
				arg_559_1.talkMaxDuration = 0
				arg_559_1.dialogCg_.alpha = 1

				arg_559_1.dialog_:SetActive(true)
				SetActive(arg_559_1.leftNameGo_, true)

				arg_559_1.leftNameTxt_.text = arg_559_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_559_1.leftNameTxt_.transform)

				arg_559_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_559_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_559_1:RecordName(arg_559_1.leftNameTxt_.text)
				SetActive(arg_559_1.iconTrs_.gameObject, true)
				arg_559_1.iconController_:SetSelectedState("hero")

				arg_559_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_559_1.callingController_:SetSelectedState("normal")

				arg_559_1.keyicon_.color = Color.New(1, 1, 1)
				arg_559_1.icon_.color = Color.New(1, 1, 1)

				local var_562_3 = arg_559_1:FormatText(arg_559_1:GetWordFromCfg(1108411134).content)

				arg_559_1.text_.text = var_562_3

				LuaForUtil.ClearLinePrefixSymbol(arg_559_1.text_)

				local var_562_5 = 3 <= 0 and var_562_2 or var_562_2 * (utf8.len(var_562_3) / 3)

				if (3 <= 0 and var_562_2 or var_562_2 * (utf8.len(var_562_3) / 3)) > 0 and var_562_2 < var_562_5 then
					arg_559_1.talkMaxDuration = var_562_5

					if var_562_5 + var_562_1 > arg_559_1.duration_ then
						arg_559_1.duration_ = var_562_5 + var_562_1
					end
				end

				arg_559_1.text_.text = var_562_3
				arg_559_1.typewritter.percent = 0

				arg_559_1.typewritter:SetDirty()
				arg_559_1:ShowNextGo(false)
				arg_559_1:RecordContent(arg_559_1.text_.text)
			end

			local var_562_6 = math.max(var_562_2, arg_559_1.talkMaxDuration)

			if var_562_1 <= arg_559_1.time_ and arg_559_1.time_ < var_562_1 + var_562_6 then
				arg_559_1.typewritter.percent = (arg_559_1.time_ - var_562_1) / var_562_6

				arg_559_1.typewritter:SetDirty()
			end

			if arg_559_1.time_ >= var_562_1 + var_562_6 and arg_559_1.time_ < var_562_1 + var_562_6 + arg_562_0 then
				arg_559_1.typewritter.percent = 1

				arg_559_1.typewritter:SetDirty()
				arg_559_1:ShowNextGo(true)
			end
		end

		arg_559_1.nodeConfigList_ = {}

		arg_559_1:InitPlayNodeList()
	end,
	Play1108411135 = function(arg_563_0, arg_563_1)
		arg_563_1.time_ = 0
		arg_563_1.frameCnt_ = 0
		arg_563_1.state_ = "playing"
		arg_563_1.curTalkId_ = 1108411135
		arg_563_1.duration_ = 10.07

		local var_563_0 = {
			zh = 7.9,
			ja = 10.066
		}
		local var_563_1 = manager.audio:GetLocalizationFlag()

		if var_563_0[var_563_1] ~= nil then
			arg_563_1.duration_ = var_563_0[var_563_1]
		end

		SetActive(arg_563_1.tipsGo_, false)

		function arg_563_1.onSingleLineFinish_()
			arg_563_1.onSingleLineUpdate_ = nil
			arg_563_1.onSingleLineFinish_ = nil
			arg_563_1.state_ = "waiting"
		end

		function arg_563_1.playNext_(arg_565_0)
			if arg_565_0 == 1 then
				arg_563_0:Play1108411136(arg_563_1)
			end
		end

		function arg_563_1.onSingleLineUpdate_(arg_566_0)
			if 0 < arg_563_1.time_ and arg_563_1.time_ <= 0 + arg_566_0 and not isNil(arg_563_1.actors_["10102ui_story"]) and arg_563_1.var_.characterEffect10102ui_story == nil then
				arg_563_1.var_.characterEffect10102ui_story = arg_563_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_566_0 = 0.200000002980232

			if 0 <= arg_563_1.time_ and arg_563_1.time_ < 0 + var_566_0 and not isNil(arg_563_1.actors_["10102ui_story"]) then
				if arg_563_1.var_.characterEffect10102ui_story and not isNil(arg_563_1.actors_["10102ui_story"]) then
					arg_563_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_563_1.time_ >= 0 + var_566_0 and arg_563_1.time_ < 0 + var_566_0 + arg_566_0 and not isNil(arg_563_1.actors_["10102ui_story"]) and arg_563_1.var_.characterEffect10102ui_story then
				arg_563_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_566_2 = 0
			local var_566_3 = 0.925

			if 0 < arg_563_1.time_ and arg_563_1.time_ <= var_566_2 + arg_566_0 then
				arg_563_1.talkMaxDuration = 0
				arg_563_1.dialogCg_.alpha = 1

				arg_563_1.dialog_:SetActive(true)
				SetActive(arg_563_1.leftNameGo_, true)

				arg_563_1.leftNameTxt_.text = arg_563_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_563_1.leftNameTxt_.transform)

				arg_563_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_563_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_563_1:RecordName(arg_563_1.leftNameTxt_.text)
				SetActive(arg_563_1.iconTrs_.gameObject, false)
				arg_563_1.callingController_:SetSelectedState("normal")

				local var_566_4 = arg_563_1:GetWordFromCfg(1108411135)
				local var_566_5 = arg_563_1:FormatText(var_566_4.content)

				arg_563_1.text_.text = var_566_5

				LuaForUtil.ClearLinePrefixSymbol(arg_563_1.text_)

				local var_566_7 = 37 <= 0 and var_566_3 or var_566_3 * (utf8.len(var_566_5) / 37)

				if (37 <= 0 and var_566_3 or var_566_3 * (utf8.len(var_566_5) / 37)) > 0 and var_566_3 < var_566_7 then
					arg_563_1.talkMaxDuration = var_566_7

					if var_566_7 + var_566_2 > arg_563_1.duration_ then
						arg_563_1.duration_ = var_566_7 + var_566_2
					end
				end

				arg_563_1.text_.text = var_566_5
				arg_563_1.typewritter.percent = 0

				arg_563_1.typewritter:SetDirty()
				arg_563_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411135", "story_v_side_new_1108411.awb") ~= 0 then
					local var_566_8 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411135", "story_v_side_new_1108411.awb") / 1000

					if var_566_8 + var_566_2 > arg_563_1.duration_ then
						arg_563_1.duration_ = var_566_8 + var_566_2
					end

					if var_566_4.prefab_name ~= "" and arg_563_1.actors_[var_566_4.prefab_name] ~= nil then
						local var_566_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_563_1.actors_[var_566_4.prefab_name].transform, "story_v_side_new_1108411", "1108411135", "story_v_side_new_1108411.awb")

						arg_563_1:RecordAudio("1108411135", var_566_9)
						arg_563_1:RecordAudio("1108411135", var_566_9)
					else
						arg_563_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411135", "story_v_side_new_1108411.awb")
					end

					arg_563_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411135", "story_v_side_new_1108411.awb")
				end

				arg_563_1:RecordContent(arg_563_1.text_.text)
			end

			local var_566_10 = math.max(var_566_3, arg_563_1.talkMaxDuration)

			if var_566_2 <= arg_563_1.time_ and arg_563_1.time_ < var_566_2 + var_566_10 then
				arg_563_1.typewritter.percent = (arg_563_1.time_ - var_566_2) / var_566_10

				arg_563_1.typewritter:SetDirty()
			end

			if arg_563_1.time_ >= var_566_2 + var_566_10 and arg_563_1.time_ < var_566_2 + var_566_10 + arg_566_0 then
				arg_563_1.typewritter.percent = 1

				arg_563_1.typewritter:SetDirty()
				arg_563_1:ShowNextGo(true)
			end
		end

		arg_563_1.nodeConfigList_ = {}

		arg_563_1:InitPlayNodeList()
	end,
	Play1108411136 = function(arg_567_0, arg_567_1)
		arg_567_1.time_ = 0
		arg_567_1.frameCnt_ = 0
		arg_567_1.state_ = "playing"
		arg_567_1.curTalkId_ = 1108411136
		arg_567_1.duration_ = 5

		SetActive(arg_567_1.tipsGo_, false)

		function arg_567_1.onSingleLineFinish_()
			arg_567_1.onSingleLineUpdate_ = nil
			arg_567_1.onSingleLineFinish_ = nil
			arg_567_1.state_ = "waiting"
		end

		function arg_567_1.playNext_(arg_569_0)
			if arg_569_0 == 1 then
				arg_567_0:Play1108411137(arg_567_1)
			end
		end

		function arg_567_1.onSingleLineUpdate_(arg_570_0)
			if 0 < arg_567_1.time_ and arg_567_1.time_ <= 0 + arg_570_0 and not isNil(arg_567_1.actors_["10102ui_story"]) and arg_567_1.var_.characterEffect10102ui_story == nil then
				arg_567_1.var_.characterEffect10102ui_story = arg_567_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_570_0 = 0.200000002980232

			if 0 <= arg_567_1.time_ and arg_567_1.time_ < 0 + var_570_0 and not isNil(arg_567_1.actors_["10102ui_story"]) then
				if arg_567_1.var_.characterEffect10102ui_story and not isNil(arg_567_1.actors_["10102ui_story"]) then
					arg_567_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_567_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_567_1.time_ - 0) / var_570_0)
				end
			end

			if arg_567_1.time_ >= 0 + var_570_0 and arg_567_1.time_ < 0 + var_570_0 + arg_570_0 and not isNil(arg_567_1.actors_["10102ui_story"]) and arg_567_1.var_.characterEffect10102ui_story then
				arg_567_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_567_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_570_1 = 0
			local var_570_2 = 0.4

			if 0 < arg_567_1.time_ and arg_567_1.time_ <= var_570_1 + arg_570_0 then
				arg_567_1.talkMaxDuration = 0
				arg_567_1.dialogCg_.alpha = 1

				arg_567_1.dialog_:SetActive(true)
				SetActive(arg_567_1.leftNameGo_, true)

				arg_567_1.leftNameTxt_.text = arg_567_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_567_1.leftNameTxt_.transform)

				arg_567_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_567_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_567_1:RecordName(arg_567_1.leftNameTxt_.text)
				SetActive(arg_567_1.iconTrs_.gameObject, true)
				arg_567_1.iconController_:SetSelectedState("hero")

				arg_567_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_567_1.callingController_:SetSelectedState("normal")

				arg_567_1.keyicon_.color = Color.New(1, 1, 1)
				arg_567_1.icon_.color = Color.New(1, 1, 1)

				local var_570_3 = arg_567_1:FormatText(arg_567_1:GetWordFromCfg(1108411136).content)

				arg_567_1.text_.text = var_570_3

				LuaForUtil.ClearLinePrefixSymbol(arg_567_1.text_)

				local var_570_5 = 16 <= 0 and var_570_2 or var_570_2 * (utf8.len(var_570_3) / 16)

				if (16 <= 0 and var_570_2 or var_570_2 * (utf8.len(var_570_3) / 16)) > 0 and var_570_2 < var_570_5 then
					arg_567_1.talkMaxDuration = var_570_5

					if var_570_5 + var_570_1 > arg_567_1.duration_ then
						arg_567_1.duration_ = var_570_5 + var_570_1
					end
				end

				arg_567_1.text_.text = var_570_3
				arg_567_1.typewritter.percent = 0

				arg_567_1.typewritter:SetDirty()
				arg_567_1:ShowNextGo(false)
				arg_567_1:RecordContent(arg_567_1.text_.text)
			end

			local var_570_6 = math.max(var_570_2, arg_567_1.talkMaxDuration)

			if var_570_1 <= arg_567_1.time_ and arg_567_1.time_ < var_570_1 + var_570_6 then
				arg_567_1.typewritter.percent = (arg_567_1.time_ - var_570_1) / var_570_6

				arg_567_1.typewritter:SetDirty()
			end

			if arg_567_1.time_ >= var_570_1 + var_570_6 and arg_567_1.time_ < var_570_1 + var_570_6 + arg_570_0 then
				arg_567_1.typewritter.percent = 1

				arg_567_1.typewritter:SetDirty()
				arg_567_1:ShowNextGo(true)
			end
		end

		arg_567_1.nodeConfigList_ = {}

		arg_567_1:InitPlayNodeList()
	end,
	Play1108411137 = function(arg_571_0, arg_571_1)
		arg_571_1.time_ = 0
		arg_571_1.frameCnt_ = 0
		arg_571_1.state_ = "playing"
		arg_571_1.curTalkId_ = 1108411137
		arg_571_1.duration_ = 5

		SetActive(arg_571_1.tipsGo_, false)

		function arg_571_1.onSingleLineFinish_()
			arg_571_1.onSingleLineUpdate_ = nil
			arg_571_1.onSingleLineFinish_ = nil
			arg_571_1.state_ = "waiting"
		end

		function arg_571_1.playNext_(arg_573_0)
			if arg_573_0 == 1 then
				arg_571_0:Play1108411138(arg_571_1)
			end
		end

		function arg_571_1.onSingleLineUpdate_(arg_574_0)
			local var_574_0 = 0.95

			if 0 < arg_571_1.time_ and arg_571_1.time_ <= 0 + arg_574_0 then
				arg_571_1.talkMaxDuration = 0
				arg_571_1.dialogCg_.alpha = 1

				arg_571_1.dialog_:SetActive(true)
				SetActive(arg_571_1.leftNameGo_, true)

				arg_571_1.leftNameTxt_.text = arg_571_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_571_1.leftNameTxt_.transform)

				arg_571_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_571_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_571_1:RecordName(arg_571_1.leftNameTxt_.text)
				SetActive(arg_571_1.iconTrs_.gameObject, true)
				arg_571_1.iconController_:SetSelectedState("hero")

				arg_571_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_571_1.callingController_:SetSelectedState("normal")

				arg_571_1.keyicon_.color = Color.New(1, 1, 1)
				arg_571_1.icon_.color = Color.New(1, 1, 1)

				local var_574_1 = arg_571_1:FormatText(arg_571_1:GetWordFromCfg(1108411137).content)

				arg_571_1.text_.text = var_574_1

				LuaForUtil.ClearLinePrefixSymbol(arg_571_1.text_)

				local var_574_3 = 38 <= 0 and var_574_0 or var_574_0 * (utf8.len(var_574_1) / 38)

				if (38 <= 0 and var_574_0 or var_574_0 * (utf8.len(var_574_1) / 38)) > 0 and var_574_0 < var_574_3 then
					arg_571_1.talkMaxDuration = var_574_3

					if var_574_3 + 0 > arg_571_1.duration_ then
						arg_571_1.duration_ = var_574_3 + 0
					end
				end

				arg_571_1.text_.text = var_574_1
				arg_571_1.typewritter.percent = 0

				arg_571_1.typewritter:SetDirty()
				arg_571_1:ShowNextGo(false)
				arg_571_1:RecordContent(arg_571_1.text_.text)
			end

			local var_574_4 = math.max(var_574_0, arg_571_1.talkMaxDuration)

			if 0 <= arg_571_1.time_ and arg_571_1.time_ < 0 + var_574_4 then
				arg_571_1.typewritter.percent = (arg_571_1.time_ - 0) / var_574_4

				arg_571_1.typewritter:SetDirty()
			end

			if arg_571_1.time_ >= 0 + var_574_4 and arg_571_1.time_ < 0 + var_574_4 + arg_574_0 then
				arg_571_1.typewritter.percent = 1

				arg_571_1.typewritter:SetDirty()
				arg_571_1:ShowNextGo(true)
			end
		end

		arg_571_1.nodeConfigList_ = {}

		arg_571_1:InitPlayNodeList()
	end,
	Play1108411138 = function(arg_575_0, arg_575_1)
		arg_575_1.time_ = 0
		arg_575_1.frameCnt_ = 0
		arg_575_1.state_ = "playing"
		arg_575_1.curTalkId_ = 1108411138
		arg_575_1.duration_ = 5

		SetActive(arg_575_1.tipsGo_, false)

		function arg_575_1.onSingleLineFinish_()
			arg_575_1.onSingleLineUpdate_ = nil
			arg_575_1.onSingleLineFinish_ = nil
			arg_575_1.state_ = "waiting"
		end

		function arg_575_1.playNext_(arg_577_0)
			if arg_577_0 == 1 then
				arg_575_0:Play1108411139(arg_575_1)
			end
		end

		function arg_575_1.onSingleLineUpdate_(arg_578_0)
			local var_578_0 = 0.35

			if 0 < arg_575_1.time_ and arg_575_1.time_ <= 0 + arg_578_0 then
				arg_575_1.talkMaxDuration = 0
				arg_575_1.dialogCg_.alpha = 1

				arg_575_1.dialog_:SetActive(true)
				SetActive(arg_575_1.leftNameGo_, true)

				arg_575_1.leftNameTxt_.text = arg_575_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_575_1.leftNameTxt_.transform)

				arg_575_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_575_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_575_1:RecordName(arg_575_1.leftNameTxt_.text)
				SetActive(arg_575_1.iconTrs_.gameObject, true)
				arg_575_1.iconController_:SetSelectedState("hero")

				arg_575_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_575_1.callingController_:SetSelectedState("normal")

				arg_575_1.keyicon_.color = Color.New(1, 1, 1)
				arg_575_1.icon_.color = Color.New(1, 1, 1)

				local var_578_1 = arg_575_1:FormatText(arg_575_1:GetWordFromCfg(1108411138).content)

				arg_575_1.text_.text = var_578_1

				LuaForUtil.ClearLinePrefixSymbol(arg_575_1.text_)

				local var_578_3 = 14 <= 0 and var_578_0 or var_578_0 * (utf8.len(var_578_1) / 14)

				if (14 <= 0 and var_578_0 or var_578_0 * (utf8.len(var_578_1) / 14)) > 0 and var_578_0 < var_578_3 then
					arg_575_1.talkMaxDuration = var_578_3

					if var_578_3 + 0 > arg_575_1.duration_ then
						arg_575_1.duration_ = var_578_3 + 0
					end
				end

				arg_575_1.text_.text = var_578_1
				arg_575_1.typewritter.percent = 0

				arg_575_1.typewritter:SetDirty()
				arg_575_1:ShowNextGo(false)
				arg_575_1:RecordContent(arg_575_1.text_.text)
			end

			local var_578_4 = math.max(var_578_0, arg_575_1.talkMaxDuration)

			if 0 <= arg_575_1.time_ and arg_575_1.time_ < 0 + var_578_4 then
				arg_575_1.typewritter.percent = (arg_575_1.time_ - 0) / var_578_4

				arg_575_1.typewritter:SetDirty()
			end

			if arg_575_1.time_ >= 0 + var_578_4 and arg_575_1.time_ < 0 + var_578_4 + arg_578_0 then
				arg_575_1.typewritter.percent = 1

				arg_575_1.typewritter:SetDirty()
				arg_575_1:ShowNextGo(true)
			end
		end

		arg_575_1.nodeConfigList_ = {}

		arg_575_1:InitPlayNodeList()
	end,
	Play1108411139 = function(arg_579_0, arg_579_1)
		arg_579_1.time_ = 0
		arg_579_1.frameCnt_ = 0
		arg_579_1.state_ = "playing"
		arg_579_1.curTalkId_ = 1108411139
		arg_579_1.duration_ = 5.8

		local var_579_0 = {
			zh = 4.2,
			ja = 5.8
		}
		local var_579_1 = manager.audio:GetLocalizationFlag()

		if var_579_0[var_579_1] ~= nil then
			arg_579_1.duration_ = var_579_0[var_579_1]
		end

		SetActive(arg_579_1.tipsGo_, false)

		function arg_579_1.onSingleLineFinish_()
			arg_579_1.onSingleLineUpdate_ = nil
			arg_579_1.onSingleLineFinish_ = nil
			arg_579_1.state_ = "waiting"
		end

		function arg_579_1.playNext_(arg_581_0)
			if arg_581_0 == 1 then
				arg_579_0:Play1108411140(arg_579_1)
			end
		end

		function arg_579_1.onSingleLineUpdate_(arg_582_0)
			if 0 < arg_579_1.time_ and arg_579_1.time_ <= 0 + arg_582_0 and not isNil(arg_579_1.actors_["10102ui_story"]) and arg_579_1.var_.characterEffect10102ui_story == nil then
				arg_579_1.var_.characterEffect10102ui_story = arg_579_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_582_0 = 0.200000002980232

			if 0 <= arg_579_1.time_ and arg_579_1.time_ < 0 + var_582_0 and not isNil(arg_579_1.actors_["10102ui_story"]) then
				if arg_579_1.var_.characterEffect10102ui_story and not isNil(arg_579_1.actors_["10102ui_story"]) then
					arg_579_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_579_1.time_ >= 0 + var_582_0 and arg_579_1.time_ < 0 + var_582_0 + arg_582_0 and not isNil(arg_579_1.actors_["10102ui_story"]) and arg_579_1.var_.characterEffect10102ui_story then
				arg_579_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_579_1.time_ and arg_579_1.time_ <= 0 + arg_582_0 then
				arg_579_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102actionlink/10102action462")
			end

			if 0 < arg_579_1.time_ and arg_579_1.time_ <= 0 + arg_582_0 then
				arg_579_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileC_biyan", "EmotionTimelineAnimator")
			end

			local var_582_2 = 0
			local var_582_3 = 0.45

			if 0 < arg_579_1.time_ and arg_579_1.time_ <= var_582_2 + arg_582_0 then
				arg_579_1.talkMaxDuration = 0
				arg_579_1.dialogCg_.alpha = 1

				arg_579_1.dialog_:SetActive(true)
				SetActive(arg_579_1.leftNameGo_, true)

				arg_579_1.leftNameTxt_.text = arg_579_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_579_1.leftNameTxt_.transform)

				arg_579_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_579_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_579_1:RecordName(arg_579_1.leftNameTxt_.text)
				SetActive(arg_579_1.iconTrs_.gameObject, false)
				arg_579_1.callingController_:SetSelectedState("normal")

				local var_582_4 = arg_579_1:GetWordFromCfg(1108411139)
				local var_582_5 = arg_579_1:FormatText(var_582_4.content)

				arg_579_1.text_.text = var_582_5

				LuaForUtil.ClearLinePrefixSymbol(arg_579_1.text_)

				local var_582_7 = 18 <= 0 and var_582_3 or var_582_3 * (utf8.len(var_582_5) / 18)

				if (18 <= 0 and var_582_3 or var_582_3 * (utf8.len(var_582_5) / 18)) > 0 and var_582_3 < var_582_7 then
					arg_579_1.talkMaxDuration = var_582_7

					if var_582_7 + var_582_2 > arg_579_1.duration_ then
						arg_579_1.duration_ = var_582_7 + var_582_2
					end
				end

				arg_579_1.text_.text = var_582_5
				arg_579_1.typewritter.percent = 0

				arg_579_1.typewritter:SetDirty()
				arg_579_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411139", "story_v_side_new_1108411.awb") ~= 0 then
					local var_582_8 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411139", "story_v_side_new_1108411.awb") / 1000

					if var_582_8 + var_582_2 > arg_579_1.duration_ then
						arg_579_1.duration_ = var_582_8 + var_582_2
					end

					if var_582_4.prefab_name ~= "" and arg_579_1.actors_[var_582_4.prefab_name] ~= nil then
						local var_582_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_579_1.actors_[var_582_4.prefab_name].transform, "story_v_side_new_1108411", "1108411139", "story_v_side_new_1108411.awb")

						arg_579_1:RecordAudio("1108411139", var_582_9)
						arg_579_1:RecordAudio("1108411139", var_582_9)
					else
						arg_579_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411139", "story_v_side_new_1108411.awb")
					end

					arg_579_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411139", "story_v_side_new_1108411.awb")
				end

				arg_579_1:RecordContent(arg_579_1.text_.text)
			end

			local var_582_10 = math.max(var_582_3, arg_579_1.talkMaxDuration)

			if var_582_2 <= arg_579_1.time_ and arg_579_1.time_ < var_582_2 + var_582_10 then
				arg_579_1.typewritter.percent = (arg_579_1.time_ - var_582_2) / var_582_10

				arg_579_1.typewritter:SetDirty()
			end

			if arg_579_1.time_ >= var_582_2 + var_582_10 and arg_579_1.time_ < var_582_2 + var_582_10 + arg_582_0 then
				arg_579_1.typewritter.percent = 1

				arg_579_1.typewritter:SetDirty()
				arg_579_1:ShowNextGo(true)
			end
		end

		arg_579_1.nodeConfigList_ = {}

		arg_579_1:InitPlayNodeList()
	end,
	Play1108411140 = function(arg_583_0, arg_583_1)
		arg_583_1.time_ = 0
		arg_583_1.frameCnt_ = 0
		arg_583_1.state_ = "playing"
		arg_583_1.curTalkId_ = 1108411140
		arg_583_1.duration_ = 5

		SetActive(arg_583_1.tipsGo_, false)

		function arg_583_1.onSingleLineFinish_()
			arg_583_1.onSingleLineUpdate_ = nil
			arg_583_1.onSingleLineFinish_ = nil
			arg_583_1.state_ = "waiting"
		end

		function arg_583_1.playNext_(arg_585_0)
			if arg_585_0 == 1 then
				arg_583_0:Play1108411141(arg_583_1)
			end
		end

		function arg_583_1.onSingleLineUpdate_(arg_586_0)
			if 0 < arg_583_1.time_ and arg_583_1.time_ <= 0 + arg_586_0 and not isNil(arg_583_1.actors_["10102ui_story"]) and arg_583_1.var_.characterEffect10102ui_story == nil then
				arg_583_1.var_.characterEffect10102ui_story = arg_583_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_586_0 = 0.200000002980232

			if 0 <= arg_583_1.time_ and arg_583_1.time_ < 0 + var_586_0 and not isNil(arg_583_1.actors_["10102ui_story"]) then
				if arg_583_1.var_.characterEffect10102ui_story and not isNil(arg_583_1.actors_["10102ui_story"]) then
					arg_583_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_583_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_583_1.time_ - 0) / var_586_0)
				end
			end

			if arg_583_1.time_ >= 0 + var_586_0 and arg_583_1.time_ < 0 + var_586_0 + arg_586_0 and not isNil(arg_583_1.actors_["10102ui_story"]) and arg_583_1.var_.characterEffect10102ui_story then
				arg_583_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_583_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_586_1 = 0
			local var_586_2 = 0.475

			if 0 < arg_583_1.time_ and arg_583_1.time_ <= var_586_1 + arg_586_0 then
				arg_583_1.talkMaxDuration = 0
				arg_583_1.dialogCg_.alpha = 1

				arg_583_1.dialog_:SetActive(true)
				SetActive(arg_583_1.leftNameGo_, true)

				arg_583_1.leftNameTxt_.text = arg_583_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_583_1.leftNameTxt_.transform)

				arg_583_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_583_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_583_1:RecordName(arg_583_1.leftNameTxt_.text)
				SetActive(arg_583_1.iconTrs_.gameObject, true)
				arg_583_1.iconController_:SetSelectedState("hero")

				arg_583_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_583_1.callingController_:SetSelectedState("normal")

				arg_583_1.keyicon_.color = Color.New(1, 1, 1)
				arg_583_1.icon_.color = Color.New(1, 1, 1)

				local var_586_3 = arg_583_1:FormatText(arg_583_1:GetWordFromCfg(1108411140).content)

				arg_583_1.text_.text = var_586_3

				LuaForUtil.ClearLinePrefixSymbol(arg_583_1.text_)

				local var_586_5 = 19 <= 0 and var_586_2 or var_586_2 * (utf8.len(var_586_3) / 19)

				if (19 <= 0 and var_586_2 or var_586_2 * (utf8.len(var_586_3) / 19)) > 0 and var_586_2 < var_586_5 then
					arg_583_1.talkMaxDuration = var_586_5

					if var_586_5 + var_586_1 > arg_583_1.duration_ then
						arg_583_1.duration_ = var_586_5 + var_586_1
					end
				end

				arg_583_1.text_.text = var_586_3
				arg_583_1.typewritter.percent = 0

				arg_583_1.typewritter:SetDirty()
				arg_583_1:ShowNextGo(false)
				arg_583_1:RecordContent(arg_583_1.text_.text)
			end

			local var_586_6 = math.max(var_586_2, arg_583_1.talkMaxDuration)

			if var_586_1 <= arg_583_1.time_ and arg_583_1.time_ < var_586_1 + var_586_6 then
				arg_583_1.typewritter.percent = (arg_583_1.time_ - var_586_1) / var_586_6

				arg_583_1.typewritter:SetDirty()
			end

			if arg_583_1.time_ >= var_586_1 + var_586_6 and arg_583_1.time_ < var_586_1 + var_586_6 + arg_586_0 then
				arg_583_1.typewritter.percent = 1

				arg_583_1.typewritter:SetDirty()
				arg_583_1:ShowNextGo(true)
			end
		end

		arg_583_1.nodeConfigList_ = {}

		arg_583_1:InitPlayNodeList()
	end,
	Play1108411141 = function(arg_587_0, arg_587_1)
		arg_587_1.time_ = 0
		arg_587_1.frameCnt_ = 0
		arg_587_1.state_ = "playing"
		arg_587_1.curTalkId_ = 1108411141
		arg_587_1.duration_ = 5

		SetActive(arg_587_1.tipsGo_, false)

		function arg_587_1.onSingleLineFinish_()
			arg_587_1.onSingleLineUpdate_ = nil
			arg_587_1.onSingleLineFinish_ = nil
			arg_587_1.state_ = "waiting"
		end

		function arg_587_1.playNext_(arg_589_0)
			if arg_589_0 == 1 then
				arg_587_0:Play1108411142(arg_587_1)
			end
		end

		function arg_587_1.onSingleLineUpdate_(arg_590_0)
			if 0 < arg_587_1.time_ and arg_587_1.time_ <= 0 + arg_590_0 then
				arg_587_1.var_.moveOldPos10102ui_story = arg_587_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_590_0 = 0.001

			if 0 <= arg_587_1.time_ and arg_587_1.time_ < 0 + var_590_0 then
				arg_587_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_587_1.var_.moveOldPos10102ui_story, Vector3.New(0, 100, 0), (arg_587_1.time_ - 0) / var_590_0)
				arg_587_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_587_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_587_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_587_1.actors_["10102ui_story"].transform.position).z)
				arg_587_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_587_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_587_1.actors_["10102ui_story"].transform.localEulerAngles = arg_587_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_587_1.time_ >= 0 + var_590_0 and arg_587_1.time_ < 0 + var_590_0 + arg_590_0 then
				arg_587_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_587_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_587_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_587_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_587_1.actors_["10102ui_story"].transform.position).z)
				arg_587_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_587_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_587_1.actors_["10102ui_story"].transform.localEulerAngles = arg_587_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_590_1 = 0
			local var_590_2 = 1.2

			if 0 < arg_587_1.time_ and arg_587_1.time_ <= var_590_1 + arg_590_0 then
				arg_587_1.talkMaxDuration = 0
				arg_587_1.dialogCg_.alpha = 1

				arg_587_1.dialog_:SetActive(true)
				SetActive(arg_587_1.leftNameGo_, true)

				arg_587_1.leftNameTxt_.text = arg_587_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_587_1.leftNameTxt_.transform)

				arg_587_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_587_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_587_1:RecordName(arg_587_1.leftNameTxt_.text)
				SetActive(arg_587_1.iconTrs_.gameObject, true)
				arg_587_1.iconController_:SetSelectedState("hero")

				arg_587_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_587_1.callingController_:SetSelectedState("normal")

				arg_587_1.keyicon_.color = Color.New(1, 1, 1)
				arg_587_1.icon_.color = Color.New(1, 1, 1)

				local var_590_3 = arg_587_1:FormatText(arg_587_1:GetWordFromCfg(1108411141).content)

				arg_587_1.text_.text = var_590_3

				LuaForUtil.ClearLinePrefixSymbol(arg_587_1.text_)

				local var_590_5 = 48 <= 0 and var_590_2 or var_590_2 * (utf8.len(var_590_3) / 48)

				if (48 <= 0 and var_590_2 or var_590_2 * (utf8.len(var_590_3) / 48)) > 0 and var_590_2 < var_590_5 then
					arg_587_1.talkMaxDuration = var_590_5

					if var_590_5 + var_590_1 > arg_587_1.duration_ then
						arg_587_1.duration_ = var_590_5 + var_590_1
					end
				end

				arg_587_1.text_.text = var_590_3
				arg_587_1.typewritter.percent = 0

				arg_587_1.typewritter:SetDirty()
				arg_587_1:ShowNextGo(false)
				arg_587_1:RecordContent(arg_587_1.text_.text)
			end

			local var_590_6 = math.max(var_590_2, arg_587_1.talkMaxDuration)

			if var_590_1 <= arg_587_1.time_ and arg_587_1.time_ < var_590_1 + var_590_6 then
				arg_587_1.typewritter.percent = (arg_587_1.time_ - var_590_1) / var_590_6

				arg_587_1.typewritter:SetDirty()
			end

			if arg_587_1.time_ >= var_590_1 + var_590_6 and arg_587_1.time_ < var_590_1 + var_590_6 + arg_590_0 then
				arg_587_1.typewritter.percent = 1

				arg_587_1.typewritter:SetDirty()
				arg_587_1:ShowNextGo(true)
			end
		end

		arg_587_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_587_1:InitPlayNodeList()
	end,
	Play1108411142 = function(arg_591_0, arg_591_1)
		arg_591_1.time_ = 0
		arg_591_1.frameCnt_ = 0
		arg_591_1.state_ = "playing"
		arg_591_1.curTalkId_ = 1108411142
		arg_591_1.duration_ = 5

		SetActive(arg_591_1.tipsGo_, false)

		function arg_591_1.onSingleLineFinish_()
			arg_591_1.onSingleLineUpdate_ = nil
			arg_591_1.onSingleLineFinish_ = nil
			arg_591_1.state_ = "waiting"
		end

		function arg_591_1.playNext_(arg_593_0)
			if arg_593_0 == 1 then
				arg_591_0:Play1108411143(arg_591_1)
			end
		end

		function arg_591_1.onSingleLineUpdate_(arg_594_0)
			local var_594_0 = 1

			if 0 < arg_591_1.time_ and arg_591_1.time_ <= 0 + arg_594_0 then
				arg_591_1.talkMaxDuration = 0
				arg_591_1.dialogCg_.alpha = 1

				arg_591_1.dialog_:SetActive(true)
				SetActive(arg_591_1.leftNameGo_, true)

				arg_591_1.leftNameTxt_.text = arg_591_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_591_1.leftNameTxt_.transform)

				arg_591_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_591_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_591_1:RecordName(arg_591_1.leftNameTxt_.text)
				SetActive(arg_591_1.iconTrs_.gameObject, true)
				arg_591_1.iconController_:SetSelectedState("hero")

				arg_591_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_591_1.callingController_:SetSelectedState("normal")

				arg_591_1.keyicon_.color = Color.New(1, 1, 1)
				arg_591_1.icon_.color = Color.New(1, 1, 1)

				local var_594_1 = arg_591_1:FormatText(arg_591_1:GetWordFromCfg(1108411142).content)

				arg_591_1.text_.text = var_594_1

				LuaForUtil.ClearLinePrefixSymbol(arg_591_1.text_)

				local var_594_3 = 40 <= 0 and var_594_0 or var_594_0 * (utf8.len(var_594_1) / 40)

				if (40 <= 0 and var_594_0 or var_594_0 * (utf8.len(var_594_1) / 40)) > 0 and var_594_0 < var_594_3 then
					arg_591_1.talkMaxDuration = var_594_3

					if var_594_3 + 0 > arg_591_1.duration_ then
						arg_591_1.duration_ = var_594_3 + 0
					end
				end

				arg_591_1.text_.text = var_594_1
				arg_591_1.typewritter.percent = 0

				arg_591_1.typewritter:SetDirty()
				arg_591_1:ShowNextGo(false)
				arg_591_1:RecordContent(arg_591_1.text_.text)
			end

			local var_594_4 = math.max(var_594_0, arg_591_1.talkMaxDuration)

			if 0 <= arg_591_1.time_ and arg_591_1.time_ < 0 + var_594_4 then
				arg_591_1.typewritter.percent = (arg_591_1.time_ - 0) / var_594_4

				arg_591_1.typewritter:SetDirty()
			end

			if arg_591_1.time_ >= 0 + var_594_4 and arg_591_1.time_ < 0 + var_594_4 + arg_594_0 then
				arg_591_1.typewritter.percent = 1

				arg_591_1.typewritter:SetDirty()
				arg_591_1:ShowNextGo(true)
			end
		end

		arg_591_1.nodeConfigList_ = {}

		arg_591_1:InitPlayNodeList()
	end,
	Play1108411143 = function(arg_595_0, arg_595_1)
		arg_595_1.time_ = 0
		arg_595_1.frameCnt_ = 0
		arg_595_1.state_ = "playing"
		arg_595_1.curTalkId_ = 1108411143
		arg_595_1.duration_ = 5

		SetActive(arg_595_1.tipsGo_, false)

		function arg_595_1.onSingleLineFinish_()
			arg_595_1.onSingleLineUpdate_ = nil
			arg_595_1.onSingleLineFinish_ = nil
			arg_595_1.state_ = "waiting"
		end

		function arg_595_1.playNext_(arg_597_0)
			if arg_597_0 == 1 then
				arg_595_0:Play1108411144(arg_595_1)
			end
		end

		function arg_595_1.onSingleLineUpdate_(arg_598_0)
			local var_598_0 = 0.775

			if 0 < arg_595_1.time_ and arg_595_1.time_ <= 0 + arg_598_0 then
				arg_595_1.talkMaxDuration = 0
				arg_595_1.dialogCg_.alpha = 1

				arg_595_1.dialog_:SetActive(true)
				SetActive(arg_595_1.leftNameGo_, true)

				arg_595_1.leftNameTxt_.text = arg_595_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_595_1.leftNameTxt_.transform)

				arg_595_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_595_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_595_1:RecordName(arg_595_1.leftNameTxt_.text)
				SetActive(arg_595_1.iconTrs_.gameObject, true)
				arg_595_1.iconController_:SetSelectedState("hero")

				arg_595_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_595_1.callingController_:SetSelectedState("normal")

				arg_595_1.keyicon_.color = Color.New(1, 1, 1)
				arg_595_1.icon_.color = Color.New(1, 1, 1)

				local var_598_1 = arg_595_1:FormatText(arg_595_1:GetWordFromCfg(1108411143).content)

				arg_595_1.text_.text = var_598_1

				LuaForUtil.ClearLinePrefixSymbol(arg_595_1.text_)

				local var_598_3 = 31 <= 0 and var_598_0 or var_598_0 * (utf8.len(var_598_1) / 31)

				if (31 <= 0 and var_598_0 or var_598_0 * (utf8.len(var_598_1) / 31)) > 0 and var_598_0 < var_598_3 then
					arg_595_1.talkMaxDuration = var_598_3

					if var_598_3 + 0 > arg_595_1.duration_ then
						arg_595_1.duration_ = var_598_3 + 0
					end
				end

				arg_595_1.text_.text = var_598_1
				arg_595_1.typewritter.percent = 0

				arg_595_1.typewritter:SetDirty()
				arg_595_1:ShowNextGo(false)
				arg_595_1:RecordContent(arg_595_1.text_.text)
			end

			local var_598_4 = math.max(var_598_0, arg_595_1.talkMaxDuration)

			if 0 <= arg_595_1.time_ and arg_595_1.time_ < 0 + var_598_4 then
				arg_595_1.typewritter.percent = (arg_595_1.time_ - 0) / var_598_4

				arg_595_1.typewritter:SetDirty()
			end

			if arg_595_1.time_ >= 0 + var_598_4 and arg_595_1.time_ < 0 + var_598_4 + arg_598_0 then
				arg_595_1.typewritter.percent = 1

				arg_595_1.typewritter:SetDirty()
				arg_595_1:ShowNextGo(true)
			end
		end

		arg_595_1.nodeConfigList_ = {}

		arg_595_1:InitPlayNodeList()
	end,
	Play1108411144 = function(arg_599_0, arg_599_1)
		arg_599_1.time_ = 0
		arg_599_1.frameCnt_ = 0
		arg_599_1.state_ = "playing"
		arg_599_1.curTalkId_ = 1108411144
		arg_599_1.duration_ = 7.6

		local var_599_0 = {
			zh = 3.9,
			ja = 7.6
		}
		local var_599_1 = manager.audio:GetLocalizationFlag()

		if var_599_0[var_599_1] ~= nil then
			arg_599_1.duration_ = var_599_0[var_599_1]
		end

		SetActive(arg_599_1.tipsGo_, false)

		function arg_599_1.onSingleLineFinish_()
			arg_599_1.onSingleLineUpdate_ = nil
			arg_599_1.onSingleLineFinish_ = nil
			arg_599_1.state_ = "waiting"
		end

		function arg_599_1.playNext_(arg_601_0)
			if arg_601_0 == 1 then
				arg_599_0:Play1108411145(arg_599_1)
			end
		end

		function arg_599_1.onSingleLineUpdate_(arg_602_0)
			if 0 < arg_599_1.time_ and arg_599_1.time_ <= 0 + arg_602_0 then
				arg_599_1.var_.moveOldPos10102ui_story = arg_599_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_602_0 = 0.001

			if 0 <= arg_599_1.time_ and arg_599_1.time_ < 0 + var_602_0 then
				arg_599_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_599_1.var_.moveOldPos10102ui_story, Vector3.New(0, 100, 0), (arg_599_1.time_ - 0) / var_602_0)
				arg_599_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_599_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_599_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_599_1.actors_["10102ui_story"].transform.position).z)
				arg_599_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_599_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_599_1.actors_["10102ui_story"].transform.localEulerAngles = arg_599_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_599_1.time_ >= 0 + var_602_0 and arg_599_1.time_ < 0 + var_602_0 + arg_602_0 then
				arg_599_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_599_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_599_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_599_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_599_1.actors_["10102ui_story"].transform.position).z)
				arg_599_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_599_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_599_1.actors_["10102ui_story"].transform.localEulerAngles = arg_599_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_602_1 = arg_599_1.actors_["10102ui_story"]

			if 0 < arg_599_1.time_ and arg_599_1.time_ <= 0 + arg_602_0 and not isNil(var_602_1) and arg_599_1.var_.characterEffect10102ui_story == nil then
				arg_599_1.var_.characterEffect10102ui_story = var_602_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_602_2 = 0.200000002980232

			if 0 <= arg_599_1.time_ and arg_599_1.time_ < 0 + var_602_2 and not isNil(var_602_1) then
				if arg_599_1.var_.characterEffect10102ui_story and not isNil(var_602_1) then
					arg_599_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_599_1.time_ >= 0 + var_602_2 and arg_599_1.time_ < 0 + var_602_2 + arg_602_0 and not isNil(var_602_1) and arg_599_1.var_.characterEffect10102ui_story then
				arg_599_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_599_1.time_ and arg_599_1.time_ <= 0 + arg_602_0 then
				arg_599_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action1_1")
			end

			if 0 < arg_599_1.time_ and arg_599_1.time_ <= 0 + arg_602_0 then
				arg_599_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_602_4 = 0
			local var_602_5 = 0.375

			if 0 < arg_599_1.time_ and arg_599_1.time_ <= var_602_4 + arg_602_0 then
				arg_599_1.talkMaxDuration = 0
				arg_599_1.dialogCg_.alpha = 1

				arg_599_1.dialog_:SetActive(true)
				SetActive(arg_599_1.leftNameGo_, true)

				arg_599_1.leftNameTxt_.text = arg_599_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_599_1.leftNameTxt_.transform)

				arg_599_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_599_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_599_1:RecordName(arg_599_1.leftNameTxt_.text)
				SetActive(arg_599_1.iconTrs_.gameObject, true)
				arg_599_1.iconController_:SetSelectedState("hero")

				arg_599_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10102_split_1")

				arg_599_1.callingController_:SetSelectedState("normal")

				arg_599_1.keyicon_.color = Color.New(1, 1, 1)
				arg_599_1.icon_.color = Color.New(1, 1, 1)

				local var_602_6 = arg_599_1:GetWordFromCfg(1108411144)
				local var_602_7 = arg_599_1:FormatText(var_602_6.content)

				arg_599_1.text_.text = var_602_7

				LuaForUtil.ClearLinePrefixSymbol(arg_599_1.text_)

				local var_602_9 = 15 <= 0 and var_602_5 or var_602_5 * (utf8.len(var_602_7) / 15)

				if (15 <= 0 and var_602_5 or var_602_5 * (utf8.len(var_602_7) / 15)) > 0 and var_602_5 < var_602_9 then
					arg_599_1.talkMaxDuration = var_602_9

					if var_602_9 + var_602_4 > arg_599_1.duration_ then
						arg_599_1.duration_ = var_602_9 + var_602_4
					end
				end

				arg_599_1.text_.text = var_602_7
				arg_599_1.typewritter.percent = 0

				arg_599_1.typewritter:SetDirty()
				arg_599_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411144", "story_v_side_new_1108411.awb") ~= 0 then
					local var_602_10 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411144", "story_v_side_new_1108411.awb") / 1000

					if var_602_10 + var_602_4 > arg_599_1.duration_ then
						arg_599_1.duration_ = var_602_10 + var_602_4
					end

					if var_602_6.prefab_name ~= "" and arg_599_1.actors_[var_602_6.prefab_name] ~= nil then
						local var_602_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_599_1.actors_[var_602_6.prefab_name].transform, "story_v_side_new_1108411", "1108411144", "story_v_side_new_1108411.awb")

						arg_599_1:RecordAudio("1108411144", var_602_11)
						arg_599_1:RecordAudio("1108411144", var_602_11)
					else
						arg_599_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411144", "story_v_side_new_1108411.awb")
					end

					arg_599_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411144", "story_v_side_new_1108411.awb")
				end

				arg_599_1:RecordContent(arg_599_1.text_.text)
			end

			local var_602_12 = math.max(var_602_5, arg_599_1.talkMaxDuration)

			if var_602_4 <= arg_599_1.time_ and arg_599_1.time_ < var_602_4 + var_602_12 then
				arg_599_1.typewritter.percent = (arg_599_1.time_ - var_602_4) / var_602_12

				arg_599_1.typewritter:SetDirty()
			end

			if arg_599_1.time_ >= var_602_4 + var_602_12 and arg_599_1.time_ < var_602_4 + var_602_12 + arg_602_0 then
				arg_599_1.typewritter.percent = 1

				arg_599_1.typewritter:SetDirty()
				arg_599_1:ShowNextGo(true)
			end
		end

		arg_599_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_599_1:InitPlayNodeList()
	end,
	Play1108411145 = function(arg_603_0, arg_603_1)
		arg_603_1.time_ = 0
		arg_603_1.frameCnt_ = 0
		arg_603_1.state_ = "playing"
		arg_603_1.curTalkId_ = 1108411145
		arg_603_1.duration_ = 5

		SetActive(arg_603_1.tipsGo_, false)

		function arg_603_1.onSingleLineFinish_()
			arg_603_1.onSingleLineUpdate_ = nil
			arg_603_1.onSingleLineFinish_ = nil
			arg_603_1.state_ = "waiting"
		end

		function arg_603_1.playNext_(arg_605_0)
			if arg_605_0 == 1 then
				arg_603_0:Play1108411146(arg_603_1)
			end
		end

		function arg_603_1.onSingleLineUpdate_(arg_606_0)
			if 0 < arg_603_1.time_ and arg_603_1.time_ <= 0 + arg_606_0 then
				arg_603_1.var_.moveOldPos10102ui_story = arg_603_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_606_0 = 0.001

			if 0 <= arg_603_1.time_ and arg_603_1.time_ < 0 + var_606_0 then
				arg_603_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_603_1.var_.moveOldPos10102ui_story, Vector3.New(0, 100, 0), (arg_603_1.time_ - 0) / var_606_0)
				arg_603_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_603_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_603_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_603_1.actors_["10102ui_story"].transform.position).z)
				arg_603_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_603_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_603_1.actors_["10102ui_story"].transform.localEulerAngles = arg_603_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_603_1.time_ >= 0 + var_606_0 and arg_603_1.time_ < 0 + var_606_0 + arg_606_0 then
				arg_603_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_603_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_603_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_603_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_603_1.actors_["10102ui_story"].transform.position).z)
				arg_603_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_603_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_603_1.actors_["10102ui_story"].transform.localEulerAngles = arg_603_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_606_1 = arg_603_1.actors_["10102ui_story"]

			if 0 < arg_603_1.time_ and arg_603_1.time_ <= 0 + arg_606_0 and not isNil(var_606_1) and arg_603_1.var_.characterEffect10102ui_story == nil then
				arg_603_1.var_.characterEffect10102ui_story = var_606_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_606_2 = 0.200000002980232

			if 0 <= arg_603_1.time_ and arg_603_1.time_ < 0 + var_606_2 and not isNil(var_606_1) then
				if arg_603_1.var_.characterEffect10102ui_story and not isNil(var_606_1) then
					arg_603_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_603_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_603_1.time_ - 0) / var_606_2)
				end
			end

			if arg_603_1.time_ >= 0 + var_606_2 and arg_603_1.time_ < 0 + var_606_2 + arg_606_0 and not isNil(var_606_1) and arg_603_1.var_.characterEffect10102ui_story then
				arg_603_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_603_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_606_3 = 0
			local var_606_4 = 1.7

			if 0 < arg_603_1.time_ and arg_603_1.time_ <= var_606_3 + arg_606_0 then
				arg_603_1.talkMaxDuration = 0
				arg_603_1.dialogCg_.alpha = 1

				arg_603_1.dialog_:SetActive(true)
				SetActive(arg_603_1.leftNameGo_, false)

				arg_603_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_603_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_603_1:RecordName(arg_603_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_603_1.iconTrs_.gameObject, false)
				arg_603_1.callingController_:SetSelectedState("normal")

				local var_606_5 = arg_603_1:FormatText(arg_603_1:GetWordFromCfg(1108411145).content)

				arg_603_1.text_.text = var_606_5

				LuaForUtil.ClearLinePrefixSymbol(arg_603_1.text_)

				local var_606_7 = 68 <= 0 and var_606_4 or var_606_4 * (utf8.len(var_606_5) / 68)

				if (68 <= 0 and var_606_4 or var_606_4 * (utf8.len(var_606_5) / 68)) > 0 and var_606_4 < var_606_7 then
					arg_603_1.talkMaxDuration = var_606_7

					if var_606_7 + var_606_3 > arg_603_1.duration_ then
						arg_603_1.duration_ = var_606_7 + var_606_3
					end
				end

				arg_603_1.text_.text = var_606_5
				arg_603_1.typewritter.percent = 0

				arg_603_1.typewritter:SetDirty()
				arg_603_1:ShowNextGo(false)
				arg_603_1:RecordContent(arg_603_1.text_.text)
			end

			local var_606_8 = math.max(var_606_4, arg_603_1.talkMaxDuration)

			if var_606_3 <= arg_603_1.time_ and arg_603_1.time_ < var_606_3 + var_606_8 then
				arg_603_1.typewritter.percent = (arg_603_1.time_ - var_606_3) / var_606_8

				arg_603_1.typewritter:SetDirty()
			end

			if arg_603_1.time_ >= var_606_3 + var_606_8 and arg_603_1.time_ < var_606_3 + var_606_8 + arg_606_0 then
				arg_603_1.typewritter.percent = 1

				arg_603_1.typewritter:SetDirty()
				arg_603_1:ShowNextGo(true)
			end
		end

		arg_603_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_603_1:InitPlayNodeList()
	end,
	Play1108411146 = function(arg_607_0, arg_607_1)
		arg_607_1.time_ = 0
		arg_607_1.frameCnt_ = 0
		arg_607_1.state_ = "playing"
		arg_607_1.curTalkId_ = 1108411146
		arg_607_1.duration_ = 5

		SetActive(arg_607_1.tipsGo_, false)

		function arg_607_1.onSingleLineFinish_()
			arg_607_1.onSingleLineUpdate_ = nil
			arg_607_1.onSingleLineFinish_ = nil
			arg_607_1.state_ = "waiting"
		end

		function arg_607_1.playNext_(arg_609_0)
			if arg_609_0 == 1 then
				arg_607_0:Play1108411147(arg_607_1)
			end
		end

		function arg_607_1.onSingleLineUpdate_(arg_610_0)
			if 0 < arg_607_1.time_ and arg_607_1.time_ <= 0 + arg_610_0 then
				local var_610_0 = arg_607_1.var_.effect5454

				if not arg_607_1.var_.effect5454 then
					var_610_0 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_piaosan1"), manager.ui.mainCamera.transform)
					var_610_0.name = "5454"
					arg_607_1.var_.effect5454 = var_610_0
				else
					var_610_0.transform:SetParent(manager.ui.mainCamera.transform)
				end

				var_610_0.transform.localPosition = Vector3.New(0, 0, 0)
				var_610_0.transform.localRotation = Quaternion.Euler(0, 0, 0)
				var_610_0.transform.localScale = Vector3.New(var_610_0.transform.localScale.x * (Screen.width / Screen.height / 1.7777777777777777), var_610_0.transform.localScale.y * Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1), var_610_0.transform.localScale.z)
			end

			local var_610_2 = 0
			local var_610_3 = 1.175

			if 0 < arg_607_1.time_ and arg_607_1.time_ <= var_610_2 + arg_610_0 then
				arg_607_1.talkMaxDuration = 0
				arg_607_1.dialogCg_.alpha = 1

				arg_607_1.dialog_:SetActive(true)
				SetActive(arg_607_1.leftNameGo_, false)

				arg_607_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_607_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_607_1:RecordName(arg_607_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_607_1.iconTrs_.gameObject, false)
				arg_607_1.callingController_:SetSelectedState("normal")

				local var_610_4 = arg_607_1:FormatText(arg_607_1:GetWordFromCfg(1108411146).content)

				arg_607_1.text_.text = var_610_4

				LuaForUtil.ClearLinePrefixSymbol(arg_607_1.text_)

				local var_610_6 = 47 <= 0 and var_610_3 or var_610_3 * (utf8.len(var_610_4) / 47)

				if (47 <= 0 and var_610_3 or var_610_3 * (utf8.len(var_610_4) / 47)) > 0 and var_610_3 < var_610_6 then
					arg_607_1.talkMaxDuration = var_610_6

					if var_610_6 + var_610_2 > arg_607_1.duration_ then
						arg_607_1.duration_ = var_610_6 + var_610_2
					end
				end

				arg_607_1.text_.text = var_610_4
				arg_607_1.typewritter.percent = 0

				arg_607_1.typewritter:SetDirty()
				arg_607_1:ShowNextGo(false)
				arg_607_1:RecordContent(arg_607_1.text_.text)
			end

			local var_610_7 = math.max(var_610_3, arg_607_1.talkMaxDuration)

			if var_610_2 <= arg_607_1.time_ and arg_607_1.time_ < var_610_2 + var_610_7 then
				arg_607_1.typewritter.percent = (arg_607_1.time_ - var_610_2) / var_610_7

				arg_607_1.typewritter:SetDirty()
			end

			if arg_607_1.time_ >= var_610_2 + var_610_7 and arg_607_1.time_ < var_610_2 + var_610_7 + arg_610_0 then
				arg_607_1.typewritter.percent = 1

				arg_607_1.typewritter:SetDirty()
				arg_607_1:ShowNextGo(true)
			end
		end

		arg_607_1.nodeConfigList_ = {}

		arg_607_1:InitPlayNodeList()
	end,
	Play1108411147 = function(arg_611_0, arg_611_1)
		arg_611_1.time_ = 0
		arg_611_1.frameCnt_ = 0
		arg_611_1.state_ = "playing"
		arg_611_1.curTalkId_ = 1108411147
		arg_611_1.duration_ = 2.8

		local var_611_0 = {
			zh = 1.933,
			ja = 2.8
		}
		local var_611_1 = manager.audio:GetLocalizationFlag()

		if var_611_0[var_611_1] ~= nil then
			arg_611_1.duration_ = var_611_0[var_611_1]
		end

		SetActive(arg_611_1.tipsGo_, false)

		function arg_611_1.onSingleLineFinish_()
			arg_611_1.onSingleLineUpdate_ = nil
			arg_611_1.onSingleLineFinish_ = nil
			arg_611_1.state_ = "waiting"
		end

		function arg_611_1.playNext_(arg_613_0)
			if arg_613_0 == 1 then
				arg_611_0:Play1108411148(arg_611_1)
			end
		end

		function arg_611_1.onSingleLineUpdate_(arg_614_0)
			if 0 < arg_611_1.time_ and arg_611_1.time_ <= 0 + arg_614_0 and not isNil(arg_611_1.actors_["10102ui_story"]) and arg_611_1.var_.characterEffect10102ui_story == nil then
				arg_611_1.var_.characterEffect10102ui_story = arg_611_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_614_0 = 0.200000002980232

			if 0 <= arg_611_1.time_ and arg_611_1.time_ < 0 + var_614_0 and not isNil(arg_611_1.actors_["10102ui_story"]) then
				if arg_611_1.var_.characterEffect10102ui_story and not isNil(arg_611_1.actors_["10102ui_story"]) then
					arg_611_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_611_1.time_ >= 0 + var_614_0 and arg_611_1.time_ < 0 + var_614_0 + arg_614_0 and not isNil(arg_611_1.actors_["10102ui_story"]) and arg_611_1.var_.characterEffect10102ui_story then
				arg_611_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_614_2 = 0
			local var_614_3 = 0.15

			if 0 < arg_611_1.time_ and arg_611_1.time_ <= var_614_2 + arg_614_0 then
				arg_611_1.talkMaxDuration = 0
				arg_611_1.dialogCg_.alpha = 1

				arg_611_1.dialog_:SetActive(true)
				SetActive(arg_611_1.leftNameGo_, true)

				arg_611_1.leftNameTxt_.text = arg_611_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_611_1.leftNameTxt_.transform)

				arg_611_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_611_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_611_1:RecordName(arg_611_1.leftNameTxt_.text)
				SetActive(arg_611_1.iconTrs_.gameObject, true)
				arg_611_1.iconController_:SetSelectedState("hero")

				arg_611_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10102")

				arg_611_1.callingController_:SetSelectedState("normal")

				arg_611_1.keyicon_.color = Color.New(1, 1, 1)
				arg_611_1.icon_.color = Color.New(1, 1, 1)

				local var_614_4 = arg_611_1:GetWordFromCfg(1108411147)
				local var_614_5 = arg_611_1:FormatText(var_614_4.content)

				arg_611_1.text_.text = var_614_5

				LuaForUtil.ClearLinePrefixSymbol(arg_611_1.text_)

				local var_614_7 = 6 <= 0 and var_614_3 or var_614_3 * (utf8.len(var_614_5) / 6)

				if (6 <= 0 and var_614_3 or var_614_3 * (utf8.len(var_614_5) / 6)) > 0 and var_614_3 < var_614_7 then
					arg_611_1.talkMaxDuration = var_614_7

					if var_614_7 + var_614_2 > arg_611_1.duration_ then
						arg_611_1.duration_ = var_614_7 + var_614_2
					end
				end

				arg_611_1.text_.text = var_614_5
				arg_611_1.typewritter.percent = 0

				arg_611_1.typewritter:SetDirty()
				arg_611_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411147", "story_v_side_new_1108411.awb") ~= 0 then
					local var_614_8 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411147", "story_v_side_new_1108411.awb") / 1000

					if var_614_8 + var_614_2 > arg_611_1.duration_ then
						arg_611_1.duration_ = var_614_8 + var_614_2
					end

					if var_614_4.prefab_name ~= "" and arg_611_1.actors_[var_614_4.prefab_name] ~= nil then
						local var_614_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_611_1.actors_[var_614_4.prefab_name].transform, "story_v_side_new_1108411", "1108411147", "story_v_side_new_1108411.awb")

						arg_611_1:RecordAudio("1108411147", var_614_9)
						arg_611_1:RecordAudio("1108411147", var_614_9)
					else
						arg_611_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411147", "story_v_side_new_1108411.awb")
					end

					arg_611_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411147", "story_v_side_new_1108411.awb")
				end

				arg_611_1:RecordContent(arg_611_1.text_.text)
			end

			local var_614_10 = math.max(var_614_3, arg_611_1.talkMaxDuration)

			if var_614_2 <= arg_611_1.time_ and arg_611_1.time_ < var_614_2 + var_614_10 then
				arg_611_1.typewritter.percent = (arg_611_1.time_ - var_614_2) / var_614_10

				arg_611_1.typewritter:SetDirty()
			end

			if arg_611_1.time_ >= var_614_2 + var_614_10 and arg_611_1.time_ < var_614_2 + var_614_10 + arg_614_0 then
				arg_611_1.typewritter.percent = 1

				arg_611_1.typewritter:SetDirty()
				arg_611_1:ShowNextGo(true)
			end
		end

		arg_611_1.nodeConfigList_ = {}

		arg_611_1:InitPlayNodeList()
	end,
	Play1108411148 = function(arg_615_0, arg_615_1)
		arg_615_1.time_ = 0
		arg_615_1.frameCnt_ = 0
		arg_615_1.state_ = "playing"
		arg_615_1.curTalkId_ = 1108411148
		arg_615_1.duration_ = 5

		SetActive(arg_615_1.tipsGo_, false)

		function arg_615_1.onSingleLineFinish_()
			arg_615_1.onSingleLineUpdate_ = nil
			arg_615_1.onSingleLineFinish_ = nil
			arg_615_1.state_ = "waiting"
		end

		function arg_615_1.playNext_(arg_617_0)
			if arg_617_0 == 1 then
				arg_615_0:Play1108411149(arg_615_1)
			end
		end

		function arg_615_1.onSingleLineUpdate_(arg_618_0)
			if 0 < arg_615_1.time_ and arg_615_1.time_ <= 0 + arg_618_0 and not isNil(arg_615_1.actors_["10102ui_story"]) and arg_615_1.var_.characterEffect10102ui_story == nil then
				arg_615_1.var_.characterEffect10102ui_story = arg_615_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_618_0 = 0.200000002980232

			if 0 <= arg_615_1.time_ and arg_615_1.time_ < 0 + var_618_0 and not isNil(arg_615_1.actors_["10102ui_story"]) then
				if arg_615_1.var_.characterEffect10102ui_story and not isNil(arg_615_1.actors_["10102ui_story"]) then
					arg_615_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_615_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_615_1.time_ - 0) / var_618_0)
				end
			end

			if arg_615_1.time_ >= 0 + var_618_0 and arg_615_1.time_ < 0 + var_618_0 + arg_618_0 and not isNil(arg_615_1.actors_["10102ui_story"]) and arg_615_1.var_.characterEffect10102ui_story then
				arg_615_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_615_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_618_1 = 0
			local var_618_2 = 0.65

			if 0 < arg_615_1.time_ and arg_615_1.time_ <= var_618_1 + arg_618_0 then
				arg_615_1.talkMaxDuration = 0
				arg_615_1.dialogCg_.alpha = 1

				arg_615_1.dialog_:SetActive(true)
				SetActive(arg_615_1.leftNameGo_, true)

				arg_615_1.leftNameTxt_.text = arg_615_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_615_1.leftNameTxt_.transform)

				arg_615_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_615_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_615_1:RecordName(arg_615_1.leftNameTxt_.text)
				SetActive(arg_615_1.iconTrs_.gameObject, true)
				arg_615_1.iconController_:SetSelectedState("hero")

				arg_615_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_615_1.callingController_:SetSelectedState("normal")

				arg_615_1.keyicon_.color = Color.New(1, 1, 1)
				arg_615_1.icon_.color = Color.New(1, 1, 1)

				local var_618_3 = arg_615_1:FormatText(arg_615_1:GetWordFromCfg(1108411148).content)

				arg_615_1.text_.text = var_618_3

				LuaForUtil.ClearLinePrefixSymbol(arg_615_1.text_)

				local var_618_5 = 26 <= 0 and var_618_2 or var_618_2 * (utf8.len(var_618_3) / 26)

				if (26 <= 0 and var_618_2 or var_618_2 * (utf8.len(var_618_3) / 26)) > 0 and var_618_2 < var_618_5 then
					arg_615_1.talkMaxDuration = var_618_5

					if var_618_5 + var_618_1 > arg_615_1.duration_ then
						arg_615_1.duration_ = var_618_5 + var_618_1
					end
				end

				arg_615_1.text_.text = var_618_3
				arg_615_1.typewritter.percent = 0

				arg_615_1.typewritter:SetDirty()
				arg_615_1:ShowNextGo(false)
				arg_615_1:RecordContent(arg_615_1.text_.text)
			end

			local var_618_6 = math.max(var_618_2, arg_615_1.talkMaxDuration)

			if var_618_1 <= arg_615_1.time_ and arg_615_1.time_ < var_618_1 + var_618_6 then
				arg_615_1.typewritter.percent = (arg_615_1.time_ - var_618_1) / var_618_6

				arg_615_1.typewritter:SetDirty()
			end

			if arg_615_1.time_ >= var_618_1 + var_618_6 and arg_615_1.time_ < var_618_1 + var_618_6 + arg_618_0 then
				arg_615_1.typewritter.percent = 1

				arg_615_1.typewritter:SetDirty()
				arg_615_1:ShowNextGo(true)
			end
		end

		arg_615_1.nodeConfigList_ = {}

		arg_615_1:InitPlayNodeList()
	end,
	Play1108411149 = function(arg_619_0, arg_619_1)
		arg_619_1.time_ = 0
		arg_619_1.frameCnt_ = 0
		arg_619_1.state_ = "playing"
		arg_619_1.curTalkId_ = 1108411149
		arg_619_1.duration_ = 6

		local var_619_0 = {
			zh = 4.666,
			ja = 6
		}
		local var_619_1 = manager.audio:GetLocalizationFlag()

		if var_619_0[var_619_1] ~= nil then
			arg_619_1.duration_ = var_619_0[var_619_1]
		end

		SetActive(arg_619_1.tipsGo_, false)

		function arg_619_1.onSingleLineFinish_()
			arg_619_1.onSingleLineUpdate_ = nil
			arg_619_1.onSingleLineFinish_ = nil
			arg_619_1.state_ = "waiting"
		end

		function arg_619_1.playNext_(arg_621_0)
			if arg_621_0 == 1 then
				arg_619_0:Play1108411150(arg_619_1)
			end
		end

		function arg_619_1.onSingleLineUpdate_(arg_622_0)
			if 0 < arg_619_1.time_ and arg_619_1.time_ <= 0 + arg_622_0 and not isNil(arg_619_1.actors_["10102ui_story"]) and arg_619_1.var_.characterEffect10102ui_story == nil then
				arg_619_1.var_.characterEffect10102ui_story = arg_619_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_622_0 = 0.200000002980232

			if 0 <= arg_619_1.time_ and arg_619_1.time_ < 0 + var_622_0 and not isNil(arg_619_1.actors_["10102ui_story"]) then
				if arg_619_1.var_.characterEffect10102ui_story and not isNil(arg_619_1.actors_["10102ui_story"]) then
					arg_619_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_619_1.time_ >= 0 + var_622_0 and arg_619_1.time_ < 0 + var_622_0 + arg_622_0 and not isNil(arg_619_1.actors_["10102ui_story"]) and arg_619_1.var_.characterEffect10102ui_story then
				arg_619_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_622_2 = 0
			local var_622_3 = 0.5

			if 0 < arg_619_1.time_ and arg_619_1.time_ <= var_622_2 + arg_622_0 then
				arg_619_1.talkMaxDuration = 0
				arg_619_1.dialogCg_.alpha = 1

				arg_619_1.dialog_:SetActive(true)
				SetActive(arg_619_1.leftNameGo_, true)

				arg_619_1.leftNameTxt_.text = arg_619_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_619_1.leftNameTxt_.transform)

				arg_619_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_619_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_619_1:RecordName(arg_619_1.leftNameTxt_.text)
				SetActive(arg_619_1.iconTrs_.gameObject, true)
				arg_619_1.iconController_:SetSelectedState("hero")

				arg_619_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10102")

				arg_619_1.callingController_:SetSelectedState("normal")

				arg_619_1.keyicon_.color = Color.New(1, 1, 1)
				arg_619_1.icon_.color = Color.New(1, 1, 1)

				local var_622_4 = arg_619_1:GetWordFromCfg(1108411149)
				local var_622_5 = arg_619_1:FormatText(var_622_4.content)

				arg_619_1.text_.text = var_622_5

				LuaForUtil.ClearLinePrefixSymbol(arg_619_1.text_)

				local var_622_7 = 20 <= 0 and var_622_3 or var_622_3 * (utf8.len(var_622_5) / 20)

				if (20 <= 0 and var_622_3 or var_622_3 * (utf8.len(var_622_5) / 20)) > 0 and var_622_3 < var_622_7 then
					arg_619_1.talkMaxDuration = var_622_7

					if var_622_7 + var_622_2 > arg_619_1.duration_ then
						arg_619_1.duration_ = var_622_7 + var_622_2
					end
				end

				arg_619_1.text_.text = var_622_5
				arg_619_1.typewritter.percent = 0

				arg_619_1.typewritter:SetDirty()
				arg_619_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411149", "story_v_side_new_1108411.awb") ~= 0 then
					local var_622_8 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411149", "story_v_side_new_1108411.awb") / 1000

					if var_622_8 + var_622_2 > arg_619_1.duration_ then
						arg_619_1.duration_ = var_622_8 + var_622_2
					end

					if var_622_4.prefab_name ~= "" and arg_619_1.actors_[var_622_4.prefab_name] ~= nil then
						local var_622_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_619_1.actors_[var_622_4.prefab_name].transform, "story_v_side_new_1108411", "1108411149", "story_v_side_new_1108411.awb")

						arg_619_1:RecordAudio("1108411149", var_622_9)
						arg_619_1:RecordAudio("1108411149", var_622_9)
					else
						arg_619_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411149", "story_v_side_new_1108411.awb")
					end

					arg_619_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411149", "story_v_side_new_1108411.awb")
				end

				arg_619_1:RecordContent(arg_619_1.text_.text)
			end

			local var_622_10 = math.max(var_622_3, arg_619_1.talkMaxDuration)

			if var_622_2 <= arg_619_1.time_ and arg_619_1.time_ < var_622_2 + var_622_10 then
				arg_619_1.typewritter.percent = (arg_619_1.time_ - var_622_2) / var_622_10

				arg_619_1.typewritter:SetDirty()
			end

			if arg_619_1.time_ >= var_622_2 + var_622_10 and arg_619_1.time_ < var_622_2 + var_622_10 + arg_622_0 then
				arg_619_1.typewritter.percent = 1

				arg_619_1.typewritter:SetDirty()
				arg_619_1:ShowNextGo(true)
			end
		end

		arg_619_1.nodeConfigList_ = {}

		arg_619_1:InitPlayNodeList()
	end,
	Play1108411150 = function(arg_623_0, arg_623_1)
		arg_623_1.time_ = 0
		arg_623_1.frameCnt_ = 0
		arg_623_1.state_ = "playing"
		arg_623_1.curTalkId_ = 1108411150
		arg_623_1.duration_ = 5

		SetActive(arg_623_1.tipsGo_, false)

		function arg_623_1.onSingleLineFinish_()
			arg_623_1.onSingleLineUpdate_ = nil
			arg_623_1.onSingleLineFinish_ = nil
			arg_623_1.state_ = "waiting"
		end

		function arg_623_1.playNext_(arg_625_0)
			if arg_625_0 == 1 then
				arg_623_0:Play1108411151(arg_623_1)
			end
		end

		function arg_623_1.onSingleLineUpdate_(arg_626_0)
			if 0 < arg_623_1.time_ and arg_623_1.time_ <= 0 + arg_626_0 and not isNil(arg_623_1.actors_["10102ui_story"]) and arg_623_1.var_.characterEffect10102ui_story == nil then
				arg_623_1.var_.characterEffect10102ui_story = arg_623_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_626_0 = 0.200000002980232

			if 0 <= arg_623_1.time_ and arg_623_1.time_ < 0 + var_626_0 and not isNil(arg_623_1.actors_["10102ui_story"]) then
				if arg_623_1.var_.characterEffect10102ui_story and not isNil(arg_623_1.actors_["10102ui_story"]) then
					arg_623_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_623_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_623_1.time_ - 0) / var_626_0)
				end
			end

			if arg_623_1.time_ >= 0 + var_626_0 and arg_623_1.time_ < 0 + var_626_0 + arg_626_0 and not isNil(arg_623_1.actors_["10102ui_story"]) and arg_623_1.var_.characterEffect10102ui_story then
				arg_623_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_623_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_626_1 = 0
			local var_626_2 = 0.9

			if 0 < arg_623_1.time_ and arg_623_1.time_ <= var_626_1 + arg_626_0 then
				arg_623_1.talkMaxDuration = 0
				arg_623_1.dialogCg_.alpha = 1

				arg_623_1.dialog_:SetActive(true)
				SetActive(arg_623_1.leftNameGo_, false)

				arg_623_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_623_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_623_1:RecordName(arg_623_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_623_1.iconTrs_.gameObject, false)
				arg_623_1.callingController_:SetSelectedState("normal")

				local var_626_3 = arg_623_1:FormatText(arg_623_1:GetWordFromCfg(1108411150).content)

				arg_623_1.text_.text = var_626_3

				LuaForUtil.ClearLinePrefixSymbol(arg_623_1.text_)

				local var_626_5 = 36 <= 0 and var_626_2 or var_626_2 * (utf8.len(var_626_3) / 36)

				if (36 <= 0 and var_626_2 or var_626_2 * (utf8.len(var_626_3) / 36)) > 0 and var_626_2 < var_626_5 then
					arg_623_1.talkMaxDuration = var_626_5

					if var_626_5 + var_626_1 > arg_623_1.duration_ then
						arg_623_1.duration_ = var_626_5 + var_626_1
					end
				end

				arg_623_1.text_.text = var_626_3
				arg_623_1.typewritter.percent = 0

				arg_623_1.typewritter:SetDirty()
				arg_623_1:ShowNextGo(false)
				arg_623_1:RecordContent(arg_623_1.text_.text)
			end

			local var_626_6 = math.max(var_626_2, arg_623_1.talkMaxDuration)

			if var_626_1 <= arg_623_1.time_ and arg_623_1.time_ < var_626_1 + var_626_6 then
				arg_623_1.typewritter.percent = (arg_623_1.time_ - var_626_1) / var_626_6

				arg_623_1.typewritter:SetDirty()
			end

			if arg_623_1.time_ >= var_626_1 + var_626_6 and arg_623_1.time_ < var_626_1 + var_626_6 + arg_626_0 then
				arg_623_1.typewritter.percent = 1

				arg_623_1.typewritter:SetDirty()
				arg_623_1:ShowNextGo(true)
			end
		end

		arg_623_1.nodeConfigList_ = {}

		arg_623_1:InitPlayNodeList()
	end,
	Play1108411151 = function(arg_627_0, arg_627_1)
		arg_627_1.time_ = 0
		arg_627_1.frameCnt_ = 0
		arg_627_1.state_ = "playing"
		arg_627_1.curTalkId_ = 1108411151
		arg_627_1.duration_ = 8.27

		local var_627_0 = {
			zh = 5.166,
			ja = 8.266
		}
		local var_627_1 = manager.audio:GetLocalizationFlag()

		if var_627_0[var_627_1] ~= nil then
			arg_627_1.duration_ = var_627_0[var_627_1]
		end

		SetActive(arg_627_1.tipsGo_, false)

		function arg_627_1.onSingleLineFinish_()
			arg_627_1.onSingleLineUpdate_ = nil
			arg_627_1.onSingleLineFinish_ = nil
			arg_627_1.state_ = "waiting"
		end

		function arg_627_1.playNext_(arg_629_0)
			if arg_629_0 == 1 then
				arg_627_0:Play1108411152(arg_627_1)
			end
		end

		function arg_627_1.onSingleLineUpdate_(arg_630_0)
			if 0 < arg_627_1.time_ and arg_627_1.time_ <= 0 + arg_630_0 and not isNil(arg_627_1.actors_["10102ui_story"]) and arg_627_1.var_.characterEffect10102ui_story == nil then
				arg_627_1.var_.characterEffect10102ui_story = arg_627_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_630_0 = 0.200000002980232

			if 0 <= arg_627_1.time_ and arg_627_1.time_ < 0 + var_630_0 and not isNil(arg_627_1.actors_["10102ui_story"]) then
				if arg_627_1.var_.characterEffect10102ui_story and not isNil(arg_627_1.actors_["10102ui_story"]) then
					arg_627_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_627_1.time_ >= 0 + var_630_0 and arg_627_1.time_ < 0 + var_630_0 + arg_630_0 and not isNil(arg_627_1.actors_["10102ui_story"]) and arg_627_1.var_.characterEffect10102ui_story then
				arg_627_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_630_2 = 0
			local var_630_3 = 0.5

			if 0 < arg_627_1.time_ and arg_627_1.time_ <= var_630_2 + arg_630_0 then
				arg_627_1.talkMaxDuration = 0
				arg_627_1.dialogCg_.alpha = 1

				arg_627_1.dialog_:SetActive(true)
				SetActive(arg_627_1.leftNameGo_, true)

				arg_627_1.leftNameTxt_.text = arg_627_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_627_1.leftNameTxt_.transform)

				arg_627_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_627_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_627_1:RecordName(arg_627_1.leftNameTxt_.text)
				SetActive(arg_627_1.iconTrs_.gameObject, true)
				arg_627_1.iconController_:SetSelectedState("hero")

				arg_627_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10102")

				arg_627_1.callingController_:SetSelectedState("normal")

				arg_627_1.keyicon_.color = Color.New(1, 1, 1)
				arg_627_1.icon_.color = Color.New(1, 1, 1)

				local var_630_4 = arg_627_1:GetWordFromCfg(1108411151)
				local var_630_5 = arg_627_1:FormatText(var_630_4.content)

				arg_627_1.text_.text = var_630_5

				LuaForUtil.ClearLinePrefixSymbol(arg_627_1.text_)

				local var_630_7 = 20 <= 0 and var_630_3 or var_630_3 * (utf8.len(var_630_5) / 20)

				if (20 <= 0 and var_630_3 or var_630_3 * (utf8.len(var_630_5) / 20)) > 0 and var_630_3 < var_630_7 then
					arg_627_1.talkMaxDuration = var_630_7

					if var_630_7 + var_630_2 > arg_627_1.duration_ then
						arg_627_1.duration_ = var_630_7 + var_630_2
					end
				end

				arg_627_1.text_.text = var_630_5
				arg_627_1.typewritter.percent = 0

				arg_627_1.typewritter:SetDirty()
				arg_627_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411151", "story_v_side_new_1108411.awb") ~= 0 then
					local var_630_8 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411151", "story_v_side_new_1108411.awb") / 1000

					if var_630_8 + var_630_2 > arg_627_1.duration_ then
						arg_627_1.duration_ = var_630_8 + var_630_2
					end

					if var_630_4.prefab_name ~= "" and arg_627_1.actors_[var_630_4.prefab_name] ~= nil then
						local var_630_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_627_1.actors_[var_630_4.prefab_name].transform, "story_v_side_new_1108411", "1108411151", "story_v_side_new_1108411.awb")

						arg_627_1:RecordAudio("1108411151", var_630_9)
						arg_627_1:RecordAudio("1108411151", var_630_9)
					else
						arg_627_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411151", "story_v_side_new_1108411.awb")
					end

					arg_627_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411151", "story_v_side_new_1108411.awb")
				end

				arg_627_1:RecordContent(arg_627_1.text_.text)
			end

			local var_630_10 = math.max(var_630_3, arg_627_1.talkMaxDuration)

			if var_630_2 <= arg_627_1.time_ and arg_627_1.time_ < var_630_2 + var_630_10 then
				arg_627_1.typewritter.percent = (arg_627_1.time_ - var_630_2) / var_630_10

				arg_627_1.typewritter:SetDirty()
			end

			if arg_627_1.time_ >= var_630_2 + var_630_10 and arg_627_1.time_ < var_630_2 + var_630_10 + arg_630_0 then
				arg_627_1.typewritter.percent = 1

				arg_627_1.typewritter:SetDirty()
				arg_627_1:ShowNextGo(true)
			end
		end

		arg_627_1.nodeConfigList_ = {}

		arg_627_1:InitPlayNodeList()
	end,
	Play1108411152 = function(arg_631_0, arg_631_1)
		arg_631_1.time_ = 0
		arg_631_1.frameCnt_ = 0
		arg_631_1.state_ = "playing"
		arg_631_1.curTalkId_ = 1108411152
		arg_631_1.duration_ = 5

		SetActive(arg_631_1.tipsGo_, false)

		function arg_631_1.onSingleLineFinish_()
			arg_631_1.onSingleLineUpdate_ = nil
			arg_631_1.onSingleLineFinish_ = nil
			arg_631_1.state_ = "waiting"
		end

		function arg_631_1.playNext_(arg_633_0)
			if arg_633_0 == 1 then
				arg_631_0:Play1108411153(arg_631_1)
			end
		end

		function arg_631_1.onSingleLineUpdate_(arg_634_0)
			if 0 < arg_631_1.time_ and arg_631_1.time_ <= 0 + arg_634_0 and not isNil(arg_631_1.actors_["10102ui_story"]) and arg_631_1.var_.characterEffect10102ui_story == nil then
				arg_631_1.var_.characterEffect10102ui_story = arg_631_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_634_0 = 0.200000002980232

			if 0 <= arg_631_1.time_ and arg_631_1.time_ < 0 + var_634_0 and not isNil(arg_631_1.actors_["10102ui_story"]) then
				if arg_631_1.var_.characterEffect10102ui_story and not isNil(arg_631_1.actors_["10102ui_story"]) then
					arg_631_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_631_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_631_1.time_ - 0) / var_634_0)
				end
			end

			if arg_631_1.time_ >= 0 + var_634_0 and arg_631_1.time_ < 0 + var_634_0 + arg_634_0 and not isNil(arg_631_1.actors_["10102ui_story"]) and arg_631_1.var_.characterEffect10102ui_story then
				arg_631_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_631_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_634_1 = 0
			local var_634_2 = 0.225

			if 0 < arg_631_1.time_ and arg_631_1.time_ <= var_634_1 + arg_634_0 then
				arg_631_1.talkMaxDuration = 0
				arg_631_1.dialogCg_.alpha = 1

				arg_631_1.dialog_:SetActive(true)
				SetActive(arg_631_1.leftNameGo_, true)

				arg_631_1.leftNameTxt_.text = arg_631_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_631_1.leftNameTxt_.transform)

				arg_631_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_631_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_631_1:RecordName(arg_631_1.leftNameTxt_.text)
				SetActive(arg_631_1.iconTrs_.gameObject, true)
				arg_631_1.iconController_:SetSelectedState("hero")

				arg_631_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_631_1.callingController_:SetSelectedState("normal")

				arg_631_1.keyicon_.color = Color.New(1, 1, 1)
				arg_631_1.icon_.color = Color.New(1, 1, 1)

				local var_634_3 = arg_631_1:FormatText(arg_631_1:GetWordFromCfg(1108411152).content)

				arg_631_1.text_.text = var_634_3

				LuaForUtil.ClearLinePrefixSymbol(arg_631_1.text_)

				local var_634_5 = 9 <= 0 and var_634_2 or var_634_2 * (utf8.len(var_634_3) / 9)

				if (9 <= 0 and var_634_2 or var_634_2 * (utf8.len(var_634_3) / 9)) > 0 and var_634_2 < var_634_5 then
					arg_631_1.talkMaxDuration = var_634_5

					if var_634_5 + var_634_1 > arg_631_1.duration_ then
						arg_631_1.duration_ = var_634_5 + var_634_1
					end
				end

				arg_631_1.text_.text = var_634_3
				arg_631_1.typewritter.percent = 0

				arg_631_1.typewritter:SetDirty()
				arg_631_1:ShowNextGo(false)
				arg_631_1:RecordContent(arg_631_1.text_.text)
			end

			local var_634_6 = math.max(var_634_2, arg_631_1.talkMaxDuration)

			if var_634_1 <= arg_631_1.time_ and arg_631_1.time_ < var_634_1 + var_634_6 then
				arg_631_1.typewritter.percent = (arg_631_1.time_ - var_634_1) / var_634_6

				arg_631_1.typewritter:SetDirty()
			end

			if arg_631_1.time_ >= var_634_1 + var_634_6 and arg_631_1.time_ < var_634_1 + var_634_6 + arg_634_0 then
				arg_631_1.typewritter.percent = 1

				arg_631_1.typewritter:SetDirty()
				arg_631_1:ShowNextGo(true)
			end
		end

		arg_631_1.nodeConfigList_ = {}

		arg_631_1:InitPlayNodeList()
	end,
	Play1108411153 = function(arg_635_0, arg_635_1)
		arg_635_1.time_ = 0
		arg_635_1.frameCnt_ = 0
		arg_635_1.state_ = "playing"
		arg_635_1.curTalkId_ = 1108411153
		arg_635_1.duration_ = 3.7

		local var_635_0 = {
			zh = 3.2,
			ja = 3.7
		}
		local var_635_1 = manager.audio:GetLocalizationFlag()

		if var_635_0[var_635_1] ~= nil then
			arg_635_1.duration_ = var_635_0[var_635_1]
		end

		SetActive(arg_635_1.tipsGo_, false)

		function arg_635_1.onSingleLineFinish_()
			arg_635_1.onSingleLineUpdate_ = nil
			arg_635_1.onSingleLineFinish_ = nil
			arg_635_1.state_ = "waiting"
		end

		function arg_635_1.playNext_(arg_637_0)
			if arg_637_0 == 1 then
				arg_635_0:Play1108411154(arg_635_1)
			end
		end

		function arg_635_1.onSingleLineUpdate_(arg_638_0)
			if 0 < arg_635_1.time_ and arg_635_1.time_ <= 0 + arg_638_0 and not isNil(arg_635_1.actors_["10102ui_story"]) and arg_635_1.var_.characterEffect10102ui_story == nil then
				arg_635_1.var_.characterEffect10102ui_story = arg_635_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_638_0 = 0.200000002980232

			if 0 <= arg_635_1.time_ and arg_635_1.time_ < 0 + var_638_0 and not isNil(arg_635_1.actors_["10102ui_story"]) then
				if arg_635_1.var_.characterEffect10102ui_story and not isNil(arg_635_1.actors_["10102ui_story"]) then
					arg_635_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_635_1.time_ >= 0 + var_638_0 and arg_635_1.time_ < 0 + var_638_0 + arg_638_0 and not isNil(arg_635_1.actors_["10102ui_story"]) and arg_635_1.var_.characterEffect10102ui_story then
				arg_635_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_638_2 = 0
			local var_638_3 = 0.35

			if 0 < arg_635_1.time_ and arg_635_1.time_ <= var_638_2 + arg_638_0 then
				arg_635_1.talkMaxDuration = 0
				arg_635_1.dialogCg_.alpha = 1

				arg_635_1.dialog_:SetActive(true)
				SetActive(arg_635_1.leftNameGo_, true)

				arg_635_1.leftNameTxt_.text = arg_635_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_635_1.leftNameTxt_.transform)

				arg_635_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_635_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_635_1:RecordName(arg_635_1.leftNameTxt_.text)
				SetActive(arg_635_1.iconTrs_.gameObject, true)
				arg_635_1.iconController_:SetSelectedState("hero")

				arg_635_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10102")

				arg_635_1.callingController_:SetSelectedState("normal")

				arg_635_1.keyicon_.color = Color.New(1, 1, 1)
				arg_635_1.icon_.color = Color.New(1, 1, 1)

				local var_638_4 = arg_635_1:GetWordFromCfg(1108411153)
				local var_638_5 = arg_635_1:FormatText(var_638_4.content)

				arg_635_1.text_.text = var_638_5

				LuaForUtil.ClearLinePrefixSymbol(arg_635_1.text_)

				local var_638_7 = 14 <= 0 and var_638_3 or var_638_3 * (utf8.len(var_638_5) / 14)

				if (14 <= 0 and var_638_3 or var_638_3 * (utf8.len(var_638_5) / 14)) > 0 and var_638_3 < var_638_7 then
					arg_635_1.talkMaxDuration = var_638_7

					if var_638_7 + var_638_2 > arg_635_1.duration_ then
						arg_635_1.duration_ = var_638_7 + var_638_2
					end
				end

				arg_635_1.text_.text = var_638_5
				arg_635_1.typewritter.percent = 0

				arg_635_1.typewritter:SetDirty()
				arg_635_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411153", "story_v_side_new_1108411.awb") ~= 0 then
					local var_638_8 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411153", "story_v_side_new_1108411.awb") / 1000

					if var_638_8 + var_638_2 > arg_635_1.duration_ then
						arg_635_1.duration_ = var_638_8 + var_638_2
					end

					if var_638_4.prefab_name ~= "" and arg_635_1.actors_[var_638_4.prefab_name] ~= nil then
						local var_638_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_635_1.actors_[var_638_4.prefab_name].transform, "story_v_side_new_1108411", "1108411153", "story_v_side_new_1108411.awb")

						arg_635_1:RecordAudio("1108411153", var_638_9)
						arg_635_1:RecordAudio("1108411153", var_638_9)
					else
						arg_635_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411153", "story_v_side_new_1108411.awb")
					end

					arg_635_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411153", "story_v_side_new_1108411.awb")
				end

				arg_635_1:RecordContent(arg_635_1.text_.text)
			end

			local var_638_10 = math.max(var_638_3, arg_635_1.talkMaxDuration)

			if var_638_2 <= arg_635_1.time_ and arg_635_1.time_ < var_638_2 + var_638_10 then
				arg_635_1.typewritter.percent = (arg_635_1.time_ - var_638_2) / var_638_10

				arg_635_1.typewritter:SetDirty()
			end

			if arg_635_1.time_ >= var_638_2 + var_638_10 and arg_635_1.time_ < var_638_2 + var_638_10 + arg_638_0 then
				arg_635_1.typewritter.percent = 1

				arg_635_1.typewritter:SetDirty()
				arg_635_1:ShowNextGo(true)
			end
		end

		arg_635_1.nodeConfigList_ = {}

		arg_635_1:InitPlayNodeList()
	end,
	Play1108411154 = function(arg_639_0, arg_639_1)
		arg_639_1.time_ = 0
		arg_639_1.frameCnt_ = 0
		arg_639_1.state_ = "playing"
		arg_639_1.curTalkId_ = 1108411154
		arg_639_1.duration_ = 5

		SetActive(arg_639_1.tipsGo_, false)

		function arg_639_1.onSingleLineFinish_()
			arg_639_1.onSingleLineUpdate_ = nil
			arg_639_1.onSingleLineFinish_ = nil
			arg_639_1.state_ = "waiting"
		end

		function arg_639_1.playNext_(arg_641_0)
			if arg_641_0 == 1 then
				arg_639_0:Play1108411155(arg_639_1)
			end
		end

		function arg_639_1.onSingleLineUpdate_(arg_642_0)
			if 0 < arg_639_1.time_ and arg_639_1.time_ <= 0 + arg_642_0 and not isNil(arg_639_1.actors_["10102ui_story"]) and arg_639_1.var_.characterEffect10102ui_story == nil then
				arg_639_1.var_.characterEffect10102ui_story = arg_639_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_642_0 = 0.200000002980232

			if 0 <= arg_639_1.time_ and arg_639_1.time_ < 0 + var_642_0 and not isNil(arg_639_1.actors_["10102ui_story"]) then
				if arg_639_1.var_.characterEffect10102ui_story and not isNil(arg_639_1.actors_["10102ui_story"]) then
					arg_639_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_639_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_639_1.time_ - 0) / var_642_0)
				end
			end

			if arg_639_1.time_ >= 0 + var_642_0 and arg_639_1.time_ < 0 + var_642_0 + arg_642_0 and not isNil(arg_639_1.actors_["10102ui_story"]) and arg_639_1.var_.characterEffect10102ui_story then
				arg_639_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_639_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_642_1 = 0
			local var_642_2 = 0.4

			if 0 < arg_639_1.time_ and arg_639_1.time_ <= var_642_1 + arg_642_0 then
				arg_639_1.talkMaxDuration = 0
				arg_639_1.dialogCg_.alpha = 1

				arg_639_1.dialog_:SetActive(true)
				SetActive(arg_639_1.leftNameGo_, true)

				arg_639_1.leftNameTxt_.text = arg_639_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_639_1.leftNameTxt_.transform)

				arg_639_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_639_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_639_1:RecordName(arg_639_1.leftNameTxt_.text)
				SetActive(arg_639_1.iconTrs_.gameObject, true)
				arg_639_1.iconController_:SetSelectedState("hero")

				arg_639_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_639_1.callingController_:SetSelectedState("normal")

				arg_639_1.keyicon_.color = Color.New(1, 1, 1)
				arg_639_1.icon_.color = Color.New(1, 1, 1)

				local var_642_3 = arg_639_1:FormatText(arg_639_1:GetWordFromCfg(1108411154).content)

				arg_639_1.text_.text = var_642_3

				LuaForUtil.ClearLinePrefixSymbol(arg_639_1.text_)

				local var_642_5 = 16 <= 0 and var_642_2 or var_642_2 * (utf8.len(var_642_3) / 16)

				if (16 <= 0 and var_642_2 or var_642_2 * (utf8.len(var_642_3) / 16)) > 0 and var_642_2 < var_642_5 then
					arg_639_1.talkMaxDuration = var_642_5

					if var_642_5 + var_642_1 > arg_639_1.duration_ then
						arg_639_1.duration_ = var_642_5 + var_642_1
					end
				end

				arg_639_1.text_.text = var_642_3
				arg_639_1.typewritter.percent = 0

				arg_639_1.typewritter:SetDirty()
				arg_639_1:ShowNextGo(false)
				arg_639_1:RecordContent(arg_639_1.text_.text)
			end

			local var_642_6 = math.max(var_642_2, arg_639_1.talkMaxDuration)

			if var_642_1 <= arg_639_1.time_ and arg_639_1.time_ < var_642_1 + var_642_6 then
				arg_639_1.typewritter.percent = (arg_639_1.time_ - var_642_1) / var_642_6

				arg_639_1.typewritter:SetDirty()
			end

			if arg_639_1.time_ >= var_642_1 + var_642_6 and arg_639_1.time_ < var_642_1 + var_642_6 + arg_642_0 then
				arg_639_1.typewritter.percent = 1

				arg_639_1.typewritter:SetDirty()
				arg_639_1:ShowNextGo(true)
			end
		end

		arg_639_1.nodeConfigList_ = {}

		arg_639_1:InitPlayNodeList()
	end,
	Play1108411155 = function(arg_643_0, arg_643_1)
		arg_643_1.time_ = 0
		arg_643_1.frameCnt_ = 0
		arg_643_1.state_ = "playing"
		arg_643_1.curTalkId_ = 1108411155
		arg_643_1.duration_ = 2.13

		local var_643_0 = {
			zh = 2.133,
			ja = 2.033
		}
		local var_643_1 = manager.audio:GetLocalizationFlag()

		if var_643_0[var_643_1] ~= nil then
			arg_643_1.duration_ = var_643_0[var_643_1]
		end

		SetActive(arg_643_1.tipsGo_, false)

		function arg_643_1.onSingleLineFinish_()
			arg_643_1.onSingleLineUpdate_ = nil
			arg_643_1.onSingleLineFinish_ = nil
			arg_643_1.state_ = "waiting"
		end

		function arg_643_1.playNext_(arg_645_0)
			if arg_645_0 == 1 then
				arg_643_0:Play1108411156(arg_643_1)
			end
		end

		function arg_643_1.onSingleLineUpdate_(arg_646_0)
			if 0 < arg_643_1.time_ and arg_643_1.time_ <= 0 + arg_646_0 and not isNil(arg_643_1.actors_["10102ui_story"]) and arg_643_1.var_.characterEffect10102ui_story == nil then
				arg_643_1.var_.characterEffect10102ui_story = arg_643_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_646_0 = 0.200000002980232

			if 0 <= arg_643_1.time_ and arg_643_1.time_ < 0 + var_646_0 and not isNil(arg_643_1.actors_["10102ui_story"]) then
				if arg_643_1.var_.characterEffect10102ui_story and not isNil(arg_643_1.actors_["10102ui_story"]) then
					arg_643_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_643_1.time_ >= 0 + var_646_0 and arg_643_1.time_ < 0 + var_646_0 + arg_646_0 and not isNil(arg_643_1.actors_["10102ui_story"]) and arg_643_1.var_.characterEffect10102ui_story then
				arg_643_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_646_2 = 0
			local var_646_3 = 0.225

			if 0 < arg_643_1.time_ and arg_643_1.time_ <= var_646_2 + arg_646_0 then
				arg_643_1.talkMaxDuration = 0
				arg_643_1.dialogCg_.alpha = 1

				arg_643_1.dialog_:SetActive(true)
				SetActive(arg_643_1.leftNameGo_, true)

				arg_643_1.leftNameTxt_.text = arg_643_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_643_1.leftNameTxt_.transform)

				arg_643_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_643_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_643_1:RecordName(arg_643_1.leftNameTxt_.text)
				SetActive(arg_643_1.iconTrs_.gameObject, true)
				arg_643_1.iconController_:SetSelectedState("hero")

				arg_643_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10102")

				arg_643_1.callingController_:SetSelectedState("normal")

				arg_643_1.keyicon_.color = Color.New(1, 1, 1)
				arg_643_1.icon_.color = Color.New(1, 1, 1)

				local var_646_4 = arg_643_1:GetWordFromCfg(1108411155)
				local var_646_5 = arg_643_1:FormatText(var_646_4.content)

				arg_643_1.text_.text = var_646_5

				LuaForUtil.ClearLinePrefixSymbol(arg_643_1.text_)

				local var_646_7 = 9 <= 0 and var_646_3 or var_646_3 * (utf8.len(var_646_5) / 9)

				if (9 <= 0 and var_646_3 or var_646_3 * (utf8.len(var_646_5) / 9)) > 0 and var_646_3 < var_646_7 then
					arg_643_1.talkMaxDuration = var_646_7

					if var_646_7 + var_646_2 > arg_643_1.duration_ then
						arg_643_1.duration_ = var_646_7 + var_646_2
					end
				end

				arg_643_1.text_.text = var_646_5
				arg_643_1.typewritter.percent = 0

				arg_643_1.typewritter:SetDirty()
				arg_643_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411155", "story_v_side_new_1108411.awb") ~= 0 then
					local var_646_8 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411155", "story_v_side_new_1108411.awb") / 1000

					if var_646_8 + var_646_2 > arg_643_1.duration_ then
						arg_643_1.duration_ = var_646_8 + var_646_2
					end

					if var_646_4.prefab_name ~= "" and arg_643_1.actors_[var_646_4.prefab_name] ~= nil then
						local var_646_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_643_1.actors_[var_646_4.prefab_name].transform, "story_v_side_new_1108411", "1108411155", "story_v_side_new_1108411.awb")

						arg_643_1:RecordAudio("1108411155", var_646_9)
						arg_643_1:RecordAudio("1108411155", var_646_9)
					else
						arg_643_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411155", "story_v_side_new_1108411.awb")
					end

					arg_643_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411155", "story_v_side_new_1108411.awb")
				end

				arg_643_1:RecordContent(arg_643_1.text_.text)
			end

			local var_646_10 = math.max(var_646_3, arg_643_1.talkMaxDuration)

			if var_646_2 <= arg_643_1.time_ and arg_643_1.time_ < var_646_2 + var_646_10 then
				arg_643_1.typewritter.percent = (arg_643_1.time_ - var_646_2) / var_646_10

				arg_643_1.typewritter:SetDirty()
			end

			if arg_643_1.time_ >= var_646_2 + var_646_10 and arg_643_1.time_ < var_646_2 + var_646_10 + arg_646_0 then
				arg_643_1.typewritter.percent = 1

				arg_643_1.typewritter:SetDirty()
				arg_643_1:ShowNextGo(true)
			end
		end

		arg_643_1.nodeConfigList_ = {}

		arg_643_1:InitPlayNodeList()
	end,
	Play1108411156 = function(arg_647_0, arg_647_1)
		arg_647_1.time_ = 0
		arg_647_1.frameCnt_ = 0
		arg_647_1.state_ = "playing"
		arg_647_1.curTalkId_ = 1108411156
		arg_647_1.duration_ = 6.83

		SetActive(arg_647_1.tipsGo_, false)

		function arg_647_1.onSingleLineFinish_()
			arg_647_1.onSingleLineUpdate_ = nil
			arg_647_1.onSingleLineFinish_ = nil
			arg_647_1.state_ = "waiting"
		end

		function arg_647_1.playNext_(arg_649_0)
			if arg_649_0 == 1 then
				arg_647_0:Play1108411157(arg_647_1)
			end
		end

		function arg_647_1.onSingleLineUpdate_(arg_650_0)
			local var_650_9000

			if 0 < arg_647_1.time_ and arg_647_1.time_ <= 0 + arg_650_0 then
				local var_650_0 = arg_647_1.bgs_.ST0116a

				arg_647_1.bgs_.ST0116a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_650_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_650_1 = var_650_0:GetComponent("SpriteRenderer")

				if var_650_1 and var_650_1.sprite then
					local var_650_2 = 2 * (var_650_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_650_0.transform.localScale = Vector3.New(var_650_2 / var_650_1.sprite.bounds.size.y < var_650_2 * manager.ui.mainCameraCom_.aspect / var_650_1.sprite.bounds.size.x and var_650_2 * manager.ui.mainCameraCom_.aspect / var_650_1.sprite.bounds.size.x or var_650_2 / var_650_1.sprite.bounds.size.y, var_650_2 / var_650_1.sprite.bounds.size.y < var_650_2 * manager.ui.mainCameraCom_.aspect / var_650_1.sprite.bounds.size.x and var_650_2 * manager.ui.mainCameraCom_.aspect / var_650_1.sprite.bounds.size.x or var_650_2 / var_650_1.sprite.bounds.size.y, 0)
				end

				for iter_650_0, iter_650_1 in pairs(arg_647_1.bgs_) do
					if iter_650_0 ~= "ST0116a" then
						iter_650_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_650_3 = 0

			if 0 < arg_647_1.time_ and arg_647_1.time_ <= var_650_3 + arg_650_0 then
				arg_647_1.allBtn_.enabled = false
			end

			if arg_647_1.time_ >= var_650_3 + 0.3 and arg_647_1.time_ < var_650_3 + 0.3 + arg_650_0 then
				arg_647_1.allBtn_.enabled = true
			end

			local var_650_4 = 0

			if 0 < arg_647_1.time_ and arg_647_1.time_ <= var_650_4 + arg_650_0 then
				arg_647_1.mask_.enabled = true
				arg_647_1.mask_.raycastTarget = true

				arg_647_1:SetGaussion(false)
			end

			local var_650_5 = 2

			if var_650_4 <= arg_647_1.time_ and arg_647_1.time_ < var_650_4 + var_650_5 then
				local var_650_6 = Color.New(0, 0, 0)

				var_650_6.a = Mathf.Lerp(1, 0, (arg_647_1.time_ - var_650_4) / var_650_5)
				arg_647_1.mask_.color = var_650_6
			end

			if arg_647_1.time_ >= var_650_4 + var_650_5 and arg_647_1.time_ < var_650_4 + var_650_5 + arg_650_0 then
				local var_650_7 = Color.New(0, 0, 0)

				arg_647_1.mask_.enabled = false
				var_650_7.a = 0
				arg_647_1.mask_.color = var_650_7
			end

			local var_650_8 = arg_647_1.actors_["10102ui_story"]

			if 0 < arg_647_1.time_ and arg_647_1.time_ <= 0 + arg_650_0 and not isNil(var_650_8) and arg_647_1.var_.characterEffect10102ui_story == nil then
				arg_647_1.var_.characterEffect10102ui_story = var_650_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_650_9 = 0.200000002980232

			if 0 <= arg_647_1.time_ and arg_647_1.time_ < 0 + var_650_9 and not isNil(var_650_8) then
				if arg_647_1.var_.characterEffect10102ui_story and not isNil(var_650_8) then
					arg_647_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_647_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_647_1.time_ - 0) / var_650_9)
				end
			end

			if arg_647_1.time_ >= 0 + var_650_9 and arg_647_1.time_ < 0 + var_650_9 + arg_650_0 and not isNil(var_650_8) and arg_647_1.var_.characterEffect10102ui_story then
				arg_647_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_647_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			if 0 < arg_647_1.time_ and arg_647_1.time_ <= 0 + arg_650_0 then
				if arg_647_1.var_.effect5454 then
					Object.Destroy(arg_647_1.var_.effect5454)

					arg_647_1.var_.effect5454 = nil
				end
			end

			if 0 < arg_647_1.time_ and arg_647_1.time_ <= 0 + arg_650_0 then
				local var_650_11 = arg_647_1.var_.effect54543

				if not arg_647_1.var_.effect54543 then
					var_650_11 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_piaosan"), manager.ui.mainCamera.transform)
					var_650_11.name = "54543"
					arg_647_1.var_.effect54543 = var_650_11
				else
					var_650_11.transform:SetParent(var_650_9000)
				end

				var_650_11.transform.localPosition = Vector3.New(0, 0, 0)
				var_650_11.transform.localRotation = Quaternion.Euler(0, 0, 0)
				var_650_11.transform.localScale = Vector3.New(var_650_11.transform.localScale.x * (Screen.width / Screen.height / 1.7777777777777777), var_650_11.transform.localScale.y * Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1), var_650_11.transform.localScale.z)
			end

			local var_650_13 = arg_647_1.bgs_.ST0116a.transform

			if 0.0166666666666667 < arg_647_1.time_ and arg_647_1.time_ <= 0.0166666666666667 + arg_650_0 then
				arg_647_1.var_.moveOldPosST0116a = var_650_13.localPosition
			end

			local var_650_14 = 0.001

			if 0.0166666666666667 <= arg_647_1.time_ and arg_647_1.time_ < 0.0166666666666667 + var_650_14 then
				var_650_13.localPosition = Vector3.Lerp(arg_647_1.var_.moveOldPosST0116a, Vector3.New(0, 0.46, 4.83), (arg_647_1.time_ - 0.0166666666666667) / var_650_14)
			end

			if arg_647_1.time_ >= 0.0166666666666667 + var_650_14 and arg_647_1.time_ < 0.0166666666666667 + var_650_14 + arg_650_0 then
				var_650_13.localPosition = Vector3.New(0, 0.46, 4.83)
			end

			local var_650_15 = arg_647_1.bgs_.ST0116a.transform

			if 0.0333333333333333 < arg_647_1.time_ and arg_647_1.time_ <= 0.0333333333333333 + arg_650_0 then
				arg_647_1.var_.moveOldPosST0116a = var_650_15.localPosition
			end

			local var_650_16 = 2.66666666666567

			if 0.0333333333333333 <= arg_647_1.time_ and arg_647_1.time_ < 0.0333333333333333 + var_650_16 then
				var_650_15.localPosition = Vector3.Lerp(arg_647_1.var_.moveOldPosST0116a, Vector3.New(0, 1, 8.31), (arg_647_1.time_ - 0.0333333333333333) / var_650_16)
			end

			if arg_647_1.time_ >= 0.0333333333333333 + var_650_16 and arg_647_1.time_ < 0.0333333333333333 + var_650_16 + arg_650_0 then
				var_650_15.localPosition = Vector3.New(0, 1, 8.31)
			end

			if arg_647_1.frameCnt_ <= 1 then
				arg_647_1.dialog_:SetActive(false)
			end

			local var_650_17 = 1.83333333333333
			local var_650_18 = 1.45

			if 1.83333333333333 < arg_647_1.time_ and arg_647_1.time_ <= var_650_17 + arg_650_0 then
				arg_647_1.talkMaxDuration = 0

				arg_647_1.dialog_:SetActive(true)

				arg_647_1.dialogCg_.alpha = 0

				local var_650_19 = LeanTween.value(arg_647_1.dialog_, 0, 1, 0.3)

				var_650_19:setOnUpdate(LuaHelper.FloatAction(function(arg_651_0)
					arg_647_1.dialogCg_.alpha = arg_651_0
				end))
				var_650_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_647_1.dialog_)
					var_650_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_647_1.duration_ = arg_647_1.duration_ + 0.3

				SetActive(arg_647_1.leftNameGo_, false)

				arg_647_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_647_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_647_1:RecordName(arg_647_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_647_1.iconTrs_.gameObject, false)
				arg_647_1.callingController_:SetSelectedState("normal")

				local var_650_20 = arg_647_1:FormatText(arg_647_1:GetWordFromCfg(1108411156).content)

				arg_647_1.text_.text = var_650_20

				LuaForUtil.ClearLinePrefixSymbol(arg_647_1.text_)

				local var_650_22 = 58 <= 0 and var_650_18 or var_650_18 * (utf8.len(var_650_20) / 58)

				if (58 <= 0 and var_650_18 or var_650_18 * (utf8.len(var_650_20) / 58)) > 0 and var_650_18 < var_650_22 then
					arg_647_1.talkMaxDuration = var_650_22
					var_650_17 = var_650_17 + 0.3

					if var_650_22 + var_650_17 > arg_647_1.duration_ then
						arg_647_1.duration_ = var_650_22 + var_650_17
					end
				end

				arg_647_1.text_.text = var_650_20
				arg_647_1.typewritter.percent = 0

				arg_647_1.typewritter:SetDirty()
				arg_647_1:ShowNextGo(false)
				arg_647_1:RecordContent(arg_647_1.text_.text)
			end

			local var_650_23 = var_650_17 + 0.3
			local var_650_24 = math.max(var_650_18, arg_647_1.talkMaxDuration)

			if var_650_17 + 0.3 <= arg_647_1.time_ and arg_647_1.time_ < var_650_23 + var_650_24 then
				arg_647_1.typewritter.percent = (arg_647_1.time_ - var_650_23) / var_650_24

				arg_647_1.typewritter:SetDirty()
			end

			if arg_647_1.time_ >= var_650_23 + var_650_24 and arg_647_1.time_ < var_650_23 + var_650_24 + arg_650_0 then
				arg_647_1.typewritter.percent = 1

				arg_647_1.typewritter:SetDirty()
				arg_647_1:ShowNextGo(true)
			end
		end

		arg_647_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "ST0116a",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0.0166666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "ST0116a",
				changeDisplayLayer = false,
				needEase = false,
				duration = 2.66666666666567,
				className = "StoryMoveNode",
				startTime = 0.0333333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_647_1:InitPlayNodeList()
	end,
	Play1108411157 = function(arg_653_0, arg_653_1)
		arg_653_1.time_ = 0
		arg_653_1.frameCnt_ = 0
		arg_653_1.state_ = "playing"
		arg_653_1.curTalkId_ = 1108411157
		arg_653_1.duration_ = 5

		SetActive(arg_653_1.tipsGo_, false)

		function arg_653_1.onSingleLineFinish_()
			arg_653_1.onSingleLineUpdate_ = nil
			arg_653_1.onSingleLineFinish_ = nil
			arg_653_1.state_ = "waiting"
		end

		function arg_653_1.playNext_(arg_655_0)
			if arg_655_0 == 1 then
				arg_653_0:Play1108411158(arg_653_1)
			end
		end

		function arg_653_1.onSingleLineUpdate_(arg_656_0)
			local var_656_0 = 1.3

			if 0 < arg_653_1.time_ and arg_653_1.time_ <= 0 + arg_656_0 then
				arg_653_1.talkMaxDuration = 0
				arg_653_1.dialogCg_.alpha = 1

				arg_653_1.dialog_:SetActive(true)
				SetActive(arg_653_1.leftNameGo_, false)

				arg_653_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_653_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_653_1:RecordName(arg_653_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_653_1.iconTrs_.gameObject, false)
				arg_653_1.callingController_:SetSelectedState("normal")

				local var_656_1 = arg_653_1:FormatText(arg_653_1:GetWordFromCfg(1108411157).content)

				arg_653_1.text_.text = var_656_1

				LuaForUtil.ClearLinePrefixSymbol(arg_653_1.text_)

				local var_656_3 = 52 <= 0 and var_656_0 or var_656_0 * (utf8.len(var_656_1) / 52)

				if (52 <= 0 and var_656_0 or var_656_0 * (utf8.len(var_656_1) / 52)) > 0 and var_656_0 < var_656_3 then
					arg_653_1.talkMaxDuration = var_656_3

					if var_656_3 + 0 > arg_653_1.duration_ then
						arg_653_1.duration_ = var_656_3 + 0
					end
				end

				arg_653_1.text_.text = var_656_1
				arg_653_1.typewritter.percent = 0

				arg_653_1.typewritter:SetDirty()
				arg_653_1:ShowNextGo(false)
				arg_653_1:RecordContent(arg_653_1.text_.text)
			end

			local var_656_4 = math.max(var_656_0, arg_653_1.talkMaxDuration)

			if 0 <= arg_653_1.time_ and arg_653_1.time_ < 0 + var_656_4 then
				arg_653_1.typewritter.percent = (arg_653_1.time_ - 0) / var_656_4

				arg_653_1.typewritter:SetDirty()
			end

			if arg_653_1.time_ >= 0 + var_656_4 and arg_653_1.time_ < 0 + var_656_4 + arg_656_0 then
				arg_653_1.typewritter.percent = 1

				arg_653_1.typewritter:SetDirty()
				arg_653_1:ShowNextGo(true)
			end
		end

		arg_653_1.nodeConfigList_ = {}

		arg_653_1:InitPlayNodeList()
	end,
	Play1108411158 = function(arg_657_0, arg_657_1)
		arg_657_1.time_ = 0
		arg_657_1.frameCnt_ = 0
		arg_657_1.state_ = "playing"
		arg_657_1.curTalkId_ = 1108411158
		arg_657_1.duration_ = 5

		SetActive(arg_657_1.tipsGo_, false)

		function arg_657_1.onSingleLineFinish_()
			arg_657_1.onSingleLineUpdate_ = nil
			arg_657_1.onSingleLineFinish_ = nil
			arg_657_1.state_ = "waiting"
		end

		function arg_657_1.playNext_(arg_659_0)
			if arg_659_0 == 1 then
				arg_657_0:Play1108411159(arg_657_1)
			end
		end

		function arg_657_1.onSingleLineUpdate_(arg_660_0)
			local var_660_0 = 1.35

			if 0 < arg_657_1.time_ and arg_657_1.time_ <= 0 + arg_660_0 then
				arg_657_1.talkMaxDuration = 0
				arg_657_1.dialogCg_.alpha = 1

				arg_657_1.dialog_:SetActive(true)
				SetActive(arg_657_1.leftNameGo_, false)

				arg_657_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_657_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_657_1:RecordName(arg_657_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_657_1.iconTrs_.gameObject, false)
				arg_657_1.callingController_:SetSelectedState("normal")

				local var_660_1 = arg_657_1:FormatText(arg_657_1:GetWordFromCfg(1108411158).content)

				arg_657_1.text_.text = var_660_1

				LuaForUtil.ClearLinePrefixSymbol(arg_657_1.text_)

				local var_660_3 = 54 <= 0 and var_660_0 or var_660_0 * (utf8.len(var_660_1) / 54)

				if (54 <= 0 and var_660_0 or var_660_0 * (utf8.len(var_660_1) / 54)) > 0 and var_660_0 < var_660_3 then
					arg_657_1.talkMaxDuration = var_660_3

					if var_660_3 + 0 > arg_657_1.duration_ then
						arg_657_1.duration_ = var_660_3 + 0
					end
				end

				arg_657_1.text_.text = var_660_1
				arg_657_1.typewritter.percent = 0

				arg_657_1.typewritter:SetDirty()
				arg_657_1:ShowNextGo(false)
				arg_657_1:RecordContent(arg_657_1.text_.text)
			end

			local var_660_4 = math.max(var_660_0, arg_657_1.talkMaxDuration)

			if 0 <= arg_657_1.time_ and arg_657_1.time_ < 0 + var_660_4 then
				arg_657_1.typewritter.percent = (arg_657_1.time_ - 0) / var_660_4

				arg_657_1.typewritter:SetDirty()
			end

			if arg_657_1.time_ >= 0 + var_660_4 and arg_657_1.time_ < 0 + var_660_4 + arg_660_0 then
				arg_657_1.typewritter.percent = 1

				arg_657_1.typewritter:SetDirty()
				arg_657_1:ShowNextGo(true)
			end
		end

		arg_657_1.nodeConfigList_ = {}

		arg_657_1:InitPlayNodeList()
	end,
	Play1108411159 = function(arg_661_0, arg_661_1)
		arg_661_1.time_ = 0
		arg_661_1.frameCnt_ = 0
		arg_661_1.state_ = "playing"
		arg_661_1.curTalkId_ = 1108411159
		arg_661_1.duration_ = 5

		SetActive(arg_661_1.tipsGo_, false)

		function arg_661_1.onSingleLineFinish_()
			arg_661_1.onSingleLineUpdate_ = nil
			arg_661_1.onSingleLineFinish_ = nil
			arg_661_1.state_ = "waiting"
		end

		function arg_661_1.playNext_(arg_663_0)
			if arg_663_0 == 1 then
				arg_661_0:Play1108411160(arg_661_1)
			end
		end

		function arg_661_1.onSingleLineUpdate_(arg_664_0)
			local var_664_0 = 0.175

			if 0 < arg_661_1.time_ and arg_661_1.time_ <= 0 + arg_664_0 then
				arg_661_1.talkMaxDuration = 0
				arg_661_1.dialogCg_.alpha = 1

				arg_661_1.dialog_:SetActive(true)
				SetActive(arg_661_1.leftNameGo_, true)

				arg_661_1.leftNameTxt_.text = arg_661_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_661_1.leftNameTxt_.transform)

				arg_661_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_661_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_661_1:RecordName(arg_661_1.leftNameTxt_.text)
				SetActive(arg_661_1.iconTrs_.gameObject, true)
				arg_661_1.iconController_:SetSelectedState("hero")

				arg_661_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_661_1.callingController_:SetSelectedState("normal")

				arg_661_1.keyicon_.color = Color.New(1, 1, 1)
				arg_661_1.icon_.color = Color.New(1, 1, 1)

				local var_664_1 = arg_661_1:FormatText(arg_661_1:GetWordFromCfg(1108411159).content)

				arg_661_1.text_.text = var_664_1

				LuaForUtil.ClearLinePrefixSymbol(arg_661_1.text_)

				local var_664_3 = 7 <= 0 and var_664_0 or var_664_0 * (utf8.len(var_664_1) / 7)

				if (7 <= 0 and var_664_0 or var_664_0 * (utf8.len(var_664_1) / 7)) > 0 and var_664_0 < var_664_3 then
					arg_661_1.talkMaxDuration = var_664_3

					if var_664_3 + 0 > arg_661_1.duration_ then
						arg_661_1.duration_ = var_664_3 + 0
					end
				end

				arg_661_1.text_.text = var_664_1
				arg_661_1.typewritter.percent = 0

				arg_661_1.typewritter:SetDirty()
				arg_661_1:ShowNextGo(false)
				arg_661_1:RecordContent(arg_661_1.text_.text)
			end

			local var_664_4 = math.max(var_664_0, arg_661_1.talkMaxDuration)

			if 0 <= arg_661_1.time_ and arg_661_1.time_ < 0 + var_664_4 then
				arg_661_1.typewritter.percent = (arg_661_1.time_ - 0) / var_664_4

				arg_661_1.typewritter:SetDirty()
			end

			if arg_661_1.time_ >= 0 + var_664_4 and arg_661_1.time_ < 0 + var_664_4 + arg_664_0 then
				arg_661_1.typewritter.percent = 1

				arg_661_1.typewritter:SetDirty()
				arg_661_1:ShowNextGo(true)
			end
		end

		arg_661_1.nodeConfigList_ = {}

		arg_661_1:InitPlayNodeList()
	end,
	Play1108411160 = function(arg_665_0, arg_665_1)
		arg_665_1.time_ = 0
		arg_665_1.frameCnt_ = 0
		arg_665_1.state_ = "playing"
		arg_665_1.curTalkId_ = 1108411160
		arg_665_1.duration_ = 2.5

		local var_665_0 = {
			zh = 2.5,
			ja = 1.999999999999
		}
		local var_665_1 = manager.audio:GetLocalizationFlag()

		if var_665_0[var_665_1] ~= nil then
			arg_665_1.duration_ = var_665_0[var_665_1]
		end

		SetActive(arg_665_1.tipsGo_, false)

		function arg_665_1.onSingleLineFinish_()
			arg_665_1.onSingleLineUpdate_ = nil
			arg_665_1.onSingleLineFinish_ = nil
			arg_665_1.state_ = "waiting"
		end

		function arg_665_1.playNext_(arg_667_0)
			if arg_667_0 == 1 then
				arg_665_0:Play1108411161(arg_665_1)
			end
		end

		function arg_665_1.onSingleLineUpdate_(arg_668_0)
			if 0 < arg_665_1.time_ and arg_665_1.time_ <= 0 + arg_668_0 then
				arg_665_1.var_.moveOldPos10102ui_story = arg_665_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_668_0 = 0.001

			if 0 <= arg_665_1.time_ and arg_665_1.time_ < 0 + var_668_0 then
				arg_665_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_665_1.var_.moveOldPos10102ui_story, Vector3.New(0, -0.985, -6.275), (arg_665_1.time_ - 0) / var_668_0)
				arg_665_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_665_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_665_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_665_1.actors_["10102ui_story"].transform.position).z)
				arg_665_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_665_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_665_1.actors_["10102ui_story"].transform.localEulerAngles = arg_665_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_665_1.time_ >= 0 + var_668_0 and arg_665_1.time_ < 0 + var_668_0 + arg_668_0 then
				arg_665_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6.275)
				arg_665_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_665_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_665_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_665_1.actors_["10102ui_story"].transform.position).z)
				arg_665_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_665_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_665_1.actors_["10102ui_story"].transform.localEulerAngles = arg_665_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_668_1 = arg_665_1.actors_["10102ui_story"]

			if 0 < arg_665_1.time_ and arg_665_1.time_ <= 0 + arg_668_0 and not isNil(var_668_1) and arg_665_1.var_.characterEffect10102ui_story == nil then
				arg_665_1.var_.characterEffect10102ui_story = var_668_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_668_2 = 0.200000002980232

			if 0 <= arg_665_1.time_ and arg_665_1.time_ < 0 + var_668_2 and not isNil(var_668_1) then
				if arg_665_1.var_.characterEffect10102ui_story and not isNil(var_668_1) then
					arg_665_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_665_1.time_ >= 0 + var_668_2 and arg_665_1.time_ < 0 + var_668_2 + arg_668_0 and not isNil(var_668_1) and arg_665_1.var_.characterEffect10102ui_story then
				arg_665_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_665_1.time_ and arg_665_1.time_ <= 0 + arg_668_0 then
				arg_665_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action5_1")
			end

			if 0 < arg_665_1.time_ and arg_665_1.time_ <= 0 + arg_668_0 then
				arg_665_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_deyiA", "EmotionTimelineAnimator")
			end

			local var_668_4 = 0
			local var_668_5 = 0.45

			if 0 < arg_665_1.time_ and arg_665_1.time_ <= var_668_4 + arg_668_0 then
				arg_665_1.talkMaxDuration = 0
				arg_665_1.dialogCg_.alpha = 1

				arg_665_1.dialog_:SetActive(true)
				SetActive(arg_665_1.leftNameGo_, true)

				arg_665_1.leftNameTxt_.text = arg_665_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_665_1.leftNameTxt_.transform)

				arg_665_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_665_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_665_1:RecordName(arg_665_1.leftNameTxt_.text)
				SetActive(arg_665_1.iconTrs_.gameObject, false)
				arg_665_1.callingController_:SetSelectedState("normal")

				local var_668_6 = arg_665_1:GetWordFromCfg(1108411160)
				local var_668_7 = arg_665_1:FormatText(var_668_6.content)

				arg_665_1.text_.text = var_668_7

				LuaForUtil.ClearLinePrefixSymbol(arg_665_1.text_)

				local var_668_9 = 18 <= 0 and var_668_5 or var_668_5 * (utf8.len(var_668_7) / 18)

				if (18 <= 0 and var_668_5 or var_668_5 * (utf8.len(var_668_7) / 18)) > 0 and var_668_5 < var_668_9 then
					arg_665_1.talkMaxDuration = var_668_9

					if var_668_9 + var_668_4 > arg_665_1.duration_ then
						arg_665_1.duration_ = var_668_9 + var_668_4
					end
				end

				arg_665_1.text_.text = var_668_7
				arg_665_1.typewritter.percent = 0

				arg_665_1.typewritter:SetDirty()
				arg_665_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411160", "story_v_side_new_1108411.awb") ~= 0 then
					local var_668_10 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411160", "story_v_side_new_1108411.awb") / 1000

					if var_668_10 + var_668_4 > arg_665_1.duration_ then
						arg_665_1.duration_ = var_668_10 + var_668_4
					end

					if var_668_6.prefab_name ~= "" and arg_665_1.actors_[var_668_6.prefab_name] ~= nil then
						local var_668_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_665_1.actors_[var_668_6.prefab_name].transform, "story_v_side_new_1108411", "1108411160", "story_v_side_new_1108411.awb")

						arg_665_1:RecordAudio("1108411160", var_668_11)
						arg_665_1:RecordAudio("1108411160", var_668_11)
					else
						arg_665_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411160", "story_v_side_new_1108411.awb")
					end

					arg_665_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411160", "story_v_side_new_1108411.awb")
				end

				arg_665_1:RecordContent(arg_665_1.text_.text)
			end

			local var_668_12 = math.max(var_668_5, arg_665_1.talkMaxDuration)

			if var_668_4 <= arg_665_1.time_ and arg_665_1.time_ < var_668_4 + var_668_12 then
				arg_665_1.typewritter.percent = (arg_665_1.time_ - var_668_4) / var_668_12

				arg_665_1.typewritter:SetDirty()
			end

			if arg_665_1.time_ >= var_668_4 + var_668_12 and arg_665_1.time_ < var_668_4 + var_668_12 + arg_668_0 then
				arg_665_1.typewritter.percent = 1

				arg_665_1.typewritter:SetDirty()
				arg_665_1:ShowNextGo(true)
			end
		end

		arg_665_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_665_1:InitPlayNodeList()
	end,
	Play1108411161 = function(arg_669_0, arg_669_1)
		arg_669_1.time_ = 0
		arg_669_1.frameCnt_ = 0
		arg_669_1.state_ = "playing"
		arg_669_1.curTalkId_ = 1108411161
		arg_669_1.duration_ = 5

		SetActive(arg_669_1.tipsGo_, false)

		function arg_669_1.onSingleLineFinish_()
			arg_669_1.onSingleLineUpdate_ = nil
			arg_669_1.onSingleLineFinish_ = nil
			arg_669_1.state_ = "waiting"
		end

		function arg_669_1.playNext_(arg_671_0)
			if arg_671_0 == 1 then
				arg_669_0:Play1108411162(arg_669_1)
			end
		end

		function arg_669_1.onSingleLineUpdate_(arg_672_0)
			if 0 < arg_669_1.time_ and arg_669_1.time_ <= 0 + arg_672_0 and not isNil(arg_669_1.actors_["10102ui_story"]) and arg_669_1.var_.characterEffect10102ui_story == nil then
				arg_669_1.var_.characterEffect10102ui_story = arg_669_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_672_0 = 0.200000002980232

			if 0 <= arg_669_1.time_ and arg_669_1.time_ < 0 + var_672_0 and not isNil(arg_669_1.actors_["10102ui_story"]) then
				if arg_669_1.var_.characterEffect10102ui_story and not isNil(arg_669_1.actors_["10102ui_story"]) then
					arg_669_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_669_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_669_1.time_ - 0) / var_672_0)
				end
			end

			if arg_669_1.time_ >= 0 + var_672_0 and arg_669_1.time_ < 0 + var_672_0 + arg_672_0 and not isNil(arg_669_1.actors_["10102ui_story"]) and arg_669_1.var_.characterEffect10102ui_story then
				arg_669_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_669_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_672_1 = 0
			local var_672_2 = 0.55

			if 0 < arg_669_1.time_ and arg_669_1.time_ <= var_672_1 + arg_672_0 then
				arg_669_1.talkMaxDuration = 0
				arg_669_1.dialogCg_.alpha = 1

				arg_669_1.dialog_:SetActive(true)
				SetActive(arg_669_1.leftNameGo_, true)

				arg_669_1.leftNameTxt_.text = arg_669_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_669_1.leftNameTxt_.transform)

				arg_669_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_669_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_669_1:RecordName(arg_669_1.leftNameTxt_.text)
				SetActive(arg_669_1.iconTrs_.gameObject, true)
				arg_669_1.iconController_:SetSelectedState("hero")

				arg_669_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_669_1.callingController_:SetSelectedState("normal")

				arg_669_1.keyicon_.color = Color.New(1, 1, 1)
				arg_669_1.icon_.color = Color.New(1, 1, 1)

				local var_672_3 = arg_669_1:FormatText(arg_669_1:GetWordFromCfg(1108411161).content)

				arg_669_1.text_.text = var_672_3

				LuaForUtil.ClearLinePrefixSymbol(arg_669_1.text_)

				local var_672_5 = 22 <= 0 and var_672_2 or var_672_2 * (utf8.len(var_672_3) / 22)

				if (22 <= 0 and var_672_2 or var_672_2 * (utf8.len(var_672_3) / 22)) > 0 and var_672_2 < var_672_5 then
					arg_669_1.talkMaxDuration = var_672_5

					if var_672_5 + var_672_1 > arg_669_1.duration_ then
						arg_669_1.duration_ = var_672_5 + var_672_1
					end
				end

				arg_669_1.text_.text = var_672_3
				arg_669_1.typewritter.percent = 0

				arg_669_1.typewritter:SetDirty()
				arg_669_1:ShowNextGo(false)
				arg_669_1:RecordContent(arg_669_1.text_.text)
			end

			local var_672_6 = math.max(var_672_2, arg_669_1.talkMaxDuration)

			if var_672_1 <= arg_669_1.time_ and arg_669_1.time_ < var_672_1 + var_672_6 then
				arg_669_1.typewritter.percent = (arg_669_1.time_ - var_672_1) / var_672_6

				arg_669_1.typewritter:SetDirty()
			end

			if arg_669_1.time_ >= var_672_1 + var_672_6 and arg_669_1.time_ < var_672_1 + var_672_6 + arg_672_0 then
				arg_669_1.typewritter.percent = 1

				arg_669_1.typewritter:SetDirty()
				arg_669_1:ShowNextGo(true)
			end
		end

		arg_669_1.nodeConfigList_ = {}

		arg_669_1:InitPlayNodeList()
	end,
	Play1108411162 = function(arg_673_0, arg_673_1)
		arg_673_1.time_ = 0
		arg_673_1.frameCnt_ = 0
		arg_673_1.state_ = "playing"
		arg_673_1.curTalkId_ = 1108411162
		arg_673_1.duration_ = 3.03

		local var_673_0 = {
			zh = 3,
			ja = 3.033
		}
		local var_673_1 = manager.audio:GetLocalizationFlag()

		if var_673_0[var_673_1] ~= nil then
			arg_673_1.duration_ = var_673_0[var_673_1]
		end

		SetActive(arg_673_1.tipsGo_, false)

		function arg_673_1.onSingleLineFinish_()
			arg_673_1.onSingleLineUpdate_ = nil
			arg_673_1.onSingleLineFinish_ = nil
			arg_673_1.state_ = "waiting"
		end

		function arg_673_1.playNext_(arg_675_0)
			if arg_675_0 == 1 then
				arg_673_0:Play1108411163(arg_673_1)
			end
		end

		function arg_673_1.onSingleLineUpdate_(arg_676_0)
			if 0 < arg_673_1.time_ and arg_673_1.time_ <= 0 + arg_676_0 and not isNil(arg_673_1.actors_["10102ui_story"]) and arg_673_1.var_.characterEffect10102ui_story == nil then
				arg_673_1.var_.characterEffect10102ui_story = arg_673_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_676_0 = 0.200000002980232

			if 0 <= arg_673_1.time_ and arg_673_1.time_ < 0 + var_676_0 and not isNil(arg_673_1.actors_["10102ui_story"]) then
				if arg_673_1.var_.characterEffect10102ui_story and not isNil(arg_673_1.actors_["10102ui_story"]) then
					arg_673_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_673_1.time_ >= 0 + var_676_0 and arg_673_1.time_ < 0 + var_676_0 + arg_676_0 and not isNil(arg_673_1.actors_["10102ui_story"]) and arg_673_1.var_.characterEffect10102ui_story then
				arg_673_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_673_1.time_ and arg_673_1.time_ <= 0 + arg_676_0 then
				arg_673_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102actionlink/10102action453")
			end

			if 0 < arg_673_1.time_ and arg_673_1.time_ <= 0 + arg_676_0 then
				arg_673_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_676_2 = 0
			local var_676_3 = 0.3

			if 0 < arg_673_1.time_ and arg_673_1.time_ <= var_676_2 + arg_676_0 then
				arg_673_1.talkMaxDuration = 0
				arg_673_1.dialogCg_.alpha = 1

				arg_673_1.dialog_:SetActive(true)
				SetActive(arg_673_1.leftNameGo_, true)

				arg_673_1.leftNameTxt_.text = arg_673_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_673_1.leftNameTxt_.transform)

				arg_673_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_673_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_673_1:RecordName(arg_673_1.leftNameTxt_.text)
				SetActive(arg_673_1.iconTrs_.gameObject, false)
				arg_673_1.callingController_:SetSelectedState("normal")

				local var_676_4 = arg_673_1:GetWordFromCfg(1108411162)
				local var_676_5 = arg_673_1:FormatText(var_676_4.content)

				arg_673_1.text_.text = var_676_5

				LuaForUtil.ClearLinePrefixSymbol(arg_673_1.text_)

				local var_676_7 = 12 <= 0 and var_676_3 or var_676_3 * (utf8.len(var_676_5) / 12)

				if (12 <= 0 and var_676_3 or var_676_3 * (utf8.len(var_676_5) / 12)) > 0 and var_676_3 < var_676_7 then
					arg_673_1.talkMaxDuration = var_676_7

					if var_676_7 + var_676_2 > arg_673_1.duration_ then
						arg_673_1.duration_ = var_676_7 + var_676_2
					end
				end

				arg_673_1.text_.text = var_676_5
				arg_673_1.typewritter.percent = 0

				arg_673_1.typewritter:SetDirty()
				arg_673_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411162", "story_v_side_new_1108411.awb") ~= 0 then
					local var_676_8 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411162", "story_v_side_new_1108411.awb") / 1000

					if var_676_8 + var_676_2 > arg_673_1.duration_ then
						arg_673_1.duration_ = var_676_8 + var_676_2
					end

					if var_676_4.prefab_name ~= "" and arg_673_1.actors_[var_676_4.prefab_name] ~= nil then
						local var_676_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_673_1.actors_[var_676_4.prefab_name].transform, "story_v_side_new_1108411", "1108411162", "story_v_side_new_1108411.awb")

						arg_673_1:RecordAudio("1108411162", var_676_9)
						arg_673_1:RecordAudio("1108411162", var_676_9)
					else
						arg_673_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411162", "story_v_side_new_1108411.awb")
					end

					arg_673_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411162", "story_v_side_new_1108411.awb")
				end

				arg_673_1:RecordContent(arg_673_1.text_.text)
			end

			local var_676_10 = math.max(var_676_3, arg_673_1.talkMaxDuration)

			if var_676_2 <= arg_673_1.time_ and arg_673_1.time_ < var_676_2 + var_676_10 then
				arg_673_1.typewritter.percent = (arg_673_1.time_ - var_676_2) / var_676_10

				arg_673_1.typewritter:SetDirty()
			end

			if arg_673_1.time_ >= var_676_2 + var_676_10 and arg_673_1.time_ < var_676_2 + var_676_10 + arg_676_0 then
				arg_673_1.typewritter.percent = 1

				arg_673_1.typewritter:SetDirty()
				arg_673_1:ShowNextGo(true)
			end
		end

		arg_673_1.nodeConfigList_ = {}

		arg_673_1:InitPlayNodeList()
	end,
	Play1108411163 = function(arg_677_0, arg_677_1)
		arg_677_1.time_ = 0
		arg_677_1.frameCnt_ = 0
		arg_677_1.state_ = "playing"
		arg_677_1.curTalkId_ = 1108411163
		arg_677_1.duration_ = 5

		SetActive(arg_677_1.tipsGo_, false)

		function arg_677_1.onSingleLineFinish_()
			arg_677_1.onSingleLineUpdate_ = nil
			arg_677_1.onSingleLineFinish_ = nil
			arg_677_1.state_ = "waiting"
		end

		function arg_677_1.playNext_(arg_679_0)
			if arg_679_0 == 1 then
				arg_677_0:Play1108411164(arg_677_1)
			end
		end

		function arg_677_1.onSingleLineUpdate_(arg_680_0)
			if 0 < arg_677_1.time_ and arg_677_1.time_ <= 0 + arg_680_0 and not isNil(arg_677_1.actors_["10102ui_story"]) and arg_677_1.var_.characterEffect10102ui_story == nil then
				arg_677_1.var_.characterEffect10102ui_story = arg_677_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_680_0 = 0.200000002980232

			if 0 <= arg_677_1.time_ and arg_677_1.time_ < 0 + var_680_0 and not isNil(arg_677_1.actors_["10102ui_story"]) then
				if arg_677_1.var_.characterEffect10102ui_story and not isNil(arg_677_1.actors_["10102ui_story"]) then
					arg_677_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_677_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_677_1.time_ - 0) / var_680_0)
				end
			end

			if arg_677_1.time_ >= 0 + var_680_0 and arg_677_1.time_ < 0 + var_680_0 + arg_680_0 and not isNil(arg_677_1.actors_["10102ui_story"]) and arg_677_1.var_.characterEffect10102ui_story then
				arg_677_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_677_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_680_1 = 0
			local var_680_2 = 0.2

			if 0 < arg_677_1.time_ and arg_677_1.time_ <= var_680_1 + arg_680_0 then
				arg_677_1.talkMaxDuration = 0
				arg_677_1.dialogCg_.alpha = 1

				arg_677_1.dialog_:SetActive(true)
				SetActive(arg_677_1.leftNameGo_, true)

				arg_677_1.leftNameTxt_.text = arg_677_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_677_1.leftNameTxt_.transform)

				arg_677_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_677_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_677_1:RecordName(arg_677_1.leftNameTxt_.text)
				SetActive(arg_677_1.iconTrs_.gameObject, true)
				arg_677_1.iconController_:SetSelectedState("hero")

				arg_677_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_677_1.callingController_:SetSelectedState("normal")

				arg_677_1.keyicon_.color = Color.New(1, 1, 1)
				arg_677_1.icon_.color = Color.New(1, 1, 1)

				local var_680_3 = arg_677_1:FormatText(arg_677_1:GetWordFromCfg(1108411163).content)

				arg_677_1.text_.text = var_680_3

				LuaForUtil.ClearLinePrefixSymbol(arg_677_1.text_)

				local var_680_5 = 8 <= 0 and var_680_2 or var_680_2 * (utf8.len(var_680_3) / 8)

				if (8 <= 0 and var_680_2 or var_680_2 * (utf8.len(var_680_3) / 8)) > 0 and var_680_2 < var_680_5 then
					arg_677_1.talkMaxDuration = var_680_5

					if var_680_5 + var_680_1 > arg_677_1.duration_ then
						arg_677_1.duration_ = var_680_5 + var_680_1
					end
				end

				arg_677_1.text_.text = var_680_3
				arg_677_1.typewritter.percent = 0

				arg_677_1.typewritter:SetDirty()
				arg_677_1:ShowNextGo(false)
				arg_677_1:RecordContent(arg_677_1.text_.text)
			end

			local var_680_6 = math.max(var_680_2, arg_677_1.talkMaxDuration)

			if var_680_1 <= arg_677_1.time_ and arg_677_1.time_ < var_680_1 + var_680_6 then
				arg_677_1.typewritter.percent = (arg_677_1.time_ - var_680_1) / var_680_6

				arg_677_1.typewritter:SetDirty()
			end

			if arg_677_1.time_ >= var_680_1 + var_680_6 and arg_677_1.time_ < var_680_1 + var_680_6 + arg_680_0 then
				arg_677_1.typewritter.percent = 1

				arg_677_1.typewritter:SetDirty()
				arg_677_1:ShowNextGo(true)
			end
		end

		arg_677_1.nodeConfigList_ = {}

		arg_677_1:InitPlayNodeList()
	end,
	Play1108411164 = function(arg_681_0, arg_681_1)
		arg_681_1.time_ = 0
		arg_681_1.frameCnt_ = 0
		arg_681_1.state_ = "playing"
		arg_681_1.curTalkId_ = 1108411164
		arg_681_1.duration_ = 5

		SetActive(arg_681_1.tipsGo_, false)

		function arg_681_1.onSingleLineFinish_()
			arg_681_1.onSingleLineUpdate_ = nil
			arg_681_1.onSingleLineFinish_ = nil
			arg_681_1.state_ = "waiting"
		end

		function arg_681_1.playNext_(arg_683_0)
			if arg_683_0 == 1 then
				arg_681_0:Play1108411165(arg_681_1)
			end
		end

		function arg_681_1.onSingleLineUpdate_(arg_684_0)
			if 0 < arg_681_1.time_ and arg_681_1.time_ <= 0 + arg_684_0 then
				arg_681_1.var_.moveOldPos10102ui_story = arg_681_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_684_0 = 0.001

			if 0 <= arg_681_1.time_ and arg_681_1.time_ < 0 + var_684_0 then
				arg_681_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_681_1.var_.moveOldPos10102ui_story, Vector3.New(0, 100, 0), (arg_681_1.time_ - 0) / var_684_0)
				arg_681_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_681_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_681_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_681_1.actors_["10102ui_story"].transform.position).z)
				arg_681_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_681_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_681_1.actors_["10102ui_story"].transform.localEulerAngles = arg_681_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_681_1.time_ >= 0 + var_684_0 and arg_681_1.time_ < 0 + var_684_0 + arg_684_0 then
				arg_681_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_681_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_681_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_681_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_681_1.actors_["10102ui_story"].transform.position).z)
				arg_681_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_681_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_681_1.actors_["10102ui_story"].transform.localEulerAngles = arg_681_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_684_1 = 0
			local var_684_2 = 1.275

			if 0 < arg_681_1.time_ and arg_681_1.time_ <= var_684_1 + arg_684_0 then
				arg_681_1.talkMaxDuration = 0
				arg_681_1.dialogCg_.alpha = 1

				arg_681_1.dialog_:SetActive(true)
				SetActive(arg_681_1.leftNameGo_, false)

				arg_681_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_681_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_681_1:RecordName(arg_681_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_681_1.iconTrs_.gameObject, false)
				arg_681_1.callingController_:SetSelectedState("normal")

				local var_684_3 = arg_681_1:FormatText(arg_681_1:GetWordFromCfg(1108411164).content)

				arg_681_1.text_.text = var_684_3

				LuaForUtil.ClearLinePrefixSymbol(arg_681_1.text_)

				local var_684_5 = 51 <= 0 and var_684_2 or var_684_2 * (utf8.len(var_684_3) / 51)

				if (51 <= 0 and var_684_2 or var_684_2 * (utf8.len(var_684_3) / 51)) > 0 and var_684_2 < var_684_5 then
					arg_681_1.talkMaxDuration = var_684_5

					if var_684_5 + var_684_1 > arg_681_1.duration_ then
						arg_681_1.duration_ = var_684_5 + var_684_1
					end
				end

				arg_681_1.text_.text = var_684_3
				arg_681_1.typewritter.percent = 0

				arg_681_1.typewritter:SetDirty()
				arg_681_1:ShowNextGo(false)
				arg_681_1:RecordContent(arg_681_1.text_.text)
			end

			local var_684_6 = math.max(var_684_2, arg_681_1.talkMaxDuration)

			if var_684_1 <= arg_681_1.time_ and arg_681_1.time_ < var_684_1 + var_684_6 then
				arg_681_1.typewritter.percent = (arg_681_1.time_ - var_684_1) / var_684_6

				arg_681_1.typewritter:SetDirty()
			end

			if arg_681_1.time_ >= var_684_1 + var_684_6 and arg_681_1.time_ < var_684_1 + var_684_6 + arg_684_0 then
				arg_681_1.typewritter.percent = 1

				arg_681_1.typewritter:SetDirty()
				arg_681_1:ShowNextGo(true)
			end
		end

		arg_681_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_681_1:InitPlayNodeList()
	end,
	Play1108411165 = function(arg_685_0, arg_685_1)
		arg_685_1.time_ = 0
		arg_685_1.frameCnt_ = 0
		arg_685_1.state_ = "playing"
		arg_685_1.curTalkId_ = 1108411165
		arg_685_1.duration_ = 5

		SetActive(arg_685_1.tipsGo_, false)

		function arg_685_1.onSingleLineFinish_()
			arg_685_1.onSingleLineUpdate_ = nil
			arg_685_1.onSingleLineFinish_ = nil
			arg_685_1.state_ = "waiting"
		end

		function arg_685_1.playNext_(arg_687_0)
			if arg_687_0 == 1 then
				arg_685_0:Play1108411166(arg_685_1)
			end
		end

		function arg_685_1.onSingleLineUpdate_(arg_688_0)
			local var_688_0 = 0.2

			if 0 < arg_685_1.time_ and arg_685_1.time_ <= 0 + arg_688_0 then
				arg_685_1.talkMaxDuration = 0
				arg_685_1.dialogCg_.alpha = 1

				arg_685_1.dialog_:SetActive(true)
				SetActive(arg_685_1.leftNameGo_, true)

				arg_685_1.leftNameTxt_.text = arg_685_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_685_1.leftNameTxt_.transform)

				arg_685_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_685_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_685_1:RecordName(arg_685_1.leftNameTxt_.text)
				SetActive(arg_685_1.iconTrs_.gameObject, true)
				arg_685_1.iconController_:SetSelectedState("hero")

				arg_685_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_685_1.callingController_:SetSelectedState("normal")

				arg_685_1.keyicon_.color = Color.New(1, 1, 1)
				arg_685_1.icon_.color = Color.New(1, 1, 1)

				local var_688_1 = arg_685_1:FormatText(arg_685_1:GetWordFromCfg(1108411165).content)

				arg_685_1.text_.text = var_688_1

				LuaForUtil.ClearLinePrefixSymbol(arg_685_1.text_)

				local var_688_3 = 8 <= 0 and var_688_0 or var_688_0 * (utf8.len(var_688_1) / 8)

				if (8 <= 0 and var_688_0 or var_688_0 * (utf8.len(var_688_1) / 8)) > 0 and var_688_0 < var_688_3 then
					arg_685_1.talkMaxDuration = var_688_3

					if var_688_3 + 0 > arg_685_1.duration_ then
						arg_685_1.duration_ = var_688_3 + 0
					end
				end

				arg_685_1.text_.text = var_688_1
				arg_685_1.typewritter.percent = 0

				arg_685_1.typewritter:SetDirty()
				arg_685_1:ShowNextGo(false)
				arg_685_1:RecordContent(arg_685_1.text_.text)
			end

			local var_688_4 = math.max(var_688_0, arg_685_1.talkMaxDuration)

			if 0 <= arg_685_1.time_ and arg_685_1.time_ < 0 + var_688_4 then
				arg_685_1.typewritter.percent = (arg_685_1.time_ - 0) / var_688_4

				arg_685_1.typewritter:SetDirty()
			end

			if arg_685_1.time_ >= 0 + var_688_4 and arg_685_1.time_ < 0 + var_688_4 + arg_688_0 then
				arg_685_1.typewritter.percent = 1

				arg_685_1.typewritter:SetDirty()
				arg_685_1:ShowNextGo(true)
			end
		end

		arg_685_1.nodeConfigList_ = {}

		arg_685_1:InitPlayNodeList()
	end,
	Play1108411166 = function(arg_689_0, arg_689_1)
		arg_689_1.time_ = 0
		arg_689_1.frameCnt_ = 0
		arg_689_1.state_ = "playing"
		arg_689_1.curTalkId_ = 1108411166
		arg_689_1.duration_ = 6.73

		local var_689_0 = {
			zh = 6.266,
			ja = 6.733
		}
		local var_689_1 = manager.audio:GetLocalizationFlag()

		if var_689_0[var_689_1] ~= nil then
			arg_689_1.duration_ = var_689_0[var_689_1]
		end

		SetActive(arg_689_1.tipsGo_, false)

		function arg_689_1.onSingleLineFinish_()
			arg_689_1.onSingleLineUpdate_ = nil
			arg_689_1.onSingleLineFinish_ = nil
			arg_689_1.state_ = "waiting"
		end

		function arg_689_1.playNext_(arg_691_0)
			if arg_691_0 == 1 then
				arg_689_0:Play1108411167(arg_689_1)
			end
		end

		function arg_689_1.onSingleLineUpdate_(arg_692_0)
			if 0 < arg_689_1.time_ and arg_689_1.time_ <= 0 + arg_692_0 then
				arg_689_1.var_.moveOldPos10102ui_story = arg_689_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_692_0 = 0.001

			if 0 <= arg_689_1.time_ and arg_689_1.time_ < 0 + var_692_0 then
				arg_689_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_689_1.var_.moveOldPos10102ui_story, Vector3.New(0, -0.985, -6.275), (arg_689_1.time_ - 0) / var_692_0)
				arg_689_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_689_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_689_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_689_1.actors_["10102ui_story"].transform.position).z)
				arg_689_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_689_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_689_1.actors_["10102ui_story"].transform.localEulerAngles = arg_689_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_689_1.time_ >= 0 + var_692_0 and arg_689_1.time_ < 0 + var_692_0 + arg_692_0 then
				arg_689_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6.275)
				arg_689_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_689_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_689_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_689_1.actors_["10102ui_story"].transform.position).z)
				arg_689_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_689_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_689_1.actors_["10102ui_story"].transform.localEulerAngles = arg_689_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_692_1 = arg_689_1.actors_["10102ui_story"]

			if 0 < arg_689_1.time_ and arg_689_1.time_ <= 0 + arg_692_0 and not isNil(var_692_1) and arg_689_1.var_.characterEffect10102ui_story == nil then
				arg_689_1.var_.characterEffect10102ui_story = var_692_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_692_2 = 0.200000002980232

			if 0 <= arg_689_1.time_ and arg_689_1.time_ < 0 + var_692_2 and not isNil(var_692_1) then
				if arg_689_1.var_.characterEffect10102ui_story and not isNil(var_692_1) then
					arg_689_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_689_1.time_ >= 0 + var_692_2 and arg_689_1.time_ < 0 + var_692_2 + arg_692_0 and not isNil(var_692_1) and arg_689_1.var_.characterEffect10102ui_story then
				arg_689_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_689_1.time_ and arg_689_1.time_ <= 0 + arg_692_0 then
				arg_689_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action3_2")
			end

			if 0 < arg_689_1.time_ and arg_689_1.time_ <= 0 + arg_692_0 then
				arg_689_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileC_biyan", "EmotionTimelineAnimator")
			end

			local var_692_4 = 0
			local var_692_5 = 0.75

			if 0 < arg_689_1.time_ and arg_689_1.time_ <= var_692_4 + arg_692_0 then
				arg_689_1.talkMaxDuration = 0
				arg_689_1.dialogCg_.alpha = 1

				arg_689_1.dialog_:SetActive(true)
				SetActive(arg_689_1.leftNameGo_, true)

				arg_689_1.leftNameTxt_.text = arg_689_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_689_1.leftNameTxt_.transform)

				arg_689_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_689_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_689_1:RecordName(arg_689_1.leftNameTxt_.text)
				SetActive(arg_689_1.iconTrs_.gameObject, false)
				arg_689_1.callingController_:SetSelectedState("normal")

				local var_692_6 = arg_689_1:GetWordFromCfg(1108411166)
				local var_692_7 = arg_689_1:FormatText(var_692_6.content)

				arg_689_1.text_.text = var_692_7

				LuaForUtil.ClearLinePrefixSymbol(arg_689_1.text_)

				local var_692_9 = 30 <= 0 and var_692_5 or var_692_5 * (utf8.len(var_692_7) / 30)

				if (30 <= 0 and var_692_5 or var_692_5 * (utf8.len(var_692_7) / 30)) > 0 and var_692_5 < var_692_9 then
					arg_689_1.talkMaxDuration = var_692_9

					if var_692_9 + var_692_4 > arg_689_1.duration_ then
						arg_689_1.duration_ = var_692_9 + var_692_4
					end
				end

				arg_689_1.text_.text = var_692_7
				arg_689_1.typewritter.percent = 0

				arg_689_1.typewritter:SetDirty()
				arg_689_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411166", "story_v_side_new_1108411.awb") ~= 0 then
					local var_692_10 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411166", "story_v_side_new_1108411.awb") / 1000

					if var_692_10 + var_692_4 > arg_689_1.duration_ then
						arg_689_1.duration_ = var_692_10 + var_692_4
					end

					if var_692_6.prefab_name ~= "" and arg_689_1.actors_[var_692_6.prefab_name] ~= nil then
						local var_692_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_689_1.actors_[var_692_6.prefab_name].transform, "story_v_side_new_1108411", "1108411166", "story_v_side_new_1108411.awb")

						arg_689_1:RecordAudio("1108411166", var_692_11)
						arg_689_1:RecordAudio("1108411166", var_692_11)
					else
						arg_689_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411166", "story_v_side_new_1108411.awb")
					end

					arg_689_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411166", "story_v_side_new_1108411.awb")
				end

				arg_689_1:RecordContent(arg_689_1.text_.text)
			end

			local var_692_12 = math.max(var_692_5, arg_689_1.talkMaxDuration)

			if var_692_4 <= arg_689_1.time_ and arg_689_1.time_ < var_692_4 + var_692_12 then
				arg_689_1.typewritter.percent = (arg_689_1.time_ - var_692_4) / var_692_12

				arg_689_1.typewritter:SetDirty()
			end

			if arg_689_1.time_ >= var_692_4 + var_692_12 and arg_689_1.time_ < var_692_4 + var_692_12 + arg_692_0 then
				arg_689_1.typewritter.percent = 1

				arg_689_1.typewritter:SetDirty()
				arg_689_1:ShowNextGo(true)
			end
		end

		arg_689_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_689_1:InitPlayNodeList()
	end,
	Play1108411167 = function(arg_693_0, arg_693_1)
		arg_693_1.time_ = 0
		arg_693_1.frameCnt_ = 0
		arg_693_1.state_ = "playing"
		arg_693_1.curTalkId_ = 1108411167
		arg_693_1.duration_ = 9

		SetActive(arg_693_1.tipsGo_, false)

		function arg_693_1.onSingleLineFinish_()
			arg_693_1.onSingleLineUpdate_ = nil
			arg_693_1.onSingleLineFinish_ = nil
			arg_693_1.state_ = "waiting"
		end

		function arg_693_1.playNext_(arg_695_0)
			if arg_695_0 == 1 then
				arg_693_0:Play1108411168(arg_693_1)
			end
		end

		function arg_693_1.onSingleLineUpdate_(arg_696_0)
			if arg_693_1.bgs_.ST0115 == nil then
				local var_696_0 = Object.Instantiate(arg_693_1.paintGo_)

				var_696_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST0115")
				var_696_0.name = "ST0115"
				var_696_0.transform.parent = arg_693_1.stage_.transform
				var_696_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_693_1.bgs_.ST0115 = var_696_0
			end

			if 2 < arg_693_1.time_ and arg_693_1.time_ <= 2 + arg_696_0 then
				local var_696_1 = arg_693_1.bgs_.ST0115

				arg_693_1.bgs_.ST0115.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_696_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_696_2 = var_696_1:GetComponent("SpriteRenderer")

				if var_696_2 and var_696_2.sprite then
					local var_696_3 = 2 * (var_696_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_696_1.transform.localScale = Vector3.New(var_696_3 / var_696_2.sprite.bounds.size.y < var_696_3 * manager.ui.mainCameraCom_.aspect / var_696_2.sprite.bounds.size.x and var_696_3 * manager.ui.mainCameraCom_.aspect / var_696_2.sprite.bounds.size.x or var_696_3 / var_696_2.sprite.bounds.size.y, var_696_3 / var_696_2.sprite.bounds.size.y < var_696_3 * manager.ui.mainCameraCom_.aspect / var_696_2.sprite.bounds.size.x and var_696_3 * manager.ui.mainCameraCom_.aspect / var_696_2.sprite.bounds.size.x or var_696_3 / var_696_2.sprite.bounds.size.y, 0)
				end

				for iter_696_0, iter_696_1 in pairs(arg_693_1.bgs_) do
					if iter_696_0 ~= "ST0115" then
						iter_696_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_696_4 = 0

			if 0 < arg_693_1.time_ and arg_693_1.time_ <= var_696_4 + arg_696_0 then
				arg_693_1.allBtn_.enabled = false
			end

			if arg_693_1.time_ >= var_696_4 + 0.3 and arg_693_1.time_ < var_696_4 + 0.3 + arg_696_0 then
				arg_693_1.allBtn_.enabled = true
			end

			local var_696_5 = 0

			if 0 < arg_693_1.time_ and arg_693_1.time_ <= var_696_5 + arg_696_0 then
				arg_693_1.mask_.enabled = true
				arg_693_1.mask_.raycastTarget = true

				arg_693_1:SetGaussion(false)
			end

			local var_696_6 = 2

			if var_696_5 <= arg_693_1.time_ and arg_693_1.time_ < var_696_5 + var_696_6 then
				local var_696_7 = Color.New(0, 0, 0)

				var_696_7.a = Mathf.Lerp(0, 1, (arg_693_1.time_ - var_696_5) / var_696_6)
				arg_693_1.mask_.color = var_696_7
			end

			if arg_693_1.time_ >= var_696_5 + var_696_6 and arg_693_1.time_ < var_696_5 + var_696_6 + arg_696_0 then
				local var_696_8 = Color.New(0, 0, 0)

				var_696_8.a = 1
				arg_693_1.mask_.color = var_696_8
			end

			local var_696_9 = 2

			if 2 < arg_693_1.time_ and arg_693_1.time_ <= var_696_9 + arg_696_0 then
				arg_693_1.mask_.enabled = true
				arg_693_1.mask_.raycastTarget = true

				arg_693_1:SetGaussion(false)
			end

			local var_696_10 = 2

			if var_696_9 <= arg_693_1.time_ and arg_693_1.time_ < var_696_9 + var_696_10 then
				local var_696_11 = Color.New(0, 0, 0)

				var_696_11.a = Mathf.Lerp(1, 0, (arg_693_1.time_ - var_696_9) / var_696_10)
				arg_693_1.mask_.color = var_696_11
			end

			if arg_693_1.time_ >= var_696_9 + var_696_10 and arg_693_1.time_ < var_696_9 + var_696_10 + arg_696_0 then
				local var_696_12 = Color.New(0, 0, 0)

				arg_693_1.mask_.enabled = false
				var_696_12.a = 0
				arg_693_1.mask_.color = var_696_12
			end

			local var_696_13 = arg_693_1.actors_["10102ui_story"].transform

			if 2 < arg_693_1.time_ and arg_693_1.time_ <= 2 + arg_696_0 then
				arg_693_1.var_.moveOldPos10102ui_story = var_696_13.localPosition
			end

			local var_696_14 = 0.001

			if 2 <= arg_693_1.time_ and arg_693_1.time_ < 2 + var_696_14 then
				var_696_13.localPosition = Vector3.Lerp(arg_693_1.var_.moveOldPos10102ui_story, Vector3.New(0, 100, 0), (arg_693_1.time_ - 2) / var_696_14)
				var_696_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_696_13.position).x, (manager.ui.mainCamera.transform.position - var_696_13.position).y, (manager.ui.mainCamera.transform.position - var_696_13.position).z)
				var_696_13.localEulerAngles.z = 0
				var_696_13.localEulerAngles.x = 0
				var_696_13.localEulerAngles = var_696_13.localEulerAngles
			end

			if arg_693_1.time_ >= 2 + var_696_14 and arg_693_1.time_ < 2 + var_696_14 + arg_696_0 then
				var_696_13.localPosition = Vector3.New(0, 100, 0)
				var_696_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_696_13.position).x, (manager.ui.mainCamera.transform.position - var_696_13.position).y, (manager.ui.mainCamera.transform.position - var_696_13.position).z)
				var_696_13.localEulerAngles.z = 0
				var_696_13.localEulerAngles.x = 0
				var_696_13.localEulerAngles = var_696_13.localEulerAngles
			end

			local var_696_15 = arg_693_1.actors_["10102ui_story"]

			if 2 < arg_693_1.time_ and arg_693_1.time_ <= 2 + arg_696_0 and not isNil(var_696_15) and arg_693_1.var_.characterEffect10102ui_story == nil then
				arg_693_1.var_.characterEffect10102ui_story = var_696_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_696_16 = 0.200000002980232

			if 2 <= arg_693_1.time_ and arg_693_1.time_ < 2 + var_696_16 and not isNil(var_696_15) then
				if arg_693_1.var_.characterEffect10102ui_story and not isNil(var_696_15) then
					arg_693_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_693_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_693_1.time_ - 2) / var_696_16)
				end
			end

			if arg_693_1.time_ >= 2 + var_696_16 and arg_693_1.time_ < 2 + var_696_16 + arg_696_0 and not isNil(var_696_15) and arg_693_1.var_.characterEffect10102ui_story then
				arg_693_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_693_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			if 2 < arg_693_1.time_ and arg_693_1.time_ <= 2 + arg_696_0 then
				if arg_693_1.var_.effect54543 then
					Object.Destroy(arg_693_1.var_.effect54543)

					arg_693_1.var_.effect54543 = nil
				end
			end

			if 0.166666666666667 < arg_693_1.time_ and arg_693_1.time_ <= 0.166666666666667 + arg_696_0 then
				arg_693_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_696_20 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_693_1.bgmTxt_.text ~= var_696_20 and arg_693_1.bgmTxt_.text ~= "" then
						if arg_693_1.bgmTxt2_.text ~= "" then
							arg_693_1.bgmTxt_.text = arg_693_1.bgmTxt2_.text
						end

						arg_693_1.bgmTxt2_.text = var_696_20

						arg_693_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_693_1.bgmTxt_.text = var_696_20
						arg_693_1.bgmTxt2_.text = var_696_20
					end

					if arg_693_1.bgmTimer then
						arg_693_1.bgmTimer:Stop()

						arg_693_1.bgmTimer = nil
					end

					if arg_693_1.settingData.show_music_name == 1 then
						arg_693_1.musicController:SetSelectedState("show")
						arg_693_1.musicAnimator_:Play("open", 0, 0)

						if arg_693_1.settingData.music_time ~= 0 then
							arg_693_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_693_1.settingData.music_time), function()
								if arg_693_1 == nil or isNil(arg_693_1.bgmTxt_) then
									return
								end

								arg_693_1.musicController:SetSelectedState("hide")
								arg_693_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 1.66666666666667 < arg_693_1.time_ and arg_693_1.time_ <= 1.66666666666667 + arg_696_0 then
				arg_693_1:AudioAction("play", "music", "bgm_side_daily05", "bgm_side_daily05", "bgm_side_daily05.awb")

				local var_696_23 = manager.audio:GetAudioName("bgm_side_daily05", "bgm_side_daily05")

				if "" ~= "" then
					if arg_693_1.bgmTxt_.text ~= var_696_23 and arg_693_1.bgmTxt_.text ~= "" then
						if arg_693_1.bgmTxt2_.text ~= "" then
							arg_693_1.bgmTxt_.text = arg_693_1.bgmTxt2_.text
						end

						arg_693_1.bgmTxt2_.text = var_696_23

						arg_693_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_693_1.bgmTxt_.text = var_696_23
						arg_693_1.bgmTxt2_.text = var_696_23
					end

					if arg_693_1.bgmTimer then
						arg_693_1.bgmTimer:Stop()

						arg_693_1.bgmTimer = nil
					end

					if arg_693_1.settingData.show_music_name == 1 then
						arg_693_1.musicController:SetSelectedState("show")
						arg_693_1.musicAnimator_:Play("open", 0, 0)

						if arg_693_1.settingData.music_time ~= 0 then
							arg_693_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_693_1.settingData.music_time), function()
								if arg_693_1 == nil or isNil(arg_693_1.bgmTxt_) then
									return
								end

								arg_693_1.musicController:SetSelectedState("hide")
								arg_693_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.166666666666667 < arg_693_1.time_ and arg_693_1.time_ <= 0.166666666666667 + arg_696_0 then
				arg_693_1:AudioAction("stop", "effect", "se_story_side_1095", "se_story_side_1095_amb_forest_night_nowater", "")
			end

			if 1.66666666666667 < arg_693_1.time_ and arg_693_1.time_ <= 1.66666666666667 + arg_696_0 then
				arg_693_1:AudioAction("play", "effect", "se_story_side_1075", "se_story_side_1075_morningloop", "")
			end

			if 4.3 < arg_693_1.time_ and arg_693_1.time_ <= 4.3 + arg_696_0 then
				arg_693_1:AudioAction("play", "effect", "se_story_side_128402", "se_story_side_128402_cook", "")
			end

			if arg_693_1.frameCnt_ <= 1 then
				arg_693_1.dialog_:SetActive(false)
			end

			local var_696_27 = 3.999999999999
			local var_696_28 = 1.65

			if 3.999999999999 < arg_693_1.time_ and arg_693_1.time_ <= var_696_27 + arg_696_0 then
				arg_693_1.talkMaxDuration = 0

				arg_693_1.dialog_:SetActive(true)

				arg_693_1.dialogCg_.alpha = 0

				local var_696_29 = LeanTween.value(arg_693_1.dialog_, 0, 1, 0.3)

				var_696_29:setOnUpdate(LuaHelper.FloatAction(function(arg_699_0)
					arg_693_1.dialogCg_.alpha = arg_699_0
				end))
				var_696_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_693_1.dialog_)
					var_696_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_693_1.duration_ = arg_693_1.duration_ + 0.3

				SetActive(arg_693_1.leftNameGo_, false)

				arg_693_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_693_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_693_1:RecordName(arg_693_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_693_1.iconTrs_.gameObject, false)
				arg_693_1.callingController_:SetSelectedState("normal")

				local var_696_30 = arg_693_1:FormatText(arg_693_1:GetWordFromCfg(1108411167).content)

				arg_693_1.text_.text = var_696_30

				LuaForUtil.ClearLinePrefixSymbol(arg_693_1.text_)

				local var_696_32 = 66 <= 0 and var_696_28 or var_696_28 * (utf8.len(var_696_30) / 66)

				if (66 <= 0 and var_696_28 or var_696_28 * (utf8.len(var_696_30) / 66)) > 0 and var_696_28 < var_696_32 then
					arg_693_1.talkMaxDuration = var_696_32
					var_696_27 = var_696_27 + 0.3

					if var_696_32 + var_696_27 > arg_693_1.duration_ then
						arg_693_1.duration_ = var_696_32 + var_696_27
					end
				end

				arg_693_1.text_.text = var_696_30
				arg_693_1.typewritter.percent = 0

				arg_693_1.typewritter:SetDirty()
				arg_693_1:ShowNextGo(false)
				arg_693_1:RecordContent(arg_693_1.text_.text)
			end

			local var_696_33 = var_696_27 + 0.3
			local var_696_34 = math.max(var_696_28, arg_693_1.talkMaxDuration)

			if var_696_27 + 0.3 <= arg_693_1.time_ and arg_693_1.time_ < var_696_33 + var_696_34 then
				arg_693_1.typewritter.percent = (arg_693_1.time_ - var_696_33) / var_696_34

				arg_693_1.typewritter:SetDirty()
			end

			if arg_693_1.time_ >= var_696_33 + var_696_34 and arg_693_1.time_ < var_696_33 + var_696_34 + arg_696_0 then
				arg_693_1.typewritter.percent = 1

				arg_693_1.typewritter:SetDirty()
				arg_693_1:ShowNextGo(true)
			end
		end

		arg_693_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_693_1:InitPlayNodeList()
	end,
	Play1108411168 = function(arg_701_0, arg_701_1)
		arg_701_1.time_ = 0
		arg_701_1.frameCnt_ = 0
		arg_701_1.state_ = "playing"
		arg_701_1.curTalkId_ = 1108411168
		arg_701_1.duration_ = 5

		SetActive(arg_701_1.tipsGo_, false)

		function arg_701_1.onSingleLineFinish_()
			arg_701_1.onSingleLineUpdate_ = nil
			arg_701_1.onSingleLineFinish_ = nil
			arg_701_1.state_ = "waiting"
		end

		function arg_701_1.playNext_(arg_703_0)
			if arg_703_0 == 1 then
				arg_701_0:Play1108411169(arg_701_1)
			end
		end

		function arg_701_1.onSingleLineUpdate_(arg_704_0)
			local var_704_0 = 0.325

			if 0 < arg_701_1.time_ and arg_701_1.time_ <= 0 + arg_704_0 then
				arg_701_1.talkMaxDuration = 0
				arg_701_1.dialogCg_.alpha = 1

				arg_701_1.dialog_:SetActive(true)
				SetActive(arg_701_1.leftNameGo_, true)

				arg_701_1.leftNameTxt_.text = arg_701_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_701_1.leftNameTxt_.transform)

				arg_701_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_701_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_701_1:RecordName(arg_701_1.leftNameTxt_.text)
				SetActive(arg_701_1.iconTrs_.gameObject, true)
				arg_701_1.iconController_:SetSelectedState("hero")

				arg_701_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_701_1.callingController_:SetSelectedState("normal")

				arg_701_1.keyicon_.color = Color.New(1, 1, 1)
				arg_701_1.icon_.color = Color.New(1, 1, 1)

				local var_704_1 = arg_701_1:FormatText(arg_701_1:GetWordFromCfg(1108411168).content)

				arg_701_1.text_.text = var_704_1

				LuaForUtil.ClearLinePrefixSymbol(arg_701_1.text_)

				local var_704_3 = 13 <= 0 and var_704_0 or var_704_0 * (utf8.len(var_704_1) / 13)

				if (13 <= 0 and var_704_0 or var_704_0 * (utf8.len(var_704_1) / 13)) > 0 and var_704_0 < var_704_3 then
					arg_701_1.talkMaxDuration = var_704_3

					if var_704_3 + 0 > arg_701_1.duration_ then
						arg_701_1.duration_ = var_704_3 + 0
					end
				end

				arg_701_1.text_.text = var_704_1
				arg_701_1.typewritter.percent = 0

				arg_701_1.typewritter:SetDirty()
				arg_701_1:ShowNextGo(false)
				arg_701_1:RecordContent(arg_701_1.text_.text)
			end

			local var_704_4 = math.max(var_704_0, arg_701_1.talkMaxDuration)

			if 0 <= arg_701_1.time_ and arg_701_1.time_ < 0 + var_704_4 then
				arg_701_1.typewritter.percent = (arg_701_1.time_ - 0) / var_704_4

				arg_701_1.typewritter:SetDirty()
			end

			if arg_701_1.time_ >= 0 + var_704_4 and arg_701_1.time_ < 0 + var_704_4 + arg_704_0 then
				arg_701_1.typewritter.percent = 1

				arg_701_1.typewritter:SetDirty()
				arg_701_1:ShowNextGo(true)
			end
		end

		arg_701_1.nodeConfigList_ = {}

		arg_701_1:InitPlayNodeList()
	end,
	Play1108411169 = function(arg_705_0, arg_705_1)
		arg_705_1.time_ = 0
		arg_705_1.frameCnt_ = 0
		arg_705_1.state_ = "playing"
		arg_705_1.curTalkId_ = 1108411169
		arg_705_1.duration_ = 6.33

		local var_705_0 = {
			zh = 3.166,
			ja = 6.333
		}
		local var_705_1 = manager.audio:GetLocalizationFlag()

		if var_705_0[var_705_1] ~= nil then
			arg_705_1.duration_ = var_705_0[var_705_1]
		end

		SetActive(arg_705_1.tipsGo_, false)

		function arg_705_1.onSingleLineFinish_()
			arg_705_1.onSingleLineUpdate_ = nil
			arg_705_1.onSingleLineFinish_ = nil
			arg_705_1.state_ = "waiting"
		end

		function arg_705_1.playNext_(arg_707_0)
			if arg_707_0 == 1 then
				arg_705_0:Play1108411170(arg_705_1)
			end
		end

		function arg_705_1.onSingleLineUpdate_(arg_708_0)
			if 0 < arg_705_1.time_ and arg_705_1.time_ <= 0 + arg_708_0 then
				arg_705_1.var_.moveOldPos10102ui_story = arg_705_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_708_0 = 0.001

			if 0 <= arg_705_1.time_ and arg_705_1.time_ < 0 + var_708_0 then
				arg_705_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_705_1.var_.moveOldPos10102ui_story, Vector3.New(0, -0.985, -6.275), (arg_705_1.time_ - 0) / var_708_0)
				arg_705_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_705_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_705_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_705_1.actors_["10102ui_story"].transform.position).z)
				arg_705_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_705_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_705_1.actors_["10102ui_story"].transform.localEulerAngles = arg_705_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_705_1.time_ >= 0 + var_708_0 and arg_705_1.time_ < 0 + var_708_0 + arg_708_0 then
				arg_705_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6.275)
				arg_705_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_705_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_705_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_705_1.actors_["10102ui_story"].transform.position).z)
				arg_705_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_705_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_705_1.actors_["10102ui_story"].transform.localEulerAngles = arg_705_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_708_1 = arg_705_1.actors_["10102ui_story"]

			if 0 < arg_705_1.time_ and arg_705_1.time_ <= 0 + arg_708_0 and not isNil(var_708_1) and arg_705_1.var_.characterEffect10102ui_story == nil then
				arg_705_1.var_.characterEffect10102ui_story = var_708_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_708_2 = 0.200000002980232

			if 0 <= arg_705_1.time_ and arg_705_1.time_ < 0 + var_708_2 and not isNil(var_708_1) then
				if arg_705_1.var_.characterEffect10102ui_story and not isNil(var_708_1) then
					arg_705_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_705_1.time_ >= 0 + var_708_2 and arg_705_1.time_ < 0 + var_708_2 + arg_708_0 and not isNil(var_708_1) and arg_705_1.var_.characterEffect10102ui_story then
				arg_705_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_705_1.time_ and arg_705_1.time_ <= 0 + arg_708_0 then
				arg_705_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action6_1")
			end

			if 0 < arg_705_1.time_ and arg_705_1.time_ <= 0 + arg_708_0 then
				arg_705_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_708_4 = 0
			local var_708_5 = 0.35

			if 0 < arg_705_1.time_ and arg_705_1.time_ <= var_708_4 + arg_708_0 then
				arg_705_1.talkMaxDuration = 0
				arg_705_1.dialogCg_.alpha = 1

				arg_705_1.dialog_:SetActive(true)
				SetActive(arg_705_1.leftNameGo_, true)

				arg_705_1.leftNameTxt_.text = arg_705_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_705_1.leftNameTxt_.transform)

				arg_705_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_705_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_705_1:RecordName(arg_705_1.leftNameTxt_.text)
				SetActive(arg_705_1.iconTrs_.gameObject, false)
				arg_705_1.callingController_:SetSelectedState("normal")

				local var_708_6 = arg_705_1:GetWordFromCfg(1108411169)
				local var_708_7 = arg_705_1:FormatText(var_708_6.content)

				arg_705_1.text_.text = var_708_7

				LuaForUtil.ClearLinePrefixSymbol(arg_705_1.text_)

				local var_708_9 = 14 <= 0 and var_708_5 or var_708_5 * (utf8.len(var_708_7) / 14)

				if (14 <= 0 and var_708_5 or var_708_5 * (utf8.len(var_708_7) / 14)) > 0 and var_708_5 < var_708_9 then
					arg_705_1.talkMaxDuration = var_708_9

					if var_708_9 + var_708_4 > arg_705_1.duration_ then
						arg_705_1.duration_ = var_708_9 + var_708_4
					end
				end

				arg_705_1.text_.text = var_708_7
				arg_705_1.typewritter.percent = 0

				arg_705_1.typewritter:SetDirty()
				arg_705_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411169", "story_v_side_new_1108411.awb") ~= 0 then
					local var_708_10 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411169", "story_v_side_new_1108411.awb") / 1000

					if var_708_10 + var_708_4 > arg_705_1.duration_ then
						arg_705_1.duration_ = var_708_10 + var_708_4
					end

					if var_708_6.prefab_name ~= "" and arg_705_1.actors_[var_708_6.prefab_name] ~= nil then
						local var_708_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_705_1.actors_[var_708_6.prefab_name].transform, "story_v_side_new_1108411", "1108411169", "story_v_side_new_1108411.awb")

						arg_705_1:RecordAudio("1108411169", var_708_11)
						arg_705_1:RecordAudio("1108411169", var_708_11)
					else
						arg_705_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411169", "story_v_side_new_1108411.awb")
					end

					arg_705_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411169", "story_v_side_new_1108411.awb")
				end

				arg_705_1:RecordContent(arg_705_1.text_.text)
			end

			local var_708_12 = math.max(var_708_5, arg_705_1.talkMaxDuration)

			if var_708_4 <= arg_705_1.time_ and arg_705_1.time_ < var_708_4 + var_708_12 then
				arg_705_1.typewritter.percent = (arg_705_1.time_ - var_708_4) / var_708_12

				arg_705_1.typewritter:SetDirty()
			end

			if arg_705_1.time_ >= var_708_4 + var_708_12 and arg_705_1.time_ < var_708_4 + var_708_12 + arg_708_0 then
				arg_705_1.typewritter.percent = 1

				arg_705_1.typewritter:SetDirty()
				arg_705_1:ShowNextGo(true)
			end
		end

		arg_705_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_705_1:InitPlayNodeList()
	end,
	Play1108411170 = function(arg_709_0, arg_709_1)
		arg_709_1.time_ = 0
		arg_709_1.frameCnt_ = 0
		arg_709_1.state_ = "playing"
		arg_709_1.curTalkId_ = 1108411170
		arg_709_1.duration_ = 5

		SetActive(arg_709_1.tipsGo_, false)

		function arg_709_1.onSingleLineFinish_()
			arg_709_1.onSingleLineUpdate_ = nil
			arg_709_1.onSingleLineFinish_ = nil
			arg_709_1.state_ = "waiting"
		end

		function arg_709_1.playNext_(arg_711_0)
			if arg_711_0 == 1 then
				arg_709_0:Play1108411171(arg_709_1)
			end
		end

		function arg_709_1.onSingleLineUpdate_(arg_712_0)
			if 0 < arg_709_1.time_ and arg_709_1.time_ <= 0 + arg_712_0 and not isNil(arg_709_1.actors_["10102ui_story"]) and arg_709_1.var_.characterEffect10102ui_story == nil then
				arg_709_1.var_.characterEffect10102ui_story = arg_709_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_712_0 = 0.200000002980232

			if 0 <= arg_709_1.time_ and arg_709_1.time_ < 0 + var_712_0 and not isNil(arg_709_1.actors_["10102ui_story"]) then
				if arg_709_1.var_.characterEffect10102ui_story and not isNil(arg_709_1.actors_["10102ui_story"]) then
					arg_709_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_709_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_709_1.time_ - 0) / var_712_0)
				end
			end

			if arg_709_1.time_ >= 0 + var_712_0 and arg_709_1.time_ < 0 + var_712_0 + arg_712_0 and not isNil(arg_709_1.actors_["10102ui_story"]) and arg_709_1.var_.characterEffect10102ui_story then
				arg_709_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_709_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			if 0.333333333333333 < arg_709_1.time_ and arg_709_1.time_ <= 0.333333333333333 + arg_712_0 then
				arg_709_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_plate", "")
			end

			local var_712_2 = 0
			local var_712_3 = 1.9

			if 0 < arg_709_1.time_ and arg_709_1.time_ <= var_712_2 + arg_712_0 then
				arg_709_1.talkMaxDuration = 0
				arg_709_1.dialogCg_.alpha = 1

				arg_709_1.dialog_:SetActive(true)
				SetActive(arg_709_1.leftNameGo_, false)

				arg_709_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_709_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_709_1:RecordName(arg_709_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_709_1.iconTrs_.gameObject, false)
				arg_709_1.callingController_:SetSelectedState("normal")

				local var_712_4 = arg_709_1:FormatText(arg_709_1:GetWordFromCfg(1108411170).content)

				arg_709_1.text_.text = var_712_4

				LuaForUtil.ClearLinePrefixSymbol(arg_709_1.text_)

				local var_712_6 = 76 <= 0 and var_712_3 or var_712_3 * (utf8.len(var_712_4) / 76)

				if (76 <= 0 and var_712_3 or var_712_3 * (utf8.len(var_712_4) / 76)) > 0 and var_712_3 < var_712_6 then
					arg_709_1.talkMaxDuration = var_712_6

					if var_712_6 + var_712_2 > arg_709_1.duration_ then
						arg_709_1.duration_ = var_712_6 + var_712_2
					end
				end

				arg_709_1.text_.text = var_712_4
				arg_709_1.typewritter.percent = 0

				arg_709_1.typewritter:SetDirty()
				arg_709_1:ShowNextGo(false)
				arg_709_1:RecordContent(arg_709_1.text_.text)
			end

			local var_712_7 = math.max(var_712_3, arg_709_1.talkMaxDuration)

			if var_712_2 <= arg_709_1.time_ and arg_709_1.time_ < var_712_2 + var_712_7 then
				arg_709_1.typewritter.percent = (arg_709_1.time_ - var_712_2) / var_712_7

				arg_709_1.typewritter:SetDirty()
			end

			if arg_709_1.time_ >= var_712_2 + var_712_7 and arg_709_1.time_ < var_712_2 + var_712_7 + arg_712_0 then
				arg_709_1.typewritter.percent = 1

				arg_709_1.typewritter:SetDirty()
				arg_709_1:ShowNextGo(true)
			end
		end

		arg_709_1.nodeConfigList_ = {}

		arg_709_1:InitPlayNodeList()
	end,
	Play1108411171 = function(arg_713_0, arg_713_1)
		arg_713_1.time_ = 0
		arg_713_1.frameCnt_ = 0
		arg_713_1.state_ = "playing"
		arg_713_1.curTalkId_ = 1108411171
		arg_713_1.duration_ = 5

		SetActive(arg_713_1.tipsGo_, false)

		function arg_713_1.onSingleLineFinish_()
			arg_713_1.onSingleLineUpdate_ = nil
			arg_713_1.onSingleLineFinish_ = nil
			arg_713_1.state_ = "waiting"
		end

		function arg_713_1.playNext_(arg_715_0)
			if arg_715_0 == 1 then
				arg_713_0:Play1108411172(arg_713_1)
			end
		end

		function arg_713_1.onSingleLineUpdate_(arg_716_0)
			local var_716_0 = 0.35

			if 0 < arg_713_1.time_ and arg_713_1.time_ <= 0 + arg_716_0 then
				arg_713_1.talkMaxDuration = 0
				arg_713_1.dialogCg_.alpha = 1

				arg_713_1.dialog_:SetActive(true)
				SetActive(arg_713_1.leftNameGo_, true)

				arg_713_1.leftNameTxt_.text = arg_713_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_713_1.leftNameTxt_.transform)

				arg_713_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_713_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_713_1:RecordName(arg_713_1.leftNameTxt_.text)
				SetActive(arg_713_1.iconTrs_.gameObject, true)
				arg_713_1.iconController_:SetSelectedState("hero")

				arg_713_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_713_1.callingController_:SetSelectedState("normal")

				arg_713_1.keyicon_.color = Color.New(1, 1, 1)
				arg_713_1.icon_.color = Color.New(1, 1, 1)

				local var_716_1 = arg_713_1:FormatText(arg_713_1:GetWordFromCfg(1108411171).content)

				arg_713_1.text_.text = var_716_1

				LuaForUtil.ClearLinePrefixSymbol(arg_713_1.text_)

				local var_716_3 = 14 <= 0 and var_716_0 or var_716_0 * (utf8.len(var_716_1) / 14)

				if (14 <= 0 and var_716_0 or var_716_0 * (utf8.len(var_716_1) / 14)) > 0 and var_716_0 < var_716_3 then
					arg_713_1.talkMaxDuration = var_716_3

					if var_716_3 + 0 > arg_713_1.duration_ then
						arg_713_1.duration_ = var_716_3 + 0
					end
				end

				arg_713_1.text_.text = var_716_1
				arg_713_1.typewritter.percent = 0

				arg_713_1.typewritter:SetDirty()
				arg_713_1:ShowNextGo(false)
				arg_713_1:RecordContent(arg_713_1.text_.text)
			end

			local var_716_4 = math.max(var_716_0, arg_713_1.talkMaxDuration)

			if 0 <= arg_713_1.time_ and arg_713_1.time_ < 0 + var_716_4 then
				arg_713_1.typewritter.percent = (arg_713_1.time_ - 0) / var_716_4

				arg_713_1.typewritter:SetDirty()
			end

			if arg_713_1.time_ >= 0 + var_716_4 and arg_713_1.time_ < 0 + var_716_4 + arg_716_0 then
				arg_713_1.typewritter.percent = 1

				arg_713_1.typewritter:SetDirty()
				arg_713_1:ShowNextGo(true)
			end
		end

		arg_713_1.nodeConfigList_ = {}

		arg_713_1:InitPlayNodeList()
	end,
	Play1108411172 = function(arg_717_0, arg_717_1)
		arg_717_1.time_ = 0
		arg_717_1.frameCnt_ = 0
		arg_717_1.state_ = "playing"
		arg_717_1.curTalkId_ = 1108411172
		arg_717_1.duration_ = 5.73

		local var_717_0 = {
			zh = 4.633,
			ja = 5.733
		}
		local var_717_1 = manager.audio:GetLocalizationFlag()

		if var_717_0[var_717_1] ~= nil then
			arg_717_1.duration_ = var_717_0[var_717_1]
		end

		SetActive(arg_717_1.tipsGo_, false)

		function arg_717_1.onSingleLineFinish_()
			arg_717_1.onSingleLineUpdate_ = nil
			arg_717_1.onSingleLineFinish_ = nil
			arg_717_1.state_ = "waiting"
		end

		function arg_717_1.playNext_(arg_719_0)
			if arg_719_0 == 1 then
				arg_717_0:Play1108411173(arg_717_1)
			end
		end

		function arg_717_1.onSingleLineUpdate_(arg_720_0)
			if 0 < arg_717_1.time_ and arg_717_1.time_ <= 0 + arg_720_0 and not isNil(arg_717_1.actors_["10102ui_story"]) and arg_717_1.var_.characterEffect10102ui_story == nil then
				arg_717_1.var_.characterEffect10102ui_story = arg_717_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_720_0 = 0.200000002980232

			if 0 <= arg_717_1.time_ and arg_717_1.time_ < 0 + var_720_0 and not isNil(arg_717_1.actors_["10102ui_story"]) then
				if arg_717_1.var_.characterEffect10102ui_story and not isNil(arg_717_1.actors_["10102ui_story"]) then
					arg_717_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_717_1.time_ >= 0 + var_720_0 and arg_717_1.time_ < 0 + var_720_0 + arg_720_0 and not isNil(arg_717_1.actors_["10102ui_story"]) and arg_717_1.var_.characterEffect10102ui_story then
				arg_717_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_717_1.time_ and arg_717_1.time_ <= 0 + arg_720_0 then
				arg_717_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action6_2")
			end

			if 0 < arg_717_1.time_ and arg_717_1.time_ <= 0 + arg_720_0 then
				arg_717_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileC_biyan", "EmotionTimelineAnimator")
			end

			local var_720_2 = 0
			local var_720_3 = 0.55

			if 0 < arg_717_1.time_ and arg_717_1.time_ <= var_720_2 + arg_720_0 then
				arg_717_1.talkMaxDuration = 0
				arg_717_1.dialogCg_.alpha = 1

				arg_717_1.dialog_:SetActive(true)
				SetActive(arg_717_1.leftNameGo_, true)

				arg_717_1.leftNameTxt_.text = arg_717_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_717_1.leftNameTxt_.transform)

				arg_717_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_717_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_717_1:RecordName(arg_717_1.leftNameTxt_.text)
				SetActive(arg_717_1.iconTrs_.gameObject, false)
				arg_717_1.callingController_:SetSelectedState("normal")

				local var_720_4 = arg_717_1:GetWordFromCfg(1108411172)
				local var_720_5 = arg_717_1:FormatText(var_720_4.content)

				arg_717_1.text_.text = var_720_5

				LuaForUtil.ClearLinePrefixSymbol(arg_717_1.text_)

				local var_720_7 = 22 <= 0 and var_720_3 or var_720_3 * (utf8.len(var_720_5) / 22)

				if (22 <= 0 and var_720_3 or var_720_3 * (utf8.len(var_720_5) / 22)) > 0 and var_720_3 < var_720_7 then
					arg_717_1.talkMaxDuration = var_720_7

					if var_720_7 + var_720_2 > arg_717_1.duration_ then
						arg_717_1.duration_ = var_720_7 + var_720_2
					end
				end

				arg_717_1.text_.text = var_720_5
				arg_717_1.typewritter.percent = 0

				arg_717_1.typewritter:SetDirty()
				arg_717_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411172", "story_v_side_new_1108411.awb") ~= 0 then
					local var_720_8 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411172", "story_v_side_new_1108411.awb") / 1000

					if var_720_8 + var_720_2 > arg_717_1.duration_ then
						arg_717_1.duration_ = var_720_8 + var_720_2
					end

					if var_720_4.prefab_name ~= "" and arg_717_1.actors_[var_720_4.prefab_name] ~= nil then
						local var_720_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_717_1.actors_[var_720_4.prefab_name].transform, "story_v_side_new_1108411", "1108411172", "story_v_side_new_1108411.awb")

						arg_717_1:RecordAudio("1108411172", var_720_9)
						arg_717_1:RecordAudio("1108411172", var_720_9)
					else
						arg_717_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411172", "story_v_side_new_1108411.awb")
					end

					arg_717_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411172", "story_v_side_new_1108411.awb")
				end

				arg_717_1:RecordContent(arg_717_1.text_.text)
			end

			local var_720_10 = math.max(var_720_3, arg_717_1.talkMaxDuration)

			if var_720_2 <= arg_717_1.time_ and arg_717_1.time_ < var_720_2 + var_720_10 then
				arg_717_1.typewritter.percent = (arg_717_1.time_ - var_720_2) / var_720_10

				arg_717_1.typewritter:SetDirty()
			end

			if arg_717_1.time_ >= var_720_2 + var_720_10 and arg_717_1.time_ < var_720_2 + var_720_10 + arg_720_0 then
				arg_717_1.typewritter.percent = 1

				arg_717_1.typewritter:SetDirty()
				arg_717_1:ShowNextGo(true)
			end
		end

		arg_717_1.nodeConfigList_ = {}

		arg_717_1:InitPlayNodeList()
	end,
	Play1108411173 = function(arg_721_0, arg_721_1)
		arg_721_1.time_ = 0
		arg_721_1.frameCnt_ = 0
		arg_721_1.state_ = "playing"
		arg_721_1.curTalkId_ = 1108411173
		arg_721_1.duration_ = 5

		SetActive(arg_721_1.tipsGo_, false)

		function arg_721_1.onSingleLineFinish_()
			arg_721_1.onSingleLineUpdate_ = nil
			arg_721_1.onSingleLineFinish_ = nil
			arg_721_1.state_ = "waiting"
		end

		function arg_721_1.playNext_(arg_723_0)
			if arg_723_0 == 1 then
				arg_721_0:Play1108411174(arg_721_1)
			end
		end

		function arg_721_1.onSingleLineUpdate_(arg_724_0)
			if 0 < arg_721_1.time_ and arg_721_1.time_ <= 0 + arg_724_0 and not isNil(arg_721_1.actors_["10102ui_story"]) and arg_721_1.var_.characterEffect10102ui_story == nil then
				arg_721_1.var_.characterEffect10102ui_story = arg_721_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_724_0 = 0.200000002980232

			if 0 <= arg_721_1.time_ and arg_721_1.time_ < 0 + var_724_0 and not isNil(arg_721_1.actors_["10102ui_story"]) then
				if arg_721_1.var_.characterEffect10102ui_story and not isNil(arg_721_1.actors_["10102ui_story"]) then
					arg_721_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_721_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_721_1.time_ - 0) / var_724_0)
				end
			end

			if arg_721_1.time_ >= 0 + var_724_0 and arg_721_1.time_ < 0 + var_724_0 + arg_724_0 and not isNil(arg_721_1.actors_["10102ui_story"]) and arg_721_1.var_.characterEffect10102ui_story then
				arg_721_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_721_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_724_1 = 0
			local var_724_2 = 0.225

			if 0 < arg_721_1.time_ and arg_721_1.time_ <= var_724_1 + arg_724_0 then
				arg_721_1.talkMaxDuration = 0
				arg_721_1.dialogCg_.alpha = 1

				arg_721_1.dialog_:SetActive(true)
				SetActive(arg_721_1.leftNameGo_, true)

				arg_721_1.leftNameTxt_.text = arg_721_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_721_1.leftNameTxt_.transform)

				arg_721_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_721_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_721_1:RecordName(arg_721_1.leftNameTxt_.text)
				SetActive(arg_721_1.iconTrs_.gameObject, true)
				arg_721_1.iconController_:SetSelectedState("hero")

				arg_721_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_721_1.callingController_:SetSelectedState("normal")

				arg_721_1.keyicon_.color = Color.New(1, 1, 1)
				arg_721_1.icon_.color = Color.New(1, 1, 1)

				local var_724_3 = arg_721_1:FormatText(arg_721_1:GetWordFromCfg(1108411173).content)

				arg_721_1.text_.text = var_724_3

				LuaForUtil.ClearLinePrefixSymbol(arg_721_1.text_)

				local var_724_5 = 9 <= 0 and var_724_2 or var_724_2 * (utf8.len(var_724_3) / 9)

				if (9 <= 0 and var_724_2 or var_724_2 * (utf8.len(var_724_3) / 9)) > 0 and var_724_2 < var_724_5 then
					arg_721_1.talkMaxDuration = var_724_5

					if var_724_5 + var_724_1 > arg_721_1.duration_ then
						arg_721_1.duration_ = var_724_5 + var_724_1
					end
				end

				arg_721_1.text_.text = var_724_3
				arg_721_1.typewritter.percent = 0

				arg_721_1.typewritter:SetDirty()
				arg_721_1:ShowNextGo(false)
				arg_721_1:RecordContent(arg_721_1.text_.text)
			end

			local var_724_6 = math.max(var_724_2, arg_721_1.talkMaxDuration)

			if var_724_1 <= arg_721_1.time_ and arg_721_1.time_ < var_724_1 + var_724_6 then
				arg_721_1.typewritter.percent = (arg_721_1.time_ - var_724_1) / var_724_6

				arg_721_1.typewritter:SetDirty()
			end

			if arg_721_1.time_ >= var_724_1 + var_724_6 and arg_721_1.time_ < var_724_1 + var_724_6 + arg_724_0 then
				arg_721_1.typewritter.percent = 1

				arg_721_1.typewritter:SetDirty()
				arg_721_1:ShowNextGo(true)
			end
		end

		arg_721_1.nodeConfigList_ = {}

		arg_721_1:InitPlayNodeList()
	end,
	Play1108411174 = function(arg_725_0, arg_725_1)
		arg_725_1.time_ = 0
		arg_725_1.frameCnt_ = 0
		arg_725_1.state_ = "playing"
		arg_725_1.curTalkId_ = 1108411174
		arg_725_1.duration_ = 5

		SetActive(arg_725_1.tipsGo_, false)

		function arg_725_1.onSingleLineFinish_()
			arg_725_1.onSingleLineUpdate_ = nil
			arg_725_1.onSingleLineFinish_ = nil
			arg_725_1.state_ = "waiting"
		end

		function arg_725_1.playNext_(arg_727_0)
			if arg_727_0 == 1 then
				arg_725_0:Play1108411175(arg_725_1)
			end
		end

		function arg_725_1.onSingleLineUpdate_(arg_728_0)
			if 0 < arg_725_1.time_ and arg_725_1.time_ <= 0 + arg_728_0 then
				arg_725_1.var_.moveOldPos10102ui_story = arg_725_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_728_0 = 0.001

			if 0 <= arg_725_1.time_ and arg_725_1.time_ < 0 + var_728_0 then
				arg_725_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_725_1.var_.moveOldPos10102ui_story, Vector3.New(0, 100, 0), (arg_725_1.time_ - 0) / var_728_0)
				arg_725_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_725_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_725_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_725_1.actors_["10102ui_story"].transform.position).z)
				arg_725_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_725_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_725_1.actors_["10102ui_story"].transform.localEulerAngles = arg_725_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_725_1.time_ >= 0 + var_728_0 and arg_725_1.time_ < 0 + var_728_0 + arg_728_0 then
				arg_725_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_725_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_725_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_725_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_725_1.actors_["10102ui_story"].transform.position).z)
				arg_725_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_725_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_725_1.actors_["10102ui_story"].transform.localEulerAngles = arg_725_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_728_1 = 0
			local var_728_2 = 1.25

			if 0 < arg_725_1.time_ and arg_725_1.time_ <= var_728_1 + arg_728_0 then
				arg_725_1.talkMaxDuration = 0
				arg_725_1.dialogCg_.alpha = 1

				arg_725_1.dialog_:SetActive(true)
				SetActive(arg_725_1.leftNameGo_, false)

				arg_725_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_725_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_725_1:RecordName(arg_725_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_725_1.iconTrs_.gameObject, false)
				arg_725_1.callingController_:SetSelectedState("normal")

				local var_728_3 = arg_725_1:FormatText(arg_725_1:GetWordFromCfg(1108411174).content)

				arg_725_1.text_.text = var_728_3

				LuaForUtil.ClearLinePrefixSymbol(arg_725_1.text_)

				local var_728_5 = 50 <= 0 and var_728_2 or var_728_2 * (utf8.len(var_728_3) / 50)

				if (50 <= 0 and var_728_2 or var_728_2 * (utf8.len(var_728_3) / 50)) > 0 and var_728_2 < var_728_5 then
					arg_725_1.talkMaxDuration = var_728_5

					if var_728_5 + var_728_1 > arg_725_1.duration_ then
						arg_725_1.duration_ = var_728_5 + var_728_1
					end
				end

				arg_725_1.text_.text = var_728_3
				arg_725_1.typewritter.percent = 0

				arg_725_1.typewritter:SetDirty()
				arg_725_1:ShowNextGo(false)
				arg_725_1:RecordContent(arg_725_1.text_.text)
			end

			local var_728_6 = math.max(var_728_2, arg_725_1.talkMaxDuration)

			if var_728_1 <= arg_725_1.time_ and arg_725_1.time_ < var_728_1 + var_728_6 then
				arg_725_1.typewritter.percent = (arg_725_1.time_ - var_728_1) / var_728_6

				arg_725_1.typewritter:SetDirty()
			end

			if arg_725_1.time_ >= var_728_1 + var_728_6 and arg_725_1.time_ < var_728_1 + var_728_6 + arg_728_0 then
				arg_725_1.typewritter.percent = 1

				arg_725_1.typewritter:SetDirty()
				arg_725_1:ShowNextGo(true)
			end
		end

		arg_725_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_725_1:InitPlayNodeList()
	end,
	Play1108411175 = function(arg_729_0, arg_729_1)
		arg_729_1.time_ = 0
		arg_729_1.frameCnt_ = 0
		arg_729_1.state_ = "playing"
		arg_729_1.curTalkId_ = 1108411175
		arg_729_1.duration_ = 5

		SetActive(arg_729_1.tipsGo_, false)

		function arg_729_1.onSingleLineFinish_()
			arg_729_1.onSingleLineUpdate_ = nil
			arg_729_1.onSingleLineFinish_ = nil
			arg_729_1.state_ = "waiting"
		end

		function arg_729_1.playNext_(arg_731_0)
			if arg_731_0 == 1 then
				arg_729_0:Play1108411176(arg_729_1)
			end
		end

		function arg_729_1.onSingleLineUpdate_(arg_732_0)
			local var_732_0 = 0.55

			if 0 < arg_729_1.time_ and arg_729_1.time_ <= 0 + arg_732_0 then
				arg_729_1.talkMaxDuration = 0
				arg_729_1.dialogCg_.alpha = 1

				arg_729_1.dialog_:SetActive(true)
				SetActive(arg_729_1.leftNameGo_, true)

				arg_729_1.leftNameTxt_.text = arg_729_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_729_1.leftNameTxt_.transform)

				arg_729_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_729_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_729_1:RecordName(arg_729_1.leftNameTxt_.text)
				SetActive(arg_729_1.iconTrs_.gameObject, true)
				arg_729_1.iconController_:SetSelectedState("hero")

				arg_729_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_729_1.callingController_:SetSelectedState("normal")

				arg_729_1.keyicon_.color = Color.New(1, 1, 1)
				arg_729_1.icon_.color = Color.New(1, 1, 1)

				local var_732_1 = arg_729_1:FormatText(arg_729_1:GetWordFromCfg(1108411175).content)

				arg_729_1.text_.text = var_732_1

				LuaForUtil.ClearLinePrefixSymbol(arg_729_1.text_)

				local var_732_3 = 22 <= 0 and var_732_0 or var_732_0 * (utf8.len(var_732_1) / 22)

				if (22 <= 0 and var_732_0 or var_732_0 * (utf8.len(var_732_1) / 22)) > 0 and var_732_0 < var_732_3 then
					arg_729_1.talkMaxDuration = var_732_3

					if var_732_3 + 0 > arg_729_1.duration_ then
						arg_729_1.duration_ = var_732_3 + 0
					end
				end

				arg_729_1.text_.text = var_732_1
				arg_729_1.typewritter.percent = 0

				arg_729_1.typewritter:SetDirty()
				arg_729_1:ShowNextGo(false)
				arg_729_1:RecordContent(arg_729_1.text_.text)
			end

			local var_732_4 = math.max(var_732_0, arg_729_1.talkMaxDuration)

			if 0 <= arg_729_1.time_ and arg_729_1.time_ < 0 + var_732_4 then
				arg_729_1.typewritter.percent = (arg_729_1.time_ - 0) / var_732_4

				arg_729_1.typewritter:SetDirty()
			end

			if arg_729_1.time_ >= 0 + var_732_4 and arg_729_1.time_ < 0 + var_732_4 + arg_732_0 then
				arg_729_1.typewritter.percent = 1

				arg_729_1.typewritter:SetDirty()
				arg_729_1:ShowNextGo(true)
			end
		end

		arg_729_1.nodeConfigList_ = {}

		arg_729_1:InitPlayNodeList()
	end,
	Play1108411176 = function(arg_733_0, arg_733_1)
		arg_733_1.time_ = 0
		arg_733_1.frameCnt_ = 0
		arg_733_1.state_ = "playing"
		arg_733_1.curTalkId_ = 1108411176
		arg_733_1.duration_ = 3.23

		local var_733_0 = {
			zh = 3.233,
			ja = 3.1
		}
		local var_733_1 = manager.audio:GetLocalizationFlag()

		if var_733_0[var_733_1] ~= nil then
			arg_733_1.duration_ = var_733_0[var_733_1]
		end

		SetActive(arg_733_1.tipsGo_, false)

		function arg_733_1.onSingleLineFinish_()
			arg_733_1.onSingleLineUpdate_ = nil
			arg_733_1.onSingleLineFinish_ = nil
			arg_733_1.state_ = "waiting"
		end

		function arg_733_1.playNext_(arg_735_0)
			if arg_735_0 == 1 then
				arg_733_0:Play1108411177(arg_733_1)
			end
		end

		function arg_733_1.onSingleLineUpdate_(arg_736_0)
			if 0 < arg_733_1.time_ and arg_733_1.time_ <= 0 + arg_736_0 then
				arg_733_1.var_.moveOldPos10102ui_story = arg_733_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_736_0 = 0.001

			if 0 <= arg_733_1.time_ and arg_733_1.time_ < 0 + var_736_0 then
				arg_733_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_733_1.var_.moveOldPos10102ui_story, Vector3.New(0, -0.985, -6.275), (arg_733_1.time_ - 0) / var_736_0)
				arg_733_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_733_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_733_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_733_1.actors_["10102ui_story"].transform.position).z)
				arg_733_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_733_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_733_1.actors_["10102ui_story"].transform.localEulerAngles = arg_733_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_733_1.time_ >= 0 + var_736_0 and arg_733_1.time_ < 0 + var_736_0 + arg_736_0 then
				arg_733_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6.275)
				arg_733_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_733_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_733_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_733_1.actors_["10102ui_story"].transform.position).z)
				arg_733_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_733_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_733_1.actors_["10102ui_story"].transform.localEulerAngles = arg_733_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_736_1 = arg_733_1.actors_["10102ui_story"]

			if 0 < arg_733_1.time_ and arg_733_1.time_ <= 0 + arg_736_0 and not isNil(var_736_1) and arg_733_1.var_.characterEffect10102ui_story == nil then
				arg_733_1.var_.characterEffect10102ui_story = var_736_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_736_2 = 0.200000002980232

			if 0 <= arg_733_1.time_ and arg_733_1.time_ < 0 + var_736_2 and not isNil(var_736_1) then
				if arg_733_1.var_.characterEffect10102ui_story and not isNil(var_736_1) then
					arg_733_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_733_1.time_ >= 0 + var_736_2 and arg_733_1.time_ < 0 + var_736_2 + arg_736_0 and not isNil(var_736_1) and arg_733_1.var_.characterEffect10102ui_story then
				arg_733_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_733_1.time_ and arg_733_1.time_ <= 0 + arg_736_0 then
				arg_733_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action1_1")
			end

			if 0 < arg_733_1.time_ and arg_733_1.time_ <= 0 + arg_736_0 then
				arg_733_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_xinwei", "EmotionTimelineAnimator")
			end

			local var_736_4 = 0
			local var_736_5 = 0.4

			if 0 < arg_733_1.time_ and arg_733_1.time_ <= var_736_4 + arg_736_0 then
				arg_733_1.talkMaxDuration = 0
				arg_733_1.dialogCg_.alpha = 1

				arg_733_1.dialog_:SetActive(true)
				SetActive(arg_733_1.leftNameGo_, true)

				arg_733_1.leftNameTxt_.text = arg_733_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_733_1.leftNameTxt_.transform)

				arg_733_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_733_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_733_1:RecordName(arg_733_1.leftNameTxt_.text)
				SetActive(arg_733_1.iconTrs_.gameObject, false)
				arg_733_1.callingController_:SetSelectedState("normal")

				local var_736_6 = arg_733_1:GetWordFromCfg(1108411176)
				local var_736_7 = arg_733_1:FormatText(var_736_6.content)

				arg_733_1.text_.text = var_736_7

				LuaForUtil.ClearLinePrefixSymbol(arg_733_1.text_)

				local var_736_9 = 16 <= 0 and var_736_5 or var_736_5 * (utf8.len(var_736_7) / 16)

				if (16 <= 0 and var_736_5 or var_736_5 * (utf8.len(var_736_7) / 16)) > 0 and var_736_5 < var_736_9 then
					arg_733_1.talkMaxDuration = var_736_9

					if var_736_9 + var_736_4 > arg_733_1.duration_ then
						arg_733_1.duration_ = var_736_9 + var_736_4
					end
				end

				arg_733_1.text_.text = var_736_7
				arg_733_1.typewritter.percent = 0

				arg_733_1.typewritter:SetDirty()
				arg_733_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411176", "story_v_side_new_1108411.awb") ~= 0 then
					local var_736_10 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411176", "story_v_side_new_1108411.awb") / 1000

					if var_736_10 + var_736_4 > arg_733_1.duration_ then
						arg_733_1.duration_ = var_736_10 + var_736_4
					end

					if var_736_6.prefab_name ~= "" and arg_733_1.actors_[var_736_6.prefab_name] ~= nil then
						local var_736_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_733_1.actors_[var_736_6.prefab_name].transform, "story_v_side_new_1108411", "1108411176", "story_v_side_new_1108411.awb")

						arg_733_1:RecordAudio("1108411176", var_736_11)
						arg_733_1:RecordAudio("1108411176", var_736_11)
					else
						arg_733_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411176", "story_v_side_new_1108411.awb")
					end

					arg_733_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411176", "story_v_side_new_1108411.awb")
				end

				arg_733_1:RecordContent(arg_733_1.text_.text)
			end

			local var_736_12 = math.max(var_736_5, arg_733_1.talkMaxDuration)

			if var_736_4 <= arg_733_1.time_ and arg_733_1.time_ < var_736_4 + var_736_12 then
				arg_733_1.typewritter.percent = (arg_733_1.time_ - var_736_4) / var_736_12

				arg_733_1.typewritter:SetDirty()
			end

			if arg_733_1.time_ >= var_736_4 + var_736_12 and arg_733_1.time_ < var_736_4 + var_736_12 + arg_736_0 then
				arg_733_1.typewritter.percent = 1

				arg_733_1.typewritter:SetDirty()
				arg_733_1:ShowNextGo(true)
			end
		end

		arg_733_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_733_1:InitPlayNodeList()
	end,
	Play1108411177 = function(arg_737_0, arg_737_1)
		arg_737_1.time_ = 0
		arg_737_1.frameCnt_ = 0
		arg_737_1.state_ = "playing"
		arg_737_1.curTalkId_ = 1108411177
		arg_737_1.duration_ = 5

		SetActive(arg_737_1.tipsGo_, false)

		function arg_737_1.onSingleLineFinish_()
			arg_737_1.onSingleLineUpdate_ = nil
			arg_737_1.onSingleLineFinish_ = nil
			arg_737_1.state_ = "waiting"
		end

		function arg_737_1.playNext_(arg_739_0)
			if arg_739_0 == 1 then
				arg_737_0:Play1108411178(arg_737_1)
			end
		end

		function arg_737_1.onSingleLineUpdate_(arg_740_0)
			if 0 < arg_737_1.time_ and arg_737_1.time_ <= 0 + arg_740_0 and not isNil(arg_737_1.actors_["10102ui_story"]) and arg_737_1.var_.characterEffect10102ui_story == nil then
				arg_737_1.var_.characterEffect10102ui_story = arg_737_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_740_0 = 0.200000002980232

			if 0 <= arg_737_1.time_ and arg_737_1.time_ < 0 + var_740_0 and not isNil(arg_737_1.actors_["10102ui_story"]) then
				if arg_737_1.var_.characterEffect10102ui_story and not isNil(arg_737_1.actors_["10102ui_story"]) then
					arg_737_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_737_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_737_1.time_ - 0) / var_740_0)
				end
			end

			if arg_737_1.time_ >= 0 + var_740_0 and arg_737_1.time_ < 0 + var_740_0 + arg_740_0 and not isNil(arg_737_1.actors_["10102ui_story"]) and arg_737_1.var_.characterEffect10102ui_story then
				arg_737_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_737_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_740_1 = 0
			local var_740_2 = 0.725

			if 0 < arg_737_1.time_ and arg_737_1.time_ <= var_740_1 + arg_740_0 then
				arg_737_1.talkMaxDuration = 0
				arg_737_1.dialogCg_.alpha = 1

				arg_737_1.dialog_:SetActive(true)
				SetActive(arg_737_1.leftNameGo_, true)

				arg_737_1.leftNameTxt_.text = arg_737_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_737_1.leftNameTxt_.transform)

				arg_737_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_737_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_737_1:RecordName(arg_737_1.leftNameTxt_.text)
				SetActive(arg_737_1.iconTrs_.gameObject, true)
				arg_737_1.iconController_:SetSelectedState("hero")

				arg_737_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_737_1.callingController_:SetSelectedState("normal")

				arg_737_1.keyicon_.color = Color.New(1, 1, 1)
				arg_737_1.icon_.color = Color.New(1, 1, 1)

				local var_740_3 = arg_737_1:FormatText(arg_737_1:GetWordFromCfg(1108411177).content)

				arg_737_1.text_.text = var_740_3

				LuaForUtil.ClearLinePrefixSymbol(arg_737_1.text_)

				local var_740_5 = 29 <= 0 and var_740_2 or var_740_2 * (utf8.len(var_740_3) / 29)

				if (29 <= 0 and var_740_2 or var_740_2 * (utf8.len(var_740_3) / 29)) > 0 and var_740_2 < var_740_5 then
					arg_737_1.talkMaxDuration = var_740_5

					if var_740_5 + var_740_1 > arg_737_1.duration_ then
						arg_737_1.duration_ = var_740_5 + var_740_1
					end
				end

				arg_737_1.text_.text = var_740_3
				arg_737_1.typewritter.percent = 0

				arg_737_1.typewritter:SetDirty()
				arg_737_1:ShowNextGo(false)
				arg_737_1:RecordContent(arg_737_1.text_.text)
			end

			local var_740_6 = math.max(var_740_2, arg_737_1.talkMaxDuration)

			if var_740_1 <= arg_737_1.time_ and arg_737_1.time_ < var_740_1 + var_740_6 then
				arg_737_1.typewritter.percent = (arg_737_1.time_ - var_740_1) / var_740_6

				arg_737_1.typewritter:SetDirty()
			end

			if arg_737_1.time_ >= var_740_1 + var_740_6 and arg_737_1.time_ < var_740_1 + var_740_6 + arg_740_0 then
				arg_737_1.typewritter.percent = 1

				arg_737_1.typewritter:SetDirty()
				arg_737_1:ShowNextGo(true)
			end
		end

		arg_737_1.nodeConfigList_ = {}

		arg_737_1:InitPlayNodeList()
	end,
	Play1108411178 = function(arg_741_0, arg_741_1)
		arg_741_1.time_ = 0
		arg_741_1.frameCnt_ = 0
		arg_741_1.state_ = "playing"
		arg_741_1.curTalkId_ = 1108411178
		arg_741_1.duration_ = 7.73

		local var_741_0 = {
			zh = 7.3,
			ja = 7.733
		}
		local var_741_1 = manager.audio:GetLocalizationFlag()

		if var_741_0[var_741_1] ~= nil then
			arg_741_1.duration_ = var_741_0[var_741_1]
		end

		SetActive(arg_741_1.tipsGo_, false)

		function arg_741_1.onSingleLineFinish_()
			arg_741_1.onSingleLineUpdate_ = nil
			arg_741_1.onSingleLineFinish_ = nil
			arg_741_1.state_ = "waiting"
		end

		function arg_741_1.playNext_(arg_743_0)
			if arg_743_0 == 1 then
				arg_741_0:Play1108411179(arg_741_1)
			end
		end

		function arg_741_1.onSingleLineUpdate_(arg_744_0)
			if 0 < arg_741_1.time_ and arg_741_1.time_ <= 0 + arg_744_0 and not isNil(arg_741_1.actors_["10102ui_story"]) and arg_741_1.var_.characterEffect10102ui_story == nil then
				arg_741_1.var_.characterEffect10102ui_story = arg_741_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_744_0 = 0.200000002980232

			if 0 <= arg_741_1.time_ and arg_741_1.time_ < 0 + var_744_0 and not isNil(arg_741_1.actors_["10102ui_story"]) then
				if arg_741_1.var_.characterEffect10102ui_story and not isNil(arg_741_1.actors_["10102ui_story"]) then
					arg_741_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_741_1.time_ >= 0 + var_744_0 and arg_741_1.time_ < 0 + var_744_0 + arg_744_0 and not isNil(arg_741_1.actors_["10102ui_story"]) and arg_741_1.var_.characterEffect10102ui_story then
				arg_741_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_741_1.time_ and arg_741_1.time_ <= 0 + arg_744_0 then
				arg_741_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action5_1")
			end

			if 0 < arg_741_1.time_ and arg_741_1.time_ <= 0 + arg_744_0 then
				arg_741_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_744_2 = 0
			local var_744_3 = 0.925

			if 0 < arg_741_1.time_ and arg_741_1.time_ <= var_744_2 + arg_744_0 then
				arg_741_1.talkMaxDuration = 0
				arg_741_1.dialogCg_.alpha = 1

				arg_741_1.dialog_:SetActive(true)
				SetActive(arg_741_1.leftNameGo_, true)

				arg_741_1.leftNameTxt_.text = arg_741_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_741_1.leftNameTxt_.transform)

				arg_741_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_741_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_741_1:RecordName(arg_741_1.leftNameTxt_.text)
				SetActive(arg_741_1.iconTrs_.gameObject, false)
				arg_741_1.callingController_:SetSelectedState("normal")

				local var_744_4 = arg_741_1:GetWordFromCfg(1108411178)
				local var_744_5 = arg_741_1:FormatText(var_744_4.content)

				arg_741_1.text_.text = var_744_5

				LuaForUtil.ClearLinePrefixSymbol(arg_741_1.text_)

				local var_744_7 = 37 <= 0 and var_744_3 or var_744_3 * (utf8.len(var_744_5) / 37)

				if (37 <= 0 and var_744_3 or var_744_3 * (utf8.len(var_744_5) / 37)) > 0 and var_744_3 < var_744_7 then
					arg_741_1.talkMaxDuration = var_744_7

					if var_744_7 + var_744_2 > arg_741_1.duration_ then
						arg_741_1.duration_ = var_744_7 + var_744_2
					end
				end

				arg_741_1.text_.text = var_744_5
				arg_741_1.typewritter.percent = 0

				arg_741_1.typewritter:SetDirty()
				arg_741_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411178", "story_v_side_new_1108411.awb") ~= 0 then
					local var_744_8 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411178", "story_v_side_new_1108411.awb") / 1000

					if var_744_8 + var_744_2 > arg_741_1.duration_ then
						arg_741_1.duration_ = var_744_8 + var_744_2
					end

					if var_744_4.prefab_name ~= "" and arg_741_1.actors_[var_744_4.prefab_name] ~= nil then
						local var_744_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_741_1.actors_[var_744_4.prefab_name].transform, "story_v_side_new_1108411", "1108411178", "story_v_side_new_1108411.awb")

						arg_741_1:RecordAudio("1108411178", var_744_9)
						arg_741_1:RecordAudio("1108411178", var_744_9)
					else
						arg_741_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411178", "story_v_side_new_1108411.awb")
					end

					arg_741_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411178", "story_v_side_new_1108411.awb")
				end

				arg_741_1:RecordContent(arg_741_1.text_.text)
			end

			local var_744_10 = math.max(var_744_3, arg_741_1.talkMaxDuration)

			if var_744_2 <= arg_741_1.time_ and arg_741_1.time_ < var_744_2 + var_744_10 then
				arg_741_1.typewritter.percent = (arg_741_1.time_ - var_744_2) / var_744_10

				arg_741_1.typewritter:SetDirty()
			end

			if arg_741_1.time_ >= var_744_2 + var_744_10 and arg_741_1.time_ < var_744_2 + var_744_10 + arg_744_0 then
				arg_741_1.typewritter.percent = 1

				arg_741_1.typewritter:SetDirty()
				arg_741_1:ShowNextGo(true)
			end
		end

		arg_741_1.nodeConfigList_ = {}

		arg_741_1:InitPlayNodeList()
	end,
	Play1108411179 = function(arg_745_0, arg_745_1)
		arg_745_1.time_ = 0
		arg_745_1.frameCnt_ = 0
		arg_745_1.state_ = "playing"
		arg_745_1.curTalkId_ = 1108411179
		arg_745_1.duration_ = 5

		SetActive(arg_745_1.tipsGo_, false)

		function arg_745_1.onSingleLineFinish_()
			arg_745_1.onSingleLineUpdate_ = nil
			arg_745_1.onSingleLineFinish_ = nil
			arg_745_1.state_ = "waiting"
		end

		function arg_745_1.playNext_(arg_747_0)
			if arg_747_0 == 1 then
				arg_745_0:Play1108411180(arg_745_1)
			end
		end

		function arg_745_1.onSingleLineUpdate_(arg_748_0)
			if 0 < arg_745_1.time_ and arg_745_1.time_ <= 0 + arg_748_0 and not isNil(arg_745_1.actors_["10102ui_story"]) and arg_745_1.var_.characterEffect10102ui_story == nil then
				arg_745_1.var_.characterEffect10102ui_story = arg_745_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_748_0 = 0.200000002980232

			if 0 <= arg_745_1.time_ and arg_745_1.time_ < 0 + var_748_0 and not isNil(arg_745_1.actors_["10102ui_story"]) then
				if arg_745_1.var_.characterEffect10102ui_story and not isNil(arg_745_1.actors_["10102ui_story"]) then
					arg_745_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_745_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_745_1.time_ - 0) / var_748_0)
				end
			end

			if arg_745_1.time_ >= 0 + var_748_0 and arg_745_1.time_ < 0 + var_748_0 + arg_748_0 and not isNil(arg_745_1.actors_["10102ui_story"]) and arg_745_1.var_.characterEffect10102ui_story then
				arg_745_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_745_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_748_1 = 0
			local var_748_2 = 0.425

			if 0 < arg_745_1.time_ and arg_745_1.time_ <= var_748_1 + arg_748_0 then
				arg_745_1.talkMaxDuration = 0
				arg_745_1.dialogCg_.alpha = 1

				arg_745_1.dialog_:SetActive(true)
				SetActive(arg_745_1.leftNameGo_, true)

				arg_745_1.leftNameTxt_.text = arg_745_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_745_1.leftNameTxt_.transform)

				arg_745_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_745_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_745_1:RecordName(arg_745_1.leftNameTxt_.text)
				SetActive(arg_745_1.iconTrs_.gameObject, true)
				arg_745_1.iconController_:SetSelectedState("hero")

				arg_745_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_745_1.callingController_:SetSelectedState("normal")

				arg_745_1.keyicon_.color = Color.New(1, 1, 1)
				arg_745_1.icon_.color = Color.New(1, 1, 1)

				local var_748_3 = arg_745_1:FormatText(arg_745_1:GetWordFromCfg(1108411179).content)

				arg_745_1.text_.text = var_748_3

				LuaForUtil.ClearLinePrefixSymbol(arg_745_1.text_)

				local var_748_5 = 17 <= 0 and var_748_2 or var_748_2 * (utf8.len(var_748_3) / 17)

				if (17 <= 0 and var_748_2 or var_748_2 * (utf8.len(var_748_3) / 17)) > 0 and var_748_2 < var_748_5 then
					arg_745_1.talkMaxDuration = var_748_5

					if var_748_5 + var_748_1 > arg_745_1.duration_ then
						arg_745_1.duration_ = var_748_5 + var_748_1
					end
				end

				arg_745_1.text_.text = var_748_3
				arg_745_1.typewritter.percent = 0

				arg_745_1.typewritter:SetDirty()
				arg_745_1:ShowNextGo(false)
				arg_745_1:RecordContent(arg_745_1.text_.text)
			end

			local var_748_6 = math.max(var_748_2, arg_745_1.talkMaxDuration)

			if var_748_1 <= arg_745_1.time_ and arg_745_1.time_ < var_748_1 + var_748_6 then
				arg_745_1.typewritter.percent = (arg_745_1.time_ - var_748_1) / var_748_6

				arg_745_1.typewritter:SetDirty()
			end

			if arg_745_1.time_ >= var_748_1 + var_748_6 and arg_745_1.time_ < var_748_1 + var_748_6 + arg_748_0 then
				arg_745_1.typewritter.percent = 1

				arg_745_1.typewritter:SetDirty()
				arg_745_1:ShowNextGo(true)
			end
		end

		arg_745_1.nodeConfigList_ = {}

		arg_745_1:InitPlayNodeList()
	end,
	Play1108411180 = function(arg_749_0, arg_749_1)
		arg_749_1.time_ = 0
		arg_749_1.frameCnt_ = 0
		arg_749_1.state_ = "playing"
		arg_749_1.curTalkId_ = 1108411180
		arg_749_1.duration_ = 5

		SetActive(arg_749_1.tipsGo_, false)

		function arg_749_1.onSingleLineFinish_()
			arg_749_1.onSingleLineUpdate_ = nil
			arg_749_1.onSingleLineFinish_ = nil
			arg_749_1.state_ = "waiting"
		end

		function arg_749_1.playNext_(arg_751_0)
			if arg_751_0 == 1 then
				arg_749_0:Play1108411181(arg_749_1)
			end
		end

		function arg_749_1.onSingleLineUpdate_(arg_752_0)
			local var_752_0 = 0.55

			if 0 < arg_749_1.time_ and arg_749_1.time_ <= 0 + arg_752_0 then
				arg_749_1.talkMaxDuration = 0
				arg_749_1.dialogCg_.alpha = 1

				arg_749_1.dialog_:SetActive(true)
				SetActive(arg_749_1.leftNameGo_, true)

				arg_749_1.leftNameTxt_.text = arg_749_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_749_1.leftNameTxt_.transform)

				arg_749_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_749_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_749_1:RecordName(arg_749_1.leftNameTxt_.text)
				SetActive(arg_749_1.iconTrs_.gameObject, true)
				arg_749_1.iconController_:SetSelectedState("hero")

				arg_749_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_749_1.callingController_:SetSelectedState("normal")

				arg_749_1.keyicon_.color = Color.New(1, 1, 1)
				arg_749_1.icon_.color = Color.New(1, 1, 1)

				local var_752_1 = arg_749_1:FormatText(arg_749_1:GetWordFromCfg(1108411180).content)

				arg_749_1.text_.text = var_752_1

				LuaForUtil.ClearLinePrefixSymbol(arg_749_1.text_)

				local var_752_3 = 22 <= 0 and var_752_0 or var_752_0 * (utf8.len(var_752_1) / 22)

				if (22 <= 0 and var_752_0 or var_752_0 * (utf8.len(var_752_1) / 22)) > 0 and var_752_0 < var_752_3 then
					arg_749_1.talkMaxDuration = var_752_3

					if var_752_3 + 0 > arg_749_1.duration_ then
						arg_749_1.duration_ = var_752_3 + 0
					end
				end

				arg_749_1.text_.text = var_752_1
				arg_749_1.typewritter.percent = 0

				arg_749_1.typewritter:SetDirty()
				arg_749_1:ShowNextGo(false)
				arg_749_1:RecordContent(arg_749_1.text_.text)
			end

			local var_752_4 = math.max(var_752_0, arg_749_1.talkMaxDuration)

			if 0 <= arg_749_1.time_ and arg_749_1.time_ < 0 + var_752_4 then
				arg_749_1.typewritter.percent = (arg_749_1.time_ - 0) / var_752_4

				arg_749_1.typewritter:SetDirty()
			end

			if arg_749_1.time_ >= 0 + var_752_4 and arg_749_1.time_ < 0 + var_752_4 + arg_752_0 then
				arg_749_1.typewritter.percent = 1

				arg_749_1.typewritter:SetDirty()
				arg_749_1:ShowNextGo(true)
			end
		end

		arg_749_1.nodeConfigList_ = {}

		arg_749_1:InitPlayNodeList()
	end,
	Play1108411181 = function(arg_753_0, arg_753_1)
		arg_753_1.time_ = 0
		arg_753_1.frameCnt_ = 0
		arg_753_1.state_ = "playing"
		arg_753_1.curTalkId_ = 1108411181
		arg_753_1.duration_ = 5.87

		local var_753_0 = {
			zh = 3.966,
			ja = 5.866
		}
		local var_753_1 = manager.audio:GetLocalizationFlag()

		if var_753_0[var_753_1] ~= nil then
			arg_753_1.duration_ = var_753_0[var_753_1]
		end

		SetActive(arg_753_1.tipsGo_, false)

		function arg_753_1.onSingleLineFinish_()
			arg_753_1.onSingleLineUpdate_ = nil
			arg_753_1.onSingleLineFinish_ = nil
			arg_753_1.state_ = "waiting"
		end

		function arg_753_1.playNext_(arg_755_0)
			if arg_755_0 == 1 then
				arg_753_0:Play1108411182(arg_753_1)
			end
		end

		function arg_753_1.onSingleLineUpdate_(arg_756_0)
			if 0 < arg_753_1.time_ and arg_753_1.time_ <= 0 + arg_756_0 and not isNil(arg_753_1.actors_["10102ui_story"]) and arg_753_1.var_.characterEffect10102ui_story == nil then
				arg_753_1.var_.characterEffect10102ui_story = arg_753_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_756_0 = 0.200000002980232

			if 0 <= arg_753_1.time_ and arg_753_1.time_ < 0 + var_756_0 and not isNil(arg_753_1.actors_["10102ui_story"]) then
				if arg_753_1.var_.characterEffect10102ui_story and not isNil(arg_753_1.actors_["10102ui_story"]) then
					arg_753_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_753_1.time_ >= 0 + var_756_0 and arg_753_1.time_ < 0 + var_756_0 + arg_756_0 and not isNil(arg_753_1.actors_["10102ui_story"]) and arg_753_1.var_.characterEffect10102ui_story then
				arg_753_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_753_1.time_ and arg_753_1.time_ <= 0 + arg_756_0 then
				arg_753_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action5_2")
			end

			if 0 < arg_753_1.time_ and arg_753_1.time_ <= 0 + arg_756_0 then
				arg_753_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_756_2 = 0
			local var_756_3 = 0.55

			if 0 < arg_753_1.time_ and arg_753_1.time_ <= var_756_2 + arg_756_0 then
				arg_753_1.talkMaxDuration = 0
				arg_753_1.dialogCg_.alpha = 1

				arg_753_1.dialog_:SetActive(true)
				SetActive(arg_753_1.leftNameGo_, true)

				arg_753_1.leftNameTxt_.text = arg_753_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_753_1.leftNameTxt_.transform)

				arg_753_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_753_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_753_1:RecordName(arg_753_1.leftNameTxt_.text)
				SetActive(arg_753_1.iconTrs_.gameObject, false)
				arg_753_1.callingController_:SetSelectedState("normal")

				local var_756_4 = arg_753_1:GetWordFromCfg(1108411181)
				local var_756_5 = arg_753_1:FormatText(var_756_4.content)

				arg_753_1.text_.text = var_756_5

				LuaForUtil.ClearLinePrefixSymbol(arg_753_1.text_)

				local var_756_7 = 22 <= 0 and var_756_3 or var_756_3 * (utf8.len(var_756_5) / 22)

				if (22 <= 0 and var_756_3 or var_756_3 * (utf8.len(var_756_5) / 22)) > 0 and var_756_3 < var_756_7 then
					arg_753_1.talkMaxDuration = var_756_7

					if var_756_7 + var_756_2 > arg_753_1.duration_ then
						arg_753_1.duration_ = var_756_7 + var_756_2
					end
				end

				arg_753_1.text_.text = var_756_5
				arg_753_1.typewritter.percent = 0

				arg_753_1.typewritter:SetDirty()
				arg_753_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411181", "story_v_side_new_1108411.awb") ~= 0 then
					local var_756_8 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411181", "story_v_side_new_1108411.awb") / 1000

					if var_756_8 + var_756_2 > arg_753_1.duration_ then
						arg_753_1.duration_ = var_756_8 + var_756_2
					end

					if var_756_4.prefab_name ~= "" and arg_753_1.actors_[var_756_4.prefab_name] ~= nil then
						local var_756_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_753_1.actors_[var_756_4.prefab_name].transform, "story_v_side_new_1108411", "1108411181", "story_v_side_new_1108411.awb")

						arg_753_1:RecordAudio("1108411181", var_756_9)
						arg_753_1:RecordAudio("1108411181", var_756_9)
					else
						arg_753_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411181", "story_v_side_new_1108411.awb")
					end

					arg_753_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411181", "story_v_side_new_1108411.awb")
				end

				arg_753_1:RecordContent(arg_753_1.text_.text)
			end

			local var_756_10 = math.max(var_756_3, arg_753_1.talkMaxDuration)

			if var_756_2 <= arg_753_1.time_ and arg_753_1.time_ < var_756_2 + var_756_10 then
				arg_753_1.typewritter.percent = (arg_753_1.time_ - var_756_2) / var_756_10

				arg_753_1.typewritter:SetDirty()
			end

			if arg_753_1.time_ >= var_756_2 + var_756_10 and arg_753_1.time_ < var_756_2 + var_756_10 + arg_756_0 then
				arg_753_1.typewritter.percent = 1

				arg_753_1.typewritter:SetDirty()
				arg_753_1:ShowNextGo(true)
			end
		end

		arg_753_1.nodeConfigList_ = {}

		arg_753_1:InitPlayNodeList()
	end,
	Play1108411182 = function(arg_757_0, arg_757_1)
		arg_757_1.time_ = 0
		arg_757_1.frameCnt_ = 0
		arg_757_1.state_ = "playing"
		arg_757_1.curTalkId_ = 1108411182
		arg_757_1.duration_ = 7.4

		local var_757_0 = {
			zh = 5.1,
			ja = 7.4
		}
		local var_757_1 = manager.audio:GetLocalizationFlag()

		if var_757_0[var_757_1] ~= nil then
			arg_757_1.duration_ = var_757_0[var_757_1]
		end

		SetActive(arg_757_1.tipsGo_, false)

		function arg_757_1.onSingleLineFinish_()
			arg_757_1.onSingleLineUpdate_ = nil
			arg_757_1.onSingleLineFinish_ = nil
			arg_757_1.state_ = "waiting"
		end

		function arg_757_1.playNext_(arg_759_0)
			if arg_759_0 == 1 then
				arg_757_0:Play1108411183(arg_757_1)
			end
		end

		function arg_757_1.onSingleLineUpdate_(arg_760_0)
			local var_760_0 = 0.7

			if 0 < arg_757_1.time_ and arg_757_1.time_ <= 0 + arg_760_0 then
				arg_757_1.talkMaxDuration = 0
				arg_757_1.dialogCg_.alpha = 1

				arg_757_1.dialog_:SetActive(true)
				SetActive(arg_757_1.leftNameGo_, true)

				arg_757_1.leftNameTxt_.text = arg_757_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_757_1.leftNameTxt_.transform)

				arg_757_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_757_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_757_1:RecordName(arg_757_1.leftNameTxt_.text)
				SetActive(arg_757_1.iconTrs_.gameObject, false)
				arg_757_1.callingController_:SetSelectedState("normal")

				local var_760_1 = arg_757_1:GetWordFromCfg(1108411182)
				local var_760_2 = arg_757_1:FormatText(var_760_1.content)

				arg_757_1.text_.text = var_760_2

				LuaForUtil.ClearLinePrefixSymbol(arg_757_1.text_)

				local var_760_4 = 28 <= 0 and var_760_0 or var_760_0 * (utf8.len(var_760_2) / 28)

				if (28 <= 0 and var_760_0 or var_760_0 * (utf8.len(var_760_2) / 28)) > 0 and var_760_0 < var_760_4 then
					arg_757_1.talkMaxDuration = var_760_4

					if var_760_4 + 0 > arg_757_1.duration_ then
						arg_757_1.duration_ = var_760_4 + 0
					end
				end

				arg_757_1.text_.text = var_760_2
				arg_757_1.typewritter.percent = 0

				arg_757_1.typewritter:SetDirty()
				arg_757_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411182", "story_v_side_new_1108411.awb") ~= 0 then
					local var_760_5 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411182", "story_v_side_new_1108411.awb") / 1000

					if var_760_5 + 0 > arg_757_1.duration_ then
						arg_757_1.duration_ = var_760_5 + 0
					end

					if var_760_1.prefab_name ~= "" and arg_757_1.actors_[var_760_1.prefab_name] ~= nil then
						local var_760_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_757_1.actors_[var_760_1.prefab_name].transform, "story_v_side_new_1108411", "1108411182", "story_v_side_new_1108411.awb")

						arg_757_1:RecordAudio("1108411182", var_760_6)
						arg_757_1:RecordAudio("1108411182", var_760_6)
					else
						arg_757_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411182", "story_v_side_new_1108411.awb")
					end

					arg_757_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411182", "story_v_side_new_1108411.awb")
				end

				arg_757_1:RecordContent(arg_757_1.text_.text)
			end

			local var_760_7 = math.max(var_760_0, arg_757_1.talkMaxDuration)

			if 0 <= arg_757_1.time_ and arg_757_1.time_ < 0 + var_760_7 then
				arg_757_1.typewritter.percent = (arg_757_1.time_ - 0) / var_760_7

				arg_757_1.typewritter:SetDirty()
			end

			if arg_757_1.time_ >= 0 + var_760_7 and arg_757_1.time_ < 0 + var_760_7 + arg_760_0 then
				arg_757_1.typewritter.percent = 1

				arg_757_1.typewritter:SetDirty()
				arg_757_1:ShowNextGo(true)
			end
		end

		arg_757_1.nodeConfigList_ = {}

		arg_757_1:InitPlayNodeList()
	end,
	Play1108411183 = function(arg_761_0, arg_761_1)
		arg_761_1.time_ = 0
		arg_761_1.frameCnt_ = 0
		arg_761_1.state_ = "playing"
		arg_761_1.curTalkId_ = 1108411183
		arg_761_1.duration_ = 5

		SetActive(arg_761_1.tipsGo_, false)

		function arg_761_1.onSingleLineFinish_()
			arg_761_1.onSingleLineUpdate_ = nil
			arg_761_1.onSingleLineFinish_ = nil
			arg_761_1.state_ = "waiting"
		end

		function arg_761_1.playNext_(arg_763_0)
			if arg_763_0 == 1 then
				arg_761_0:Play1108411184(arg_761_1)
			end
		end

		function arg_761_1.onSingleLineUpdate_(arg_764_0)
			if 0 < arg_761_1.time_ and arg_761_1.time_ <= 0 + arg_764_0 and not isNil(arg_761_1.actors_["10102ui_story"]) and arg_761_1.var_.characterEffect10102ui_story == nil then
				arg_761_1.var_.characterEffect10102ui_story = arg_761_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_764_0 = 0.200000002980232

			if 0 <= arg_761_1.time_ and arg_761_1.time_ < 0 + var_764_0 and not isNil(arg_761_1.actors_["10102ui_story"]) then
				if arg_761_1.var_.characterEffect10102ui_story and not isNil(arg_761_1.actors_["10102ui_story"]) then
					arg_761_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_761_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_761_1.time_ - 0) / var_764_0)
				end
			end

			if arg_761_1.time_ >= 0 + var_764_0 and arg_761_1.time_ < 0 + var_764_0 + arg_764_0 and not isNil(arg_761_1.actors_["10102ui_story"]) and arg_761_1.var_.characterEffect10102ui_story then
				arg_761_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_761_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_764_1 = 0
			local var_764_2 = 0.2

			if 0 < arg_761_1.time_ and arg_761_1.time_ <= var_764_1 + arg_764_0 then
				arg_761_1.talkMaxDuration = 0
				arg_761_1.dialogCg_.alpha = 1

				arg_761_1.dialog_:SetActive(true)
				SetActive(arg_761_1.leftNameGo_, true)

				arg_761_1.leftNameTxt_.text = arg_761_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_761_1.leftNameTxt_.transform)

				arg_761_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_761_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_761_1:RecordName(arg_761_1.leftNameTxt_.text)
				SetActive(arg_761_1.iconTrs_.gameObject, true)
				arg_761_1.iconController_:SetSelectedState("hero")

				arg_761_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_761_1.callingController_:SetSelectedState("normal")

				arg_761_1.keyicon_.color = Color.New(1, 1, 1)
				arg_761_1.icon_.color = Color.New(1, 1, 1)

				local var_764_3 = arg_761_1:FormatText(arg_761_1:GetWordFromCfg(1108411183).content)

				arg_761_1.text_.text = var_764_3

				LuaForUtil.ClearLinePrefixSymbol(arg_761_1.text_)

				local var_764_5 = 8 <= 0 and var_764_2 or var_764_2 * (utf8.len(var_764_3) / 8)

				if (8 <= 0 and var_764_2 or var_764_2 * (utf8.len(var_764_3) / 8)) > 0 and var_764_2 < var_764_5 then
					arg_761_1.talkMaxDuration = var_764_5

					if var_764_5 + var_764_1 > arg_761_1.duration_ then
						arg_761_1.duration_ = var_764_5 + var_764_1
					end
				end

				arg_761_1.text_.text = var_764_3
				arg_761_1.typewritter.percent = 0

				arg_761_1.typewritter:SetDirty()
				arg_761_1:ShowNextGo(false)
				arg_761_1:RecordContent(arg_761_1.text_.text)
			end

			local var_764_6 = math.max(var_764_2, arg_761_1.talkMaxDuration)

			if var_764_1 <= arg_761_1.time_ and arg_761_1.time_ < var_764_1 + var_764_6 then
				arg_761_1.typewritter.percent = (arg_761_1.time_ - var_764_1) / var_764_6

				arg_761_1.typewritter:SetDirty()
			end

			if arg_761_1.time_ >= var_764_1 + var_764_6 and arg_761_1.time_ < var_764_1 + var_764_6 + arg_764_0 then
				arg_761_1.typewritter.percent = 1

				arg_761_1.typewritter:SetDirty()
				arg_761_1:ShowNextGo(true)
			end
		end

		arg_761_1.nodeConfigList_ = {}

		arg_761_1:InitPlayNodeList()
	end,
	Play1108411184 = function(arg_765_0, arg_765_1)
		arg_765_1.time_ = 0
		arg_765_1.frameCnt_ = 0
		arg_765_1.state_ = "playing"
		arg_765_1.curTalkId_ = 1108411184
		arg_765_1.duration_ = 4.63

		local var_765_0 = {
			zh = 2.966,
			ja = 4.633
		}
		local var_765_1 = manager.audio:GetLocalizationFlag()

		if var_765_0[var_765_1] ~= nil then
			arg_765_1.duration_ = var_765_0[var_765_1]
		end

		SetActive(arg_765_1.tipsGo_, false)

		function arg_765_1.onSingleLineFinish_()
			arg_765_1.onSingleLineUpdate_ = nil
			arg_765_1.onSingleLineFinish_ = nil
			arg_765_1.state_ = "waiting"
		end

		function arg_765_1.playNext_(arg_767_0)
			if arg_767_0 == 1 then
				arg_765_0:Play1108411185(arg_765_1)
			end
		end

		function arg_765_1.onSingleLineUpdate_(arg_768_0)
			if 0 < arg_765_1.time_ and arg_765_1.time_ <= 0 + arg_768_0 and not isNil(arg_765_1.actors_["10102ui_story"]) and arg_765_1.var_.characterEffect10102ui_story == nil then
				arg_765_1.var_.characterEffect10102ui_story = arg_765_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_768_0 = 0.200000002980232

			if 0 <= arg_765_1.time_ and arg_765_1.time_ < 0 + var_768_0 and not isNil(arg_765_1.actors_["10102ui_story"]) then
				if arg_765_1.var_.characterEffect10102ui_story and not isNil(arg_765_1.actors_["10102ui_story"]) then
					arg_765_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_765_1.time_ >= 0 + var_768_0 and arg_765_1.time_ < 0 + var_768_0 + arg_768_0 and not isNil(arg_765_1.actors_["10102ui_story"]) and arg_765_1.var_.characterEffect10102ui_story then
				arg_765_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_768_2 = 0
			local var_768_3 = 0.375

			if 0 < arg_765_1.time_ and arg_765_1.time_ <= var_768_2 + arg_768_0 then
				arg_765_1.talkMaxDuration = 0
				arg_765_1.dialogCg_.alpha = 1

				arg_765_1.dialog_:SetActive(true)
				SetActive(arg_765_1.leftNameGo_, true)

				arg_765_1.leftNameTxt_.text = arg_765_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_765_1.leftNameTxt_.transform)

				arg_765_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_765_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_765_1:RecordName(arg_765_1.leftNameTxt_.text)
				SetActive(arg_765_1.iconTrs_.gameObject, false)
				arg_765_1.callingController_:SetSelectedState("normal")

				local var_768_4 = arg_765_1:GetWordFromCfg(1108411184)
				local var_768_5 = arg_765_1:FormatText(var_768_4.content)

				arg_765_1.text_.text = var_768_5

				LuaForUtil.ClearLinePrefixSymbol(arg_765_1.text_)

				local var_768_7 = 15 <= 0 and var_768_3 or var_768_3 * (utf8.len(var_768_5) / 15)

				if (15 <= 0 and var_768_3 or var_768_3 * (utf8.len(var_768_5) / 15)) > 0 and var_768_3 < var_768_7 then
					arg_765_1.talkMaxDuration = var_768_7

					if var_768_7 + var_768_2 > arg_765_1.duration_ then
						arg_765_1.duration_ = var_768_7 + var_768_2
					end
				end

				arg_765_1.text_.text = var_768_5
				arg_765_1.typewritter.percent = 0

				arg_765_1.typewritter:SetDirty()
				arg_765_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411184", "story_v_side_new_1108411.awb") ~= 0 then
					local var_768_8 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411184", "story_v_side_new_1108411.awb") / 1000

					if var_768_8 + var_768_2 > arg_765_1.duration_ then
						arg_765_1.duration_ = var_768_8 + var_768_2
					end

					if var_768_4.prefab_name ~= "" and arg_765_1.actors_[var_768_4.prefab_name] ~= nil then
						local var_768_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_765_1.actors_[var_768_4.prefab_name].transform, "story_v_side_new_1108411", "1108411184", "story_v_side_new_1108411.awb")

						arg_765_1:RecordAudio("1108411184", var_768_9)
						arg_765_1:RecordAudio("1108411184", var_768_9)
					else
						arg_765_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411184", "story_v_side_new_1108411.awb")
					end

					arg_765_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411184", "story_v_side_new_1108411.awb")
				end

				arg_765_1:RecordContent(arg_765_1.text_.text)
			end

			local var_768_10 = math.max(var_768_3, arg_765_1.talkMaxDuration)

			if var_768_2 <= arg_765_1.time_ and arg_765_1.time_ < var_768_2 + var_768_10 then
				arg_765_1.typewritter.percent = (arg_765_1.time_ - var_768_2) / var_768_10

				arg_765_1.typewritter:SetDirty()
			end

			if arg_765_1.time_ >= var_768_2 + var_768_10 and arg_765_1.time_ < var_768_2 + var_768_10 + arg_768_0 then
				arg_765_1.typewritter.percent = 1

				arg_765_1.typewritter:SetDirty()
				arg_765_1:ShowNextGo(true)
			end
		end

		arg_765_1.nodeConfigList_ = {}

		arg_765_1:InitPlayNodeList()
	end,
	Play1108411185 = function(arg_769_0, arg_769_1)
		arg_769_1.time_ = 0
		arg_769_1.frameCnt_ = 0
		arg_769_1.state_ = "playing"
		arg_769_1.curTalkId_ = 1108411185
		arg_769_1.duration_ = 5

		SetActive(arg_769_1.tipsGo_, false)

		function arg_769_1.onSingleLineFinish_()
			arg_769_1.onSingleLineUpdate_ = nil
			arg_769_1.onSingleLineFinish_ = nil
			arg_769_1.state_ = "waiting"
		end

		function arg_769_1.playNext_(arg_771_0)
			if arg_771_0 == 1 then
				arg_769_0:Play1108411186(arg_769_1)
			end
		end

		function arg_769_1.onSingleLineUpdate_(arg_772_0)
			if 0 < arg_769_1.time_ and arg_769_1.time_ <= 0 + arg_772_0 and not isNil(arg_769_1.actors_["10102ui_story"]) and arg_769_1.var_.characterEffect10102ui_story == nil then
				arg_769_1.var_.characterEffect10102ui_story = arg_769_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_772_0 = 0.200000002980232

			if 0 <= arg_769_1.time_ and arg_769_1.time_ < 0 + var_772_0 and not isNil(arg_769_1.actors_["10102ui_story"]) then
				if arg_769_1.var_.characterEffect10102ui_story and not isNil(arg_769_1.actors_["10102ui_story"]) then
					arg_769_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_769_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_769_1.time_ - 0) / var_772_0)
				end
			end

			if arg_769_1.time_ >= 0 + var_772_0 and arg_769_1.time_ < 0 + var_772_0 + arg_772_0 and not isNil(arg_769_1.actors_["10102ui_story"]) and arg_769_1.var_.characterEffect10102ui_story then
				arg_769_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_769_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_772_1 = 0
			local var_772_2 = 1.05

			if 0 < arg_769_1.time_ and arg_769_1.time_ <= var_772_1 + arg_772_0 then
				arg_769_1.talkMaxDuration = 0
				arg_769_1.dialogCg_.alpha = 1

				arg_769_1.dialog_:SetActive(true)
				SetActive(arg_769_1.leftNameGo_, true)

				arg_769_1.leftNameTxt_.text = arg_769_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_769_1.leftNameTxt_.transform)

				arg_769_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_769_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_769_1:RecordName(arg_769_1.leftNameTxt_.text)
				SetActive(arg_769_1.iconTrs_.gameObject, true)
				arg_769_1.iconController_:SetSelectedState("hero")

				arg_769_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_769_1.callingController_:SetSelectedState("normal")

				arg_769_1.keyicon_.color = Color.New(1, 1, 1)
				arg_769_1.icon_.color = Color.New(1, 1, 1)

				local var_772_3 = arg_769_1:FormatText(arg_769_1:GetWordFromCfg(1108411185).content)

				arg_769_1.text_.text = var_772_3

				LuaForUtil.ClearLinePrefixSymbol(arg_769_1.text_)

				local var_772_5 = 42 <= 0 and var_772_2 or var_772_2 * (utf8.len(var_772_3) / 42)

				if (42 <= 0 and var_772_2 or var_772_2 * (utf8.len(var_772_3) / 42)) > 0 and var_772_2 < var_772_5 then
					arg_769_1.talkMaxDuration = var_772_5

					if var_772_5 + var_772_1 > arg_769_1.duration_ then
						arg_769_1.duration_ = var_772_5 + var_772_1
					end
				end

				arg_769_1.text_.text = var_772_3
				arg_769_1.typewritter.percent = 0

				arg_769_1.typewritter:SetDirty()
				arg_769_1:ShowNextGo(false)
				arg_769_1:RecordContent(arg_769_1.text_.text)
			end

			local var_772_6 = math.max(var_772_2, arg_769_1.talkMaxDuration)

			if var_772_1 <= arg_769_1.time_ and arg_769_1.time_ < var_772_1 + var_772_6 then
				arg_769_1.typewritter.percent = (arg_769_1.time_ - var_772_1) / var_772_6

				arg_769_1.typewritter:SetDirty()
			end

			if arg_769_1.time_ >= var_772_1 + var_772_6 and arg_769_1.time_ < var_772_1 + var_772_6 + arg_772_0 then
				arg_769_1.typewritter.percent = 1

				arg_769_1.typewritter:SetDirty()
				arg_769_1:ShowNextGo(true)
			end
		end

		arg_769_1.nodeConfigList_ = {}

		arg_769_1:InitPlayNodeList()
	end,
	Play1108411186 = function(arg_773_0, arg_773_1)
		arg_773_1.time_ = 0
		arg_773_1.frameCnt_ = 0
		arg_773_1.state_ = "playing"
		arg_773_1.curTalkId_ = 1108411186
		arg_773_1.duration_ = 6.6

		local var_773_0 = {
			zh = 4,
			ja = 6.6
		}
		local var_773_1 = manager.audio:GetLocalizationFlag()

		if var_773_0[var_773_1] ~= nil then
			arg_773_1.duration_ = var_773_0[var_773_1]
		end

		SetActive(arg_773_1.tipsGo_, false)

		function arg_773_1.onSingleLineFinish_()
			arg_773_1.onSingleLineUpdate_ = nil
			arg_773_1.onSingleLineFinish_ = nil
			arg_773_1.state_ = "waiting"
		end

		function arg_773_1.playNext_(arg_775_0)
			if arg_775_0 == 1 then
				arg_773_0:Play1108411187(arg_773_1)
			end
		end

		function arg_773_1.onSingleLineUpdate_(arg_776_0)
			if 0 < arg_773_1.time_ and arg_773_1.time_ <= 0 + arg_776_0 and not isNil(arg_773_1.actors_["10102ui_story"]) and arg_773_1.var_.characterEffect10102ui_story == nil then
				arg_773_1.var_.characterEffect10102ui_story = arg_773_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_776_0 = 0.200000002980232

			if 0 <= arg_773_1.time_ and arg_773_1.time_ < 0 + var_776_0 and not isNil(arg_773_1.actors_["10102ui_story"]) then
				if arg_773_1.var_.characterEffect10102ui_story and not isNil(arg_773_1.actors_["10102ui_story"]) then
					arg_773_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_773_1.time_ >= 0 + var_776_0 and arg_773_1.time_ < 0 + var_776_0 + arg_776_0 and not isNil(arg_773_1.actors_["10102ui_story"]) and arg_773_1.var_.characterEffect10102ui_story then
				arg_773_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_773_1.time_ and arg_773_1.time_ <= 0 + arg_776_0 then
				arg_773_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action4_1")
			end

			if 0 < arg_773_1.time_ and arg_773_1.time_ <= 0 + arg_776_0 then
				arg_773_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_deyiA", "EmotionTimelineAnimator")
			end

			local var_776_2 = 0
			local var_776_3 = 0.5

			if 0 < arg_773_1.time_ and arg_773_1.time_ <= var_776_2 + arg_776_0 then
				arg_773_1.talkMaxDuration = 0
				arg_773_1.dialogCg_.alpha = 1

				arg_773_1.dialog_:SetActive(true)
				SetActive(arg_773_1.leftNameGo_, true)

				arg_773_1.leftNameTxt_.text = arg_773_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_773_1.leftNameTxt_.transform)

				arg_773_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_773_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_773_1:RecordName(arg_773_1.leftNameTxt_.text)
				SetActive(arg_773_1.iconTrs_.gameObject, false)
				arg_773_1.callingController_:SetSelectedState("normal")

				local var_776_4 = arg_773_1:GetWordFromCfg(1108411186)
				local var_776_5 = arg_773_1:FormatText(var_776_4.content)

				arg_773_1.text_.text = var_776_5

				LuaForUtil.ClearLinePrefixSymbol(arg_773_1.text_)

				local var_776_7 = 20 <= 0 and var_776_3 or var_776_3 * (utf8.len(var_776_5) / 20)

				if (20 <= 0 and var_776_3 or var_776_3 * (utf8.len(var_776_5) / 20)) > 0 and var_776_3 < var_776_7 then
					arg_773_1.talkMaxDuration = var_776_7

					if var_776_7 + var_776_2 > arg_773_1.duration_ then
						arg_773_1.duration_ = var_776_7 + var_776_2
					end
				end

				arg_773_1.text_.text = var_776_5
				arg_773_1.typewritter.percent = 0

				arg_773_1.typewritter:SetDirty()
				arg_773_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411186", "story_v_side_new_1108411.awb") ~= 0 then
					local var_776_8 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411186", "story_v_side_new_1108411.awb") / 1000

					if var_776_8 + var_776_2 > arg_773_1.duration_ then
						arg_773_1.duration_ = var_776_8 + var_776_2
					end

					if var_776_4.prefab_name ~= "" and arg_773_1.actors_[var_776_4.prefab_name] ~= nil then
						local var_776_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_773_1.actors_[var_776_4.prefab_name].transform, "story_v_side_new_1108411", "1108411186", "story_v_side_new_1108411.awb")

						arg_773_1:RecordAudio("1108411186", var_776_9)
						arg_773_1:RecordAudio("1108411186", var_776_9)
					else
						arg_773_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411186", "story_v_side_new_1108411.awb")
					end

					arg_773_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411186", "story_v_side_new_1108411.awb")
				end

				arg_773_1:RecordContent(arg_773_1.text_.text)
			end

			local var_776_10 = math.max(var_776_3, arg_773_1.talkMaxDuration)

			if var_776_2 <= arg_773_1.time_ and arg_773_1.time_ < var_776_2 + var_776_10 then
				arg_773_1.typewritter.percent = (arg_773_1.time_ - var_776_2) / var_776_10

				arg_773_1.typewritter:SetDirty()
			end

			if arg_773_1.time_ >= var_776_2 + var_776_10 and arg_773_1.time_ < var_776_2 + var_776_10 + arg_776_0 then
				arg_773_1.typewritter.percent = 1

				arg_773_1.typewritter:SetDirty()
				arg_773_1:ShowNextGo(true)
			end
		end

		arg_773_1.nodeConfigList_ = {}

		arg_773_1:InitPlayNodeList()
	end,
	Play1108411187 = function(arg_777_0, arg_777_1)
		arg_777_1.time_ = 0
		arg_777_1.frameCnt_ = 0
		arg_777_1.state_ = "playing"
		arg_777_1.curTalkId_ = 1108411187
		arg_777_1.duration_ = 5

		SetActive(arg_777_1.tipsGo_, false)

		function arg_777_1.onSingleLineFinish_()
			arg_777_1.onSingleLineUpdate_ = nil
			arg_777_1.onSingleLineFinish_ = nil
			arg_777_1.state_ = "waiting"
		end

		function arg_777_1.playNext_(arg_779_0)
			if arg_779_0 == 1 then
				arg_777_0:Play1108411188(arg_777_1)
			end
		end

		function arg_777_1.onSingleLineUpdate_(arg_780_0)
			if 0 < arg_777_1.time_ and arg_777_1.time_ <= 0 + arg_780_0 and not isNil(arg_777_1.actors_["10102ui_story"]) and arg_777_1.var_.characterEffect10102ui_story == nil then
				arg_777_1.var_.characterEffect10102ui_story = arg_777_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_780_0 = 0.200000002980232

			if 0 <= arg_777_1.time_ and arg_777_1.time_ < 0 + var_780_0 and not isNil(arg_777_1.actors_["10102ui_story"]) then
				if arg_777_1.var_.characterEffect10102ui_story and not isNil(arg_777_1.actors_["10102ui_story"]) then
					arg_777_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_777_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_777_1.time_ - 0) / var_780_0)
				end
			end

			if arg_777_1.time_ >= 0 + var_780_0 and arg_777_1.time_ < 0 + var_780_0 + arg_780_0 and not isNil(arg_777_1.actors_["10102ui_story"]) and arg_777_1.var_.characterEffect10102ui_story then
				arg_777_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_777_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_780_1 = 0
			local var_780_2 = 0.45

			if 0 < arg_777_1.time_ and arg_777_1.time_ <= var_780_1 + arg_780_0 then
				arg_777_1.talkMaxDuration = 0
				arg_777_1.dialogCg_.alpha = 1

				arg_777_1.dialog_:SetActive(true)
				SetActive(arg_777_1.leftNameGo_, true)

				arg_777_1.leftNameTxt_.text = arg_777_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_777_1.leftNameTxt_.transform)

				arg_777_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_777_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_777_1:RecordName(arg_777_1.leftNameTxt_.text)
				SetActive(arg_777_1.iconTrs_.gameObject, true)
				arg_777_1.iconController_:SetSelectedState("hero")

				arg_777_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_777_1.callingController_:SetSelectedState("normal")

				arg_777_1.keyicon_.color = Color.New(1, 1, 1)
				arg_777_1.icon_.color = Color.New(1, 1, 1)

				local var_780_3 = arg_777_1:FormatText(arg_777_1:GetWordFromCfg(1108411187).content)

				arg_777_1.text_.text = var_780_3

				LuaForUtil.ClearLinePrefixSymbol(arg_777_1.text_)

				local var_780_5 = 18 <= 0 and var_780_2 or var_780_2 * (utf8.len(var_780_3) / 18)

				if (18 <= 0 and var_780_2 or var_780_2 * (utf8.len(var_780_3) / 18)) > 0 and var_780_2 < var_780_5 then
					arg_777_1.talkMaxDuration = var_780_5

					if var_780_5 + var_780_1 > arg_777_1.duration_ then
						arg_777_1.duration_ = var_780_5 + var_780_1
					end
				end

				arg_777_1.text_.text = var_780_3
				arg_777_1.typewritter.percent = 0

				arg_777_1.typewritter:SetDirty()
				arg_777_1:ShowNextGo(false)
				arg_777_1:RecordContent(arg_777_1.text_.text)
			end

			local var_780_6 = math.max(var_780_2, arg_777_1.talkMaxDuration)

			if var_780_1 <= arg_777_1.time_ and arg_777_1.time_ < var_780_1 + var_780_6 then
				arg_777_1.typewritter.percent = (arg_777_1.time_ - var_780_1) / var_780_6

				arg_777_1.typewritter:SetDirty()
			end

			if arg_777_1.time_ >= var_780_1 + var_780_6 and arg_777_1.time_ < var_780_1 + var_780_6 + arg_780_0 then
				arg_777_1.typewritter.percent = 1

				arg_777_1.typewritter:SetDirty()
				arg_777_1:ShowNextGo(true)
			end
		end

		arg_777_1.nodeConfigList_ = {}

		arg_777_1:InitPlayNodeList()
	end,
	Play1108411188 = function(arg_781_0, arg_781_1)
		arg_781_1.time_ = 0
		arg_781_1.frameCnt_ = 0
		arg_781_1.state_ = "playing"
		arg_781_1.curTalkId_ = 1108411188
		arg_781_1.duration_ = 6.73

		local var_781_0 = {
			zh = 6.2,
			ja = 6.733
		}
		local var_781_1 = manager.audio:GetLocalizationFlag()

		if var_781_0[var_781_1] ~= nil then
			arg_781_1.duration_ = var_781_0[var_781_1]
		end

		SetActive(arg_781_1.tipsGo_, false)

		function arg_781_1.onSingleLineFinish_()
			arg_781_1.onSingleLineUpdate_ = nil
			arg_781_1.onSingleLineFinish_ = nil
			arg_781_1.state_ = "waiting"
		end

		function arg_781_1.playNext_(arg_783_0)
			if arg_783_0 == 1 then
				arg_781_0:Play1108411189(arg_781_1)
			end
		end

		function arg_781_1.onSingleLineUpdate_(arg_784_0)
			if 0 < arg_781_1.time_ and arg_781_1.time_ <= 0 + arg_784_0 and not isNil(arg_781_1.actors_["10102ui_story"]) and arg_781_1.var_.characterEffect10102ui_story == nil then
				arg_781_1.var_.characterEffect10102ui_story = arg_781_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_784_0 = 0.200000002980232

			if 0 <= arg_781_1.time_ and arg_781_1.time_ < 0 + var_784_0 and not isNil(arg_781_1.actors_["10102ui_story"]) then
				if arg_781_1.var_.characterEffect10102ui_story and not isNil(arg_781_1.actors_["10102ui_story"]) then
					arg_781_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_781_1.time_ >= 0 + var_784_0 and arg_781_1.time_ < 0 + var_784_0 + arg_784_0 and not isNil(arg_781_1.actors_["10102ui_story"]) and arg_781_1.var_.characterEffect10102ui_story then
				arg_781_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_781_1.time_ and arg_781_1.time_ <= 0 + arg_784_0 then
				arg_781_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action4_2")
			end

			local var_784_2 = 0
			local var_784_3 = 0.7

			if 0 < arg_781_1.time_ and arg_781_1.time_ <= var_784_2 + arg_784_0 then
				arg_781_1.talkMaxDuration = 0
				arg_781_1.dialogCg_.alpha = 1

				arg_781_1.dialog_:SetActive(true)
				SetActive(arg_781_1.leftNameGo_, true)

				arg_781_1.leftNameTxt_.text = arg_781_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_781_1.leftNameTxt_.transform)

				arg_781_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_781_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_781_1:RecordName(arg_781_1.leftNameTxt_.text)
				SetActive(arg_781_1.iconTrs_.gameObject, false)
				arg_781_1.callingController_:SetSelectedState("normal")

				local var_784_4 = arg_781_1:GetWordFromCfg(1108411188)
				local var_784_5 = arg_781_1:FormatText(var_784_4.content)

				arg_781_1.text_.text = var_784_5

				LuaForUtil.ClearLinePrefixSymbol(arg_781_1.text_)

				local var_784_7 = 29 <= 0 and var_784_3 or var_784_3 * (utf8.len(var_784_5) / 29)

				if (29 <= 0 and var_784_3 or var_784_3 * (utf8.len(var_784_5) / 29)) > 0 and var_784_3 < var_784_7 then
					arg_781_1.talkMaxDuration = var_784_7

					if var_784_7 + var_784_2 > arg_781_1.duration_ then
						arg_781_1.duration_ = var_784_7 + var_784_2
					end
				end

				arg_781_1.text_.text = var_784_5
				arg_781_1.typewritter.percent = 0

				arg_781_1.typewritter:SetDirty()
				arg_781_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411188", "story_v_side_new_1108411.awb") ~= 0 then
					local var_784_8 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411188", "story_v_side_new_1108411.awb") / 1000

					if var_784_8 + var_784_2 > arg_781_1.duration_ then
						arg_781_1.duration_ = var_784_8 + var_784_2
					end

					if var_784_4.prefab_name ~= "" and arg_781_1.actors_[var_784_4.prefab_name] ~= nil then
						local var_784_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_781_1.actors_[var_784_4.prefab_name].transform, "story_v_side_new_1108411", "1108411188", "story_v_side_new_1108411.awb")

						arg_781_1:RecordAudio("1108411188", var_784_9)
						arg_781_1:RecordAudio("1108411188", var_784_9)
					else
						arg_781_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411188", "story_v_side_new_1108411.awb")
					end

					arg_781_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411188", "story_v_side_new_1108411.awb")
				end

				arg_781_1:RecordContent(arg_781_1.text_.text)
			end

			local var_784_10 = math.max(var_784_3, arg_781_1.talkMaxDuration)

			if var_784_2 <= arg_781_1.time_ and arg_781_1.time_ < var_784_2 + var_784_10 then
				arg_781_1.typewritter.percent = (arg_781_1.time_ - var_784_2) / var_784_10

				arg_781_1.typewritter:SetDirty()
			end

			if arg_781_1.time_ >= var_784_2 + var_784_10 and arg_781_1.time_ < var_784_2 + var_784_10 + arg_784_0 then
				arg_781_1.typewritter.percent = 1

				arg_781_1.typewritter:SetDirty()
				arg_781_1:ShowNextGo(true)
			end
		end

		arg_781_1.nodeConfigList_ = {}

		arg_781_1:InitPlayNodeList()
	end,
	Play1108411189 = function(arg_785_0, arg_785_1)
		arg_785_1.time_ = 0
		arg_785_1.frameCnt_ = 0
		arg_785_1.state_ = "playing"
		arg_785_1.curTalkId_ = 1108411189
		arg_785_1.duration_ = 4.7

		local var_785_0 = {
			zh = 3.8,
			ja = 4.7
		}
		local var_785_1 = manager.audio:GetLocalizationFlag()

		if var_785_0[var_785_1] ~= nil then
			arg_785_1.duration_ = var_785_0[var_785_1]
		end

		SetActive(arg_785_1.tipsGo_, false)

		function arg_785_1.onSingleLineFinish_()
			arg_785_1.onSingleLineUpdate_ = nil
			arg_785_1.onSingleLineFinish_ = nil
			arg_785_1.state_ = "waiting"
		end

		function arg_785_1.playNext_(arg_787_0)
			if arg_787_0 == 1 then
				arg_785_0:Play1108411190(arg_785_1)
			end
		end

		function arg_785_1.onSingleLineUpdate_(arg_788_0)
			if 0 < arg_785_1.time_ and arg_785_1.time_ <= 0 + arg_788_0 then
				arg_785_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_788_0 = 0
			local var_788_1 = 0.5

			if 0 < arg_785_1.time_ and arg_785_1.time_ <= var_788_0 + arg_788_0 then
				arg_785_1.talkMaxDuration = 0
				arg_785_1.dialogCg_.alpha = 1

				arg_785_1.dialog_:SetActive(true)
				SetActive(arg_785_1.leftNameGo_, true)

				arg_785_1.leftNameTxt_.text = arg_785_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_785_1.leftNameTxt_.transform)

				arg_785_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_785_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_785_1:RecordName(arg_785_1.leftNameTxt_.text)
				SetActive(arg_785_1.iconTrs_.gameObject, false)
				arg_785_1.callingController_:SetSelectedState("normal")

				local var_788_2 = arg_785_1:GetWordFromCfg(1108411189)
				local var_788_3 = arg_785_1:FormatText(var_788_2.content)

				arg_785_1.text_.text = var_788_3

				LuaForUtil.ClearLinePrefixSymbol(arg_785_1.text_)

				local var_788_5 = 20 <= 0 and var_788_1 or var_788_1 * (utf8.len(var_788_3) / 20)

				if (20 <= 0 and var_788_1 or var_788_1 * (utf8.len(var_788_3) / 20)) > 0 and var_788_1 < var_788_5 then
					arg_785_1.talkMaxDuration = var_788_5

					if var_788_5 + var_788_0 > arg_785_1.duration_ then
						arg_785_1.duration_ = var_788_5 + var_788_0
					end
				end

				arg_785_1.text_.text = var_788_3
				arg_785_1.typewritter.percent = 0

				arg_785_1.typewritter:SetDirty()
				arg_785_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411189", "story_v_side_new_1108411.awb") ~= 0 then
					local var_788_6 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411189", "story_v_side_new_1108411.awb") / 1000

					if var_788_6 + var_788_0 > arg_785_1.duration_ then
						arg_785_1.duration_ = var_788_6 + var_788_0
					end

					if var_788_2.prefab_name ~= "" and arg_785_1.actors_[var_788_2.prefab_name] ~= nil then
						local var_788_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_785_1.actors_[var_788_2.prefab_name].transform, "story_v_side_new_1108411", "1108411189", "story_v_side_new_1108411.awb")

						arg_785_1:RecordAudio("1108411189", var_788_7)
						arg_785_1:RecordAudio("1108411189", var_788_7)
					else
						arg_785_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411189", "story_v_side_new_1108411.awb")
					end

					arg_785_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411189", "story_v_side_new_1108411.awb")
				end

				arg_785_1:RecordContent(arg_785_1.text_.text)
			end

			local var_788_8 = math.max(var_788_1, arg_785_1.talkMaxDuration)

			if var_788_0 <= arg_785_1.time_ and arg_785_1.time_ < var_788_0 + var_788_8 then
				arg_785_1.typewritter.percent = (arg_785_1.time_ - var_788_0) / var_788_8

				arg_785_1.typewritter:SetDirty()
			end

			if arg_785_1.time_ >= var_788_0 + var_788_8 and arg_785_1.time_ < var_788_0 + var_788_8 + arg_788_0 then
				arg_785_1.typewritter.percent = 1

				arg_785_1.typewritter:SetDirty()
				arg_785_1:ShowNextGo(true)
			end
		end

		arg_785_1.nodeConfigList_ = {}

		arg_785_1:InitPlayNodeList()
	end,
	Play1108411190 = function(arg_789_0, arg_789_1)
		arg_789_1.time_ = 0
		arg_789_1.frameCnt_ = 0
		arg_789_1.state_ = "playing"
		arg_789_1.curTalkId_ = 1108411190
		arg_789_1.duration_ = 5

		SetActive(arg_789_1.tipsGo_, false)

		function arg_789_1.onSingleLineFinish_()
			arg_789_1.onSingleLineUpdate_ = nil
			arg_789_1.onSingleLineFinish_ = nil
			arg_789_1.state_ = "waiting"
		end

		function arg_789_1.playNext_(arg_791_0)
			if arg_791_0 == 1 then
				arg_789_0:Play1108411191(arg_789_1)
			end
		end

		function arg_789_1.onSingleLineUpdate_(arg_792_0)
			if 0 < arg_789_1.time_ and arg_789_1.time_ <= 0 + arg_792_0 and not isNil(arg_789_1.actors_["10102ui_story"]) and arg_789_1.var_.characterEffect10102ui_story == nil then
				arg_789_1.var_.characterEffect10102ui_story = arg_789_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_792_0 = 0.200000002980232

			if 0 <= arg_789_1.time_ and arg_789_1.time_ < 0 + var_792_0 and not isNil(arg_789_1.actors_["10102ui_story"]) then
				if arg_789_1.var_.characterEffect10102ui_story and not isNil(arg_789_1.actors_["10102ui_story"]) then
					arg_789_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_789_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_789_1.time_ - 0) / var_792_0)
				end
			end

			if arg_789_1.time_ >= 0 + var_792_0 and arg_789_1.time_ < 0 + var_792_0 + arg_792_0 and not isNil(arg_789_1.actors_["10102ui_story"]) and arg_789_1.var_.characterEffect10102ui_story then
				arg_789_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_789_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_792_1 = 0
			local var_792_2 = 0.325

			if 0 < arg_789_1.time_ and arg_789_1.time_ <= var_792_1 + arg_792_0 then
				arg_789_1.talkMaxDuration = 0
				arg_789_1.dialogCg_.alpha = 1

				arg_789_1.dialog_:SetActive(true)
				SetActive(arg_789_1.leftNameGo_, true)

				arg_789_1.leftNameTxt_.text = arg_789_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_789_1.leftNameTxt_.transform)

				arg_789_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_789_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_789_1:RecordName(arg_789_1.leftNameTxt_.text)
				SetActive(arg_789_1.iconTrs_.gameObject, true)
				arg_789_1.iconController_:SetSelectedState("hero")

				arg_789_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_789_1.callingController_:SetSelectedState("normal")

				arg_789_1.keyicon_.color = Color.New(1, 1, 1)
				arg_789_1.icon_.color = Color.New(1, 1, 1)

				local var_792_3 = arg_789_1:FormatText(arg_789_1:GetWordFromCfg(1108411190).content)

				arg_789_1.text_.text = var_792_3

				LuaForUtil.ClearLinePrefixSymbol(arg_789_1.text_)

				local var_792_5 = 13 <= 0 and var_792_2 or var_792_2 * (utf8.len(var_792_3) / 13)

				if (13 <= 0 and var_792_2 or var_792_2 * (utf8.len(var_792_3) / 13)) > 0 and var_792_2 < var_792_5 then
					arg_789_1.talkMaxDuration = var_792_5

					if var_792_5 + var_792_1 > arg_789_1.duration_ then
						arg_789_1.duration_ = var_792_5 + var_792_1
					end
				end

				arg_789_1.text_.text = var_792_3
				arg_789_1.typewritter.percent = 0

				arg_789_1.typewritter:SetDirty()
				arg_789_1:ShowNextGo(false)
				arg_789_1:RecordContent(arg_789_1.text_.text)
			end

			local var_792_6 = math.max(var_792_2, arg_789_1.talkMaxDuration)

			if var_792_1 <= arg_789_1.time_ and arg_789_1.time_ < var_792_1 + var_792_6 then
				arg_789_1.typewritter.percent = (arg_789_1.time_ - var_792_1) / var_792_6

				arg_789_1.typewritter:SetDirty()
			end

			if arg_789_1.time_ >= var_792_1 + var_792_6 and arg_789_1.time_ < var_792_1 + var_792_6 + arg_792_0 then
				arg_789_1.typewritter.percent = 1

				arg_789_1.typewritter:SetDirty()
				arg_789_1:ShowNextGo(true)
			end
		end

		arg_789_1.nodeConfigList_ = {}

		arg_789_1:InitPlayNodeList()
	end,
	Play1108411191 = function(arg_793_0, arg_793_1)
		arg_793_1.time_ = 0
		arg_793_1.frameCnt_ = 0
		arg_793_1.state_ = "playing"
		arg_793_1.curTalkId_ = 1108411191
		arg_793_1.duration_ = 7.23

		local var_793_0 = {
			zh = 4.933,
			ja = 7.233
		}
		local var_793_1 = manager.audio:GetLocalizationFlag()

		if var_793_0[var_793_1] ~= nil then
			arg_793_1.duration_ = var_793_0[var_793_1]
		end

		SetActive(arg_793_1.tipsGo_, false)

		function arg_793_1.onSingleLineFinish_()
			arg_793_1.onSingleLineUpdate_ = nil
			arg_793_1.onSingleLineFinish_ = nil
			arg_793_1.state_ = "waiting"
		end

		function arg_793_1.playNext_(arg_795_0)
			if arg_795_0 == 1 then
				arg_793_0:Play1108411192(arg_793_1)
			end
		end

		function arg_793_1.onSingleLineUpdate_(arg_796_0)
			if 0 < arg_793_1.time_ and arg_793_1.time_ <= 0 + arg_796_0 and not isNil(arg_793_1.actors_["10102ui_story"]) and arg_793_1.var_.characterEffect10102ui_story == nil then
				arg_793_1.var_.characterEffect10102ui_story = arg_793_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_796_0 = 0.200000002980232

			if 0 <= arg_793_1.time_ and arg_793_1.time_ < 0 + var_796_0 and not isNil(arg_793_1.actors_["10102ui_story"]) then
				if arg_793_1.var_.characterEffect10102ui_story and not isNil(arg_793_1.actors_["10102ui_story"]) then
					arg_793_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_793_1.time_ >= 0 + var_796_0 and arg_793_1.time_ < 0 + var_796_0 + arg_796_0 and not isNil(arg_793_1.actors_["10102ui_story"]) and arg_793_1.var_.characterEffect10102ui_story then
				arg_793_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_793_1.time_ and arg_793_1.time_ <= 0 + arg_796_0 then
				arg_793_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action6_1")
			end

			local var_796_2 = 0
			local var_796_3 = 0.575

			if 0 < arg_793_1.time_ and arg_793_1.time_ <= var_796_2 + arg_796_0 then
				arg_793_1.talkMaxDuration = 0
				arg_793_1.dialogCg_.alpha = 1

				arg_793_1.dialog_:SetActive(true)
				SetActive(arg_793_1.leftNameGo_, true)

				arg_793_1.leftNameTxt_.text = arg_793_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_793_1.leftNameTxt_.transform)

				arg_793_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_793_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_793_1:RecordName(arg_793_1.leftNameTxt_.text)
				SetActive(arg_793_1.iconTrs_.gameObject, false)
				arg_793_1.callingController_:SetSelectedState("normal")

				local var_796_4 = arg_793_1:GetWordFromCfg(1108411191)
				local var_796_5 = arg_793_1:FormatText(var_796_4.content)

				arg_793_1.text_.text = var_796_5

				LuaForUtil.ClearLinePrefixSymbol(arg_793_1.text_)

				local var_796_7 = 23 <= 0 and var_796_3 or var_796_3 * (utf8.len(var_796_5) / 23)

				if (23 <= 0 and var_796_3 or var_796_3 * (utf8.len(var_796_5) / 23)) > 0 and var_796_3 < var_796_7 then
					arg_793_1.talkMaxDuration = var_796_7

					if var_796_7 + var_796_2 > arg_793_1.duration_ then
						arg_793_1.duration_ = var_796_7 + var_796_2
					end
				end

				arg_793_1.text_.text = var_796_5
				arg_793_1.typewritter.percent = 0

				arg_793_1.typewritter:SetDirty()
				arg_793_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411191", "story_v_side_new_1108411.awb") ~= 0 then
					local var_796_8 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411191", "story_v_side_new_1108411.awb") / 1000

					if var_796_8 + var_796_2 > arg_793_1.duration_ then
						arg_793_1.duration_ = var_796_8 + var_796_2
					end

					if var_796_4.prefab_name ~= "" and arg_793_1.actors_[var_796_4.prefab_name] ~= nil then
						local var_796_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_793_1.actors_[var_796_4.prefab_name].transform, "story_v_side_new_1108411", "1108411191", "story_v_side_new_1108411.awb")

						arg_793_1:RecordAudio("1108411191", var_796_9)
						arg_793_1:RecordAudio("1108411191", var_796_9)
					else
						arg_793_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411191", "story_v_side_new_1108411.awb")
					end

					arg_793_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411191", "story_v_side_new_1108411.awb")
				end

				arg_793_1:RecordContent(arg_793_1.text_.text)
			end

			local var_796_10 = math.max(var_796_3, arg_793_1.talkMaxDuration)

			if var_796_2 <= arg_793_1.time_ and arg_793_1.time_ < var_796_2 + var_796_10 then
				arg_793_1.typewritter.percent = (arg_793_1.time_ - var_796_2) / var_796_10

				arg_793_1.typewritter:SetDirty()
			end

			if arg_793_1.time_ >= var_796_2 + var_796_10 and arg_793_1.time_ < var_796_2 + var_796_10 + arg_796_0 then
				arg_793_1.typewritter.percent = 1

				arg_793_1.typewritter:SetDirty()
				arg_793_1:ShowNextGo(true)
			end
		end

		arg_793_1.nodeConfigList_ = {}

		arg_793_1:InitPlayNodeList()
	end,
	Play1108411192 = function(arg_797_0, arg_797_1)
		arg_797_1.time_ = 0
		arg_797_1.frameCnt_ = 0
		arg_797_1.state_ = "playing"
		arg_797_1.curTalkId_ = 1108411192
		arg_797_1.duration_ = 5

		SetActive(arg_797_1.tipsGo_, false)

		function arg_797_1.onSingleLineFinish_()
			arg_797_1.onSingleLineUpdate_ = nil
			arg_797_1.onSingleLineFinish_ = nil
			arg_797_1.state_ = "waiting"
		end

		function arg_797_1.playNext_(arg_799_0)
			if arg_799_0 == 1 then
				arg_797_0:Play1108411193(arg_797_1)
			end
		end

		function arg_797_1.onSingleLineUpdate_(arg_800_0)
			if 0 < arg_797_1.time_ and arg_797_1.time_ <= 0 + arg_800_0 and not isNil(arg_797_1.actors_["10102ui_story"]) and arg_797_1.var_.characterEffect10102ui_story == nil then
				arg_797_1.var_.characterEffect10102ui_story = arg_797_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_800_0 = 0.200000002980232

			if 0 <= arg_797_1.time_ and arg_797_1.time_ < 0 + var_800_0 and not isNil(arg_797_1.actors_["10102ui_story"]) then
				if arg_797_1.var_.characterEffect10102ui_story and not isNil(arg_797_1.actors_["10102ui_story"]) then
					arg_797_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_797_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_797_1.time_ - 0) / var_800_0)
				end
			end

			if arg_797_1.time_ >= 0 + var_800_0 and arg_797_1.time_ < 0 + var_800_0 + arg_800_0 and not isNil(arg_797_1.actors_["10102ui_story"]) and arg_797_1.var_.characterEffect10102ui_story then
				arg_797_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_797_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_800_1 = 0
			local var_800_2 = 0.4

			if 0 < arg_797_1.time_ and arg_797_1.time_ <= var_800_1 + arg_800_0 then
				arg_797_1.talkMaxDuration = 0
				arg_797_1.dialogCg_.alpha = 1

				arg_797_1.dialog_:SetActive(true)
				SetActive(arg_797_1.leftNameGo_, true)

				arg_797_1.leftNameTxt_.text = arg_797_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_797_1.leftNameTxt_.transform)

				arg_797_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_797_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_797_1:RecordName(arg_797_1.leftNameTxt_.text)
				SetActive(arg_797_1.iconTrs_.gameObject, true)
				arg_797_1.iconController_:SetSelectedState("hero")

				arg_797_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_797_1.callingController_:SetSelectedState("normal")

				arg_797_1.keyicon_.color = Color.New(1, 1, 1)
				arg_797_1.icon_.color = Color.New(1, 1, 1)

				local var_800_3 = arg_797_1:FormatText(arg_797_1:GetWordFromCfg(1108411192).content)

				arg_797_1.text_.text = var_800_3

				LuaForUtil.ClearLinePrefixSymbol(arg_797_1.text_)

				local var_800_5 = 16 <= 0 and var_800_2 or var_800_2 * (utf8.len(var_800_3) / 16)

				if (16 <= 0 and var_800_2 or var_800_2 * (utf8.len(var_800_3) / 16)) > 0 and var_800_2 < var_800_5 then
					arg_797_1.talkMaxDuration = var_800_5

					if var_800_5 + var_800_1 > arg_797_1.duration_ then
						arg_797_1.duration_ = var_800_5 + var_800_1
					end
				end

				arg_797_1.text_.text = var_800_3
				arg_797_1.typewritter.percent = 0

				arg_797_1.typewritter:SetDirty()
				arg_797_1:ShowNextGo(false)
				arg_797_1:RecordContent(arg_797_1.text_.text)
			end

			local var_800_6 = math.max(var_800_2, arg_797_1.talkMaxDuration)

			if var_800_1 <= arg_797_1.time_ and arg_797_1.time_ < var_800_1 + var_800_6 then
				arg_797_1.typewritter.percent = (arg_797_1.time_ - var_800_1) / var_800_6

				arg_797_1.typewritter:SetDirty()
			end

			if arg_797_1.time_ >= var_800_1 + var_800_6 and arg_797_1.time_ < var_800_1 + var_800_6 + arg_800_0 then
				arg_797_1.typewritter.percent = 1

				arg_797_1.typewritter:SetDirty()
				arg_797_1:ShowNextGo(true)
			end
		end

		arg_797_1.nodeConfigList_ = {}

		arg_797_1:InitPlayNodeList()
	end,
	Play1108411193 = function(arg_801_0, arg_801_1)
		arg_801_1.time_ = 0
		arg_801_1.frameCnt_ = 0
		arg_801_1.state_ = "playing"
		arg_801_1.curTalkId_ = 1108411193
		arg_801_1.duration_ = 2

		SetActive(arg_801_1.tipsGo_, false)

		function arg_801_1.onSingleLineFinish_()
			arg_801_1.onSingleLineUpdate_ = nil
			arg_801_1.onSingleLineFinish_ = nil
			arg_801_1.state_ = "waiting"
		end

		function arg_801_1.playNext_(arg_803_0)
			if arg_803_0 == 1 then
				arg_801_0:Play1108411194(arg_801_1)
			end
		end

		function arg_801_1.onSingleLineUpdate_(arg_804_0)
			if 0 < arg_801_1.time_ and arg_801_1.time_ <= 0 + arg_804_0 and not isNil(arg_801_1.actors_["10102ui_story"]) and arg_801_1.var_.characterEffect10102ui_story == nil then
				arg_801_1.var_.characterEffect10102ui_story = arg_801_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_804_0 = 0.200000002980232

			if 0 <= arg_801_1.time_ and arg_801_1.time_ < 0 + var_804_0 and not isNil(arg_801_1.actors_["10102ui_story"]) then
				if arg_801_1.var_.characterEffect10102ui_story and not isNil(arg_801_1.actors_["10102ui_story"]) then
					arg_801_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_801_1.time_ >= 0 + var_804_0 and arg_801_1.time_ < 0 + var_804_0 + arg_804_0 and not isNil(arg_801_1.actors_["10102ui_story"]) and arg_801_1.var_.characterEffect10102ui_story then
				arg_801_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_801_1.time_ and arg_801_1.time_ <= 0 + arg_804_0 then
				arg_801_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			if 0 < arg_801_1.time_ and arg_801_1.time_ <= 0 + arg_804_0 then
				arg_801_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102actionlink/10102action467")
			end

			local var_804_2 = 0
			local var_804_3 = 0.125

			if 0 < arg_801_1.time_ and arg_801_1.time_ <= var_804_2 + arg_804_0 then
				arg_801_1.talkMaxDuration = 0
				arg_801_1.dialogCg_.alpha = 1

				arg_801_1.dialog_:SetActive(true)
				SetActive(arg_801_1.leftNameGo_, true)

				arg_801_1.leftNameTxt_.text = arg_801_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_801_1.leftNameTxt_.transform)

				arg_801_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_801_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_801_1:RecordName(arg_801_1.leftNameTxt_.text)
				SetActive(arg_801_1.iconTrs_.gameObject, false)
				arg_801_1.callingController_:SetSelectedState("normal")

				local var_804_4 = arg_801_1:GetWordFromCfg(1108411193)
				local var_804_5 = arg_801_1:FormatText(var_804_4.content)

				arg_801_1.text_.text = var_804_5

				LuaForUtil.ClearLinePrefixSymbol(arg_801_1.text_)

				local var_804_7 = 5 <= 0 and var_804_3 or var_804_3 * (utf8.len(var_804_5) / 5)

				if (5 <= 0 and var_804_3 or var_804_3 * (utf8.len(var_804_5) / 5)) > 0 and var_804_3 < var_804_7 then
					arg_801_1.talkMaxDuration = var_804_7

					if var_804_7 + var_804_2 > arg_801_1.duration_ then
						arg_801_1.duration_ = var_804_7 + var_804_2
					end
				end

				arg_801_1.text_.text = var_804_5
				arg_801_1.typewritter.percent = 0

				arg_801_1.typewritter:SetDirty()
				arg_801_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411193", "story_v_side_new_1108411.awb") ~= 0 then
					local var_804_8 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411193", "story_v_side_new_1108411.awb") / 1000

					if var_804_8 + var_804_2 > arg_801_1.duration_ then
						arg_801_1.duration_ = var_804_8 + var_804_2
					end

					if var_804_4.prefab_name ~= "" and arg_801_1.actors_[var_804_4.prefab_name] ~= nil then
						local var_804_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_801_1.actors_[var_804_4.prefab_name].transform, "story_v_side_new_1108411", "1108411193", "story_v_side_new_1108411.awb")

						arg_801_1:RecordAudio("1108411193", var_804_9)
						arg_801_1:RecordAudio("1108411193", var_804_9)
					else
						arg_801_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411193", "story_v_side_new_1108411.awb")
					end

					arg_801_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411193", "story_v_side_new_1108411.awb")
				end

				arg_801_1:RecordContent(arg_801_1.text_.text)
			end

			local var_804_10 = math.max(var_804_3, arg_801_1.talkMaxDuration)

			if var_804_2 <= arg_801_1.time_ and arg_801_1.time_ < var_804_2 + var_804_10 then
				arg_801_1.typewritter.percent = (arg_801_1.time_ - var_804_2) / var_804_10

				arg_801_1.typewritter:SetDirty()
			end

			if arg_801_1.time_ >= var_804_2 + var_804_10 and arg_801_1.time_ < var_804_2 + var_804_10 + arg_804_0 then
				arg_801_1.typewritter.percent = 1

				arg_801_1.typewritter:SetDirty()
				arg_801_1:ShowNextGo(true)
			end
		end

		arg_801_1.nodeConfigList_ = {}

		arg_801_1:InitPlayNodeList()
	end,
	Play1108411194 = function(arg_805_0, arg_805_1)
		arg_805_1.time_ = 0
		arg_805_1.frameCnt_ = 0
		arg_805_1.state_ = "playing"
		arg_805_1.curTalkId_ = 1108411194
		arg_805_1.duration_ = 9.2

		local var_805_0 = {
			zh = 7.4,
			ja = 9.2
		}
		local var_805_1 = manager.audio:GetLocalizationFlag()

		if var_805_0[var_805_1] ~= nil then
			arg_805_1.duration_ = var_805_0[var_805_1]
		end

		SetActive(arg_805_1.tipsGo_, false)

		function arg_805_1.onSingleLineFinish_()
			arg_805_1.onSingleLineUpdate_ = nil
			arg_805_1.onSingleLineFinish_ = nil
			arg_805_1.state_ = "waiting"
		end

		function arg_805_1.playNext_(arg_807_0)
			if arg_807_0 == 1 then
				arg_805_0:Play1108411195(arg_805_1)
			end
		end

		function arg_805_1.onSingleLineUpdate_(arg_808_0)
			local var_808_0 = 0.95

			if 0 < arg_805_1.time_ and arg_805_1.time_ <= 0 + arg_808_0 then
				arg_805_1.talkMaxDuration = 0
				arg_805_1.dialogCg_.alpha = 1

				arg_805_1.dialog_:SetActive(true)
				SetActive(arg_805_1.leftNameGo_, true)

				arg_805_1.leftNameTxt_.text = arg_805_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_805_1.leftNameTxt_.transform)

				arg_805_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_805_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_805_1:RecordName(arg_805_1.leftNameTxt_.text)
				SetActive(arg_805_1.iconTrs_.gameObject, false)
				arg_805_1.callingController_:SetSelectedState("normal")

				local var_808_1 = arg_805_1:GetWordFromCfg(1108411194)
				local var_808_2 = arg_805_1:FormatText(var_808_1.content)

				arg_805_1.text_.text = var_808_2

				LuaForUtil.ClearLinePrefixSymbol(arg_805_1.text_)

				local var_808_4 = 38 <= 0 and var_808_0 or var_808_0 * (utf8.len(var_808_2) / 38)

				if (38 <= 0 and var_808_0 or var_808_0 * (utf8.len(var_808_2) / 38)) > 0 and var_808_0 < var_808_4 then
					arg_805_1.talkMaxDuration = var_808_4

					if var_808_4 + 0 > arg_805_1.duration_ then
						arg_805_1.duration_ = var_808_4 + 0
					end
				end

				arg_805_1.text_.text = var_808_2
				arg_805_1.typewritter.percent = 0

				arg_805_1.typewritter:SetDirty()
				arg_805_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411194", "story_v_side_new_1108411.awb") ~= 0 then
					local var_808_5 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411194", "story_v_side_new_1108411.awb") / 1000

					if var_808_5 + 0 > arg_805_1.duration_ then
						arg_805_1.duration_ = var_808_5 + 0
					end

					if var_808_1.prefab_name ~= "" and arg_805_1.actors_[var_808_1.prefab_name] ~= nil then
						local var_808_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_805_1.actors_[var_808_1.prefab_name].transform, "story_v_side_new_1108411", "1108411194", "story_v_side_new_1108411.awb")

						arg_805_1:RecordAudio("1108411194", var_808_6)
						arg_805_1:RecordAudio("1108411194", var_808_6)
					else
						arg_805_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411194", "story_v_side_new_1108411.awb")
					end

					arg_805_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411194", "story_v_side_new_1108411.awb")
				end

				arg_805_1:RecordContent(arg_805_1.text_.text)
			end

			local var_808_7 = math.max(var_808_0, arg_805_1.talkMaxDuration)

			if 0 <= arg_805_1.time_ and arg_805_1.time_ < 0 + var_808_7 then
				arg_805_1.typewritter.percent = (arg_805_1.time_ - 0) / var_808_7

				arg_805_1.typewritter:SetDirty()
			end

			if arg_805_1.time_ >= 0 + var_808_7 and arg_805_1.time_ < 0 + var_808_7 + arg_808_0 then
				arg_805_1.typewritter.percent = 1

				arg_805_1.typewritter:SetDirty()
				arg_805_1:ShowNextGo(true)
			end
		end

		arg_805_1.nodeConfigList_ = {}

		arg_805_1:InitPlayNodeList()
	end,
	Play1108411195 = function(arg_809_0, arg_809_1)
		arg_809_1.time_ = 0
		arg_809_1.frameCnt_ = 0
		arg_809_1.state_ = "playing"
		arg_809_1.curTalkId_ = 1108411195
		arg_809_1.duration_ = 5

		SetActive(arg_809_1.tipsGo_, false)

		function arg_809_1.onSingleLineFinish_()
			arg_809_1.onSingleLineUpdate_ = nil
			arg_809_1.onSingleLineFinish_ = nil
			arg_809_1.state_ = "waiting"
		end

		function arg_809_1.playNext_(arg_811_0)
			if arg_811_0 == 1 then
				arg_809_0:Play1108411196(arg_809_1)
			end
		end

		function arg_809_1.onSingleLineUpdate_(arg_812_0)
			local var_812_0 = 0.1

			if 0 < arg_809_1.time_ and arg_809_1.time_ <= 0 + arg_812_0 then
				arg_809_1.talkMaxDuration = 0
				arg_809_1.dialogCg_.alpha = 1

				arg_809_1.dialog_:SetActive(true)
				SetActive(arg_809_1.leftNameGo_, true)

				arg_809_1.leftNameTxt_.text = arg_809_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_809_1.leftNameTxt_.transform)

				arg_809_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_809_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_809_1:RecordName(arg_809_1.leftNameTxt_.text)
				SetActive(arg_809_1.iconTrs_.gameObject, true)
				arg_809_1.iconController_:SetSelectedState("hero")

				arg_809_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_809_1.callingController_:SetSelectedState("normal")

				arg_809_1.keyicon_.color = Color.New(1, 1, 1)
				arg_809_1.icon_.color = Color.New(1, 1, 1)

				local var_812_1 = arg_809_1:FormatText(arg_809_1:GetWordFromCfg(1108411195).content)

				arg_809_1.text_.text = var_812_1

				LuaForUtil.ClearLinePrefixSymbol(arg_809_1.text_)

				local var_812_3 = 4 <= 0 and var_812_0 or var_812_0 * (utf8.len(var_812_1) / 4)

				if (4 <= 0 and var_812_0 or var_812_0 * (utf8.len(var_812_1) / 4)) > 0 and var_812_0 < var_812_3 then
					arg_809_1.talkMaxDuration = var_812_3

					if var_812_3 + 0 > arg_809_1.duration_ then
						arg_809_1.duration_ = var_812_3 + 0
					end
				end

				arg_809_1.text_.text = var_812_1
				arg_809_1.typewritter.percent = 0

				arg_809_1.typewritter:SetDirty()
				arg_809_1:ShowNextGo(false)
				arg_809_1:RecordContent(arg_809_1.text_.text)
			end

			local var_812_4 = math.max(var_812_0, arg_809_1.talkMaxDuration)

			if 0 <= arg_809_1.time_ and arg_809_1.time_ < 0 + var_812_4 then
				arg_809_1.typewritter.percent = (arg_809_1.time_ - 0) / var_812_4

				arg_809_1.typewritter:SetDirty()
			end

			if arg_809_1.time_ >= 0 + var_812_4 and arg_809_1.time_ < 0 + var_812_4 + arg_812_0 then
				arg_809_1.typewritter.percent = 1

				arg_809_1.typewritter:SetDirty()
				arg_809_1:ShowNextGo(true)
			end
		end

		arg_809_1.nodeConfigList_ = {}

		arg_809_1:InitPlayNodeList()
	end,
	Play1108411196 = function(arg_813_0, arg_813_1)
		arg_813_1.time_ = 0
		arg_813_1.frameCnt_ = 0
		arg_813_1.state_ = "playing"
		arg_813_1.curTalkId_ = 1108411196
		arg_813_1.duration_ = 4.33

		local var_813_0 = {
			zh = 4.333,
			ja = 4.033
		}
		local var_813_1 = manager.audio:GetLocalizationFlag()

		if var_813_0[var_813_1] ~= nil then
			arg_813_1.duration_ = var_813_0[var_813_1]
		end

		SetActive(arg_813_1.tipsGo_, false)

		function arg_813_1.onSingleLineFinish_()
			arg_813_1.onSingleLineUpdate_ = nil
			arg_813_1.onSingleLineFinish_ = nil
			arg_813_1.state_ = "waiting"
		end

		function arg_813_1.playNext_(arg_815_0)
			if arg_815_0 == 1 then
				arg_813_0:Play1108411197(arg_813_1)
			end
		end

		function arg_813_1.onSingleLineUpdate_(arg_816_0)
			if 0 < arg_813_1.time_ and arg_813_1.time_ <= 0 + arg_816_0 and not isNil(arg_813_1.actors_["10102ui_story"]) and arg_813_1.var_.characterEffect10102ui_story == nil then
				arg_813_1.var_.characterEffect10102ui_story = arg_813_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_816_0 = 0.200000002980232

			if 0 <= arg_813_1.time_ and arg_813_1.time_ < 0 + var_816_0 and not isNil(arg_813_1.actors_["10102ui_story"]) then
				if arg_813_1.var_.characterEffect10102ui_story and not isNil(arg_813_1.actors_["10102ui_story"]) then
					arg_813_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_813_1.time_ >= 0 + var_816_0 and arg_813_1.time_ < 0 + var_816_0 + arg_816_0 and not isNil(arg_813_1.actors_["10102ui_story"]) and arg_813_1.var_.characterEffect10102ui_story then
				arg_813_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_813_1.time_ and arg_813_1.time_ <= 0 + arg_816_0 then
				arg_813_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action7_2")
			end

			if 0 < arg_813_1.time_ and arg_813_1.time_ <= 0 + arg_816_0 then
				arg_813_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_816_2 = 0
			local var_816_3 = 0.425

			if 0 < arg_813_1.time_ and arg_813_1.time_ <= var_816_2 + arg_816_0 then
				arg_813_1.talkMaxDuration = 0
				arg_813_1.dialogCg_.alpha = 1

				arg_813_1.dialog_:SetActive(true)
				SetActive(arg_813_1.leftNameGo_, true)

				arg_813_1.leftNameTxt_.text = arg_813_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_813_1.leftNameTxt_.transform)

				arg_813_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_813_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_813_1:RecordName(arg_813_1.leftNameTxt_.text)
				SetActive(arg_813_1.iconTrs_.gameObject, false)
				arg_813_1.callingController_:SetSelectedState("normal")

				local var_816_4 = arg_813_1:GetWordFromCfg(1108411196)
				local var_816_5 = arg_813_1:FormatText(var_816_4.content)

				arg_813_1.text_.text = var_816_5

				LuaForUtil.ClearLinePrefixSymbol(arg_813_1.text_)

				local var_816_7 = 17 <= 0 and var_816_3 or var_816_3 * (utf8.len(var_816_5) / 17)

				if (17 <= 0 and var_816_3 or var_816_3 * (utf8.len(var_816_5) / 17)) > 0 and var_816_3 < var_816_7 then
					arg_813_1.talkMaxDuration = var_816_7

					if var_816_7 + var_816_2 > arg_813_1.duration_ then
						arg_813_1.duration_ = var_816_7 + var_816_2
					end
				end

				arg_813_1.text_.text = var_816_5
				arg_813_1.typewritter.percent = 0

				arg_813_1.typewritter:SetDirty()
				arg_813_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411196", "story_v_side_new_1108411.awb") ~= 0 then
					local var_816_8 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411196", "story_v_side_new_1108411.awb") / 1000

					if var_816_8 + var_816_2 > arg_813_1.duration_ then
						arg_813_1.duration_ = var_816_8 + var_816_2
					end

					if var_816_4.prefab_name ~= "" and arg_813_1.actors_[var_816_4.prefab_name] ~= nil then
						local var_816_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_813_1.actors_[var_816_4.prefab_name].transform, "story_v_side_new_1108411", "1108411196", "story_v_side_new_1108411.awb")

						arg_813_1:RecordAudio("1108411196", var_816_9)
						arg_813_1:RecordAudio("1108411196", var_816_9)
					else
						arg_813_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411196", "story_v_side_new_1108411.awb")
					end

					arg_813_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411196", "story_v_side_new_1108411.awb")
				end

				arg_813_1:RecordContent(arg_813_1.text_.text)
			end

			local var_816_10 = math.max(var_816_3, arg_813_1.talkMaxDuration)

			if var_816_2 <= arg_813_1.time_ and arg_813_1.time_ < var_816_2 + var_816_10 then
				arg_813_1.typewritter.percent = (arg_813_1.time_ - var_816_2) / var_816_10

				arg_813_1.typewritter:SetDirty()
			end

			if arg_813_1.time_ >= var_816_2 + var_816_10 and arg_813_1.time_ < var_816_2 + var_816_10 + arg_816_0 then
				arg_813_1.typewritter.percent = 1

				arg_813_1.typewritter:SetDirty()
				arg_813_1:ShowNextGo(true)
			end
		end

		arg_813_1.nodeConfigList_ = {}

		arg_813_1:InitPlayNodeList()
	end,
	Play1108411197 = function(arg_817_0, arg_817_1)
		arg_817_1.time_ = 0
		arg_817_1.frameCnt_ = 0
		arg_817_1.state_ = "playing"
		arg_817_1.curTalkId_ = 1108411197
		arg_817_1.duration_ = 5

		SetActive(arg_817_1.tipsGo_, false)

		function arg_817_1.onSingleLineFinish_()
			arg_817_1.onSingleLineUpdate_ = nil
			arg_817_1.onSingleLineFinish_ = nil
			arg_817_1.state_ = "waiting"
		end

		function arg_817_1.playNext_(arg_819_0)
			if arg_819_0 == 1 then
				arg_817_0:Play1108411198(arg_817_1)
			end
		end

		function arg_817_1.onSingleLineUpdate_(arg_820_0)
			if 0 < arg_817_1.time_ and arg_817_1.time_ <= 0 + arg_820_0 and not isNil(arg_817_1.actors_["10102ui_story"]) and arg_817_1.var_.characterEffect10102ui_story == nil then
				arg_817_1.var_.characterEffect10102ui_story = arg_817_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_820_0 = 0.200000002980232

			if 0 <= arg_817_1.time_ and arg_817_1.time_ < 0 + var_820_0 and not isNil(arg_817_1.actors_["10102ui_story"]) then
				if arg_817_1.var_.characterEffect10102ui_story and not isNil(arg_817_1.actors_["10102ui_story"]) then
					arg_817_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_817_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_817_1.time_ - 0) / var_820_0)
				end
			end

			if arg_817_1.time_ >= 0 + var_820_0 and arg_817_1.time_ < 0 + var_820_0 + arg_820_0 and not isNil(arg_817_1.actors_["10102ui_story"]) and arg_817_1.var_.characterEffect10102ui_story then
				arg_817_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_817_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_820_1 = 0
			local var_820_2 = 0.575

			if 0 < arg_817_1.time_ and arg_817_1.time_ <= var_820_1 + arg_820_0 then
				arg_817_1.talkMaxDuration = 0
				arg_817_1.dialogCg_.alpha = 1

				arg_817_1.dialog_:SetActive(true)
				SetActive(arg_817_1.leftNameGo_, true)

				arg_817_1.leftNameTxt_.text = arg_817_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_817_1.leftNameTxt_.transform)

				arg_817_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_817_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_817_1:RecordName(arg_817_1.leftNameTxt_.text)
				SetActive(arg_817_1.iconTrs_.gameObject, true)
				arg_817_1.iconController_:SetSelectedState("hero")

				arg_817_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_817_1.callingController_:SetSelectedState("normal")

				arg_817_1.keyicon_.color = Color.New(1, 1, 1)
				arg_817_1.icon_.color = Color.New(1, 1, 1)

				local var_820_3 = arg_817_1:FormatText(arg_817_1:GetWordFromCfg(1108411197).content)

				arg_817_1.text_.text = var_820_3

				LuaForUtil.ClearLinePrefixSymbol(arg_817_1.text_)

				local var_820_5 = 23 <= 0 and var_820_2 or var_820_2 * (utf8.len(var_820_3) / 23)

				if (23 <= 0 and var_820_2 or var_820_2 * (utf8.len(var_820_3) / 23)) > 0 and var_820_2 < var_820_5 then
					arg_817_1.talkMaxDuration = var_820_5

					if var_820_5 + var_820_1 > arg_817_1.duration_ then
						arg_817_1.duration_ = var_820_5 + var_820_1
					end
				end

				arg_817_1.text_.text = var_820_3
				arg_817_1.typewritter.percent = 0

				arg_817_1.typewritter:SetDirty()
				arg_817_1:ShowNextGo(false)
				arg_817_1:RecordContent(arg_817_1.text_.text)
			end

			local var_820_6 = math.max(var_820_2, arg_817_1.talkMaxDuration)

			if var_820_1 <= arg_817_1.time_ and arg_817_1.time_ < var_820_1 + var_820_6 then
				arg_817_1.typewritter.percent = (arg_817_1.time_ - var_820_1) / var_820_6

				arg_817_1.typewritter:SetDirty()
			end

			if arg_817_1.time_ >= var_820_1 + var_820_6 and arg_817_1.time_ < var_820_1 + var_820_6 + arg_820_0 then
				arg_817_1.typewritter.percent = 1

				arg_817_1.typewritter:SetDirty()
				arg_817_1:ShowNextGo(true)
			end
		end

		arg_817_1.nodeConfigList_ = {}

		arg_817_1:InitPlayNodeList()
	end,
	Play1108411198 = function(arg_821_0, arg_821_1)
		arg_821_1.time_ = 0
		arg_821_1.frameCnt_ = 0
		arg_821_1.state_ = "playing"
		arg_821_1.curTalkId_ = 1108411198
		arg_821_1.duration_ = 10.67

		local var_821_0 = {
			zh = 8.2,
			ja = 10.666
		}
		local var_821_1 = manager.audio:GetLocalizationFlag()

		if var_821_0[var_821_1] ~= nil then
			arg_821_1.duration_ = var_821_0[var_821_1]
		end

		SetActive(arg_821_1.tipsGo_, false)

		function arg_821_1.onSingleLineFinish_()
			arg_821_1.onSingleLineUpdate_ = nil
			arg_821_1.onSingleLineFinish_ = nil
			arg_821_1.state_ = "waiting"
		end

		function arg_821_1.playNext_(arg_823_0)
			if arg_823_0 == 1 then
				arg_821_0:Play1108411199(arg_821_1)
			end
		end

		function arg_821_1.onSingleLineUpdate_(arg_824_0)
			if 0 < arg_821_1.time_ and arg_821_1.time_ <= 0 + arg_824_0 and not isNil(arg_821_1.actors_["10102ui_story"]) and arg_821_1.var_.characterEffect10102ui_story == nil then
				arg_821_1.var_.characterEffect10102ui_story = arg_821_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_824_0 = 0.200000002980232

			if 0 <= arg_821_1.time_ and arg_821_1.time_ < 0 + var_824_0 and not isNil(arg_821_1.actors_["10102ui_story"]) then
				if arg_821_1.var_.characterEffect10102ui_story and not isNil(arg_821_1.actors_["10102ui_story"]) then
					arg_821_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_821_1.time_ >= 0 + var_824_0 and arg_821_1.time_ < 0 + var_824_0 + arg_824_0 and not isNil(arg_821_1.actors_["10102ui_story"]) and arg_821_1.var_.characterEffect10102ui_story then
				arg_821_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_824_2 = 0
			local var_824_3 = 1.025

			if 0 < arg_821_1.time_ and arg_821_1.time_ <= var_824_2 + arg_824_0 then
				arg_821_1.talkMaxDuration = 0
				arg_821_1.dialogCg_.alpha = 1

				arg_821_1.dialog_:SetActive(true)
				SetActive(arg_821_1.leftNameGo_, true)

				arg_821_1.leftNameTxt_.text = arg_821_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_821_1.leftNameTxt_.transform)

				arg_821_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_821_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_821_1:RecordName(arg_821_1.leftNameTxt_.text)
				SetActive(arg_821_1.iconTrs_.gameObject, false)
				arg_821_1.callingController_:SetSelectedState("normal")

				local var_824_4 = arg_821_1:GetWordFromCfg(1108411198)
				local var_824_5 = arg_821_1:FormatText(var_824_4.content)

				arg_821_1.text_.text = var_824_5

				LuaForUtil.ClearLinePrefixSymbol(arg_821_1.text_)

				local var_824_7 = 41 <= 0 and var_824_3 or var_824_3 * (utf8.len(var_824_5) / 41)

				if (41 <= 0 and var_824_3 or var_824_3 * (utf8.len(var_824_5) / 41)) > 0 and var_824_3 < var_824_7 then
					arg_821_1.talkMaxDuration = var_824_7

					if var_824_7 + var_824_2 > arg_821_1.duration_ then
						arg_821_1.duration_ = var_824_7 + var_824_2
					end
				end

				arg_821_1.text_.text = var_824_5
				arg_821_1.typewritter.percent = 0

				arg_821_1.typewritter:SetDirty()
				arg_821_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411198", "story_v_side_new_1108411.awb") ~= 0 then
					local var_824_8 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411198", "story_v_side_new_1108411.awb") / 1000

					if var_824_8 + var_824_2 > arg_821_1.duration_ then
						arg_821_1.duration_ = var_824_8 + var_824_2
					end

					if var_824_4.prefab_name ~= "" and arg_821_1.actors_[var_824_4.prefab_name] ~= nil then
						local var_824_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_821_1.actors_[var_824_4.prefab_name].transform, "story_v_side_new_1108411", "1108411198", "story_v_side_new_1108411.awb")

						arg_821_1:RecordAudio("1108411198", var_824_9)
						arg_821_1:RecordAudio("1108411198", var_824_9)
					else
						arg_821_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411198", "story_v_side_new_1108411.awb")
					end

					arg_821_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411198", "story_v_side_new_1108411.awb")
				end

				arg_821_1:RecordContent(arg_821_1.text_.text)
			end

			local var_824_10 = math.max(var_824_3, arg_821_1.talkMaxDuration)

			if var_824_2 <= arg_821_1.time_ and arg_821_1.time_ < var_824_2 + var_824_10 then
				arg_821_1.typewritter.percent = (arg_821_1.time_ - var_824_2) / var_824_10

				arg_821_1.typewritter:SetDirty()
			end

			if arg_821_1.time_ >= var_824_2 + var_824_10 and arg_821_1.time_ < var_824_2 + var_824_10 + arg_824_0 then
				arg_821_1.typewritter.percent = 1

				arg_821_1.typewritter:SetDirty()
				arg_821_1:ShowNextGo(true)
			end
		end

		arg_821_1.nodeConfigList_ = {}

		arg_821_1:InitPlayNodeList()
	end,
	Play1108411199 = function(arg_825_0, arg_825_1)
		arg_825_1.time_ = 0
		arg_825_1.frameCnt_ = 0
		arg_825_1.state_ = "playing"
		arg_825_1.curTalkId_ = 1108411199
		arg_825_1.duration_ = 5

		SetActive(arg_825_1.tipsGo_, false)

		function arg_825_1.onSingleLineFinish_()
			arg_825_1.onSingleLineUpdate_ = nil
			arg_825_1.onSingleLineFinish_ = nil
			arg_825_1.state_ = "waiting"
		end

		function arg_825_1.playNext_(arg_827_0)
			if arg_827_0 == 1 then
				arg_825_0:Play1108411200(arg_825_1)
			end
		end

		function arg_825_1.onSingleLineUpdate_(arg_828_0)
			if 0 < arg_825_1.time_ and arg_825_1.time_ <= 0 + arg_828_0 then
				arg_825_1.var_.moveOldPos10102ui_story = arg_825_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_828_0 = 0.001

			if 0 <= arg_825_1.time_ and arg_825_1.time_ < 0 + var_828_0 then
				arg_825_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_825_1.var_.moveOldPos10102ui_story, Vector3.New(0, 100, 0), (arg_825_1.time_ - 0) / var_828_0)
				arg_825_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_825_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_825_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_825_1.actors_["10102ui_story"].transform.position).z)
				arg_825_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_825_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_825_1.actors_["10102ui_story"].transform.localEulerAngles = arg_825_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_825_1.time_ >= 0 + var_828_0 and arg_825_1.time_ < 0 + var_828_0 + arg_828_0 then
				arg_825_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_825_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_825_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_825_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_825_1.actors_["10102ui_story"].transform.position).z)
				arg_825_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_825_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_825_1.actors_["10102ui_story"].transform.localEulerAngles = arg_825_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_828_1 = arg_825_1.actors_["10102ui_story"]

			if 0 < arg_825_1.time_ and arg_825_1.time_ <= 0 + arg_828_0 and not isNil(var_828_1) and arg_825_1.var_.characterEffect10102ui_story == nil then
				arg_825_1.var_.characterEffect10102ui_story = var_828_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_828_2 = 0.200000002980232

			if 0 <= arg_825_1.time_ and arg_825_1.time_ < 0 + var_828_2 and not isNil(var_828_1) then
				if arg_825_1.var_.characterEffect10102ui_story and not isNil(var_828_1) then
					arg_825_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_825_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_825_1.time_ - 0) / var_828_2)
				end
			end

			if arg_825_1.time_ >= 0 + var_828_2 and arg_825_1.time_ < 0 + var_828_2 + arg_828_0 and not isNil(var_828_1) and arg_825_1.var_.characterEffect10102ui_story then
				arg_825_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_825_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_828_3 = 0
			local var_828_4 = 1.475

			if 0 < arg_825_1.time_ and arg_825_1.time_ <= var_828_3 + arg_828_0 then
				arg_825_1.talkMaxDuration = 0
				arg_825_1.dialogCg_.alpha = 1

				arg_825_1.dialog_:SetActive(true)
				SetActive(arg_825_1.leftNameGo_, false)

				arg_825_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_825_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_825_1:RecordName(arg_825_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_825_1.iconTrs_.gameObject, false)
				arg_825_1.callingController_:SetSelectedState("normal")

				local var_828_5 = arg_825_1:FormatText(arg_825_1:GetWordFromCfg(1108411199).content)

				arg_825_1.text_.text = var_828_5

				LuaForUtil.ClearLinePrefixSymbol(arg_825_1.text_)

				local var_828_7 = 59 <= 0 and var_828_4 or var_828_4 * (utf8.len(var_828_5) / 59)

				if (59 <= 0 and var_828_4 or var_828_4 * (utf8.len(var_828_5) / 59)) > 0 and var_828_4 < var_828_7 then
					arg_825_1.talkMaxDuration = var_828_7

					if var_828_7 + var_828_3 > arg_825_1.duration_ then
						arg_825_1.duration_ = var_828_7 + var_828_3
					end
				end

				arg_825_1.text_.text = var_828_5
				arg_825_1.typewritter.percent = 0

				arg_825_1.typewritter:SetDirty()
				arg_825_1:ShowNextGo(false)
				arg_825_1:RecordContent(arg_825_1.text_.text)
			end

			local var_828_8 = math.max(var_828_4, arg_825_1.talkMaxDuration)

			if var_828_3 <= arg_825_1.time_ and arg_825_1.time_ < var_828_3 + var_828_8 then
				arg_825_1.typewritter.percent = (arg_825_1.time_ - var_828_3) / var_828_8

				arg_825_1.typewritter:SetDirty()
			end

			if arg_825_1.time_ >= var_828_3 + var_828_8 and arg_825_1.time_ < var_828_3 + var_828_8 + arg_828_0 then
				arg_825_1.typewritter.percent = 1

				arg_825_1.typewritter:SetDirty()
				arg_825_1:ShowNextGo(true)
			end
		end

		arg_825_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_825_1:InitPlayNodeList()
	end,
	Play1108411200 = function(arg_829_0, arg_829_1)
		arg_829_1.time_ = 0
		arg_829_1.frameCnt_ = 0
		arg_829_1.state_ = "playing"
		arg_829_1.curTalkId_ = 1108411200
		arg_829_1.duration_ = 7.83

		local var_829_0 = {
			zh = 5.166,
			ja = 7.833
		}
		local var_829_1 = manager.audio:GetLocalizationFlag()

		if var_829_0[var_829_1] ~= nil then
			arg_829_1.duration_ = var_829_0[var_829_1]
		end

		SetActive(arg_829_1.tipsGo_, false)

		function arg_829_1.onSingleLineFinish_()
			arg_829_1.onSingleLineUpdate_ = nil
			arg_829_1.onSingleLineFinish_ = nil
			arg_829_1.state_ = "waiting"
			arg_829_1.auto_ = false
		end

		function arg_829_1.playNext_(arg_831_0)
			arg_829_1.onStoryFinished_()
		end

		function arg_829_1.onSingleLineUpdate_(arg_832_0)
			if 0 < arg_829_1.time_ and arg_829_1.time_ <= 0 + arg_832_0 then
				arg_829_1.var_.moveOldPos10102ui_story = arg_829_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_832_0 = 0.001

			if 0 <= arg_829_1.time_ and arg_829_1.time_ < 0 + var_832_0 then
				arg_829_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_829_1.var_.moveOldPos10102ui_story, Vector3.New(0, -0.985, -6.275), (arg_829_1.time_ - 0) / var_832_0)
				arg_829_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_829_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_829_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_829_1.actors_["10102ui_story"].transform.position).z)
				arg_829_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_829_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_829_1.actors_["10102ui_story"].transform.localEulerAngles = arg_829_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_829_1.time_ >= 0 + var_832_0 and arg_829_1.time_ < 0 + var_832_0 + arg_832_0 then
				arg_829_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6.275)
				arg_829_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_829_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_829_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_829_1.actors_["10102ui_story"].transform.position).z)
				arg_829_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_829_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_829_1.actors_["10102ui_story"].transform.localEulerAngles = arg_829_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_832_1 = arg_829_1.actors_["10102ui_story"]

			if 0 < arg_829_1.time_ and arg_829_1.time_ <= 0 + arg_832_0 and not isNil(var_832_1) and arg_829_1.var_.characterEffect10102ui_story == nil then
				arg_829_1.var_.characterEffect10102ui_story = var_832_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_832_2 = 0.200000002980232

			if 0 <= arg_829_1.time_ and arg_829_1.time_ < 0 + var_832_2 and not isNil(var_832_1) then
				if arg_829_1.var_.characterEffect10102ui_story and not isNil(var_832_1) then
					arg_829_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_829_1.time_ >= 0 + var_832_2 and arg_829_1.time_ < 0 + var_832_2 + arg_832_0 and not isNil(var_832_1) and arg_829_1.var_.characterEffect10102ui_story then
				arg_829_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_829_1.time_ and arg_829_1.time_ <= 0 + arg_832_0 then
				arg_829_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action6_1")
			end

			if 0 < arg_829_1.time_ and arg_829_1.time_ <= 0 + arg_832_0 then
				arg_829_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_832_4 = 0
			local var_832_5 = 0.525

			if 0 < arg_829_1.time_ and arg_829_1.time_ <= var_832_4 + arg_832_0 then
				arg_829_1.talkMaxDuration = 0
				arg_829_1.dialogCg_.alpha = 1

				arg_829_1.dialog_:SetActive(true)
				SetActive(arg_829_1.leftNameGo_, true)

				arg_829_1.leftNameTxt_.text = arg_829_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_829_1.leftNameTxt_.transform)

				arg_829_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_829_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_829_1:RecordName(arg_829_1.leftNameTxt_.text)
				SetActive(arg_829_1.iconTrs_.gameObject, false)
				arg_829_1.callingController_:SetSelectedState("normal")

				local var_832_6 = arg_829_1:GetWordFromCfg(1108411200)
				local var_832_7 = arg_829_1:FormatText(var_832_6.content)

				arg_829_1.text_.text = var_832_7

				LuaForUtil.ClearLinePrefixSymbol(arg_829_1.text_)

				local var_832_9 = 21 <= 0 and var_832_5 or var_832_5 * (utf8.len(var_832_7) / 21)

				if (21 <= 0 and var_832_5 or var_832_5 * (utf8.len(var_832_7) / 21)) > 0 and var_832_5 < var_832_9 then
					arg_829_1.talkMaxDuration = var_832_9

					if var_832_9 + var_832_4 > arg_829_1.duration_ then
						arg_829_1.duration_ = var_832_9 + var_832_4
					end
				end

				arg_829_1.text_.text = var_832_7
				arg_829_1.typewritter.percent = 0

				arg_829_1.typewritter:SetDirty()
				arg_829_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411200", "story_v_side_new_1108411.awb") ~= 0 then
					local var_832_10 = manager.audio:GetVoiceLength("story_v_side_new_1108411", "1108411200", "story_v_side_new_1108411.awb") / 1000

					if var_832_10 + var_832_4 > arg_829_1.duration_ then
						arg_829_1.duration_ = var_832_10 + var_832_4
					end

					if var_832_6.prefab_name ~= "" and arg_829_1.actors_[var_832_6.prefab_name] ~= nil then
						local var_832_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_829_1.actors_[var_832_6.prefab_name].transform, "story_v_side_new_1108411", "1108411200", "story_v_side_new_1108411.awb")

						arg_829_1:RecordAudio("1108411200", var_832_11)
						arg_829_1:RecordAudio("1108411200", var_832_11)
					else
						arg_829_1:AudioAction("play", "voice", "story_v_side_new_1108411", "1108411200", "story_v_side_new_1108411.awb")
					end

					arg_829_1:RecordHistoryTalkVoice("story_v_side_new_1108411", "1108411200", "story_v_side_new_1108411.awb")
				end

				arg_829_1:RecordContent(arg_829_1.text_.text)
			end

			local var_832_12 = math.max(var_832_5, arg_829_1.talkMaxDuration)

			if var_832_4 <= arg_829_1.time_ and arg_829_1.time_ < var_832_4 + var_832_12 then
				arg_829_1.typewritter.percent = (arg_829_1.time_ - var_832_4) / var_832_12

				arg_829_1.typewritter:SetDirty()
			end

			if arg_829_1.time_ >= var_832_4 + var_832_12 and arg_829_1.time_ < var_832_4 + var_832_12 + arg_832_0 then
				arg_829_1.typewritter.percent = 1

				arg_829_1.typewritter:SetDirty()
				arg_829_1:ShowNextGo(true)
			end
		end

		arg_829_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_829_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/ST01",
		"TextureConfig/Background/ST02",
		"TextureConfig/Background/I18f",
		"TextureConfig/Background/ST0115a",
		"TextureConfig/Background/ST0116a",
		"TextureConfig/Background/ST0115"
	},
	voices = {
		"story_v_side_new_1108411.awb"
	}
}
